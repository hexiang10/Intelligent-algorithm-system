package com.ruoyi.ai.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.core.domain.PageQuery;
import org.springframework.stereotype.Service;
import com.ruoyi.common.core.mybatisplus.core.ServicePlusImpl;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.ruoyi.ai.domain.bo.AiPwdBo;
import com.ruoyi.ai.domain.vo.AiPwdVo;
import com.ruoyi.ai.domain.AiPwd;
import com.ruoyi.ai.mapper.AiPwdMapper;
import com.ruoyi.ai.service.IAiPwdService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 密码管理Service业务层处理
 *
 * @author 何翔
 * @date 2022-04-30
 */
@Service
public class AiPwdServiceImpl extends ServicePlusImpl<AiPwdMapper, AiPwd, AiPwdVo> implements IAiPwdService {

    @Override
    public AiPwdVo queryById(Long id){
        return getVoById(id);
    }

    @Override
    public TableDataInfo<AiPwdVo> queryPageList(AiPwdBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<AiPwd> lqw = buildQueryWrapper(bo);
        QueryWrapper<AiPwd> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id",SecurityUtils.getUserId());
        Page<AiPwdVo> result = pageVo(pageQuery.build(), queryWrapper);
        return TableDataInfo.build(result);
    }

    @Override
    public List<AiPwdVo> queryList(AiPwdBo bo) {
        LambdaQueryWrapper<AiPwd> lqw = buildQueryWrapper(bo);
        QueryWrapper<AiPwd> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id",SecurityUtils.getUserId());
        return listVo(queryWrapper);
    }

    private LambdaQueryWrapper<AiPwd> buildQueryWrapper(AiPwdBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<AiPwd> lqw = Wrappers.lambdaQuery();
        lqw.like(StringUtils.isNotBlank(bo.getText()), AiPwd::getText, bo.getText());
        lqw.like(StringUtils.isNotBlank(bo.getKeyWord()), AiPwd::getKeyWord, bo.getKeyWord());
        lqw.like(StringUtils.isNotBlank(bo.getCiphertext()), AiPwd::getCiphertext, bo.getCiphertext());
        lqw.like(StringUtils.isNotBlank(bo.getRemark()), AiPwd::getRemark, bo.getRemark());
        lqw.eq(bo.getCreateTime() != null, AiPwd::getCreateTime, bo.getCreateTime());
        return lqw;
    }

    @Override
    public Boolean insertByBo(AiPwdBo bo) {
        AiPwd add = BeanUtil.toBean(bo, AiPwd.class);
        add.setUserId(SecurityUtils.getUserId());
        System.out.println(add);
        validEntityBeforeSave(add);
        boolean flag = save(add);
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    @Override
    public Boolean updateByBo(AiPwdBo bo) {
        AiPwd update = BeanUtil.toBean(bo, AiPwd.class);
        validEntityBeforeSave(update);
        return updateById(update);
    }

    /**
     * 保存前的数据校验
     *
     * @param entity 实体类数据
     */
    private void validEntityBeforeSave(AiPwd entity){
        //TODO 做一些数据校验,如唯一约束
    }

    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if(isValid){
            //TODO 做一些业务上的校验,判断是否需要校验
        }
        return removeByIds(ids);
    }
}
