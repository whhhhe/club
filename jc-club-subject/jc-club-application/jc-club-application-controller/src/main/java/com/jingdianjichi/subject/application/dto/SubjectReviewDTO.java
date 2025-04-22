package com.jingdianjichi.subject.application.dto;

import com.jingdianjichi.subject.common.entity.PageResult;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class SubjectReviewDTO {
    private Long subjectId;

    private String subjectName;

    private Integer subjectType;

    private String subjectAnswer;

    private List<SubjectAnswerDTO> optionList;

    private List<Long> categoryIds;

    private List<Long> labelIds;

    private Integer correct;

    private Integer subjectDifficult; // 题目难度（1-5）

    private String subjectParse;      // 解析字段

    private String createdBy;         // 提交者（用于展示谁出的题）

    private Date createdTime;         // 提交时间（便于排序）

    private Integer isDeleted;

    private List<String> labelNames;

}
