package com.klspta.web.xuzhouNW.wpzf;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.opengis.geometry.Geometry;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.web.xuzhouNW.wpzf.shape.Shpreader;

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
            //实现上图
            upload(folderpath);
            
        }
        
    }
    
    /**
     * 
     * <br>Description:解析shape文件夹的内容，将shp上传
     * <br>Author:黎春行
     * <br>Date:2013-7-31
     * @param folderpath
     */
    private void upload(String folderpath){
    	File file = new File(folderpath);
    	File[] files = file.listFiles()[0].listFiles();
    	String shpfilePath = "";
    	String dbffilePath = "";
    	for(int i = 0; i < files.length; i++){
    		File newFile = files[i];
    		if(newFile.getName().contains(".dbf")){
    			dbffilePath = newFile.getPath();
    		}else if (newFile.getName().contains(".shp")) {
				shpfilePath = newFile.getPath();
			}
    	}
    	//获取shape文件的所有属性信息和空间数据
    	List<Map<String, Object>> shapeList = new Shpreader(shpfilePath, dbffilePath).getShpMap();
    	String upLoadName = UtilFactory.getConfigUtil().getConfig("wpname");
    	//获取对应的srid
    	String querySrid = "select t.srid from sde.st_geometry_columns t where upper(t.table_name) = ?";
    	List<Map<String, Object>>  sridList = query(querySrid, GIS, new Object[]{upLoadName});
    	String srid = "";
    	if(sridList.size() > 0){
    		srid = String.valueOf(sridList.get(0).get("srid"));
    	}
    	//将shp文件上传到空间库当中
    	for(int i = 0; i < shapeList.size(); i++){
    		//判断对应的objectid是否存在
    		shapeList.get(i).get("OBJECTID");
    		String objectid = String.valueOf(shapeList.get(i).get("OBJECTID"));
    		String objectSql = "select t.objectid from " + upLoadName + " t where t.OBJECTID = ?"; 
    		int objectsize = query(objectSql, GIS, new Object[]{objectid}).size();
    		//删除重复的objectid
    		if(objectsize > 0){
    			String deleteSql = "delete from " + upLoadName + " t where t.OBJECTID = ?";
    			update(deleteSql, GIS, new Object[]{objectid});
    		}
    		//写入新的shape数据
    		String[] name = {"OBJECTID", "XZQDM", "XMC", "JCBH", "TBLX", "TZ", "QSX", "HSX", "XZB", "YZB", "JCMJ", "BGDL", "BGFW", "WBGLX", "SHAPE_LENG"};
    		StringBuffer nameBuffer = new StringBuffer();
    		StringBuffer valueBuffer = new StringBuffer();
    		for(int j = 0; j < name.length; j++){
    			String value = String.valueOf(shapeList.get(i).get(name[j]));
    			if("".equals(value) || value == null || "null".equals(value)){
    				continue;
    			}
    			nameBuffer.append(name[j] + ",");
    			valueBuffer.append("'" + value + "',");
    		}
    		nameBuffer.append("SHAPE");
    		valueBuffer.append("sde.st_geometry ('" + String.valueOf(shapeList.get(i).get("geometry")) + "', '" + srid + "')");
    		String insertSql = "insert into " + upLoadName + "(" + nameBuffer.toString() + ") values ("+ valueBuffer.toString() +")"; 
    		System.out.println(insertSql);
    		update(insertSql, GIS);
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
