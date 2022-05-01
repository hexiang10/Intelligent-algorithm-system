package com.ruoyi.ai.pwd.domain.vo;

import com.alibaba.excel.annotation.ExcelIgnoreUnannotated;
import com.alibaba.excel.annotation.ExcelProperty;
import com.ruoyi.common.annotation.ExcelDictFormat;
import com.ruoyi.common.convert.ExcelDictConvert;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import java.util.Date;



/**
 * 密码管理视图对象 ai_pwd
 *
 * @author 何翔
 * @date 2022-04-30
 */
@Data
@ApiModel("密码管理视图对象")
@ExcelIgnoreUnannotated
public class AiPwdVo {

	private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
	@ExcelProperty(value = "主键")
	@ApiModelProperty("主键")
	private Long id;

    /**
     * 原文
     */
	@ExcelProperty(value = "原文")
	@ApiModelProperty("原文")
	private String text;

    /**
     * key键
     */
	@ExcelProperty(value = "key键")
	@ApiModelProperty("key键")
	private String keyWord;

    /**
     * 密文
     */
	@ExcelProperty(value = "密文")
	@ApiModelProperty("密文")
	private String ciphertext;

    /**
     * 备注
     */
	@ExcelProperty(value = "备注")
	@ApiModelProperty("备注")
	private String remark;

    /**
     * 创建时间
     */
	@ExcelProperty(value = "创建时间")
	@ApiModelProperty("创建时间")
	private Date createTime;


}
