package com.ruoyi.ai.utils;


import com.ruoyi.ai.common.FastDFSFile;
import org.csource.common.NameValuePair;
import org.csource.fastdfs.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * @author: hexiang
 * @date: 2022/4/4
 * @description: FastDFS工具类
 */

public class FastDFSClientUtil {

    private static Logger logger = LoggerFactory.getLogger(FastDFSClientUtil.class);

    /*
      初始化FastDFS客户端
      @return
     */
    static {
        try {
            String filePath = new ClassPathResource("fdfs_client.conf").getPath();
            ClientGlobal.init(filePath);
        } catch (Exception e) {
            logger.error("初始化FastDFS客户端失败");
            e.printStackTrace();
        }
    }
    /*
      获取TrackerServer
     */
    private static TrackerServer getTrackerServer() throws IOException {
       TrackerClient trackerClient = new TrackerClient();
       return trackerClient.getTrackerServer();
    }

    /**
     * 生产storageClient
     * @return
     * @throws IOException
     */
    private static StorageClient getStorageClient() throws IOException {
        TrackerServer trackerServer = getTrackerServer();
        return new StorageClient(trackerServer,null);
    }

    /**
     * 上传文件
     * @param file
     * @return
     */
    public static String[] uploadFile(FastDFSFile file) {
        logger.info("File Name: " + file.getName() + "File Length:" + file.getContent().length);
        //文件属性信息
        NameValuePair[] meta_list = new NameValuePair[1];
        meta_list[0] = new NameValuePair("author", file.getAuthor());
        long startTime = System.currentTimeMillis();
        String[] uploadResults = null;
        StorageClient storageClient = null;
        try {
            storageClient = getStorageClient();
            uploadResults =  storageClient.upload_file(file.getContent(), file.getExt(), meta_list);
        } catch (Exception e) {
            logger.error("上传文件失败");
            e.printStackTrace();
        }
        //输出上传文件耗时
        logger.info("upload_file time used: " + (System.currentTimeMillis() - startTime) + " ms");
        if(uploadResults == null&&storageClient!=null){
            logger.error("upload file fail, error code: " + storageClient.getErrorCode());
        }
        logger.info("upload file successfully!!!" + "group_name:" + uploadResults[0] + ", remote_filename:" + uploadResults[1]);
        return uploadResults;
    }

    /**
     * 下载文件
     * @param groupName
     * @param remoteFileName
     * @return
     */
    public static InputStream downloadFile(String groupName, String remoteFileName) {
        try {
            StorageClient storageClient = getStorageClient();
            byte[] file = storageClient.download_file(groupName, remoteFileName);
            return new ByteArrayInputStream(file);
        } catch (Exception e) {
            logger.error("下载文件失败");
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 删除文件
     * @param groupName
     * @param remoteFileName
     * @return
     */
    public static void deleteFile(String groupName, String remoteFileName) {
        try {
            StorageClient storageClient = getStorageClient();
            storageClient.delete_file(groupName, remoteFileName);
            logger.info("delete file successfully!!!");
        } catch (Exception e) {
            logger.error("删除文件失败");
            e.printStackTrace();
        }
    }

    /**
     * 获取文件信息
     * @param groupName
     * @param remoteFileName
     * @return
     */
    public static FileInfo getFileInfo(String groupName, String remoteFileName) {
        try {
            StorageClient storageClient = getStorageClient();
            return storageClient.get_file_info(groupName, remoteFileName);
        } catch (Exception e) {
            logger.error("获取文件信息失败");
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 获取文件路径
     */
    public static String getTrackerUrl() throws Exception {
        TrackerClient trackerClient = new TrackerClient();
        TrackerServer trackerServer = trackerClient.getTrackerServer();
        StorageServer storeStorage = trackerClient.getStoreStorage(trackerServer);
        return "http://"+storeStorage.getInetSocketAddress().getHostString()+":8888/";
    }
}
