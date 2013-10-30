package com.klspta.web.cbd.yzt.jbb;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.web.cbd.yzt.utilList.IData;

public class JbbData extends AbstractBaseBean implements IData  {
	private static final String formName = "JC_JIBEN";
	private static final String zrformName = "JC_ZIRAN";
	
	public static List<Map<String, Object>> jbbList;
	@Override
	public List<Map<String, Object>> getAllList(HttpServletRequest request) {
		if(jbbList == null){
		    StringBuffer sql = new StringBuffer();
		    sql.append("select rownum xh,t.* from ").append(formName).append(" t") ;
	        List<Map<String, Object>> resultList = query(sql.toString(), YW);
	        jbbList = addZrb(resultList);
		}
		return jbbList;
	}

	@Override
	public List<Map<String, Object>> getQuery(HttpServletRequest request) {
		String keyWord = request.getParameter("keyWord");
		StringBuffer querySql = new StringBuffer();
		querySql.append("select  rownum xh,t.* from ").append(formName).append(" t");
		if(keyWord != null){
			keyWord = UtilFactory.getStrUtil().unescape(keyWord);
			querySql.append(" where dkmc like '%");
			querySql.append(keyWord).append("%'");
		}
		List<Map<String, Object>> resultList = query(querySql.toString(), YW);
		return addZrb(resultList);
	}
	
	
	private List<Map<String, Object>> addZrb(List<Map<String, Object>> resultList){
		String zrb = "select t.zrbbh from " + zrformName + " t where t.jbguid = ?";
		for(int i = 0; i < resultList.size(); i++){
			String zrbbh = "";
			Map<String, Object> resultMap = resultList.get(i);
			String jbGuid = String.valueOf(resultMap.get("YW_GUID"));
			List<Map<String, Object>> zrList = query(zrb, YW, new Object[]{jbGuid});
			for(int j = 0; j < zrList.size(); j++){
				zrbbh += String.valueOf(zrList.get(j).get("zrbbh"));
			}
			resultList.get(i).put("zrbbh", zrbbh);
		}
		return resultList;
	}
	
	public boolean updateJbb(HttpServletRequest request){
	    String yw_guid=request.getParameter("tbbh");
        String dbChanges=request.getParameter("tbchanges");
        JSONArray js=JSONArray.fromObject(UtilFactory.getStrUtil().unescape(dbChanges));
        System.out.println(js);
        Iterator<?> it = js.getJSONObject(0).keys();
        StringBuffer sb=new StringBuffer("update jc_jiben set ");
        List<Object> list=new ArrayList<Object>();
        while(it.hasNext()){        
           String key = (String) it.next().toString();             
           String value= js.getJSONObject(0).getString(key); 
           sb.append(key).append("=?,");
           list.add(value);
        }
        list.add(yw_guid);
        sb.replace(sb.length()-1,sb.length()," where yw_guid=?");
        int result=update(sb.toString(),YW,list.toArray());
        return result==1?true:false;
	}

}
