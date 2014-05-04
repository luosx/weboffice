package com.klspta.web.cbd.sccsl;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

public class EsfzjjcManager extends AbstractBaseBean {

	public List<Map<String, Object>> getESFData() {
		String sql = "select t.ssqy as ssqy,rownum as xh,t.xqmc as xqmc,t.xz as xz,t.jsnd as jsnd,t.qw as qw,t.jzlx as jzlx,t.wyf as wyf," +
				"t.ldzs as ldzs,t.fwzs as fwzs,t.lczk as lczk,t.rjl as rjl,t.lhl as lhl," +
				"t.tcw as tcw,t.kfs as kfs,t.wygs as wygs,t.dz as dz,t.yw_guid as yw_guid,t.url from esf_jbxx t order by t.ssqy";
		List<Map<String, Object>> result = query(sql, YW);
		for(int i=0 ; i < result.size();i++){
			result.get(i).put("XH", i+1+"");
		}
		return result;
	}

	public List<Map<String, Object>> getESFData(String keyword) {
		List<Map<String, Object>> result = null;
		if(!"".equals(keyword)){
			String sql = "select t.ssqy as ssqy,rownum as xh,t.xqmc as xqmc,t.xz as xz,t.jsnd as jsnd,t.qw as qw,t.jzlx as jzlx,t.wyf as wyf," +
				"t.ldzs as ldzs,t.fwzs as fwzs,t.lczk as lczk,t.rjl as rjl,t.lhl as lhl," +
				"t.tcw as tcw,t.kfs as kfs,t.wygs as wygs,t.dz as dz,t.yw_guid as yw_guid from esf_jbxx t " +
				"where t.ssqy like '"+keyword+"' or t.xqmc like '" +keyword+"' or t.xz like '"+keyword+"' or t.jsnd like '"+keyword+
				"' or t.qw like '"+keyword+"' or t.jzlx like '"+keyword+"' or t.wyf like '"+keyword+"' or t.tcw like '"+keyword+
				"' or t.kfs like '"+keyword+"' or t.wygs like '"+keyword+"' or t.dz like '"+keyword+"' order by t.ssqy";
			result = query(sql, YW);
			for(int i=0 ; i < result.size();i++){
				result.get(i).put("XH", i+1+"");
			}
		}else result = getESFData();
		return result;
	}

	public void getXZL() {
		List<Map<String, Object>> result = getESFData();
		for (int i = 0; i < result.size(); i++) {
			result.get(i).put("XIANGXI", i);
		}
		response(result);
	}

	public void saveXzlzj() {
		String zj = request.getParameter("zj");
		String sj = request.getParameter("sj");
		String yw_guid = request.getParameter("yw_guid");
		String xzlmc = request.getParameter("xzlmc");
		xzlmc = UtilFactory.getStrUtil().unescape(xzlmc);
		StringBuffer sql = new StringBuffer();
		String year = Calendar.getInstance().get(Calendar.YEAR) + "";
		String month = Calendar.getInstance().get(Calendar.MONTH) + 1 + "";
		String sql1 = "select bh from ESF_JBXX where yw_guid='" + yw_guid + "'";
		String bh = query(sql1, YW).get(0).get("BH").toString();
		sql.append("merge into ESF_ZSXX j using(select distinct '");
		sql
				.append("' as nd,'")
				.append(month)
				.append(
						"' as jd from ESF_ZSXX t ) t2 on (j.year=t2.nd and j.month = t2.jd and j.bh=?) when matched then ");
		sql
				.append("update set j.zj=? , j.sj =? when not matched then insert(j.bh,j.xzlmc,j.year, j.month, j.zj,j.sj)");
		sql.append(" values(?,?,?, ?, ?,?)");
		update(sql.toString(), YW, new Object[] { bh, zj, sj, bh, xzlmc, year,
				month, zj, sj });
		response("true");
	}

	/**
	 * 获取补偿标准
	 * 
	 * @return
	 */
	public List<Map<String, Object>> getBCBZ() {
		List<Map<String, Object>> result = null;
		String sql = "select * from bcbz";
		try {
			result = query(sql, YW);
			List<Map<String, Object>> result1 = null;
			sql = "select round(sum(zzzsgm)/sum(zzzshs)*10000,2) as hj from jc_jiben";
			result1 = query(sql, YW);
			Map<String, Object> map = result.get(0);
			double hjdouble = Double.parseDouble(map.get("bcf").toString())
			+ Double.parseDouble(map.get("bzf").toString())
			/ Double.parseDouble(result1.get(0).get("hj").toString());
			DecimalFormat df = new DecimalFormat("#.00");
			String hj = df.format(hjdouble);
			map.put("hj", hj);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}
}