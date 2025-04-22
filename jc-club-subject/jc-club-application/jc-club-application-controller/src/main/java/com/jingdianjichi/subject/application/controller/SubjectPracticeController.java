package com.jingdianjichi.subject.application.controller;

import com.baomidou.mybatisplus.extension.api.R;
import com.google.common.base.Preconditions;
import com.jingdianjichi.auth.entity.Result;
import com.jingdianjichi.subject.application.convert.SubjectInfoDTOConverter;
import com.jingdianjichi.subject.application.convert.SubjectPracticeDTOConverter;
import com.jingdianjichi.subject.application.convert.SubjectReviewDtoConverter;
import com.jingdianjichi.subject.application.dto.*;
import com.jingdianjichi.subject.domain.convert.SubjectPracticeConverter;
import com.jingdianjichi.subject.domain.entity.PracticeSubmitBO;
import com.jingdianjichi.subject.domain.entity.SubjectInfoBO;
import com.jingdianjichi.subject.domain.entity.SubjectReviewBO;
import com.jingdianjichi.subject.domain.redis.RedisUtil;
import com.jingdianjichi.subject.domain.service.PracticeLogDomainService;
import com.jingdianjichi.subject.domain.service.SubjectPracticeDomainService;
import com.jingdianjichi.subject.infra.basic.entity.SubjectInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.List;

/**
 * @Author: zmy
 * @Date: 2025年04月17日 13:07
 */

@RestController
@RequestMapping("/subject/practice")
@Slf4j
public class SubjectPracticeController {


    @Resource
    private PracticeLogDomainService practiceLogDomainService;
    @Resource
    private SubjectPracticeDomainService subjectPracticeDomainService;

    @PostMapping("start")
    public Result<List<SubjectReviewDTO>> start(@RequestBody SubjectPracticeDTO subjectPracticeDTO){
        try {
            Preconditions.checkNotNull(subjectPracticeDTO, "参数为空！！");
            Preconditions.checkNotNull(subjectPracticeDTO.getLabelIds(), "标签为空！！");
            Preconditions.checkNotNull(subjectPracticeDTO.getSubjectDifficulties(), "难度为空！！");

            log.info("subjectPracticeDTO:{}", subjectPracticeDTO);
            List<Long> labelIds = subjectPracticeDTO.getLabelIds();
            List<Integer> subjectDifficulties = subjectPracticeDTO.getSubjectDifficulties();

            List<SubjectReviewBO> boList = subjectPracticeDomainService.start(labelIds, subjectDifficulties);

            List<SubjectReviewDTO> dtoList = SubjectReviewDtoConverter.INSTANCE.converterBOListToDTOList(boList);
            Collections.shuffle(dtoList);
            return Result.ok(dtoList);
        } catch (Exception e) {
            log.info("subject.practice.start.error:{}", e.getMessage());
            throw new RuntimeException(e);
        }

    }

    @PostMapping("/submit")

    public Result<Long> submit(@RequestBody PracticeSubmitDTO submitDTO) {
        // 逻辑处理
        try{
            log.info("PracticeSubmitDTO:{}", submitDTO);
            Preconditions.checkNotNull(submitDTO, "参数为空！！");
            PracticeSubmitBO practiceSubmitBO = SubjectPracticeDTOConverter.INSTANCE.PracticeDTOtoBO(submitDTO);;
            Long practiceId =  practiceLogDomainService.submit(practiceSubmitBO);
            return Result.ok(practiceId);
        }catch (Exception e){
            log.error("submit.error:{}", e.getMessage());
            throw new RuntimeException();
        }
    }
    @PostMapping(value = "/getPracticeRankList")
    private Result<List<RankDTO>> getPracticeRankList(){

        List<RankDTO> rankDTOList = SubjectPracticeDTOConverter.INSTANCE.
                practiceRankBOsToDTOs(subjectPracticeDomainService.getPracticeRankList());
        return Result.ok(rankDTOList);
    }

    @GetMapping("/wrongList")
    public Result<List<SubjectInfoDTO>> getWrongList(@RequestParam(value = "difficulty", required = false) Integer difficulty){
        List<SubjectInfoBO> SubjectInfoBOS =  subjectPracticeDomainService.getWrongList(difficulty);
        List<SubjectInfoDTO> dtoList = SubjectInfoDTOConverter.INSTANCE.convertBOToDTOList(SubjectInfoBOS);

        return Result.ok(dtoList);
    }

    @GetMapping("/wrongDetail")
    public Result<SubjectReviewDTO> getWrongDetail(@RequestParam("subjectId") Long subjectId){
        Preconditions.checkNotNull(subjectId, "subjectId为空！");

        SubjectReviewBO subjectReviewBO = subjectPracticeDomainService.getWrongDetail(subjectId);

        SubjectReviewDTO subjectReviewDTO = SubjectReviewDtoConverter.INSTANCE.converterBOoToDTO(subjectReviewBO);

        return Result.ok(subjectReviewDTO);
    }

}
