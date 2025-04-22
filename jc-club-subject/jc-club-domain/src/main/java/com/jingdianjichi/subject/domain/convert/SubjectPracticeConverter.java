package com.jingdianjichi.subject.domain.convert;


import com.jingdianjichi.subject.domain.entity.PracticeSubmitBO;
import com.jingdianjichi.subject.domain.entity.RankBO;
import com.jingdianjichi.subject.infra.basic.entity.PracticeDetailLog;
import com.jingdianjichi.subject.infra.basic.entity.PracticeLog;
import com.jingdianjichi.subject.infra.basic.entity.Rank;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper
public interface SubjectPracticeConverter {
    SubjectPracticeConverter INSTANCE = Mappers.getMapper(SubjectPracticeConverter.class);

    PracticeLog converterBOtoEntity(PracticeSubmitBO practiceSubmitBO);

    List<RankBO> converterRanksToBOs(List<Rank> ranks);

}
