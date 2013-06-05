package com.klspta.base.util.impl;

import it.sauronsoftware.ftp4j.FTPClient;

import java.io.File;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.util.api.IFtpUtil;

public class FtpUtil extends AbstractBaseBean implements IFtpUtil {
    FTPClient ftp;

    private static FtpUtil ftpUtil;

    private static Map<String, Object> ftpConfigMap = new HashMap<String, Object>();

    private FtpUtil() {

    }

    public static IFtpUtil getInstance(String key) throws Exception {
        if (!key.equals("NEW WITH UTIL FACTORY!")) {
            throw new Exception("请通过UtilFactory获取实例.");
        }
        if (ftpUtil == null) {
            return new FtpUtil();
        }
        return ftpUtil;
    }

    /**
     * <br>Description: 附件下载
     * <br>Author:李如意
     * <br>Date:2012-7-1
     * @see com.klspta.model.accessory.IFtpUtil#downloadFile(java.lang.String, int, java.lang.String, java.lang.String, java.lang.String)
     */
    public String downloadFile(String ip, int port, String username, String password, String ftpFileId) {
        StringBuffer sb = new StringBuffer("ftp://");
        sb.append(username).append(":").append(password).append("@").append(ip).append(":").append(port)
                .append("/").append(ftpFileId);
        return sb.toString();
    }

    /**
     * <br>Description: 获取ftp配置信息
     * <br>Author:李如意
     * <br>DateTime:2012-8-23 下午03:07:18
     * @see com.klspta.base.util.api.IFtpUtil#getFtpConfig()
     */
    @Override
    public Map<String, Object> getFtpConfig() {
        String host = UtilFactory.getConfigUtil().getConfig("ftp.host");
        String port = UtilFactory.getConfigUtil().getConfig("ftp.port");
        String username = UtilFactory.getConfigUtil().getConfig("ftp.username");
        String password = UtilFactory.getConfigUtil().getConfig("ftp.password");
        ftpConfigMap.put("FTP_HOST", host);
        ftpConfigMap.put("FTP_PORT", port);
        ftpConfigMap.put("FTP_USERNAME", username);
        ftpConfigMap.put("FTP_PASSWORD", password);
        return ftpConfigMap;
    }

    /**
     * <br>Description:获取ftpClient
     * <br>Author:李如意
     * <br>Date:2012-8-16
     * @see com.klspta.base.util.api.IFtpUtil#getFtpClient()
     */
    @Override
    public FTPClient getFtpClient() {
        Map<String, Object> ftpConfigMap = getFtpConfig();
        FTPClient ftpClient = new FTPClient();
        try {
            ftpClient.connect((String) ftpConfigMap.get("FTP_HOST"), Integer.parseInt((String) ftpConfigMap
                    .get("FTP_PORT")));
            ftpClient.login((String) ftpConfigMap.get("FTP_USERNAME"), (String) ftpConfigMap
                    .get("FTP_PASSWORD"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ftpClient;
    }

    /**
     * <br>Description: 附件上传
     * <br>Author:李如意
     * <br>Date:2012-8-16
     * @see com.klspta.base.util.api.IFtpUtil#uploadFile(java.lang.String)
     */
    @Override
    public boolean uploadFile(InputStream input, String ftpFileName) {
        try {
            FTPClient client = UtilFactory.getFtpUtil().getFtpClient();
            client.upload(ftpFileName, input, 0L, 0L, null);
            client.disconnect(false);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    /**
     * <br>Description: 附件上传
     * <br>Author:李如意
     * <br>Date:2012-8-17
     * @see com.klspta.base.util.api.IFtpUtil#uploadFile(java.lang.String)
     */
    @Override
    public boolean uploadFile(String file_path) {
        try {
            FTPClient client = UtilFactory.getFtpUtil().getFtpClient();
            client.upload(new File(file_path));
            client.disconnect(false);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    /**
     * <br>Description: 附件下载
     * <br>Author:李如意
     * <br>Date:2012-8-17
     * @see com.klspta.base.util.api.IFtpUtil#downloadFile(java.lang.String, java.lang.String)
     */
    public boolean downloadFile(String remoteFileName, String localFilePosition) {
        FTPClient client = UtilFactory.getFtpUtil().getFtpClient();
        try {
            client.download(remoteFileName, new File(localFilePosition));
            client.disconnect(false);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    /**
     * <br>Description: 附件删除
     * <br>Author:李如意
     * <br>Date:2012-8-16
     * @see com.klspta.base.util.api.IFtpUtil#deleteFTPFile(java.lang.String)
     */
    public boolean deleteFile(String ftpFileName) {
        FTPClient client = UtilFactory.getFtpUtil().getFtpClient();
        try {
            client.deleteFile(ftpFileName);
            client.disconnect(false);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

}
