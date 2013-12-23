package com.klspta.web.xiamen.phjg;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.wkt.Polygon;

public class PhjgManager extends AbstractBaseBean {

	public static final String[][] showList = new String[][]{{"OBJECTID","0.1","hiddlen"},{"XMBH", "0.1","项目编号"},{"XMMC", "0.12","项目名称"},{"YDDWMC", "0.12","用地单位名称"},{"AREA", "0.1","项目面积"},{"YWLX", "0.1","项目类型"},{"YDQK","0.1","用地情况"},{"YDSJ","0.1","用地时间"},{"SZFPW","0.13","批准文号"},{"PZRQ","0.1","批准时间"}};
	
	public void getList(){
		String userId = request.getParameter("userid");
		String keyword = request.getParameter("keyword");
		IphjgData phjgData = new PhjgData();
		List<Map<String, Object>> phjgList = phjgData.getList(keyword);
		response(phjgList);
	}
	
	
    public void getWkt(){
        String objectId = request.getParameter("objectId"); 
        String sql = "select sde.st_astext(t.shape) wkt from dlgzgdr t where t.objectid = ?";
        List<Map<String,Object>> list = query(sql,GIS,new Object[]{objectId});
        String wkt = (String)(list.get(0)).get("wkt");
        Polygon polygon = new Polygon(wkt);
        response(polygon.toJson());
    }
}
