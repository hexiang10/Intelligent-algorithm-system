package com.ruoyi.ai.mnist;

import ai.djl.modality.cv.Image;
import ai.djl.modality.cv.ImageFactory;
import ai.djl.modality.cv.transform.ToTensor;
import ai.djl.ndarray.NDArray;
import ai.djl.ndarray.NDList;
import ai.djl.ndarray.NDManager;
import ai.djl.training.dataset.RandomAccessDataset;
import ai.djl.training.dataset.Record;
import ai.djl.translate.Pipeline;
import ai.djl.util.Progress;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * 数据集 for mnist
 *
 * @author hexiang
 */
public class MnistDataset extends RandomAccessDataset {

    private final Path path;
    private boolean prepared;
    private List<String> items;

    private MnistDataset(Builder builder) {
        super(builder);
        this.path = builder.path;
    }

    public static Builder builder() {
        return new Builder();
    }

    @Override
    public void prepare(Progress progress) throws IOException {
        if (prepared) {
            return;
        }
        try (Stream<Path> paths = Files.walk(path)) {
            items = paths.map(p -> p.toFile().getName())
                    .filter(n -> n.endsWith(".png"))
                    .distinct()
                    .collect(Collectors.toList());
        }
        prepared = true;
    }

    @Override
    protected long availableSize() {
        return items.size();
    }

    @Override
    public Record get(NDManager manager, long index) {
        String item = items.get(Math.toIntExact(index));
        Path imagePath = Paths.get(path.toString(), item);
        NDArray imageArray = null;
        try {
            imageArray = ImageFactory.getInstance()
                    .fromFile(imagePath)
                    .toNDArray(manager, Image.Flag.GRAYSCALE);
        } catch (IOException e) {
            e.printStackTrace();
        }
        NDList data = new NDList(imageArray);
        NDList labels = new NDList(1);
        labels.add(manager.create(Integer.parseInt(item.split("_")[0])));
        return new Record(data, labels);
    }

    public static final class Builder extends BaseBuilder<Builder> {

        private Path path;

        Builder() {
            pipeline = new Pipeline(new ToTensor());
        }

        @Override
        protected Builder self() {
            return this;
        }

        public Builder optPath(Path path) {
            this.path = path;
            return this;
        }

        public MnistDataset build() {
            return new MnistDataset(this);
        }
    }
}
