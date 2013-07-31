package com.klspta.web.xuzhouNW.wpzf;

import java.io.File;
import java.util.List;
import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

public class ImportWp extends AbstractBaseBean {
    //临时文件路径
    private String tempPath = getTempPath();
    
    public void importWp(){
        String zipPath = getTempFile();
        if(zipPath!=null){
            File zipFile = new File(zipPath);
            String folderpath = tempPath + zipFile.getParentFile().getName();
            //解压缩
            UtilFactory.getZIPUtil().unZip(zipPath, folderpath);
            
            
        }
        
    }
    
    
    private String getTempFile(){
       try {
           List<String> list = UtilFactory.getFileUtil().upload(request, 0, 0);
        return list.get(0);
        } catch (Exception e) {
            e.printStackTrace();
        }     
       return null;      
    }
    
    private String getTempPath(){
        String tempPath="";
        tempPath = UtilFactory.getConfigUtil().getShapefileTempPathFloder();
        return tempPath;
        
    }
    
    
    private void parseDbfFile(String filePath){
        
        
    }
}
