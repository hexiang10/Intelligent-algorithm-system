package com.ruoyi.ai.car;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * 用于生成ID的工具类
 * @author yuxue
 * @date 2020-10-12 11:16
 */
public class GenerateIdUtil {

    private static DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMddHHmmssSSS");

    /**
     * 获取时间戳，生成文件名称
     * @return
     */
    public static synchronized Long getId() {
        try {
            Thread.sleep(1);
        } catch (Exception e) {}
        return System.currentTimeMillis();
    }

    public static synchronized String getStrId() {
        try {
            Thread.sleep(1);
        } catch (Exception e) {}
        return formatter.format(LocalDateTime.now());
    }


}
