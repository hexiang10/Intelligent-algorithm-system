package com.ruoyi.ai.face.controller;

import com.ruoyi.common.core.domain.AjaxResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 测试
 *
 * @author hexiang
 */
@Api(value = "物体识别处理", tags = {"物体识别处理"})
@RequiredArgsConstructor(onConstructor_ = @Autowired)
@RestController
public class QrObjController {

    /**
     * 测试
     */
    @ApiOperation("测试")
    @GetMapping("/ai/obj")
    public AjaxResult getCode() {

        return AjaxResult.success("ok","1231231");
    }


}
