package com.klspta.model.analysis.overlayanalysis;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class OverlayAnalysis extends AbstractBaseBean{
	
	public void getOverlayAnalysis(){
		String yw_guid = request.getParameter("yw_guid");
		String layername = request.getParameter("layername");
		String yw_flag = "1";
		List<Map<String, Object>> responseList = new GisOAnalysis().overLayA(yw_guid, layername, yw_flag);
		response(responseList);
	}
}
