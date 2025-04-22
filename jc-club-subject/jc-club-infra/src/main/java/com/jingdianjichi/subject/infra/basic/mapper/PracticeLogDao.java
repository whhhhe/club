package com.jingdianjichi.subject.infra.basic.mapper;

import com.jingdianjichi.subject.infra.basic.entity.PracticeDetailLog;
import com.jingdianjichi.subject.infra.basic.entity.PracticeLog;
import com.jingdianjichi.subject.infra.basic.entity.Rank;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PracticeLogDao {

    Long insert(PracticeLog practiceLog);

    List<Rank> getPracticeRankList();

    List<Long> getWrongSubjectIds(String userId);
}
