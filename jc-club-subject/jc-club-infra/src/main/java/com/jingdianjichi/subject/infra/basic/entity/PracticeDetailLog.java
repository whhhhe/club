package com.jingdianjichi.subject.infra.basic.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
@TableName("practice_detail_log")
public class PracticeDetailLog implements Serializable {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long practiceId;

    private Long subjectId;

    private Integer subjectType;

    private Integer isCorrect;

    @TableField(fill = FieldFill.INSERT)
    private Date createdTime;

    private Integer isDeleted;
}
