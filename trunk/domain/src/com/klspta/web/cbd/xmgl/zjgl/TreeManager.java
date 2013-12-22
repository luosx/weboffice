package com.klspta.web.cbd.xmgl.zjgl;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class TreeManager extends AbstractBaseBean {

    StringBuffer buffer = new StringBuffer();

    public StringBuffer getParentNOde() {
        String sql = " select *  from zjgl_tree t where t.common='1' and parent_id='0'  order  by sort";
        List<Map<String, Object>> list = query(sql, YW);
        for (int i = 0; i < list.size(); i++) {
            //一级
            if (i == 0) {
                buffer.append("\n{text:'");
            } else {
                buffer.append(",\n{text:'");
            }
            buffer.append(list.get(i).get("tree_name").toString());
            buffer.append("',leaf:'0',id:'");
            buffer.append(list.get(i).get("tree_id").toString());
            buffer.append("',children:[");
            String sqlejString = "select * from  zjgl_tree where parent_id=? and common='1' order  by sort ";
            List<Map<String, Object>> query = query(sqlejString, YW, new Object[] { list.get(i)
                    .get("tree_id").toString() });
            for (int j = 0; j < query.size(); j++) {
                //二级
                if (j == 0) {
                    buffer.append("\n{text:'");
                } else {
                    buffer.append(",\n{text:'");
                }
                buffer.append(query.get(i).get("tree_name").toString());
                buffer.append("',leaf:'1',id:'");
                buffer.append(query.get(i).get("tree_id").toString());
                buffer.append("'}");
                String sqls = " select * from  zjgl_tree where parent_id=? and common='1' order  by sort ";
                List<Map<String, Object>> querys = query(sqlejString, YW, new Object[] { list.get(i).get(
                        "tree_id").toString() });
                for (int k = 0; k < querys.size(); k++) {
                    //三级
                    if (j == 0) {
                        buffer.append("\n{text:'");
                    } else {
                        buffer.append(",\n{text:'");
                    }
                    buffer.append(querys.get(i).get("tree_name").toString());
                    buffer.append("',leaf:'1',id:'");
                    buffer.append(querys.get(i).get("tree_id").toString());
                    buffer.append("'}");
                    String sqlss = " select * from  zjgl_tree where parent_id=? and yw_guid=? order  by sort ";
                    List<Map<String, Object>> queryss = query(sqlejString, YW, new Object[] { list.get(i)
                            .get("tree_id").toString() });
                    for (int f = 0; f < queryss.size(); f++) {
                        //si级
                        if (j == 0) {
                            buffer.append("\n{text:'");
                        } else {
                            buffer.append(",\n{text:'");
                        }
                        buffer.append(queryss.get(f).get("tree_name").toString());
                        buffer.append("',leaf:'1',id:'");
                        buffer.append(queryss.get(f).get("tree_id").toString());
                        buffer.append("'}");
                        if (i == (list.size() - 1)) {
                            buffer.append("}");
                        } else {
                            buffer.append("},");
                        }
                    }
                    if (i == (list.size() - 1)) {
                        buffer.append("}");
                    } else {
                        buffer.append("},");
                    }
                }
                if (i == (list.size() - 1)) {
                    buffer.append("}");
                } else {
                    buffer.append("},");
                }
            }
            if (i == (list.size() - 1)) {
                buffer.append("}");
            } else {
                buffer.append("},");
            }

        }
        return  buffer;
    }
//前期费用
    public List<Map<String, Object>> getZC_tree(String yw_guid,String type) {
      String sql="select *  from zjgl_tree where yw_guid=? and parent_id=?";
      List<Map<String, Object>> list = query(sql, YW,new Object []{yw_guid,type});
        return list;
    }
    
}
