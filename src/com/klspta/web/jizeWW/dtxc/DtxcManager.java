package com.klspta.web.jizeWW.dtxc;

import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.console.ManagerFactory;

/**
 * 
 * <br>Title:动态巡查管理类
 * <br>Description:动态巡查管理类
 * <br>Author:王雷
 * <br>Date:2013-9-18
 */
public class DtxcManager extends AbstractBaseBean {
	
	private static String xcbh	= "";
	
	/**
	 * 
	 * <br>Title: 生成巡查编号
	 * <br>Description: 
	 * <br>Author: 姚建林
	 * <br>Date: 2013-6-18
	 */
	public String buildXcbh(){
		int intnum = 0;
		String stringnum = "";
		
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd", new DateFormatSymbols());
		String dateString = df.format(Calendar.getInstance().getTime());
		
		if("".equals(xcbh)){
			String sql = "select max(substr(t.xcbh,11,3)) num from xcrz t where t.xcbh like '%" + dateString + "%'";
			List<Map<String, Object>> result = query(sql, YW);
			if(result.get(0).get("num") != null){
				intnum = Integer.parseInt(result.get(0).get("num").toString()) + 1;
				stringnum = "00" + intnum;
				stringnum = stringnum.substring(stringnum.length() - 3);
				xcbh = "XC" + dateString + stringnum;
			}else{
				xcbh = "XC" + dateString + "001";
			}
		}else{
			intnum = Integer.parseInt(xcbh.substring(10)) + 1;
			stringnum = "00" + intnum;
			stringnum = stringnum.substring(stringnum.length() - 3);
			xcbh = "XC" + dateString + stringnum;
		}
		return xcbh;
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
			responseException(this, "getXcrzListByUserId", "400001", e);
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
	
	/**
	 * 
	 * <br>Title: 生成抄告单统一编号
	 * <br>Description: 
	 * <br>Author: 姚建林
	 * <br>Date: 2013-6-22
	 */
	public void buildCgdbh(){
		//获得前台参数
		String yw_guid = request.getParameter("yw_guid");
		String cgdid = request.getParameter("cgdid");
		String sql = "select cgdbh from xcrzcgd where yw_guid = ? and cgdid = ?";
		List<Map<String, Object>> result = query(sql, YW, new Object[]{yw_guid,cgdid});
		if(result.size() == 1){
			response(result.get(0).get("cgdbh").toString());
		}
		if(result.size() == 0){
			StringBuffer cgdbh = new StringBuffer();
			String strCou = "";
			//年份
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String strDate = sdf.format(date);
			cgdbh.append("〔");
			cgdbh.append(strDate.substring(0,4));
			cgdbh.append("〕");
			//添加流水号
			sql = "select cgdbh from( select substr(t.cgdbh,7,3) cgdbh from xcrzcgd t where userid <> '1' order by t.createdate desc) where rownum=1";
			result = query(sql, YW);
			if(result != null && result.size() > 0){
				strCou = result.get(0).get("cgdbh").toString();//数据库中日志条数
			}else{
				strCou = "0";
			}
			int intCou = Integer.parseInt(strCou) + 1;//新生成日志是数据库中日志条数+1
			String strtemp = intCou + "";
			int i = strtemp.length();
			int j = 3 - i;//3位流水号
			for (int n = 0; n < j; n++) {
				cgdbh.append("0");
			}
			cgdbh.append(strtemp);
			cgdbh.append("号");
			
			//返回生成好的巡查日志编号
			response(cgdbh.toString());
		}
	}
	
	/**
	 * 
	 * <br>Title: 保存抄告单编号
	 * <br>Description: 
	 * <br>Author: 姚建林
	 * <br>Date: 2013-6-22
	 */
	public void saveCgdbh(){
		//获得前台参数
		String yw_guid = request.getParameter("yw_guid");
		String cgdid = request.getParameter("cgdid");
		String sql = "select * from xcrzcgd where yw_guid = ? and cgdid = ?";
		List<Map<String, Object>> result = query(sql, YW, new Object[]{yw_guid,cgdid});
		//如果数据库中之前没有这条记录，执行插入
		if(result.size() == 0){
			String cgdbh = UtilFactory.getStrUtil().unescape(request.getParameter("cgdbh"));
			String userid = request.getParameter("userid");
			//向数据库中插入数据
			sql = "insert into xcrzcgd (yw_guid,cgdid,cgdbh,userid) values (?,?,?,?)";
			update(sql, YW, new Object[]{yw_guid,cgdid,cgdbh,userid});		
		}	
	}
	
	/**
	 * 
	 * <br>Description:获取抄告单状态
	 * <br>Author:王雷
	 * <br>Date:2013-9-18
	 */
	public void getCgdState(){
	    String yw_guid = request.getParameter("yw_guid");
	    String sql = "select t.cgdqk from xcrz_cg t where t.yw_guid=? order by t.num asc";
	    List<Map<String,Object>> list = query(sql,YW,new Object[]{yw_guid});
	    response(list);
	}

	/**
	 * 
	 * <br>Title: 根据当前巡查日志获取上一笔巡查日志
	 * <br>Description: 
	 * <br>Author: 黎春行
	 * <br>Date: 2013-6-24
	 */	
	public void getPreXcrz(){
		String num = request.getParameter("num");
		String userId = request.getParameter("userId");
		String keyWord = request.getParameter("keyWord");
		
		int preNum = Integer.parseInt(num) - 1;
		if(preNum < 0){
			response("error");
			return ;
		}
		
		String userXzqh = "";
		String sql = "";
		try {
			userXzqh = ManagerFactory.getUserManager().getUserWithId(userId).getXzqh();
		} catch (Exception e) {
			responseException(this, "getPreXcrz", "400001", e);
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
		response((String)result.get(preNum).get("YW_GUID"));
	}
	
	/**
	 * 
	 * <br>Title: 根据当前巡查日志获取下一笔巡查日志
	 * <br>Description: 
	 * <br>Author: 黎春行
	 * <br>Date: 2013-6-24
	 */	
	public void getNextXcrz(){
		
		String num = request.getParameter("num");
		String userId = request.getParameter("userId");
		String keyWord = request.getParameter("keyWord");
		String userXzqh = "";
		String sql = "";
		try {
			userXzqh = ManagerFactory.getUserManager().getUserWithId(userId).getXzqh();
		} catch (Exception e) {
			responseException(this, "getNextXcrz", "400001", e);
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
		int nextNum = Integer.parseInt(num) + 1;
		if(nextNum >= result.size()){
			response("error");
		}else{
			response((String)result.get(nextNum).get("YW_GUID"));
		}
	}
	
	/**
	 * 
	 * <br>Description:判断巡查日志是否有巡查成果
	 * <br>Author:王雷
	 * <br>Date:2013-7-13
	 */
	public void isHaveCG(){
		String yw_guid = request.getParameter("yw_guid");
		String selectSQL="select substr(t.xcdw,0,3) xcq,t.xcrq from xcrz t where t.yw_guid=?";
		List<Map<String,Object>> list = query(selectSQL,YW,new Object[]{yw_guid});
		String xcq="";
		String xcrq="";
		if(list!=null && list.size()>0){
			Map<String,Object> map = list.get(0);
			xcq = (String)map.get("xcq");
			xcrq = (String)map.get("xcrq");
			String selectCgSQL="select t.yw_guid from dc_ydqkdcb t where to_char(to_date(t.hcrq,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') = to_char(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') and t.xian=?";
			List<Map<String,Object>> list2 = query(selectCgSQL,YW,new Object[]{xcrq,xcq});
			if(list2!=null && list2.size()>0){
				response("1");				
			}else{
			    response("0");  
			}		
		}else{
		    response("0");    
		}
	}
	
	/**
	 * 
	 * <br>Description:判断此yw_guid是否在数据库中存在
	 * <br>Author:姚建林
	 * <br>Date:2013-9-10
	 * @param strKey是需要判断的yw_guid
	 * @return
	 */
	public String checkGuid(String strKey){
		String newForm = "true";
		String sql = "select t.yw_guid from xcrz t where t.yw_guid = ?";
		List<Map<String, Object>> resultList = query(sql, YW ,new Object[]{strKey});
		if(resultList.size() == 1){
			newForm = "false";
		}
		return newForm;
	}
	
}
