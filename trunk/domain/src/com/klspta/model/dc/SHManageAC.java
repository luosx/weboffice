package com.klspta.model.dc;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.klspta.base.AbstractBaseBean;
import com.klspta.model.giscomponents.shtc.ShtcDataOperation;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

/**
 * <br>Title:图层标注管理类
 * <br>Description:
 * <br>Author:郭润沛
 * <br>Date:2012-4-7
 */
public class SHManageAC extends AbstractBaseBean  {

    /**
     * <br>Description:修改地图标注图层的状态
     * <br>Author:郭润沛
     * <br>Date:2012-4-7
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public void updateStatus() throws Exception {
        String yw_guid=request.getParameter("yw_guid");
        String sql_point="update dc_edit_point set flag='1' where yw_guid=?";
        String sql_polygon="update dc_edit_polygon set flag='1' where yw_guid=?";
        String sql_table="update dc_ydqkdcb set flag='1',status='1' where yw_guid=?";
        String del="delete from dc_ydqkdcb where flag='0'";
        String delpolygon="delete from dc_edit_polygon where flag='0'";
        String delpoint="delete from dc_edit_point where flag='0'";
        Object[] args={yw_guid};
        //Globals.getGisJdbcTemplate().update(sql_point,GIS,args);
        //Globals.getGisJdbcTemplate().update(sql_polygon, args);
        //Globals.getYwJdbcTemplate().update(sql_table, args);
        //Globals.getYwJdbcTemplate().update(del);
        //Globals.getGisJdbcTemplate().update(delpolygon);
        //Globals.getGisJdbcTemplate().update(delpoint);
        //response.getWriter().write("success");
        update(sql_point, GIS, args);
        update(sql_polygon, GIS, args);
        update(sql_table, YW, args);
        update(del, YW);
        update(delpoint, GIS);
        update(delpolygon, GIS);
        response("success");
    }

    public void updatePhotoText() throws Exception {
        String path = request.getParameter("path");
        String yw_guid = request.getParameter("yw_guid");
        doit(path, yw_guid);
        //response.getWriter().write("success");
        response("success");
    }
    
    public void saveTBBH() throws Exception {
    	//response.setCharacterEncoding("utf-8");
    	request.setCharacterEncoding("UTF-8");
        String ids = request.getParameter("ids");
        ids="'"+(ids.replaceAll(",", "','"))+"'";
        String sql="insert into DC_YDQKDCB(YW_GUID,xh,rwmc,zb,flag,status) (select 'HC'||t.tbbh,'HC'||t.tbbh,t.tbbh,(t.shape.minx+t.shape.maxx)/2||','||(t.shape.miny+t.shape.maxy)/2,'1','0' from giser.dc_bhtb t where t.tbbh in("+ids+"))";
        //Globals.getYwJdbcTemplate().update(sql);
        update(sql, YW);
        //response.getWriter().write("success");
        response("success");
    }
    public void checkTBBH() throws Exception {
    	response.setCharacterEncoding("utf-8");
        String ids = request.getParameter("ids");
        String[] tbbhs=ids.split(",");
        String str="";
        String str1=""; //编号不匹配
        String str2=""; //已在核查任务中
        String str3=""; //已核查完成 
        String str4=""; //有效图斑编号
        List list=new ArrayList(); //无效图斑编号
        
        
        for(int i=0;i<tbbhs.length;i++){
        	if(i==tbbhs.length-1){
        	   str+="'"+tbbhs[i].trim()+"'";
        	}else{
        	   str+="'"+tbbhs[i].trim()+"',";
        	}
        } 
        String sql1="select t.tbbh from dc_bhtb t  where t.tbbh in("+str+")";
        //List list1=Globals.getGisJdbcTemplate().queryForList(sql1);
        List<Map<String, Object>> list1 = query(sql1, GIS);
        for(int i=0;i<tbbhs.length;i++){
        	boolean flag=true;
            for(int j=0;j<list1.size();j++){
            	Map map=(Map)list1.get(j);
            	if(tbbhs[i].equals((String)map.get("tbbh"))){
            		flag=false;
            	}
            }
            if(flag){
            	str1+=tbbhs[i]+",";
            	list.add(tbbhs[i]);
            }
        }
        if(!"".equals(str1)){
          str1=tbbhs.length-list1.size()+"个（"+str1.substring(0,str1.length()-1)+"）";
        }else{
          str1=tbbhs.length-list1.size()+"个";
        }
        
        String sql2="select t.RWMC from DC_YDQKDCB t where t.RWMC in("+str+") and status='0'";
        //List list2=Globals.getYwJdbcTemplate().queryForList(sql2);
        List<Map<String, Object>> list2 = query(sql2, YW); 
        for(int i=0;i<list2.size();i++){
        	Map map=(Map)list2.get(i);
        	str2+=(String)map.get("rwmc")+",";
        	list.add((String)map.get("rwmc"));
        }
        if(!"".equals(str2)){
          str2=list2.size()+"个（"+str2.substring(0,str2.length()-1)+"）";
        }else{
          str2=list2.size()+"个";
        }
        
        String sql3="select t.RWMC from DC_YDQKDCB t where t.RWMC in("+str+") and status='1'";
        //List list3=Globals.getYwJdbcTemplate().queryForList(sql3);
        List<Map<String, Object>> list3 = query(sql3, YW);
        for(int i=0;i<list3.size();i++){
        	Map map=(Map)list3.get(i);
        	str3+=(String)map.get("rwmc")+",";
        	list.add((String)map.get("rwmc"));
        }
        if(!"".equals(str3)){
          str3=list3.size()+"个（"+str3.substring(0,str3.length()-1)+"）";
        }else{
          str3=list3.size()+"个";	
        }
        
        for(int i=0;i<tbbhs.length;i++){
        	boolean flag=true;
        	for(int j=0;j<list.size();j++){
        		if(tbbhs[i].equals((String)list.get(j))){
        			flag=false;
        		}
        	}
        	if(flag){
        		str4+=tbbhs[i]+",";
        	}
        }
        
        if(!str4.equals("")){
        	str4=str4.substring(0,str4.length()-1);
        }
        String result=tbbhs.length+"@"+(tbbhs.length-(tbbhs.length-list1.size())-list2.size()-list3.size())+"@"+str1+"@"+str2+"@"+str3+"@"+str4;
        
        //response.getWriter().write(result);
        response(result);
    }
    
    
	/**
	 * 
	 * <br>
	 * Description:删除待核查的信息<br>
	 * Author:王峰 <br>
	 * Date:2011-7-28
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public void delDHC() throws Exception {
		    response.setCharacterEncoding("UTF-8");
	        String id = request.getParameter("id");
	        String msg = "";
	        try {
	        	ShtcDataOperation.getInstance().delShtcInfo(id);
	            //response.getWriter().write("true");
	        	msg = "true";
	        } catch (Exception ex) {
	            //response.getWriter().write("false");
	        	msg = "false";
	        }
	        response(msg);
    }
	public void saveXY() throws Exception {
        String x = request.getParameter("x");
        String y = request.getParameter("y");
        String sql="insert into WY_GPS_LOCATION_LOG(gps_id,gps_x,gps_y) values(?,?,?)";
        Object[] args={"dc001",x,y};
        //Globals.getYwJdbcTemplate().update(sql,args);
        update(sql, YW, args);
        System.out.println("插入一条坐标："+x+"========="+y);
    }
	public void expExcel() throws Exception {
	    response.setCharacterEncoding("UTF-8");
	    String flag=request.getParameter("flag");
	    ExpExcelOperation e=new ExpExcelOperation();
	    e.exportClassroom(flag);
        // response.getWriter().write("true");
	    response("true");
    }
	
    public void analyseXcHc() throws Exception {
    	response.setCharacterEncoding("utf-8");
    	String start=request.getParameter("start");
    	String end=request.getParameter("end");
    	DecimalFormat a = new DecimalFormat("0.00");
    	int HCall=0;
    	int HChf=0;
    	int HCwf=0;
    	double HCallMj=0.00;
    	double HChfMj=0.00;
    	double HCwfMj=0.00;
    	int XCall=0;
    	int XChf=0;
    	int XCwf=0;
    	double XCallMj=0.00;
    	double XChfMj=0.00;
    	double XCwfMj=0.00;
    	String HCallcount="select mj from DC_YDQKDCB where XH like '%HC%' and (status='1' or status='!0!1') and HCRQ>=to_date('"+start+"','yyyy-mm-dd HH24:mi:ss') and HCRQ<=to_date('"+end+"','yyyy-mm-dd HH24:mi:ss')";
    	//List HCalllist=Globals.getYwJdbcTemplate().queryForList(HCallcount);
    	List<Map<String, Object>> HCalllist = query(HCallcount, YW);
    	HCall=HCalllist.size();
    	for(int i=0;i<HCall;i++){
    		Map map=(Map)HCalllist.get(i);
    		if(map.get("mj")!=null){
    		HCallMj+=Double.parseDouble((String)map.get("mj"));
    		}
    	}
    	String HCisBeiAn="select mj from DC_YDQKDCB where XH like '%HC%' and (status='1' or status='!0!1') and ISBEIAN='1' and HCRQ>=to_date('"+start+"','yyyy-mm-dd HH24:mi:ss') and HCRQ<=to_date('"+end+"','yyyy-mm-dd HH24:mi:ss')";
    	//List HChflist=Globals.getYwJdbcTemplate().queryForList(HCisBeiAn);
    	List<Map<String, Object>> HChflist = query(HCisBeiAn, YW);
    	HChf=HChflist.size();
    	for(int i=0;i<HChf;i++){
    		Map map=(Map)HChflist.get(i);
    		if(map.get("mj")!=null){
    		HChfMj+=Double.parseDouble((String)map.get("mj"));
    		}
    	}
    	String HCnoBeiAn="select mj from DC_YDQKDCB where XH like '%HC%' and (status='1' or status='!0!1') and ISBEIAN='0' and HCRQ>=to_date('"+start+"','yyyy-mm-dd HH24:mi:ss') and HCRQ<=to_date('"+end+"','yyyy-mm-dd HH24:mi:ss')";
    	//List HCwflist=Globals.getYwJdbcTemplate().queryForList(HCnoBeiAn);
    	List<Map<String, Object>> HCwflist = query(HCnoBeiAn, YW);
    	HCwf=HCwflist.size();
    	for(int i=0;i<HCwf;i++){
    		Map map=(Map)HCwflist.get(i);
    		if(map.get("mj")!=null){
    		HCwfMj+=Double.parseDouble((String)map.get("mj"));
    		}
    	}
    	String XCallcount="select mj from DC_YDQKDCB where XH like '%XC%' and (status='1' or status='!0!1') and HCRQ>=to_date('"+start+"','yyyy-mm-dd HH24:mi:ss') and HCRQ<=to_date('"+end+"','yyyy-mm-dd HH24:mi:ss')";
    	//List XCalllist=Globals.getYwJdbcTemplate().queryForList(XCallcount);
    	List<Map<String, Object>> XCalllist = query(XCallcount, YW);
    	XCall=XCalllist.size();
    	for(int i=0;i<XCall;i++){
    		Map map=(Map)XCalllist.get(i);
    		if(map.get("mj")!=null){
    		XCallMj+=Double.parseDouble((String)map.get("mj"));
    		}
    	}
    	String XCisBeiAn="select mj from DC_YDQKDCB where XH like '%XC%' and (status='1' or status='!0!1') and ISBEIAN='1' and HCRQ>=to_date('"+start+"','yyyy-mm-dd HH24:mi:ss') and HCRQ<=to_date('"+end+"','yyyy-mm-dd HH24:mi:ss')";
    	//List XChflist=Globals.getYwJdbcTemplate().queryForList(XCisBeiAn);
    	List<Map<String, Object>> XChflist = query(XCisBeiAn, YW); 
    	XChf=XChflist.size();
    	for(int i=0;i<XChf;i++){
    		Map map=(Map)XChflist.get(i);
    		if(map.get("mj")!=null){
    		XChfMj+=Double.parseDouble((String)map.get("mj"));
    		}
    	}
    	String XCnoBeiAn="select mj from DC_YDQKDCB where XH like '%XC%' and (status='1' or status='!0!1') and ISBEIAN='0' and HCRQ>=to_date('"+start+"','yyyy-mm-dd HH24:mi:ss') and HCRQ<=to_date('"+end+"','yyyy-mm-dd HH24:mi:ss')";
    	//List XCwflist=Globals.getYwJdbcTemplate().queryForList(XCnoBeiAn);
    	List<Map<String, Object>> XCwflist = query(XCnoBeiAn, YW);
    	XCwf=XCwflist.size();
    	for(int i=0;i<XCwf;i++){
    		Map map=(Map)XCwflist.get(i);
    		if(map.get("mj")!=null){
    		XCwfMj+=Double.parseDouble((String)map.get("mj"));
    		}
    	}
    	
    	String wfhc="select mj from DC_YDQKDCB where XH like '%HC%' and (status='1' or status='!0!1') and ISBEIAN='0' and WFWGLX and HCRQ>=to_date('"+start+"','yyyy-mm-dd HH24:mi:ss') and HCRQ<=to_date('"+end+"','yyyy-mm-dd HH24:mi:ss')";
    	String result=HCall+"@"+a.format(HCallMj)+"@"+HChf+"@"+a.format(HChfMj)+"@"+HCwf+"@"+a.format(HCwfMj)+"@"+XCall+"@"+a.format(XCallMj)+"@"+XChf+"@"+a.format(XChfMj)+"@"+XCwf+"@"+a.format(XCwfMj)+"@";
        response(result);
    	//response.getWriter().write(result);
    }
    private void doit(String path, String yw_guid){
        File dir = new File(path + "\\" + yw_guid);
        File file[] = dir.listFiles();
        String pressText = "";
        if(yw_guid.startsWith("XC")){
            pressText = "巡查编号：" + yw_guid;
        }else{
            pressText = "核查编号：" + yw_guid;
        }
        for (int i = 0; i < file.length; i++) {
            pressImage("C:\\klspta\\1.bmp", file[i].getAbsolutePath(), 0, 0);
            pressText(pressText, file[i].getAbsolutePath(), "宋体", 10, 20, 30, 380, -5);
        }
    }

    private void pressText(String pressText, String targetImg, String fontName, int fontStyle, int color, int fontSize, int x, int y) {
        try {
            File _file = new File(targetImg);
            Image src = ImageIO.read(_file);
            int wideth = src.getWidth(null);
            int height = src.getHeight(null);
            BufferedImage image = new BufferedImage(wideth, height, BufferedImage.TYPE_INT_RGB);
            Graphics g = image.createGraphics();
            g.drawImage(src, 0, 0, wideth, height, null);
            //  String s="www.qhd.com.cn"; 
            g.setColor(Color.RED);
            g.setFont(new Font(fontName, fontStyle, fontSize));

            g.drawString(pressText, wideth - fontSize - x, height - fontSize / 2 - y);
            g.dispose();
            FileOutputStream out = new FileOutputStream(targetImg);
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
            encoder.encode(image);
            out.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    private void pressImage(String pressImg, String targetImg, int x, int y) {
        try {
            File _file = new File(targetImg);
            Image src = ImageIO.read(_file);
            int wideth = src.getWidth(null);
            int height = src.getHeight(null);
            BufferedImage image = new BufferedImage(wideth, height, BufferedImage.TYPE_INT_RGB);
            Graphics g = image.createGraphics();
            g.drawImage(src, 0, 0, wideth, height, null);
            File _filebiao = new File(pressImg);
            Image src_biao = ImageIO.read(_filebiao);
            int wideth_biao = src_biao.getWidth(null);
            int height_biao = src_biao.getHeight(null);
            g.drawImage(src_biao, wideth - wideth_biao - x, height - height_biao - y, wideth_biao, height_biao, null);
            g.dispose();
            FileOutputStream out = new FileOutputStream(targetImg);
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
            encoder.encode(image);
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
