package com.ruoyi.ai;

import com.ruoyi.ai.aiModels.car.deal.DealWithImg;

import java.util.HashMap;
import java.util.Map;

/**
 * @author: 何翔
 * @date: 2022/5/12
 * @description: 车辆识别测试
 */

public class CarTest {
    public static void main(String[] args) {
        Map<String, String> map = new HashMap<String, String>();
        map.put("path","D:\\Study\\Project\\AI-System\\build\\car\\image\\baidu_image\\test1.jpg");
        String carNum = DealWithImg.recognition(map);
    }
}
