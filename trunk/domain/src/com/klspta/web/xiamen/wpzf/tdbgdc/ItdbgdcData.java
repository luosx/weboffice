package com.klspta.web.xiamen.wpzf.tdbgdc;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 
 * <br>Title:土地变更调查数据管理类
 * <br>Description:实现对土地变更调查数据的删、改、查
 * <br>Author:黎春行
 * <br>Date:2013-11-18
 */
public interface ItdbgdcData {
	/**
	 * 
	 * <br>Description:获取待核查-疑似违法数据
	 * <br>Author:黎春行
	 * <br>Date:2013-11-18
	 * @param userId
	 * @return
	 */
	public List<Map<String, Object>> getDhcWF(String userId, String keyword);
	
	/**
	 * 
	 * <br>Description:获取待核查-合法数据
	 * <br>Author:黎春行
	 * <br>Date:2013-11-18
	 * @param userId
	 * @return
	 */
	public List<Map<String, Object>> getDhcHF(String userId, String keyword);
	/**
	 * 
	 * <br>Description:获取已核查-违法数据
	 * <br>Author:黎春行
	 * <br>Date:2013-11-18
	 * @param userId
	 * @return
	 */
	public List<Map<String, Object>> getYhcWF(String userId);
	
	/**
	 * 
	 * <br>Description:获取已核查-合法数据
	 * <br>Author:黎春行
	 * <br>Date:2013-11-18
	 * @param userId
	 * @return
	 */
	public List<Map<String, Object>> getYhcHf(String userId);
	
	/**
	 * 
	 * <br>Description:修改下发状态
	 * <br>Author:黎春行
	 * <br>Date:2013-11-18
	 * @param yw_guid
	 * @return
	 */
	public String changeXF(String yw_guid, String type);
	
	/**
	 * 
	 * <br>Description:批量处理下发状态
	 * <br>Author:黎春行
	 * <br>Date:2013-11-18
	 * @param guids
	 * @return
	 */
	public String changeXF(Set guids);
	
	/**
	 * 
	 * <br>Description:添加现场核查情况
	 * <br>Author:黎春行
	 * <br>Date:2013-11-18
	 * @param yw_guid
	 * @param value
	 * @return
	 */
	public String setxchcqk(String yw_guid, String value);
	
	/**
	 * 
	 * <br>Description:添加处理情况
	 * <br>Author:黎春行
	 * <br>Date:2013-11-18
	 * @param yw_guid
	 * @param value
	 * @return
	 */
	public String setClqk(String yw_guid, String value);
	
	/**
	 * 
	 * <br>Description:修改压盖分析情况
	 * <br>Author:黎春行
	 * <br>Date:2013-11-19
	 * @param yw_guid
	 * @param value
	 * @return
	 */
	public String changeFxqk(String yw_guid, String value);

}
