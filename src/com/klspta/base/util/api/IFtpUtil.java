package com.klspta.base.util.api;

import it.sauronsoftware.ftp4j.FTPClient;

import java.io.InputStream;
import java.util.Map;

public interface IFtpUtil {

    /**
     * <br>Description: 获取ftp配置信息
     * <br>Author:李如意
     * <br>Date:2012-8-13
     * @return
     */
    public Map<String, Object> getFtpConfig();

    /**
     * <br>Description: 获取ftp连接
     * <br>Author:李如意
     * <br>Date:2012-8-15
     * @return
     */
    public FTPClient getFtpClient();

    /**
     * <br>Description: 	附件上传
     * <br>Author:李如意
     * <br>Date:2012-8-16
     * @param file_path		服务器端临时文件夹下的文件路径
     * @return
     */
    public boolean uploadFile(String file_path);

    /**
     * <br>Author:李如意	  	附件上传，直接从客户端以流的方式直接写入ftp服务器
     * <br>Date:2012-8-17
     * @param input			输入流
     * @param ftpFileName	上传到ftp服务器的文件名称
     * @return
     */
    public boolean uploadFile(InputStream input, String ftpFileName);

    /**
     * <br>Description: 	附件下载
     * <br>Author:李如意
     * <br>Date:2012-8-16
     * @param remoteFileName 	ftp服务器上文件名称	
     * @param localFile			附件下载保存的位置（保存在服务器端临时文件夹下）		
     * @return
     */
    boolean downloadFile(String remoteFileName, String localFile);

    /**
     * <br>Description: 附件删除
     * <br>Author:李如意
     * <br>Date:2012-8-16
     * @param ftpFileName	ftp服务器上的文件名称
     * @return
     */
    public boolean deleteFile(String ftpFileName);

}
