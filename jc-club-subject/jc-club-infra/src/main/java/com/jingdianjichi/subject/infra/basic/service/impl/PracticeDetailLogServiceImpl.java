package com.jingdianjichi.subject.infra.basic.service.impl;

import com.jingdianjichi.subject.infra.basic.entity.PracticeDetailLog;
import com.jingdianjichi.subject.infra.basic.mapper.PracticeDetailLogDao;
import com.jingdianjichi.subject.infra.basic.service.PracticeDetailLogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Author: zmy
 * @Date: 2025年04月17日 21:10
 */
@Service("practiceDetailLogService")
public class PracticeDetailLogServiceImpl implements PracticeDetailLogService {

    @Resource
    private PracticeDetailLogDao practiceDetailLogDao;

    @Override
    public void batchInsert(List<PracticeDetailLog> list) {
        practiceDetailLogDao.batchInsert(list);
    }
}
