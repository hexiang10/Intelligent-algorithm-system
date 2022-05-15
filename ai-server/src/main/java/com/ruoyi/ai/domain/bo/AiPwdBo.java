package com.ruoyi.ai.domain.bo;

import com.ruoyi.common.core.validate.AddGroup;
import com.ruoyi.common.core.validate.EditGroup;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import javax.validation.constraints.*;

import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 密码管理业务对象 ai_pwd
 *
 * @author 何翔
 * @date 2022-04-30
 */

@Data
@EqualsAndHashCode(callSuper = true)
@ApiModel("密码管理业务对象")
public class AiPwdBo extends BaseEntity {

    /**
     * 主键
     */
    @ApiModelProperty(value = "主键", required = true)
    @NotNull(message = "主键不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 原文
     */
    @ApiModelProperty(value = "原文", required = true)
    @NotBlank(message = "原文不能为空", groups = { AddGroup.class, EditGroup.class })
    private String text;

    /**
     * key键
     */
    @ApiModelProperty(value = "key键")
    private String keyWord;

    /**
     * 密文
     */
    @ApiModelProperty(value = "密文", required = true)
    @NotBlank(message = "密文不能为空", groups = { AddGroup.class, EditGroup.class })
    private String ciphertext;

    /**
     * 备注
     */
    @ApiModelProperty(value = "备注")
    private String remark;

    /**
     * 加密方式
     */
    @ApiModelProperty(value = "加密方式")
    private String encodeType;

}
