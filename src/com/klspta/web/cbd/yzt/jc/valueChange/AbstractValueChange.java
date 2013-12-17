package com.klspta.web.cbd.yzt.jc.valueChange;

import com.klspta.base.AbstractBaseBean;

public abstract class AbstractValueChange extends AbstractBaseBean {
	/**
	 * 
	 * <br>Description:地块（自然斑、基本地块）添加时，修改关联表数据
	 * <br>Author:黎春行
	 * <br>Date:2013-12-13
	 * @param yw_guid
	 * @return
	 */
	public abstract boolean add(String dkmc);
	
	/**
	 * 
	 * <br>Description:删除（自然斑、基本地块）时，修改关联表数据
	 * <br>Author:黎春行
	 * <br>Date:2013-12-13
	 * @param yw_guid
	 * @return
	 */
	public abstract boolean delete(String dkmc);
	
	/**
	 * 
	 * <br>Description:修改（自然斑、基本地块）属性时，修改关联表数据
	 * <br>Author:黎春行
	 * <br>Date:2013-12-13
	 * @param yw_guid
	 * @return
	 */
	public abstract boolean modify(String dkmc);
	
	/**
	 * 
	 * <br>Description:同时删除多个（自然斑、基本地块）时，修改关联数据
	 * <br>Author:黎春行
	 * <br>Date:2013-12-13
	 * @param yw_guids
	 * @return
	 */
	public boolean delete(String[] dkmcs){
		boolean status = false;
		for(int i = 0; i < dkmcs.length; i++){
			status = status && delete(dkmcs[i]);
		}
		return status;
	};
}
