package com.klspta.model.dtdw;

import org.springframework.stereotype.Component;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.wkt.Point;

/**
 * 需要在conf下的applicationContext-bean.xml中，增加配置信息： <bean name="simpleExample"
 * class="com.klspta.model.SimpleExample" scope="prototype"/>
 * 
 * @author wang
 * 
 */
@Component
public class SendCarPosition extends AbstractBaseBean {

	public SendCarPosition() {
		// System.out.println("" + this.getClass().getName());
	}

	public void send() {
		try {
			String id = request.getParameter("id");
			String x = request.getParameter("x");
			String y = request.getParameter("y");
			Point p = UtilFactory.getGisGridUtil().changePoint(new Point(x, y));
			// 更新
			String updateSql = "update car_current_data t set t.car_x=?,t.car_y=? ,t.send_data=sysdate where t.car_id=?";
			String insertSql = "insert into car_location_history(x,y,car_id,carid) values(?,?,?,(select t.car_name from car_info t where t.car_id=?))";
			update(updateSql, YW,
					new Object[] { p.getX4Str(), p.getY4Str(), id });
			update(insertSql, YW, new Object[] { p.getX4Str(), p.getY4Str(),
					id, id });

			clearParameter();

		} catch (Exception e) {
			e.printStackTrace();
		}
		// response();
	}

}
