package com.klspta.web.cbd.qyjc;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.web.cbd.qyjc.common.BuildModel;
import com.klspta.web.cbd.qyjc.common.ModelFactory;

public class QyjcManager extends AbstractBaseBean{
	private static QyjcManager qyjcManager;

    public static QyjcManager getInstcne() {
        if (qyjcManager == null) {
        	qyjcManager = new QyjcManager();
        }
        return qyjcManager;
    }

	public String getList() {
        String sql = "select t.bh,t.xzlmc,t.kfs,t.wygs,t.tzf,t.cpdw,t.cplx,t.cylx,t.rzqy,t.kpsj,t.ysxkz,t.cbcs,t.lc,t.bzcg,t.wq,t.cn,t.gd,t.gs,t.dt,t.gdcw,t.tcwzj,t.syl,t.qt from xzlxx t";
        List<Map<String, Object>> list = query(sql, YW);
        StringBuffer result = new StringBuffer(
                "<table id='XZLZJ' width='3000' border='1' cellpadding='1' cellspacing='0'>" +
                "<tr class='tr01' ><td id='0_0' height='10' width='10' colspan='1' rowspan='2' class='tr01'>编号</td>" +
                "<td id='0_1' height='10' width='10' colspan='1' rowspan='2' class='tr01'>写字楼名称</td>" +
                "<td id='0_2' height='10' width='10' colspan='1' rowspan='2' class='tr01'>开发商</td>" +
                "<td id='0_3' height='10' width='10' colspan='1' rowspan='2' class='tr01'>物业公司</td>" +
                "<td id='0_4' height='10' width='10' colspan='1' rowspan='2' class='tr01'>投资方</td>" +
                "<td id='0_5' height='10' width='10' colspan='3' rowspan='1' class='tr01'>产品</td>" +
                "<td id='0_6' height='10' width='10' colspan='14' rowspan='1' class='tr01'>项目</td>" +
                "<td id='0_7' height='10' width='150' colspan='1' rowspan='2' class='tr01'>其他</td>" +
                "<td id='0_7' height='10' width='16' colspan='1' rowspan='2' class='tr01'>操作</td>" +
                "</tr><tr class='trtotal' ><td id='1_0' height='10' width='60' colspan='1' rowspan='1' class='tr01'>产品定位</td>" +
                "<td id='1_1' height='10' width='40' colspan='1' rowspan='1' class='tr01'>产品类型</td>" +
                "<td id='1_2' height='10' width='60' colspan='1' rowspan='1' class='tr01'>产业类型</td>" +
                "<td id='1_3' height='10' width='10' colspan='1' rowspan='1' class='tr01'>入驻企业</td>" +
                "<td id='1_4' height='10' width='10' colspan='1' rowspan='1' class='tr01'>开盘时间</td>" +
                "<td id='1_5' height='10' width='10' colspan='1' rowspan='1' class='tr01'>预售许可证</td>" +
                "<td id='1_6' height='10' width='10' colspan='1' rowspan='1' class='tr01'>成本测算</td>" +
                "<td id='1_7' height='10' width='10' colspan='1' rowspan='1' class='tr01'>楼层</td>" +
                "<td id='1_8' height='10' width='10' colspan='1' rowspan='1' class='tr01'>标准层高（米）</td>" +
                "<td id='1_9' height='10' width='10' colspan='1' rowspan='1' class='tr01'>外墙</td>" +
                "<td id='1_10' height='10' width='10' colspan='1' rowspan='1' class='tr01'>采暖</td>" +
                "<td id='1_11' height='10' width='10' colspan='1' rowspan='1' class='tr01'>供电</td>" +
                "<td id='1_12' height='10' width='10' colspan='1' rowspan='1' class='tr01'>供水</td>" +
                "<td id='1_13' height='10' width='50' colspan='1' rowspan='1' class='tr01'>电梯</td>" +
                "<td id='1_14' height='10' width='10' colspan='1' rowspan='1' class='tr01'>固定车位（个）</td>" +
                "<td id='1_15' height='10' width='10' colspan='1' rowspan='1' class='tr01'>停车位租价（元/月·个）</td>" +
                "<td id='1_16' height='10' width='10' colspan='1' rowspan='1' class='tr01'>使用率</td></tr>  ");
        result.append("<tr id='newRow' class='tr02' style='display:none;'>"
        +"<td  class='td1'><input  id='bh'/ ></td>"
        +"<td  class='td1'><input  id='xzlmc' /></td>"
        +"<td  class='td1'><input  id='kfs' /></td>"
        +"<td  class='td1'><input  id='wygs' /></td>"
        +"<td  class='td1'><input  id='tzf' /></td>"
        +"<td  class='td1'><input  id='cpdw' /></td>"
        +"<td  class='td1'><input  id='cplx' /></td>"
        +"<td  class='td1'><input  id='cylx' /></td>"
        +"<td  class='td1'><input  id='rzqy' /></td>"
        +"<td  class='td1'><input  id='kpsj' /></td>"
        
        +"<td  class='td1'><input  id='ysxkz'/ ></td>"
        +"<td  class='td1'><input  id='cbcs' /></td>"
        +"<td  class='td1'><input  id='lc' /></td>"
        +"<td  class='td1'><input  id='bzcg' /></td>"
        +"<td  class='td1'><input  id='wq' /></td>"
        +"<td  class='td1'><input  id='cn' /></td>"
        +"<td  class='td1'><input  id='gd' /></td>"
        +"<td  class='td1'><input  id='gs' /></td>"
        +"<td  class='td1'><input  id='dt' /></td>"
        +"<td  class='td1'><input  id='gdcw'/ ></td>"
        
        +"<td  class='td1'><input  id='tcwzj' /></td>"
        +"<td  class='td1'><input  id='syl' /></td>"
        +"<td  class='td1'><input  id='qt' /></td>" 
        +"<td  class='td1'><a href='javascript:save()'>保存</a>&nbsp;&nbsp;<a href='javascript:cancel()'>取消</a></td></tr> ");
        
        for (int i = 0; i < list.size(); i++) {
            String bh = (String) (list.get(i)).get("bh");
            String xzlmc = (String) (list.get(i)).get("xzlmc");
            String kfs = (String) (list.get(i)).get("kfs");
            String wygs = (String) (list.get(i)).get("wygs");
            String tzf = (String) (list.get(i)).get("tzf");
            String cpdw = (String) (list.get(i)).get("cpdw");
            String cplx = (String) (list.get(i)).get("cplx");
            String cylx = (String) (list.get(i)).get("cylx");
            String rzqy = (String) (list.get(i)).get("rzqy");
            String kpsj = (String) (list.get(i)).get("kpsj");
            		
            String ysxkz = (String) (list.get(i)).get("ysxkz");
            String cbcs = (String) (list.get(i)).get("cbcs");
            String lc = (String) (list.get(i)).get("lc");
            String bzcg = (String) (list.get(i)).get("bzcg");
            String wq = (String) (list.get(i)).get("wq");
            String cn = (String) (list.get(i)).get("cn");
            String gd = (String) (list.get(i)).get("gd");
            String gs = (String) (list.get(i)).get("gs");
            String dt = (String) (list.get(i)).get("dt");
            String gdcw = (String) (list.get(i)).get("gdcw");
            
            String tcwzj = (String) (list.get(i)).get("tcwzj");
            String syl = (String) (list.get(i)).get("syl");
            String qt = (String) (list.get(i)).get("qt");
            
            result.append("<tr id=row" + i + "><td class='tr02' >" 
            		    + bh + "</td><td class='tr02' >"
                        + xzlmc + "</td><td class='tr02' >" 
                        + kfs + "</td><td class='tr02' >" 
                        + wygs+ "</td><td class='tr02' >"
                        + tzf + "</td><td class='tr02' >"
                        + cpdw + "</td><td class='tr02' >" 
                        + cplx + "</td><td class='tr02' >" 
                        + cylx+ "</td><td class='tr02' >"
                        
                        + rzqy + "</td><td class='tr02' >"
                        + kpsj + "</td><td class='tr02' >" 
                        + ysxkz + "</td><td class='tr02' >" 
                        + cbcs+ "</td><td class='tr02' >"
                        + lc + "</td><td class='tr02' >"
                        + bzcg + "</td><td class='tr02' >" 
                        + wq + "</td><td class='tr02' >" 
                        + cn+ "</td><td class='tr02' >"
                        
                        + gd + "</td><td class='tr02' >"
                        + gs + "</td><td class='tr02' >" 
                        + dt + "</td><td class='tr02' >" 
                        + gdcw+ "</td><td class='tr02' >"
                        + tcwzj + "</td><td class='tr02' >"
                        + syl + "</td><td class='tr02' >" 
                        + qt + "</td><td><a href='javascript:modify(" + i
                        + ")'>修改</a>&nbsp;&nbsp;<a href=\"javascript:del('" + bh
                        + "')\">删除</a></td></tr>");
        }
        result.append("</table>");
        return result.toString().replaceAll("null", "-").replaceAll("\r\n", " ; ");
    }
	public void del() {
        String bh = request.getParameter("bh");
        String sql = "delete from xzlxx t where bh='" + bh + "'";
        this.update(sql, YW);
        response("success");
    }
	public void saveZJXX(){
	      String bh = request.getParameter("bh");
	      String xzlmc = request.getParameter("xzlmc");
	      String kfs = request.getParameter("kfs");
	      String wygs = request.getParameter("wygs");
	      String tzf = request.getParameter("tzf");
	      String cpdw = request.getParameter("cpdw");
	      String cplx = request.getParameter("cplx");
	      String cylx = request.getParameter("cylx");
	      
	      String rzqy = request.getParameter("rzqy");
	      String kpsj = request.getParameter("kpsj");
	      String ysxkz = request.getParameter("ysxkz");
	      String cbcs = request.getParameter("cbcs");
	      String lc = request.getParameter("lc");
	      String bzcg = request.getParameter("bzcg");
	      String wq = request.getParameter("wq");
	      String cn = request.getParameter("cn");
	      String gd = request.getParameter("gd");
	      String gs = request.getParameter("gs");
	      String dt = request.getParameter("dt");
	      String gdcw = request.getParameter("gdcw");
	      String tcwzj = request.getParameter("tcwzj");
	      String syl = request.getParameter("syl");
	      String qt = request.getParameter("qt");
	      
	      bh=UtilFactory.getStrUtil().unescape(bh);
	      xzlmc=UtilFactory.getStrUtil().unescape(xzlmc);
	      kfs=UtilFactory.getStrUtil().unescape(kfs);
	      wygs=UtilFactory.getStrUtil().unescape(wygs);
	      tzf=UtilFactory.getStrUtil().unescape(tzf);
	      cpdw=UtilFactory.getStrUtil().unescape(cpdw);
	      cplx=UtilFactory.getStrUtil().unescape(cplx);
	      cylx=UtilFactory.getStrUtil().unescape(cylx);
	      
	      rzqy=UtilFactory.getStrUtil().unescape(rzqy);
	      kpsj=UtilFactory.getStrUtil().unescape(kpsj);
	      ysxkz=UtilFactory.getStrUtil().unescape(ysxkz);
	      cbcs=UtilFactory.getStrUtil().unescape(cbcs);
	      lc=UtilFactory.getStrUtil().unescape(lc);
	      bzcg=UtilFactory.getStrUtil().unescape(bzcg);
	      wq=UtilFactory.getStrUtil().unescape(wq);
	      cn=UtilFactory.getStrUtil().unescape(cn);
	      gd=UtilFactory.getStrUtil().unescape(gd);
	      gs=UtilFactory.getStrUtil().unescape(gs);
	      
	      dt=UtilFactory.getStrUtil().unescape(dt);
	      gdcw=UtilFactory.getStrUtil().unescape(gdcw);
	      tcwzj=UtilFactory.getStrUtil().unescape(tcwzj);
	      syl=UtilFactory.getStrUtil().unescape(syl);
	      qt=UtilFactory.getStrUtil().unescape(qt);
		      String insertString="insert into xzlxx (bh,xzlmc,kfs,wygs,tzf,cpdw,cplx,cylx,rzqy,kpsj,ysxkz,cbcs,lc,bzcg,wq,cn,gd,gs,dt,gdcw,tcwzj,syl,qt )values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		  int    i = update(insertString, YW,new Object[]{bh,xzlmc,kfs,wygs,tzf,cpdw,cplx,cylx,rzqy,kpsj,ysxkz,cbcs,lc,bzcg,wq,cn,gd,gs,dt,gdcw,tcwzj,syl,qt});
	        
	      if(i>0){
	         response("success");
	      }else{
	          response("failure");
	      }
	  }
	public void updateZJXX(){
	      String bh = request.getParameter("bh");
	      String xzlmc = request.getParameter("xzlmc");
	      String kfs = request.getParameter("kfs");
	      String wygs = request.getParameter("wygs");
	      String tzf = request.getParameter("tzf");
	      String cpdw = request.getParameter("cpdw");
	      String cplx = request.getParameter("cplx");
	      String cylx = request.getParameter("cylx");
	      
	      String rzqy = request.getParameter("rzqy");
	      String kpsj = request.getParameter("kpsj");
	      String ysxkz = request.getParameter("ysxkz");
	      String cbcs = request.getParameter("cbcs");
	      String lc = request.getParameter("lc");
	      String bzcg = request.getParameter("bzcg");
	      String wq = request.getParameter("wq");
	      String cn = request.getParameter("cn");
	      String gd = request.getParameter("gd");
	      String gs = request.getParameter("gs");
	      String dt = request.getParameter("dt");
	      String gdcw = request.getParameter("gdcw");
	      String tcwzj = request.getParameter("tcwzj");
	      String syl = request.getParameter("syl");
	      String qt = request.getParameter("qt");
	      
	      bh=UtilFactory.getStrUtil().unescape(bh);
	      xzlmc=UtilFactory.getStrUtil().unescape(xzlmc);
	      kfs=UtilFactory.getStrUtil().unescape(kfs);
	      wygs=UtilFactory.getStrUtil().unescape(wygs);
	      tzf=UtilFactory.getStrUtil().unescape(tzf);
	      cpdw=UtilFactory.getStrUtil().unescape(cpdw);
	      cplx=UtilFactory.getStrUtil().unescape(cplx);
	      cylx=UtilFactory.getStrUtil().unescape(cylx);
	      
	      rzqy=UtilFactory.getStrUtil().unescape(rzqy);
	      kpsj=UtilFactory.getStrUtil().unescape(kpsj);
	      ysxkz=UtilFactory.getStrUtil().unescape(ysxkz);
	      cbcs=UtilFactory.getStrUtil().unescape(cbcs);
	      lc=UtilFactory.getStrUtil().unescape(lc);
	      bzcg=UtilFactory.getStrUtil().unescape(bzcg);
	      wq=UtilFactory.getStrUtil().unescape(wq);
	      cn=UtilFactory.getStrUtil().unescape(cn);
	      gd=UtilFactory.getStrUtil().unescape(gd);
	      gs=UtilFactory.getStrUtil().unescape(gs);
	      
	      dt=UtilFactory.getStrUtil().unescape(dt);
	      gdcw=UtilFactory.getStrUtil().unescape(gdcw);
	      tcwzj=UtilFactory.getStrUtil().unescape(tcwzj);
	      syl=UtilFactory.getStrUtil().unescape(syl);
	      qt=UtilFactory.getStrUtil().unescape(qt);
	      
	            String update ="update xzlxx set xzlmc='"+xzlmc+"',kfs='"+kfs+"',wygs='"+wygs+"',tzf='"+tzf+"',cpdw='"
	            				+cpdw+"',cplx='"+cplx+"',cylx='"+cylx+"',rzqy='"+rzqy+"',kpsj='"+kpsj+"',ysxkz='"+ysxkz+"',cbcs='"
	            				+cbcs+"',lc='"+lc+"',bzcg='"+bzcg+"',wq='"+wq+"',cn='"+cn+"',gd='"+gd+"',gs='"
	            				+gs+"',dt='"+dt+"',gdcw='"+gdcw+"',tcwzj='"+tcwzj+"',syl='"+syl+"',qt='"+qt+"' where bh = '"+bh+"'";
	            System.out.print(update);
	      int i = update(update, YW,new Object[] {bh,xzlmc,kfs,wygs,tzf,cpdw,cplx,cylx,rzqy,kpsj,ysxkz,cbcs,lc,bzcg,wq,cn,gd,gs,dt,gdcw,tcwzj,syl,qt });
	      if(i>0){
	         response("success");
	      }else{
	          response("failure");
	      }
	  }

///////////////////////////////////////////////////////////////////

    /****
     * 
     * <br>Description:资金管理基本信息保存
     * <br>Author:朱波海
     * <br>Date:2014-1-6
     */
    public void Save_ZjqkXX(){
        String date_id_cols_value = request.getParameter("date_id_cols_value");
        date_id_cols_value=  UtilFactory.getStrUtil().unescape(date_id_cols_value);
        if(date_id_cols_value!=null&&!date_id_cols_value.equals("")){
            String[] split = date_id_cols_value.split("@");
            for(int i=0;i<split.length;i++){
                String[] split2 = split[i].split("_");
                String update="update XZLZJQK set "+split2[1]+"='"+split2[2]+"'  where yw_guid=? ";
                update(update,YW,new Object[]{split2[0]});
            }
            response("success");
        }
    }
    /*****
     * 
     * <br>Description:资金管理按年度保存
     * <br>Author:朱波海
     * <br>Date:2014-1-6
     */
    public void Save_Zjqk(){
        String datepjlm_id_cols_value = request.getParameter("datepjlm_id_cols_value");
        String datepjzj_id_cols_value = request.getParameter("datepjzj_id_cols_value");
        String year = request.getParameter("year");
        if(datepjlm_id_cols_value!=null&&!datepjlm_id_cols_value.equals("")){
            String[] split = datepjlm_id_cols_value.split("@");
            for(int i=0;i<split.length;i++){
                String[] split2 = split[i].split("_");
                String update="update XZLZJQKND_PJLM set "+split2[1]+"='"+split2[2]+"'  where yw_guid=? and rq=?";
                update(update,YW,new Object[]{split2[0],year});
            }
          
        }
        if(datepjzj_id_cols_value!=null&&!datepjzj_id_cols_value.equals("")){
            String[] split = datepjzj_id_cols_value.split("@");
            for(int i=0;i<split.length;i++){
                String[] split2 = split[i].split("_");
                String update="update XZLZJQKND_PJZJ set "+split2[1]+"='"+split2[2]+"'  where yw_guid=? and rq=?";
                update(update,YW,new Object[]{split2[0],year});
            }
        }
        response("success");
    }
  /****
   * 
   * <br>Description:
   * <br>Author:朱波海
   * <br>Date:2014-1-7
   */
    public void getTable(){
        String year = request.getParameter("year");
        String sqlString="select *  from XZLXX t";
        List<Map<String, Object>> list = query(sqlString,YW);
        for(int i=0;i<list.size();i++){
        String que="select * from XZLZJQKND_PJZJ where yw_guid=? and rq=?";
        List<Map<String, Object>> list2 = query(que, YW,new Object[]{list.get(i).get("yw_guid"),year});
        if(list2.size()<1){
            String insert="insert into XZLZJQKND_PJZJ (yw_guid,rq) values(?,?)";
            update(insert, YW,new Object[]{list.get(i).get("yw_guid"),year});
        }
        }
        for(int i=0;i<list.size();i++){
            String que="select * from XZLZJQKND_PJLM where yw_guid=? and rq=?";
            List<Map<String, Object>> list2 = query(que, YW,new Object[]{list.get(i).get("yw_guid"),year});
            if(list2.size()<1){
                String insert="insert into XZLZJQKND_PJLM (yw_guid,rq) values(?,?)";
                update(insert, YW,new Object[]{list.get(i).get("yw_guid"),year});
            }
            }
        String sql2="select * from XZLXX t,XZLZJQKND_PJLM t2 where t2.yw_guid=t.yw_guid and t2.rq=?";
        List<Map<String, Object>> query = query(sql2, YW,new Object []{year});
        String sql="select * from XZLXX t,XZLZJQKND_PJZJ t2 where t2.yw_guid=t.yw_guid and t2.rq=?";
        List<Map<String, Object>> query2 = query(sql, YW,new Object []{year});
        BuildModel buildModel = new BuildModel();
        String table = buildModel.getZjqkNd(query,query2);
        response(table);        
        
    }
/****
 * 
 * <br>Description:查询两年的数据
 * <br>Author:朱波海
 * <br>Date:2014-1-7
 */
    public void getXzl_ND(){
        String year1 = request.getParameter("year1");
        String year2 = request.getParameter("year2");
        String tabName = request.getParameter("tabName");
        String [] year={year1,year2};
        String ta=new ModelFactory().getMoreTab(year,tabName);
        response(ta);
        
    }
    

}
