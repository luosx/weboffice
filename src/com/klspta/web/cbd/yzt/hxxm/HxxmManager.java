package com.klspta.web.cbd.yzt.hxxm;




import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.model.CBDReport.CBDReportManager;
import com.klspta.model.CBDReport.tablestyle.ITableStyle;
import com.klspta.web.cbd.yzt.jbb.JbbData;
import com.klspta.web.cbd.yzt.jbb.JbbReport;
import com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow;

public class HxxmManager extends AbstractBaseBean {
	
	public void getHxxm() {
		HttpServletRequest request = this.request;
		response(new HxxmData().getAllList(request));
	}
	
	public void getHxxmmc(){
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("select t.xmname from JC_XIANGMU t");
		List<Map<String, Object>> list = query(sqlBuffer.toString(), YW);
		response(list);
	} 
	
	public void getQuery(){
		HttpServletRequest request = this.request;
		response(new HxxmData().getQuery(request));
	}
	
	public void updateHxxm() {
        HttpServletRequest request = this.request;
        if (new HxxmData().updateHxxm(request)) {
            response("{success:true}");
        } else {
            response("{success:false}");
        }
    }
	
	/**
	 * 
	 * <br>Description:TODO 方法功能描述
	 * <br>Author:黎春行
	 * <br>Date:2013-12-24
	 * @throws Exception 
	 */
	public void update() throws Exception{
    	String xmmc =new String(request.getParameter("key").getBytes("iso-8859-1"), "UTF-8");
    	String index = request.getParameter("vindex");
    	String value = new String(request.getParameter("value").getBytes("iso-8859-1"), "UTF-8");
    	String field = HxxmReport.shows[Integer.parseInt(index)][0];
    	response(String.valueOf(new HxxmData().modifyValue(xmmc, field, value)));
	}
	/**
	 * 
	 * <br>Description:添加一个新的红线项目
	 * <br>Author:黎春行
	 * <br>Date:2013-12-24
	 * @throws Exception 
	 */
	public void insert() throws Exception{
		String xmmc = new String(request.getParameter("xmmc").getBytes("iso-8859-1"), "UTF-8");
    	if (xmmc != null) {
    		xmmc = UtilFactory.getStrUtil().unescape(xmmc);
	        if (new HxxmData().insertHxxm(xmmc)) {
	            response("{success:true}");
	        } else {
	            response("{success:false}");
	        }
    	}else{
    		response("{success:false}");
    	}
	}
	
	/**
	 * 
	 * <br>Description:删除红线项目
	 * <br>Author:黎春行
	 * <br>Date:2013-12-25
	 * @throws Exception
	 */
    public void delete() throws Exception{
    	boolean result = false;
    	HxxmData hxxmData = new HxxmData();
    	String hxxms =new String(request.getParameter("yw_guid").getBytes("iso-8859-1"),"utf-8");
    	String[] hxxmArray = hxxms.split(",");
    	for(int i = 0; i < hxxmArray.length; i++){
    		result = result || hxxmData.delete(hxxmArray[i]);
    	}
    	response(String.valueOf(result));
    }
	
	
	public void draw() throws Exception{
    	//String guid = new String(request.getParameter("guid").getBytes("ISO-8859-1"),"UTF-8");
    	String guid = request.getParameter("guid");
		String polygon = request.getParameter("polygon");
		String type = request.getParameter("type");
    	if (guid != null) {
    		guid = UtilFactory.getStrUtil().unescape(guid);
    	}else{
    		response("{error:not primary}");
    	}
    	boolean draw = false;
		if("3d".equals(type)){
			draw = new HxxmData().recordGIS(guid, polygon,type);
		}else{
			draw = new HxxmData().recordGIS(guid, polygon);
		}
    	
    	response(String.valueOf(draw)); 
	}
	
    /**
     * 
     * <br>Description：红线项目列表过滤
     * <br>Author:黎春行
     * <br>Date:2013-12-25
     * @throws Exception
     */
	public void getReport() throws Exception{
		String keyword = request.getParameter("keyword");
		StringBuffer query = new StringBuffer();
		ITableStyle its = new TableStyleEditRow();
		if(keyword != null){
			query.append(" where ");
			keyword = UtilFactory.getStrUtil().unescape(keyword);
			StringBuffer querybuffer = new StringBuffer();
			String[][] nameStrings = HxxmReport.shows;
			for(int i = 1; i < nameStrings.length - 1; i++){
				querybuffer.append("upper(t.").append(nameStrings[i][0]).append(")||");
			}
			querybuffer.append("upper(t.").append(nameStrings[nameStrings.length - 1][0]).append(")) like '%").append(keyword).append("%'");
			query.append("(");
			query.append(querybuffer);
		}
		Map<String, Object> conditionMap = new HashMap<String, Object>();
		conditionMap.put("query", query.toString());
		response(String.valueOf(new CBDReportManager().getReport("HXXM", new Object[]{conditionMap},its)));
	}
	
	
	public void getdkmc(){
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("select t.dkmc from dcsjk_kgzb t");
		List<Map<String, Object>> list = query(sqlBuffer.toString(), YW);
		response(list);
	} 

	public void getCQSJ(){
		String value = request.getParameter("value");
		String[] dkmcs = value.split(",");
		String sql = "select sum(zd) as zd ,sum(jsyd) as jsyd,round(sum(jzgm)/sum(jsyd)/100,2)||'%' as rjl,sum(jzgm) as jzgm," +
				"sum(gjjzgm)as gjjzgm ,sum(jzjzgm) as jzjzgm ,sum(szjzgm) as szjzgm,sum(kfcb) as kfcb," +
				"round(sum(kfcb)/sum(jsyd),2)*10000 as dmcb,round(sum(kfcb)/sum(jzgm),2)*10000 as lmcb,"+
				"sum(zzsgm) as zzsgm,sum(zzzsgm) as zzzsgm ,sum(zzzshs) as zzzshs,sum(hjmj)" +
				" as hjmj,sum(fzzzsgm) as fzzzsgm,sum(fzzjs) as fzzjs from jc_jiben where dkmc in (";
		for(int i=0;i<dkmcs.length ;i++){
			if(i==dkmcs.length-1){
				sql += " ?)";
			}else {
				sql += " ?,";
			}
		}
		List<Map<String,Object>> list = query(sql, YW,dkmcs);
		response(list);
	}
	
	String[] items = {"xmmc","xh","zd","jsyd","rjl", "jzgm","ghyt", "gjjzgm",
	     "jzjzgm", "szjzgm", "zzsgm", "zzzsgm", "zzzshs", "hjmj", "fzzzsgm", 
	 "fzzjs", "kfcb", "lmcb", "dmcb","yjcjj","yjzftdsy","cxb",  "cqqd", "cbfgl", 
	 "zzcqfy", "qycqfy", "qtfy", "azftzcb", "zzhbtzcb", "cqhbtz","qtfyzb","lmcjj",
	 "fwsj", "zj","jbdk","yw_guid"};
	public void modify(){
		String yw_guid = request.getParameter("yw_guid");
		String[] values = new String[items.length];
		String insertsql = "insert into jc_xiangmu (xmname,xh,zd,jsyd,rjl,jzgm,ghyt,gjjzgm,jzjzgm,szjzgm,zzsgm,zzzsgm,zzzshs," +
				"hjmj,fzzzsgm,fzzjs,kfcb,lmcb,dmcb,yjcjj,yjzftdsy,cxb,cqqd,cbfgl,zzcqfy,qycqfy,qtfy,azftzcb,zzhbtzcb," +
				"cqhbtz,qtfyzb,lmcjj,fwsj,zj,dkmc,yw_guid) values (";
		String updatesql = "update jc_xiangmu set xmname=?,xh=?,zd=?,jsyd=?,rjl=?,jzgm=?,ghyt=?,gjjzgm=?,jzjzgm=?,szjzgm=?,zzsgm=?,zzzsgm=?,zzzshs=?," +
		"hjmj=?,fzzzsgm=?,fzzjs=?,kfcb=?,lmcb=?,dmcb=?,yjcjj=?,yjzftdsy=?,cxb=?,cqqd=?,cbfgl=?,zzcqfy=?,qycqfy=?,qtfy=?,azftzcb=?,zzhbtzcb=?," +
		"cqhbtz=?,qtfyzb=?,lmcjj=?,fwsj=?,zj=?,dkmc=? where yw_guid=?";
		for( int i=0;i<items.length;i++){
			values[i] = request.getParameter(items[i]);
			if(items[i].equals("xh")){
				if(Integer.parseInt("".equals(values[i])?"0":values[i])<10){
					values[i] = "0" + values[i];
				}
			}
			insertsql +="?,";
		}
		insertsql = insertsql.substring(0,insertsql.length()-1);
		insertsql += ")";
		int i = 0;
		if("".equals(yw_guid) || yw_guid==null || "null".equals(yw_guid)){
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd_hhmmss");
            String format = dateFormat.format(new Date());
            values[values.length-1] = format;
            String sql = "insert into jc_cbjhzhb (yw_guid,xmmc) values (?,?)";
            update(sql, YW,new Object[]{format,values[0]});
			i = update(insertsql,YW,values);
		}else{
			i = update(updatesql, YW,values );
			String sql = "update jc_cbjhzhb set xmmc = ? where yw_guid=?";
			update(sql,YW,new Object[]{values[0],yw_guid});
		}
		if(i==1){
			response("{success:true}");
		}else {
			response("{success:false}");
		}
	}
}
