package com.klspta.web.cbd.jtfx.scjc;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

/**
 * <br>Title:市场监测信息维护
 * <br>Description:二手房基础信息维护，及月度价格维护
 * <br>Author:邹勇
 * <br>Date:2013-12-30
 */
public class ScjcManager extends AbstractBaseBean {
    /**
     * <br>Description:获取每一列的信息
     * <br>Author:邹勇
     * <br>Date:2013-12-30
     * @return
     */
    private static ScjcManager scjcManager;

    public static ScjcManager getInstcne() {
        if (scjcManager == null) {
            scjcManager = new ScjcManager();
        }
        return scjcManager;
    }

    public String getList() {
        String sql = "select t.*  from esf_jbxx t where 1=1 order by t.dateflag desc";
        List<Map<String, Object>> list = query(sql, YW);
        StringBuffer result = new StringBuffer(
                "<table id='esftable' name='esftable' ><tr id='-1'><td class='tr01'>序号</td><td class='tr01'>所属区域</td><td  class='tr01'>小区名称</td><td  class='tr01'>小区类别</td><td width=300 class='tr01'>备注</td><td  style='display:none;'>主键(hiden)</td><td class='tr01'>操作</td>  </tr>  ");
        result.append("<tr id='newRow' class='tr02' style='display:none;'><td></td><td  class='td1'><select id='ssqy'><option value='CBD中心区'  selected = 'selected'>CBD中心区</option><option value='CBD东扩区'>CBD东扩区</option></select></td><td  class='td1'><input  id='xqmc' size=10></td><td  class='td1'><select id='xqlb'><option value='老旧房'>老旧房</option><option value='新居房'>新居房</option></select></td><td><textarea id='bz' cols='36' rows='3'></textarea></td><td style='display:none;'><input  id='yw_guid'></td><td><a href='javascript:save()'>保存</a>&nbsp;&nbsp;<a href='javascript:cancel()'>取消</a></td>  </tr> ");
        for (int i = 0; i < list.size(); i++) {
            String rownum = i + 1 + "";
            String ssqy = (String) (list.get(i)).get("ssqy");
            String xqmc = (String) (list.get(i)).get("xqmc");
            String xqlb = (String) (list.get(i)).get("xqlb");
            String bz = (String) (list.get(i)).get("bz");
            String yw_guid = (String) (list.get(i)).get("yw_guid");
            if (xqlb.equals("老旧房")) {
                result.append("<tr id=row" + i + "><td class='tr02'>" + rownum + "</td><td class='tr02'>"
                        + ssqy + "</td><td class='tr02'>" + xqmc + "</td><td class='tr02'>" + xqlb
                        + "</td><td class='tr02'>" + bz + "</td><td style='display:none;'>" + yw_guid
                        + "</td><td><a href='javascript:modify(" + i
                        + ")'>修改</a>&nbsp;&nbsp;<a href=\"javascript:del('" + yw_guid
                        + "')\">删除</a></td></tr>");
            } else if (xqlb.equals("新居房")) {
                result.append("<tr id=row" + i + "><td class='tr03'>" + rownum + "</td><td class='tr03'>"
                        + ssqy + "</td><td class='tr03'>" + xqmc + "</td><td class='tr03'>" + xqlb
                        + "</td><td class='tr03'>" + bz + "</td><td style='display:none;'>" + yw_guid
                        + "</td><td><a href='javascript:modify(" + i
                        + ")'>修改</a>&nbsp;&nbsp;<a href=\"javascript:del('" + yw_guid
                        + "')\">删除</a></td></tr>");
            }
        }

        result.append("</table>");
        return result.toString().replaceAll("null", "").replaceAll("\r\n", " ; ");
    }

    public void delByYwGuid() {
        String yw_guid = request.getParameter("yw_guid");
        String sql = "delete from esf_jbxx t where yw_guid='" + yw_guid + "'";
        this.update(sql, YW);
        response("success");
    }

    public void save() {
        String yw_guid = request.getParameter("yw_guid");
        String ssqy = UtilFactory.getStrUtil().unescape(request.getParameter("ssqy"));
        String xqmc = UtilFactory.getStrUtil().unescape(request.getParameter("xqmc"));
        String xqlb = UtilFactory.getStrUtil().unescape(request.getParameter("xqlb"));
        String bz = UtilFactory.getStrUtil().unescape(request.getParameter("bz"));
        if(!yw_guid.equals("")&&yw_guid!=null){
            String update ="update esf_jbxx set ssqy='"+ssqy+"',xqmc='"+xqmc+"',xqlb='"+xqlb+"',bz='"+bz+"'where yw_guid=?";
            this.update(update, YW,new Object[] { yw_guid });
        }else{
       
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd_hhmmss");
        String format = dateFormat.format(new Date());
        
        String insertSql = "insert into esf_jbxx(ssqy,xqmc,xqlb,bz,yw_guid) values(?,?,?,?,?)";
        this.update(insertSql, YW, new Object[] { ssqy, xqmc, xqlb, bz ,format});
        String intserSql2 = "insert into esf_zsxx(yw_guid)values(?)";
        this.update(intserSql2, YW,new Object[] { format });
        }
        response("success");

    }

    /**
     * <br>Description:生成录入租售情况表
     * <br>Author:邹勇
     * <br>Date:2013-12-30
     * @return
     */
    public String getList2() {
        String sql = "select t.xqmc,t2.zl,t2.esfjj,t2.czl,t2.czfjj,t.yw_guid  from esf_jbxx t ,esf_zsxx t2 where t.yw_guid=t2.yw_guid order by t.dateflag desc";
        List<Map<String, Object>> list = query(sql, YW);
        StringBuffer result = new StringBuffer(
                "<table id='zsqktable' name='zsqktable'><tr id='-1'><td class='tr01'>序号</td><td class='tr01'>小区名称</td><td class='tr01'>二手房总量</td><td class='tr01'>二手房均价</td><td class='tr01'>出租量</td><td class='tr01'>出租房均价</td><td style='display:none;'>主键(hiden)</td></tr>");
        for (int i = 0; i < list.size(); i++) {
            String rownum = i + 1 + "";
            String xqmc = (String) (list.get(i)).get("xqmc");
            String yw_guid = (String) (list.get(i)).get("yw_guid");
            result.append("<tr id=row"
                    + i
                    + "><td>"
                    + rownum
                    + "</td><td>"
                    + xqmc
                    + "</td><td><input id='"+(String) (list.get(i)).get("yw_guid")+"_1'value='"+replace(String.valueOf(list.get(i).get("zl")))+"' onchange='chang(this)'  /></td><td><input id='"+(String) (list.get(i)).get("yw_guid")+"_2' value='"+replace(String.valueOf(list.get(i).get("esfjj")))+"'  onchange='chang(this)'/></td><td><input id='"+(String) (list.get(i)).get("yw_guid")+"_3' value='"+replace(String.valueOf(list.get(i).get("czl")))+"'  onchange='chang(this)'/></td><td><input id='"+(String) (list.get(i)).get("yw_guid")+"_4' value='"+replace(String.valueOf(list.get(i).get("czfjj")))+"'  onchange='chang(this)'/></td><td id='yw_guid' style='display:none;'>"
                    + yw_guid + "</td></tr>");
        }
        result.append("</table>");
        return result.toString().replaceAll("null", "").replaceAll("\r\n", " ; ");
    }
    
    public void insert(){
        String sj = request.getParameter("sj");
        if(sj!=null&&!sj.equals("")){
        String[] date = sj.split("@");
        for(int i=0;i<date.length;i++){
            String[] split = date[i].split("_");
            String yw_guid=split[0]+"_"+split[1];
            String xh=split[2];
            String value=split[3];
            String type="";
            if(xh.equals("1")){
                type="zl";
            }
            if(xh.equals("2")){
                type="esfjj";
            }
            if(xh.equals("3")){
                type="czl";
            }
            if(xh.equals("4")){
                type="czfjj";
            }
            String upda ="update esf_zsxx set "+type+"='"+value+"' where yw_guid=?";
            this.update(upda, YW,new Object[]{yw_guid});
        }
        }
//        String insertSql = "update esf_zsxx set zl='"+zl+"',esfjj='"+esfjj+"',czl='"+czl+"',czfjj='"+czfjj+"'where yw_guid=?";
//        this.update(insertSql, YW,new Object[]{yw_guid});
        response("success");
    }
    
    public String replace(String str){
        if(str.equals("null")){
            return "";
        }else{
            return str;
        }
        
    }
}
