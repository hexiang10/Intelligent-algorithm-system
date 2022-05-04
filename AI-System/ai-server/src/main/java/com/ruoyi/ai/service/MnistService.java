package com.ruoyi.ai.service;

import ai.djl.MalformedModelException;
import ai.djl.modality.cv.ImageFactory;
import ai.djl.translate.TranslateException;
import ai.djl.util.ZipUtils;
import com.ruoyi.ai.mnist.Arguments;
import com.ruoyi.ai.mnist.MnistInference;
import com.ruoyi.ai.mnist.MnistTrainer;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Stream;


public class MnistService {

    private static final Logger log = LoggerFactory.getLogger(MnistInference.class);

    public static int result;

    public static String fileName;

    public static void initDataset() throws IOException {
        if (!Paths.get("build", "dataset","mnist").toFile().exists()) {
            log.info("start init dataset");
            ZipUtils.unzip(Files.newInputStream(Paths.get("build", "dataset","mnist.zip").toAbsolutePath()), Paths.get("build","dataset"));
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
        try (Stream<Path> paths = Files.list(Paths.get("build",  "upload"))) {
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

    public static void main(String[] args) {
        System.out.println(Paths.get("build").toAbsolutePath());
    }

}

