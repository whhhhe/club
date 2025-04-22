package com.jingdianjichi.subject.infra.basic.mapper;

import com.jingdianjichi.subject.infra.basic.entity.PracticeDetailLog;
import com.jingdianjichi.subject.infra.basic.entity.SubjectBrief;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PracticeDetailLogDao {
    void batchInsert(@Param("list") List<PracticeDetailLog> list);
}
