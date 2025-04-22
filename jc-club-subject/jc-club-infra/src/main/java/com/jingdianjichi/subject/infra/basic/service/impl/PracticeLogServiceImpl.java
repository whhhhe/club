package com.jingdianjichi.subject.infra.basic.service.impl;

import com.jingdianjichi.subject.common.enums.IsDeletedFlagEnum;
import com.jingdianjichi.subject.common.util.LoginUtil;
import com.jingdianjichi.subject.infra.basic.entity.PracticeLog;
import com.jingdianjichi.subject.infra.basic.mapper.PracticeLogDao;
import com.jingdianjichi.subject.infra.basic.service.PracticeLogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @Author: zmy
 * @Date: 2025年04月17日 20:17
 */

@Service("practiceLogService")
public class PracticeLogServiceImpl implements PracticeLogService {
    @Resource
    private PracticeLogDao practiceLogDao;

    @Override
    public Long submit(PracticeLog practiceLog) {
        String loginId = LoginUtil.getLoginId();
        practiceLog.setUserId(loginId);
        practiceLog.setIsDeleted(IsDeletedFlagEnum.UN_DELETED.getCode());
        practiceLogDao.insert(practiceLog);
        return practiceLog.getId();
    }
}
