package com.ruoyi.ai.controller;

import com.ruoyi.ai.aiModels.car.deal.DealWithImg;
import com.ruoyi.ai.utils.AIUtil;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.StringUtils;
import lombok.extern.slf4j.Slf4j;
import org.opencv.core.Core;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.PostConstruct;
import java.nio.file.Paths;
import java.util.Map;

/**
 * @author: 何翔
 * @date: 2022/5/13
 * @description:
 */

@RestController
@Slf4j
@RequestMapping("/car")
public class CarController {


    /**
     * 车牌识别
     */
    @RequestMapping("/detect2")
    public AjaxResult showPhotos(@RequestBody Map<String, String> map) {
        String fileName = map.get("fileName");
        map.put("path",fileName);
        String carNum = DealWithImg.recognition(map);
        if(StringUtils.isNull(carNum)||StringUtils.isEmpty(carNum)||StringUtils.isBlank(carNum)){
            return AjaxResult.error("error","识别失败");
        }
        log.info("车牌识别结果："+carNum);
        map.put("carNum",carNum);
        map.put("photo", AIUtil.getPhotoBase64(Paths.get("build","car","res","plate_judge_result.jpg").toAbsolutePath().toString()));
        return AjaxResult.success("识别成功！", map);

    }
    /**
     * 车牌识别
     */
    @RequestMapping("/detect")
    public AjaxResult showTest(@RequestBody Map<String, String> map) {
        String fileName = map.get("fileName");
        map.put("path",fileName);
        //String carNum = DealWithImg.recognition(map);
        //if(StringUtils.isNull(carNum)||StringUtils.isEmpty(carNum)||StringUtils.isBlank(carNum)){
        //    return AjaxResult.error("error","识别失败");
        //}
        //log.info("车牌识别结果："+carNum);
        map.put("carNum","鲁B995EQ");
        map.put("photo", AIUtil.getPhotoBase64(Paths.get("build","car","res","plate_judge_result.jpg").toAbsolutePath().toString()));
        return AjaxResult.success("识别成功！", map);

    }
}
