package com.jingdianjichi.subject.domain.convert;

import com.jingdianjichi.subject.domain.entity.PracticeSubmitBO;
import com.jingdianjichi.subject.domain.entity.RankBO;
import com.jingdianjichi.subject.infra.basic.entity.PracticeLog;
import com.jingdianjichi.subject.infra.basic.entity.Rank;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Generated;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2025-04-18T17:03:52+0800",
    comments = "version: 1.4.2.Final, compiler: javac, environment: Java 1.8.0_392 (Amazon.com Inc.)"
)
public class SubjectPracticeConverterImpl implements SubjectPracticeConverter {

    @Override
    public PracticeLog converterBOtoEntity(PracticeSubmitBO practiceSubmitBO) {
        if ( practiceSubmitBO == null ) {
            return null;
        }

        PracticeLog practiceLog = new PracticeLog();

        practiceLog.setQuestionCount( practiceSubmitBO.getQuestionCount() );
        practiceLog.setCorrectCount( practiceSubmitBO.getCorrectCount() );
        practiceLog.setUseTime( practiceSubmitBO.getUseTime() );

        return practiceLog;
    }

    @Override
    public List<RankBO> converterRanksToBOs(List<Rank> ranks) {
        if ( ranks == null ) {
            return null;
        }

        List<RankBO> list = new ArrayList<RankBO>( ranks.size() );
        for ( Rank rank : ranks ) {
            list.add( rankToRankBO( rank ) );
        }

        return list;
    }

    protected RankBO rankToRankBO(Rank rank) {
        if ( rank == null ) {
            return null;
        }

        RankBO rankBO = new RankBO();

        rankBO.setAvatar( rank.getAvatar() );
        rankBO.setName( rank.getName() );
        rankBO.setCount( rank.getCount() );

        return rankBO;
    }
}
