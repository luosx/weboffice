package com.klspta.model.download;

import java.util.Iterator;
import java.util.List;


/**
 * <br>Description:下载专区-->下载服务功能的实现！
 * <br>@author: 李如意
 * <br>Date: 2011-07-01
 */

public class DownloadService {

    public String getDate(List<DownloadInfoBean> list) {
        DownloadInfoBean dib = new DownloadInfoBean();
        Iterator<DownloadInfoBean> it = list.iterator();
        StringBuffer sb = new StringBuffer();
        sb.append("[");
        int i = 1;
        while (it.hasNext()) {
            dib = it.next();
            String title = dib.getTitle();
            String content = dib.getContent();
            String date = dib.getDate();                     
            String isHaveAccessory = dib.getIsHaveAccessory();
            sb.append("['"+i+"','" + title + "','" + date + "','"+(i-1)+"','"+content + "','" + isHaveAccessory + "']");
            if (it.hasNext()) {
                sb.append(",");
            }
            i++;
        }
        sb.append("]");        
        return sb.toString();
    }
}
