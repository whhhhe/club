package com.jingdianjichi.subject.application.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * @Author: zmy
 * @Date: 2025年04月18日 11:04
 */
@Data
public class RankDTO implements Serializable {

    private String avatar;

    private String name;

    private Integer count;
}
