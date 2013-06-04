package com.klspta.model.changeCoords;


import org.springframework.stereotype.Component;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.util.impl.ChangeCoordsSysUtil;
import com.klspta.base.wkt.Point;
/**
 * 需要在conf下的applicationContext-bean.xml中，增加配置信息：
 * <bean name="simpleExample" class="com.klspta.model.SimpleExample" scope="prototype"/>
 * @author wang
 *
 */
@Component
public class ChangeCoords extends AbstractBaseBean {
    
    public ChangeCoords(){
    }
    //type
    //value = 84BLTO80PLAIN
    //value = 84BLTO80BL
    //value = 80BLTO80PLAIN
    //value = 80PLAINTO80BL
    //value = 84PLAINTO80PLAIN
    public void changeme(){
        try{
            double x = Double.parseDouble(request.getParameter("x"));
            double y = Double.parseDouble(request.getParameter("y"));
            String type=request.getParameter("type");
            String typeVaue=null;
            if("84BLTO80PLAIN".equalsIgnoreCase(type))
            	typeVaue=ChangeCoordsSysUtil.GPS84_TO_BALIN80;
            if("84BLTO80BL".equalsIgnoreCase(type))
            	typeVaue=ChangeCoordsSysUtil.BL84_TO_BL80;
            if("80BLTO80PLAIN".equalsIgnoreCase(type))
            	typeVaue=ChangeCoordsSysUtil.BL80_TO_PLAIN80;
            if(" 80PLAINTO80BL".equalsIgnoreCase(type))
            	typeVaue=ChangeCoordsSysUtil.PLAIN80_TO_BL80;
            if("84PLAINTO80PLAIN".equalsIgnoreCase(type))
            	typeVaue=ChangeCoordsSysUtil.PLAIN84_TO_PLAIN80;
            if("GRID".equalsIgnoreCase(type))
            	typeVaue=ChangeCoordsSysUtil.GRID;
            Point p = UtilFactory.getChangeCoordsSysUtil().changeMe(new Point(x,y),typeVaue);            
            putParameter(p.getX());
            putParameter(p.getY());
            response();
        }catch(Exception e){
            
        }
        

    }
}
