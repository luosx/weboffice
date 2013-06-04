package com.klspta.model.giscomponents.pda;

import com.klspta.base.AbstractBaseBean;


/**
 * 
 * <br>
 * Title:PDA设备管理 <br>
 * Description: <br>
 * Author:王峰 <br>
 * Date:2011-4-14
 */
public class PDAManageAC extends AbstractBaseBean{
	/**
	 * 
	 * <br>
	 * Description:根据前台传入的PDA编号，进行删除操作 <br>
	 * Author:王峰 <br>
	 * Date:2011-4-14
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public void delPDA()throws Exception {
		 String pdaId = request.getParameter("pdaId");
		 try{
		     PDAUtil.getInstance().deleteByPdaId(pdaId);
		     response.getWriter().write("true");
		  }catch(Exception ex){
			  response.getWriter().write("false"); 
		  }
	}
	
}