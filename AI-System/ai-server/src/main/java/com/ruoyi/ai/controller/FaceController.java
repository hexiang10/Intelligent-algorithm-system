package com.ruoyi.ai.controller;

import com.ruoyi.ai.domain.ObjectDetectionResult;
import com.ruoyi.ai.service.FaceService;
import com.ruoyi.ai.utils.AIUtil;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.StringUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.binary.Base64;
import org.bytedeco.opencv.opencv_core.Mat;
import org.bytedeco.opencv.opencv_core.MatVector;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.PostConstruct;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.bytedeco.opencv.global.opencv_imgcodecs.imread;

/**
 * @author: hexiang
 * @date: 2022/5/4
 * @description:
 */

@RestController
@Slf4j
@RequestMapping("/face")
public class FaceController {


    @PostConstruct
    private void init() {
        FaceService.init();
    }

    /**
     * 显示单张图片
     *
     * @return
     */
    @RequestMapping("/show")
    public AjaxResult showPhotos(@RequestBody HashMap<String, Object> map) {

        String fileName = (String) map.get("fileName");
        // 读取文件到Mat
        Mat src = imread(fileName);

        // 执行推理
        MatVector outs = FaceService.doPredict(src);

        // 处理原始的推理结果，
        // 对检测到的每个目标，找出置信度最高的类别作为改目标的类别，
        // 还要找出每个目标的位置，这些信息都保存在ObjectDetectionResult对象中
        List<ObjectDetectionResult> results = FaceService.postprocess(src, outs);

        // 释放资源
        outs.releaseReference();

        // 检测到的目标总数
        int detectNum = results.size();

        log.info("一共检测到{}个目标", detectNum);

        // 没检测到
        if (detectNum < 1) {
            return AjaxResult.error("error", "未检测到目标");
        } else {
            // 检测结果页面的提示信息
            map.put("target", "检测到" + results.size() + "个目标");
        }

        // 计算出总耗时，并输出在图片的左上角
        FaceService.printTimeUsed(src);

        // 将每一个被识别的对象在图片框出来，并在框的左上角标注该对象的类别
        FaceService.markEveryDetectObject(src, results, map);

        log.info("map=>"+ map);
        // 将添加了标注的图片保持在磁盘上，并将图片信息写入map（给跳转页面使用）
        String outputName = FaceService.saveMarkedImage(src);

        log.info("生成文件的路径为=>" + outputName);

        if (StringUtils.isNull(outputName) || StringUtils.isEmpty(outputName)) {
            return AjaxResult.error("error", "图片识别失败");
        }
            map.put("photo",AIUtil.getPhotoBase64(outputName));
            return AjaxResult.success("识别成功", map);

        }
}


