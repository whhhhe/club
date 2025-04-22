package com.jingdianjichi.subject.domain.convert;

import com.jingdianjichi.subject.domain.entity.SubjectReviewBO;
import com.jingdianjichi.subject.infra.basic.entity.SubjectInfo;
import com.jingdianjichi.subject.infra.basic.entity.SubjectReview;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper
public interface SubjectReviewConverter {
    SubjectReviewConverter INSTANCE = Mappers.getMapper(SubjectReviewConverter.class);

    List<SubjectReviewBO> converterEntitiesToBOS(List<SubjectReview> subjectReviews);

    SubjectReviewBO converterReviewToBO(SubjectReview subjectReview);

}
