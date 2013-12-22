package com.klspta.web.cbd.xmgl.zjgl;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class TreeManager extends AbstractBaseBean {

/******
 * 
 * <br>Description:树关联
 * <br>Author:朱波海
 * <br>Date:2013-12-22
 * @param yw_guid
 * @param type
 * @return
 */
    
    public List<Map<String, Object>> getZC_tree(String yw_guid, String type) {
        String sql = "select *  from zjgl_tree where yw_guid=? and parent_id=?";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { yw_guid, type });
        return list;
    }

    public String getTree(String yw_guid){
        StringBuffer buffer = new StringBuffer();
       buffer.append("{text:'资金支出',leaf:0,id:'1',");
       buffer.append("children:[{text:'一级开发支出',leaf:0,id:'101',");
       buffer.append("children:[");
       StringBuffer qqfy = getChaild_tree(yw_guid,"前期费用","qqfy");
       buffer.append(qqfy);
       buffer.append(",");
       StringBuffer cqfy = getChaild_tree(yw_guid,"拆迁费用","cqfy");
       buffer.append(cqfy);
       buffer.append(",");
       StringBuffer szfy = getChaild_tree(yw_guid,"市政费用","szfy");
       buffer.append(szfy);
       buffer.append(",");
       StringBuffer cwfy = getChaild_tree(yw_guid,"财务费用","cwfy");
       buffer.append(cwfy);
       buffer.append(",");
       StringBuffer qlfy = getChaild_tree(yw_guid,"管理费","qlfy");
       buffer.append(qlfy);
       buffer.append("]},");
       StringBuffer cyzjfh = getChaild_tree(yw_guid,"筹融资金返还","cyzjfh");
       buffer.append(cyzjfh);
       buffer.append(",");
       StringBuffer qtzc = getChaild_tree(yw_guid,"其他支出","qtzc");
       buffer.append(qtzc);
       buffer.append("]}");
        return  buffer.toString();
    }
    
    public StringBuffer getFather_tree(List<Map<String, Object>> list) {
        StringBuffer buffer = new StringBuffer();
        if (list != null) {
            for (int i = 0; i < list.size(); i++) {
                if (i == 0) {
                    buffer.append("\n{text:'");
                } else {
                    buffer.append(",\n{text:'");
                }
                buffer.append(list.get(i).get("tree_name").toString());
                buffer.append("',leaf:'0',id:'");
                buffer.append(list.get(i).get("tree_id").toString());
                buffer.append("',children:[");
                if (i == (list.size() - 1)) {
                    buffer.append("]}");
                }
            }
        }
        return buffer;
    }

    public StringBuffer getChaild_tree(String yw_guid,String name,String type) {
        StringBuffer buffer = new StringBuffer();
        String sql_qqfy="  select * from zjgl_tree where yw_guid=? and parent_id=?" ;
        List<Map<String, Object>> list = query(sql_qqfy, YW,new Object []{yw_guid,type});
        if (list.size()>0) {
            buffer.append("{text:'"+name+"',leaf:0,id:'"+type+"',children:[");
            for (int i = 0; i < list.size(); i++) {
                if (i == 0) {
                    buffer.append("\n{text:'");
                } else {
                    buffer.append(",\n{text:'");
                }
                buffer.append(list.get(i).get("tree_name").toString());
                buffer.append("',leaf:'0',id:'");
                buffer.append(list.get(i).get("tree_id").toString());
                buffer.append("'}");
            }
            buffer.append("]}");
        }else{
            buffer.append("{text:'"+name+"',leaf:1,id:'"+type+"'}");  
            
        }
        return buffer;
    }

   
}
