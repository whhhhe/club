package com.jingdianjichi.subject.infra.basic.entity;

import com.jingdianjichi.subject.common.entity.PageResult;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class SubjectReview extends PageResult {

    private Long subjectId;

    private String subjectName;

    private Integer subjectType;

    private String subjectAnswer; // 简答题用

    private Integer subjectDifficult; // 题目难度（1-5）

    private List<SubjectAnswer> optionList; // 单选、多选共用

    private Integer correct;    //判断

    private List<Long> categoryIds;

    private List<Long> labelIds;

    private Integer isDeleted; // 是否删除：0正常，1已删除，2待审核

    private String subjectParse;

    private String createdBy;         // 提交者（用于展示谁出的题）

    private Date createdTime;

}
