package com.jingdianjichi.subject.application.dto;

import lombok.Data;

/**
 * @Author: zmy
 * @Date: 2025年04月17日 21:20
 */
@Data
public class AnswerResult {
    /**
     * 题目 ID
     */
    private Long subjectId;

    /**
     * 题型（1：单选，2：多选，3：判断）
     */
    private Integer subjectType;

    /**
     * 是否答对（1：正确，0：错误）
     */
    private Integer isCorrect;
}