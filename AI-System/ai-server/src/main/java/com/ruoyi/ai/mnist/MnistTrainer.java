package com.ruoyi.ai.mnist;

import ai.djl.Device;
import ai.djl.Model;
import ai.djl.basicdataset.cv.classification.Mnist;
import ai.djl.basicmodelzoo.basic.Mlp;
import ai.djl.metric.Metrics;
import ai.djl.ndarray.types.Shape;
import ai.djl.nn.Block;
import ai.djl.training.DefaultTrainingConfig;
import ai.djl.training.EasyTrain;
import ai.djl.training.Trainer;
import ai.djl.training.TrainingResult;
import ai.djl.training.dataset.Dataset;
import ai.djl.training.dataset.RandomAccessDataset;
import ai.djl.training.evaluator.Accuracy;
import ai.djl.training.listener.SaveModelTrainingListener;
import ai.djl.training.listener.TrainingListener;
import ai.djl.training.loss.Loss;
import ai.djl.training.util.ProgressBar;
import ai.djl.translate.TranslateException;


import java.io.IOException;
import java.nio.file.Paths;

/**
 * 模型训练 for mnist
 *
 * @author hexiang
 */
public class MnistTrainer {

    private static final MnistTrainer INSTANCE = new MnistTrainer();

    private MnistTrainer() {
    }

    public static MnistTrainer getInstance() {
        return INSTANCE;
    }

    public TrainingResult train(Arguments arguments) throws IOException, TranslateException {
        if (arguments == null) {
            return null;
        }
        // Construct neural network
        Block block = new Mlp(28 * 28, 10, new int[]{128, 64});

        try (Model model = Model.newInstance("first")) {
            model.setBlock(block);

            // get training and validation dataset
            RandomAccessDataset trainingSet = getDataset(Dataset.Usage.TRAIN, arguments);
            RandomAccessDataset validateSet = getDataset(Dataset.Usage.TEST, arguments);

            // setup training configuration
            DefaultTrainingConfig config = setupTrainingConfig(arguments);

            try (Trainer trainer = model.newTrainer(config)) {
                trainer.setMetrics(new Metrics());

                /*
                 * MNIST is 28x28 grayscale image and pre processed into 28 * 28 NDArray.
                 * 1st axis is batch axis, we can use 1 for initialization.
                 */
                Shape inputShape = new Shape(1, Mnist.IMAGE_HEIGHT * Mnist.IMAGE_WIDTH);

                // initialize trainer with proper input shape
                trainer.initialize(inputShape);

                EasyTrain.fit(trainer, arguments.getEpoch(), trainingSet, validateSet);

                return trainer.getTrainingResult();
            }
        }
    }

    private DefaultTrainingConfig setupTrainingConfig(Arguments arguments) {
        String outputDir = arguments.getOutputDir();
        SaveModelTrainingListener listener = new SaveModelTrainingListener(outputDir);
        listener.setSaveModelCallback(
                trainer -> {
                    TrainingResult result = trainer.getTrainingResult();
                    Model model = trainer.getModel();
                    float accuracy = result.getValidateEvaluation("Accuracy");
                    model.setProperty("Accuracy", String.format("%.5f", accuracy));
                    model.setProperty("Loss", String.format("%.5f", result.getValidateLoss()));
                });
        return new DefaultTrainingConfig(Loss.softmaxCrossEntropyLoss())
                .addEvaluator(new Accuracy())
                .optDevices(Device.getDevices(arguments.getMaxGpus()))
                .addTrainingListeners(TrainingListener.Defaults.logging(outputDir))
                .addTrainingListeners(listener);
    }

    private RandomAccessDataset getDataset(Dataset.Usage usage, Arguments arguments)
            throws IOException {
        MnistDataset mnist = MnistDataset.builder()
                .optPath(Paths.get("build", "dataset", "mnist", "1.1", "data", getUsagePath(usage)))
                .setSampling(arguments.getBatchSize(), true)
                .optLimit(arguments.getLimit())
                .build();
        mnist.prepare(new ProgressBar());
        return mnist;
    }

    private String getUsagePath(Dataset.Usage usage) {
        switch (usage) {
            case TRAIN:
                return "training";
            case TEST:
                return "testing";
            case VALIDATION:
            default:
                throw new IllegalArgumentException("Invalid usage");
        }
    }

}
