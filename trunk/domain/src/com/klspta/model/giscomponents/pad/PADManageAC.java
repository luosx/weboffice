package com.klspta.model.giscomponents.pad;

import com.klspta.base.AbstractBaseBean;


public class PADManageAC extends AbstractBaseBean {

	/**
	 * 
	 * <br>Description: 删除指定的外业设备回传信息
	 * <br>Author:李如意
	 * <br>Date:2012-8-11
	 * @return
	 */
    public String delPAD(){
           String guid=request.getParameter("guid"); 
           Object[] mes = {guid}; 
            if(guid != null){
                String sql="delete from WY_DEVICE_DATA where guid=?";
                int flag = update(sql,AbstractBaseBean.YW,mes);
            }
        return null;
    }

}
