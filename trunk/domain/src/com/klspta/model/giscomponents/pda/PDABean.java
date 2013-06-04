package com.klspta.model.giscomponents.pda;

import javax.servlet.http.HttpServletRequest;

/**
 * 
 * <br>Title:PDABean
 * <br>Description:PDABean
 * <br>Author:王雷
 * <br>Date:2012-2-7
 */
public class PDABean {
	 
	/**
	 * PDA编号
	 */
	private String PDAId;	
	/**
	 * PDA名称
	 */
	private String PDAName;
	
	/**
	 * PDA型号
	 */
	private String PDAType;
	
	/**
	 * PDA所属单位
	 */
	private String PDAUnit;
	
	/**
	 * PDA保管人
	 */
	private String PDAPerson;
	
	/**
	 * O否1是
	 */
	private String flag;
	
	/**
	 * PDA保管人联系电话
	 */
	private String PDAPersonPhone;
	
	/**
	 * PDA内置号码
	 */
	private String PDAPhone;
	
	/**
	 * PDA所在政区代码
	 */
	private String PDACantonCode;

	/**
	 * 
	 * <br>Description:获取PDA编号
	 * <br>Author:王雷
	 * <br>Date:2012-2-7
	 * @return
	 */
	public String getPDAId() {
		return PDAId;
	}
    /**
     * 
     * <br>Description:设置PDA编号
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @param id
     */
	public void setPDAId(String id) {
		PDAId = id;
	}
    /**
     * 
     * <br>Description:获取PDA名字
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @return
     */
	public String getPDAName() {
		return PDAName;
	}
    /**
     * 
     * <br>Description:设置PDA名字
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @param name
     */
	public void setPDAName(String name) {
		PDAName = name;
	}
    /**
     * 
     * <br>Description:获取PDA类型
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @return
     */
	public String getPDAType() {
		return PDAType;
	}
    /**
     * 
     * <br>Description:设置PDA类型
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @param type
     */
	public void setPDAType(String type) {
		PDAType = type;
	}
    /**
     * 
     * <br>Description:获取PDA所属单位
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @return
     */
	public String getPDAUnit() {
		return PDAUnit;
	}
    /**
     * 
     * <br>Description:设置PDA所属单位
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @param unit
     */
	public void setPDAUnit(String unit) {
		PDAUnit = unit;
	}
    /**
     * 
     * <br>Description:获取PDA持有者
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @return
     */
	public String getPDAPerson() {
		return PDAPerson;
	}
    /**
     * 
     * <br>Description:设置PDA持有者
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @param person
     */
	public void setPDAPerson(String person) {
		PDAPerson = person;
	}
    /**
     * 
     * <br>Description:获取是否启用
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @return
     */
	public String getFlag() {
		return flag;
	}
    /**
     * 
     * <br>Description:设置是否启用
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @param flag
     */
	public void setFlag(String flag) {
		this.flag = flag;
	}
    /**
     * 
     * <br>Description:获取PDA个人电话
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @return
     */
	public String getPDAPersonPhone() {
		return PDAPersonPhone;
	}
    /**
     * 
     * <br>Description:设置PDA个人电话
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @param personPhone
     */
	public void setPDAPersonPhone(String personPhone) {
		PDAPersonPhone = personPhone;
	}
    /**
     * 
     * <br>Description:获取PDA电话
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @return
     */
	public String getPDAPhone() {
		return PDAPhone;
	}
    /**
     * 
     * <br>Description:设置PDA电话
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @param phone
     */
	public void setPDAPhone(String phone) {
		PDAPhone = phone;
	}
    /**
     * 
     * <br>Description:获取PDA区域编码
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @return
     */
	public String getPDACantonCode() {
		return PDACantonCode;
	}
    /**
     * 
     * <br>Description:设置PDA区域编码
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @param cantonCode
     */
	public void setPDACantonCode(String cantonCode) {
		PDACantonCode = cantonCode;
	}

}
