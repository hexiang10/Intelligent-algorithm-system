package com.ruoyi.ai.utils;

import com.ruoyi.ai.common.FastDFSFile;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.binary.Base64;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;
import java.nio.file.Paths;

/**
 * @author: hexiang
 * @date: 2022/5/4
 * @description:
 */

@Slf4j
public class AIUtil {

    private static String fileName;
    public static String getFileName(){
        return fileName;
    }

    //path 为图片在服务器的绝对路径
    public static String getPhotoBase64(String path) {
        try {
            File file = new File(path);
            FileInputStream fis;
            fis = new FileInputStream(file);
            long size = file.length();
            log.info("文件大小=>" + size);
            byte[] temp = new byte[(int) size];
            fis.read(temp, 0, (int) size);
            fis.close();
            return new String(Base64.encodeBase64(temp));
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    //path 为图片在服务器的绝对路径
    public static String getPhotoBase64(File file) {
        try {
            FileInputStream fis;
            fis = new FileInputStream(file);
            long size = file.length();
            log.info("文件大小=>" + size);
            byte[] temp = new byte[(int) size];
            fis.read(temp, 0, (int) size);
            fis.close();
            return new String(Base64.encodeBase64(temp));
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    //path 为图片在服务器的绝对路径
    public static String getPhotoBase64(BufferedImage bufferedImage) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();//io流
        try {
            ImageIO.write(bufferedImage, "png", baos);//写入流中
            byte[] bytes = baos.toByteArray();//转换成字节
            //BASE64Encoder encoder = new BASE64Encoder();
            //String png_base64 = encoder.encodeBuffer(bytes).trim();//转换成base64串
            //png_base64 = png_base64.replaceAll(" ", "").replaceAll(" ", "");
            //
            return new String(Base64.encodeBase64(bytes));
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }

    }
    /**
     * 上传文件到指定目录
     * @param file 文件
     * @return
     */
    public static String upload(MultipartFile file ,String uploadName){

        fileName = "upload.png";

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


}
