package com.jingdianjichi.subject.domain.handler.subject;

import com.google.common.base.Preconditions;
import com.jingdianjichi.subject.common.enums.IsDeletedFlagEnum;
import com.jingdianjichi.subject.common.enums.SubjectInfoTypeEnum;
import com.jingdianjichi.subject.common.util.LoginUtil;
import com.jingdianjichi.subject.domain.constants.Constants;
import com.jingdianjichi.subject.domain.convert.JudgeSubjectConverter;
import com.jingdianjichi.subject.domain.convert.MultipleSubjectConverter;
import com.jingdianjichi.subject.domain.entity.SubjectAnswerBO;
import com.jingdianjichi.subject.domain.entity.SubjectInfoBO;
import com.jingdianjichi.subject.domain.entity.SubjectOptionBO;
import com.jingdianjichi.subject.domain.entity.SubjectReviewBO;
import com.jingdianjichi.subject.domain.redis.RedisUtil;
import com.jingdianjichi.subject.infra.basic.entity.SubjectJudge;
import com.jingdianjichi.subject.infra.basic.entity.SubjectMultiple;
import com.jingdianjichi.subject.infra.basic.service.SubjectJudgeService;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.LinkedList;
import java.util.List;

import static com.jingdianjichi.subject.domain.constants.Constants.ADMIN;
import static com.jingdianjichi.subject.domain.constants.Constants.ROLE_PREFIX;

/**
 * 判断题目的策略类
 * 
 * @author: ChickenWing
 * @date: 2023/10/5
 */
@Component
public class JudgeTypeHandler implements SubjectTypeHandler{

    @Resource
    private SubjectJudgeService subjectJudgeService;
    @Resource
    private RedisUtil redisUtil;

    @Override
    public SubjectInfoTypeEnum getHandlerType() {
        return SubjectInfoTypeEnum.JUDGE;
    }

    @Override
    public void add(SubjectInfoBO subjectInfoBO) {
        String key = redisUtil.buildKey(ROLE_PREFIX, LoginUtil.getLoginId());
        Long roleId = Long.valueOf(redisUtil.get(key));
        Preconditions.checkNotNull(roleId);
        int isDeleted = roleId.equals(ADMIN) ? IsDeletedFlagEnum.UN_DELETED.getCode() : IsDeletedFlagEnum.UNDER_REVIEW.getCode();

        //判断题目的插入
        SubjectJudge subjectJudge = new SubjectJudge();
        SubjectAnswerBO subjectAnswerBO = subjectInfoBO.getOptionList().get(0);
        subjectJudge.setSubjectId(subjectInfoBO.getId());
        subjectJudge.setIsCorrect(subjectAnswerBO.getIsCorrect());
        subjectJudge.setIsDeleted(isDeleted);
        subjectJudgeService.insert(subjectJudge);
    }

    @Override
    public SubjectOptionBO query(int subjectId) {
        SubjectJudge subjectJudge = new SubjectJudge();
        subjectJudge.setSubjectId(Long.valueOf(subjectId));
        List<SubjectJudge> result = subjectJudgeService.queryByCondition(subjectJudge);
        List<SubjectAnswerBO> subjectAnswerBOList = JudgeSubjectConverter.INSTANCE.convertEntityToBoList(result);
        SubjectOptionBO subjectOptionBO = new SubjectOptionBO();
        subjectOptionBO.setOptionList(subjectAnswerBOList);
        return subjectOptionBO;
    }

    @Override
    public List<SubjectReviewBO> queryAllSubjects(Integer pageNo, Integer pageSize) {
        return null;
    }

    @Override
    public Long count() {
        return null;
    }
}
