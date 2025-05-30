package com.jingdianjichi.subject.domain.service;

import com.jingdianjichi.subject.common.entity.PageResult;
import com.jingdianjichi.subject.domain.entity.SubjectInfoBO;
import com.jingdianjichi.subject.domain.entity.SubjectLabelBO;
import com.jingdianjichi.subject.domain.entity.SubjectReviewBO;
import com.jingdianjichi.subject.infra.basic.entity.SubjectInfoEs;
import com.jingdianjichi.subject.infra.basic.entity.SubjectReview;

import java.util.List;

/**
 * 题目领域服务
 * 
 * @author: ChickenWing
 * @date: 2023/10/3
 */
public interface SubjectInfoDomainService {

    /**
     * 新增题目
     */
    void add(SubjectInfoBO subjectInfoBO);

    /**
     * 分页查询
     */
    PageResult<SubjectInfoBO> getSubjectPage(SubjectInfoBO subjectInfoBO);

    /**
     * 查询题目信息
     */
    SubjectInfoBO querySubjectInfo(SubjectInfoBO subjectInfoBO);

    /**
     * 全文检索
     */
    PageResult<SubjectInfoEs> getSubjectPageBySearch(SubjectInfoBO subjectInfoBO);

    List<SubjectInfoBO> getContributeList();


    List<SubjectReviewBO> queryAllSubjects(Integer subjectType, Integer pageNo, Integer pageSize);

    Integer count(Integer subjectType);


    void setDiffAndTag();
}

