package com.jingdianjichi.subject.domain.entity;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class SubjectReviewBO {
    private Long subjectId;

    private String subjectName;

    private Integer subjectType;

    private String subjectAnswer; // 简答题直接使用该字段

    private Integer correct;    //判断

    private List<SubjectAnswerBO> optionList;// 选择/判断题使用

    private Integer subjectDifficult; // 题目难度（1-5）

    private List<Long> categoryIds;

    private List<Long> labelIds;

    private String subjectParse;

    private String createdBy;         // 提交者（用于展示谁出的题）

    private Date createdTime;

    private Integer isDeleted;

    private List<String> labelNames;
}
