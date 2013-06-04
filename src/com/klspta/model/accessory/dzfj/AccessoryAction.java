package com.klspta.model.accessory.dzfj;

import java.util.List;
import java.util.Map;
import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.util.bean.ftputil.AccessoryBean;

public class AccessoryAction extends AbstractBaseBean{
    /**
     * 
     * <br>Description:创建文件夹
     * <br>Author:朱波海
     * <br>Date:2012-8-7
     */
    public void createFolder() {
        String file_name =UtilFactory.getStrUtil().unescape( request.getParameter("file_name"));
        file_name = file_name.trim();
        String file_type = request.getParameter("file_type");
        String parent_file_id = request.getParameter("parent_file_id");
        String yw_guid = request.getParameter("yw_guid");
        String user_id = request.getParameter("user_id");
        String file_id = request.getParameter("file_id ");
        AccessoryBean accessoryBean = new AccessoryBean();
        accessoryBean.setFile_id(file_id);
        accessoryBean.setFile_name(file_name);
        accessoryBean.setFile_type(file_type);
        accessoryBean.setParent_file_id(parent_file_id);
        accessoryBean.setYw_guid(yw_guid);
        accessoryBean.setUser_id(user_id);
       AccessoryOperation.getInstance().createFolder(accessoryBean);
    }

    /**
     * 
     * <br>Description:删除操作:先删除accessory表的记录，再删除FTP服务器
     * <br>Author:朱波海
     * <br>Date:2012-8-7
     */
    
    public void deleteFile(){
        String file_id = request.getParameter("file_id");
        AccessoryBean accessoryBean = AccessoryOperation.getInstance().getAccessoryById(file_id);
        AccessoryOperation.getInstance().deleteAccessory(accessoryBean);
        if (accessoryBean.getFile_type().equals("file")) {
            AccessoryOperation.getInstance().deleteFTPFile(accessoryBean.getFile_path());
        }
    }

    /**
     * 
     * <br>Description:树形节点重命名
     * <br>Author:朱波海
     * <br>Date:2012-8-7
     */
    public void nodeRename(){

        String file_id = request.getParameter("file_id");
        String newName = UtilFactory.getStrUtil().unescape(request.getParameter("newName"));
        String sql = "update atta_accessory set file_name = ? where FILE_ID = ?";
        Object[] args = { newName, file_id };
        update(sql,CORE, args);
    }

    /**
     * 
     * <br>Description:树形节点重命名，根据树形的file_id取得对应的FILE_NAME
     * <br>Author:朱波海
     * <br>Date:2012-8-7
     */

   
    public void getNodeName() {
        String file_id = request.getParameter("file_id");
        String sql = "select t.file_name from atta_accessory t where t.file_id = ?";
        Object args[]={file_id};
        List <Map<String ,Object>> list=query(sql,CORE ,args);
        String oldName=null;
             Map<String ,Object>map=list.get(0);
             oldName=  ((String)map.get("file_name"));
        response(oldName);
    }
    /**
     电子附件全部下载
     */
   // public void downloadAll()  {
      //  String realPath=request.getRealPath("/")+"common//pages//accessory//download//";
      //  String yw_guid = request.getParameter("yw_guid");
       
   // }
}
