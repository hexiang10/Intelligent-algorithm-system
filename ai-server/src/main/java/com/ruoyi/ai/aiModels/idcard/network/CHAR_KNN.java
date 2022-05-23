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
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.ml.KNearest;
import org.opencv.ml.Ml;



public class CHAR_KNN {
    public static final int K = 5;

	public static String trainImages = Paths.get("build","idcard","data","chars2").toAbsolutePath().toString();

    private   KNearest knn ;

    private  int sizeData = 10;
    // 中国车牌
    private final char strCharacters[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'X'/*, 'A', 'B', 'C', 'D', 'E',
            'F', 'G', 'H',  没有I
            'J', 'K', 'L', 'M', 'N',  没有O 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'*/ };
    private final int numCharacter = 11; /* 没有I和0,10个数字与24个英文字符之和 */


    public void knnTrain(Mat TrainData, Mat classes) {

    	  boolean success = getKnn().train(TrainData, Ml.ROW_SAMPLE,classes);

    	//  getKnn().save(knnXml);
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
        Mat classTemMat = new Mat(1,trainingLabels.size(),CvType.CV_32FC1);
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
         knnTrain(TrainingData, Classes);


     }

    public static void main(String[] args){
        System.loadLibrary(Core.NATIVE_LIBRARY_NAME);

        CHAR_KNN knnTrain = new CHAR_KNN();
        StringBuffer idcar = new StringBuffer();
        for (int i = 0; i <= 17; i++) {
       	   Mat img = Imgcodecs.imread(Paths.get("build","idcard","test").toAbsolutePath().toString()+"/debug_specMat"+i+".jpg");
       	    String charText = knnTrain.knnFind(img);
            idcar.append(charText);

		}
        System.out.println("idcar:\n" + idcar.toString());


    }
    public   String knnFind(Mat charMat) {
        if(!getKnn().isTrained()){
        	System.out.println("train....");
        	 Map<String, Mat> resultMap = saveTrainData();
             saveModel(resultMap);
        }
        Mat f = IdCardCoreFunc.features(charMat, 10);

        //find the nearest neighbours of test data
        Mat results = new Mat();
        Mat neighborResponses = new Mat();
        Mat dists = new Mat();
        getKnn().findNearest(f, K, results, neighborResponses, dists);
        String charText = String.valueOf(strCharacters[(int) results.get(0,0)[0]]);
        return charText;
    }

	public KNearest getKnn() {
		if(knn==null){
			knn = KNearest.create();
		}
		return knn;
	}

	public void setKnn(KNearest knn) {
		this.knn = knn;
	}
}
