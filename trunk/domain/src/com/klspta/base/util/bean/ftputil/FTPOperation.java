package com.klspta.base.util.bean.ftputil;

import it.sauronsoftware.ftp4j.FTPClient;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;


public class FTPOperation extends AbstractBaseBean implements IFTPOperation {

    //定义FTPServerConfigBean,static 避免频繁访问数据库
    private static FTPServerConfigBean ftpConfig;

    /**
     * 
     * <br>Description:private构造方法，屏蔽new创建
     * <br>Author:郭
     * <br>Date:2010-11-22
     */
    private FTPOperation() {
    }

    private static FTPOperation FTPOp = new FTPOperation();

    /**
     * 
     * <br>Description:返回FTP操作对象
     * <br>Author:郭
     * <br>Date:2010-11-22
     * @return
     */
    public static IFTPOperation getInstance() {
        if (FTPOp == null) {
            FTPOp = new FTPOperation();
        }
        return FTPOp;
    }
    
    public FTPServerConfigBean getFtpConfig(){
        if (ftpConfig == null) {
            String sql = "select t.* from core_ftpserverconfig t";
            List<Map<String,Object>> list = query(sql,CORE);
            if (list.size() == 1) {
            	Map<String,Object> map=list.get(0);
            	ftpConfig=new FTPServerConfigBean();
            	ftpConfig.setFtp_id((String)map.get("ftp_id"));
            	ftpConfig.setFtp_username((String)map.get("ftp_username"));
            	ftpConfig.setFtp_password((String)map.get("ftp_password"));
            	ftpConfig.setFtp_port((String)map.get("ftp_port"));
            	ftpConfig.setFtp_host((String)map.get("ftp_host"));
            	ftpConfig.setFtp_description((String)map.get("ftp_description"));
                //ftpConfig = (FTPServerConfigBean) list.get(0);
            } else {
                System.out.println("FTPServerConfig配置错误....");
                return null;
            }
        }
        return ftpConfig;
    }
    
    @Override
    public FTPClient getFTPClient() {
        if (ftpConfig == null) {
        	ftpConfig = new FTPServerConfigBean();
        	//ftpConfig.setFtp_id(UtilFactory.getConfigUtil().getConfig(key));
        	ftpConfig.setFtp_username(UtilFactory.getConfigUtil().getConfig("ftp.username"));
        	ftpConfig.setFtp_password(UtilFactory.getConfigUtil().getConfig("ftp.password"));
        	ftpConfig.setFtp_port(UtilFactory.getConfigUtil().getConfig("ftp.port"));
        	ftpConfig.setFtp_host(UtilFactory.getConfigUtil().getConfig("ftp.host"));
        	
        }
        try {
            FTPClient client = new FTPClient();
           // client.setCharset("utf-8");				//屏蔽解决文档在线编辑上传文件到服务器乱码问题  lry 2011-11-15 15：20
           // client.setType(FTPClient.TYPE_BINARY);
            String host=ftpConfig.getFtp_host();
            int port=Integer.parseInt(ftpConfig.getFtp_port());
            client.connect(host, port);
            client.login(ftpConfig.getFtp_username(), ftpConfig.getFtp_password());
            return client;
        } catch (Exception e) {
            System.out.println("FTPClient 连接失败！  FTPOperation.getFTPClient()....");
            e.printStackTrace();
        }

        return null;
    }

}
