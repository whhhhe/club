package com.jingdianjichi.subject.domain.service;

import com.jingdianjichi.subject.domain.entity.PracticeSubmitBO;

import java.util.List;

public interface PracticeDetailLogDomainService {
    void submit(List<PracticeSubmitBO> list);
}
