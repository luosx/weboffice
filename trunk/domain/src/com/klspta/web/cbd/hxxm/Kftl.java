package com.klspta.web.cbd.hxxm;

import org.springframework.stereotype.Component;

import com.klspta.base.AbstractBaseBean;
/**
 * 
 * <br>Title:开发体量
 * <br>Description:
 * <br>Author:陈强峰
 * <br>Date:2013-10-10
 */
@Component
public class Kftl extends AbstractBaseBean{
    /**
     * 
     * <br>Description:新增开发体量
     * <br>Author:陈强峰
     * <br>Date:2013-10-10
     */
    public void add(){
         String yw_guid=request.getParameter("yw_guid");
         String xmmc=request.getParameter("xmmc");
         String year=request.getParameter("year");
         String season=request.getParameter("season");
         String hs=request.getParameter("hs");
         String dl=request.getParameter("dl");
         String gm=request.getParameter("gm");
         String tz=request.getParameter("tz");
         String z=request.getParameter("z");
         String q=request.getParameter("q");
         String sql="insert into kftl(xmmc,nd,jd,hs,dl,gm,tz,z,q) values(?,?,?,?,?,?,?,?,?)";
         int flag=update(sql,YW,new Object[]{xmmc,year,season,hs,dl,gm,tz,z,q});
         if(flag==0){
             response("{success:true}");
         }else{
             response("{success:false}");
         }
    }

}
