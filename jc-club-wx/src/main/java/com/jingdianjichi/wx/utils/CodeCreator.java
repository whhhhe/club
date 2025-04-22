package com.jingdianjichi.wx.utils;

import lombok.extern.slf4j.Slf4j;

import java.util.Random;

@Slf4j
public class CodeCreator {
    public static String getCode(){
        Random random = new Random();
        StringBuilder num = new StringBuilder();
        for(int i = 0; i < 6; i++){
            num.append(random.nextInt(10));
        }
        log.info("code:{}", num);
        return num.toString();
    }
}
