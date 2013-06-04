package com.klspta.model.giscomponents.infoquery;

import java.util.List;
import java.util.Map;

import com.klspta.model.giscomponents.util.MapFucntionUtil;

/**
 * 
 * <br>Title:InfoQueryLayer
 * <br>Description:InfoQueryLayer
 * <br>Author:王雷
 * <br>Date:2012-2-7
 */
public class InfoQueryLayer {
    private static InfoQueryLayer infoquery;
    private InfoQueryLayer(){}
    /**
     * 
     * <br>Description:获取实例
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @return
     */
    public static InfoQueryLayer getInstance(){
        if(infoquery==null){
            return new InfoQueryLayer();
        }
        return infoquery;
    }
    /**
     * 
     * <br>Description:获取图斑查询图层
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @return
     */
    public String getQueryLayer(){       
        List<Map<String,Object>> list=MapFucntionUtil.getTb("4");       
        StringBuffer sb = new StringBuffer();
        sb.append("[");        
        if(list!=null&&list.size()>0){
            for(int i=0;i<list.size();i++){
                Map<String,Object> map=(Map<String,Object>)list.get(i);
                if(i==0){
                    sb.append("{boxLabel:'").append((String)map.get("treename")).append("',name:'treeid',checked:'true',inputValue:'"+(String)map.get("treeid")).append("'},");
                    continue;
                }  
                sb.append("{boxLabel:'").append((String)map.get("treename")).append("',name:'treeid',inputValue:'"+(String)map.get("treeid")).append("'},");                 
            }
        }
        sb.deleteCharAt(sb.length()-1);
        sb.append("]");  
        return sb.toString();
    }   
}
