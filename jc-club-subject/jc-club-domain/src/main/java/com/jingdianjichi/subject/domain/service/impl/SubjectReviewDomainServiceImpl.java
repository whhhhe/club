package com.jingdianjichi.subject.domain.service.impl;

import com.jingdianjichi.subject.common.enums.IsDeletedFlagEnum;
import com.jingdianjichi.subject.common.util.IdWorkerUtil;
import com.jingdianjichi.subject.common.util.LoginUtil;
import com.jingdianjichi.subject.domain.convert.SubjectInfoConverter;
import com.jingdianjichi.subject.domain.convert.SubjectReviewConverter;
import com.jingdianjichi.subject.domain.entity.SubjectInfoBO;
import com.jingdianjichi.subject.domain.entity.SubjectReviewBO;
import com.jingdianjichi.subject.domain.redis.RedisUtil;
import com.jingdianjichi.subject.domain.service.SubjectInfoDomainService;
import com.jingdianjichi.subject.domain.service.SubjectReviewDomainService;
import com.jingdianjichi.subject.infra.basic.entity.*;
import com.jingdianjichi.subject.infra.basic.service.*;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import static com.jingdianjichi.subject.domain.constants.Constants.DIFF_SET_PREFIX;
import static com.jingdianjichi.subject.domain.constants.Constants.TAG_SET_PREFIX;

/**
 * @Author: zmy
 * @Date: 2025年04月15日 20:19
 */
@Service("subjectReviewDomainService")
public class SubjectReviewDomainServiceImpl implements SubjectReviewDomainService {

    @Resource
    private SubjectReviewService subjectReviewService;

    @Resource
    private SubjectInfoService subjectInfoService;

    @Resource
    private SubjectEsService subjectEsService;

    @Resource
    private SubjectBriefService subjectBriefService;

    @Resource
    private SubjectMappingService subjectMappingService;

    @Resource
    private RedisUtil redisUtil;

    private static final String RANK_KEY = "subject_rank";

    private static final Integer BRIEF = 4;

    public List<SubjectReviewBO> getReviewSubjects(SubjectInfoBO subjectInfoBO) {
        SubjectInfo subjectInfo = new SubjectInfo();
        subjectInfo.setIsDeleted(IsDeletedFlagEnum.UNDER_REVIEW.getCode());
        List<SubjectReview> subjectReviews =  subjectReviewService.getReviewSubjects(subjectInfo);
        List<SubjectReviewBO> bos = SubjectReviewConverter.INSTANCE.converterEntitiesToBOS(subjectReviews);
        return bos;
    }

    @Override
    public List<SubjectInfoBO> getMyCommit(SubjectInfoBO subjectInfoBO) {
        SubjectInfo subjectInfo = new SubjectInfo();
        subjectInfo.setCreatedBy(LoginUtil.getLoginId());
        List<SubjectInfo> subjectInfos =  subjectReviewService.getMyCommit(subjectInfo);
        List<SubjectInfoBO> bos = SubjectInfoConverter.INSTANCE.convertListInfoToBO(subjectInfos);
        System.out.println("subjectInfoBos:" + bos);
        return bos;
    }

    @Override
    public SubjectReviewBO getReviewSubjectDetail(Long subjectId) {
        SubjectInfo subjectInfo = new SubjectInfo();
        subjectInfo.setId(subjectId);
        return SubjectReviewConverter.INSTANCE.converterReviewToBO(subjectReviewService.getReviewSubjects(subjectInfo).get(0));

    }

    @Override
    public void approve(Long subjectId) {
        SubjectInfo esInfo = subjectInfoService.queryById(subjectId);

        SubjectInfoBO subjectInfoBO = SubjectInfoConverter.INSTANCE.convertInfoToBo(esInfo);
//        System.out.println("**************" + subjectInfoBO + "*****************");
        if(Objects.equals(esInfo.getSubjectType(), BRIEF)){
            SubjectBrief subjectBrief = new SubjectBrief();
            subjectBrief.setSubjectId(Math.toIntExact(subjectId));
            SubjectBrief res = subjectBriefService.queryByCondition(subjectBrief);
            subjectInfoBO.setSubjectAnswer(res.getSubjectAnswer());
        }
        //同步到es
        putSubjectInEs(subjectInfoBO);
        //设置贡献值
        redisUtil.addScore(RANK_KEY, subjectInfoBO.getCreatedBy(), 1);
        subjectReviewService.updateSubjectStatus(subjectId, true);
        if(subjectInfoBO.getSubjectType() == 4) return;
        SubjectMapping subjectMapping = new SubjectMapping();
        subjectMapping.setSubjectId(subjectId);
        List<Long> labelIds = subjectMappingService.queryLabelId(subjectMapping).stream().map(SubjectMapping::getLabelId).collect(Collectors.toList());

        for(Long labelId: labelIds){
            String tagKey = redisUtil.buildKey(TAG_SET_PREFIX, String.valueOf(labelId));
            String diffKey = redisUtil.buildKey(DIFF_SET_PREFIX, String.valueOf(esInfo.getSubjectDifficult()));
            redisUtil.sadd(tagKey, subjectId);
            redisUtil.sadd(diffKey, subjectId);
        }

    }

    @Override
    public void reject(Long subjectId) {
        subjectReviewService.updateSubjectStatus(subjectId, false);
    }

    @Override
    public Integer getReviewCount() {
        return subjectReviewService.getReviewCount();
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
