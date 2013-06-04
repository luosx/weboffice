package com.klspta.model.giscomponents.util;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import com.klspta.base.AbstractBaseBean;


/**
 * 
 * <br>Title:地图功能操作类
 * <br>Description:TODO 类功能描述
 * <br>Author:陈强峰
 * <br>Date:2011-9-15
 */
public class MapFucntionUtil extends AbstractBaseBean{
    
     //属性对象
     public static Vector<Object> sx;
     //项目对象
     public static Vector<Object> xm;
     //框选
     public static Vector<Object> kx;
     //图斑对象
     public static List<Map<String, Object>> tb;
     
     public static MapFucntionUtil instance;
     
     public static MapFucntionUtil getInstance(){
    	 if(instance == null){
    		 instance = new MapFucntionUtil();
    	 }
    	 return instance;
     }
     
     /**
      * 
      * <br>Description:获取图斑查询信息
      * <br>Author:陈强峰
      * <br>Date:2011-9-16
      * @return
      */
     public static List<Map<String, Object>>  getTb(String fun){
         if(tb==null){
        	 tb = getInstance().tbSearch(fun);
         }
         return tb;
     }
     /**
      * 
      * <br>Description:获取框选查询信息
      * <br>Author:陈强峰
      * <br>Date:2011-9-16
      * @return
      */
     public static Vector<Object>  getKx(String fun){
         if(kx==null){
        	 kx = getInstance().kxSearch(fun);
         }
         return kx;
     }
     /**
      * 
      * <br>Description:获取属性查询信息
      * <br>Author:陈强峰
      * <br>Date:2011-9-16
      * @return
      */
     public static Vector<Object>  getSx(){
         if(sx==null){
        	 sx = getInstance().sxSearch();
         }
         return sx;
     }
     /**
      * 
      * <br>Description:获取项目信息
      * <br>Author:陈强峰
      * <br>Date:2011-9-16
      * @return
      */
     public static  Vector<Object>  getXm(String fun){
         if(xm==null){
        	 xm = getInstance().xmSearch(fun);
         }
         return xm;
     }
    /**
     * 
     * <br>Description:属性查询方法
     * <br>Author:陈强峰
     * <br>Date:2011-9-16
     * @see com.klspta.gisapp.utils.IMapFunctionOperation#sxSearch(java.lang.String)
     */
     public  Vector<Object> sxSearch() {
        Vector<Object> ve = new Vector<Object>();
        String sql = "select * from v_sxcx t where t.format <> 'raster'  and t.queryFields <>' ' order by t.rankIndex,t.LAYERID";
        List<Map<String, Object>> list = query(sql, AbstractBaseBean.CORE);
        if (list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                Map<String, Object> map = list.get(i);
                ve.add(map);
            }
        }
        return ve;
    }

    /**
     * <br>Description:根据项目编号查询项目信息
     * <br>Author:陈强峰
     * <br>Date:2011-9-15
     * @see com.klspta.gisapp.utils.IMapFunctionOperation#xmSearch(java.lang.String)
     */
      public Vector<Object> xmSearch(String function) {
        Vector<Object> ve = new Vector<Object>();
        String sql = "";
        List<Map<String, Object>> list = query(sql, CORE, new Object[] { function });
        if (list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                Map<String, Object> map = list.get(i);
                ve.add(map);
            }
        }
        return ve;
    }
     /**
      * 
      * <br>Description:图斑查询方法
      * <br>Author:陈强峰
      * <br>Date:2011-9-21
      * @param function
      * @return
      */
     public  List<Map<String, Object>> tbSearch(String function) {
         String sql="select * from gis_maptree where MAPFUNCTION like '%"+function+"%'";
         List<Map<String, Object>> list =  query(sql, CORE);
         return list; 
     }
     /**'
      * 
      * <br>Description:框选查询
      * <br>Author:陈强峰
      * <br>Date:2011-9-21
      * @param function
      * @return
      */
     public  Vector<Object> kxSearch(String function) {
         Vector<Object> ve = new Vector<Object>();
         String sql = "select * from v_kxcx t where t.fields<>' 'and  mapfunction like '%"+function+"%' order by t.rankIndex,t.LAYERID";
         List<Map<String, Object>> list = query(sql, CORE);
         if (list.size() > 0) {
             for (int i = 0; i < list.size(); i++) {
                 Map<String, Object> map = list.get(i);
                 ve.add(map);
             }
         }
         return ve;
     }
}
