package com.jingdianjichi.subject.domain.service.impl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jingdianjichi.subject.common.entity.PageResult;
import com.jingdianjichi.subject.common.enums.IsDeletedFlagEnum;
import com.jingdianjichi.subject.common.util.IdWorkerUtil;
import com.jingdianjichi.subject.common.util.LoginUtil;
import com.jingdianjichi.subject.domain.convert.SubjectCategoryConverter;
import com.jingdianjichi.subject.domain.convert.SubjectInfoConverter;
import com.jingdianjichi.subject.domain.entity.SubjectCategoryBO;
import com.jingdianjichi.subject.domain.entity.SubjectInfoBO;
import com.jingdianjichi.subject.domain.entity.SubjectOptionBO;
import com.jingdianjichi.subject.domain.entity.SubjectReviewBO;
import com.jingdianjichi.subject.domain.handler.subject.SubjectTypeHandler;
import com.jingdianjichi.subject.domain.handler.subject.SubjectTypeHandlerFactory;
import com.jingdianjichi.subject.domain.redis.RedisUtil;
import com.jingdianjichi.subject.domain.service.SubjectCategoryDomainService;
import com.jingdianjichi.subject.domain.service.SubjectInfoDomainService;
import com.jingdianjichi.subject.domain.service.SubjectLikedDomainService;
import com.jingdianjichi.subject.infra.basic.entity.*;
import com.jingdianjichi.subject.infra.basic.service.*;
import com.jingdianjichi.subject.infra.entity.UserInfo;
import com.jingdianjichi.subject.infra.rpc.UserRpc;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.ZSetOperations;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

import static com.jingdianjichi.subject.domain.constants.Constants.*;

@Service
@Slf4j
public class SubjectInfoDomainServiceImpl implements SubjectInfoDomainService {

    @Resource
    private SubjectInfoService subjectInfoService;

    @Resource
    private SubjectMappingService subjectMappingService;

    @Resource
    private SubjectLabelService subjectLabelService;

    @Resource
    private SubjectTypeHandlerFactory subjectTypeHandlerFactory;

    @Resource
    private SubjectEsService subjectEsService;

    @Resource
    private SubjectLikedDomainService subjectLikedDomainService;

    @Resource
    private UserRpc userRpc;

    @Resource
    private RedisUtil redisUtil;

    private static final String RANK_KEY = "subject_rank";

    private static final String ROLE_ID_PREFIX = "role.id";

    private static final Long NORMAL = 2L;
    private static final Long ADMIN = 1L;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void add(SubjectInfoBO subjectInfoBO) {
        if (log.isInfoEnabled()) {
            log.info("SubjectInfoDomainServiceImpl.add.bo:{}", JSON.toJSONString(subjectInfoBO));
        }
        SubjectInfo subjectInfo = SubjectInfoConverter.INSTANCE.convertBoToInfo(subjectInfoBO);
        String userId = LoginUtil.getLoginId();
        log.info("userId{}************************", userId);
        Long roleId = userRpc.getRoleIdByUserId(userId);
        int isDeleted = Objects.equals(roleId, ADMIN) ? IsDeletedFlagEnum.UN_DELETED.getCode() : IsDeletedFlagEnum.UNDER_REVIEW.getCode();
        String key = redisUtil.buildKey(ROLE_ID_PREFIX, userId);
        redisUtil.set(key, String.valueOf(roleId));
        //如果是普通用户

        subjectInfo.setIsDeleted(isDeleted);


        subjectInfoService.insert(subjectInfo);
        SubjectTypeHandler handler = subjectTypeHandlerFactory.getHandler(subjectInfo.getSubjectType());
        subjectInfoBO.setId(subjectInfo.getId());
        handler.add(subjectInfoBO);
        List<Integer> categoryIds = subjectInfoBO.getCategoryIds();
        List<Integer> labelIds = subjectInfoBO.getLabelIds();
        List<SubjectMapping> mappingList = new LinkedList<>();
        categoryIds.forEach(categoryId -> {
            labelIds.forEach(labelId -> {
                SubjectMapping subjectMapping = new SubjectMapping();
                subjectMapping.setSubjectId(subjectInfo.getId());
                subjectMapping.setCategoryId(Long.valueOf(categoryId));
                subjectMapping.setLabelId(Long.valueOf(labelId));
                if(Objects.equals(roleId, NORMAL))
                    subjectMapping.setIsDeleted(IsDeletedFlagEnum.UNDER_REVIEW.getCode());
                else
                    subjectMapping.setIsDeleted(IsDeletedFlagEnum.UN_DELETED.getCode());
                mappingList.add(subjectMapping);
            });
        });
        subjectMappingService.batchInsert(mappingList);
        //如果是管理
        if(Objects.equals(roleId, ADMIN)){
            //同步到es
            putSubjectInEs(subjectInfoBO);
            //redis放入zadd计入排行榜
            redisUtil.addScore(RANK_KEY, LoginUtil.getLoginId(), 1);
            //写入redis set
            if(subjectInfo.getSubjectType() == 4) return;
            for(Integer labelId: labelIds){
                String tagKey = redisUtil.buildKey(TAG_SET_PREFIX, String.valueOf(labelId));
                String diffKey = redisUtil.buildKey(DIFF_SET_PREFIX, String.valueOf(subjectInfo.getSubjectDifficult()));
                redisUtil.sadd(tagKey, subjectInfo.getId());
                redisUtil.sadd(diffKey, subjectInfo.getId());
            }

        }
    }

    @Override
    public PageResult<SubjectInfoBO> getSubjectPage(SubjectInfoBO subjectInfoBO) {
        PageResult<SubjectInfoBO> pageResult = new PageResult<>();
        pageResult.setPageNo(subjectInfoBO.getPageNo());
        pageResult.setPageSize(subjectInfoBO.getPageSize());
        int start = (subjectInfoBO.getPageNo() - 1) * subjectInfoBO.getPageSize();
        SubjectInfo subjectInfo = SubjectInfoConverter.INSTANCE.convertBoToInfo(subjectInfoBO);
        int count = subjectInfoService.countByCondition(subjectInfo, subjectInfoBO.getCategoryId()
                , subjectInfoBO.getLabelId());
        if (count == 0) {
            return pageResult;
        }
        List<SubjectInfo> subjectInfoList = subjectInfoService.queryPage(subjectInfo, subjectInfoBO.getCategoryId()
                , subjectInfoBO.getLabelId(), start, subjectInfoBO.getPageSize());
        List<SubjectInfoBO> subjectInfoBOS = SubjectInfoConverter.INSTANCE.convertListInfoToBO(subjectInfoList);
        subjectInfoBOS.forEach(info -> {
            SubjectMapping subjectMapping = new SubjectMapping();
            subjectMapping.setSubjectId(info.getId());
            subjectMapping.setIsDeleted(IsDeletedFlagEnum.UN_DELETED.getCode());
            List<SubjectMapping> mappingList = subjectMappingService.queryLabelId(subjectMapping);
            List<Long> labelIds = mappingList.stream().map(SubjectMapping::getLabelId).collect(Collectors.toList());
            List<SubjectLabel> labelList = subjectLabelService.batchQueryById(labelIds);
            List<String> labelNames = labelList.stream().map(SubjectLabel::getLabelName).collect(Collectors.toList());
            info.setLabelName(labelNames);
        });
        pageResult.setRecords(subjectInfoBOS);
        pageResult.setTotal(count);
        return pageResult;
    }

    @Override
    public SubjectInfoBO querySubjectInfo(SubjectInfoBO subjectInfoBO) {
        SubjectInfo subjectInfo = subjectInfoService.queryById(subjectInfoBO.getId());
        SubjectTypeHandler handler = subjectTypeHandlerFactory.getHandler(subjectInfo.getSubjectType());
        SubjectOptionBO optionBO = handler.query(subjectInfo.getId().intValue());
        SubjectInfoBO bo = SubjectInfoConverter.INSTANCE.convertOptionAndInfoToBo(optionBO, subjectInfo);
        SubjectMapping subjectMapping = new SubjectMapping();
        subjectMapping.setSubjectId(subjectInfo.getId());
        subjectMapping.setIsDeleted(IsDeletedFlagEnum.UN_DELETED.getCode());
        List<SubjectMapping> mappingList = subjectMappingService.queryLabelId(subjectMapping);
        List<Long> labelIdList = mappingList.stream().map(SubjectMapping::getLabelId).collect(Collectors.toList());
        List<SubjectLabel> labelList = subjectLabelService.batchQueryById(labelIdList);
        List<String> labelNameList = labelList.stream().map(SubjectLabel::getLabelName).collect(Collectors.toList());
        bo.setLabelName(labelNameList);
        bo.setLiked(subjectLikedDomainService.isLiked(subjectInfoBO.getId(), LoginUtil.getLoginId()));
        bo.setLikedCount(subjectLikedDomainService.getLikedCount(subjectInfoBO.getId()));
        assembleSubjectCursor(subjectInfoBO, bo);
        return bo;
    }

    private void assembleSubjectCursor(SubjectInfoBO subjectInfoBO, SubjectInfoBO bo) {
        Long categoryId = subjectInfoBO.getCategoryId();
        Long labelId = subjectInfoBO.getLabelId();
        Long subjectId = subjectInfoBO.getId();
        if (Objects.isNull(categoryId) || Objects.isNull(labelId)) {
            return;
        }
        Long nextSubjectId = subjectInfoService.querySubjectIdCursor(subjectId, categoryId, labelId, 1);
        bo.setNextSubjectId(nextSubjectId);
        Long lastSubjectId = subjectInfoService.querySubjectIdCursor(subjectId, categoryId, labelId, 0);
        bo.setLastSubjectId(lastSubjectId);
    }

    @Override
    public PageResult<SubjectInfoEs> getSubjectPageBySearch(SubjectInfoBO subjectInfoBO) {
        SubjectInfoEs subjectInfoEs = new SubjectInfoEs();
        subjectInfoEs.setPageNo(subjectInfoBO.getPageNo());
        subjectInfoEs.setPageSize(subjectInfoBO.getPageSize());
        subjectInfoEs.setKeyWord(subjectInfoBO.getKeyWord());
        return subjectEsService.querySubjectList(subjectInfoEs);
    }

    @Override
    public List<SubjectInfoBO> getContributeList() {
        Set<ZSetOperations.TypedTuple<String>> typedTuples = redisUtil.rankWithScore(RANK_KEY, 0, 5);
        if (log.isInfoEnabled()) {
            log.info("getContributeList.typedTuples:{}", JSON.toJSONString(typedTuples));
        }
        if (CollectionUtils.isEmpty(typedTuples)) {
            return Collections.emptyList();
        }
        List<SubjectInfoBO> boList = new LinkedList<>();
        typedTuples.forEach((rank -> {
            SubjectInfoBO subjectInfoBO = new SubjectInfoBO();
            subjectInfoBO.setSubjectCount(rank.getScore().intValue());
            UserInfo userInfo = userRpc.getUserInfo(rank.getValue());
            subjectInfoBO.setCreateUser(userInfo.getNickName());
            subjectInfoBO.setCreateUserAvatar(userInfo.getAvatar());
            boList.add(subjectInfoBO);
        }));
        return boList;
    }

    @Override
    public List<SubjectReviewBO> queryAllSubjects(Integer subjectType, Integer pageNo, Integer pageSize) {
        SubjectTypeHandler handler = subjectTypeHandlerFactory.getHandler(subjectType);
        List<SubjectReviewBO> subjectReviewBOS = handler.queryAllSubjects(pageNo, pageSize);
        log.info("subjectReviewBOS:{}", subjectReviewBOS);
        if(subjectReviewBOS == null) return null;
        List<Long> list = subjectReviewBOS.stream().map(SubjectReviewBO::getSubjectId).collect(Collectors.toList());
        List<SubjectInfo> subjectInfos = subjectInfoService.queryByIdList(list);
        for(int i = 0; i < subjectReviewBOS.size(); i++){
            subjectReviewBOS.get(i).setSubjectName(subjectInfos.get(i).getSubjectName());
            subjectReviewBOS.get(i).setSubjectDifficult(subjectInfos.get(i).getSubjectDifficult());
            subjectReviewBOS.get(i).setSubjectParse(subjectInfos.get(i).getSubjectParse());
        }
        return subjectReviewBOS;
    }

    @Override
    public Integer count(Integer subjectType) {
        SubjectTypeHandler handler = subjectTypeHandlerFactory.getHandler(subjectType);
        Long count = handler.count();
        return Math.toIntExact(count);
    }

    @Override
    public void setDiffAndTag() {
        System.out.println("000000000000000000");
        List<SubjectJobLabel> subjectJobEntities = subjectInfoService.setTag();
        List<SubjectJobDifficult> subjectJobDifficulties = subjectInfoService.setDiff();
        System.out.println("111111111111111111");
        log.info("labelIdsAndSubjectIds{}", subjectJobEntities);
        log.info("subjectDifficultiesAndSubjectIds{}", subjectJobDifficulties);
        for(SubjectJobLabel subjectJobEntity : subjectJobEntities){
            subjectJobEntity.convertStrToList();
            String tagKey = redisUtil.buildKey(TAG_SET_PREFIX, String.valueOf(subjectJobEntity.getLabelId()));
            redisUtil.saddAll(tagKey, subjectJobEntity.getSubjectIdSet());
        }
        for(SubjectJobDifficult subjectJobDifficult : subjectJobDifficulties){
            subjectJobDifficult.convertStrToList();
            String diffKey = redisUtil.buildKey(DIFF_SET_PREFIX, String.valueOf(subjectJobDifficult.getSubjectDifficult()));
            redisUtil.saddAll(diffKey, subjectJobDifficult.getSubjectIdSet());
        }
    }

    private void putSubjectInEs(SubjectInfoBO subjectInfoBO){
        SubjectInfoEs subjectInfoEs = new SubjectInfoEs();
        SubjectInfo subjectInfo = SubjectInfoConverter.INSTANCE.convertBoToInfo(subjectInfoBO);

        subjectInfoEs.setDocId(new IdWorkerUtil(1, 1, 1).nextId());
        subjectInfoEs.setSubjectId(subjectInfo.getId());
        subjectInfoEs.setSubjectAnswer(subjectInfoBO.getSubjectAnswer());
        subjectInfoEs.setCreateTime(new Date().getTime());
        subjectInfoEs.setCreateUser("ADMIN");
        subjectInfoEs.setSubjectName(subjectInfo.getSubjectName());
        subjectInfoEs.setSubjectType(subjectInfo.getSubjectType());
        subjectEsService.insert(subjectInfoEs);
    }
}
