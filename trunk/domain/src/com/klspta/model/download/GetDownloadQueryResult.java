package com.klspta.model.download;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;


public class GetDownloadQueryResult extends AbstractBaseBean{

    /**
     * <br>Description:获得下载维护表格数据
     * <br>Author:尹宇星
     * <br>Date:2011-6-22
     * @param list
     * @return
     */
    public String getGpsQueryDateResult(List<DownloadInfoBean> list) {
        DownloadInfoBean dib = new DownloadInfoBean();
        Iterator<DownloadInfoBean> it = list.iterator();
        StringBuffer sb = new StringBuffer();
        sb.append("[");
        int i = 0;
        while (it.hasNext()) {
            dib = it.next();
            String type = caseType(dib.getType());
            String title = dib.getTitle();
            String people = dib.getPeople();
            String date = dib.getDate();
            String section = caseSection(dib.getSection());
            String accessory = dib.getIsHaveAccessory();
            sb.append("['" + title + "','" + people + "','" + section + "','" + date + "','" + type + "',"
                    + i + "," + i + "," + i + ",'" + accessory + "']");
            if (it.hasNext()) {
                sb.append(",");
            }
            i++;
        }
        sb.append("]");
        return sb.toString();
    }

    /**
     * <br>Description:获得部门下拉列表数据
     * <br>Author:尹宇星
     * <br>Date:2011-6-22
     * @return
     */
    public String getSectionList() {
        String sql = "select treename, treeid from core.ROLE_ZZJGTREE";
        List list = query(sql,CORE);
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < list.size(); i++) {
            Map map = (Map) list.get(i);
            sb.append("{text:'" + map.get("treename") + "',value:'" + map.get("treeid") + "'}");
            if ((i + 1) < list.size()) {
                sb.append(",");
            }
        }
        return sb.toString();
    }

    /**
     * <br>Description:根据部门id获得部门名称
     * <br>Author:尹宇星
     * <br>Date:2011-6-22
     * @param id 部门id
     * @return
     */
    private String caseSection(String id) {
        String name = null;
        String sql = "select treename, treeid from core.ROLE_ZZJGTREE";
        List list = query(sql,CORE);
        for (int i = 0; i < list.size(); i++) {
            Map map = (Map) list.get(i);
            if (id.equals(map.get("treeid"))) {
                name = (String) map.get("treename");
            }
        }
        return name;
    }

    /**
     * <br>Description:根据类型ID获得类型名称
     * <br>Author:尹宇星
     * <br>Date:2011-6-22
     * @param id 类型id
     * @return
     */
    private String caseType(String id) {
        String name = null;
        String sql = "select CHILD_ID, CHILD_NAME from PUBLIC_CODE where id='DOWNLOADTYPE'";
        List list = query(sql,YW);
        for (int i = 0; i < list.size(); i++) {
            Map map = (Map) list.get(i);
            if (id.equals(map.get("CHILD_ID"))) {
                name = (String) map.get("CHILD_NAME");
            }
        }
        return name;
    }
}
