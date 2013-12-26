package com.klspta.web.cbd.xmgl.xmkgzbb;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.model.CBDReport.CBDReportManager;
import com.klspta.web.xiamen.ajcc.AjccData;
import com.klspta.web.xiamen.ajcc.IajccData;

public class Xmkgzbbmanager extends AbstractBaseBean { 
	public static final String[][] showList = new String[][]{{"READFLAG", "0.1","hiddlen"},{"ROWNUM", "0.03","序号"},{"DKBH", "0.1","地块编号"},{"YDXZDH", "0.11","用地性质代号"},{"YDXZ", "0.11","用地性质"},{"YDMJ", "0.09","用地面积"},{"RJL","0.08","容积率"},{"JZMJ","0.08","建筑面积"},{"KZGD","0.08","控制高度"},{"BZ","0.1","备注"}};
	
	
	public void getDclList(){
		String userId = request.getParameter("userid");
		String keyword = request.getParameter("keyword");
		IajccData ajcc = new AjccData();
		List<Map<String, Object>> queryList = ajcc.getDclList(userId, keyword);
		response(queryList);
	}
	
	public void getReport(){
		String keyword = request.getParameter("keyword");
		StringBuffer query = new StringBuffer();
		if(keyword != null){
			query.append(" where ");
			keyword = UtilFactory.getStrUtil().unescape(keyword);
			StringBuffer querybuffer = new StringBuffer();
			querybuffer.append("upper(YDDW)||upper(MJ)||upper(JSQK)||upper(YDSJ) like '%").append(keyword).append("%') order by ROWNUM");
			query.append("(");
			query.append(querybuffer);
		}
		Map<String, Object> conditionMap = new HashMap<String, Object>();
		conditionMap.put("query", query.toString());
		response(String.valueOf(new CBDReportManager().getReport("AJCCCX", new Object[]{conditionMap})));
	}
  
    /*******
     * 
     * <br>Description:项目管理——保存办理过程
     * <br>Author:朱波海
     * <br>Date:2013-12-16
     */
  public void saveDK(){
      String dkbh = request.getParameter("dkbh");
      String ydxz = request.getParameter("ydxz");
      String ydxzdh = request.getParameter("ydxzdh");
      String ydmj = request.getParameter("ydmj");
      String rjl = request.getParameter("rjl");
      String jzmj = request.getParameter("jzmj");
      String kzgd = request.getParameter("kzgd");
      String bz = request.getParameter("bz");
      String ydxzlx = request.getParameter("ydxzlx");
      String yw_guid = request.getParameter("yw_guid");
      String insertString="insert into xmkgzbb (dkbh,ydxz,ydxzdh,ydmj,rjl,jzmj,kzgd,bz,ydxzlx,yw_guid )values(?,?,?,?,?,?,?,?,?,?)";
      int i = update(insertString, YW,new Object[]{dkbh,ydxz,ydxzdh,ydmj,rjl,jzmj,kzgd,bz,ydxzlx,yw_guid});
      if(i>0){
         response("success");
      }else{
          response("failure");
      }
  }
  
  
    
    
}
