package com.jingdianjichi.subject.domain.service.impl;

import com.jingdianjichi.subject.common.enums.IsDeletedFlagEnum;
import com.jingdianjichi.subject.domain.convert.SubjectPracticeConverter;
import com.jingdianjichi.subject.domain.entity.AnswerResult;
import com.jingdianjichi.subject.domain.entity.PracticeSubmitBO;
import com.jingdianjichi.subject.domain.service.PracticeLogDomainService;
import com.jingdianjichi.subject.infra.basic.entity.PracticeDetailLog;
import com.jingdianjichi.subject.infra.basic.entity.PracticeLog;
import com.jingdianjichi.subject.infra.basic.service.PracticeDetailLogService;
import com.jingdianjichi.subject.infra.basic.service.PracticeLogService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * @Author: zmy
 * @Date: 2025年04月17日 20:16
 */

@Slf4j
@Service("practiceLogDomainService")
public class PracticeLogDomainServiceImpl implements PracticeLogDomainService {

    @Resource
    private PracticeLogService practiceLogService;

    @Resource
    private PracticeDetailLogService practiceDetailLogService;
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long submit(PracticeSubmitBO practiceSubmitBO) {
        PracticeLog practiceLog = SubjectPracticeConverter.INSTANCE.converterBOtoEntity(practiceSubmitBO);
        Long practiceId = practiceLogService.submit(practiceLog);

        List<AnswerResult> answers = practiceSubmitBO.getAnswers();
        List<PracticeDetailLog> list = new ArrayList<>();
        for(AnswerResult answerResult : answers){
            log.info("practiceId:{}", practiceId);
            PracticeDetailLog practiceDetailLog = new PracticeDetailLog();
            practiceDetailLog.setPracticeId(practiceId);
            practiceDetailLog.setSubjectId(answerResult.getSubjectId());
            practiceDetailLog.setSubjectType(answerResult.getSubjectType());
            practiceDetailLog.setIsCorrect(answerResult.getIsCorrect());
            practiceDetailLog.setIsDeleted(IsDeletedFlagEnum.UN_DELETED.getCode());
            list.add(practiceDetailLog);
        }
        log.info("list:{}", list);
        practiceDetailLogService.batchInsert(list);
        return practiceId;
    }
}
