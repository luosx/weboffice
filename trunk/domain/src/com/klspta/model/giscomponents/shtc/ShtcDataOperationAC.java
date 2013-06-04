package com.klspta.model.giscomponents.shtc;

import com.klspta.base.AbstractBaseBean;

/**
 * 
 * <br>
 * Title:手绘图层管理 <br>
 * Description: <br>
 * Author:王峰 <br>
 * Date:2011-4-14
 */
public class ShtcDataOperationAC extends AbstractBaseBean {
	/**
	 * 
	 * <br>
	 * Description:保存手绘图层的信息 <br>
	 * Author:王峰 <br>
	 * Date:2011-7-28
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public void saveShtc()throws Exception {
		response.setCharacterEncoding("UTF-8");
		String msg = "";
	    try{
			String id=request.getParameter("id");
			String name=request.getParameter("name");
			String describe=request.getParameter("describe");
			String rings=request.getParameter("rings");
			String type=request.getParameter("type");
			String shareflag=request.getParameter("flag");
			String yw_guid=request.getParameter("yw_guid");
			String zfjctype=request.getParameter("zfjctype");
			String username=request.getParameter("username");
			String ringType="polyline";
			if(type.equals("polygon")||type.equals("区域")){
			  ringType="polygon";
			}
			if(type.equals("point")||type.equals("地点")){
				  ringType="point";
			}
			String[] arrayRings=null;
			if(id==null) arrayRings=rings.split(",");
			ShtcDataOperation.getInstance().save(arrayRings,id,name,describe,ringType,shareflag,username,zfjctype,yw_guid);
			msg = "{success:true}";
		  }catch(Exception ex){
			msg = "{success:false}";
		  }
	  response(msg);
	}
	
	/**
	 * 
	 * <br>
	 * Description:删除手绘图层的信息 <br>
	 * Author:王峰 <br>
	 * Date:2011-7-28
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public void delShtc() throws Exception {
		    response.setCharacterEncoding("UTF-8");
	        String id = request.getParameter("id");
	        String msg = "";
	        try {
	        	ShtcDataOperation.getInstance().delShtcInfo(id);
	            //response.getWriter().write("true");
	        	msg = "true";
	        } catch (Exception ex) {
	            //response.getWriter().write("false");
	        	msg = "false";
	        }
	        response(msg);
	}

	/**
	 * 
	 * <br>
	 * Description:删除手绘图层的信息 <br>
	 * Author:王峰 <br>
	 * Date:2011-7-28
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	/*
	public ActionForward delLocation() throws Exception {
		    response.setCharacterEncoding("UTF-8");
	        String id = request.getParameter("yw_guid");
	        String type = request.getParameter("zfjcType");
	        ShtcDataOperation.getInstance().delShtcLocation(id);
	        String path = "/model/giscomponents/queryLocation/queryLocation.jsp?zfjcType="+type+"&yw_guid"+id;
	        return new ActionForward(path);
    }
	*/
	/**
	 * 
	 * <br>
	 * Description:根据图层名称获取Mapservices URL <br>
	 * Author:王峰 <br>
	 * Date:2011-7-28
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public void getMapservicesByName() throws Exception {
		    response.setCharacterEncoding("UTF-8");
	        String name = request.getParameter("servicesName");
	        String url=ShtcDataOperation.getInstance().getServices(name);
	        response(url);
	}
}
