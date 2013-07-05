package com.klspta.web.xuzhouWW.carhistory;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Component;
import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

@Component
public class CarHistory extends AbstractBaseBean {

	public CarHistory() {
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
		List<Map<String, Object>> list = query(sql, YW, new Object[] {
				startDate, endDate });
		response(list);
	}
}
