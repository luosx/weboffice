package com.klspta.model.download;

import java.util.List;
import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.util.bean.ftputil.AccessoryBean;
import com.klspta.model.accessory.AccessoryOperation;

/**
 * <br>Title:AccessoryAC
 * <br>Description:下载专区附件Action类
 * <br>Author:尹宇星
 * <br>Date:2011-6-20
 */
public class AccessoryAC extends AbstractBaseBean {

    /**
     * <br>Description:附件上传Action
     * <br>Author:尹宇星
     * <br>Date:2011-6-22
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public void uploadFile()throws Exception{
        request.setCharacterEncoding("utf-8");
        String msg = null;
        String yw_guid = request.getParameter("ywid");
        try {
            List<String> list = UtilFactory.getFileUtil().upload(request, 0, 0);
            String filePath = list.get(0);
            filePath = filePath.substring(0, filePath.lastIndexOf("/"));
            AccessoryOperation.getInstance().uploadDirectory(filePath, yw_guid, "0", false);
            response.getWriter().write("{success:true}");
        } catch (Exception e) {
            msg = e.getMessage();

        } finally {
            if (msg != null) {
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{failure:true,msg:'" + msg + "'}");
            }
        }
    }

    /**
     * <br>Description:附件删除Action
     * <br>Author:尹宇星
     * <br>Date:2011-6-22
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public void deleteFile() throws Exception{
        String file_id = request.getParameter("file_id");
        AccessoryBean accessoryBean = AccessoryOperation.getInstance().getAccessoryById(file_id);
        String ywid = accessoryBean.getYw_guid();
        request.setAttribute("ywid", ywid);
        AccessoryOperation.getInstance().deleteAccessory(accessoryBean);
        if (accessoryBean.getFile_type().equals("file")) {
            AccessoryOperation.getInstance().deleteFTPFile(accessoryBean.getFile_path());
        }
        response.getWriter().write("true");
        //return mapping.findForward("del_success");
    }
}
