package com.ruoyi.ai.face.service;

import com.ruoyi.ai.face.domain.ObjectDetectionResult;
import org.bytedeco.opencv.opencv_core.Mat;
import org.bytedeco.opencv.opencv_core.MatVector;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

/**
 * @author: hexiang
 * @date: 2022/5/3
 * @description:
 */

public interface YoloService {
    public String upload(MultipartFile file, String fileName);

    public void init();
    /**
     * 将每一个被识别的对象在图片框出来，并在框的左上角标注该对象的类别
     * @param src
     * @param results
     */
    public  void markEveryDetectObject(Mat src, List<ObjectDetectionResult> results,Map<String,Object> map) ;

    /**
     * 用神经网络执行推理
     * @param src
     * @return
     */
    public MatVector doPredict(Mat src);
    /**
     * 计算出总耗时，并输出在图片的左上角
     * @param src
     */
    public void printTimeUsed(Mat src) ;

    /**
     * 推理完成后的操作
     * @param frame
     * @param outs
     * @return
     */
    public List<ObjectDetectionResult> postprocess(Mat frame, MatVector outs);

    /**
     * 将添加了标注的图片保持在磁盘上，并将图片信息写入map（给跳转页面使用）
     * @param src
     */
    public String saveMarkedImage(Mat src) ;
}
