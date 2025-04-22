package com.jingdianjichi.subject.domain.convert;

import com.jingdianjichi.subject.domain.entity.SubjectAnswerBO;
import com.jingdianjichi.subject.domain.entity.SubjectReviewBO;
import com.jingdianjichi.subject.infra.basic.entity.SubjectAnswer;
import com.jingdianjichi.subject.infra.basic.entity.SubjectReview;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Generated;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2025-04-18T17:03:52+0800",
    comments = "version: 1.4.2.Final, compiler: javac, environment: Java 1.8.0_392 (Amazon.com Inc.)"
)
public class SubjectReviewConverterImpl implements SubjectReviewConverter {

    @Override
    public List<SubjectReviewBO> converterEntitiesToBOS(List<SubjectReview> subjectReviews) {
        if ( subjectReviews == null ) {
            return null;
        }

        List<SubjectReviewBO> list = new ArrayList<SubjectReviewBO>( subjectReviews.size() );
        for ( SubjectReview subjectReview : subjectReviews ) {
            list.add( converterReviewToBO( subjectReview ) );
        }

        return list;
    }

    @Override
    public SubjectReviewBO converterReviewToBO(SubjectReview subjectReview) {
        if ( subjectReview == null ) {
            return null;
        }

        SubjectReviewBO subjectReviewBO = new SubjectReviewBO();

        subjectReviewBO.setSubjectId( subjectReview.getSubjectId() );
        subjectReviewBO.setSubjectName( subjectReview.getSubjectName() );
        subjectReviewBO.setSubjectType( subjectReview.getSubjectType() );
        subjectReviewBO.setSubjectAnswer( subjectReview.getSubjectAnswer() );
        subjectReviewBO.setCorrect( subjectReview.getCorrect() );
        subjectReviewBO.setOptionList( subjectAnswerListToSubjectAnswerBOList( subjectReview.getOptionList() ) );
        subjectReviewBO.setSubjectDifficult( subjectReview.getSubjectDifficult() );
        List<Long> list1 = subjectReview.getCategoryIds();
        if ( list1 != null ) {
            subjectReviewBO.setCategoryIds( new ArrayList<Long>( list1 ) );
        }
        List<Long> list2 = subjectReview.getLabelIds();
        if ( list2 != null ) {
            subjectReviewBO.setLabelIds( new ArrayList<Long>( list2 ) );
        }
        subjectReviewBO.setSubjectParse( subjectReview.getSubjectParse() );
        subjectReviewBO.setCreatedBy( subjectReview.getCreatedBy() );
        subjectReviewBO.setCreatedTime( subjectReview.getCreatedTime() );
        subjectReviewBO.setIsDeleted( subjectReview.getIsDeleted() );

        return subjectReviewBO;
    }

    protected SubjectAnswerBO subjectAnswerToSubjectAnswerBO(SubjectAnswer subjectAnswer) {
        if ( subjectAnswer == null ) {
            return null;
        }

        SubjectAnswerBO subjectAnswerBO = new SubjectAnswerBO();

        subjectAnswerBO.setOptionType( subjectAnswer.getOptionType() );
        subjectAnswerBO.setOptionContent( subjectAnswer.getOptionContent() );
        subjectAnswerBO.setIsCorrect( subjectAnswer.getIsCorrect() );

        return subjectAnswerBO;
    }

    protected List<SubjectAnswerBO> subjectAnswerListToSubjectAnswerBOList(List<SubjectAnswer> list) {
        if ( list == null ) {
            return null;
        }

        List<SubjectAnswerBO> list1 = new ArrayList<SubjectAnswerBO>( list.size() );
        for ( SubjectAnswer subjectAnswer : list ) {
            list1.add( subjectAnswerToSubjectAnswerBO( subjectAnswer ) );
        }

        return list1;
    }
}
