package com.klspta.model.download;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.klspta.base.AbstractBaseBean;


public class DelRecord extends AbstractBaseBean {
    /**
     * 
     * <br>Description:根据前台传入的业务编号进行删除操作
     * <br>Author:尹
     * <br>Date:2011-06-20
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @return
     * @throws Exception
     */

    public void deleteTask(){
        String yw_guid = request.getParameter("yw_guid");
        List<String> args_list = new ArrayList<String>();
        args_list.add(yw_guid);
        Object[] args = new Object[args_list.size()];
        for (int i = 0; i < args_list.size(); i++) {
            args[i] = args_list.get(i);
        }
        String sql = "delete from CORE_DOWNLOAD_LIST where KC08 = ?";
        update(sql,CORE, new Object[]{yw_guid});
        try {
			response.getWriter().print("true");
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
}
