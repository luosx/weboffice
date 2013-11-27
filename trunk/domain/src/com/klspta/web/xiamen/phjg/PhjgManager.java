package com.klspta.web.xiamen.phjg;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class PhjgManager extends AbstractBaseBean {

	public static final String[][] showList = new String[][]{{"DC_ID","0.1","hiddlen"},{"YW_GUID", "0.1","图斑编号"},{"XMMC", "0.12","项目名称"},{"XMWZ", "0.1","项目位置"},{"XMMJ", "0.1","项目面积"},{"XMLX", "0.1","项目类型"},{"YDQK","0.1","用地情况"},{"YDSJ","0.1","用地时间"},{"PZWH","0.13","批准文号"},{"PZSJ","0.1","批准时间"}};
	
	public void getList(){
		String userId = request.getParameter("userid");
		String keyword = request.getParameter("keyword");
		IphjgData phjgData = new PhjgData();
		List<Map<String, Object>> phjgList = phjgData.getList(null);
		response(phjgList);
	}
	
}
