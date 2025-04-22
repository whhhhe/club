package com.jingdianjichi.circle.server.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ListToStringConversion {
    public static void main(String[] args) {
        // 原始的 List
        List<Integer> originalList = Arrays.asList(1, 2, 3, 4, 5);
        // 将 List 转换为字符串
        String listString = originalList.toString();

        System.out.println(listString);
        // 去除字符串两端的方括号
        listString = listString.substring(1, listString.length() - 1);
        // 根据逗号和空格分割字符串
        String[] elements = listString.split(", ");

        // 创建一个新的 List 并将分割后的元素添加进去
        List<Integer> newList = new ArrayList<>();
        for (String element : elements) {
            newList.add(Integer.parseInt(element));
        }

        System.out.println(newList);
    }
}