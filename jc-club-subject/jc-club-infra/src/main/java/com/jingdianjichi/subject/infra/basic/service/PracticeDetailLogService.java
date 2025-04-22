package com.jingdianjichi.subject.infra.basic.service;

import com.jingdianjichi.subject.infra.basic.entity.PracticeDetailLog;

import java.util.List;

/**
 * @Author: zmy
 * @Date: 2025年04月17日 21:10
 */
public interface PracticeDetailLogService {

    void batchInsert(List<PracticeDetailLog> list);
}
