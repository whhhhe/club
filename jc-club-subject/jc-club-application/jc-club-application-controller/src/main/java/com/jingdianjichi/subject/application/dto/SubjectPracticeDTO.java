package com.jingdianjichi.subject.application.dto;

import lombok.Data;

import java.util.List;

/**
 * @Author: zmy
 * @Date: 2025年04月17日 13:57
 */
@Data
public class SubjectPracticeDTO {
    /**
     * 标签列表
     * */
    private List<Long> labelIds;
    /**
     * 难度列表
     * */
    private List<Integer> subjectDifficulties;
}
