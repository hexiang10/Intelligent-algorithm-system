package com.ruoyi.ai.pwd.service;

import com.ruoyi.ai.pwd.domain.AiPwd;
import com.ruoyi.ai.pwd.domain.vo.AiPwdVo;
import com.ruoyi.ai.pwd.domain.bo.AiPwdBo;
import com.ruoyi.common.core.mybatisplus.core.IServicePlus;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.core.domain.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 密码管理Service接口
 *
 * @author 何翔
 * @date 2022-04-30
 */
public interface IAiPwdService extends IServicePlus<AiPwd, AiPwdVo> {
	/**
	 * 查询单个
	 * @return
	 */
	AiPwdVo queryById(Long id);

	/**
	 * 查询列表
	 */
    TableDataInfo<AiPwdVo> queryPageList(AiPwdBo bo, PageQuery pageQuery);

	/**
	 * 查询列表
	 */
	List<AiPwdVo> queryList(AiPwdBo bo);

	/**
	 * 根据新增业务对象插入密码管理
	 * @param bo 密码管理新增业务对象
	 * @return
	 */
	Boolean insertByBo(AiPwdBo bo);

	/**
	 * 根据编辑业务对象修改密码管理
	 * @param bo 密码管理编辑业务对象
	 * @return
	 */
	Boolean updateByBo(AiPwdBo bo);

	/**
	 * 校验并删除数据
	 * @param ids 主键集合
	 * @param isValid 是否校验,true-删除前校验,false-不校验
	 * @return
	 */
	Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
