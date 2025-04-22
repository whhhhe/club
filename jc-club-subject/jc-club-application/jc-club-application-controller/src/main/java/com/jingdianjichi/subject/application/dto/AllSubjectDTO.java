package com.jingdianjichi.subject.application.dto;

import com.jingdianjichi.subject.common.entity.PageResult;
import lombok.Data;

import java.util.List;

/**
 * @Author: zmy
 * @Date: 2025年04月20日 22:40
 */
@Data
public class AllSubjectDTO extends PageResult {
    private List<SubjectReviewDTO> subjectReviewDTOs;

}
