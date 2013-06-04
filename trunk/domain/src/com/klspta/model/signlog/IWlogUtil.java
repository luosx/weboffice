package com.klspta.model.signlog;

import java.util.List;

public interface IWlogUtil {
	/**
	 * 
	 * <br>Description:增加一笔签核记录
	 * <br>Author:黎春行
	 * <br>Date:2012-6-19
	 * @param signBean
	 * @return
	 */
	public int addLog(WfxsdjbllogBean signBean);

	/**
	 * 
	 * <br>Description:删除一笔签核记录
	 * <br>Author:黎春行
	 * <br>Date:2012-6-19
	 * @param signBean
	 * @return
	 */
	public int deleteLog(WfxsdjbllogBean signBean);
	
	/**
	 * 
	 * <br>Description:根据yw_guid获取记录
	 * <br>Author:黎春行
	 * <br>Date:2012-6-19
	 * @param yw_guid
	 * @return
	 */
	public List<WfxsdjbllogBean> getWfxsdjbllogBean(String yw_guid);
}
