package com.klspta.web.xuzhouNW.ajgl;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.FactoryUtils;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.vividsolutions.jts.algorithm.match.SimilarityMeasure;

/**
 * 
 * <br>
 * Title:案件管理 <br>
 * Description: 类功能描述 <br>
 * Author:李亚栓 <br>
 * Date:2012-8-10
 */
public class AnjianManager extends AbstractBaseBean {
	// 案件状态
	private final String WCLStatus = "1";// 未处理、未立案（疑似违法）
	private final String CLZ_WhcStatus = "2";// 处理中未核查状态
	private final String CLZ_YhcStatus = "6";// 处理中已核查状态
	private final String YLAStatus = "3";// 已立案
	private final String HEStatus = "4";// 合法
	private final String LABJStatus = "5";// 立案办结
	
	// 案件管理-【信访举报】
	/**
	 * 
	 * <br>
	 * Description:信访举报列表 <br>
	 * Author:李亚栓 <br>
	 * Date:2012-8-10
	 */
	public void getXfjbList() {
		// 获取输入的关键字
		String keyword = request.getParameter("keyWord");
		String status = request.getParameter("status");
		String strColumnName = "t.XSH||t.DJR||t.BJBDW||t.DJRQ||t.WTFSD7||XSZY";
		String where = "";
		String sql = null;
		if (keyword != null && !"".equals(keyword)) {
			keyword = keyword.trim();
			while (keyword.indexOf("  ") > 0) {// 循环去掉多个空格，所有字符中间只用一个空格间隔
				keyword = keyword.replace("  ", " ");
			}
			keyword = UtilFactory.getStrUtil().unescape(keyword);
			// keyword=keyword.toUpperCase();
			where += " and ("+ strColumnName+ " like '%"+ (keyword.replaceAll(" ", "%' and " + strColumnName+ "  like '%")) + "%')";// 查询条件
		}
		String ajStatus = "";
		if (this.WCLStatus.equals(status)) {
			sql = "select (rownum-1) as ROWNUM1,t.XSH,t.DJR,t.BJBDW,to_char(t.DJRQ,'yyyy-MM-dd') as DJRQ,WTFSD7,XSZY, t.YW_GUID from wfxsdjbl t where  (t.AJSTATUS ='"+ WCLStatus + "' or t.AJSTATUS is   null) ";
		} else if (this.CLZ_WhcStatus.equals(status)) {
			ajStatus = CLZ_WhcStatus;
			sql = "select (rownum-1) as ROWNUM1,t.XSH,t.DJR,t.BJBDW,to_char(t.DJRQ,'yyyy-MM-dd') as DJRQ,WTFSD7,XSZY , t.YW_GUID from wfxsdjbl t where t.AJSTATUS ='"+ ajStatus + "'";
		} else if(this.CLZ_YhcStatus.equals(status)){
			ajStatus = CLZ_YhcStatus;
			sql = "select (rownum-1) as ROWNUM1,t.XSH,t.DJR,t.BJBDW,to_char(t.DJRQ,'yyyy-MM-dd') as DJRQ,WTFSD7,XSZY , t.YW_GUID from wfxsdjbl t where t.AJSTATUS ='"+ ajStatus + "'";
		}else if (this.YLAStatus.equals(status)) {
			ajStatus = YLAStatus;
			sql = "select (rownum-1) as ROWNUM1,t.XSH,t.DJR,t.BJBDW,to_char(t.DJRQ,'yyyy-MM-dd') as DJRQ,WTFSD7,XSZY , t.YW_GUID from wfxsdjbl t where t.AJSTATUS ='"+ ajStatus + "'";
		} else if (this.HEStatus.equals(status)) {
			ajStatus = HEStatus;
			sql = "select (rownum-1) as ROWNUM1,t.XSH,t.DJR,t.BJBDW,to_char(t.DJRQ,'yyyy-MM-dd') as DJRQ,WTFSD7,XSZY , t.YW_GUID from wfxsdjbl t where t.AJSTATUS ='"+ ajStatus + "'";
		} else if (this.LABJStatus.equals(status)) {
			ajStatus = LABJStatus;
			sql = "select (rownum-1) as ROWNUM1,t.XSH,t.DJR,t.BJBDW,to_char(t.DJRQ,'yyyy-MM-dd') as DJRQ,WTFSD7,XSZY , t.YW_GUID from wfxsdjbl t where t.AJSTATUS ='"+ ajStatus + "'";
		}
		sql += where += "";
		List<Map<String, Object>> listYw = query(sql, YW);
		response(listYw);
	}

	/**
	 * 
	 * <br>
	 * Description:信访举报【处理中：立案】信访举报操作 <br>
	 * Author:李亚栓 <br>
	 * Date:2012-8-10
	 */
	public void liAnOperate() {
		String yw_guid = request.getParameter("yw_guid");
		// 将【处理中】状态的案件设为【立案】
		String sql = "update wfxsdjbl set AJSTATUS ='" + YLAStatus+ "' where yw_guid=?";
		Object[] args = { yw_guid };
		int i = update(sql, YW, args);
		try {
			if (i > 0) {
				response.getWriter().write("{success:true,msg:true}");
			} else {
				response.getWriter().write("{success:failure,msg:true}");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 
	 * <br>
	 * Description:【处理中的合法按钮】操作 <br>
	 * Author:李亚栓 <br>
	 * Date:2012-8-10
	 */
	public void heFaAnJi() {
		// 获取yw_guid字符串
		String ids = request.getParameter("ids");
		// 2表示：处理中，4表示：合法
		String[] strs = ids.split(",");
		for (int i = 0; i < strs.length; i++) {
			String sql = "update wfxsdjbl set AJSTATUS ='" + HEStatus+ "' where yw_guid='" + strs[i] + "'";
			int a = update(sql, YW);
			if (a > 0) {
				response("0");
			} else {
				response("1");
				System.out.println("修改失败");
			}
		}
	}

	/**
	 * 
	 * <br>
	 * Description:信访举报【处理中的立案按钮】操作 <br>
	 * Author:李亚栓 <br>
	 * Date:2012-8-10
	 */
	public void clzXfjbLa() {
		// 1未处理2处理中3已立案 办结：4合法5立案办结
		String yw_guid = request.getParameter("yw_guid");
		String sql = "update wfxsdjbl set AJSTATUS ='" + YLAStatus+ "' where yw_guid=?";
		int a = update(sql, YW, new Object[] { yw_guid });
		if (a > 0) {
			response("0");
		} else {
			System.out.println("操作失败！！");
		}

	}

	// 案件管理-【巡查发现】
	/**
	 * 
	 * <br>
	 * Description:巡查发现列表 <br>
	 * Author:李亚栓 <br>
	 * Date:2012-8-11
	 */
	public void getXcfxList() {
		// String flag=request.getParameter("flag");
		String keyWord = request.getParameter("keyWord");
		String status = request.getParameter("status");
		String strColumnName = "guid||xmmc||dwmc|| rwlx|| wfdd|| rwms||sfwf||xcqkms|| xcr|| xcrq|| cjzb||jwzb||imgname|| gpsid";
		String sql = null;
		String where = "";
		if (keyWord != null && !"".equals(keyWord)) {
			keyWord = keyWord.trim();
			while (keyWord.indexOf("  ") > 0) {// 循环去掉多个空格，所有字符中间只用一个空格间隔
				keyWord = keyWord.replace("  ", " ");
			}
			keyWord = UtilFactory.getStrUtil().unescape(keyWord);
			// keyword=keyword.toUpperCase();
			where += " and ("+ strColumnName+ " like '%"+ (keyWord.replaceAll(" ", "%' and " + strColumnName+ "  like '%")) + "%')";// 查询条件
		}
		String ajStatus = "";
		if (this.WCLStatus.equals(status)) {
			ajStatus = WCLStatus;
		} else if (this.YLAStatus.equals(status)) {
			ajStatus = YLAStatus;
		} else if (this.HEStatus.equals(status)) {
			ajStatus = HEStatus;
		} else if (this.LABJStatus.equals(status)) {
			ajStatus = LABJStatus;
		}
		sql = "select (rownum-1) as ROWNUM1,guid,xmmc,dwmc, rwlx, wfdd, rwms,sfwf,xcqkms, xcr, to_char(xcrq,'yyyy-MM-dd') as xcrq , cjzb,jwzb,imgname, gpsid from WY_DEVICE_DATA where AJSTATUS='"+ ajStatus + "' and guid like 'XC%'";
		sql += where += "";
		List<Map<String, Object>> listYw = query(sql, YW);
		response(listYw);
	}

	/**
	 * <br>
	 * Description:巡查发现-未立案-设为合法 操作 <br>
	 * Author:李亚栓 <br>
	 * Date:2012-8-11
	 */
	public void wlaXcfxSwHa() {
		String ids = request.getParameter("ids");
		String[] guids = ids.split(",");
		String sql = null;
		for (int i = 0; i < guids.length; i++) {
			sql = "update WY_DEVICE_DATA set sfwf='合法' , AJSTATUS ='"+ HEStatus + "' where guid='" + guids[i] + "'";
			int a = update(sql, YW);
			if (a > 0) {
				response("0");
			} else {
				System.out.println("操作失败！！");
			}
		}
	}

	/**
	 * 
	 * <br>
	 * Description:巡查发现-未立案-立案操作 <br>
	 * Author:李亚栓 <br>
	 * Date:2012-8-11
	 */
	public void xcfxLa() {
		// 获取yw_guid字符串
		String guid = request.getParameter("guid");
		String sql = null;
		// 将【未处理】状态的案件设为【立案】
		sql = "update wy_device_data set AJSTATUS ='" + YLAStatus+ "' where guid='" + guid + "'";
		int a = update(sql, YW);
		if (a > 0) {
			response("0");
		} else {
			response("false");
			System.out.println("修改失败");
		}
	}

	/**
	 * 
	 * <br>
	 * Description:巡查发现-合法 <br>
	 * Author:李亚栓 <br>
	 * Date:2012-8-11
	 */
	public void checkLegal() {
		// 获取yw_guid字符串
		String ids = request.getParameter("ids");
		String[] strs = ids.split(",");
		String sql = null;
		for (int i = 0; i < strs.length; i++) {
			sql = "update zfjc_wyxc_sdxcqkb set AJSTATUS ='3' where yw_guid='"
					+ strs[0] + "'";
			int a = update(sql, YW);
			if (a > 0) {
				response("true");
			} else {
				response("false");
				System.out.println("修改失败");
			}
		}

	}

	// 案件管理-【卫片执法】
	/**
	 * 
	 * <br>
	 * Description:卫片执法 列表 <br>
	 * Author:李亚栓 王龙梅 <br>
	 * Date:2012-8-11
	 */
	public void getWpzfList() {
		String keyWord = request.getParameter("keyWord");
		String strColumnName = "t.TBBH||t.XZQHMC||to_char(t.TBMJ)||t.QSX||t.HSX||to_char(t.TIME,'yyyy-MM-dd')";
		String status = request.getParameter("status");
		String hzqhs1 =request.getParameter("hzqhs1");
		String hzqhs2 =request.getParameter("hzqhs2");
		String hzqhs3 =request.getParameter("hzqhs3");
		String addsql="";
		String hst="";
		if(hzqhs2==""){
			if(hzqhs1.endsWith("00")){
				hst= hzqhs1.substring(0,hzqhs1.lastIndexOf("00"));
				addsql=" and t.xzqhdm like '"+hst+"__'";
				}
			else addsql=" and t.xzqhdm='"+hzqhs1+"'";
		}else{
		if(hzqhs3==""&&hzqhs2!=""){
			addsql=" and ( t.xzqhdm='"+hzqhs1+"' or t.xzqhdm='"+hzqhs2+"' )";
		}else{
			addsql=" and ( t.xzqhdm='"+hzqhs1+"' or t.xzqhdm='"+hzqhs2+"' or t.xzqhdm='"+hzqhs3+"' )";
		}
		}
		String where = "";
		String sql = null;
		if (keyWord != null && !"".equals(keyWord)) {
			keyWord = keyWord.trim();
			while (keyWord.indexOf("  ") > 0) {// 循环去掉多个空格，所有字符中间只用一个空格间隔
				keyWord = keyWord.replace("  ", " ");
			}
			keyWord = UtilFactory.getStrUtil().unescape(keyWord);
			keyWord = keyWord.toUpperCase();
			where += " and ("+ strColumnName+ " like '%"+ (keyWord.replaceAll(" ", "%' and " + strColumnName+ "  like '%")) + "%')";// 查询条件
		}
		if (status.equals(this.WCLStatus)) {
			sql = "select t.TBBH,t.XZQHMC,to_char(t.TBMJ) TBMJ,t.QSX,t.HSX,t.ISHF from wpzf_tb t where t.tbbh not in (select s.tbbh from wpzf_analyse_sp s) and t.AJSTATUS ='1' "+ where+addsql+ " union select t.TBBH,t.XZQHMC,t.TBMJ,t.QSX,t.HSX,t.ISHF from wpzf_tb t,wpzf_analyse_sp s where t.tbbh = s.tbbh and t.AJSTATUS ='1' and s.YGBL < 0.7 "+ where+addsql+" order by t.time desc";
		} else if (status.equals(this.CLZ_WhcStatus)) {
			sql = "select t.TBBH,t.XZQHMC,to_char(t.TBMJ) TBMJ,t.QSX,t.HSX,to_char(t.TIME,'yyyy-MM-dd') TIME,t.ISHF from wpzf_tb t where t.AJSTATUS='"+ this.CLZ_WhcStatus + "'"+addsql;
		}else if (status.equals(this.CLZ_YhcStatus)) {
			sql = "select t.TBBH,t.XZQHMC,to_char(t.TBMJ) TBMJ,t.QSX,t.HSX,to_char(t.TIME,'yyyy-MM-dd') TIME,t.ISHF from wpzf_tb t where t.AJSTATUS='"+ this.CLZ_YhcStatus + "'"+addsql;
		} else if (this.YLAStatus.equals(status)) {
			sql = "select t.TBBH,t.XZQHMC,to_char(t.TBMJ) TBMJ,t.QSX,t.HSX,to_char(t.TIME,'yyyy-MM-dd') TIME,t.ISHF from wpzf_tb t where t.AJSTATUS='"+ this.YLAStatus + "'"+addsql;
		} else if (this.HEStatus.equals(status)) {
			sql = "select t.TBBH,t.XZQHMC,to_char(t.TBMJ) TBMJ,t.QSX,t.HSX,to_char(t.TIME,'yyyy-MM-dd') TIME,t.ISHF from wpzf_tb t where t.AJSTATUS='"+ this.HEStatus + "'"+addsql;
		} else if (this.LABJStatus.equals(status)) {
			sql = "select t.TBBH,t.XZQHMC,to_char(t.TBMJ) TBMJ,t.QSX,t.HSX,to_char(t.TIME,'yyyy-MM-dd') TIME,t.ISHF from wpzf_tb t where t.AJSTATUS='"+ this.LABJStatus + "'"+addsql;
		}
		sql += where;
		sql+="  order by t.time desc";
		// 卫片执法中可疑违法
		List<Map<String, Object>> wplist = query(sql, YW);
		int i = 0;
		for (Map<String, Object> wp:wplist) {
			wp.put("ROWNUM1", i);
			i++;
		}
		response(wplist);
	}

	
	/**
	 * 
	 * <br>
	 * Description:获取所有案件列表 <br>
	 * Author:黎春行 <br>
	 * Date:2012-8-12
	 */
	public void getAllList() {
		// 获取输入的关键字
		String keyword = request.getParameter("keyWord");
		String strColumnName = "t.XSH||t.DJR||t.BJBDW||t.DJRQ||t.WTFSD7||XSZY";
		String where = "";
		String sql = null;
		sql = "select t.XSH,t.DJR,t.BJBDW,to_char(t.DJRQ,'yyyy-MM-dd') as DJRQ,WTFSD7,XSZY, t.YW_GUID from wfxsdjbl t";
		if (keyword != null && !"".equals(keyword)) {
			keyword = keyword.trim();
			while (keyword.indexOf("  ") > 0) {// 循环去掉多个空格，所有字符中间只用一个空格间隔
				keyword = keyword.replace("  ", " ");
			}
			keyword = UtilFactory.getStrUtil().unescape(keyword);
			// keyword=keyword.toUpperCase();
			where += " and ("+ strColumnName+ " like '%"+ (keyword.replaceAll(" ", "%' and " + strColumnName+ "  like '%")) + "%')";// 查询条件
		}
		sql = "select t.XSH,t.DJR,t.BJBDW,to_char(t.DJRQ,'yyyy-MM-dd') as DJRQ,WTFSD7,XSZY , t.YW_GUID from wfxsdjbl t ";
		sql += where += " order by t.XSH asc";
		List<Map<String, Object>> listYw = query(sql, YW);
		int i = 0;
		for (Map<String, Object> list : listYw) {
			list.put("index", i);
			i++;
		}
		response(listYw);
	}

	/**
	 * 
	 * <br>
	 * Description:把未核查的设为已核查<br>
	 * Author:王龙梅 <br>
	 * Date:2012-8-11
	 */
	public void towclStatus() {
		String jcbh = request.getParameter("ids");
		String sql = "update wpzf_tb set AJSTATUS='"+HEStatus+"' where tbbh=?";
		String[] tbbh = jcbh.split(",");
		for (int i = 0; i < tbbh.length; i++) {
			update(sql, YW, new Object[] {tbbh[i] });
			response("0");
		}
	}
	/**
	 * 
	 * <br>
	 * Description:未处理的卫片设为合法 <br>
	 * Author:李亚栓 <br>
	 * Date:2012-8-11
	 */
	public void changeWpStatus() {
		String jcbh = request.getParameter("ids");
		String sql = "update wpzf_tb set AJSTATUS='"+HEStatus+"' where tbbh=?";
		String[] tbbh = jcbh.split(",");
		for (int i = 0; i < tbbh.length; i++) {
			update(sql, YW, new Object[] {tbbh[i] });
			response("0");
		}
	}
	/**
	 * 
	 * <br>
	 * Description:未处理的卫片设为待核查 <br>
	 * Author:王龙梅 <br>
	 * Date:2012-8-11
	 */
	public void xiaFa() {
		String jcbh = request.getParameter("ids");
		Date date =new Date();
		//String time = UtilFactory.getDateUtil().getCurrentChineseDate();
		//String dtstr=date.toString();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		String time=sdf.format(date);
		String sql = "update wpzf_tb t set t.AJSTATUS='"+CLZ_WhcStatus+"',t.time=to_date('"+time+"','yyyy-mm-dd hh24:mi:ss') where tbbh=?";
		String[] tbbh = jcbh.split(",");
		for (int i = 0; i < tbbh.length; i++) {
			update(sql, YW, new Object[] {tbbh[i] });
			response("0");
		}
	}
	
	/**
	 * 
	 * <br>
	 * Description:案件管理-卫片执法中【未处理-立案】操作 <br>
	 * Author:李亚栓 <br>
	 * Date:2012-8-11
	 */

	public void clzWpLa() {
		String tbbh = request.getParameter("tbbh");
		// 1未处理、未立案2处理中3已立案4合法5立案办结
		String sql = "update wpzf_tb set AJSTATUS ='"+YLAStatus+"' where tbbh=?";
		int a = update(sql, YW, new Object[] { tbbh });
		if (a > 0) {
			response("0");
		} else {
			System.out.println("操作失败！！");
		}
	}


}
