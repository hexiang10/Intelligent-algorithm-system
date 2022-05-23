package com.ruoyi.ai.utils;

import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Map;
import java.util.Vector;

import com.ruoyi.ai.aiModels.idcard.network.CHAR_SVM;
import com.ruoyi.ai.aiModels.idcard.core.IdCardCoreFunc;
import com.ruoyi.common.utils.StringUtils;
import org.opencv.core.Core;
import org.opencv.core.CvType;
import org.opencv.core.Mat;
import org.opencv.core.MatOfPoint;
import org.opencv.core.Rect;
import org.opencv.core.Scalar;
import org.opencv.core.Size;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;
import org.opencv.ml.SVM;



public class IdCardCvUtil {
   public static CHAR_SVM svmTrain;
   //public static String svmXml = "res/model/svm.xml";
   public static String svmXml = Paths.get("build","idcard","model","svm.xml").toAbsolutePath().toString();

   public static void getIdNum(Map<String, Object> map, String filename) {
       System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
       String text = IdCardCvUtil.getIdCardCode(filename);
       if(StringUtils.isEmpty(text)||StringUtils.isNull(text)){
           map.put("error", "识别失败");
           return;
       }
       map.put("idNum", text);
   }

	public static String getIdCardCode(String imagePath) {
		Mat rgbMat = Imgcodecs.imread(imagePath); // 原图
		Rect rect = detectTextArea(rgbMat);
		String text = getCharText(rgbMat, rect);
		return text;
	}

	private static String getCharText(Mat srcMat, Rect rect) {
		if (svmTrain == null) {
			svmTrain = new CHAR_SVM();
			SVM svm = SVM.load(svmXml);
			svmTrain.setSvm(svm);
		}
		Mat effective = new Mat(); // 身份证位置
		Mat charsGrayMat = new Mat();
		Mat hierarchy = new Mat();
		srcMat.copyTo(effective);
		Mat charsMat = new Mat(effective, rect);
		Imgproc.cvtColor(charsMat, charsGrayMat, Imgproc.COLOR_RGB2GRAY);// 灰度化
		Imgproc.GaussianBlur(charsGrayMat, charsGrayMat, new Size(3, 3), 0, 0, Core.BORDER_DEFAULT);
		double thresholdValue = IdCardCoreFunc.otsu(charsGrayMat) - 25;//减50是去掉文字周边燥点 阴影覆盖;
		Imgproc.threshold(charsGrayMat, charsGrayMat, thresholdValue, 255, Imgproc.THRESH_BINARY_INV);
		Imgproc.medianBlur(charsGrayMat, charsGrayMat, 3);
		//Imgcodecs.imwrite("temp/charsMat.jpg", charsGrayMat);
		Imgcodecs.imwrite(Paths.get("build","idcard","test").toAbsolutePath().toString()+"/charsMat.jpg", charsGrayMat);
		ArrayList<MatOfPoint> charContours = new ArrayList<>();
		Imgproc.findContours(charsGrayMat, charContours, hierarchy, Imgproc.RETR_EXTERNAL, Imgproc.CHAIN_APPROX_NONE);

		Vector<Rect> vecRect = new Vector<Rect>();

		for (int k = 0; k < charContours.size(); k++) {
			Rect mr = Imgproc.boundingRect(charContours.get(k));
			if (verifySizes(mr)) {
				vecRect.add(mr);
			}

		}
		Vector<Rect> sortedRect = IdCardCoreFunc.SortRect(vecRect);
		int x = 0;
		StringBuffer idcar = new StringBuffer();
		for (Rect rectSor : sortedRect) {
			Mat specMat = new Mat(charsGrayMat, rectSor);
			specMat = preprocessChar(specMat);
			//Imgcodecs.imwrite("temp/debug_specMat" + x + ".jpg", specMat);
			Imgcodecs.imwrite(Paths.get("build","idcard","test").toAbsolutePath().toString()+"/debug_specMat" + x + ".jpg", specMat);
			x++;
			String charText = svmTrain.svmFind(specMat);
			idcar.append(charText);
		}
		return idcar.toString();

	}

	private static Rect detectTextArea(Mat srcMat) {
		Mat grayMat = new Mat(); // 灰度图
		Imgproc.cvtColor(srcMat, grayMat, Imgproc.COLOR_RGB2GRAY);// 灰度化
		Imgproc.GaussianBlur(grayMat, grayMat, new Size(3, 3), 0, 0, Core.BORDER_DEFAULT);
		grayMat = IdCardCoreFunc.Sobel(grayMat);
		//Imgcodecs.imwrite("temp/Sobel.jpg", grayMat);
		Imgcodecs.imwrite(Paths.get("build","idcard","test").toAbsolutePath().toString()+"/Sobel.jpg", grayMat);
		Imgproc.threshold(grayMat, grayMat, 0, 255, Imgproc.THRESH_OTSU + Imgproc.THRESH_BINARY);
		Imgproc.medianBlur(grayMat, grayMat, 3);

		//Imgcodecs.imwrite("temp/grayMat.jpg", grayMat);
		Imgcodecs.imwrite(Paths.get("build","idcard","test").toAbsolutePath().toString()+"/grayMat.jpg", grayMat);

		// 使用闭操作。对图像进行闭操作以后，可以看到车牌区域被连接成一个矩形装的区域。
		Rect rect = null;
		for (int step = 20; step < 60;) {
			//System.out.println(step);
			Mat element = Imgproc.getStructuringElement(Imgproc.MORPH_RECT, new Size(step, 1));
			Imgproc.morphologyEx(grayMat, grayMat, Imgproc.MORPH_CLOSE, element);

			//Imgcodecs.imwrite("temp/MORPH_CLOSE.jpg", grayMat);
			Imgcodecs.imwrite(Paths.get("build","idcard","test").toAbsolutePath().toString()+"/MORPH_CLOSE.jpg", grayMat);

			/**
			 * 轮廓提取()
			 */
			ArrayList<MatOfPoint> contoursList = new ArrayList<>();
			Mat hierarchy = new Mat();
			Imgproc.findContours(grayMat, contoursList, hierarchy,
					Imgproc.RETR_EXTERNAL, Imgproc.CHAIN_APPROX_SIMPLE);

			for (int i = 0; i < contoursList.size(); i++) {
				Rect tempRect = Imgproc.boundingRect(contoursList.get(i));
				if(grayMat.height()/tempRect.height<5){
					continue;
				}
				int r = tempRect.width / tempRect.height;
				 if (r < 1){
					r = tempRect.height/tempRect.width;
				 }
				if (tempRect.width>10 && tempRect.height>10 &&
						grayMat.width()!=tempRect.width && r >10 && r<20) {
					if (rect == null) {
						rect = tempRect;
						continue;
					}

					if (tempRect.y > rect.y) {
						rect = tempRect;
					}
				}
			}
			if (rect != null) {
				//Imgcodecs.imwrite("temp/rectMat.jpg", new Mat(grayMat,rect));
				Imgcodecs.imwrite(Paths.get("build","idcard","test").toAbsolutePath().toString()+"/rectMat.jpg", new Mat(grayMat,rect));
				return rect;
			}
			step = step + 5;
		}
		return rect;

	}

	/**
	 * 字符预处理: 统一每个字符的大小
	 *
	 * @param in
	 * @return
	 */
	private static Mat preprocessChar(Mat in) {
		int h = in.rows();
		int w = in.cols();
		int charSize = 20;
		Mat transformMat = Mat.eye(2, 3, CvType.CV_32F);
		int m = Math.max(w, h);
		transformMat.put(0, 2, ((m - w) / 2f));
		transformMat.put(1, 2, ((m - h) / 2f));

		Mat warpImage = new Mat(m, m, in.type());

		Imgproc.warpAffine(in, warpImage, transformMat, warpImage.size(), Imgproc.INTER_LINEAR, Core.BORDER_CONSTANT,
				new Scalar(0));

		Mat out = new Mat();
		Imgproc.resize(warpImage, out, new Size(charSize, charSize));

		return out;
	}

	private static boolean verifySizes(Rect mr) {
		if (mr.size().height < 5 || mr.size().width < 5) {
			return false;
		}
		return true;
	}


    public static void main(String[] args) throws Exception {
        System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
        //String text = IdCardCvUtils.getIdCardCode("res/test/xx4.jpg");
        String text = IdCardCvUtil.getIdCardCode(Paths.get("build","dataset","idcard","1.jpg").toAbsolutePath().toString());
        System.out.println(text);
    }



}
