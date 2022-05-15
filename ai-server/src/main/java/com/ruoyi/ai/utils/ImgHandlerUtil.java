package com.ruoyi.ai.utils;

import com.ruoyi.ai.aiModels.imgHandler.ImageUI;
import org.opencv.core.*;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;

import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

/**
 * @author: hexiang
 * @date: 2022/5/6
 * @description:
 */

public class ImgHandlerUtil {


    /**
     *
     * <p>Title: EPF</p>
     * <p>Description: 边缘保留滤波EPF</p>
     */
    public static void getEPF(Map<String,Object> map ,String fileName) {
        System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
        Mat src = Imgcodecs.imread(fileName);
        if (src.empty()) {
            map.put("error","加载文件失败！");
        }
        ImageUI ui = new ImageUI();
        ui.imshow("OpenCV_9_Input", src);
        //双边模糊
        Mat dst = new Mat();
        //双边滤波
        Imgproc.bilateralFilter(src, dst, 0, 100, 15);
        ImageUI out = new ImageUI();
        out.imshow("OpenCV_bilateralFilter_OutPut", dst);

        //均值迁移
        dst = new Mat();
        Imgproc.pyrMeanShiftFiltering(src, dst, 10, 50);
        out = new ImageUI();
        out.imshow("OpenCV_pyrMeanShift_OutPut", dst);
    }


    /**
     *
     * <p>Title: Gaussian</p>
     * <p>Description: 高斯模糊</p>
     */
    public static void getGaussian(Map<String,Object> map ,String fileName){
        System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
        org.opencv.core.Mat src = Imgcodecs.imread(fileName);
        if (src.empty()) {
            map.put("error","加载文件失败！");
        }
        int width = src.cols();
        int height = src.rows();
        int dims = src.channels();
        byte[] data = new byte[width * height * dims];
        src.get(0, 0, data);
        int r = 0, g = 0, b = 0;
        Random random = new Random();
        for (int row = 0; row < height; row++) {
            for (int col = 0; col < width; col++) {
                //高斯模糊加的值
                double rf = random.nextGaussian() * 30;
                double gf = random.nextGaussian() * 30;
                double bf = random.nextGaussian() * 30;

                b = data[row * width * dims + col * dims] & 0xff;
                g = data[row * width * dims + col * dims + 1] & 0xff;
                r = data[row * width * dims + col * dims + 2] & 0xff;
                b = clamp(b + bf);
                r = clamp(r + rf);
                g = clamp(g + gf);

                //加上高斯噪声
                data[row * width * dims + col * dims] = (byte)b;
                data[row * width * dims + col * dims + 1] = (byte)g;
                data[row * width * dims + col * dims + 2] =(byte)r;
            }
        }
        src.put(0, 0, data);
        map.put("Gaussian_Noise",new ImageUI().imshow(src));
        //高斯去噪
        Mat dst = new Mat();
        //高斯滤波，调整Size(5, 5)值
        Imgproc.GaussianBlur(src, dst, new Size(5, 5), 15);
        map.put("Gaussian_Blur",new ImageUI().imshow(dst));
    }
    /**
     * 把值控制在0~255之间
     * @param d
     * @return
     */
    public static int clamp(double d) {
        if (d > 255) {
            return 255;
        } else if (d < 0) {
            return 0;
        } else {
            return (int)d;
        }
    }

    /**
     *
     * <p>Title: FindContours</p>
     * <p>Description: 轮廓发现</p>
     */
    public static void findContours(Map<String,Object> map ,String fileName) {
        System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
        Mat src = Imgcodecs.imread(fileName);
        if (src.empty()) {
            map.put("error","加载文件失败！");
        }
        demoTwo(src,map);
        //ImageUI ui = new ImageUI();
        //ui.imshow("OpenCV_26_Input", src);
        //demoOne(src);
    }

    /**
     * 有阈值，复杂图像，比demoOne更精确
     * @param src
     */
    public static void demoTwo(Mat src, Map<String,Object> map) {
        Mat gray = new Mat();
        Imgproc.cvtColor(src, gray, Imgproc.COLOR_BGR2GRAY);
        //双边模糊
        Mat dst = new Mat();
        Imgproc.bilateralFilter(gray, dst, 0, 50, 5);
        //边缘提取
        Mat edges = new Mat();
        Imgproc.Canny(dst, edges, 30, 200);

        map.put("Binary",new ImageUI().imshow(edges));
        //ImageUI ui_binary = new ImageUI();
        //ui_binary.imshow("OpenCV_Binary_Two", edges);

        List<MatOfPoint> contours = new ArrayList<MatOfPoint>();
        Mat hierarchy = new Mat();
        Imgproc.findContours(edges, contours, hierarchy, Imgproc.RETR_EXTERNAL, Imgproc.CHAIN_APPROX_SIMPLE, new Point(0, 0));

        Mat result = src.clone();
        for (int i = 0; i < contours.size(); i++) {
            Imgproc.drawContours(result, contours, i, new Scalar(0, 0, 255), 2);
        }
        map.put("Contours",new ImageUI().imshow(result));
        //ImageUI out = new ImageUI();
        //out.imshow("OpenCV_Result_demoTwo", result);
    }

    /**
     * 无阈值，使用于简单图像
     * @param src
     */
    public static void demoOne(Mat src) {
        Mat gray = new Mat();
        Mat binary = new Mat();
        Imgproc.cvtColor(src, gray, Imgproc.COLOR_BGR2GRAY);
        //二值化
        Imgproc.threshold(gray, binary, 0, 255, Imgproc.THRESH_BINARY | Imgproc.THRESH_OTSU);

        ImageUI ui_binary = new ImageUI();
        ui_binary.imshow("OpenCV_Binary_One", binary);

        List<MatOfPoint> contours = new ArrayList<MatOfPoint>();
        Mat hierarchy = new Mat();
        Imgproc.findContours(binary, contours, hierarchy, Imgproc.RETR_EXTERNAL, Imgproc.CHAIN_APPROX_SIMPLE, new Point(0, 0));

        Mat result = src.clone();
        for (int i = 0; i < contours.size(); i++) {
            Imgproc.drawContours(result, contours, i, new Scalar(0, 255, 0), 2);
        }
        ImageUI out = new ImageUI();
        out.imshow("OpenCV_Result_demoOne", result);
    }

}
