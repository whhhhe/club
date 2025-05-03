package com.jingdianjichi.subject.domain.handler.subject;

import com.baomidou.mybatisplus.extension.api.R;
import com.google.common.base.Preconditions;
import com.jingdianjichi.subject.common.enums.IsDeletedFlagEnum;
import com.jingdianjichi.subject.common.enums.SubjectInfoTypeEnum;
import com.jingdianjichi.subject.common.util.LoginUtil;
import com.jingdianjichi.subject.domain.constants.Constants;
import static com.jingdianjichi.subject.domain.constants.Constants.*;
import com.jingdianjichi.subject.domain.convert.MultipleSubjectConverter;
import com.jingdianjichi.subject.domain.convert.RadioSubjectConverter;
import com.jingdianjichi.subject.domain.entity.SubjectAnswerBO;
import com.jingdianjichi.subject.domain.entity.SubjectInfoBO;
import com.jingdianjichi.subject.domain.entity.SubjectOptionBO;
import com.jingdianjichi.subject.domain.entity.SubjectReviewBO;
import com.jingdianjichi.subject.domain.redis.RedisUtil;
import com.jingdianjichi.subject.infra.basic.entity.SubjectMultiple;
import com.jingdianjichi.subject.infra.basic.entity.SubjectRadio;
import com.jingdianjichi.subject.infra.basic.service.SubjectRadioService;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 单选题目的策略类
 *
 * @author: ChickenWing
 * @date: 2023/10/5
 */
@Component
public class RadioTypeHandler implements SubjectTypeHandler {

    @Resource
    private SubjectRadioService subjectRadioService;

    @Resource
    private RedisUtil redisUtil;


    @Override
    public SubjectInfoTypeEnum getHandlerType() {
        return SubjectInfoTypeEnum.RADIO;
    }

    @Override
    public void add(SubjectInfoBO subjectInfoBO) {
        Long roleId = Long.valueOf(redisUtil.get(redisUtil.buildKey(ROLE_PREFIX, LoginUtil.getLoginId())));
        Preconditions.checkNotNull(roleId);
        int isDeleted = roleId.equals(ADMIN) ? IsDeletedFlagEnum.UN_DELETED.getCode() : IsDeletedFlagEnum.UNDER_REVIEW.getCode();
        //单选题目的插入
        List<SubjectRadio> subjectRadioList = new LinkedList<>();
        subjectInfoBO.getOptionList().forEach(option -> {
            SubjectRadio subjectRadio = RadioSubjectConverter.INSTANCE.convertBoToEntity(option);
            subjectRadio.setSubjectId(subjectInfoBO.getId());
            subjectRadio.setIsDeleted(isDeleted);
            subjectRadioList.add(subjectRadio);
        });
        subjectRadioService.batchInsert(subjectRadioList);
    }

    @Override
    public SubjectOptionBO query(int subjectId) {
        SubjectRadio subjectRadio = new SubjectRadio();
        subjectRadio.setSubjectId((long) subjectId);
        List<SubjectRadio> result = subjectRadioService.queryByCondition(subjectRadio);
        List<SubjectAnswerBO> subjectAnswerBOList = RadioSubjectConverter.INSTANCE.convertEntityToBoList(result);
        SubjectOptionBO subjectOptionBO = new SubjectOptionBO();
        subjectOptionBO.setOptionList(subjectAnswerBOList);
        return subjectOptionBO;
    }

    @Override
    public List<SubjectReviewBO> queryAllSubjects(Integer pageNo, Integer pageSize) {
        System.out.println("开始查询......");
        SubjectRadio subjectRadio = new SubjectRadio();
        subjectRadio.setIsDeleted(IsDeletedFlagEnum.UN_DELETED.getCode());
        List<SubjectRadio> subjectRadios = subjectRadioService.queryByPage(subjectRadio, pageNo, pageSize);
        if(subjectRadios == null) return null;
        subjectRadios.forEach(System.out::println);
        List<SubjectReviewBO> subjectReviewBOS = new ArrayList<>();
        for(int i = 0; i < subjectRadios.size(); i += 4){
            SubjectReviewBO subjectReviewBO = new SubjectReviewBO();
            subjectReviewBO.setSubjectId(subjectRadios.get(i).getSubjectId());
            subjectReviewBO.setSubjectType(1);
            List<SubjectAnswerBO> list = new ArrayList<>();
            for(int j = i; j < i + 4; j++){
                SubjectAnswerBO subjectAnswerBO = new SubjectAnswerBO();
                subjectAnswerBO.setOptionType(subjectRadios.get(j).getOptionType());
                subjectAnswerBO.setOptionContent(subjectRadios.get(j).getOptionContent());
                subjectAnswerBO.setIsCorrect(subjectRadios.get(j).getIsCorrect());
                list.add(subjectAnswerBO);
            }
            System.out.println("list" + list);
            subjectReviewBO.setOptionList(list);
            subjectReviewBOS.add(subjectReviewBO);
        }
        subjectReviewBOS.forEach(System.out::println);
        return subjectReviewBOS;
    }

    @Override
    public Long count() {

        return subjectRadioService.count();
    }

}
