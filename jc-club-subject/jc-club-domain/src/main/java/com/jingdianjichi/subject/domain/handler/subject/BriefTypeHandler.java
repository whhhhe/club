package com.jingdianjichi.subject.domain.handler.subject;

import com.jingdianjichi.subject.common.enums.IsDeletedFlagEnum;
import com.jingdianjichi.subject.common.enums.SubjectInfoTypeEnum;
import com.jingdianjichi.subject.common.util.LoginUtil;
import com.jingdianjichi.subject.domain.constants.Constants;
import com.jingdianjichi.subject.domain.convert.BriefSubjectConverter;
import com.jingdianjichi.subject.domain.entity.SubjectInfoBO;
import com.jingdianjichi.subject.domain.entity.SubjectOptionBO;
import com.jingdianjichi.subject.domain.entity.SubjectReviewBO;
import com.jingdianjichi.subject.domain.redis.RedisUtil;
import com.jingdianjichi.subject.infra.basic.entity.SubjectBrief;
import com.jingdianjichi.subject.infra.basic.service.SubjectBriefService;
import org.springframework.stereotype.Component;
import com.jingdianjichi.subject.domain.constants.Constants.*;

import javax.annotation.Resource;

import java.util.List;

import static com.jingdianjichi.subject.domain.constants.Constants.ADMIN;
import static com.jingdianjichi.subject.domain.constants.Constants.ROLE_PREFIX;

/**
 * 简答题目的策略类
 * 
 * @author: ChickenWing
 * @date: 2023/10/5
 */
@Component
public class BriefTypeHandler implements SubjectTypeHandler{

    @Resource
    private SubjectBriefService subjectBriefService;

    @Resource
    private RedisUtil redisUtil;


    @Override
    public SubjectInfoTypeEnum getHandlerType() {
        return SubjectInfoTypeEnum.BRIEF;
    }

    @Override
    public void add(SubjectInfoBO subjectInfoBO) {
        Long roleId = Long.valueOf(redisUtil.get(redisUtil.buildKey(ROLE_PREFIX, LoginUtil.getLoginId())));
        int isDeleted = roleId.equals(ADMIN) ? IsDeletedFlagEnum.UN_DELETED.getCode() : IsDeletedFlagEnum.UNDER_REVIEW.getCode();

//        System.out.println("subjectInfoBO:" + subjectInfoBO);
        SubjectBrief subjectBrief = BriefSubjectConverter.INSTANCE.convertBoToEntity(subjectInfoBO);
//        System.out.println("subjectBrief:" + subjectBrief);
        subjectBrief.setSubjectId(subjectInfoBO.getId().intValue());
        subjectBrief.setIsDeleted(isDeleted);
        subjectBriefService.insert(subjectBrief);
    }

    @Override
    public SubjectOptionBO query(int subjectId) {
        SubjectBrief subjectBrief = new SubjectBrief();
        subjectBrief.setSubjectId(subjectId);
        SubjectBrief result = subjectBriefService.queryByCondition(subjectBrief);
        SubjectOptionBO subjectOptionBO = new SubjectOptionBO();
        subjectOptionBO.setSubjectAnswer(result.getSubjectAnswer());
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
