package com.klspta.web.cbd.yzt.kgzb;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

public class KgzbManager extends AbstractBaseBean {

	public void getQyList(String qyName, String dqyName) {
		String sql = "Select *  from dcsjk_kgzb where qy=? and dqy=?";
		List<Map<String, Object>> list = query(sql, YW, new Object[] { qyName,
				dqyName });

	}

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

	public void quey() {
		String yw_guid = request.getParameter("yw_guid");
		String type = request.getParameter("type");
		type = UtilFactory.getStrUtil().unescape(type);
		String quey = "select * from dcsjk_kgzb where yw_guid=? and dqy=? ";
		List<Map<String, Object>> query = query(quey, YW, new Object[] {
				yw_guid, type });
		response(query);

	}

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

		DKMC = UtilFactory.getStrUtil().unescape(DKMC);
		type = UtilFactory.getStrUtil().unescape(type);
		BZ = UtilFactory.getStrUtil().unescape(BZ);
		YDXZ = UtilFactory.getStrUtil().unescape(YDXZ);
		GHSJLY = UtilFactory.getStrUtil().unescape(GHSJLY);
		int i=0;
if(yw_guid!=null&&!yw_guid.equals("")){
	String sql = " update  dcsjk_kgzb set DKMC='" + DKMC + "',YDXZDH='"
	+ YDXZDH + "' ,YDXZ='" + YDXZ + "' ,JSYDMJ='" + JSYDMJ
	+ "',RJL='" + RJL + "',GHJZGM='" + GHJZGM + "',JZKZGD='"
	+ JZKZGD + "',JZMD='" + JZMD + "',LHL='" + LHL
	+ "',DBZS='"+DBZS+"',DXMK='"+DXMK+"',GHSJLY='"+GHSJLY+"',BZ='"+BZ+"' where yw_guid=? and dqy=?";
    i = update(sql, YW, new Object[] { yw_guid, type });
}else{
	String sql = " insert into  dcsjk_kgzb ( DKMC,YDXZDH,YDXZ ,JSYDMJ,RJL,GHJZGM,JZKZGD,JZMD,LHL,DBZS,DXMK,GHSJLY,BZ,dqy) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
   i = update(sql, YW, new Object[] { DKMC,YDXZDH,YDXZ ,JSYDMJ,RJL,GHJZGM,JZKZGD,JZMD,LHL,DBZS,DXMK,GHSJLY,BZ,type });
}
if(i==1){
	response("success");
}
	}

}
