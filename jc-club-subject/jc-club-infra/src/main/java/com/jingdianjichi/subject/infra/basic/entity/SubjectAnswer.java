package com.jingdianjichi.subject.infra.basic.entity;

import lombok.Data;

import java.io.Serializable;

@Data
public class SubjectAnswer implements Serializable {

    /**
     * 答案选项标识
     */
    private Integer optionType;

    /**
     * 答案
     */
    private String optionContent;

    /**
     * 是否正确
     */
    private Integer isCorrect;

    public SubjectAnswer(Integer optionType, Integer isCorrect, String optionContent) {
        this.optionType = optionType;
        this.isCorrect = isCorrect;
        this.optionContent = optionContent;
    }
}