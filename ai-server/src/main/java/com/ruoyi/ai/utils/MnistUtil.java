package com.ruoyi.ai.utils;

import ai.djl.MalformedModelException;
import ai.djl.modality.cv.ImageFactory;
import ai.djl.translate.TranslateException;
import ai.djl.util.ZipUtils;
import com.ruoyi.ai.aiModels.mnist.Arguments;
import com.ruoyi.ai.aiModels.mnist.MnistInference;
import com.ruoyi.ai.aiModels.mnist.MnistTrainer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.stream.Stream;


public class MnistUtil {

    private static final Logger log = LoggerFactory.getLogger(MnistInference.class);

    public static int result;

    public static String fileName;

    public static void initDataset() throws IOException {
        if (!Paths.get("build", "dataset", "mnist").toFile().exists()) {
            log.info("start init dataset");
            ZipUtils.unzip(Files.newInputStream(Paths.get("build", "dataset", "mnist.zip").toAbsolutePath()), Paths.get("build", "dataset"));
            log.info("end init dataset");
        }
    }

    public static void train() throws IOException, TranslateException {
        Arguments arguments = new Arguments();
        arguments.setEpoch(1);
        MnistTrainer.getInstance().train(arguments);
    }

    public static int inference(String name) throws IOException {
        fileName = name;
        try (Stream<Path> paths = Files.list(Paths.get("build", "upload"))) {
            //paths.filter(p -> p.toString().endsWith(".png"))
            paths.filter(p -> p.toString().endsWith(fileName))

                .forEach(p -> {
                    try {
                        Integer res = MnistInference.recognition(ImageFactory.getInstance().fromFile(p));
                        log.info("inference file:{} result:{}", p, res);
                        result = res;
                    } catch (IOException | TranslateException | MalformedModelException e) {
                        e.printStackTrace();
                    }
                });
        }

        return result;

    }

}
