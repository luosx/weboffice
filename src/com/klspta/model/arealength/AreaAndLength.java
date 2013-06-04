package com.klspta.model.arealength;

import java.sql.Clob;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Component;
import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.wkt.Polygon;
/**
 * 需要在conf下的applicationContext-bean.xml中，增加配置信息：
 * <bean name="simpleExample" class="com.klspta.model.SimpleExample" scope="prototype"/>
 * @author wang
 *
 */
@Component
public class AreaAndLength extends AbstractBaseBean {
    
    public AreaAndLength(){
    }
    
    public void cal(){
        clearParameter();
        double area = 0;
        String wkt = request.getParameter("wkt");
        Polygon pol = new Polygon(wkt);
        double[] ss = UtilFactory.getCalculateAreasAndLengthsUtil().getAreasAndLengths(pol);
        putParameter(ss[0]);
        area = getArea(wkt, "BA_SZFPZYD");
        putParameter(area);
        area = getArea(wkt, "CHINA_CSYD_SB");
        putParameter(area);
        area = getArea(wkt, "CHINA_JS_PC_POLY");
        putParameter(area);
        area = getArea(wkt, "DDXZ_ZDWZ");
        putParameter(area);
        area = getArea(wkt, "BA_GD_QUANGUO");
        putParameter(area);
        response();
    }
    
    
    private double getArea(String wkt, String tablename){
        double area = 0;
        try {
            List<Map<String,Object>> list = query(this.getClass(), GIS, new Object[] {wkt, wkt}, tablename);
            if(list.size()>0){
            	for(int i=0;i<list.size();i++){
            		Map<String,Object> map=list.get(i);
            		Clob clob = (Clob)map.get("area");
                    wkt = clob.getSubString((long)1, (int)clob.length()); 
                    //wkt = rs.getClob(1).toString();
                    double[] ss = {0, 0};
                    if(wkt.startsWith("POLYGON")){
                        Polygon pol = new Polygon(wkt);
                        ss = UtilFactory.getCalculateAreasAndLengthsUtil().getAreasAndLengths(pol);
                        area = area + ss[0];
                    }else if(wkt.startsWith("MULTIPOLYGON")){
                        //TODO
                        //TODO
                        //TODO
                        /*pol = new Polygon(wkt);
                        ss = UtilFactory.getCalculateAreasAndLengthsUtil().getAreasAndLengths(pol);
                        area = area + ss[0];*/
                    }
            	}
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return area;
    }
}
