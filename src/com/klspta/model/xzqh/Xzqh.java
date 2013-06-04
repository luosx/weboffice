package com.klspta.model.xzqh;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import org.springframework.stereotype.Component;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.util.bean.xzqhutil.XzqhBean;

/**
 * 
 * <br>
 * Title:行政区划工具 <br>
 * Description: <br>
 * Author:黎春行 <br>
 * Date:2012-5-23
 */
@Component
public class Xzqh extends AbstractBaseBean {

    /**
     * 
     * <br>Description:获取省级行政区划
     * <br>Author:黎春行
     * <br>Date:2012-5-23
     */
    public void getAllPlace() {
        String msg = UtilFactory.getXzqhUtil().generateOptionByList();
        clearParameter();
        putParameter(msg);
        response();
    }

    /**
     * 
     * <br>Description:获取特定区域的行政区划
     * <br>Author:黎春行
     * <br>Date:2012-5-23
     * @throws IOException
     */
    public void getNextPlace() throws IOException {
        String code = request.getParameter("code");
        String msg = UtilFactory.getXzqhUtil().generateOptionByList(
                UtilFactory.getXzqhUtil().getChildListByParentId(code));
        clearParameter();
        putParameter(msg);
        response();
    }

    /**
     * 
     * <br>Description:根据行政区划编码获取区划名称
     * <br>Author:黎春行
     * <br>Date:2012-6-8
     */
    public void getNameById() {
        String palceId = request.getParameter("id");
        String msg = UtilFactory.getXzqhUtil().generateOptionByList(
                UtilFactory.getXzqhUtil().getNameById(palceId));
        clearParameter();
        putParameter(msg);
        response();
    }

    /**
     * 
     * <br>Description:获取上一级的行政区划
     * <br>Author:黎春行
     * <br>Date:2012-6-19
     */
    public void getParentNameByChildId() {
        String placeId = request.getParameter("code");
        String msg = UtilFactory.getXzqhUtil().generateOptionByList(
                UtilFactory.getXzqhUtil().getParentByChildId(placeId));
        clearParameter();
        putParameter(msg);
        response();
    }

    /**
     * 
     * <br>Description:添加行政区信息
     * <br>Author:陈强峰
     * <br>Date:2012-6-19
     */
    public void addXzqh() {
    	//反馈信息
    	String msg = "success";//默认值是成功
        try {
        	//得到页面传进的参数
            String xzqh = new String(request.getParameter("xzqh").getBytes("iso-8859-1"), "UTF-8");
            String xzqmc = new String(request.getParameter("xzqmc").getBytes("iso-8859-1"), "UTF-8");
            String xzqjc = new String(request.getParameter("xzqjc").getBytes("iso-8859-1"), "UTF-8");
            String zfmc = new String(request.getParameter("xzqjc").getBytes("iso-8859-1"), "UTF-8");
            String gtbmc = new String(request.getParameter("gtbmc").getBytes("iso-8859-1"), "UTF-8");
            String sjxzq = new String(request.getParameter("sjxzq").getBytes("iso-8859-1"), "UTF-8");
            String sfzdcs = new String(request.getParameter("sfzdcs").getBytes("iso-8859-1"), "UTF-8");
            String wzdzmc = new String(request.getParameter("wzdzmc").getBytes("iso-8859-1"), "UTF-8");
            String yzbm = new String(request.getParameter("yzbm").getBytes("iso-8859-1"), "UTF-8");
            //创建一个行政区划bean
            XzqhBean xzqhbean = new XzqhBean();
            //为bean赋值
            xzqhbean.setCatoncode(xzqh);
            xzqhbean.setCatonname(xzqmc);
            xzqhbean.setCatonsimpleName(xzqjc);
            xzqhbean.setGovname(zfmc);
            xzqhbean.setLandname(gtbmc);
            xzqhbean.setParentcode(sjxzq);
            xzqhbean.setStateflag(sfzdcs);
            xzqhbean.setFullname(wzdzmc);
            xzqhbean.setPostalcode(yzbm);
            //将bean保存(更新或者添加)
            UtilFactory.getXzqhUtil().save(xzqhbean);
        } catch (UnsupportedEncodingException e) {
        	msg = "fail";//失败
        }
        clearParameter();
        putParameter(msg);
        response();
    }
    
    /**
     * 
     * <br>Description:获取邮政编码
     * <br>Author:黎春行
     * <br>Date:2012-6-20
     */
    public void getPostalCodeById() {
		String id = request.getParameter("code");
		String msg = UtilFactory.getXzqhUtil().getPostalCode(id);
		clearParameter();
		putParameter(msg);
		response();
	}
}
