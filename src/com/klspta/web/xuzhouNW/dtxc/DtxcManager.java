package com.klspta.web.xuzhouNW.dtxc;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.console.ManagerFactory;

public class DtxcManager extends AbstractBaseBean {
	static String[] strSta = new String[]{"0","0","0","0","0"};
	/**
	 * 
	 * <br>Title: 生成巡查日志
	 * <br>Description: 
	 * <br>Author: 姚建林
	 * <br>Date: 2013-6-18
	 */
	public void buildXcrq() {
		//生成yw_guid
		String yw_guid= UtilFactory.getStrUtil().getGuid();
		//生成xcbh巡查编号
		String xcbh = buildXcbh();
		//生成巡查日期
		String xcrq = UtilFactory.getDateUtil().getSimpleDate(new Date());
		String sql = "insert into xcrz(yw_guid,xcbh,xcrq) values (?,?,?)";
		update(sql, YW ,new Object[]{yw_guid,xcbh,xcrq});
		String basePath = request.getScheme() + "://" + request.getServerName()
				+ ":" + request.getServerPort() + request.getContextPath()
				+ "/";
		StringBuffer url = new StringBuffer();
		url.append(basePath);
		url.append("/web/xuzhouNW/dtxc/xcrz/xcrz.jsp?jdbcname=YWTemplate&yw_guid=");
		url.append(yw_guid);
		redirect(url.toString());
	}
	
	/**
	 * 
	 * <br>Title: 生成巡查编号
	 * <br>Description: 
	 * <br>Author: 姚建林
	 * <br>Date: 2013-6-18
	 */
	public String buildXcbh(){
		StringBuffer xcbh = new StringBuffer();
		//添加编号头"XC"
		xcbh.append("XC");
		//添加日期
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String strDate = sdf.format(date);
		xcbh.append(strDate);
		//添加流水号
		String strSqlYear = strDate.substring(0,4);
		String sql = "select count(yw_guid) cou from xcrz t where Extract(year from t.writedate) = ? and userid <> '1'";
		List<Map<String, Object>> result = query(sql, YW ,new Object[]{strSqlYear});
		String strCou = result.get(0).get("cou").toString();//数据库中日志条数
		int intCou = Integer.parseInt(strCou) + 1;//新生成日志是数据库中日志条数+1
		String strtemp = intCou + "";
		int i = strtemp.length();
		int j = 5 - i;//5位流水号
		for (int n = 0; n < j; n++) {
			xcbh.append("0");
		}
		xcbh.append(strtemp);
		//返回生成好的巡查日志编号
		return xcbh.toString();
	}
	
	/**
	 * <br>
	 * Description:根据yw_guid获取巡查日志 <br>
	 * Author:黎春行 <br>
	 * Date:2013-06-18
	 * 
	 * @return
	 */
	public List<Map<String, Object>> getXzrqbyYw_guid(String yw_guid){
		String sql = "select * from xcrz t where t.yw_guid = ?";
		return query(sql, YW, new Object[]{yw_guid});
	}
	
	/**
	 * 
	 * <br>Title: 异步保存抄告单
	 * <br>Description: 
	 * <br>Author: 姚建林
	 * <br>Date: 2013-6-19
	 */
	public void saveCgd(){
		String yw_guid = request.getParameter("yw_guid");
		String strFlag = request.getParameter("strFlag");
		String jsxm = UtilFactory.getStrUtil().unescape(request.getParameter("jsxm"));
		String jsdw = UtilFactory.getStrUtil().unescape(request.getParameter("jsdw"));
		String dgsj = UtilFactory.getStrUtil().unescape(request.getParameter("dgsj"));
		String jsqk = UtilFactory.getStrUtil().unescape(request.getParameter("jsqk"));
		String zdmj = UtilFactory.getStrUtil().unescape(request.getParameter("zdmj"));
		String zdwz = UtilFactory.getStrUtil().unescape(request.getParameter("zdwz"));
		String sql = "";
		int temp = 0;
		for (int i = 1; i < 6; i++) {
			if(strFlag.contains(i+"")){
				temp = i;
				sql = "update xcrz set jsxm"+i+" = ?,jsdw"+i+" = ?,dgsj"+i+" = ?,jsqk"+i+" = ?,zdmj"+i+" = ?,zdwz"+i+" = ?,cgdqk"+i+" = ? where yw_guid = ?";
			}
		}
		update(sql, YW, new Object[]{jsxm,jsdw,dgsj,jsqk,zdmj,zdwz,1,yw_guid});
		response(strSta[temp - 1]);
		stateCgd(yw_guid);
	}
	
	/**
	 * 
	 * <br>Title: 异步删除抄告单
	 * <br>Description: 
	 * <br>Author: 姚建林
	 * <br>Date: 2013-6-19
	 */
	public void deleteCgd(){
		String yw_guid = request.getParameter("yw_guid");
		String strFlag = request.getParameter("strFlag");
		String sql = "";
		for (int i = 1; i < 6; i++) {
			if(strFlag.contains(i+"")){
				sql = "update xcrz set jsxm"+i+" = ?,jsdw"+i+" = ?,dgsj"+i+" = ?,jsqk"+i+" = ?,zdmj"+i+" = ?,zdwz"+i+" = ?,cgdqk"+i+" = ? where yw_guid = ?";
			}
		}
		update(sql, YW, new Object[]{"","","","","","",0,yw_guid});
	}
	
	/**
	 * 
	 * <br>Title: 向前台返回五个抄告单的状态
	 * <br>Description: 
	 * <br>Author: 姚建林
	 * <br>Date: 2013-6-19
	 */
	public String[] stateCgd(String yw_guid){
		String sql = "select cgdqk1,cgdqk2,cgdqk3,cgdqk4,cgdqk5 from xcrz where yw_guid = ?";
		List<Map<String, Object>> result = query(sql, YW, new Object[]{yw_guid});
		strSta[0] = result.get(0).get("cgdqk1").toString();
		strSta[1] = result.get(0).get("cgdqk2").toString();
		strSta[2] = result.get(0).get("cgdqk3").toString();
		strSta[3] = result.get(0).get("cgdqk4").toString();
		strSta[4] = result.get(0).get("cgdqk5").toString();
		return strSta;
	}
	
	/**
	 * 
	 * <br>Title: 根据userid获得巡查日志列表
	 * <br>Description: 
	 * <br>Author: 姚建林
	 * <br>Date: 2013-6-20
	 */
	public void getXcrzListByUserId(){
		String userId = request.getParameter("userId");
		String keyWord = request.getParameter("keyWord");
		String userXzqh = "";
		String sql = "";
		try {
			userXzqh = ManagerFactory.getUserManager().getUserWithId(userId).getXzqh();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(userXzqh.length() == 6){
			if(userXzqh.substring(4).equals("00")){//市级
				sql = "select (rownum-1) RUNNUM1,YW_GUID,XCBH,XCRQ,XCDW,XCQY,XCRY,SFYWF,SPQK,CLYJ from xcrz where writerxzqh like '"+userXzqh.substring(0,4)+"%'";
			}else{//县级
				sql = "select (rownum-1) RUNNUM1,YW_GUID,XCBH,XCRQ,XCDW,XCQY,XCRY,SFYWF,SPQK,CLYJ from xcrz where writerxzqh like '"+userXzqh+"%'";
			}
		}else{//乡镇级
			sql = "select (rownum-1) RUNNUM1,YW_GUID,XCBH,XCRQ,XCDW,XCQY,XCRY,SFYWF,SPQK,CLYJ from xcrz where writerxzqh = "+userXzqh;
		}
		if (keyWord != null) {
			keyWord = UtilFactory.getStrUtil().unescape(keyWord);
			sql += " and XCBH||XCDW||XCRQ||XCQY||XCRY||XCLX||SFYWF||CLYJ||SPQK like '%"+keyWord+"%'";
		}
		List<Map<String, Object>> result = query(sql, YW);
		response(result);
	}
}
