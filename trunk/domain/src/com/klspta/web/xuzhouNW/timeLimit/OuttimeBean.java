package com.klspta.web.xuzhouNW.timeLimit;

import java.sql.Date;
import java.util.List;
import java.util.Map;



import com.klspta.base.AbstractBaseBean;
import com.klspta.console.ManagerFactory;

public class OuttimeBean extends AbstractBaseBean {
	private long dbid;
	private String execution = "";
	private String assignee = "";
	private String outcome = "";
	private String isdone;
	private String outdate;
	private Date refreshDate;
	public long getDbid() {
		return dbid;
	}
	public void setDbid(long dbid) {
		this.dbid = dbid;
	}
	public String getExecution() {
		return execution;
	}
	public void setExecution(String execution) {
		this.execution = execution;
	}
	public String getAssignee() {
		return assignee;
	}
	public void setAssignee(String assignee) {
		this.assignee = assignee;
	}
	public String getOutcome() {
		return outcome;
	}
	public void setOutcome(String outcome) {
		this.outcome = outcome;
	}
	public String getIsdone() {
		return isdone;
	}
	public void setIsdone(String isdone) {
		this.isdone = isdone;
	}
	public String getOutdate() {
		return outdate;
	}
	public void setOutdate(String outdate) {
		this.outdate = outdate;
	}
	public Date getRefreshDate() {
		return refreshDate;
	}
	public void setRefreshDate(Date refreshDate) {
		this.refreshDate = refreshDate;
	}
	
	/**
	 * 
	 * <br>Description:保存
	 * <br>Author:黎春行
	 * <br>Date:2013-3-28
	 */
	public void save(){
		String sql = "select * from outtime where dbid=" + this.dbid;
		List<Map<String, Object>> result = query(sql, WORKFLOW);
		if(result.size() > 0){
			sql = "update outtime set isdone= " + this.isdone + "where dbid=" + this.dbid;
			update(sql, WORKFLOW);
		}else{
			sql = "insert into outtime(dbid, execution, assignee, outcome, isdone, outdate, refreshdate) values(?, ?, ?, ?, ?, ?, ?)";
			Object[] args = new Object[]{this.dbid, this.execution, this.assignee, this.outcome, this.isdone, this.outdate, this.refreshDate};
			update(sql, WORKFLOW, args);
		}
	}

	/**
	 * 
	 * <br>Description:根据Id获取outtimebean
	 * <br>Author:黎春行
	 * <br>Date:2013-3-28
	 * @param dbId
	 * @return
	 */
	public OuttimeBean getByDbid(Long dbId){
		String sql = "select * from outtime where dbid=" + dbId;
		List<Map<String, Object>> result = query(sql, WORKFLOW);
		if(result.size() > 0){
			this.dbid = dbId;
			this.assignee = (String)result.get(0).get("assignee");
			this.execution = (String)result.get(0).get("execution");
			this.outcome = (String)result.get(0).get("outcome");
			this.isdone = (String)result.get(0).get("isdone");
			this.outdate = (String)result.get(0).get("outdate");
			this.refreshDate = (Date)result.get(0).get("refreshDate");
		}
		return this;
	}
	
	/**
	 * 
	 * <br>Description:根据用户名获取获取超时案件
	 * <br>Author:黎春行
	 * <br>Date:2013-3-28
	 * @param userId
	 * @return
	 * @throws Exception 
	 */
	public List getByUserId(String userId) throws Exception{
		String userName = ManagerFactory.getUserManager().getUserWithId(userId).getFullName();
		String sql = "select * from jbpm4_outtime where assignee = '" + userName + "'";
		List<Map<String, Object>> result = query(sql, WORKFLOW);
		return result;
	}
	
	/**
	 * 
	 * <br>Description:根据用户名获取获取超时案件
	 * <br>Author:黎春行
	 * <br>Date:2013-3-28
	 * @param userId
	 * @return
	 * @throws Exception 
	 */
	public List getAll() throws Exception{
		String sql = "select * from jbpm4_outtime";
		List<Map<String, Object>> result = query(sql, WORKFLOW);
		return result;
	}
	
	
	public List getQuery(String keyWord, String compare){
		String[] com = compare.split("#");
		StringBuffer sql = new StringBuffer();
		sql.append("select * from jbpm4_outtime ");
		for(int i = 0; i < com.length; i++){
			if(i == 0){
				sql.append(" where ");
				sql.append(com[i]);
				sql.append(" like '%");
				sql.append(keyWord);
				sql.append("%'");
			}else{
				sql.append(" or ");
				sql.append(com[i]);
				sql.append(" like '%");
				sql.append(keyWord);
				sql.append("%'");
			}
		}
		List<Map<String, Object>> result = query(sql.toString(), WORKFLOW);
		return result;
	}
	
	/**
	 * <br>Description:根据用户ID获取超时案件
	 * <br>Author:姚建林
	 * <br>Date:2013-4-3
	 * @param userId
	 * @return
	 * @throws Exception 
	 */
	public List getCaseByUserId(String userId) throws Exception{
		String userName = ManagerFactory.getUserManager().getUserWithId(userId).getFullName();
		String sql = "select l.bh caseid,t.outdate,t.dbid from lacpb l inner join "
			+"(select a.yw_guid,j.outdate,j.dbid from workflow.jbpm4_outtime j inner join workflow.active_task a on a.wfInsId=j.execution and j.assignee='" + userName + "' and j.isdone='否') t "
			+"on l.yw_guid = t.yw_guid";
		List<Map<String, Object>> result = query(sql, YW);
		return result;
	}
}
