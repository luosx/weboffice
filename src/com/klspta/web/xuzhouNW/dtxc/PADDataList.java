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
        String sql = "select t.readflag,t.guid,t.xzqmc,t.xmmc,t.rwlx,t.sfwf,(select u.fullname from core.core_users u where u.username=t.xcr) xcr,t.xcrq,t.cjzb,t.jwzb,t.imgname from v_pad_data t";
        if (keyword != null) {
            keyword = UtilFactory.getStrUtil().unescape(keyword);
            sql = "select t.readflag,t.guid,t.xzqmc,t.xmmc,t.rwlx,t.sfwf,(select u.fullname from core.core_users u where u.username=t.xcr) xcr,t.xcrq,t.cjzb,t.jwzb,t.imgname from v_pad_data t where (upper(guid)||upper(xmmc)||upper(rwlx)||upper(sfwf)||upper(xcr)||upper(xcrq) like '%"
                    + keyword + "%')";
        }
        List<Map<String, Object>> query = query(sql, YW);
        for(int i=0;i<query.size();i++){
            query.get(i).put("XIANGXI",i);
            query.get(i).put("DELETE",i);
        }
        response(query);
    }
    
    /**
     * 
     * <br>Description: 删除指定的外业设备回传信息
     * <br>Author:姚建林
     * <br>Date:2012-11-19
     * @return
     */
    public String delPAD() {
        String guid = request.getParameter("yw_guid");
        if (guid != null) {
            String sql = "delete from pad_xcxcqkb where yw_guid='" + guid + "'";
            update(sql, YW);
        }
        return null;
    }
}
