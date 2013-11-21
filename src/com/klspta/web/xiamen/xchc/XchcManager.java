package com.klspta.web.xiamen.xchc;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class XchcManager extends AbstractBaseBean {
	public static final String[][] showList = new String[][]{{"READFLAG", "0.1","hiddlen"},{"GUID", "0.1","任务编号"},{"XZQMC", "0.1","所在政区"},{"XMMC", "0.1","项目名称"},{"RWLX","0.1","任务类型"},{"SFWF","0.1","是否违法"},{"XCR","0.05","巡查人"},{"XCRQ","0.1","巡查日期"},{"IMGNAME","0.1","hiddlen"},{"XIANGXI","0.1","详细信息"},{"DELETE","0.1","删除"}};

	public void getDclList(){
		String userId = request.getParameter("userid");
		String keyword = request.getParameter("keyword");
		IxchcData xchc = new XchcData();
		List<Map<String, Object>> queryList = xchc.getDclList(userId, keyword);
		response(queryList);
	}
	
	
}
