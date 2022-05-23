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
     * <p>Title: Canny</p>
     * <p>Description:Canny边缘提取</p>
     */

   public static void getCanny(Map<String,Object> map ,String fileName){
        System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
        Mat src = Imgcodecs.imread(fileName);//输入图像
       if (src.empty()) {
           map.put("error","加载文件失败！");
       }
        //ImageUI ui = new ImageUI();
        //ui.imshow("OpenCV_23_Input", src);

        //使用OpenCV Canny API用法一
		/*//1.高斯模糊
		Mat dst = new Mat();
		Imgproc.GaussianBlur(src, dst, new Size(3, 3), 0);
		//2.灰度处理
		Mat gray = new Mat();
		Imgproc.cvtColor(dst, gray, Imgproc.COLOR_BGR2GRAY);
		//3.边缘提取
		Mat output = new Mat();
		Imgproc.Canny(gray, output, 50, 150, 3, true);
		ImageUI out = new ImageUI();
		out.imshow("OpenCV_Canny_Output", output);*/

        //使用OpenCV Canny API用法二
        Mat dst = new Mat();
        Imgproc.GaussianBlur(src, dst, new Size(3, 3), 0);

        Mat gray = new Mat();
        Imgproc.cvtColor(dst, gray, Imgproc.COLOR_BGR2GRAY);

        Mat xgrad = new Mat();
        Imgproc.Sobel(gray, xgrad, CvType.CV_16S, 1, 0);

        Mat ygrad = new Mat();
        Imgproc.Sobel(gray, ygrad, CvType.CV_16S, 0, 1);
        //边缘提取
        Mat output = new Mat();
        Imgproc.Canny(xgrad, ygrad, output, 50, 150);

        //让提取边缘结果变彩色
        Mat edges = new Mat();
        src.copyTo(edges, output);

        //ImageUI out = new ImageUI();
        //out.imshow("OpenCV_Canny_Output", edges);
        map.put("canny",new ImageUI().imshow(edges));

        //使用OpenCV Canny API用法三
		/*Mat dst = new Mat();
		Imgproc.GaussianBlur(src, dst, new Size(3, 3), 0);

		Mat output = new Mat();
		Imgproc.Canny(dst, output, 50, 150);
		ImageUI out = new ImageUI();
		out.imshow("OpenCV_Canny_Output", output);*/
    }


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
        //ImageUI ui = new ImageUI();
        //ui.imshow("OpenCV_9_Input", src);
        //双边模糊
        Mat dst = new Mat();
        //双边滤波
        Imgproc.bilateralFilter(src, dst, 0, 100, 15);
        //ImageUI out = new ImageUI();
        //out.imshow("OpenCV_bilateralFilter_OutPut", dst);
        map.put("bilateralFilter",new ImageUI().imshow(dst));

        //均值迁移
        dst = new Mat();
        Imgproc.pyrMeanShiftFiltering(src, dst, 10, 50);
        //out = new ImageUI();
        //out.imshow("OpenCV_pyrMeanShift_OutPut", dst);
        map.put("pyrMeanShift",new ImageUI().imshow(dst));
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

    /**
     *
     * <p>Title: WaterShed</p>
     * <p>Description:分水岭算法</p>
     */
    public static void getWaterShed(Map<String,Object> map ,String fileName) {
        System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
        //1、输入图像
        Mat src = Imgcodecs.imread(fileName);
        if (src.empty()) {
            map.put("error","加载文件失败！");
        }
        //ImageUI ui = new ImageUI();
        //ui.imshow("原始图像", src);
        //去背景颜色---黑色背景颜色就不用去背景
        int width = src.cols();
        int heght = src.rows();
        int dims = src.channels();
        byte[] data = new byte[width * heght * dims];
        src.get(0, 0, data);
        int index = 0;
        int r = 0, g = 0, b = 0;
        for (int row = 0; row < heght; row++) {
            for (int col = 0; col < width; col++) {
                index = row * width * dims + col * dims;
                b = data[index]&0xff;
                g = data[index + 1]&0xff;
                r = data[index + 2]&0xff;
                //把白色背景变为黑色
                if (b == 255 && g ==255 && r == 255) {
                    data[index] = (byte)0;
                    data[index + 1] = (byte)0;
                    data[index + 2] = (byte)0;
                }
            }
        }
        src.put(0, 0, data);
        //ImageUI background = new ImageUI();
        //background.imshow("去背景", src);

        //2、灰度
        Mat gray = new Mat();
        Imgproc.cvtColor(src, gray, Imgproc.COLOR_BGR2GRAY);
        //ImageUI ui_gray = new ImageUI();
        //ui_gray.imshow("灰度图像", gray);

        //3、二值图像
        Mat binary = new Mat();
        //自动阈值二值化
        Imgproc.threshold(gray, binary, 0, 255, Imgproc.THRESH_BINARY | Imgproc.THRESH_OTSU);
        //ImageUI ui_binary = new ImageUI();
        //ui_binary.imshow("二值化图像", binary);

        //4、距离变换
        Mat dist = new Mat();
        Imgproc.distanceTransform(binary, dist, Imgproc.DIST_L2, 3);
        Core.normalize(dist, dist, 0, 255, Core.NORM_MINMAX);
        Mat dist_8u = new Mat();
        //转换为彩色图像
        dist.convertTo(dist_8u, CvType.CV_8U);
        //ImageUI ui_dist = new ImageUI();
        //ui_dist.imshow("距离变换后的图像", dist_8u);

        //5、寻找种子
        //二值化,去除尖锐边角和噪声(0.4~1.0)*255范围进行二值化
        Imgproc.threshold(dist, dist, 102, 255, Imgproc.THRESH_BINARY);
        //形态学操作
        Mat erode = new Mat();
        //获得腐蚀算子，不同的输入图像，要调整Size()函数的值
        Mat kernel = Imgproc.getStructuringElement(Imgproc.MORPH_RECT, new Size(13, 13));
        //腐蚀
        Imgproc.erode(dist, erode, kernel);
        Mat erode_8u = new Mat();
        erode.convertTo(erode_8u, CvType.CV_8U);
        //ImageUI ui_erode = new ImageUI();
        //ui_erode.imshow("腐蚀后的图像", erode_8u);

        //6、生成Marker
        //轮廓查找
        List<MatOfPoint> contours = new ArrayList<MatOfPoint>();
        Mat hierarchy = new Mat();
        Imgproc.findContours(erode_8u, contours, hierarchy, Imgproc.RETR_EXTERNAL, Imgproc.CHAIN_APPROX_SIMPLE, new Point(0, 0));
        Mat markers = Mat.zeros(dist.size(), CvType.CV_32SC1);
        //随机颜色数组
        Scalar[] colors = new Scalar[contours.size()];
        Random random = new Random();
        for (int i = 0; i < contours.size(); i++) {
            //把Marker绘制上
            Imgproc.drawContours(markers, contours, i, new Scalar(i+1), -1);
            colors[i] = new Scalar(random.nextInt(255), random.nextInt(255), random.nextInt(255));
        }
        Imgproc.circle(markers, new Point(5, 5), 3, new Scalar(255), -1);

        //7、分水岭变换
        Imgproc.watershed(src, markers);
        //显示结果
        Mat mark = Mat.zeros(markers.size(), CvType.CV_8UC1);
        markers.convertTo(mark, CvType.CV_8U);
        Core.bitwise_not(mark, mark);
        //ImageUI out = new ImageUI();
        //out.imshow("分水岭变换", mark);

        //填色
        Mat dst = new Mat(src.size(), CvType.CV_8UC3);
        int[] idxv = new int[1];
        for (int row = 0; row < markers.rows(); row++) {
            for (int col = 0; col < markers.cols(); col++) {
                markers.get(row, col, idxv);
                if (idxv[0] > 0 && idxv[0] <= contours.size()) {
                    double[] rgb = colors[idxv[0] - 1].val;
                    dst.put(row, col, new byte[]{(byte)rgb[0], (byte)rgb[1], (byte)rgb[2]});
                } else {
                    dst.put(row, col, new byte[]{(byte)0, (byte)0, (byte)0});
                }
            }
        }
        //ImageUI fout = new ImageUI();
        //fout.imshow("分割边缘的图像", dst);
        map.put("watershed", new ImageUI().imshow(dst));
    }

}
