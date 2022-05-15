package com.ruoyi.ai.aiModels.car.core;


import com.ruoyi.ai.aiModels.car.deal.Convert;
import org.bytedeco.javacpp.BytePointer;
import org.bytedeco.javacpp.opencv_core;

import java.util.Vector;

import static com.ruoyi.ai.aiModels.car.core.CoreFunc.getPlateType;
import static org.bytedeco.javacpp.opencv_core.*;
import static org.bytedeco.javacpp.opencv_imgproc.*;


public class CharsSegment {



    public int charsSegment(final Mat in, Vector<Mat> result) {
        if (in.data().isNull())
            return -3;
        Mat threshold = new Mat();
        Mat grey_img = new Mat();
        cvtColor(in, grey_img, CV_RGB2GRAY);
        int w = in.cols();
        int h = in.rows();
        Mat temp = new Mat(in, new Rect((int) (w * 0.1), (int) (h * 0.1), (int) (w * 0.8), (int) (h * 0.8)));

        switch (getPlateType(temp, true)) {
        case BLUE:
            threshold(grey_img, threshold, 10, 255, CV_THRESH_OTSU + CV_THRESH_BINARY);
            break;
        case YELLOW:
            threshold(grey_img, threshold, 10, 255, CV_THRESH_OTSU + CV_THRESH_BINARY_INV);
            break;
        default:
            return -3;
        }
        Mat num = new Mat();
        threshold.copyTo(num);
        MatVector contours = new MatVector();
        findContours(num, contours, CV_RETR_EXTERNAL, CV_CHAIN_APPROX_NONE);
        Vector<Rect> rect = new Vector<Rect>();
        for (int i = 0; i < contours.size(); ++i) {
            Rect mr = boundingRect(contours.get(i));
            if (verifySizes(new Mat(threshold, mr)))
                rect.add(mr);
        }
        if (rect.size() == 0)
            return -3;
        Vector<Rect> sortedRect = new Vector<Rect>();
        SortRect(rect, sortedRect);
        int specIndex = GetSpecificRect(sortedRect);
        Rect chineseRect = new Rect();
        if (specIndex < sortedRect.size())
            chineseRect = GetChineseRect(sortedRect.get(specIndex));
        else
            return -3;
        Vector<Rect> newSortedRect = new Vector<Rect>();
        newSortedRect.add(chineseRect);
        RebuildRect(sortedRect, newSortedRect, specIndex);

        if (newSortedRect.size() == 0)
            return -3;
        for (int i = 0; i < newSortedRect.size(); i++) {
            Rect mr = newSortedRect.get(i);
            Mat auxRoi = new Mat(threshold, mr);
            auxRoi = preprocessChar(auxRoi);
            result.add(auxRoi);
        }
        return 0;
    }

    /**
     * 字符尺寸验证
     *
     * @param r
     * @return
     */
    private Boolean verifySizes(Mat r) {
        float aspect = 45.0f / 90.0f;
        float charAspect = (float) r.cols() / (float) r.rows();
        float error = 0.7f;
        float minHeight = 10f;
        float maxHeight = 35f;
        // We have a different aspect ratio for number 1, and it can be ~0.2
        float minAspect = 0.05f;
        float maxAspect = aspect + aspect * error;
        // area of pixels
        float area = countNonZero(r);
        // bb area
        float bbArea = r.cols() * r.rows();
        // % of pixel in area
        float percPixels = area / bbArea;

        return percPixels <= 1 && charAspect > minAspect && charAspect < maxAspect && r.rows() >= minHeight
                && r.rows() < maxHeight;
    }

    /**
     * 字符预处理: 统一每个字符的大小
     *
     * @param in
     * @return
     */
    private Mat preprocessChar(Mat in) {
        int h = in.rows();
        int w = in.cols();
        int charSize = CHAR_SIZE;
        Mat transformMat = Mat.eye(2, 3, CV_32F).asMat();
        int m = Math.max(w, h);
        transformMat.ptr(0, 2).put(Convert.getBytes(((m - w) / 2f)));
        transformMat.ptr(1, 2).put(Convert.getBytes((m - h) / 2f));

        Mat warpImage = new Mat(m, m, in.type());

        warpAffine(in, warpImage, transformMat, warpImage.size(), INTER_LINEAR, opencv_core.BORDER_CONSTANT, new Scalar(0));

        Mat out = new Mat();
        resize(warpImage, out, new Size(charSize, charSize));

        return out;
    }

    /**
     * 去除车牌上方的钮钉
     * <p>
     * 计算每行元素的阶跃数，如果小于X认为是柳丁，将此行全部填0（涂黑）， X可根据实际调整
     *
     * @param img
     * @return
     */
    private Mat clearLiuDing(Mat img) {
        final int x = this.liuDingSize;

        Mat jump = Mat.zeros(1, img.rows(), CV_32F).asMat();
    	CoreFunc.showImage("test", jump);

        System.err.println("图像总行数："+img.rows());
        for (int i = 0; i < img.rows(); i++) {
            int jumpCount = 0;
            for (int j = 0; j < img.cols() - 1; j++) {
                if (img.ptr(i, j).get() != img.ptr(i, j + 1).get())
                    jumpCount++;
            }
            System.err.println("总数："+jumpCount);
            System.err.println("第"+i+"行");
            byte[] bt=Convert.getBytes((float) jumpCount);
            System.err.println("test:"+bt.length);
            //指定矩阵行的指针
            BytePointer bp= jump.ptr(i);
//            CoreFunc.showImage("test", jump);
//
            bp.put(bt);
            System.err.println("test:end");
        }

        for (int i = 0; i < img.rows(); i++) {
            if (Convert.toFloat(jump.ptr(i)) <= x) {
                for (int j = 0; j < img.cols(); j++) {
                    img.ptr(i, j).put((byte) 0);
                }
            }
        }
        return img;
    }

    /**
     * 根据特殊车牌来构造猜测中文字符的位置和大小
     *
     * @param rectSpe
     * @return
     */
    private Rect GetChineseRect(final Rect rectSpe) {
        int height = rectSpe.height();
        float newwidth = rectSpe.width() * 1.15f;
        int x = rectSpe.x();
        int y = rectSpe.y();

        int newx = x - (int) (newwidth * 1.15);
        newx = Math.max(newx, 0);
        Rect a = new Rect(newx, y, (int) newwidth, height);
        return a;
    }

    /**
     * 找出指示城市的字符的Rect，例如苏A7003X，就是A的位置
     *
     * @param vecRect
     * @return
     */
    private int GetSpecificRect(final Vector<Rect> vecRect) {
        Vector<Integer> xpositions = new Vector<Integer>();
        int maxHeight = 0;
        int maxWidth = 0;
        for (int i = 0; i < vecRect.size(); i++) {
            xpositions.add(vecRect.get(i).x());

            if (vecRect.get(i).height() > maxHeight) {
                maxHeight = vecRect.get(i).height();
            }
            if (vecRect.get(i).width() > maxWidth) {
                maxWidth = vecRect.get(i).width();
            }
        }

        int specIndex = 0;
        for (int i = 0; i < vecRect.size(); i++) {
            Rect mr = vecRect.get(i);
            int midx = mr.x() + mr.width() / 2;

            // 如果一个字符有一定的大小，并且在整个车牌的1/7到2/7之间，则是我们要找的特殊车牌
            if ((mr.width() > maxWidth * 0.8 || mr.height() > maxHeight * 0.8)
                    && (midx < this.theMatWidth * 2 / 7 && midx > this.theMatWidth / 7)) {
                specIndex = i;
            }
        }

        return specIndex;
    }

    /**
     * 这个函数做两个事情
     * <ul>
     * <li>把特殊字符Rect左边的全部Rect去掉，后面再重建中文字符的位置;
     * <li>从特殊字符Rect开始，依次选择6个Rect，多余的舍去。
     * <ul>
     *
     * @param vecRect
     * @param outRect
     * @param specIndex
     * @return
     */
    private int RebuildRect(final Vector<Rect> vecRect, Vector<Rect> outRect, int specIndex) {
        // 最大只能有7个Rect,减去中文的就只有6个Rect
        int count = 6;
        for (int i = 0; i < vecRect.size(); i++) {
            // 将特殊字符左边的Rect去掉，这个可能会去掉中文Rect，不过没关系，我们后面会重建。
            if (i < specIndex)
                continue;

            outRect.add(vecRect.get(i));
            if (--count == 0)
                break;
        }

        return 0;
    }

    /**
     * 将Rect按位置从左到右进行排序
     *
     * @param vecRect
     * @param out
     * @return
     */
    private void SortRect(final Vector<Rect> vecRect, Vector<Rect> out) {
        Vector<Integer> orderIndex = new Vector<Integer>();
        Vector<Integer> xpositions = new Vector<Integer>();
        for (int i = 0; i < vecRect.size(); ++i) {
            orderIndex.add(i);
            xpositions.add(vecRect.get(i).x());
        }

        float min = xpositions.get(0);
        int minIdx;
        for (int i = 0; i < xpositions.size(); ++i) {
            min = xpositions.get(i);
            minIdx = i;
            for (int j = i; j < xpositions.size(); ++j) {
                if (xpositions.get(j) < min) {
                    min = xpositions.get(j);
                    minIdx = j;
                }
            }
            int aux_i = orderIndex.get(i);
            int aux_min = orderIndex.get(minIdx);
            orderIndex.remove(i);
            orderIndex.insertElementAt(aux_min, i);
            orderIndex.remove(minIdx);
            orderIndex.insertElementAt(aux_i, minIdx);

            float aux_xi = xpositions.get(i);
            float aux_xmin = xpositions.get(minIdx);
            xpositions.remove(i);
            xpositions.insertElementAt((int) aux_xmin, i);
            xpositions.remove(minIdx);
            xpositions.insertElementAt((int) aux_xi, minIdx);
        }

        for (int i = 0; i < orderIndex.size(); i++)
            out.add(vecRect.get(orderIndex.get(i)));

        return;
    }

    public void setLiuDingSize(int param) {
        this.liuDingSize = param;
    }

    public void setColorThreshold(int param) {
        this.colorThreshold = param;
    }

    public void setBluePercent(float param) {
        this.bluePercent = param;
    }

    public final float getBluePercent() {
        return this.bluePercent;
    }

    public void setWhitePercent(float param) {
        this.whitePercent = param;
    }

    public final float getWhitePercent() {
        return this.whitePercent;
    }

    public boolean getDebug() {
        return this.isDebug;
    }

    public void setDebug(boolean isDebug) {
        this.isDebug = isDebug;
    }

    // 是否开启调试模式常量，默认false代表关闭
    final static boolean DEFAULT_DEBUG = false;

    // preprocessChar所用常量
    final static int CHAR_SIZE = 20;
    final static int HORIZONTAL = 1;
    final static int VERTICAL = 0;

    final static int DEFAULT_LIUDING_SIZE = 7;
    final static int DEFAULT_MAT_WIDTH = 136;

    final static int DEFAULT_COLORTHRESHOLD = 150;
    final static float DEFAULT_BLUEPERCEMT = 0.3f;
    final static float DEFAULT_WHITEPERCEMT = 0.1f;

    private int liuDingSize = DEFAULT_LIUDING_SIZE;
    private int theMatWidth = DEFAULT_MAT_WIDTH;

    private int colorThreshold = DEFAULT_COLORTHRESHOLD;
    private float bluePercent = DEFAULT_BLUEPERCEMT;
    private float whitePercent = DEFAULT_WHITEPERCEMT;

    private boolean isDebug = DEFAULT_DEBUG;
}
