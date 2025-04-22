package com.jingdianjichi.subject.application.controller;

import com.google.common.base.Preconditions;
import com.jingdianjichi.auth.entity.Result;
import com.jingdianjichi.subject.application.convert.SubjectInfoDTOConverter;
import com.jingdianjichi.subject.application.convert.SubjectReviewDtoConverter;
import com.jingdianjichi.subject.application.dto.SubjectInfoDTO;
import com.jingdianjichi.subject.application.dto.SubjectReviewDTO;
import com.jingdianjichi.subject.common.enums.IsDeletedFlagEnum;
import com.jingdianjichi.subject.domain.convert.SubjectReviewConverter;
import com.jingdianjichi.subject.domain.entity.SubjectInfoBO;
import com.jingdianjichi.subject.domain.service.SubjectReviewDomainService;
import com.jingdianjichi.subject.infra.basic.entity.SubjectInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * @Author: zmy
 * @Date: 2025年04月15日 19:53
 */
@RestController
@Slf4j
@RequestMapping("/subject/review")
public class SubjectReviewController {
    @Resource
    private SubjectReviewDomainService subjectReviewDomainService;

    @GetMapping("/list")
    public Result<List<SubjectReviewDTO>> list() {
        SubjectInfoDTO subjectInfoDTO = new SubjectInfoDTO();
        SubjectInfoBO subjectInfoBO = SubjectInfoDTOConverter.INSTANCE.convertDTOToBO(subjectInfoDTO);
        return Result.ok(subjectReviewDomainService.getReviewSubjects(subjectInfoBO));
    }


    @GetMapping("getMyCommit")
    public Result<List<SubjectInfoDTO>> getMyCommit(){
        SubjectInfoDTO subjectInfoDTO = new SubjectInfoDTO();
        SubjectInfoBO subjectInfoBO = SubjectInfoDTOConverter.INSTANCE.convertDTOToBO(subjectInfoDTO);
        List<SubjectInfoBO> myCommit = subjectReviewDomainService.getMyCommit(subjectInfoBO);
        List<SubjectInfoDTO> subjectInfoDTOS = SubjectInfoDTOConverter.INSTANCE.convertBOToDTOList(myCommit);
        return Result.ok(subjectInfoDTOS);
    }

    @GetMapping("/detail")
    public Result<SubjectReviewDTO> getReviewSubjectDetail(@RequestParam("subjectId") Long subjectId) {
        Preconditions.checkNotNull(subjectId, "subjectId不能为空");

        return Result.ok(subjectReviewDomainService.getReviewSubjectDetail(subjectId));
    }

    @PostMapping("/approve")
    public Result<Void> approve(@RequestParam Long subjectId) {
        Preconditions.checkNotNull(subjectId, "subjectId不能为空");
        subjectReviewDomainService.approve(subjectId);
        return Result.ok();
    }

    @PostMapping("/reject")
    public Result<Void> reject(@RequestParam Long subjectId) {
        Preconditions.checkNotNull(subjectId, "subjectId不能为空");

        subjectReviewDomainService.reject(subjectId);
        return Result.ok();
    }

    @GetMapping("/count")
    public Result<Integer> getReviewCount(){
        return Result.ok(subjectReviewDomainService.getReviewCount());
    }
}
