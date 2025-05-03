package com.jingdianjichi.subject.infra.basic.entity;

import lombok.Data;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @Author: zmy
 * @Date: 2025年04月30日 20:18
 */
@Data
public class SubjectJobLabel {
    private Long labelId;

    // 数据库中是用逗号拼接的字符串
    private String subjectIdList;

    // 实际要返回的列表（由上面的字段转换而来）
    private Set<Long> subjectIdSet;

    public void convertStrToList() {
        if (subjectIdList != null && !subjectIdList.isEmpty()) {
            subjectIdSet = Arrays.stream(subjectIdList.split(","))
                    .map(Long::parseLong)
                    .collect(Collectors.toSet());
        } else {
            subjectIdSet = new HashSet<>();
        }
    }
}
