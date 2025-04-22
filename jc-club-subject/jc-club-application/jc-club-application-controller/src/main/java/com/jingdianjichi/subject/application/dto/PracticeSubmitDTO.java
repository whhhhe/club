package com.jingdianjichi.subject.application.dto;

import lombok.Data;

import java.util.List;

@Data
public class PracticeSubmitDTO {

    /**
     * 题目总数
     */
    private Integer questionCount;

    /**
     * 答对题数
     */
    private Integer correctCount;

    /**
     * 练习用时（单位：秒）
     */
    private Integer useTime;

    /**
     * 每道题的答题情况（只关心是否正确）
     */
    private List<AnswerResult> answers;


}
