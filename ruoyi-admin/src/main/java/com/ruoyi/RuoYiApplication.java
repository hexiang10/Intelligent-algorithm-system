package com.ruoyi;

import com.ruoyi.ai.aiModels.car.deal.DealWithImg;
import com.ruoyi.ai.utils.FaceUtil;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.metrics.buffering.BufferingApplicationStartup;

import java.util.HashMap;
import java.util.Map;

/**
 * 启动程序
 *
 * @author ruoyi
 */

@SpringBootApplication
public class RuoYiApplication {

    public static void main(String[] args) {
        FaceUtil.init();
        System.setProperty("spring.devtools.restart.enabled", "false");
        SpringApplication application = new SpringApplication(RuoYiApplication.class);
        application.setApplicationStartup(new BufferingApplicationStartup(2048));
        application.run(args);
        System.out.println("(♥◠‿◠)ﾉﾞ  启动成功   ლ(´ڡ`ლ)ﾞ");
    }

}
