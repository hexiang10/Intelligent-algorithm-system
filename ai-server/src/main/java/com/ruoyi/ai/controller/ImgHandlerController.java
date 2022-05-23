package com.ruoyi.ai.controller;

import com.ruoyi.ai.utils.ImgHandlerUtil;
import com.ruoyi.common.core.domain.AjaxResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * @author: hexiang
 * @date: 2022/5/4
 * @description:
 */

@RestController
@Slf4j
@RequestMapping("/img/handler/")
public class ImgHandlerController {



    /**
     * 显示高斯模糊处理图片
     *
     */
    @RequestMapping("/gaussian")
    public AjaxResult showGaussian(@RequestBody Map<String, Object> map) {
        String fileName = (String) map.get("fileName");
        ImgHandlerUtil.getGaussian(map,fileName);
        if(map.containsKey("error")){
            return AjaxResult.error("error",map.get("error"));
        }

        return AjaxResult.success("处理成功！", map);

    }

    /**
     * 发现轮廓
     *
     */
    @RequestMapping("/contours")
    public AjaxResult showContours(@RequestBody Map<String, Object> map) {
        String fileName = (String) map.get("fileName");
        ImgHandlerUtil.findContours(map,fileName);
        if(map.containsKey("error")){
            return AjaxResult.error("error",map.get("error"));
        }
        return AjaxResult.success("处理成功！", map);

    }

    /**
     * 磨皮美颜
     *
     */
    @RequestMapping("/epf")
    public AjaxResult showEpf(@RequestBody Map<String, Object> map) {
        String fileName = (String) map.get("fileName");
        ImgHandlerUtil.getEPF(map,fileName);
        if(map.containsKey("error")){
            return AjaxResult.error("error",map.get("error"));
        }
        return AjaxResult.success("处理成功！", map);

    }

    /**
     * 磨皮美颜
     *
     */
    @RequestMapping("/canny")
    public AjaxResult showCanny(@RequestBody Map<String, Object> map) {
        String fileName = (String) map.get("fileName");
        ImgHandlerUtil.getCanny(map,fileName);
        if(map.containsKey("error")){
            return AjaxResult.error("error",map.get("error"));
        }
        return AjaxResult.success("处理成功！", map);

    }

    /**
     * 边缘分割
     *
     */
    @RequestMapping("/watershed")
    public AjaxResult showWaterShed(@RequestBody Map<String, Object> map) {
        String fileName = (String) map.get("fileName");
        ImgHandlerUtil.getWaterShed(map,fileName);
        if(map.containsKey("error")){
            return AjaxResult.error("error",map.get("error"));
        }
        return AjaxResult.success("处理成功！", map);

    }


}
