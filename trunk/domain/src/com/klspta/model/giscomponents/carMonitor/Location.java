package com.klspta.model.giscomponents.carMonitor;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import org.springframework.stereotype.Component;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.util.api.IChangeCoordsSysUtil;
import com.klspta.base.wkt.Point;

@Component
public class Location extends AbstractBaseBean {

	public Location() {
	}

	public void getHistoryById() {
		String carId = request.getParameter("carId");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		carId = UtilFactory.getStrUtil().unescape(carId);
		String carIds[] = carId.split(",");
		String cars = "'" + carIds[0] + "'";
		for (int i = 1; i < carIds.length; i++) {
			cars += ",'" + carIds[i] + "'";
		}
		String sql = "select t2.car_name carid,t1.x,t1.y,to_char(t1.history_date, 'YYYY/MM/DD HH24:MI:SS') || ' UTC' history_date from car_location_history t1,car_info t2 where t1.carid=t2.car_id and t2.car_name in("
				+ cars
				+ ") and t1.history_date >to_date(?,'YYYY-MM-DD HH24:MI:SS') and t1.history_date <to_date(?,'YYYY-MM-DD HH24:MI:SS') order by t1.carid,t1.history_date";
		List<Map<String, Object>> list = query(sql, YW, new Object[] { startDate, endDate });
		response(list);
	}

	public void changeMe() {
		String x = request.getParameter("x");
		String y = request.getParameter("y");
		try {
			Double dx = Double.parseDouble(x);
			Double dy = Double.parseDouble(y);
			if (dx < 20000) {
				if (dx < 360) {
					dx = dx * 100;
					dy = dy * 100;
				}
				Point point;
				point = UtilFactory.getChangeCoordsSysUtil().changeMe(new Point(dx, dy),
						IChangeCoordsSysUtil.BL84_TO_BL80);
				Vector<String> v = new Vector<String>();
				v.add(point.getX4Str());
				v.add(point.getY4Str());
				putParameter(v);
				response();
			} else {
				Point point;
				point = UtilFactory.getChangeCoordsSysUtil().changeMe(new Point(dx, dy),
						IChangeCoordsSysUtil.PLAIN80_TO_BL80);
				Vector<String> v = new Vector<String>();
				v.add(point.getX4Str());
				v.add(point.getY4Str());
				putParameter(v);
				response();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void changeMe2() {
		String x = request.getParameter("x");
		String y = request.getParameter("y");
		try {
			Double dx = Double.parseDouble(x);
			Double dy = Double.parseDouble(y);
			Point point;
			point = UtilFactory.getChangeCoordsSysUtil().changeMe(new Point(dx, dy), IChangeCoordsSysUtil.BL84_TO_BL80);
			point = UtilFactory.getChangeCoordsSysUtil().changeMe(point, IChangeCoordsSysUtil.BL80_TO_PLAIN80);
			Vector<String> v = new Vector<String>();
			v.add(point.getX4Str());
			v.add(point.getY4Str());
			putParameter(v);
			response();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void doit() {
		String x = request.getParameter("x");
		String y = request.getParameter("y");
		String len = request.getParameter("len");
		query(this.getClass(), GIS, new Object[] { x, y, len });
		response();
	}

	public static void main(String[] args) {
		Location lo = new Location();
		lo.doit();
	}
	public void test(){
		Date date=null;
		String carid="4E6E672B07384572ADD6A5CD237AF4CD";
		String x=request.getParameter("x");
		String y=request.getParameter("y");
		String sql="insert into CAR_LOCATION_HISTORY_BAK(CARID,X,Y) values(?,?,?)";
		update(sql,YW,new Object[]{carid,x,y});
		response("true");
	}
}
