package com.ruoyi.ai.pwd.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import java.io.Serializable;
import java.util.Date;
import java.math.BigDecimal;

import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 密码管理对象 ai_pwd
 *
 * @author 何翔
 * @date 2022-04-30
 */
@Data
@Accessors(chain = true)
@TableName("ai_pwd")
public class AiPwd extends BaseEntity {

    private static final long serialVersionUID=1L;

    /**
     * 主键
     */
    @TableId(value = "id")
    private Long id;
    /**
     * 原文
     */
    private String text;
    /**
     * key键
     */
    private String keyWord;
    /**
     * 密文
     */
    private String ciphertext;
    /**
     * 备注
     */
    private String remark;
    /**
     * 删除标志
     */
    @TableLogic
    private Long delFlag;
    /**
     * 用户id
     */
    private Long userId;

}
