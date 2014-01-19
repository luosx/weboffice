package com.klspta.web.cbd.yzt.kgzb;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.model.CBDReport.CBDReportManager;
import com.klspta.model.CBDReport.tablestyle.ITableStyle;
import com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow;
import com.klspta.web.cbd.yzt.zrb.ZrbData;
/*****
 * 
 * <br>Title:底层数据库——控规指标处理类
 * <br>Description:
 * <br>Author:朱波海
 * <br>Date:2014-1-15
 */
public class KgzbManager extends AbstractBaseBean {
/**
 * 
 * <br>Description:删除操作
 * <br>Author:朱波海
 * <br>Date:2014-1-15
 */
	public void delet() {
		String yw_guid = request.getParameter("yw_guid");
		String type = request.getParameter("type");
		type = UtilFactory.getStrUtil().unescape(type);
		String delet = "delete dcsjk_kgzb where yw_guid=? and dqy=? ";
		int i = update(delet, YW, new Object[] { yw_guid, type });
		if (i == 1) {
			response("success");
		}

	}
/*****
 * 
 * <br>Description:查询功能
 * <br>Author:朱波海
 * <br>Date:2014-1-15
 */
	public void quey() {
		String yw_guid = request.getParameter("yw_guid");
		String type = request.getParameter("type");
		type = UtilFactory.getStrUtil().unescape(type);
		String quey = "select * from dcsjk_kgzb where yw_guid=? and dqy=? ";
		List<Map<String, Object>> query = query(quey, YW, new Object[] {
				yw_guid, type });
		response(query);

	}
/**
 * 
 * <br>Description:保存功能
 * <br>Author:朱波海
 * <br>Date:2014-1-15
 */
	public void save() {
		String type = request.getParameter("type");
		String yw_guid = request.getParameter("yw_guid");
		String DKMC = request.getParameter("DKMC");
		String YDXZDH = request.getParameter("YDXZDH");
		String YDXZ = request.getParameter("YDXZ");
		String JSYDMJ = request.getParameter("JSYDMJ");
		String RJL = request.getParameter("RJL");
		String GHJZGM = request.getParameter("GHJZGM");

		String JZKZGD = request.getParameter("JZKZGD");
		String JZMD = request.getParameter("JZMD");
		String LHL = request.getParameter("LHL");
		String DBZS = request.getParameter("DBZS");
		String DXMK = request.getParameter("DXMK");
		String GHSJLY = request.getParameter("GHSJLY");
		String BZ = request.getParameter("BZ");
		String QY = request.getParameter("QY");

		DKMC = UtilFactory.getStrUtil().unescape(DKMC);
		type = UtilFactory.getStrUtil().unescape(type);
		BZ = UtilFactory.getStrUtil().unescape(BZ);
		YDXZ = UtilFactory.getStrUtil().unescape(YDXZ);
		GHSJLY = UtilFactory.getStrUtil().unescape(GHSJLY);
		int i = 0;

		if (JSYDMJ == null || JSYDMJ.equals("")) {
			JSYDMJ = "0";
		}
		if (GHJZGM == null || GHJZGM.equals("")) {
			GHJZGM = "0";
		}
		if (yw_guid != null && !yw_guid.equals("")) {
			String sql = " update  dcsjk_kgzb set DKMC='" + DKMC + "',YDXZDH='"
					+ YDXZDH + "' ,YDXZ='" + YDXZ + "' ,JSYDMJ='" + JSYDMJ
					+ "',RJL='" + RJL + "',GHJZGM='" + GHJZGM + "',JZKZGD='"
					+ JZKZGD + "',JZMD='" + JZMD + "',LHL='" + LHL + "',DBZS='"
					+ DBZS + "',DXMK='" + DXMK + "',GHSJLY='" + GHSJLY
					+ "',BZ='" + BZ + "' where yw_guid=? and dqy=?";
			i = update(sql, YW, new Object[] { yw_guid, type });
		} else {
			String sql = " insert into  dcsjk_kgzb ( DKMC,YDXZDH,YDXZ ,JSYDMJ,RJL,GHJZGM,JZKZGD,JZMD,LHL,DBZS,DXMK,GHSJLY,BZ,QY,dqy) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			i = update(
					sql,
					YW,
					new Object[] { DKMC, YDXZDH, YDXZ, JSYDMJ, RJL, GHJZGM,
							JZKZGD, JZMD, LHL, DBZS, DXMK, GHSJLY, BZ, QY, type });
		}
		if (i == 1) {
			response("success");
		}
	}

	/**
	 * 
	 * <br>
	 * Description:控规指标列表过滤 <br>
	 * Author:李国明 <br>
	 * Date:2014-1-15
	 * 
	 * @throws Exception
	 */
	public void getReport() throws Exception {
		String keyword = request.getParameter("keyword");
		String type = request.getParameter("type");
		ITableStyle its = new TableStyleEditRow();
		if (!"reader".equals(type)) {
			response(String.valueOf(new CBDReportManager().getReport("SWCBR",
					new Object[] { "%" + keyword + "%" }, its)));
		} else {
			response(String.valueOf(new CBDReportManager().getReport("SWCBR",
					new Object[] { "%" + keyword + "%" }, its)));
		}
	}

	
	/**
     * 
     * <br>Description:控规指标上图
     * <br>Author:李国明
     * <br>Date:2014-01-19
     * @throws Exception 
     */
    public void drawZrb() throws Exception{
    	String dkmc = request.getParameter("dkmc");
    	String polygon = request.getParameter("polygon");
    	if (dkmc != null) {
    		dkmc = UtilFactory.getStrUtil().unescape(dkmc);
    	}else{
    		response("{error:not primary}");
    	}
    	boolean draw = KgzbData.getInstance().recordGIS(dkmc, polygon);
    	response(String.valueOf(draw)); 
    }
}
