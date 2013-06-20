package com.klspta.web.xuzhouNW.xfjb.manager;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.console.ManagerFactory;

/**
 * 
 * <br>Title:信访案件管理类
 * <br>Description:案件处理状态管理类
 * <br>Author:黎春行
 * <br>Date:2013-5-21
 */
public class XfManager extends AbstractBaseBean {
	
	
	/**
	 * 
	 * <br>Description:获取待处理案件，根据角色id
	 * <br>Author:黎春行
	 * <br>Date:2013-5-21
	 * @param userId
	 * @return
	 * @throws Exception 
	 */
	public List<Map<String, Object>> getDCLListByUserId(String userId, String keyWord) throws Exception{
		String fullName = ManagerFactory.getUserManager().getUserWithId(userId).getFullName();
		String sql = "select t.yw_guid,t.bh ,t.xslx,t.jbr, t.jbfs, t.bjbdw, t.lxdz, t.wtfsd, to_char(t.djsj,'yyyy-MM-dd') as slrq, j.wfinsid from wfxsfkxx t join workflow.v_active_task j on t.yw_guid=j.yw_guid where j.assignee_=?";
		if (keyWord != null) {
			keyWord = UtilFactory.getStrUtil().unescape(keyWord);
			sql += " and (upper(t.bh)||upper(t.xslx)||upper(t.jbr)||upper(t.lxdz)||upper(t.wtfsd)||upper(j.create_)||upper(j.activity_name_) like '%"
					+ keyWord + "%')";
		}
		sql += " order by j.create_ desc";
		List<Map<String, Object>> result = query(sql, YW,
				new String[] { fullName });

		// 调整数据格式
		int i = 0;
		for (Map<String, Object> map : result) {
			if(map.get("dwmc")==null){
				map.put("DSR", map.get("grxm"));
			}else {
				map.put("DSR", map.get("dwmc"));
			}
			map.put("INDEX", i++);
		}
		return result;
	}
	
	/**
	 * 
	 * <br>Description:获取所有待处理案件
	 * <br>Author:黎春行
	 * <br>Date:2013-5-21
	 * @return
	 */
	public List<Map<String, Object>> getDCLAllList(){
		
		return null;
	}
	
	/**
	 * 
	 * <br>Description:根据已处理案件，根据角色id
	 * <br>Author:黎春行
	 * <br>Date:2013-5-21
	 * @param userId
	 * @return
	 * @throws Exception 
	 */
	public List<Map<String, Object>> getYCLListByUserId(String userId, String keyWord) throws Exception{
		// 获取参数
		String fullName = ManagerFactory.getUserManager().getUserWithId(userId).getFullName();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

		// 获取数据
		String sql = "select distinct t.yw_guid,t.bh ,t.xslx,t.jbr, t.jbfs, t.bjbdw, t.lxdz, t.wtfsd, to_char(t.djsj,'yyyy-MM-dd') as slrq, j.wfinsid from wfxsfkxx t join workflow.v_hist_task j on t.yw_guid=j.yw_guid where j.assignee_=?";
		if (keyWord != null) {
			keyWord = UtilFactory.getStrUtil().unescape(keyWord);
			sql += " and (upper(t.bh)||upper(t.xslx)||upper(t.jbr)||upper(t.lxdz)||upper(t.wtfsd)||upper(j.create_) like '%"
					+ keyWord + "%')";
		}
		// sql += " order by j.create_ desc";
		List<Map<String, Object>> result = query(sql, YW,
				new String[] { fullName });

		// 调整数据格式
		int i = 0;
		for (Map<String, Object> map : result) {
			if(map.get("dwmc")==null){
				map.put("DSR", map.get("grxm"));
			}else {
				map.put("DSR", map.get("dwmc"));
			}
			map.put("INDEX", i++);
		}
		return result;
	}
	
	/**
	 * 
	 * <br>Description:获取所有案件
	 * <br>Author:黎春行
	 * <br>Date:2013-5-21
	 * @return
	 */
	public List<Map<String, Object>> getAllList(String keyWord){
		// 获取参数
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		// 获取数据
		String sql = "select t.yw_guid,t.bh ,t.xslx,t.jbr, t.jbfs, t.bjbdw, t.lxdz, t.wtfsd, to_char(t.djsj,'yyyy-MM-dd') as slrq, j.wfinsid from wfxsfkxx t join workflow.v_active_task j on t.yw_guid=j.yw_guid ";
		if (keyWord != null) {
			keyWord = UtilFactory.getStrUtil().unescape(keyWord);
			sql += " where (upper(t.bh)||upper(t.xslx)||upper(t.jbfs)||upper(t.jbr)||upper(t.lxdz)||upper(t.wtfsd)||upper(j.create_)||upper(j.activity_name_) like '%"
					+ keyWord + "%')";
		}
		sql += " order by j.create_ desc";
		List<Map<String, Object>> result = query(sql, YW);
		// 调整数据格式
		int i = 0;
		for (Map<String, Object> map : result) {
			if(map.get("dwmc")==null){
				map.put("DSR", map.get("grxm"));
			}else {
				map.put("DSR", map.get("dwmc"));
			}
			map.put("INDEX", i++);
		}
		return result;
	}
	
	public List<Map<String, Object>> getWCAllList(){
		
		return null;
	}
}
