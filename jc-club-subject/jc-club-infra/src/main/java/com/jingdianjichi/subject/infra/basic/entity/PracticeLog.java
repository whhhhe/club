package com.jingdianjichi.subject.infra.basic.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
@TableName("practice_log")
public class PracticeLog implements Serializable {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String userId;

    private Integer questionCount;

    private Integer correctCount;

    private Integer useTime;

    @TableField(fill = FieldFill.INSERT)
    private Date createdTime;

    private Integer isDeleted;
}
