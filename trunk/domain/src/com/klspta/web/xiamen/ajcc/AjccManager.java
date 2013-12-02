package com.klspta.web.xiamen.ajcc;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.model.CBDReport.CBDReportManager;

public class AjccManager extends AbstractBaseBean {
	public static final String[][] showList = new String[][]{{"READFLAG", "0.1","hiddlen"},{"XH", "0.15","序号"},{"YDXMMC", "0.1","用地项目名称"},{"YDZT", "0.11","用地主体"},{"ZDMJ", "0.09","占地面积"},{"JZMJ","0.08","建筑面积"},{"JZXZ","0.08","建筑现状"},{"YT","0.08","用途"},{"SFFHTDLYZTGH","0.1","是否符合土地利用总体规划"},{"FXSJ","0.1","发现时间"},{"WFLX","0.1","违法类型"},{"ZZQK","0.05","制止情况"},{"ZZTZSBH","0.05","制止通知书编号"},{"WJZZHJXZZ","0.05","违建制止后继续制止"},{"YYDSPQCZ","0.05","有用地审批且超占"}};
	
	
	public void getDclList(){
		String userId = request.getParameter("userid");
		String keyword = request.getParameter("keyword");
		IajccData ajcc = new AjccData();
		List<Map<String, Object>> queryList = ajcc.getDclList(userId, keyword);
		response(queryList);
	}
	
	public void getReport(){
		String userid = request.getParameter("userid");
		String keyword = request.getParameter("keyword");
		StringBuffer query = new StringBuffer();
		if(keyword != null){
			query.append(" where ");
			keyword = UtilFactory.getStrUtil().unescape(keyword);
			StringBuffer querybuffer = new StringBuffer();
			String[][] nameStrings = Ajccreport.showList;
			for(int i = 0; i < nameStrings.length - 1; i++){
				querybuffer.append("upper(").append(nameStrings[i][0]).append(")||");
				
			}
			querybuffer.append("upper(").append(nameStrings[nameStrings.length - 1][0]).append(") like '%").append(keyword).append("%')");
			query.append("(");
			query.append(querybuffer);
		}
		Map<String, Object> conditionMap = new HashMap<String, Object>();
		conditionMap.put("query", query.toString());
		response(String.valueOf(new CBDReportManager().getReport("AJCCCX", new Object[]{conditionMap})));
	}
	
}
