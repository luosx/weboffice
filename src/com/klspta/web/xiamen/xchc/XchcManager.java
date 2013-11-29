package com.klspta.web.xiamen.xchc;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class XchcManager extends AbstractBaseBean {
	//public static final String[][] showList = new String[][]{{"READFLAG", "0.1","hiddlen"},{"GUID", "0.15","任务编号"},{"XZQMC", "0.1","所在政区"},{"XMMC", "0.1","项目名称"},{"YDDW", "0.1","用地单位"},{"RWLX","0.1","任务类型"},{"SFWF","0.1","是否违法"},{"XCR","0.05","巡查人"},{"XCRQ","0.1","巡查日期"},{"IMGNAME","0.1","hiddlen"},{"XIANGXI","0.1","详细信息"},{"DELETE","0.1","删除"}};
	public static final String[][] showList = new String[][]{{"READFLAG", "0.1","hiddlen"},{"GUID", "0.15","任务编号"},{"XZQMC", "0.1","所在政区"},{"YDDW", "0.11","用地单位"},{"XCSJ", "0.09","用地时间"},{"TDYT","0.08","土地用途"},{"JSQK","0.08","建设情况"},{"YDQK","0.08","用地情况"},{"DFCCQK","0.1","地方查处情况"},{"WFWGLX","0.1","违法违规类型"},{"IMGNAME","0.1","hiddlen"},{"XIANGXI","0.05","详细信息"},{"DELETE","0.05","删除"}};
	public void getDclList(){
		String userId = request.getParameter("userid");
		String keyword = request.getParameter("keyword");
		IxchcData xchc = new XchcData();
		List<Map<String, Object>> queryList = xchc.getDclList(userId, keyword);
		response(queryList);
	}
	
}
