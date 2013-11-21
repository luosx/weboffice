package com.klspta.web.xiamen.xfjb;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.console.ManagerFactory;

public class XfjbManager extends AbstractBaseBean {
	/**
	 * 
	 * <br>Description:根据登陆人员获取对应的待处理信访案件
	 * <br>Author:朱波海
	 * <br>Date:2013-11-19
	 * @throws Exception
	 */
	public void getXfjbDcl() throws Exception {
		String userId = request.getParameter("userId");
		String keyWord = request.getParameter("keyWord");
		String fullName = ManagerFactory.getUserManager().getUserWithId(userId)
				.getFullName();
		String sql = "select  t.yw_guid,t.jbr,t.jbxs,t.lxdz,t.jbzywt,to_char(t.jbsj, 'yyyy-MM-dd')as jbsj ,t.lxdh ,t.jsr,t.jlr,j.activity_name_ ajblzt, j.wfinsid from xfdjb t join workflow.v_active_task j on t.yw_guid=j.yw_guid where j.assignee_=?";
		if (keyWord != null) {
			keyWord = UtilFactory.getStrUtil().unescape(keyWord);
			sql += " and (t.jbr||t.jbxs||t.jbsj||t.JSR||t.JLR like '%"
					+ keyWord + "%') ";
		}
		sql += " order by jbsj desc";
		List<Map<String, Object>> result = query(sql, YW,
				new String[] { fullName });
		// 调整数据格式
		int i = 0;
		for (Map<String, Object> map : result) {
			map.put("INDEX", i++);
		}
		response(result);
	}
	/**
	 * 
	 * <br>Description:获取登陆人员已处理的信访案件
	 * <br>Author:朱波海
	 * <br>Date:2013-11-19
	 * @throws Exception
	 */
	public void getXfjbYcl() throws Exception{
	String userId = request.getParameter("userId");
	String keyWord = request.getParameter("keyWord");
	// 获取参数
	String fullName = ManagerFactory.getUserManager().getUserWithId(userId)
			.getFullName();
	// 获取数据
	String sql = "select distinct t.yw_guid,t.jbr,t.jbxs,t.lxdz,t.jbzywt,to_char(t.jbsj, 'yyyy-MM-dd')as jbsj ,t.lxdh ,t.jsr,t.jlr,j.activityname as ajblzt, j.wfinsid from xfdjb t left join workflow.v_hist_task j on t.yw_guid=j.yw_guid where j.assignee_=?";
	if (keyWord != null) {
		keyWord = UtilFactory.getStrUtil().unescape(keyWord);
		sql += "and (t.jbr||t.jbxs||t.jbsj||t.JSR||t.JLR like '%"
				+ keyWord + "%')";
	}
	sql += " order by jbsj desc";
	List<Map<String, Object>> result = query(sql, YW,
			new String[] { fullName });
	int i = 0;
	for (Map<String, Object> map : result) {
		map.put("INDEX", i++);
	}
	response(result);
	}

	/**
	 * 
	 * <br>Description:获取所有信访办理中案件，案件查询时使用
	 * <br>Author:朱波海
	 * <br>Date:2013-11-20
	 */
	
	public void getXfjbBlz(){
		String keyWord = request.getParameter("keyWord");
		String sql = "select t.yw_guid,t.jbr,t.jbxs,t.lxdz,t.jbzywt,to_char(t.jbsj, 'yyyy-MM-dd')as jbsj ,t.lxdh ,t.jsr,t.jlr, j.activity_name_ ajblzt, j.wfinsid from xfdjb t inner join workflow.v_active_task j on t.yw_guid=j.yw_guid ";
		if (keyWord != null) {
			keyWord = UtilFactory.getStrUtil().unescape(keyWord);
			sql += " and (t.jbr||t.jbxs||t.jbsj||t.JSR||t.JLR like '%"
					+ keyWord + "%')";
		}
		sql += " order by jbsj desc";
		List<Map<String, Object>> result = query(sql, YW);
		int i = 0;
		for (Map<String, Object> map : result) {
			map.put("INDEX", i++);
		}
		response(result);
	}
	/**
	 * 
	 * <br>Description:获取所有信访已办结案件，案件查询时使用
	 * <br>Author:朱波海
	 * <br>Date:2013-11-20
	 */
	public void getXFEndList(){
		String keyWord = request.getParameter("keyWord");
			// 获取数据
			String sql = "select t.yw_guid,t.jbr,t.jbxs,t.lxdz,t.jbzywt,to_char(t.jbsj, 'yyyy-MM-dd')as jbsj ,t.lxdh ,t.jsr,t.jlr,j.endactivity_ ajblzt, j.wfinsid from xfdjb t inner join workflow.v_end_wfins j on t.yw_guid=j.yw_guid ";
			if (keyWord != null) {
				keyWord = UtilFactory.getStrUtil().unescape(keyWord);
				sql += " and (t.jbr||t.jbxs||t.jbsj||t.JSR||t.JLR like '%"
						+ keyWord + "%')";
			}
			sql += " order by j.end_ desc";
			List<Map<String, Object>> result = query(sql, YW);
			// 调整数据格式
			int i = 0;
			for (Map<String, Object> map : result) {
				map.put("INDEX", i++);
			}
			response(result);
	}
	
	
}
