package com.jingdianjichi.subject.infra.basic.service.impl;

import com.jingdianjichi.subject.common.enums.IsDeletedFlagEnum;
import com.jingdianjichi.subject.infra.basic.entity.*;
import com.jingdianjichi.subject.infra.basic.mapper.*;
import com.jingdianjichi.subject.infra.basic.service.SubjectReviewService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @Author: zmy
 * @Date: 2025年04月15日 20:37
 */
@Service("subjectReviewService")
@Slf4j
public class SubjectReviewServiceImpl implements SubjectReviewService {
    @Resource
    private SubjectInfoDao subjectInfoDao;
    @Resource
    private SubjectRadioDao subjectRadioDao;
    @Resource
    private SubjectMultipleDao subjectMultipleDao;
    @Resource
    private SubjectJudgeDao subjectJudgeDao;
    @Resource
    private SubjectBriefDao subjectBriefDao;

    @Resource
    private SubjectMappingDao subjectMappingDao;
    @Override
    @Transactional
    public List<SubjectReview> getReviewSubjects(SubjectInfo subjectInfo) {
        List<SubjectInfo> infoList = subjectInfoDao.getReviewSubjects(subjectInfo);
        if(infoList == null){
            log.error("subjectInfo传参为空!");
            return null;
        }
        return infoList.stream().map(info -> {
            SubjectReview review = new SubjectReview();
            review.setSubjectId(info.getId());
            review.setSubjectName(info.getSubjectName());
            review.setSubjectType(info.getSubjectType());
            review.setIsDeleted(info.getIsDeleted());
            review.setCategoryIds(subjectMappingDao.getCategoryIds(info.getId()));
            review.setLabelIds(subjectMappingDao.getLabelIds(info.getId()));
            review.setCreatedBy(info.getCreatedBy());
            review.setCreatedTime(info.getCreatedTime());
            review.setSubjectParse(info.getSubjectParse());
            review.setSubjectDifficult(info.getSubjectDifficult());

            switch (info.getSubjectType()) {
                case 1:
                    SubjectRadio subjectRadio = new SubjectRadio();
                    subjectRadio.setSubjectId(info.getId());
                    List<SubjectRadio> subjectRadios = subjectRadioDao.queryAllByLimit(subjectRadio);
                    if (subjectRadios == null || subjectRadios.isEmpty()) {
                        review.setOptionList(Collections.emptyList());
                        break;
                    }
                    List<SubjectAnswer> subjectAnswers = subjectRadios.stream().
                            map(radio -> new SubjectAnswer(radio.getOptionType(), radio.getIsCorrect(), radio.getOptionContent())).collect(Collectors.toList());
                    review.setOptionList(subjectAnswers);
                    break;
                case 2:
                    SubjectMultiple subjectMultiple = new SubjectMultiple();
                    subjectMultiple.setSubjectId(info.getId());
                    List<SubjectMultiple> subjectMultiples = subjectMultipleDao.queryAllByLimit(subjectMultiple);
                    if (subjectMultiples == null || subjectMultiples.isEmpty()) {
                        review.setOptionList(Collections.emptyList());
                        break;
                    }
                    List<SubjectAnswer> multipleAnswers = subjectMultiples.stream()
                            .map(m -> new SubjectAnswer(Math.toIntExact(m.getOptionType()), m.getIsCorrect(), m.getOptionContent()))
                            .collect(Collectors.toList());
                    review.setOptionList(multipleAnswers);
                    break;
                case 3:
                    review.setCorrect(subjectJudgeDao.queryBySubjectId(info.getId()).getIsCorrect());
                    break;
                case 4:
                    review.setSubjectAnswer(subjectBriefDao.queryBySubjectId(info.getId()).getSubjectAnswer());
                    break;
            }
            return review;
        }).collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void updateSubjectStatus(Long subjectId, boolean access) {
        int status = access ? IsDeletedFlagEnum.UN_DELETED.getCode() : IsDeletedFlagEnum.DELETED.getCode();
        SubjectInfo subjectInfo = subjectInfoDao.queryById(subjectId);
        if(subjectInfo == null) {
            log.error("subjectId有误，未能查询到相关题目!");
            return;
        }
        subjectInfo.setIsDeleted(status);
        subjectInfoDao.update(subjectInfo);
        int subjectType = subjectInfo.getSubjectType();
        switch (subjectType){
            case 1:
                SubjectRadio subjectRadio = new SubjectRadio();
                subjectRadio.setSubjectId(subjectId);
                List<SubjectRadio> subjectRadios = subjectRadioDao.queryAllByLimit(subjectRadio);
                for(SubjectRadio o : subjectRadios){
                    o.setIsDeleted(status);
                    subjectRadioDao.update(o);
                }
                break;
            case 2:
                SubjectMultiple subjectMultiple = new SubjectMultiple();
                subjectMultiple.setSubjectId(subjectId);
                List<SubjectMultiple> subjectMultiples = subjectMultipleDao.queryAllByLimit(subjectMultiple);
                for(SubjectMultiple o : subjectMultiples){
                    o.setIsDeleted(status);
                    subjectMultipleDao.update(o);
                }
                break;
            case 3:
                SubjectJudge subjectJudge = subjectJudgeDao.queryBySubjectId(subjectId);
                subjectJudge.setIsDeleted(status);
                subjectJudgeDao.update(subjectJudge);
                break;
            case 4:
                SubjectBrief subjectBrief = subjectBriefDao.queryBySubjectId(subjectId);
                subjectBrief.setIsDeleted(status);
                subjectBriefDao.update(subjectBrief);
                break;
        }
        //处理mapping
        List<SubjectMapping> subjectMappings = subjectMappingDao.queryBySubjectId(subjectId);
        for(SubjectMapping subjectMapping : subjectMappings){
            subjectMapping.setIsDeleted(status);
        }
        subjectMappingDao.insertOrUpdateBatch(subjectMappings);
    }

    @Override
    public Integer getReviewCount() {
        SubjectInfo subjectInfo = new SubjectInfo();
        subjectInfo.setIsDeleted(IsDeletedFlagEnum.UNDER_REVIEW.getCode());
        return subjectInfoDao.getCounts();
    }

    @Override
    public List<SubjectInfo> getMyCommit(SubjectInfo subjectInfo) {
        return subjectInfoDao.getMyCommit(subjectInfo);
    }

}
