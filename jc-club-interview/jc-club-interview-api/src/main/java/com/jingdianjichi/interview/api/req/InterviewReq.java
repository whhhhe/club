package com.jingdianjichi.interview.api.req;

import com.jingdianjichi.interview.api.enums.EngineEnum;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;


@Getter
@Setter
public class InterviewReq implements Serializable {

    private String url;

    private String engine = EngineEnum.ALI_BL.name();

}
