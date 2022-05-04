package com.ruoyi.ai.mnist;

import ai.djl.Device;

/**
 * 模型训练参数
 *
 * @author hexiang
 */
public class Arguments {

    private final int batchSize;
    private final int maxGpus;
    private int epoch;
    private String outputDir;
    private long limit;
    private String modelDir;

    public Arguments() {
        this.epoch = 2;
        this.maxGpus = Device.getGpuCount();
        this.outputDir = "build/MnistModel";
        this.limit = Long.MAX_VALUE;
        this.modelDir = null;
        this.batchSize = maxGpus > 0 ? 32 * maxGpus : 32;
    }

    public int getEpoch() {
        return epoch;
    }

    public void setEpoch(int epoch) {
        this.epoch = epoch;
    }

    public int getBatchSize() {
        return batchSize;
    }

    public int getMaxGpus() {
        return maxGpus;
    }

    public String getOutputDir() {
        return outputDir;
    }

    public void setOutputDir(String outputDir) {
        this.outputDir = outputDir;
    }

    public long getLimit() {
        return limit;
    }

    public void setLimit(long limit) {
        this.limit = limit;
    }

    public String getModelDir() {
        return modelDir;
    }

    public void setModelDir(String modelDir) {
        this.modelDir = modelDir;
    }

}
