package com.klspta.web.xiamen.helpfile;

import java.io.File;
import java.io.IOException;

public class HelpFileManager{
    
    public static void main(String[] args){
        HelpFileManager manager = new HelpFileManager();
        manager.fileList();
    }
    
    
    public String fileList(){
        String fileNames = "";
        File srcFile = new File(System.getProperty("catalina.home")+"\\webapps\\download");
        boolean bFile = srcFile.exists();
        if (!bFile || !srcFile.isDirectory() || !srcFile.canRead()) {
            try {
                srcFile.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else{
            File[] file = srcFile.listFiles();
            for(int i=0;i<file.length;i++){
                String fileName = file[i].getName();
                if(fileName.endsWith("META-INF") || fileName.endsWith("WEB-INF")){
                }else{
                    //System.out.println(fileName);
                    fileNames = fileNames + "," + fileName;
                }
            }
        }
        try {
            return fileNames;
        } catch (Exception e) {
            return "";
        }
     }
}
