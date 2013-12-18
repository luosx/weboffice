package com.klspta.web.xiamen.xchc.importwycg;

import java.io.File;
import java.rmi.server.UID;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.wkt.Point;
import com.klspta.base.wkt.Polygon;
import com.klspta.base.wkt.Ring;
import com.klspta.console.ManagerFactory;
import com.klspta.console.user.User;
import com.klspta.model.wyrw.AResultImp;

/**
 * 
 * <br>Title:巡查核查成果导入
 * <br>Description:厦门巡查核查成果导入
 * <br>Author:黎春行
 * <br>Date:2013-12-2
 */
public class XmResultImp extends  AResultImp {
	private Map<String, String[][]> saveMap = getCondition();
	private String form_name = "DC_YDQKDCB";
	private String gis_name = "dlgzwyr";
	private String srid_name = "dlgzwpr";
	private String yw_guid = "";
	
	public XmResultImp(String formName, String gisName,HttpServletRequest request) {
		super(request);
		form_name = formName;
		gis_name = gisName;
	}
	
	public XmResultImp(HttpServletRequest request){
		super(request);
	}

	@Override
	public void expResult() {
				
	}

	@Override
	public void saveData() {
		String zipPath = tempFile();
		if (zipPath != null) {
			File zipFile = new File(zipPath);
			String folderpath = tempPath + zipFile.getParentFile().getName();
            //解压缩
            UtilFactory.getZIPUtil().unZip(zipPath, folderpath);
            //xml读取
            int count = importData(folderpath);
            //上传附件
            importAccessoryField(folderpath);
            response("{success:true,msg:" + count + "}");
		}
	}
	
	/**
	 * 
	 * <br>Description:分别定义从成果包中获取的字段
	 * <br>Author:黎春行
	 * <br>Date:2013-12-2
	 * @return
	 */
	private Map<String,String[][]> getCondition(){
		Map<String, String[][]> saveMap = new HashMap<String, String[][]>();
		// String[][] ywStrings = new String[]{{"xznyd","xznyd"},{"xzwlyd","xzwlyd"},"ghjinzh","ygspmj","ygspbl","yggdbl","yggdmj","ghjbnt","ghfuh","ghxianzh","ghbufh","ghyoutj","ghyunx","xzjsyd","xzgd","taskType","taskid","endDate","beginDate","dfccqk","jsqk","wflx","area","wfwglx","zbs","sfwf","xcqkms","yddw","xy","picture","ydsj","ydqk"}; 
		String[][] ywStrings = new String[][]{{"xznyd","xznyd"},{"xzwlyd","xzwlyd"},{"taskid","yw_guid"},{"ydsj","ydsj"},{"yddw","yddw"},{"area","mj"},{"zbs","zb"},{"jsqk","jsqk"},{"wfwglx","wfwglx"},{"dfccqk","dfccqk"},{"xcqkms","xcqkms"},{"ydqk","ydqk"},{"ygspmj","ygspmj"},{"ygspbl","ygspbl"},{"yggdbl","yggdbl"},{"yggdmj","yggdmj"},{"beginDate","beginDate"},{"taskType","taskType"},{"endDate","endDate"},{"wflx","wflx"},{"sfwf","sfwf"}};
		String[][] gisStrings = new String[][]{{"taskType","tasktype"},{"wflx","wflx"},{"yddw","yddw"},{"ydqk","ydqk"},{"ydsj","ydsj"},{"taskid", "yw_guid"}};
		saveMap.put("yw", ywStrings);
		saveMap.put("gis", gisStrings);
		return saveMap;
	}
		
	private int importData(String path){
		int count = 0;
		File f = new File(path);
		File[] files = f.listFiles();
        for (int i = 0; i < files.length; i++) {
            File file = new File(files[i].getAbsolutePath());
            if(file.getAbsolutePath().toLowerCase().endsWith("xml")){
            	count += parseXml(file.getAbsolutePath());
            	continue;
            }
            File[] childList = file.listFiles();
            if(childList == null){
            	continue;
            }
            for (int j = 0; j < childList.length; j++) {
                String str = childList[j].getAbsolutePath();
                if (str.toLowerCase().endsWith("xml")) {
                    count += parseXml(str);
                }
            }
        }
		return count;
	}
	
	/**
	 * 
	 * <br>Description:解析XML信息入库
	 * <br>Author:黎春行
	 * <br>Date:2013-12-2
	 * @param xmlPath
	 * @return
	 */
	private int parseXml(String xmlPath){
		int count = 0;
		try{
			File file = new File(xmlPath);
			SAXReader sax = new SAXReader();
			Document document = sax.read(file);
			Element root = document.getRootElement();
			count = insertYW(root);
			insertGIS(root);
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			
		}
		return count;
	}

	/**
	 * 
	 * <br>Description:导入业务数据
	 * <br>Author:黎春行
	 * <br>Date:2013-12-2
	 * @param root
	 * @return
	 * @throws Exception 
	 */
	private int  insertYW(Element root) throws Exception{
		StringBuffer updatenames = new StringBuffer();
		StringBuffer insertNames = new StringBuffer();
		String primaryName = "";
		String primaryValue = "";
		String insertValue = "";
		String[][] impFields = saveMap.get("yw");
		Object[] valueObjects = new Object[impFields.length + 2];
		int num = 0;
		for(int i = 0; i < impFields.length; i++){
			if(impFields[i][1] == "yw_guid"){
				primaryName = "yw_guid";
				primaryValue = root.element(impFields[i][0]).getText();
				this.yw_guid = primaryValue;
			}else{
				insertNames.append(impFields[i][1]).append(",");
				updatenames.append(impFields[i][1]).append("=?,");
				insertValue += "?,";
				String value = root.element(impFields[i][0]).getText();
				valueObjects[num] = value;
				num++;
			}
		}
		//添加导入人员的行政区划
		insertNames.append("impuser,impxzq,impxzqbm,");
		insertValue +="?,?,?,";
		updatenames.append("impuser=?,impxzq=?,impxzqbm=?,");
		User user = ManagerFactory.getUserManager().getUserWithId(userid);
		valueObjects[num++] = user.getFullName();
		valueObjects[num++] = UtilFactory.getXzqhUtil().getNameByCode(user.getXzqh());
		valueObjects[num] = user.getXzqh();
		
		
		String updatename = updatenames.substring(0, updatenames.length() - 1);
		boolean isExit = isExit(form_name, primaryName, primaryValue, AbstractBaseBean.YW);
		if(isExit){
			//主键存在时，更新数据
			StringBuffer sql = new StringBuffer();
			sql.append("update ").append(form_name).append(" set ").append(updatename).append(" where ");
			sql.append(primaryName).append("='").append(primaryValue).append("'");
			update(sql.toString(), YW, valueObjects);
		}else{
			//主键不存在时，导入数据
			StringBuffer sql = new StringBuffer();
			sql.append("insert into ").append(form_name).append("(").append(insertNames).append(primaryName).append(") values(");
			sql.append(insertValue).append("'").append(primaryValue).append("')");
			update(sql.toString(), YW, valueObjects);
		}
		
		return 1;
	}
	
	/**
	 * 
	 * <br>Description:导入空间库
	 * <br>Author:黎春行
	 * <br>Date:2013-12-2
	 * @param root
	 * @return
	 */
	private int insertGIS(Element root){
		String wkt = "";
		String zbs = root.element("zbs").getText();
		String[] allPoint = zbs.split(";");
		Polygon polygon = new Polygon();
		Ring ring = new Ring();
		if(allPoint.length > 2){
			for(int i = 0; i < allPoint.length; i++){
				String[] points = allPoint[i].split(",");  
				double x = Double.parseDouble(points[0]);
				double y = Double.parseDouble(points[1]);
				Point p = new Point(x, y);
				ring.putPoint(p);
			}
			String[] points = allPoint[0].split(",");
			Point p2 = new Point(Double.parseDouble(points[0]), Double.parseDouble(points[1]));
			ring.putPoint(p2);
			polygon.addRing(ring);
			wkt = polygon.toWKT();	
		}
		
		String querySrid = "select t.shape.srid srid from "+ srid_name +" t where rownum =1";
        String srid = null;
        List<Map<String, Object>> rs = query(querySrid, GIS);
        if(rs.size() > 0){
        	srid = rs.get(0).get("srid") + "";
        }
        
		StringBuffer updatenames = new StringBuffer();
		StringBuffer insertNames = new StringBuffer();
		String primaryName = "";
		String primaryValue = "";
		String insertValue = "";
		String[][] impFields = saveMap.get("gis");
		Object[] valueObjects = new Object[impFields.length - 1];
		int num = 0;
		for(int i = 0; i < impFields.length; i++){
			if(impFields[i][1] == "yw_guid"){
				primaryName = "yw_guid";
				primaryValue = root.element(impFields[i][0]).getText();
			}else{
				insertNames.append(impFields[num][1]).append(",");
				updatenames.append(impFields[num][1]).append("=?,");
				insertValue += "?,";
				String value = root.element(impFields[num][0]).getText();
				value=value==""?"null":value;
				valueObjects[num] = value;
				num++;
			}
		}
		updatenames.append("SHAPE");
		insertNames.append("SHAPE,");
		String updatename = updatenames.toString();
		String shapeValue = "sde.st_geometry ('" + wkt + "', " + srid + ")";
		
		boolean isExit = isExit(gis_name, primaryName, primaryValue, AbstractBaseBean.GIS);
		if(isExit){
			//主键存在时，更新数据
			//StringBuffer sql = new StringBuffer();
			//sql.append("update ").append(gis_name).append(" set ").append(updatename).append(" where ");
			//sql.append(primaryName).append("='").append(primaryValue).append("'");
			//update(sql.toString(), GIS, valueObjects);
		}else{
			//主键不存在时，导入数据
			StringBuffer sql = new StringBuffer();
			String objectId = String.valueOf(query("select nvl(max(OBJECTID)+1,1) AS OBJECTID from " + gis_name, GIS).get(0).get("objectid"));
			sql.append("insert into ").append(gis_name).append("(").append(insertNames).append(primaryName).append(",OBJECTID) values(");
			sql.append(insertValue).append(shapeValue).append(",'").append(primaryValue).append("',").append(objectId).append(")");
			update(sql.toString(), GIS, valueObjects);
		}
		
		return 1;
	}
	
	private boolean isExit(String formName, String primaryName, String primaryValue, String type){
		if("".equals(primaryName) || "".equals(primaryValue)){
			return false;
		}
		String sql = "select " + primaryName + " from " + formName + " where " + primaryName + "='" + primaryValue + "'";
		List<Map<String, Object>> list = query(sql, type);
		if(list.size() > 0){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 
	 * <br>Description:附件上传管理类
	 * <br>Author:黎春行
	 * <br>Date:2013-12-3
	 * @param filePath
	 */
	private void importAccessoryField(String filePath){
        File f = new File(filePath);
        File[] files = f.listFiles();
        //数据更新前删除旧的数据
        String sql= "delete from atta_accessory where yw_guid = ?";
        update(sql, CORE, new Object[] { yw_guid });
        for (int i = 0; i < files.length; i++) {
            if (files[i].getAbsolutePath().endsWith(".txt")) {
                continue;
            }
            accUpload(files[i]);
        }
	}
	
    /**
     * 
     * <br>Description:根据文件夹名上传相应文件夹下的附件
     * <br>Author:陈强峰
     * <br>Date:2012-7-4
     * @param file
     */
    private void accUpload(File file) {
    	
        File[] files = file.listFiles();
        if(files == null || file.getAbsolutePath().endsWith("shape")){
        	return ;
        }
        for (int i = 0; i < files.length; i++) {
            if (files[i].getAbsolutePath().endsWith(".xml")) {
                continue;
            }
            dealAcc(files[i]);
        }
        String sql = "select file_id,file_name from atta_accessory where yw_guid=?";
        List<Map<String, Object>> list = query(sql, CORE, new Object[] { yw_guid });
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = list.get(i);
            if (map.get("file_name").toString().endsWith("jpg")) {
                if (i == list.size() - 1) {
                    sb.append(map.get("file_id"));
                } else {
                    sb.append(map.get("file_id")).append(",");
                }
            }
        }
        
        
        sql = "update "+form_name+" set zpbh=? where yw_guid=?";
        update(sql, YW, new Object[] { sb.toString(), yw_guid });
    }
    
    /**
     * 
     * <br>Description:处理附件名等参数
     * <br>Author:陈强峰
     * <br>Date:2012-7-4
     * @param file
     */
    private void dealAcc(File file) {
        String filename = file.getName();
        String fileSuffix = filename.substring(filename.lastIndexOf("."));
        String file_id = new UID().toString().replaceAll(":", "-");
        String newFilePath = file_id + fileSuffix;
        File newFile = new File(newFilePath);
        file.renameTo(newFile);
        if (UtilFactory.getFtpUtil().uploadFile(newFilePath)) {
            String sql = "insert into atta_accessory(file_id,file_type,file_name,file_path,yw_guid) values(?,?,?,?,?)";
            update(sql, CORE, new Object[] { file_id, "file", filename, newFilePath, yw_guid});
        }
    }
}
