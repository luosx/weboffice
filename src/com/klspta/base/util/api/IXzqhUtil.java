package com.klspta.base.util.api;

import java.util.HashSet;
import java.util.List;

import com.klspta.base.util.bean.xzqhutil.XzqhBean;

/**
 * 
 * <br>Title:行政区划工具类
 * <br>Description:
 * <br>Author:黎春行
 * <br>Date:2012-5-23
 */
public interface IXzqhUtil {
	/**
	 * 
	 * <br>Description:获取省级行政区划
	 * <br>Author:黎春行
	 * <br>Date:2012-5-24
	 * @return
	 */
	public List<XzqhBean> getProvinceList();
	/**
	 * 
	 * <br>Description:根据父级Id获取子级行政区划
	 * <br>Author:黎春行
	 * <br>Date:2012-5-24
	 * @param code
	 * @return
	 */
	public List<XzqhBean> getChildListByParentId(String code);
	/**
	 * 
	 * <br>Description:保存/更新行政区划
	 * <br>Author:黎春行
	 * <br>Date:2012-5-24
	 * @param xzqh
	 * @return
	 */
	boolean save(XzqhBean xzqh);
	/**
	 * 
	 * <br>Description:删除行政区域
	 * <br>Author:黎春行
	 * <br>Date:2012-5-24
	 * @param cantonCode
	 * @return
	 */
	boolean deleteByCantonCode(String cantonCode);
	
	/**
	 * 
	 * <br>Description:将含有行政区划的List转化为字符串。
	 * <br>Author:黎春行
	 * <br>Date:2012-5-24
	 * @param list
	 * @return
	 */
	String generateOptionByList(List<XzqhBean> list);
	
	/**
	 * 
	 * <br>Description:将省级行政区划转化为String。
	 * <br>Author:黎春行
	 * <br>Date:2012-5-30
	 * @return
	 */
	String generateOptionByList();

	/**
	 * 
	 * <br>Description:根据行政区划编码获取区划名称。
	 * <br>Author:黎春行
	 * <br>Date:2012-6-6
	 * @return
	 */
	 List<XzqhBean> getNameById(String id);
	 
	 /**
	  * 
	  * <br>Description:根据子政区名称获取上一级政区名称
	  * <br>Author:黎春行
	  * <br>Date:2012-6-19
	  * @param code
	  * @return
	  */
	 List<XzqhBean> getParentByChildId(String code);
	 
	 /**
	  * 
	  * <br>Description:根据行政区划编码获取区划名称。
	  * <br>Author:姚建林
	  * <br>Date:2012-6-19
	  * @return
	  */
	 String getNameByCode(String code);
     /**
      * 
      * <br>Description:根据行政区划编码获取行政区bean
      * <br>Author:陈强峰
      * <br>Date:2012-6-19
      * @param id
      * @return
      */
     public XzqhBean getBeanById(String id);
	  /**
      * 
      * <br>Description:根据行政区划编码获取邮政编码
      * <br>Author:黎春行
      * <br>Date:2012-6-20
      * @param id
      * @return
      */
     public String getPostalCode(String id);
     
     /**
      * 
      * <br>Description:根据地区名称获取行政区划
      * <br>Author:黎春行
      * <br>Date:2012-6-27
      * @param name
      * @return
      */
     public List<XzqhBean> getListByName(String[] name);
     
     /**
 	 * Title: <br>
 	 * Description:根据行政区划代码set集合返回可以在ext的ComboBox中直接展现的数据<br>
 	 * Author:姚建林 <br>
 	 * Date:2012-9-19
 	 */
 	 public String getXzqhDataByCodes(HashSet<String> hs);
 	 
 	/**
      * <br>Description:根据行政区划代码set集合返回相应的名字
      * <br>Author:姚建林
      * <br>Date:2012-9-19
      * @param name
      * @return
      */
 	 public String getXzqhNamesByCodes(HashSet<String> hs);
 	 
 	 public String getPublicCode(String id);
}
