package com.klspta.model.signlog;

import java.sql.Date;

public class WfxsdjbllogBean {
	 /**
	  * 业务编号
	  */
	private String yw_guid;
	/**
	 * 办理时间
	 */
	private Date blsj;
	/**
	 * 办理人
	 */
	private String  blr;
	/**
	 * 办理描述信息
	 */
	private String blms;
	/**
	 * 办理人员级别
	 */
	private String bljb;
	
	public String getYw_guid() {
		return yw_guid;
	}
	public void setYw_guid(String yw_guid) {
		this.yw_guid = yw_guid;
	}
	public Date getBlsj() {
		return blsj;
	}
	public void setBlsj(Date blsj) {
		this.blsj = blsj;
	}
	public String getBlr() {
		return blr;
	}
	public void setBlr(String blr) {
		this.blr = blr;
	}
	public String getBlms() {
		return blms;
	}
	public void setBlms(String blms) {
		this.blms = blms;
	}
	public String getBljb() {
		return bljb;
	}
	public void setBljb(String bljb) {
		this.bljb = bljb;
	}

}
