package com.ruoyi.ai.controller;

import com.ruoyi.ai.utils.AIUtil;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.StringUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.binary.Base64;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Map;
import java.util.UUID;

/**
 * @author: hexiang
 * @date: 2022/5/4
 * @description:
 */
@RestController
@Slf4j
public class UploadController {

    /**
     * @param file 要上传的文件
     * @return
     */
    @RequestMapping("image/fileUpload")
    public AjaxResult upload(@RequestParam("file") MultipartFile file, Map<String, Object> map) {
        // 打印文件信息
        log.info("文件 [{}], 大小 [{}]", file.getOriginalFilename(), file.getSize());
        // 得到上传文件的路径
        String uploadPath = AIUtil.upload(file,"upload");
        // 打印文件路径信息
        log.info("文件上传的路径为=>" + uploadPath);
        // 路径为空，上传失败
        if (StringUtils.isNull(uploadPath)) {
            return AjaxResult.error("error", "图片上传失败");
        }
        map.put("uploadPath",uploadPath);
        map.put("photo",AIUtil.getPhotoBase64(uploadPath));
        return AjaxResult.success("图片上传成功",map);
    }


}
