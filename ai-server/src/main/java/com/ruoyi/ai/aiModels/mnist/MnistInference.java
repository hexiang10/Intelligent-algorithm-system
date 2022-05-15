package com.ruoyi.ai.aiModels.mnist;

import ai.djl.MalformedModelException;
import ai.djl.Model;
import ai.djl.basicmodelzoo.basic.Mlp;
import ai.djl.inference.Predictor;
import ai.djl.modality.Classifications;
import ai.djl.modality.cv.Image;
import ai.djl.modality.cv.transform.Resize;
import ai.djl.modality.cv.transform.ToTensor;
import ai.djl.modality.cv.translator.ImageClassificationTranslator;
import ai.djl.nn.Block;
import ai.djl.translate.Pipeline;
import ai.djl.translate.TranslateException;
import ai.djl.translate.Translator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

/**
 * 模型使用 for mnist
 *
 * @author hexiang
 */
public class MnistInference {

    private MnistInference() {
    }

    private static final Logger log = LoggerFactory.getLogger(MnistInference.class);

    public static Integer recognition(Image img) throws IOException, TranslateException, MalformedModelException {
        Model model = Model.newInstance("first");
        Path modelDir = Paths.get("build/MnistModel");
        Predictor<Image, Classifications> predictor = null;
        Block block = new Mlp(28 * 28, 10, new int[]{128, 64});

        try {
            model.setBlock(block);
            model.load(modelDir);

            List<String> classes = IntStream.range(0, 10).mapToObj(String::valueOf).collect(Collectors.toList());
            Pipeline pipeline = new Pipeline();
            pipeline.add(new Resize(28, 28))
                    .add(new ToTensor());

            Translator<Image, Classifications> translator =
                    ImageClassificationTranslator.builder()
                            .setPipeline(pipeline)
                            .optSynset(classes)
                            .build();
            predictor = model.newPredictor(translator);
            Classifications classifications = predictor.predict(img);
            return Integer.parseInt(classifications.best().getClassName());
        } catch (MalformedModelException e) {
            log.error("model inference error! image:{}", img, e);
            throw e;
        } catch (TranslateException e) {
            log.error("translate error! image:{}", img, e);
            throw e;
        } finally {
            model.close();
            if (null != predictor) {
                predictor.close();
            }
        }
    }

}
