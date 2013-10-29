package com.klspta.model.mapconfig;

import java.util.Map;
import java.util.Vector;

import com.klspta.base.AbstractBaseBean;
import com.klspta.console.map.MapManager;

/**
 * 
 * <br>Title:TODO 类标题
 * <br>Description:地图授权和图层管理
 * <br>Author:黎春行
 * <br>Date:2012-7-10
 */
public class MapAuthorOperation extends AbstractBaseBean {

    public void getExtTreeByUserid(){
		String userid = request.getParameter("userid");
		Vector<Map<String, Object>> tree = null;
		tree = MapManager.getInstance().getExtTree(userid);
		if(tree != null){
		    response(tree);
		}
	}
}
