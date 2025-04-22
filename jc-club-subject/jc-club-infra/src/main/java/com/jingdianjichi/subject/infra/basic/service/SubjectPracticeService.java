package com.jingdianjichi.subject.infra.basic.service;

import com.jingdianjichi.subject.infra.basic.entity.Rank;
import com.jingdianjichi.subject.infra.basic.entity.SubjectInfo;
import com.jingdianjichi.subject.infra.basic.entity.SubjectReview;

import java.util.List;

public interface SubjectPracticeService {
    List<SubjectReview> start(List<Long> subjectIds);

    List<Rank> getPracticeRankList();

    List<SubjectInfo> getWrongList(Integer difficulty);
}
