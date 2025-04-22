package com.jingdianjichi.subject.application.convert;

import com.jingdianjichi.subject.application.dto.SubjectReviewDTO;
import com.jingdianjichi.subject.domain.convert.SubjectReviewConverter;
import com.jingdianjichi.subject.domain.entity.SubjectReviewBO;
import com.jingdianjichi.subject.infra.basic.entity.SubjectInfo;
import com.jingdianjichi.subject.infra.basic.entity.SubjectReview;
import com.jingdianjichi.subject.infra.basic.mapper.SubjectMappingDao;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper
public interface SubjectReviewDtoConverter {
    SubjectReviewDtoConverter INSTANCE = Mappers.getMapper(SubjectReviewDtoConverter.class);

    SubjectReviewBO converterDtoToBo(SubjectReviewDTO subjectReviewDTO);
    SubjectReviewDTO converterBOoToDTO(SubjectReviewBO subjectReviewBO);
    List<SubjectReviewDTO> converterBOListToDTOList(List<SubjectReviewBO> subjectReviewBOS);

}
