package com.klspta.model.download;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import com.klspta.base.AbstractBaseBean;


public class SaveFormAC extends AbstractBaseBean {

    /**
    * <br>Description:保存下载新增或维护表单
    * <br>Author:尹宇星
    * <br>Date:2011-6-22
    * @param mapping
    * @param form
    * @param request
    * @param response
    * @return
    * @throws Exception
    */
    public void saveForm() throws Exception {
        String ywid = request.getParameter("ywid");

        String flag = request.getParameter("flag");
        if (flag.equals("1")) {
            StringBuffer sb = new StringBuffer();
            sb.append("insert into CORE_DOWNLOAD_LIST(KC03, KC02, KC08, KC07, KC05, KC06, KC04) values(");
            //String uuid = request.getParameter("uuid");
            //System.out.println(uuid);
            Map map = request.getParameterMap();
            Iterator it = map.entrySet().iterator();
            while (it.hasNext()) {
                Entry entry = (Entry) (it.next());
                String id = entry.getKey().toString().trim();
                String value = request.getParameter(id).trim();
                if (!id.equals("method") && !id.equals("flag") && !id.equals("filePath")) {
                    if (id.equals("KC04")) {
                        sb.append("to_date('" + value + "','yyyy-mm-dd')");
                    } else {
                        sb.append("'" + value + "'");
                    }
                    //System.out.println("id:"+id+" value: "+ value);
                    if (it.hasNext()) {
                        sb.append(",");
                    }
                }
            }
            sb.append(")");
            String sql = sb.toString();
            update(sql,CORE);
            response.getWriter().write("{success:true}");
        } else {
            String sql = "update CORE_DOWNLOAD_LIST set KC03=?, KC02=?, KC07=?, KC05=?, KC06=?, KC04=to_date(?,'yyyy-mm-dd') where KC08=?";
            List<String> args_list = new ArrayList<String>();
            Map map = request.getParameterMap();
            Iterator it = map.entrySet().iterator();
            while (it.hasNext()) {
                Entry entry = (Entry) (it.next());
                String id = entry.getKey().toString().trim();
                String value = request.getParameter(id).trim();
                if (!id.equals("flag") && !id.equals("method") && !id.equals("filePath")
                        && !id.equals("ywid")) {
                    args_list.add(value);
                }
            }
            args_list.add(ywid);
            Object[] args = new Object[args_list.size()];
            for (int i = 0; i < args_list.size(); i++) {
                args[i] = args_list.get(i);
            }
            update(sql,CORE, args);
            response.getWriter().write("{success:true}");
        }
    }
}
