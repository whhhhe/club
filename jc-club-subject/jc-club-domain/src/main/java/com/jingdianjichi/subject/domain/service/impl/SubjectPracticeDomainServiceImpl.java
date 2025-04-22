package com.jingdianjichi.subject.domain.service.impl;

import cn.hutool.core.util.RandomUtil;
import com.google.common.base.Preconditions;
import com.jingdianjichi.auth.entity.Result;
import com.jingdianjichi.subject.domain.convert.SubjectInfoConverter;
import com.jingdianjichi.subject.domain.convert.SubjectPracticeConverter;
import com.jingdianjichi.subject.domain.convert.SubjectReviewConverter;
import com.jingdianjichi.subject.domain.entity.RankBO;
import com.jingdianjichi.subject.domain.entity.SubjectInfoBO;
import com.jingdianjichi.subject.domain.entity.SubjectReviewBO;
import com.jingdianjichi.subject.domain.redis.RedisUtil;
import com.jingdianjichi.subject.domain.service.SubjectPracticeDomainService;
import com.jingdianjichi.subject.infra.basic.entity.*;
import com.jingdianjichi.subject.infra.basic.service.*;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

import static com.jingdianjichi.subject.domain.constants.Constants.*;

/**
 * @Author: zmy
 * @Date: 2025年04月17日 14:33
 */

@Service("subjectPracticeDomainService")
public class SubjectPracticeDomainServiceImpl implements SubjectPracticeDomainService {

    @Resource
    private RedisUtil redisUtil;

    @Resource
    private SubjectPracticeService subjectPracticeService;

    @Resource
    private SubjectReviewService subjectReviewService;

    @Resource
    private SubjectLabelService subjectLabelService;
    @Resource
    private SubjectMappingService subjectMappingService;

    @Override
    public List<SubjectReviewBO> start(List<Long> labelIds, List<Integer> subjectDifficulties) {
        Set<Long> allSubjectIds = new HashSet<>();
        for(Long labelId : labelIds){
            String tagKey = redisUtil.buildKey(TAG_SET_PREFIX, String.valueOf(labelId));
            Set<String> tagSet = redisUtil.sMembers(tagKey).stream().map(Object::toString).collect(Collectors.toSet());
            allSubjectIds.addAll(tagSet.stream().map(Long::valueOf).collect(Collectors.toSet()));
        }

        Set<Long> difficultyFiltered = new HashSet<>();
        for (Integer diff : subjectDifficulties) {
            String diffKey = redisUtil.buildKey(DIFF_SET_PREFIX, String.valueOf(diff));
            Set<String> diffSet = redisUtil.sMembers(diffKey).stream().map(Object::toString).collect(Collectors.toSet());
            difficultyFiltered.addAll(
                    diffSet.stream().map(Long::valueOf).collect(Collectors.toSet())
            );
        }
        allSubjectIds.retainAll(difficultyFiltered);
        if (allSubjectIds.isEmpty()) {
            return Collections.emptyList();
        }

        // 从交集中随机选出固定数量（例如 10 道）
        List<Long> idList = new ArrayList<>(allSubjectIds);
        Collections.shuffle(idList);
        List<Long> finalIdList = idList.stream().limit(SUBJECT_COUNT).collect(Collectors.toList());
        List<SubjectReview> res = subjectPracticeService.start(finalIdList);

        List<SubjectReviewBO> subjectReviewBOS = SubjectReviewConverter.INSTANCE.converterEntitiesToBOS(res);
        return  subjectReviewBOS;
    }

    @Override
    public List<RankBO> getPracticeRankList() {
        List<Rank> rankList =  subjectPracticeService.getPracticeRankList();
        List<RankBO> rankBOS = SubjectPracticeConverter.INSTANCE.converterRanksToBOs(rankList);
        return rankBOS;
    }

    @Override
    public List<SubjectInfoBO> getWrongList(Integer difficulty) {
        List<SubjectInfo> reviewList =  subjectPracticeService.getWrongList(difficulty);
        List<SubjectInfoBO> subjectInfoBOS = SubjectInfoConverter.INSTANCE.convertListInfoToBO(reviewList);
        for(SubjectInfoBO subjectInfoBO : subjectInfoBOS){
            SubjectMapping subjectMapping = new SubjectMapping();
            subjectMapping.setSubjectId(subjectInfoBO.getId());
            subjectInfoBO.setLabelIds(subjectMappingService.queryLabelId(subjectMapping).
                    stream().map(SubjectMapping::getLabelId).collect(Collectors.toList()).stream().
                    map(Math::toIntExact).collect(Collectors.toList()));

        }
        for(SubjectInfoBO subjectInfoBO : subjectInfoBOS){
            List<String> labelNameList = subjectLabelService.batchQueryById(subjectInfoBO.getLabelIds().stream()
                            .map(Long::valueOf).collect(Collectors.toList())).
                    stream().map(SubjectLabel::getLabelName).collect(Collectors.toList());
            subjectInfoBO.setLabelName(labelNameList);
        }
        return subjectInfoBOS;
    }

    @Override
    public SubjectReviewBO getWrongDetail(Long subjectId) {
        SubjectInfo subjectInfo = new SubjectInfo();
        subjectInfo.setId(subjectId);
        return SubjectReviewConverter.INSTANCE.converterReviewToBO(subjectReviewService.getReviewSubjects(subjectInfo).get(0));
    }
}
