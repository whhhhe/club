package com.jingdianjichi.subject.application.convert;

import com.jingdianjichi.subject.application.dto.AnswerResult;
import com.jingdianjichi.subject.application.dto.PracticeSubmitDTO;
import com.jingdianjichi.subject.application.dto.RankDTO;
import com.jingdianjichi.subject.domain.entity.PracticeSubmitBO;
import com.jingdianjichi.subject.domain.entity.RankBO;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Generated;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2025-05-01T22:48:09+0800",
    comments = "version: 1.4.2.Final, compiler: javac, environment: Java 1.8.0_392 (Amazon.com Inc.)"
)
public class SubjectPracticeDTOConverterImpl implements SubjectPracticeDTOConverter {

    @Override
    public PracticeSubmitBO PracticeDTOtoBO(PracticeSubmitDTO practiceSubmitDTO) {
        if ( practiceSubmitDTO == null ) {
            return null;
        }

        PracticeSubmitBO practiceSubmitBO = new PracticeSubmitBO();

        practiceSubmitBO.setQuestionCount( practiceSubmitDTO.getQuestionCount() );
        practiceSubmitBO.setCorrectCount( practiceSubmitDTO.getCorrectCount() );
        practiceSubmitBO.setUseTime( practiceSubmitDTO.getUseTime() );
        practiceSubmitBO.setAnswers( answerResultListToAnswerResultList( practiceSubmitDTO.getAnswers() ) );

        return practiceSubmitBO;
    }

    @Override
    public RankBO practiceRankDTOtoBO(RankDTO rankDTO) {
        if ( rankDTO == null ) {
            return null;
        }

        RankBO rankBO = new RankBO();

        rankBO.setAvatar( rankDTO.getAvatar() );
        rankBO.setName( rankDTO.getName() );
        rankBO.setCount( rankDTO.getCount() );

        return rankBO;
    }

    @Override
    public List<RankDTO> practiceRankBOsToDTOs(List<RankBO> rankBOs) {
        if ( rankBOs == null ) {
            return null;
        }

        List<RankDTO> list = new ArrayList<RankDTO>( rankBOs.size() );
        for ( RankBO rankBO : rankBOs ) {
            list.add( rankBOToRankDTO( rankBO ) );
        }

        return list;
    }

    protected com.jingdianjichi.subject.domain.entity.AnswerResult answerResultToAnswerResult(AnswerResult answerResult) {
        if ( answerResult == null ) {
            return null;
        }

        com.jingdianjichi.subject.domain.entity.AnswerResult answerResult1 = new com.jingdianjichi.subject.domain.entity.AnswerResult();

        answerResult1.setSubjectId( answerResult.getSubjectId() );
        answerResult1.setSubjectType( answerResult.getSubjectType() );
        answerResult1.setIsCorrect( answerResult.getIsCorrect() );

        return answerResult1;
    }

    protected List<com.jingdianjichi.subject.domain.entity.AnswerResult> answerResultListToAnswerResultList(List<AnswerResult> list) {
        if ( list == null ) {
            return null;
        }

        List<com.jingdianjichi.subject.domain.entity.AnswerResult> list1 = new ArrayList<com.jingdianjichi.subject.domain.entity.AnswerResult>( list.size() );
        for ( AnswerResult answerResult : list ) {
            list1.add( answerResultToAnswerResult( answerResult ) );
        }

        return list1;
    }

    protected RankDTO rankBOToRankDTO(RankBO rankBO) {
        if ( rankBO == null ) {
            return null;
        }

        RankDTO rankDTO = new RankDTO();

        rankDTO.setAvatar( rankBO.getAvatar() );
        rankDTO.setName( rankBO.getName() );
        rankDTO.setCount( rankBO.getCount() );

        return rankDTO;
    }
}
