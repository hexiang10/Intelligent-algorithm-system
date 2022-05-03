package com.ruoyi.ai.face.service.impl;

import com.ruoyi.ai.face.domain.ObjectDetectionResult;
import com.ruoyi.ai.face.service.YoloService;
import lombok.extern.slf4j.Slf4j;
import org.bytedeco.javacpp.DoublePointer;
import org.bytedeco.javacpp.FloatPointer;
import org.bytedeco.javacpp.IntPointer;
import org.bytedeco.javacpp.indexer.FloatIndexer;
import org.bytedeco.opencv.global.opencv_dnn;
import org.bytedeco.opencv.opencv_core.*;
import org.bytedeco.opencv.opencv_dnn.Net;
import org.bytedeco.opencv.opencv_text.FloatVector;
import org.bytedeco.opencv.opencv_text.IntVector;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;

import static org.bytedeco.opencv.global.opencv_core.*;
import static org.bytedeco.opencv.global.opencv_dnn.*;
import static org.bytedeco.opencv.global.opencv_imgcodecs.imwrite;
import static org.bytedeco.opencv.global.opencv_imgproc.*;
import static org.opencv.imgproc.Imgproc.FONT_HERSHEY_SIMPLEX;

/**
 * @author: hexiang
 * @date: 2022/5/3
 * @description:
 */

@Service
@Slf4j
public class YoloServiceImpl implements YoloService {

    @Value("${web.upload-path}")
    private String uploadPath;

    @Value("${web.result-path}")
    private String resultPath;

    @Value("${opencv.yolo-cfg-path}")
    private String cfgPath;

    @Value("${opencv.yolo-weights-path}")
    private String weightsPath;

    @Value("${opencv.yolo-coconames-path}")
    private String namesPath;

    @Value("${opencv.yolo-width}")
    private int width;

    @Value("${opencv.yolo-height}")
    private int height;

    /**
     * 置信度门限（超过这个值才认为是可信的推理结果）
     */
    private float confidenceThreshold = 0.5f;

    private float nmsThreshold = 0.4f;

    // 神经网络
    private Net net;

    // 输出层
    private StringVector outNames;

    // 分类名称
    private List<String> names;

    public void init() {
        // 初始化打印一下，确保编码正常，否则日志输出会是乱码
        log.error("file.encoding is " + System.getProperty("file.encoding"));

        // 神经网络初始化
        net = readNetFromDarknet(cfgPath, weightsPath);

        // 检查网络是否为空
        if (net.empty()) {
            log.error("神经网络初始化失败");
            try {
                throw new Exception("神经网络初始化失败");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // 输出层
        outNames = net.getUnconnectedOutLayersNames();

        // 检查GPU
        if (getCudaEnabledDeviceCount() > 0) {
            net.setPreferableBackend(opencv_dnn.DNN_BACKEND_CUDA);
            net.setPreferableTarget(opencv_dnn.DNN_TARGET_CUDA);
        }

        // 分类名称
        try {
            names = Files.readAllLines(Paths.get(namesPath));
        } catch (IOException e) {
            log.error("获取分类名称失败，文件路径[{}]", namesPath, e);
        }
    }

    /**
     * 上传文件到指定目录
     * @param file 文件
     * @param fileName 源文件名
     * @return
     */
    public String upload(MultipartFile file,String fileName){
        //使用原文件名
        String path = uploadPath + "/"+UUID.randomUUID()+"-"+ fileName;

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

    /**
     * 将添加了标注的图片保持在磁盘上，并将图片信息写入map（给跳转页面使用）
     * @param src
     */
    public String saveMarkedImage( Mat src) {
        // 新的图片文件名称
        String newFileName = resultPath + "/" + UUID.randomUUID() + ".png";
        // 图片写到磁盘上
        imwrite(newFileName, src);

        return newFileName;
    }

    /**
     * 将每一个被识别的对象在图片框出来，并在框的左上角标注该对象的类别
     * @param src
     * @param results
     */
    public void markEveryDetectObject(Mat src, List<ObjectDetectionResult> results, Map<String,Object> map ) {
       StringBuilder stringBuffer = new StringBuilder();
        // 在图片上标出每个目标以及类别和置信度
        for(ObjectDetectionResult result : results) {
            log.info("类别[{}]，置信度[{}%]", result.getClassName(), result.getConfidence() * 100f);
            stringBuffer.append("【类别:").append(result.getClassName()).append(",置信度:").append(result.getConfidence() * 100f).append("%】");
            // annotate on image
            rectangle(src,
                new Point(result.getX(), result.getY()),
                new Point(result.getX() + result.getWidth(), result.getY() + result.getHeight()),
                Scalar.MAGENTA,
                1,
                LINE_8,
                0);

            // 写在目标左上角的内容：类别+置信度
            String label = result.getClassName() + ":" + String.format("%.2f%%", result.getConfidence() * 100f);

            // 计算显示这些内容所需的高度
            IntPointer baseLine = new IntPointer();

            Size labelSize = getTextSize(label, FONT_HERSHEY_SIMPLEX, 0.5, 1, baseLine);
            int top = Math.max(result.getY(), labelSize.height());

            // 添加内容到图片上
            putText(src, label, new Point(result.getX(), top-4), FONT_HERSHEY_SIMPLEX, 0.5, new Scalar(0, 255, 0, 0), 1, LINE_4, false);
        }

        map.put("results",stringBuffer.toString());

    }

    /**
     * 用神经网络执行推理
     * @param src
     * @return
     */
    public MatVector doPredict(Mat src) {
        // 将图片转为四维blog，并且对尺寸做调整
        Mat inputBlob = blobFromImage(src,
            1 / 255.0,
            new Size(width, height),
            new Scalar(0.0),
            true,
            false,
            CV_32F);

        // 神经网络输入
        net.setInput(inputBlob);

        // 设置输出结果保存的容器
        MatVector outs = new MatVector(outNames.size());

        // 推理，结果保存在outs中
        net.forward(outs, outNames);

        // 释放资源
        inputBlob.release();

        return outs;
    }

    /**
     * 计算出总耗时，并输出在图片的左上角
     * @param src
     */
    public void printTimeUsed(Mat src) {
        // 总次数
        long totalNums = net.getPerfProfile(new DoublePointer());
        // 频率
        double freq = getTickFrequency()/1000;
        // 总次数除以频率就是总耗时
        double t =  totalNums / freq;

        // 将本次检测的总耗时打印在展示图像的左上角
        putText(src,
            String.format("Inference time : %.2f ms", t),
            new Point(10, 20),
            FONT_HERSHEY_SIMPLEX,
            0.6,
            new Scalar(255, 0, 0, 0),
            1,
            LINE_AA,
            false);
    }

    /**
     * 推理完成后的操作
     * @param frame
     * @param outs
     * @return
     */
    public List<ObjectDetectionResult> postprocess(Mat frame, MatVector outs) {
        final IntVector classIds = new IntVector();
        final FloatVector confidences = new FloatVector();
        final RectVector boxes = new RectVector();

        // 处理神经网络的输出结果
        for (int i = 0; i < outs.size(); ++i) {
            // extract the bounding boxes that have a high enough score
            // and assign their highest confidence class prediction.

            // 每个检测到的物体，都有对应的每种类型的置信度，取最高的那种
            // 例如检车到猫的置信度百分之九十，狗的置信度百分之八十，那就认为是猫
            Mat result = outs.get(i);
            FloatIndexer data = result.createIndexer();

            // 将检测结果看做一个表格，
            // 每一行表示一个物体，
            // 前面四列表示这个物体的坐标，后面的每一列，表示这个物体在某个类别上的置信度，
            // 每行都是从第五列开始遍历，找到最大值以及对应的列号，
            for (int j = 0; j < result.rows(); j++) {
                // minMaxLoc implemented in java because it is 1D
                int maxIndex = -1;
                float maxScore = Float.MIN_VALUE;
                for (int k = 5; k < result.cols(); k++) {
                    float score = data.get(j, k);
                    if (score > maxScore) {
                        maxScore = score;
                        maxIndex = k - 5;
                    }
                }

                // 如果最大值大于之前设定的置信度门限，就表示可以确定是这类物体了，
                // 然后就把这个物体相关的识别信息保存下来，要保存的信息有：类别、置信度、坐标
                if (maxScore > confidenceThreshold) {
                    int centerX = (int) (data.get(j, 0) * frame.cols());
                    int centerY = (int) (data.get(j, 1) * frame.rows());
                    int width = (int) (data.get(j, 2) * frame.cols());
                    int height = (int) (data.get(j, 3) * frame.rows());
                    int left = centerX - width / 2;
                    int top = centerY - height / 2;

                    // 保存类别
                    classIds.push_back(maxIndex);
                    // 保存置信度
                    confidences.push_back(maxScore);
                    // 保存坐标
                    boxes.push_back(new Rect(left, top, width, height));
                }
            }

            // 资源释放
            data.release();
            result.release();
        }

        // remove overlapping bounding boxes with NMS
        IntPointer indices = new IntPointer(confidences.size());
        FloatPointer confidencesPointer = new FloatPointer(confidences.size());
        confidencesPointer.put(confidences.get());

        // 非极大值抑制
        NMSBoxes(boxes, confidencesPointer, confidenceThreshold, nmsThreshold, indices, 1.f, 0);

        // 将检测结果放入BO对象中，便于业务处理
        List<ObjectDetectionResult> detections = new ArrayList<>();
        for (int i = 0; i < indices.limit(); ++i) {
            final int idx = indices.get(i);
            final Rect box = boxes.get(idx);

            final int clsId = classIds.get(idx);

            detections.add(new ObjectDetectionResult(
                clsId,
                names.get(clsId),
                confidences.get(idx),
                box.x(),
                box.y(),
                box.width(),
                box.height()
            ));

            // 释放资源
            box.releaseReference();
        }

        // 释放资源
        indices.releaseReference();
        confidencesPointer.releaseReference();
        classIds.releaseReference();
        confidences.releaseReference();
        boxes.releaseReference();

        return detections;
    }
}
