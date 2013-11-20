package com.klspta.web.cbd.yzt.zrb;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.web.cbd.yzt.utilList.IData;

public class ZrbData extends AbstractBaseBean implements IData {
    private static final String formName = "JC_ZIRAN";

    /**
     * 保存自然斑列表
     */
    public static List<Map<String, Object>> zrbList;

    /**
     * 
     * <br>Description:获取所有自然斑列表
     * <br>Author:黎春行
     * <br>Date:2013-10-18
     * @param request
     */
    public List<Map<String, Object>> getAllList(HttpServletRequest request) {
        if (zrbList == null) {
            String sql = "select * from " + formName + " t order by to_number(t.yw_guid)";
            zrbList = query(sql, YW);
        }
        return zrbList;
    }

    /**
     * 
     * <br>Description:查询自然斑
     * <br>Author:黎春行
     * <br>Date:2013-10-21
     * @param request
     * @return
     */
    @Override
    public List<Map<String, Object>> getQuery(HttpServletRequest request) {
        String keyWord = request.getParameter("keyWord");
        StringBuffer querySql = new StringBuffer();
        querySql.append("select * from ").append(formName).append(" t ");
        if (keyWord != null) {
            keyWord = UtilFactory.getStrUtil().unescape(keyWord);
            querySql
                    .append("where t.yw_guid||t.zrbbh||t.zdmj||t.lzmj||t.cqgm||t.zzlzmj||t.zzcqgm||t.yjhs||t.fzzlzmj||t.fzzcqgm||t.bz like '%");
            querySql.append(keyWord).append("%'");
        } else if (zrbList != null) {
            return zrbList;
        }
        querySql.append(" order by to_number(t.yw_guid)");
        return query(querySql.toString(), YW);
    }

    /**
     * 
     * <br>Description:更新自然斑数据
     * <br>Author:黎春行
     * <br>Date:2013-10-21
     * @param request
     * @return
     */
    public boolean updateZrb(HttpServletRequest request) {
        String yw_guid = request.getParameter("tbbh");
        String dbChanges = request.getParameter("tbchanges");
        JSONArray js = JSONArray.fromObject(UtilFactory.getStrUtil().unescape(dbChanges));
        System.out.println(js);
        Iterator<?> it = js.getJSONObject(0).keys();
        StringBuffer sb = new StringBuffer("update jc_ziran set ");
        List<Object> list = new ArrayList<Object>();
        while (it.hasNext()) {
            String key = (String) it.next().toString();
            String value = js.getJSONObject(0).getString(key);
            sb.append(key).append("=?,");
            list.add(value);
        }
        list.add(yw_guid);
        sb.replace(sb.length() - 1, sb.length(), " where yw_guid=?");
        int result = update(sb.toString(), YW, list.toArray());
        if(result==1){
            flush(js.getJSONObject(0),yw_guid);
        }
        return result == 1 ? true : false;
    }
    
    private void flush(JSONObject jObject,String guid){
        int count=zrbList.size();
        int num=-1;
        Map<String,Object> map=null;
        for(int i=0;i<count;i++){
            map=zrbList.get(i);
            if(map.get("yw_guid").equals(guid)){
                num=i;
                break;
            }
        }
        if(num!=-1){
            Iterator<?> it = jObject.keys();
            while (it.hasNext()) {
                String key = (String) it.next().toString();
                String value = jObject.getString(key);
                map.put(key, value);
            }
            zrbList.set(num,map);
        }
    }
}
