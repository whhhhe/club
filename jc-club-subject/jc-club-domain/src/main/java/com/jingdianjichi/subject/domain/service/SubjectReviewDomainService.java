package com.jingdianjichi.subject.domain.service;

import com.jingdianjichi.subject.domain.entity.SubjectInfoBO;
import com.jingdianjichi.subject.domain.entity.SubjectReviewBO;

import java.util.List;

public interface SubjectReviewDomainService {
    List<SubjectReviewBO> getReviewSubjects(SubjectInfoBO subjectInfoBO);

    List<SubjectInfoBO> getMyCommit(SubjectInfoBO subjectInfoBO);

    SubjectReviewBO getReviewSubjectDetail(Long subjectId);

    void approve(Long subjectId);

    void reject(Long subjectId);

    Integer getReviewCount();

}
