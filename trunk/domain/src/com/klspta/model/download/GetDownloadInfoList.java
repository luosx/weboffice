package com.klspta.model.download;

import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class GetDownloadInfoList extends AbstractBaseBean{
    
    /**
     * 办事指南
     */
    public static final int BSZN = 1;
    /**
     * 收费标准
     */
    public static final int SFBZ = 2;
    /**
     * 基准地价
     */
    public static final int JZDJ = 3;
    
    /**
     * <br>Description:获得所有下载信息
     * <br>Author:尹宇星
     * <br>Date:2011-7-4
     * @return
     */
    public List<DownloadInfoBean> getAllDownloadInfoList() {
        String sql = "select * FROM CORE_DOWNLOAD_LIST ORDER BY KC05";
        List list = query(sql,CORE);
        List<DownloadInfoBean> downloadInfoBeanList = new ArrayList<DownloadInfoBean>();
        for (int i = 0; i < list.size(); i++) {
            Map map = (Map) list.get(i);
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            String types = (String) map.get("KC05");
            String people = (String) map.get("KC03");
            String title = (String) map.get("KC02");
            String section = (String) map.get("KC06");
            String date = df.format(map.get("KC04"));
            String content = (String) map.get("KC07");
            String isHaveAccessory = (String) map.get("KC08");
            DownloadInfoBean dib = new DownloadInfoBean(title, people, date, types, section, content,
                    isHaveAccessory);
            downloadInfoBeanList.add(dib);
        }
        return downloadInfoBeanList;
    }

    /**
     * <br>Description:按类型获得下载信息
     * <br>Author:尹宇星
     * <br>Date:2011-7-4
     * @param type
     * @return
     * @throws SQLException
     */
    public List<DownloadInfoBean> getDownloadInfoList(String type) throws SQLException {
        String sql = "select * FROM CORE_DOWNLOAD_LIST where KC05 = ?";

        List<String> args_list = new ArrayList<String>();
        args_list.add(type);

        Object[] args = new Object[args_list.size()];
        for (int i = 0; i < args_list.size(); i++) {
            args[i] = args_list.get(i);
        }
        sql = sql + " ORDER BY KC04";
        List list = query(sql,CORE, args);
        List<DownloadInfoBean> downloadInfoBeanList = new ArrayList<DownloadInfoBean>();
        for (int i = 0; i < list.size(); i++) {
            Map map = (Map) list.get(i);
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            String title = (String) map.get("KC02");
            String people = (String) map.get("KC03");
            String date = df.format(map.get("KC04"));
            String types = (String) map.get("KC05");
            String section = (String) map.get("KC06");
            String content = (String) map.get("KC07");
            String isHaveAccessory = (String) map.get("KC08");
            DownloadInfoBean dib = new DownloadInfoBean(title, people, date, types, section, content,
                    isHaveAccessory);
            downloadInfoBeanList.add(dib);
        }
        return downloadInfoBeanList;
    }

    /**
     * <br>Description:根据ID获得一条下载信息
     * <br>Author:尹宇星
     * <br>Date:2011-7-4
     * @param id
     * @return
     * @throws SQLException
     */
    public DownloadInfoBean getOneDownloadInfo(String id) throws SQLException {
        String sql = "select * FROM CORE_DOWNLOAD_LIST where KC08 = ?";

        List<String> args_list = new ArrayList<String>();
        args_list.add(id);

        Object[] args = new Object[args_list.size()];
        for (int i = 0; i < args_list.size(); i++) {
            args[i] = args_list.get(i);
        }
        List list = query(sql,CORE, args);
        DownloadInfoBean dib = new DownloadInfoBean();
        if (list.size() == 1) {
            Map map = (Map) list.get(0);
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            String title = (String) map.get("KC02");
            String people = (String) map.get("KC03");
            String date = df.format(map.get("KC04"));
            String types = (String) map.get("KC05");
            String section = (String) map.get("KC06");
            String content = (String) map.get("KC07");
            String isHaveAccessory = (String) map.get("KC08");
            dib.setTitle(title);
            dib.setPeople(people);
            dib.setDate(date);
            dib.setType(types);
            dib.setSection(section);
            dib.setIsHaveAccessory(isHaveAccessory);
            dib.setContent(content);
            return dib;
        }
        return null;
    }

}
