package com.ruoyi.ai.aiModels.idcard.network;

import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import com.ruoyi.ai.aiModels.idcard.core.IdCardCoreFunc;
import com.ruoyi.ai.aiModels.idcard.core.FileDeal;
import org.opencv.core.Core;
import org.opencv.core.CvType;
import org.opencv.core.Mat;
import org.opencv.core.TermCriteria;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.ml.Ml;
import org.opencv.ml.SVM;



public class CHAR_SVM {
    public static final int K = 5;

	public static String trainImages = Paths.get("build","idcard","data","chars2").toAbsolutePath().toString();
	public static String svmXml = Paths.get("build","idcard","model","svm.xml").toAbsolutePath().toString();

    private   SVM svm =null;

    private  int sizeData = 10;
    // 中国车牌
    private final char strCharacters[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'X'/*, 'A', 'B', 'C', 'D', 'E',
            'F', 'G', 'H',  没有I
            'J', 'K', 'L', 'M', 'N',  没有O 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'*/ };
    private final int numCharacter = 11; /* 没有I和0,10个数字与24个英文字符之和 */


    public void svmTrain(Mat TrainData, Mat classes) {
    	TermCriteria criteria=new TermCriteria(TermCriteria.MAX_ITER, 100, 1e-6);
		getSvm().setKernel(getSvm().LINEAR);
		getSvm().setType(getSvm().C_SVC);
		getSvm().setGamma(0.5);
		getSvm().setNu(0.5);
		//1-->97.77778%,2-->100%
		getSvm().setC(2);
		getSvm().setTermCriteria(criteria);
    	getSvm().train(TrainData, Ml.ROW_SAMPLE,classes);
    	getSvm().save(svmXml);
    	//  getSvm().save(svmXml);
          //System.out.println("training result: " + success);
    }

    public Map<String,Mat> saveTrainData() {
    	Map<String,Mat> result = new HashMap<String,Mat>();
        Mat classes = new Mat();
        Mat trainingData = new Mat();

        Vector<Integer> trainingLabels = new Vector<Integer>();
        String path = trainImages;
        for (int i = 0; i < numCharacter; i++) {
            String str = path + '/' + strCharacters[i];
            Vector<String> files = new Vector<String>();
            FileDeal.getFiles(str, files);

            int size = (int) files.size();
            for (int j = 0; j < size; j++) {
                Mat img = Imgcodecs.imread(files.get(j), 0);
                Mat f10 = IdCardCoreFunc.features(img, sizeData);

                trainingData.push_back(f10);
                trainingLabels.add(i); // 每一幅字符图片所对应的字符类别索引下标
            }
        }


        trainingData.convertTo(trainingData, CvType.CV_32FC1);
        Mat classTemMat = new Mat(1,trainingLabels.size(),CvType.CV_32SC1);//必须这个类型
        for (int i = 0; i < trainingLabels.size(); ++i){
        	classTemMat.put(0, i, trainingLabels.get(i).intValue());
        }

        classTemMat.copyTo(classes);
        result.put("TrainingData", trainingData);
        result.put("classes", classes);
       // System.out.println("End saveTrainData");
        return result;
    }
    public void saveModel( Map<String, Mat> dataMap) {


         String training = "TrainingData";
         Mat TrainingData =dataMap.get(training);
         Mat Classes = dataMap.get("classes");
         svmTrain(TrainingData, Classes);


     }

    public static void main(String[] args){
        System.loadLibrary(Core.NATIVE_LIBRARY_NAME);

        CHAR_SVM svmTrain = new CHAR_SVM();
        StringBuffer idcar = new StringBuffer();
        for (int i = 0; i <= 1; i++) {
       	   Mat img = Imgcodecs.imread(Paths.get("build","idcard","test").toAbsolutePath().toString()+"/debug_specMat"+i+".jpg");
       	    String charText = svmTrain.svmFind(img);
            idcar.append(charText);

		}
        System.out.println("idcar:\n" + idcar.toString());


    }
    public   String svmFind(Mat charMat) {
        if(!getSvm().isTrained()){
        	System.out.println("train....");
        	 Map<String, Mat> resultMap = saveTrainData();
             saveModel(resultMap);
        }
        Mat f = IdCardCoreFunc.features(charMat, 10);

        Mat results = new Mat();
        getSvm().predict(f, results, 0);
        String charText = String.valueOf(strCharacters[(int) results.get(0,0)[0]]);
        return charText;
    }

	public SVM getSvm() {
		if(svm==null){
			svm	= SVM.create();
		}
		return svm;
	}

	public void setSvm(SVM svm) {
		this.svm = svm;
	}
}
