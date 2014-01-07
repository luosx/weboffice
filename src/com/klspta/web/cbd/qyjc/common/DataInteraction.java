package com.klspta.web.cbd.qyjc.common;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class DataInteraction extends AbstractBaseBean {
    //平均楼面均价测算 /平均租金测算
    public static String[] types = { "XZLZJQKND_PJZJ", "XZLZJQKND_PJLM" };
/****
 * 
 * <br>Description:测算
 * <br>Author:朱波海
 * <br>Date:2014-1-7
 * @param year
 * @param type
 * @return
 */
    public List<Map<String, Object>> getDateList(String year, String tabName) {
        String tableName = "";
        List<Map<String, Object>>query=null;
        if (tabName.equals(types[0])) {
            tableName = "XZLZJQKND_PJZJ";
        }
        if (tabName.equals(types[1])) {
            tableName = "XZLZJQKND_PJLM";
        }
        if (tableName != null && !tableName.equals("")) {
        String sql="select t.bh,t.xzlmc,t2.* from XZLXX t,"+tableName+" t2 where t.yw_guid=t2.yw_guid and t2.rq=?";
         query = query(sql, YW,new Object[]{year});
        }
        return query;
    }
    /****
     * 
     * <br>Description:测算
     * <br>Author:朱波海
     * <br>Date:2014-1-7
     * @param year
     * @param type
     * @return
     */
    public List<List<Map<String, Object>>> getDateList(String []year, String type) {
        String tableName = "";
        ArrayList<List<Map<String, Object>>> list = new ArrayList<List<Map<String, Object>>>();
        if (type.equals(types[0])) {
            tableName = "XZL_LMJJCS";
        }
        if (type.equals(types[1])) {
            tableName = "XZL_PJZJCS";
        }
        if (tableName != null && !tableName.equals("")) {
            for(int i=0;i<year.length;i++){
        String sql="select t.bh,t.xzlmc,t2.* from XZLXX t,"+tableName+" t2 where t.yw_guid=t2.yw_guid  and t2.rq=?";
        List<Map<String, Object>>query = query(sql, YW,new Object[]{year[i]});
        list.add(query);
            }
        }
        return list;
    }
    /*****
     * 
     * <br>Description:获取租金情况
     * <br>Author:朱波海
     * <br>Date:2014-1-6
     */
    public  List<Map<String, Object>> getXzl_Zjqk_xx(){
        String sql="Select t.xzlmc,t.bh,t2.* from xzlxx t,xzlzjqk t2 where t.yw_guid=t2.yw_guid";
        List<Map<String, Object>> query = query(sql, YW);
        return  query;
    }
    /*****
     * 
     * <br>Description:获取租金情况_年度保存
     * <br>Author:朱波海
     * <br>Date:2014-1-6
     * @return
     */
    public List<Map<String, Object>> getXzl_Zjqk_pjlm(){
        String sql="Select t.xzlmc,t.bh,t2.* from xzlxx t,XZLZJQKND_PJLM t2 where t.yw_guid=t2.yw_guid and t2.rq='2014'";
        List<Map<String, Object>> query = query(sql, YW);
        return  query;
        
    }
    /*****
     * 
     * <br>Description:获取租金情况_年度保存
     * <br>Author:朱波海
     * <br>Date:2014-1-6
     * @return
     */
    public List<Map<String, Object>> getXzl_Zjqk_pjzj(){
        String sql="Select t.xzlmc,t.bh,t2.* from xzlxx t,XZLZJQKND_PJZJ t2 where t.yw_guid=t2.yw_guid and t2.rq='2014'";
        List<Map<String, Object>> query = query(sql, YW);
        return  query;
        
    } 
    

}
