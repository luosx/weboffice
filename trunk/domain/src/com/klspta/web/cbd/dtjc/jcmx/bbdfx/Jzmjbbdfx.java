package com.klspta.web.cbd.dtjc.jcmx.bbdfx;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.model.CBDReport.bean.TDBean;
import com.klspta.model.CBDReport.bean.TRBean;
import com.klspta.model.CBDReport.dataClass.IDataClass;

public class Jzmjbbdfx extends AbstractBaseBean implements IDataClass {

    @Override
    public Map<String, TRBean> getTRBeans(Object[] obj, TRBean trBean) {
        Map<String, TRBean> trbeans = new LinkedHashMap<String, TRBean>();
        List<Map<String, Object>> ndList = getNd();
        List<Map<String, Object>> xmList = getXmmc();
        if (ndList.size() > 0) {
            trbeans.put("bbdtitle", buildTitle(ndList));
            buildKftlTotal(trbeans, ndList, xmList);
        }
        return trbeans;
    }

    private List<Map<String, Object>> getNd() {
        String sql = "select distinct(nd) from hx_sx order by nd";
        List<Map<String, Object>> list = query(sql, YW);
        return list;
    }

    private List<Map<String, Object>> getXmmc() {
        String sql = "select distinct(xmname) as xmmc from jc_xiangmu t";
        List<Map<String, Object>> list = query(sql, YW);
        return list;
    }

    /**
     * 
     * <br>Description:构建列名
     * <br>Author:陈强峰
     * <br>Date:2013-11-4
     * @param nd
     * @return
     */
    private TRBean buildTitle(List<Map<String, Object>> ndList) {
        TRBean trb = new TRBean();
        trb.setCssStyle("tr01");
        TDBean td = new TDBean("", "130", "");
        td.setStyle("td00");
        trb.addTDBean(td);
        for (int i = 10; i <21; i++) {
            td = new TDBean(i+"", "70", "");
            trb.addTDBean(td);
        }
        td = new TDBean("", "130", "");
        td.setStyle("td01");
        trb.addTDBean(td);
        return trb;
    }

    /**
     * 
     * <br>Description:构建开发体量总计
     * <br>Author:陈强峰
     * <br>Date:2013-11-4
     * @param trbeans
     * @param ndList
     */
    private void buildKftlTotal(Map<String, TRBean> trbeans, List<Map<String, Object>> ndList,
            List<Map<String, Object>> xmList) {
        TRBean trbhs = new TRBean();
        trbhs.setCssStyle("tr02");
        for(int i=0;i<20000;i+=1000){
            TRBean trs = new TRBean();
            trs.setCssStyle("tr02");
            TDBean tds = new TDBean(i+"", "110", "15");
            trs.addTDBean(tds);
            for(int j=10;j<21;j++){
                TDBean tds1 = new TDBean("", "110", "15");
                trs.addTDBean(tds1);
            }
            TDBean tds1 = new TDBean(i+3000+"", "110", "15");
            trs.addTDBean(tds1);
            trbeans.put(i/1000+"", trs);
            if(i==0)i=6000;
        }
    }  
    
    public void getBBDpara(){
        String sql="select * from BBD_PARAMETER";
        List<Map<String,Object>> list=query(sql,YW);
        response(list);
    }
    public void saveBBDpara(){
    	try{
    	String lmbbdstring = request.getParameter("LMBBDSTRING");
    	updateLMBBD(lmbbdstring);
    	String JSQ=request.getParameter("JSQ");
    	String JSQLL=request.getParameter("JSQLL");
    	String JSQSFL=request.getParameter("JSQSFL");
    	String JSCBD=request.getParameter("JSCBD");
    	String MDJ=request.getParameter("MDJ");
    	String YYQLL=request.getParameter("YYQLL");
    	String ZHYYFL=request.getParameter("ZHYYFL");
    	String ZYZJBL=request.getParameter("ZYZJBL");
    	String GLFYBFB=request.getParameter("GLFYBFB");
    	String XSFYBFB=request.getParameter("XSFYBFB");
    	String QTFYBFB=request.getParameter("QTFYBFB");
    	String DZXSJGXS=request.getParameter("DZXSJGXS");
    	String ZYZJDYXBFB=request.getParameter("ZYZJDYXBFB");
    	String ZSYSBL=request.getParameter("ZSYSBL");
    	String CZL=request.getParameter("CZL");
        String sql="update BBD_PARAMETER set JSQ=?,JSQLL=?,JSQSFL=?,JSCBD=?,MDJ=?,YYQLL=?,ZHYYFL=?,ZYZJBL=?,GLFYBFB=?,XSFYBFB=?,QTFYBFB=?,DZXSJGXS=?,ZYZJDYXBFB=?,ZSYSBL=?,CZL=?";
        update(sql,YW,new Object[]{JSQ,JSQLL,JSQSFL,JSCBD,MDJ,YYQLL,ZHYYFL,ZYZJBL,GLFYBFB,XSFYBFB,QTFYBFB,DZXSJGXS,ZYZJDYXBFB,ZSYSBL,CZL});
        response("true");
    	}catch(Exception e){
            response("false");
    	}
    }
    
    public void updateLMBBD(String lmbbdstring){
    	String[] str = lmbbdstring.split(";");
    	String sql = "";
    	for(int i=0;i<str.length;i++){
    		String[] keyvalue = str[i].split(":");
    		sql = "update zfjc.JC_XIANGMU set lmbbd=? where  round(to_number(lmcb),1)*10000=?";
    		update(sql, YW, new Object[]{keyvalue[1],Integer.parseInt(keyvalue[0])});
    		sql = "update zfjc.JC_JIBEN set lmbbd=? where regexp_like(lmcb,'[0-9]') and round(to_number(lmcb)/1000,0)*1000=?";
    		update(sql, YW, new Object[]{keyvalue[1],Integer.parseInt(keyvalue[0])});
    	}
    }
    
    public void setValue(){
        String json=request.getParameter("json");
        //删除数据库数据
        String delSql="delete BBDFXJG where kfcb is not null";
        update(delSql, YW);
        JSONArray jsonArray;
        try {
            jsonArray = UtilFactory.getJSONUtil().jsonToObjects(
                    json.substring(json.indexOf('[')));
        for (int m = 0; m < jsonArray.size(); m++) {
            JSONObject obj = jsonArray.getJSONObject(m);
            String yw_guid = obj.get("cbcb").toString();
            String TZHSQ10 = obj.get("10").toString();
            String TZHSQ11 = obj.get("11").toString();
            String TZHSQ12 = obj.get("12").toString();
            String TZHSQ13 = obj.get("13").toString();
            String TZHSQ14 = obj.get("14").toString();
            String TZHSQ15= obj.get("15").toString();
            String TZHSQ16 = obj.get("16").toString();
            String TZHSQ17 = obj.get("17").toString();
            String TZHSQ18= obj.get("18").toString();
            String TZHSQ19 = obj.get("19").toString();
            String TZHSQ20= obj.get("20").toString();
            String SqlString="insert into  BBDFXJG (KFCB,TZHSQ10,TZHSQ11,TZHSQ12,TZHSQ13,TZHSQ14,TZHSQ15,TZHSQ16,TZHSQ17,TZHSQ18,TZHSQ19,TZHSQ20 )" +
            		"values (?,?,?,?,?,?,?,?,?,?,?,?)";
            update(SqlString, YW, new Object []{yw_guid,TZHSQ10,TZHSQ11,TZHSQ12,TZHSQ13,TZHSQ14,TZHSQ15,TZHSQ16,TZHSQ17,TZHSQ18,TZHSQ19,TZHSQ20});
        }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
