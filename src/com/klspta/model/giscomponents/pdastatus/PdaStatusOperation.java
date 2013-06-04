package com.klspta.model.giscomponents.pdastatus;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;


public class PdaStatusOperation extends AbstractBaseBean
{
  private static PdaStatusOperation pdaStatusOperation;

  public static PdaStatusOperation getInstance()
  {
    if (pdaStatusOperation == null) {
      pdaStatusOperation = new PdaStatusOperation();
    }
    return pdaStatusOperation;
  }

  public String getTree() {
    String sql = "select QT_CTN_CODE,NA_CTN_NAME from code_xzqh t where t.QT_PARENT_CODE='370200' order by t.qt_ctn_code asc ";    
    List<Map<String, Object>> list = query(sql, AbstractBaseBean.CORE);
    
    StringBuffer sb = new StringBuffer();
    for (int i = 0; i < list.size(); ++i) {
      boolean flag=false;
      sb.append("{text:'" + list.get(i).get("NA_CTN_NAME") + "',leaf:0,id:'xzq" + i + "',children:[");
      String sql1 = "select g.GPS_ID,g.GPS_NAME,g.GPS_CANTONCODE,to_char(ROUND(TO_NUMBER(sysdate-t.timestamp) * 24 * 60)) time from WY_DEVICE_INFO g,WY_GPS_CURRENT_LOCATION t where g.GPS_CANTONCODE='" + list.get(i).get("QT_CTN_CODE").toString() + "' and g.gps_id = t.gps_id order by t.timestamp desc ";

      List<Map<String, Object>> list1 = query(sql1, AbstractBaseBean.YW);      
      for (int j = 0; j < list1.size(); ++j) {
        Map map1 = (Map)list1.get(j);
        if (Integer.parseInt((String)map1.get("time")) < 10) {
          sb.append("{text:'<font color=green>" + map1.get("GPS_NAME") + "_在线</font>',checked:false,leaf:1,id:'" + map1.get("GPS_ID") + "'},");
          flag=true;
        }
        else{
          sb.append("{text:'<font color=gray>" + map1.get("GPS_NAME") + "_离线</font>',checked:false,leaf:1,id:'" + map1.get("GPS_ID") + "'},");
          flag=true;
        }
        if (j== list1.size()-1){
          if(flag) 
           sb.deleteCharAt(sb.length() - 1);
        }
      }

      if (i == list.size() - 1){
        sb.append("]}");
      }
      else {
        sb.append("]},");
      }
    }
    return sb.toString();
  }
}