package com.klspta.base.util.api;

/*******************************************************************************
 * 
 * <br>
 * Title:异常编码库处理接口<br>
 * Description:对异常配置文件处理 <br>
 * Author:朱波海 <br>
 * Date:2013-7-15
 */

public interface IExceptionCodeUtil {
	/**
	 * 
	 * <br>
	 * Description:根据key获取value值 <br>
	 * Author:朱波海 <br>
	 * Date:2013-7-15
	 * 
	 * @param key
	 * @return
	 */
	public String getCode(String key);

	/**
	 * 
	 * <br>
	 * Description:获取所有配置文件的key <br>
	 * Author:朱波海 <br>
	 * Date:2013-7-15
	 * 
	 * @return
	 */
	public Object[] getAllKey();

}
