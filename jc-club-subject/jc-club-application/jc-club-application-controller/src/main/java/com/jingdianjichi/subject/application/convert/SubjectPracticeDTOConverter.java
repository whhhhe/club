package com.jingdianjichi.subject.application.convert;

import com.jingdianjichi.subject.application.dto.PracticeSubmitDTO;
import com.jingdianjichi.subject.application.dto.RankDTO;
import com.jingdianjichi.subject.domain.entity.PracticeSubmitBO;
import com.jingdianjichi.subject.domain.entity.RankBO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper
public interface SubjectPracticeDTOConverter {
    SubjectPracticeDTOConverter INSTANCE = Mappers.getMapper(SubjectPracticeDTOConverter.class);

    PracticeSubmitBO PracticeDTOtoBO(PracticeSubmitDTO practiceSubmitDTO);

    RankBO practiceRankDTOtoBO(RankDTO rankDTO);

    List<RankDTO> practiceRankBOsToDTOs(List<RankBO> rankBOs);

}
