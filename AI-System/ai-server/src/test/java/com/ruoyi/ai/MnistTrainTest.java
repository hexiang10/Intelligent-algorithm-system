package com.ruoyi.ai;

import ai.djl.MalformedModelException;
import ai.djl.modality.cv.ImageFactory;
import ai.djl.translate.TranslateException;
import com.ruoyi.ai.mnist.MnistInference;
import com.ruoyi.ai.service.MnistService;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.stream.Stream;

/**
 * @author: hexiang
 * @date: 2022/5/4
 * @description:
 */

@Slf4j
public class MnistTrainTest {

    public static void main(String[] args) throws IOException, TranslateException {
        MnistService.initDataset();
        MnistService.train();
        inference();
    }

    public static void inference() throws IOException {
        try (Stream<Path> paths = Files.list(Paths.get("build",  "MnistModel"))) {
            //paths.filter(p -> p.toString().endsWith(fileName))
            paths.filter(p -> p.toString().endsWith(".png"))
                .forEach(p -> {
                    try {
                        Integer res = MnistInference.recognition(ImageFactory.getInstance().fromFile(p));
                        log.info("inference file:{} result:{}", p, res);
                    } catch (IOException | TranslateException | MalformedModelException e) {
                        e.printStackTrace();
                    }
                });
        }
    }
}
