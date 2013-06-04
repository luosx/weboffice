package com.klspta.model.giscomponents.sdxc;




/**
 * <br>Title:实地巡查图层管理
 * <br>Description:TODO 类功能描述
 * <br>Author:尹宇星
 * <br>Date:2011-8-8
 */
public class SdxcDataOperationAC  {//extends DispatchAction

    /**
     * <br>Description:保存实地巡查信息
     * <br>Author:尹宇星
     * <br>Date:2011-8-5
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
	/*
    public ActionForward saveSdxc(ActionMapping mapping, ActionForm form, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        response.setCharacterEncoding("UTF-8");
        try {
            String yw_guid = request.getParameter("yw_guid");
            String ringType = request.getParameter("shapefileType");
            String zfjcType = request.getParameter("zfjcType");
            String dkid = request.getParameter("dkid");
            String points = request.getParameter("arrays");
            String[] arrays = points.split(",");
            SdxcDataOperation.getInstance().save(arrays, ringType, zfjcType, yw_guid, dkid);
            response.getWriter().write("{success:true}");
        } catch (Exception ex) {
            response.getWriter().write("{success:false}");
        }
        return null;
    }
	*/
    /**
     * <br>Description:删除实地巡查图层
     * <br>Author:尹宇星
     * <br>Date:2011-8-5
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
	/*
    public ActionForward delLocation(ActionMapping mapping, ActionForm form, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        response.setCharacterEncoding("UTF-8");
        String plotid = request.getParameter("dkid");
        String id = request.getParameter("yw_guid");
        String type = request.getParameter("zfjcType");
        SdxcDataOperation.getInstance().delSdxcLocation(plotid);
        String path = "/gisapp/pages/components/queryLocation/queryLocation.jsp?zfjcType=" + type
                + "&yw_guid=" + id +"&dkId=" + plotid;
        return new ActionForward(path);
    }
    */
}
