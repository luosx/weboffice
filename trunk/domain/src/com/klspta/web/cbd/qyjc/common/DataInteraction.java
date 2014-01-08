package com.klspta.web.cbd.qyjc.common;

import java.util.ArrayList;
import java.util.HashMap;
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
        String tableName = tabName;
        List<Map<String, Object>> query1 = null;
        if (tableName != null && !tableName.equals("")) {
            String sql = "select t.bh,t.xzlmc,t2.* from XZLXX t," + tableName
                    + " t2 where t.yw_guid=t2.yw_guid and t2.rq=?";
            query1 = query(sql, YW, new Object[] { year });
            String sqlString = "select * from XZLXX ";
            List<Map<String, Object>> query2 = query(sqlString, YW);
            if (query1.size() == query2.size()) {
                return query1;
            } else {
                String sqldiff = "select  distinct t2.yw_guid from xzlxx t2 where t2.yw_guid  not in (select yw_guid from "
                        + tabName + " where rq=? )";
                List<Map<String, Object>> list = query(sqldiff, YW, new Object[] { year });
                for (int i = 0; i < list.size(); i++) {
                    String insert = "insert into " + tabName + "(yw_guid,rq ) values (?,?)";
                    update(insert, YW, new Object[] { list.get(i).get("yw_guid"), year });
                }

            }
            String sq = "select t.bh,t.xzlmc,t2.* from XZLXX t," + tableName
                    + " t2 where t.yw_guid=t2.yw_guid and t2.rq=?";
            query1 = query(sq, YW, new Object[] { year });
        }
        return query1;
    }

    /*****
     * 
     * <br>Description:获取租金情况
     * <br>Author:朱波海
     * <br>Date:2014-1-6
     */
    public List<Map<String, Object>> getXzl_Zjqk_xx() {
        String sqldiff = "select  distinct t2.yw_guid from xzlxx t2 where t2.yw_guid  not in (select yw_guid from XZLZJQK  )";
        List<Map<String, Object>> diff = query(sqldiff, YW);
        if (diff.size() > 0) {
            for (int i = 0; i < diff.size(); i++) {
                String insert = "insert into XZLZJQK (yw_guid) values(?)";
                update(insert, YW, new Object[] { diff.get(i).get("yw_guid") });
            }
        }
        String sql = "Select t.xzlmc,t.bh,t2.* from xzlxx t,xzlzjqk t2 where t.yw_guid=t2.yw_guid";
        List<Map<String, Object>> query = query(sql, YW);
        return query;
    }

    /*****
     * 
     * <br>Description:获取租金情况_年度保存
     * <br>Author:朱波海
     * <br>Date:2014-1-6
     * @return
     */
    public List<Map<String, Object>> getXzl_Zjqk_pjlm() {
        String sql = "Select t.xzlmc,t.bh,t2.* from xzlxx t,XZLZJQKND_PJLM t2 where t.yw_guid=t2.yw_guid and t2.rq='2014'";
        List<Map<String, Object>> query = query(sql, YW);
        return query;

    }

    /*****
     * 
     * <br>Description:获取租金情况_年度保存
     * <br>Author:朱波海
     * <br>Date:2014-1-6
     * @return
     */
    public List<Map<String, Object>> getXzl_Zjqk_pjzj() {
        String sql = "Select t.xzlmc,t.bh,t2.* from xzlxx t,XZLZJQKND_PJZJ t2 where t.yw_guid=t2.yw_guid and t2.rq='2014'";
        List<Map<String, Object>> query = query(sql, YW);
        return query;

    }

    public List<Map<String, Object>> getCont(String year, String TabName) {
        String sql = "select  *  from  " + TabName + "_VIEW where rq=? ";
        List<Map<String, Object>> query = query(sql, YW, new Object[] { year });
        if (query.size() > 0) {
            HashMap<String, Object> hashMap = new HashMap<String, Object>();
            HashMap<String, Object> Map = new HashMap<String, Object>();
            int yy = Integer.parseInt(String.valueOf(query.get(0).get("yy")));
            int ey = Integer.parseInt(String.valueOf(query.get(0).get("ey")));
            int sy = Integer.parseInt(String.valueOf(query.get(0).get("sy")));
            int siy = Integer.parseInt(String.valueOf(query.get(0).get("siy")));
            int wy = Integer.parseInt(String.valueOf(query.get(0).get("wy")));
            int ly = Integer.parseInt(String.valueOf(query.get(0).get("ly")));
            int qy = Integer.parseInt(String.valueOf(query.get(0).get("qy")));
            int bay = Integer.parseInt(String.valueOf(query.get(0).get("bay")));
            int jy = Integer.parseInt(String.valueOf(query.get(0).get("jy")));
            int shiy = Integer.parseInt(String.valueOf(query.get(0).get("shiy")));
            int syy = Integer.parseInt(String.valueOf(query.get(0).get("syy")));
            int sey = Integer.parseInt(String.valueOf(query.get(0).get("sey")));
            //环比增长
            hashMap.put("yy", "0");
            hashMap.put("ey",getOpration (ey , yy ));
            hashMap.put("sy", getOpration(sy, ey ));
            hashMap.put("siy",getOpration (siy , sy));
            hashMap.put("wy", getOpration(wy , siy ));
            hashMap.put("ly", getOpration(ly , wy ));
            hashMap.put("qy", getOpration(qy , ly));
            hashMap.put("bay",getOpration (bay , qy ));
            hashMap.put("jy", getOpration(jy ,bay ));
            hashMap.put("shiy", getOpration(shiy , jy ));
            hashMap.put("syy", getOpration(syy , shiy ));
            hashMap.put("sey", getOpration(sey, syy ));
            // 总增长
                Map.put("yy", "0");
                Map.put("ey", getOpration(ey , yy ));
                Map.put("sy", getOpration(sy , yy ));
                Map.put("siy",getOpration (siy , yy ));
                Map.put("wy", getOpration(wy , yy ));
                Map.put("ly", getOpration(ly , yy ));
                Map.put("qy", getOpration(qy , yy ));
                Map.put("bay",getOpration (bay , yy));
                Map.put("jy", getOpration(jy , yy ));
                Map.put("shiy",getOpration(shiy , yy));
                Map.put("syy", getOpration(syy , yy ));
                Map.put("sey",getOpration (sey , yy ));
                query.add(hashMap);
                query.add(Map);

        }
        return query;
    }

    public int getOpration(int i, int j) {
        if (j == 0) {
            return 0;
        } else {
            return (i / j - 1) * 100;
        }
    }

}
