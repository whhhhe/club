package com.jingdianjichi.subject.application.convert;

import com.jingdianjichi.subject.application.dto.SubjectAnswerDTO;
import com.jingdianjichi.subject.application.dto.SubjectReviewDTO;
import com.jingdianjichi.subject.domain.entity.SubjectAnswerBO;
import com.jingdianjichi.subject.domain.entity.SubjectReviewBO;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Generated;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2025-05-01T22:48:09+0800",
    comments = "version: 1.4.2.Final, compiler: javac, environment: Java 1.8.0_392 (Amazon.com Inc.)"
)
public class SubjectReviewDtoConverterImpl implements SubjectReviewDtoConverter {

    @Override
    public SubjectReviewBO converterDtoToBo(SubjectReviewDTO subjectReviewDTO) {
        if ( subjectReviewDTO == null ) {
            return null;
        }

        SubjectReviewBO subjectReviewBO = new SubjectReviewBO();

        subjectReviewBO.setSubjectId( subjectReviewDTO.getSubjectId() );
        subjectReviewBO.setSubjectName( subjectReviewDTO.getSubjectName() );
        subjectReviewBO.setSubjectType( subjectReviewDTO.getSubjectType() );
        subjectReviewBO.setSubjectAnswer( subjectReviewDTO.getSubjectAnswer() );
        subjectReviewBO.setCorrect( subjectReviewDTO.getCorrect() );
        subjectReviewBO.setOptionList( subjectAnswerDTOListToSubjectAnswerBOList( subjectReviewDTO.getOptionList() ) );
        subjectReviewBO.setSubjectDifficult( subjectReviewDTO.getSubjectDifficult() );
        List<Long> list1 = subjectReviewDTO.getCategoryIds();
        if ( list1 != null ) {
            subjectReviewBO.setCategoryIds( new ArrayList<Long>( list1 ) );
        }
        List<Long> list2 = subjectReviewDTO.getLabelIds();
        if ( list2 != null ) {
            subjectReviewBO.setLabelIds( new ArrayList<Long>( list2 ) );
        }
        subjectReviewBO.setSubjectParse( subjectReviewDTO.getSubjectParse() );
        subjectReviewBO.setCreatedBy( subjectReviewDTO.getCreatedBy() );
        subjectReviewBO.setCreatedTime( subjectReviewDTO.getCreatedTime() );
        subjectReviewBO.setIsDeleted( subjectReviewDTO.getIsDeleted() );
        List<String> list3 = subjectReviewDTO.getLabelNames();
        if ( list3 != null ) {
            subjectReviewBO.setLabelNames( new ArrayList<String>( list3 ) );
        }

        return subjectReviewBO;
    }

    @Override
    public SubjectReviewDTO converterBOoToDTO(SubjectReviewBO subjectReviewBO) {
        if ( subjectReviewBO == null ) {
            return null;
        }

        SubjectReviewDTO subjectReviewDTO = new SubjectReviewDTO();

        subjectReviewDTO.setSubjectId( subjectReviewBO.getSubjectId() );
        subjectReviewDTO.setSubjectName( subjectReviewBO.getSubjectName() );
        subjectReviewDTO.setSubjectType( subjectReviewBO.getSubjectType() );
        subjectReviewDTO.setSubjectAnswer( subjectReviewBO.getSubjectAnswer() );
        subjectReviewDTO.setOptionList( subjectAnswerBOListToSubjectAnswerDTOList( subjectReviewBO.getOptionList() ) );
        List<Long> list1 = subjectReviewBO.getCategoryIds();
        if ( list1 != null ) {
            subjectReviewDTO.setCategoryIds( new ArrayList<Long>( list1 ) );
        }
        List<Long> list2 = subjectReviewBO.getLabelIds();
        if ( list2 != null ) {
            subjectReviewDTO.setLabelIds( new ArrayList<Long>( list2 ) );
        }
        subjectReviewDTO.setCorrect( subjectReviewBO.getCorrect() );
        subjectReviewDTO.setSubjectDifficult( subjectReviewBO.getSubjectDifficult() );
        subjectReviewDTO.setSubjectParse( subjectReviewBO.getSubjectParse() );
        subjectReviewDTO.setCreatedBy( subjectReviewBO.getCreatedBy() );
        subjectReviewDTO.setCreatedTime( subjectReviewBO.getCreatedTime() );
        subjectReviewDTO.setIsDeleted( subjectReviewBO.getIsDeleted() );
        List<String> list3 = subjectReviewBO.getLabelNames();
        if ( list3 != null ) {
            subjectReviewDTO.setLabelNames( new ArrayList<String>( list3 ) );
        }

        return subjectReviewDTO;
    }

    @Override
    public List<SubjectReviewDTO> converterBOListToDTOList(List<SubjectReviewBO> subjectReviewBOS) {
        if ( subjectReviewBOS == null ) {
            return null;
        }

        List<SubjectReviewDTO> list = new ArrayList<SubjectReviewDTO>( subjectReviewBOS.size() );
        for ( SubjectReviewBO subjectReviewBO : subjectReviewBOS ) {
            list.add( converterBOoToDTO( subjectReviewBO ) );
        }

        return list;
    }

    protected SubjectAnswerBO subjectAnswerDTOToSubjectAnswerBO(SubjectAnswerDTO subjectAnswerDTO) {
        if ( subjectAnswerDTO == null ) {
            return null;
        }

        SubjectAnswerBO subjectAnswerBO = new SubjectAnswerBO();

        subjectAnswerBO.setOptionType( subjectAnswerDTO.getOptionType() );
        subjectAnswerBO.setOptionContent( subjectAnswerDTO.getOptionContent() );
        subjectAnswerBO.setIsCorrect( subjectAnswerDTO.getIsCorrect() );

        return subjectAnswerBO;
    }

    protected List<SubjectAnswerBO> subjectAnswerDTOListToSubjectAnswerBOList(List<SubjectAnswerDTO> list) {
        if ( list == null ) {
            return null;
        }

        List<SubjectAnswerBO> list1 = new ArrayList<SubjectAnswerBO>( list.size() );
        for ( SubjectAnswerDTO subjectAnswerDTO : list ) {
            list1.add( subjectAnswerDTOToSubjectAnswerBO( subjectAnswerDTO ) );
        }

        return list1;
    }

    protected SubjectAnswerDTO subjectAnswerBOToSubjectAnswerDTO(SubjectAnswerBO subjectAnswerBO) {
        if ( subjectAnswerBO == null ) {
            return null;
        }

        SubjectAnswerDTO subjectAnswerDTO = new SubjectAnswerDTO();

        subjectAnswerDTO.setOptionType( subjectAnswerBO.getOptionType() );
        subjectAnswerDTO.setOptionContent( subjectAnswerBO.getOptionContent() );
        subjectAnswerDTO.setIsCorrect( subjectAnswerBO.getIsCorrect() );

        return subjectAnswerDTO;
    }

    protected List<SubjectAnswerDTO> subjectAnswerBOListToSubjectAnswerDTOList(List<SubjectAnswerBO> list) {
        if ( list == null ) {
            return null;
        }

        List<SubjectAnswerDTO> list1 = new ArrayList<SubjectAnswerDTO>( list.size() );
        for ( SubjectAnswerBO subjectAnswerBO : list ) {
            list1.add( subjectAnswerBOToSubjectAnswerDTO( subjectAnswerBO ) );
        }

        return list1;
    }
}
