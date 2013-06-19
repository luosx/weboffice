package com.klspta.web.xuzhouNW.dtxc;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

/**
 * 
 * <br>
 * Title:Pad功能类 <br>
 * Description:对数据库中PAD表操作 <br>
 * Author:陈强峰 <br>
 * Date:2011-7-22
 */
public class PADDataList extends AbstractBaseBean {

    /**
     * 
     * <br>Description:获取成果列表
     * <br>Author:陈强峰
     * <br>Date:2013-6-19
     */ 
    public void getQueryData() {
        String keyword = request.getParameter("keyWord");
        if (keyword != null&&keyword.length()>0) {
            keyword = UtilFactory.getStrUtil().unescape(keyword);
            System.out.print(keyword);
            String sql = "select t.readflag,t.guid,t.xzqmc,t.xmmc,t.rwlx,t.sfwf,(select u.fullname from core.core_users u where u.username=t.xcr) xcr,t.xcrq,t.cjzb,t.jwzb,t.imgname from v_pad_data t where (upper(guid)||upper(xmmc)||upper(rwlx)||upper(sfwf)||upper(xcr)||upper(xcrq) like '%"
                    + keyword + "%')";
            List<Map<String, Object>> query = query(sql, YW);
            response(query);
        }
    }
}
