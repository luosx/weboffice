package com.klspta.model.mapconfig;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

@Component
public class MapConfig extends AbstractBaseBean {
    
    public MapConfig(){
    }
    
    public void getMapServices(){
        String sql = "select t.*,w.* from gis_mapservices t, gis_wmts_info w where t.format = w.wmts_id(+) and t.flag=1 order by  t.ranking";
        List<Map<String,Object>> list = query(sql, CORE);
        response(list);
    }
    
    public void getMapProperties(){
    	String sql = "select distinct t.treename as text,t.serverid||'@'||t.layerid||'@'||t.queryfields||'@'||t.queryfieldsinfo as value from GIS_MAPTREE t where t.serverid is not null and t.parenttreeid not like '0'";
        List<Map<String,Object>> list = query(sql, CORE);
        response(list);
    }
    
    public void getMapExtent(){
        String sql = "select t.*, t.rowid from gis_extent t where t.flag = '1'";
        List<Map<String,Object>> list = query(sql, CORE);
        response(list);
    }
    
    public void getGeometryServices(){
        String sql = "select * from gis_geometryservice t where t.flag = '1'";
        List<Map<String,Object>> list = query(sql, CORE);
        response(list);
    }
    
    private static Map<String, String> wmts = new HashMap<String, String>();
    public void getWMTSServer(){
        String name = request.getParameter("name");
        if(wmts.size() == 0){
            try {
                String sql = "select t.* from gis_wmts_info t";
                List<Map<String,Object>> list = query(sql, CORE);
                Iterator<Map<String, Object>> it = list.iterator();
                while(it.hasNext()){
                    Map<String, Object> map = it.next();
                    wmts.put((String)map.get("WMTS_ID"), UtilFactory.getJSONUtil().objectToJSON(wmts.get(name)));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response(wmts.get(name));
    }
    
    private static Map<String, List<Map<String,Object>>> wmtsinfo = new HashMap<String, List<Map<String,Object>>>();
    public void getWMTSInfo(){
        String name = request.getParameter("name");
        if(wmtsinfo.get(name) == null){
            String sql = "select * from gis_wmts_lods_info t where t.wmts_id = ? order by t.wmts_level";
            List<Map<String,Object>> list = query(sql, CORE, new Object[] {name});
            wmtsinfo.put(name, list);
        }
        try {
            response(UtilFactory.getJSONUtil().objectToJSON(wmtsinfo.get(name)));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    /**
     * 模块加载前先修改maptree 的checked值 用于不同模块默认显示不同图层
     * 李国明 2014-3-22
     */
    public void updateMapService(){
    	String serverid = request.getParameter("serverid");
    	String layerid = request.getParameter("layerid");
    	String[] serverids = serverid.split(",");
    	String[] layerids = layerid.split(",");
		String update = "update GIS_MAPTREE t set t.checked=0 where serverid in (";
		for(int j = 0;j<serverids.length ; j++){
			update += "?,";
		}
		update = update.substring(0,update.length()-1)+")";
		update(update, CORE,serverids);
    	
    	for(int i = 0;i<layerids.length;i++){
    		String[] serverid_layerid = layerids[i].split(":");
    		update = "update GIS_MAPTREE t set t.checked=1 where serverid = ? and layerid = ?";
    		update(update, CORE,new Object[]{serverid_layerid[0],serverid_layerid[1]});
    	}
    }

    public void getInitMapService(){
        String sql = "select t.serverid,t.layerid,t.type,checked  flag from GIS_MAPTREE t where t.parenttreeid not like '0' and t.flag = '1' and t.serverid is not null";
        List<Map<String,Object>> list = query(sql,CORE);
        List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
        Map<String ,Object> map = null;
        Map<String,Map<String,Object>> maps = new HashMap<String, Map<String,Object>>();
        for(int i = 0;i < list.size();i++){
        	String serverid = list.get(i).get("serverid").toString();
        	String layerid = list.get(i).get("layerid").toString();
        	String type = list.get(i).get("type").toString();
        	String flag = list.get(i).get("flag").toString();
        	if(maps.get(serverid+flag)==null){
        		map = new HashMap<String, Object>();
        		map.put("SERVERID", serverid);
        		map.put("LAYERID", layerid);
        		map.put("TYPE", type);
        		map.put("FLAG", flag);
        		maps.put(serverid+flag, map);
        	}else{
        		if(flag.equals(maps.get(serverid+flag).get("FLAG"))){
        			String layerids = maps.get(serverid+flag).get("LAYERID").toString();
        			layerids += ","+layerid;
        			maps.get(serverid+flag).put("LAYERID", layerids);
        		}else{
        			map = new HashMap<String, Object>();
            		map.put("SERVERID", serverid);
            		map.put("LAYERID", serverid);
            		map.put("TYPE", type);
            		map.put("FLAG", flag);
            		maps.put(serverid+flag, map);
        		}
        	}
        }
        for(String key : maps.keySet()){
        	result.add(maps.get(key));
        }
        response(result);
    }
}
