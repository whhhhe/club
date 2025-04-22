package com.jingdianjichi.subject.domain.service;

import com.jingdianjichi.subject.domain.entity.RankBO;
import com.jingdianjichi.subject.domain.entity.SubjectInfoBO;
import com.jingdianjichi.subject.domain.entity.SubjectReviewBO;

import java.util.List;

/**
 * @Author: zmy
 * @Date: 2025年04月17日 14:33
 */
public interface SubjectPracticeDomainService {
    List<SubjectReviewBO> start(List<Long> labelIds, List<Integer> subjectDifficulties);

    List<RankBO> getPracticeRankList();

    List<SubjectInfoBO> getWrongList(Integer difficulty);

    SubjectReviewBO getWrongDetail(Long subjectId);
}
