package com.klspta.web.cbd.swkgl;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

public class Fyzcmanager extends AbstractBaseBean {
    public void saveFyzc() {
        String mc = request.getParameter("mc");
        String gzfy = request.getParameter("gzfy");
        String gzgm = request.getParameter("gzgm");
        String cbzj = request.getParameter("cbzj");
        String gzdj = request.getParameter("gzdj");
        String lyfy = request.getParameter("lyfy");
        String lygm = request.getParameter("lygm");
        String qmfy = request.getParameter("qmfy");
        String jzmj = request.getParameter("jzmj");
        String zyzj = request.getParameter("zyzj");
        String pmft = request.getParameter("pmft");
        String lyft = request.getParameter("lyft");
        String clft = request.getParameter("clft");
        String ze = request.getParameter("ze");
        String jhcb = request.getParameter("jhcb");
        String xj = request.getParameter("xj");
        String dj = request.getParameter("dj");
        String yw_guid = request.getParameter("yw_guid");
        mc = UtilFactory.getStrUtil().unescape(mc);
        String insertString = "insert into fyzc (mc,gzfy,gzgm,cbzj,gzdj,lyfy,lygm,qmfy,jzmj,zyzj,pmft,lyft,clft,ze,jhcb,xj,dj,yw_guid)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        int i = update(insertString, YW,new Object[]{mc,gzfy,gzgm,cbzj,gzdj,lyfy,lygm,qmfy,jzmj,zyzj,pmft,lyft,clft,ze,jhcb,xj,dj,yw_guid});
        if(i>0){
            response("success");
         }else{
             response("failure");
         }
    }

}
