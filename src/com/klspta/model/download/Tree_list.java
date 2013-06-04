package com.klspta.model.download;

import java.util.List;
import java.util.Map;


public class Tree_list extends com.klspta.base.AbstractBaseBean{
    /**
     * <br>Description: 获得下载服务树形列表
     * <br>Author:尹宇星
     * <br>Date:2011-6-20
     * @return
     */
    public String getTree() {
        String sql = "select * from PUBLIC_CODE where id = 'DOWNLOADTYPE'";
        List list = query(sql,YW);
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < list.size(); i++) {
            sb.append("{id:'");
            Map map = (Map) list.get(i);
            String id = (String) map.get("CHILD_ID");
            sb.append(id);
            sb.append("',text:'");
            String name = (String) map.get("CHILD_NAME");
            sb.append(name);
            sb.append("',leaf:true}");
            if (i < list.size() - 1) {
                sb.append(",");
            }

        }
        return sb.toString();
    }
}
