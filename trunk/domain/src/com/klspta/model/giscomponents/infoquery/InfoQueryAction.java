package com.klspta.model.giscomponents.infoquery;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

/**
 * 
 * <br>Title:图斑查询
 * <br>Description:图斑查询AC
 * <br>Author:王雷
 * <br>Date:2011-7-28
 */
public class InfoQueryAction extends AbstractBaseBean {
    /**
     * 
     * <br>Description:图斑查询结果
     * <br>Author:王雷
     * <br>Date:2011-7-28
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public void query() throws Exception {
        int intPageSize; //一页显示的记录数
        int intRowCount; //记录总数
        int intPageCount;//总页数
        intPageSize = 10;//每页显示10条
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + path + "/";
        String treeid = request.getParameter("treeid");
        String keyWord = UtilFactory.getStrUtil().unescape(request.getParameter("keyWord"));
        String sql = "select t.serverid,t.layerid,t.queryfields,t.layername from gis_maptree t where t.treeid=?";
        Object[] args = { treeid };
        StringBuffer sb = new StringBuffer();
        String[] fields = null; //列名内容数组
        List<Map<String,Object>> fieldList = query(sql,CORE,args);
        Map<String,Object> fieldMap = (Map<String,Object>) fieldList.get(0);
        String serverId=(String)fieldMap.get("serverid");//地图服务id
        String layerId=(String)fieldMap.get("layerid");  //地图服务中对应的图层id      
        String fieldString = (String) fieldMap.get("queryfields");
        if(fieldString==null){
            response.getWriter().write("");
        }else{         
            fields = fieldString.split(",");
            String layerName = (String) fieldMap.get("layername");
            String whereString = fieldString.replace(",", "||");
            String sql2 = "select objectid," + fieldString + " ,t.shape.maxx||','||t.shape.maxy maxpoint ,t.shape.minx||','||t.shape.miny minpoint  from " + layerName  + " t where " + whereString
                    + " like ? order by objectid";//and rownum<=10
            Object[] args2 = { "%" + keyWord + "%" };
            List<Map<String,Object>> rows = query(sql2,GIS, args2); //获得查询数据	
            //获取记录总数
            intRowCount = rows.size();
            List<Object> objList=new ArrayList<Object>();
            List<Object> pointList=new ArrayList<Object>();
            if (rows != null && rows.size() > 0) {
                for (int i = 0; i < rows.size(); i++) {                   
                    if (i % 10 == 0) {                      
                        sb.append("<img src='" + basePath
                                + "/gisapp/images/a.png' style='position:relative;top:12px;'>&nbsp;");
                    }
                    if (i % 10 == 1) {
                        sb.append("<img src='" + basePath
                                + "/gisapp/images/b.png' style='position:relative;top:12px;'>&nbsp;");
                    }
                    if (i % 10 == 2) {
                        sb.append("<img src='" + basePath
                                + "/gisapp/images/c.png' style='position:relative;top:12px;'>&nbsp;");
                    }
                    if (i % 10 == 3) {
                        sb.append("<img src='" + basePath
                                + "/gisapp/images/d.png' style='position:relative;top:12px;'>&nbsp;");
                    }
                    if (i % 10 == 4) {
                        sb.append("<img src='" + basePath
                                + "/gisapp/images/e.png' style='position:relative;top:12px;'>&nbsp;");
                    }
                    if (i % 10 == 5) {
                        sb.append("<img src='" + basePath
                                + "/gisapp/images/f.png' style='position:relative;top:12px;'>&nbsp;");
                    }
                    if (i % 10 == 6) {
                        sb.append("<img src='" + basePath
                                + "/gisapp/images/g.png' style='position:relative;top:12px;'>&nbsp;");
                    }
                    if (i % 10 == 7) {
                        sb.append("<img src='" + basePath
                                + "/gisapp/images/h.png' style='position:relative;top:12px;'>&nbsp;");
                    }
                    if (i % 10 == 8) {
                        sb.append("<img src='" + basePath
                                + "/gisapp/images/i.png' style='position:relative;top:12px;'>&nbsp;");
                    }
                    if (i % 10 == 9) {
                        sb.append("<img src='" + basePath
                                + "/gisapp/images/j.png' style='position:relative;top:12px;'>&nbsp;");
                    }
                    Map<String,Object> map = (Map<String,Object>) rows.get(i);
                    objList.add(map.get("objectid"));
                    pointList.add(map.get("maxpoint"));
                    pointList.add(map.get("minpoint"));
                    if(objList.size()>10){                
                        objList.clear();
                        objList.add(map.get("objectid"));
                    }
                    if(pointList.size()>20){
                        pointList.clear();
                        pointList.add(map.get("maxpoint"));
                        pointList.add(map.get("minpoint"));
                    }                  
                    for (int j = 0; j < fields.length; j++) {
                    	if(map.get(fields[j])==null||"null".equals(map.get(fields[j]))){
                    		continue;
                    	}
                        if (j == 0) {
                            sb.append("<a href='#' onclick='locationMap(\""+serverId+"\","+layerId+","+map.get("objectid")+")'><font color='blue'>"
                                    + map.get(fields[j]) + "</font></a><br>");
                            continue;
                        }
                        sb.append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + map.get(fields[j])
                                        + "<br>");
                    } 
                    intPageCount=(rows.size()+intPageSize-1)/intPageSize;
                    if(i % 10 == 9&&rows.size()>10){                       
                        if (i+1 < intRowCount) {     
                            sb.append("共").append(intPageCount).append("页");
                            sb.append("<button class='btn' style='position:relative;left:80px;' onclick='nextPage()'"
                                + "'>下一页</button>");
                            sb.append("<button class='btn' style='position:relative;left:80px;' onclick='overview(\""+serverId+"\","+layerId+","+objList+","+pointList+")'"
                                + "'>全局监控</button>");
                        }else{
                            sb.append("&nbsp;&nbsp;&nbsp;共").append(intPageCount).append("页");
                            sb.append("<button class='btn' style='position:relative;left:80px;' disabled='disabled'"
                                   + "'>下一页</button>"); 
                            sb.append("<button class='btn' style='position:relative;left:80px;' onclick='overview(\""+serverId+"\","+layerId+","+objList+","+pointList+")'"
                                    + "'>全局监控</button>");
                        }
                      sb.append("@@");
                    }else if(i==rows.size()-1){
                        sb.append("&nbsp;&nbsp;&nbsp;共").append(intPageCount).append("页");
                        sb.append("<button class='btn' style='position:relative;left:80px;' disabled='disabled'"
                                + "'>下一页</button>");  
                        sb.append("<button class='btn' style='position:relative;left:80px;' onclick='overview(\""+serverId+"\","+layerId+","+objList+","+pointList+")'"
                                + "'>全局监控</button>");
                        sb.append("@@");
                    }
                }
            } else {
                response.getWriter().write("");
            }
                response.getWriter().write(UtilFactory.getStrUtil().escape(sb.toString()));
        }
        //return null;
    }
}
