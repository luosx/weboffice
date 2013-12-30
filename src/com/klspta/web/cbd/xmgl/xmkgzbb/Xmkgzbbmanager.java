package com.klspta.web.cbd.xmgl.xmkgzbb;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.model.CBDReport.CBDReportManager;
import com.klspta.web.cbd.yzt.zrb.ZrbData;

public class Xmkgzbbmanager extends AbstractBaseBean { 
	public static final String[][] showList = new String[][]{{"READFLAG", "0.1","hiddlen"},{"ROWNUM", "0.03","序号"},{"DKBH", "0.1","地块编号"},{"YDXZDH", "0.11","用地性质代号"},{"YDXZ", "0.11","用地性质"},{"YDMJ", "0.09","用地面积"},{"RJL","0.08","容积率"},{"JZMJ","0.08","建筑面积"},{"KZGD","0.08","控制高度"},{"BZ","0.1","备注"}};
	
	
	
	public void getReport(){
		String keyword = request.getParameter("keyword");
		String yw_guid = request.getParameter("yw_guid");
		StringBuffer query = new StringBuffer();
		if(keyword != null){
			keyword = UtilFactory.getStrUtil().unescape(keyword);
			StringBuffer querybuffer = new StringBuffer();
			querybuffer.append("upper(DKBH)||upper(YDXZDH)||upper(YDXZ)||upper(YDMJ)||upper(RJL)||upper(JZMJ)||upper(KZGD)||upper(BZ) like '%").append(keyword).append("%') ");
			query.append("(");
			query.append(querybuffer);
		}
		if(yw_guid != null){
			query.append(" and yw_guid = '").append(yw_guid).append("'");
		}
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("query", query.toString());
		response(String.valueOf(new CBDReportManager().getReport("XMKGZBBCX", new Object[]{conditionMap})));
	}
	 public void getQuery() {
	        HttpServletRequest request = this.request;
	        response(new XmkgzbbData().getQuery(request));
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
