package com.ruoyi.ai.controller;

import com.ruoyi.ai.utils.IdCardCvUtil;
import com.ruoyi.common.core.domain.AjaxResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * @author: 何翔
 * @date: 2022/5/13
 * @description:
 */

@RestController
@Slf4j
@RequestMapping("/idcard")
public class IdCardController {

    /**
     * 车牌识别
     */
    @RequestMapping("/detect")
    public AjaxResult showTest(@RequestBody Map<String, Object> map) {
        String fileName = (String) map.get("fileName");
        IdCardCvUtil.getIdNum(map,fileName);
        if(map.containsKey("error")){
            return AjaxResult.error("error",map.get("error"));
        }
        return AjaxResult.success("识别成功！", map);

    }
}
