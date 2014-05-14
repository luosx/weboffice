package com.klspta.web.cbd.dtjc.kfgl;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

public class XmgljgManager extends AbstractBaseBean{
    public static XmgljgManager XmgljgMangaer;
    
    public static XmgljgManager getInstcne(){
        if(XmgljgMangaer == null){
            XmgljgMangaer = new XmgljgManager();
        }
        return XmgljgMangaer;
    }

	public List<Map<String,Object>> getXmgljg(){
		List<Map<String,Object>> result = null;
		String sql = "select rownum as xh ,to_char(t.sj,'yyyy-MM-dd') as sj,t.event,t.department,t.remark from xmbljg t";
		result = query(sql, YW);
		return result;
	}
	
	public void insert(){
	    String xmmc = UtilFactory.getStrUtil().unescape(request.getParameter("xmmc"));
	    String kfzt = UtilFactory.getStrUtil().unescape(request.getParameter("kfzt"));
	    String dz = UtilFactory.getStrUtil().unescape(request.getParameter("dz"));
	    String nz = UtilFactory.getStrUtil().unescape(request.getParameter("nz"));
	    String xz = UtilFactory.getStrUtil().unescape(request.getParameter("xz"));
	    String bz = UtilFactory.getStrUtil().unescape(request.getParameter("bz"));
	    String zdmj = request.getParameter("zdmj");
	    String jsyd = request.getParameter("jsyd");
	    String jzgm = request.getParameter("jzgm");
	    String rjl = request.getParameter("rjl");
	    String zzcq = request.getParameter("zzcq");
	    String cqmj = request.getParameter("cqmj");
	    String fzzcq = request.getParameter("fzzcq");
	    String fcqmj = request.getParameter("fcqmj");
	    String yw_guid = request.getParameter("yw_guid");
	    String xgjz = UtilFactory.getStrUtil().unescape(request.getParameter("xgjz"));
	    //String sql = "update XMGL_YLB set xmmc=?,kfzt=?,dz=?,nz=?,xz=?,bz=?,zdmj=?,jsyd=?,jzgm=?,rjl=?,zzcq=?,cqmj=?,fzzcq=?,fcqmj=?,xgjz=?";
	    String sql = "merge into XMGL_YLB x1 using(select '"+yw_guid+"' as yw_guid from dual) x2 on (x1.yw_guid=x2.yw_guid) "+
	    "when matched then update set xmmc=?,kfzt=?,dz=?,nz=?,xz=?,bz=?,zdmj=?,jsyd=?,jzgm=?,rjl=?,zzcq=?,cqmj=?,fzzcq=?,fcqmj=?,xgjz=? where yw_guid=?" +
	    " when not matched then insert (xmmc,kfzt,dz,nz,xz,bz,zdmj,jsyd,jzgm,rjl,zzcq,cqmj,fzzcq,fcqmj,xgjz,yw_guid) values (?,?,?,?,?,?,?" +
	    ",?,?,?,?,?,?,?,?,?)";
	    this.update(sql, YW, new Object[]{xmmc,kfzt,dz,nz,xz,bz,zdmj,jsyd,jzgm,rjl,zzcq,cqmj,fzzcq,fcqmj,xgjz,yw_guid,xmmc,kfzt,dz,nz,xz,bz,zdmj,jsyd,jzgm,rjl,zzcq,cqmj,fzzcq,fcqmj,xgjz,yw_guid});
	    response("success");
	}
	
	public List<Map<String,Object>> getList(String yw_guid){
	    List<Map<String,Object>> result = null;
        String sql = "select * from xmgl_ylb where yw_guid=?";
        result = query(sql, YW,new Object[]{yw_guid});
        return result;
	}
}
