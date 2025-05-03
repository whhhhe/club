package com.jingdianjichi.subject.domain.handler.subject;

import com.google.common.base.Preconditions;
import com.jingdianjichi.subject.common.enums.IsDeletedFlagEnum;
import com.jingdianjichi.subject.common.enums.SubjectInfoTypeEnum;
import com.jingdianjichi.subject.common.util.LoginUtil;
import com.jingdianjichi.subject.domain.constants.Constants;
import com.jingdianjichi.subject.domain.convert.JudgeSubjectConverter;
import com.jingdianjichi.subject.domain.convert.MultipleSubjectConverter;
import com.jingdianjichi.subject.domain.convert.RadioSubjectConverter;
import com.jingdianjichi.subject.domain.entity.SubjectAnswerBO;
import com.jingdianjichi.subject.domain.entity.SubjectInfoBO;
import com.jingdianjichi.subject.domain.entity.SubjectOptionBO;
import com.jingdianjichi.subject.domain.entity.SubjectReviewBO;
import com.jingdianjichi.subject.domain.redis.RedisUtil;
import com.jingdianjichi.subject.infra.basic.entity.SubjectJudge;
import com.jingdianjichi.subject.infra.basic.entity.SubjectMultiple;
import com.jingdianjichi.subject.infra.basic.entity.SubjectRadio;
import com.jingdianjichi.subject.infra.basic.service.SubjectMultipleService;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.LinkedList;
import java.util.List;

import static com.jingdianjichi.subject.domain.constants.Constants.ADMIN;
import static com.jingdianjichi.subject.domain.constants.Constants.ROLE_PREFIX;

/**
 * 多选题目的策略类
 * 
 * @author: ChickenWing
 * @date: 2023/10/5
 */
@Component
public class MultipleTypeHandler implements SubjectTypeHandler{

    @Resource
    private SubjectMultipleService subjectMultipleService;
    @Resource
    private RedisUtil redisUtil;
    
    @Override
    public SubjectInfoTypeEnum getHandlerType() {
        return SubjectInfoTypeEnum.MULTIPLE;
    }

    @Override
    public void add(SubjectInfoBO subjectInfoBO) {
        Long roleId = Long.valueOf(redisUtil.get(redisUtil.buildKey(ROLE_PREFIX, LoginUtil.getLoginId())));
        Preconditions.checkNotNull(roleId);
        int isDeleted = roleId.equals(ADMIN) ? IsDeletedFlagEnum.UN_DELETED.getCode() : IsDeletedFlagEnum.UNDER_REVIEW.getCode();

        //多选题目的插入
        List<SubjectMultiple> subjectMultipleList = new LinkedList<>();
        subjectInfoBO.getOptionList().forEach(option -> {
            SubjectMultiple subjectMultiple = MultipleSubjectConverter.INSTANCE.convertBoToEntity(option);
            subjectMultiple.setSubjectId(subjectInfoBO.getId());
            subjectMultiple.setIsDeleted(isDeleted);
            subjectMultipleList.add(subjectMultiple);
        });
        subjectMultipleService.batchInsert(subjectMultipleList);
    }

    @Override
    public SubjectOptionBO query(int subjectId) {
        SubjectMultiple subjectMultiple = new SubjectMultiple();
        subjectMultiple.setSubjectId(Long.valueOf(subjectId));
        List<SubjectMultiple> result = subjectMultipleService.queryByCondition(subjectMultiple);
        List<SubjectAnswerBO> subjectAnswerBOList = MultipleSubjectConverter.INSTANCE.convertEntityToBoList(result);
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
