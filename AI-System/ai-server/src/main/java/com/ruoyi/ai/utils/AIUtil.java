package com.ruoyi.ai.utils;

import com.ruoyi.ai.common.FastDFSFile;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.util.UUID;

/**
 * @author: hexiang
 * @date: 2022/5/4
 * @description:
 */

public class AIUtil {

    private static String fileName;
    public static String getFileName(){
        return fileName;
    }

    /**
     * 上传文件到指定目录
     * @param file 文件
     * @return
     */
    public static String upload(MultipartFile file ,String uploadName){

        fileName = UUID.randomUUID()+".png";

        //使用原文件名
        String path = Paths.get("build",uploadName).toAbsolutePath().toString() + "\\"+ fileName;

        File dest = new File(path);

        //判断文件父目录是否存在
        if(!dest.getParentFile().exists()){
            dest.getParentFile().mkdir();
        }
        try {
            //保存文件
            file.transferTo(dest);
            return path;
        } catch (IllegalStateException | IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return null;
        }
    }


    public String saveFile(MultipartFile multipartFile) {
        String[] fileAbsolutePath = {};
        String fileName = multipartFile.getOriginalFilename();
        assert fileName != null;
        String ext = fileName.substring(fileName.lastIndexOf(".") + 1);
        byte[] file_buff = null;
        InputStream input = null;
        try {
            input = multipartFile.getInputStream();
        } catch (IOException e) {
            e.printStackTrace();
        }
        if (input != null) {
            int len1 = 0;
            try {
                len1 = input.available();
            } catch (IOException e) {
                e.printStackTrace();
            }
            file_buff = new byte[len1];
            try {
                input.read(file_buff);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        try {
            assert input != null;
            input.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        FastDFSFile file = new FastDFSFile(fileName, file_buff, ext);
        fileAbsolutePath = FastDFSClientUtil.uploadFile(file);
        try {
            return FastDFSClientUtil.getTrackerUrl() + fileAbsolutePath[0] + "/" + fileAbsolutePath[1];
        } catch (Exception e) {
            e.printStackTrace();
            //log.error("upload file failed,please upload again!");
        }
        return null;
    }

}
