package com.ruoyi.ai.aiModels.idcard.core;

import static java.lang.StrictMath.abs;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.opencv.core.Core;
import org.opencv.core.CvType;
import org.opencv.core.Mat;
import org.opencv.core.MatOfFloat;
import org.opencv.core.MatOfInt;
import org.opencv.core.Rect;
import org.opencv.core.Size;
import org.opencv.imgproc.Imgproc;


public class Canny {

    public static  Mat  canny( Mat inImg ) {

        if ( inImg.empty()) {
            System.out.println("Please check the path of input image!");
            return null;
        }
    	Mat srcImg = new Mat();
    	 inImg.copyTo(srcImg);
        final int imgRows = srcImg.rows();
        final int imgCols = srcImg.cols();

        // Step1: Denoise
        Imgproc.GaussianBlur(srcImg, srcImg, new Size(3, 3), 0, Core.BORDER_DEFAULT);

        // Step2: Convert to gray
        Mat grayImg = Mat.zeros(imgRows, imgCols, CvType.CV_8UC1);
        if (srcImg.channels() == 3) {
            Imgproc.cvtColor(srcImg, grayImg, Imgproc.COLOR_BGR2GRAY);
        }
        Imgproc.medianBlur(grayImg, grayImg, 3);

        // Step3: Binary
        int maskRoiX = (int)(imgCols/12.0);
        int maskRoiY = (int)(imgRows/8.0);
        int maskRoiW = (int)(10/12.0*imgCols);
        int maskRoiH = (int)(6/8.0*imgRows);
        Rect maskRoi = new Rect(maskRoiX, maskRoiY, maskRoiW, maskRoiH);
        Mat maskSrc = new Mat(grayImg, maskRoi);


        Map<String, Double> paramMap = FindAdaptiveThreshold(maskSrc, 3, 0.80);
        double thCannyLow = paramMap.get("cannyLowTh");
        double thCannyHigh = paramMap.get("cannyHighTh");

        Mat maskImg = Mat.zeros(imgRows, imgCols, CvType.CV_8UC1);
        Imgproc.Canny(grayImg, maskImg, thCannyLow, thCannyHigh, 3, false);

        System.out.println("Canny threshold lowth = " + thCannyLow + "\thighth = " + thCannyHigh);
        return maskImg;
    }





    /**
     * Find thresholds for Canny detector.
     * @param src input image.
     * @param aperture_size the window size for Canny detector.
     * @param PercentOfPixelsNotEdges the precision of pixels which not belong to edge.
     * @return
     */
    public  static Map<String, Double> FindAdaptiveThreshold(Mat src, int aperture_size, double PercentOfPixelsNotEdges)
    {
        Mat dx = new Mat(src.rows(), src.cols(), CvType.CV_16SC1);
        Mat dy = new Mat(src.rows(), src.cols(), CvType.CV_16SC1);
        Imgproc.Sobel(src, dx, CvType.CV_16S, 1, 0, aperture_size, 1, 0, Core.BORDER_DEFAULT);
        Imgproc.Sobel(src, dy, CvType.CV_16S, 0, 1, aperture_size, 1, 0, Core.BORDER_DEFAULT);
       return  _FindApdaptiveThreshold(dx, dy, PercentOfPixelsNotEdges);
    }


    /**
     *  Find thresholds for Canny detector (core function).
     * @param dx gradient of x orientation.
     * @param dy gradient of y orientation.
     * @param PercentOfPixelsNotEdges the precision of pixels which not belong to edge.
     */
    private static Map<String,Double>  _FindApdaptiveThreshold(Mat dx, Mat dy, double PercentOfPixelsNotEdges)
    {
    	Map<String,Double> resultMap = new HashMap<String,Double>();

    	     double m_cannyLowTh;  /* !< the lower threshold for Canny. */
    	      double m_cannyHighTh; /* !< the higher threshold for Canyy. */

        int i, j;
        Size size = dx.size();
        Mat imge = Mat.zeros(size, CvType.CV_32FC1);
        // Compute the strong of edge and store the result in image
        double maxv = 0.0, data;
        for (i = 0; i < size.height; i++) {
            for (j = 0; j < size.width; j++) {
                data = abs(dx.get(i, j)[0]) + abs(dy.get(i, j)[0]);
                imge.put(i, j, data);
                maxv = maxv < data ? data : maxv;
            }
        }
        if (0.0 == maxv) {
            m_cannyLowTh = 0.0;
            m_cannyHighTh = 0.0;
            resultMap.put("cannyLowTh", m_cannyLowTh);
            resultMap.put("cannyHighTh", m_cannyHighTh);
            return resultMap;
        }

        // Compute histogram
        int histSize = 256;
        histSize = histSize > (int)maxv ? (int)maxv : histSize;
        MatOfInt hist_size = new MatOfInt(histSize);
        MatOfFloat ranges = new MatOfFloat(0, (float) maxv);
        MatOfInt channels = new MatOfInt(0);
        // Compute hist
        Mat hist = new Mat();
        List<Mat> images = new ArrayList<>();
        images.add(imge);
        Imgproc.calcHist(images.subList(0, 1), channels, new Mat(), hist, hist_size, ranges, false);

        double sum = 0.0;
        int icount = hist.rows();
        double total = size.height * size.width * PercentOfPixelsNotEdges;
        for (i = 0; i < icount; i++) {
            sum += hist.get(i, 0)[0];
            if (sum > total) {
                break;
            }
        }
        // Compute high and low threshold of Canny
        m_cannyLowTh = (i + 1) * maxv / histSize;
        if(0.0 == m_cannyLowTh) {
            m_cannyHighTh = 0.0;
        } else {
            m_cannyHighTh = 2.5 * m_cannyLowTh;
            if (m_cannyHighTh > 255.0) {
                m_cannyHighTh = 255.0;
            }
        }
        resultMap.put("cannyLowTh", m_cannyLowTh);
        resultMap.put("cannyHighTh", m_cannyHighTh);
        return resultMap;
    }
}
