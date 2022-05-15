package com.ruoyi.ai.controller;

import com.ruoyi.ai.utils.MnistUtil;
import com.ruoyi.ai.utils.AIUtil;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.StringUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

@RestController
@Slf4j
@RequestMapping("/handwrite")
public class MnistController {



    public static String fileName;
    /**
     * @param file 要上传的文件
     * @return
     */
    @RequestMapping("fileUpload")
    public AjaxResult upload(@RequestParam("file") MultipartFile file, Map<String, Object> map) throws IOException {
        // 打印文件信息
        log.info("文件 [{}], 大小 [{}]", file.getOriginalFilename(), file.getSize());
        // 得到上传文件的路径
        String uploadPath = AIUtil.upload(file,"upload");
        // 打印文件路径信息
        log.info("文件上传的路径为=>" + uploadPath);
        // 路径为空，上传失败
        if (StringUtils.isNull(uploadPath)) {
            return AjaxResult.error("error", "上传失败");
        }
        int result = MnistUtil.inference(AIUtil.getFileName());
        log.info("识别结果=>"+result);
        return AjaxResult.success("识别成功", result);
    }


}

