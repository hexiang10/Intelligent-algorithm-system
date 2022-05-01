package com.ruoyi.ai.pwd.controller;

import java.util.List;
import java.util.Arrays;
import java.util.concurrent.TimeUnit;

import lombok.RequiredArgsConstructor;
import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.*;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.validation.annotation.Validated;
import com.ruoyi.common.annotation.RepeatSubmit;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.PageQuery;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.validate.AddGroup;
import com.ruoyi.common.core.validate.EditGroup;
import com.ruoyi.common.core.validate.QueryGroup;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.ai.pwd.domain.vo.AiPwdVo;
import com.ruoyi.ai.pwd.domain.bo.AiPwdBo;
import com.ruoyi.ai.pwd.service.IAiPwdService;
import com.ruoyi.common.core.page.TableDataInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiParam;
import io.swagger.annotations.ApiOperation;

/**
 * 密码管理Controller
 *
 * @author 何翔
 * @date 2022-04-30
 */
@Validated
@Api(value = "密码管理控制器", tags = {"密码管理管理"})
@RequiredArgsConstructor(onConstructor_ = @Autowired)
@RestController
@RequestMapping("/ai/pwd")
public class AiPwdController extends BaseController {

    private final IAiPwdService iAiPwdService;

    /**
     * 查询密码管理列表
     */
    @ApiOperation("查询密码管理列表")
    @PreAuthorize("@ss.hasPermi('ai:pwd:list')")
    @GetMapping("/list")
    public TableDataInfo<AiPwdVo> list(@Validated(QueryGroup.class) AiPwdBo bo, PageQuery pageQuery) {
        return iAiPwdService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出密码管理列表
     */
    @ApiOperation("导出密码管理列表")
    @PreAuthorize("@ss.hasPermi('ai:pwd:export')")
    @Log(title = "密码管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(@Validated AiPwdBo bo, HttpServletResponse response) {
        List<AiPwdVo> list = iAiPwdService.queryList(bo);
        ExcelUtil.exportExcel(list, "密码管理", AiPwdVo.class, response);
    }

    /**
     * 获取密码管理详细信息
     */
    @ApiOperation("获取密码管理详细信息")
    @PreAuthorize("@ss.hasPermi('ai:pwd:query')")
    @GetMapping("/{id}")
    public AjaxResult<AiPwdVo> getInfo(@ApiParam("主键")
                                                  @NotNull(message = "主键不能为空")
                                                  @PathVariable("id") Long id) {
        return AjaxResult.success(iAiPwdService.queryById(id));
    }

    /**
     * 新增密码管理
     */
    @ApiOperation("新增密码管理")
    @PreAuthorize("@ss.hasPermi('ai:pwd:add')")
    @Log(title = "密码管理", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public AjaxResult<Void> add(@Validated(AddGroup.class) @RequestBody AiPwdBo bo) {
        return toAjax(iAiPwdService.insertByBo(bo) ? 1 : 0);
    }

    /**
     * 修改密码管理
     */
    @ApiOperation("修改密码管理")
    @PreAuthorize("@ss.hasPermi('ai:pwd:edit')")
    @Log(title = "密码管理", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public AjaxResult<Void> edit(@Validated(EditGroup.class) @RequestBody AiPwdBo bo) {
        return toAjax(iAiPwdService.updateByBo(bo) ? 1 : 0);
    }

    /**
     * 删除密码管理
     */
    @ApiOperation("删除密码管理")
    @PreAuthorize("@ss.hasPermi('ai:pwd:remove')")
    @Log(title = "密码管理" , businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult<Void> remove(@ApiParam("主键串")
                                       @NotEmpty(message = "主键不能为空")
                                       @PathVariable Long[] ids) {
        return toAjax(iAiPwdService.deleteWithValidByIds(Arrays.asList(ids), true) ? 1 : 0);
    }
}
