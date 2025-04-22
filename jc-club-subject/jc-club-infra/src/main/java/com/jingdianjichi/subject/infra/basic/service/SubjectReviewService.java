package com.jingdianjichi.subject.infra.basic.service;

import com.jingdianjichi.subject.infra.basic.entity.SubjectInfo;
import com.jingdianjichi.subject.infra.basic.entity.SubjectReview;

import java.util.List;

public interface SubjectReviewService {
    List<SubjectReview> getReviewSubjects(SubjectInfo subjectInfo);

//    SubjectReview getReviewSubjectDetail(Long subjectId);

    void updateSubjectStatus(Long subjectId, boolean access);

    Integer getReviewCount();

    List<SubjectInfo> getMyCommit(SubjectInfo subjectInfo);
}
