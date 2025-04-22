package com.jingdianjichi.subject.infra.basic.service.impl;

import com.jingdianjichi.subject.common.util.LoginUtil;
import com.jingdianjichi.subject.infra.basic.entity.*;
import com.jingdianjichi.subject.infra.basic.mapper.*;
import com.jingdianjichi.subject.infra.basic.service.SubjectPracticeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @Author: zmy
 * @Date: 2025年04月17日 14:53
 */

@Service("subjectPracticeService")
public class SubjectPracticeServiceImpl implements SubjectPracticeService {

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

    @Resource
    private PracticeLogDao practiceLogDao;


    @Override
    public List<SubjectReview> start(List<Long> subjectIds) {
        List<SubjectInfo> infos = subjectInfoDao.queryByIdList(subjectIds);

        return infos.stream().map(info -> {
            SubjectReview review = new SubjectReview();
            review.setSubjectId(info.getId());
            review.setSubjectName(info.getSubjectName());
            review.setSubjectType(info.getSubjectType());
            review.setIsDeleted(info.getIsDeleted());
            review.setLabelIds(subjectMappingDao.getLabelIds(info.getId()));
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
    public List<Rank> getPracticeRankList() {
        return practiceLogDao.getPracticeRankList();
    }

    @Override
    public List<SubjectInfo> getWrongList(Integer difficulty) {
        String loginId = LoginUtil.getLoginId();
        List<Long> ids = practiceLogDao.getWrongSubjectIds(loginId);
        if(ids.isEmpty()) return Collections.emptyList();
        return subjectInfoDao.queryByIdListAndDiff(ids, difficulty);
    }
}
