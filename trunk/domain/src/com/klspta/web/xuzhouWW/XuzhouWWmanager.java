package com.klspta.web.xuzhouWW;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.URIException;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.util.URIUtil;
import org.apache.commons.lang.StringUtils;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

/*******************************************************************************
 * 
 * <br>
 * Title:外网处理类 <br>
 * Description: 徐州外网处理类 <br>
 * Author:朱波海 <br>
 * Date:2012-11-10
 */
public class XuzhouWWmanager extends AbstractBaseBean {

	/***************************************************************************
	 * 
	 * <br>
	 * Description:偏移量（角度），x0，y0是开始坐标点，x1，y1是将要到达的坐标点 <br>
	 * Author:朱波海 <br>
	 * Date:2012-11-15
	 * 
	 * @param x0
	 * @param y0
	 * @param x1
	 * @param y1
	 */
    public static Map<String, Object> cacheMap=new HashMap<String,Object>();
	public double OffsetAngle(double x0, double y0, double x1, double y1) {
		double Angle = 0.001;
		double molecular = x1 - x0;// 分子
		double denominator = y1 - y0;
		if (molecular > 0 & denominator > 0) {
			Angle = Math.atan(molecular / denominator) / 3.1415926 * 180;
		}
		else if (molecular > 0 & denominator < 0) {
			Angle = Math.atan(molecular / denominator) / 3.1415926 * 180 + 90;

		}
		else if (molecular < 0 & denominator < 0) {
			Angle = Math.atan(molecular / denominator) / 3.1415926 * 180 + 180;
		}
		else if (molecular < 0 & denominator > 0) {
			Angle = Math.atan(molecular / denominator) / 3.1415926 * 180 + 270;
		} else {
			Angle = 0.0000;
		}
		return Angle;
	}

	/***************************************************************************
	 * 
	 * <br>
	 * Description:后台发送请求，获取天气预报实施接口情况 <br>
	 * Author:朱波海 <br>
	 * Date:2012-11-14
	 * 
	 * @return
	 */
	public String getWeather() {
		String url = "http://www.weather.com.cn/data/cityinfo/101190801.html";
		String result = doGet(url, null, "UTF-8", false);
		return result;

	}

	/**
	 * 执行一个HTTP GET请求，返回请求响应的HTML
	 * 
	 * @param url
	 *            请求的URL地址
	 * @param queryString
	 *            请求的查询参数,可以为null
	 * @param charset
	 *            字符集
	 * @param pretty
	 *            是否美化
	 * @return 返回请求响应的HTML
	 */
	private static String doGet(String url, String queryString, String charset,
			boolean pretty) {
		StringBuffer response = new StringBuffer();
		HttpClient client = new HttpClient();
		HttpMethod method = new GetMethod(url);
		try {
			if (StringUtils.isNotBlank(queryString))
				// 对get请求参数做了http请求默认编码，好像没有任何问题，汉字编码后，就成为%式样的字符串
				method.setQueryString(URIUtil.encodeQuery(queryString));
			client.executeMethod(method);
			if (method.getStatusCode() == HttpStatus.SC_OK) {
				BufferedReader reader = new BufferedReader(
						new InputStreamReader(method.getResponseBodyAsStream(),
								charset));
				String line;
				while ((line = reader.readLine()) != null) {
					if (pretty)
						response.append(line).append(
								System.getProperty("line.separator"));
					else
						response.append(line);
				}
				reader.close();
			}
		} catch (URIException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			method.releaseConnection();
		}
		return response.toString();
	}

	/***************************************************************************
	 * 
	 * <br>
	 * Description: 获取行行政区划编号及在线车辆统计和总数车辆统计 <br>
	 * Author:朱波海 <br>
	 * Date:2012-11-10
	 */
	public void getOnlineCar() {
		// 徐州市所有行政编号
		String SQL = "select qt_ctn_code,na_ctn_name from code_xzqh t where QT_PARENT_CODE='320300'";
		List<Map<String, Object>> XZQLIst = query(SQL, CORE);
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		int AllcarCount = 0;
		int AllcarLineCount = 0;
		for (int i = 0; i < XZQLIst.size(); i++) {
			// 查询每一个行政区划里巡查车的数量
			String Sql = "select count(*) from car_info t1 where CAR_CANTONCODE='"
					+ XZQLIst.get(i).get("qt_ctn_code") + "'";
			List<Map<String, Object>> Query = query(Sql, YW);
			// object转换为int
			String allcount = Query.get(0).get("count(*)").toString();
			AllcarCount += Integer.valueOf(String.valueOf(allcount)).intValue();
			String sql = "select count(*) from car_info t1, car_current_data t2 where CAR_CANTONCODE='"
					+ XZQLIst.get(i).get("qt_ctn_code")
					+ "' and t2.car_number=t1.car_number and to_char(ROUND(TO_NUMBER(sysdate - t2.send_data) * 24 * 60)) <= 10";
			List<Map<String, Object>> query = query(sql, YW);
			// object转换为int
			String alllinecount = query.get(0).get("count(*)").toString();
			AllcarLineCount += Integer.valueOf(String.valueOf(alllinecount))
					.intValue();
			String xzqh_code = XZQLIst.get(i).get("qt_ctn_code").toString();
			String xz_name = XZQLIst.get(i).get("na_ctn_name").toString();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("xzqh_code", xzqh_code);
			map.put("xzqh_name", xz_name);
			map.put("child", query.get(0).get("count(*)"));
			map.put("count", Query.get(0).get("count(*)"));
			list.add(map);
		}
		Map<String, Object> zq_map = new HashMap<String, Object>();
		zq_map.put("xzqh_code", "320300");
		zq_map.put("xzqh_name", "全 市");
		zq_map.put("child", AllcarLineCount);
		zq_map.put("count", AllcarCount);
		list.add(zq_map);
		response(list);
	}

	/***************************************************************************
	 * 
	 * <br>
	 * Description:获取生成动态树的数据 Author:朱波海 <br>
	 * Date:2012-11-10
	 */
	public void getGps_Tree() {
		String xzqh_select_cod = request.getParameter("xzqh_select");
		System.out.print(xzqh_select_cod);
		String status = request.getParameter("status");
		List<Map<String, Object>> xzqh_car_code_list = new ArrayList<Map<String, Object>>();
		String xzqh_name_all = "";
		if (status != null & status != "") {
			String[] zt = status.split("/");
			if (xzqh_select_cod != null & xzqh_select_cod != "") {
				String[] xzqh_code = xzqh_select_cod.split("/");
				if (!xzqh_code[0].equals("320300")) {
					for (int i = 0; i < xzqh_code.length; i++) {
						Map<String, Object> xzqh_car_code_map = new HashMap<String, Object>();
						String sql = "select t1.CAR_CANTONCODE,t1.CAR_NUMBER ,t1.car_info_xzqh_name from car_info t1, car_current_data t2 where  t2.car_number=t1.car_number";
						String car_number = "";
						sql += " and CAR_CANTONCODE='" + xzqh_code[i] + "'";
						if (zt.length == 1) {
							if (zt[0].equals("xs")) {
								sql += " and to_char(ROUND(TO_NUMBER(sysdate - t2.send_data) * 24 * 60)) <= 10 ";
								List<Map<String, Object>> query = query(sql, YW);
								if (query.size() > 0) {
									xzqh_name_all = query.get(0).get(
											"car_info_xzqh_name").toString();
								}

								for (int j = 0; j < query.size(); j++) {
									car_number += query.get(j)
											.get("car_number").toString()
											+ "/";
								}
							} else {
								sql += " and to_char(ROUND(TO_NUMBER(sysdate - t2.send_data) * 24 * 60)) > 10 ";
								List<Map<String, Object>> query = query(sql, YW);
								if (query.size() > 0) {
									xzqh_name_all = query.get(0).get(
											"car_info_xzqh_name").toString();
								}
								for (int j = 0; j < query.size(); j++) {
									car_number += query.get(j)
											.get("car_number").toString()
											+ "/";
								}
							}

						} else {
							List<Map<String, Object>> query = query(sql, YW);
							if (query.size() > 0) {
								xzqh_name_all = query.get(0).get(
										"car_info_xzqh_name").toString();
							}
							for (int j = 0; j < query.size(); j++) {
								car_number += query.get(j).get("car_number")
										.toString()
										+ "/";
							}

						}
						if (car_number.length() > 0) {

							xzqh_car_code_map.put("text", xzqh_name_all);
							xzqh_car_code_map.put("chehao", car_number);
							xzqh_car_code_list.add(xzqh_car_code_map);
						}
					}// //
				}
				if (xzqh_code[0].equals("320300")) {
					Map<String, Object> xzqh_car_code_map2 = new HashMap<String, Object>();
					String sql = "select t1.CAR_CANTONCODE,t1.CAR_NUMBER  from car_info t1, car_current_data t2 where  t2.car_number=t1.car_number";
					String car_number2 = "";
					// sql += " and CAR_CANTONCODE='" + xzqh_code[0] + "'";
					if (zt.length == 1) {
						if (zt[0].equals("xs")) {
							sql += " and to_char(ROUND(TO_NUMBER(sysdate - t2.send_data) * 24 * 60)) <= 10 ";
							List<Map<String, Object>> query = query(sql, YW);
							if (query.size() > 0) {
								xzqh_name_all = "徐州市";
							}
							for (int j = 0; j < query.size(); j++) {
								car_number2 += query.get(j).get("car_number")
										.toString()
										+ "/";
							}
						} else {
							sql += " and to_char(ROUND(TO_NUMBER(sysdate - t2.send_data) * 24 * 60)) > 10 ";
							List<Map<String, Object>> query = query(sql, YW);
							if (query.size() > 0) {
								xzqh_name_all = "徐州市";
							}
							for (int j = 0; j < query.size(); j++) {
								car_number2 += query.get(j).get("car_number")
										.toString()
										+ "/";
							}
						}

					} else {
						List<Map<String, Object>> query = query(sql, YW);
						if (query.size() > 0) {
							xzqh_name_all = "徐州市";
						}
						for (int j = 0; j < query.size(); j++) {
							car_number2 += query.get(j).get("car_number")
									.toString()
									+ "/";
						}

					}
					if (car_number2.length() > 0) {

						xzqh_car_code_map2.put("text", xzqh_name_all);
						xzqh_car_code_map2.put("chehao", car_number2);
						xzqh_car_code_list.add(xzqh_car_code_map2);
					}
				}

			}

		} else {
			if (xzqh_select_cod != null & xzqh_select_cod != "") {
				String[] xzqh_code = xzqh_select_cod.split("/");
				if (xzqh_code[0].equals("320300")) {
					Map<String, Object> xzqh_car_code_map = new HashMap<String, Object>();
					String sql = "select t1.CAR_CANTONCODE,t1.CAR_NUMBER ,t1.car_info_xzqh_name from car_info t1";
					String car_number2 = "";
					List<Map<String, Object>> query = query(sql, YW);
					for (int j = 0; j < query.size(); j++) {
						car_number2 += query.get(j).get("car_number")
								.toString()
								+ "/";
					}
					if (car_number2.length() > 0) {
						xzqh_car_code_map.put("text", "徐州市");
						xzqh_car_code_map.put("chehao", car_number2);
						xzqh_car_code_list.add(xzqh_car_code_map);
					}
				} else {
					for (int i = 0; i < xzqh_code.length; i++) {
						Map<String, Object> xzqh_car_code_map = new HashMap<String, Object>();
						String car_number = "";
						String sql = "select t1.CAR_CANTONCODE,t1.CAR_NUMBER ,t1.car_info_xzqh_name from car_info t1, car_current_data t2 where  t2.car_number=t1.car_number";
						sql += " and CAR_CANTONCODE='" + xzqh_code[i] + "'";
						List<Map<String, Object>> query = query(sql, YW);
						if (query.size() > 0) {
							xzqh_name_all = query.get(0).get(
									"car_info_xzqh_name").toString();
						}
						for (int j = 0; j < query.size(); j++) {
							car_number += query.get(j).get("car_number")
									.toString()
									+ "/";
						}
						if (car_number.length() > 0) {
							xzqh_car_code_map.put("text", xzqh_name_all);
							xzqh_car_code_map.put("chehao", car_number);
							xzqh_car_code_list.add(xzqh_car_code_map);
						}
					}// //
				}

			}

		}
		response(xzqh_car_code_list);
	}

	/***************************************************************************
	 * 
	 * <br>
	 * Description:车辆管理 <br>
	 * Author:朱波海 <br>
	 * Date:2012-11-12
	 */
	public void getAllCarData() {
		String sql = "select CAR_ID,CAR_NAME,CAR_UNIT,CAR_PERSON,CAR_PERSON_PHONE,CAR_CANTONCODE,CAR_NUMBER,CAR_INFO_XZQH_NAME ,CAR_STYLE, to_char(CAR_GMRQ,'yyyy-MM-dd') as CAR_GMRQ from car_info";
		List<Map<String, Object>> query = query(sql, YW);
		response(query);
	}

	/***************************************************************************
	 * 
	 * <br>
	 * Description:增加/修改操作处理 <br>
	 * Author:朱波海 <br>
	 * Date:2012-11-12
	 */
	public void addCarData() {
		String car_id = request.getParameter("car_id");
		String car_name = request.getParameter("car_name");
		String car_unit = request.getParameter("car_unit");
		String car_person = request.getParameter("car_person");
		String car_person_phone = request.getParameter("car_person_phone");
		String car_number = request.getParameter("car_number");
		String car_info_xzqh_name = request.getParameter("car_info_xzqh_name");
		String car_style = request.getParameter("car_style");
		String car_gmrq = request.getParameter("car_gmrq");
		String sql_xzqh = "select qt_ctn_code from code_xzqh where na_ctn_name='"
				+ car_info_xzqh_name + "'and qt_parent_code='320300'";
		List<Map<String, Object>> query = query(sql_xzqh, CORE);
		String car_cantoncode = query.get(0).get("qt_ctn_code").toString();
		//增加
		if (car_id.equals("") | car_id == null) {
			//String sql2 = " insert into CAR_CURRENT_DATA (CAR_NUMBER,CAR_NAME,CAR_X,CAR_Y,SEND_DATA,CAR_STATUS) values('"
			//		+ car_number + "','','','','','')";
			//update(sql2, YW);
			String sql = " insert into car_info (car_name,car_number,car_unit,car_person,car_person_phone,car_cantoncode,car_info_xzqh_name,car_style,car_gmrq) values ('"
					+ car_name
					+ "','"
					+ car_number
					+ "','"
					+ car_unit
					+ "','"
					+ car_person
					+ "','"
					+ car_person_phone
					+ "','"
					+ car_cantoncode
					+ "','"
					+ car_info_xzqh_name
					+ "','"
					+ car_style + "',to_date('" + car_gmrq + "','yyyy-mm-dd'))";
			update(sql, YW);
			response("{success:true}");

		} else {
			//修改
			String sql3="select car_number from car_info where car_id='"+car_id+"'";
			List<Map<String, Object>> query3 = query(sql3,YW);
		    //	String carnum = query3.get(0).get("car_number").toString();
			//String sql2 = "UPDATE CAR_CURRENT_DATA SET car_name='"+car_number+"' where car_nunber='"+carnum+"'";
			//update(sql2, YW);
			String sql = "UPDATE car_info SET car_name='" + car_name
					+ "',car_unit ='" + car_unit + "' ,car_person='"
					+ car_person + "', " + "car_person_phone='"
					+ car_person_phone + "',car_cantoncode='" + car_cantoncode
					+ "',car_number='" + car_number + "',"
					+ "car_info_xzqh_name='" + car_info_xzqh_name
					+ "',car_style='" + car_style + "',car_gmrq=to_date('"
					+ car_gmrq + "','yyyy-mm-dd')" + " where car_id='" + car_id
					+ "'";
			update(sql, YW);
			response("{success:true}");
		}

	}
public void getxzqhData(){
	String sql="select QT_CTN_CODE,NA_CTN_NAME from CODE_XZQH where QT_PARENT_CODE='320300'";
	List<Map<String, Object>> query = query(sql, CORE);
	response(query);
	
	
	
}
	/***************************************************************************
	 * 
	 * <br>
	 * Description:删除 <br>
	 * Author:朱波海 <br>
	 * Date:2012-11-12
	 */
	public void deleteCarData() {
		String car_id = request.getParameter("car_id");
		car_id = UtilFactory.getStrUtil().unescape(car_id);
		//String sql2 = " Delete from CAR_CURRENT_DATA where car_number='"
		//		+ car_number + "'";
		//update(sql2, YW);
		String sql = " Delete from car_info where car_id='" + car_id
				+ "'";
		update(sql, YW);
		response("success");
	}

	/***************************************************************************
	 * 
	 * <br>
	 * Description:查找 <br>
	 * Author:朱波海 <br>
	 * Date:2012-11-12
	 */
	public void queryCarData() {
		String keyworld = request.getParameter("keyWord");
		String xzqh = request.getParameter("xzqh");
		if (keyworld != ""&xzqh!="") {
			keyworld = UtilFactory.getStrUtil().unescape(keyworld);
			String sql = "select CAR_NAME,CAR_UNIT,CAR_PERSON,CAR_PERSON_PHONE,CAR_CANTONCODE,CAR_NUMBER,CAR_INFO_XZQH_NAME ,CAR_STYLE,to_char(CAR_GMRQ,'yyyy-MM-dd') as CAR_GMRQ from car_info t where (t.CAR_NUMBER||t.CAR_NAME||t.CAR_STYLE ||t.CAR_PERSON like '%"
					+ keyworld + "%') and CAR_CANTONCODE='"+xzqh+"'";
			List<Map<String, Object>> query = query(sql, YW);
			response(query);
		}else if(xzqh!=""){
			String sql = "select CAR_NAME,CAR_UNIT,CAR_PERSON,CAR_PERSON_PHONE,CAR_CANTONCODE,CAR_NUMBER,CAR_INFO_XZQH_NAME ,CAR_STYLE,to_char(CAR_GMRQ,'yyyy-MM-dd') as CAR_GMRQ from car_info t where  CAR_CANTONCODE='"+xzqh+"'";
		List<Map<String, Object>> query = query(sql, YW);
		response(query);
			
		}else if(xzqh==""&keyworld != ""){
			keyworld = UtilFactory.getStrUtil().unescape(keyworld);
			String sql = "select CAR_NAME,CAR_UNIT,CAR_PERSON,CAR_PERSON_PHONE,CAR_CANTONCODE,CAR_NUMBER,CAR_INFO_XZQH_NAME ,CAR_STYLE,to_char(CAR_GMRQ,'yyyy-MM-dd') as CAR_GMRQ from car_info t where (t.CAR_NUMBER||t.CAR_NAME||t.CAR_STYLE||t.CAR_PERSON  like '%"
				+ keyworld + "%')";
			List<Map<String, Object>> query = query(sql, YW);
			response(query);
		}

	}

	public void getPoint() {
		String carId = "";
		try {
			carId = URLDecoder.decode(request.getParameter("carId"), "utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String sql = "select car_x,car_y,car_status from car_current_data where car_number='"
				+ carId + "'";
		List<Map<String, Object>> list = query(sql, YW);
		Map map=list.get(0);
		double x1=Double.valueOf((String)map.get("car_x"));
		double y1=Double.valueOf((String)map.get("car_y"));
		double x0=0;
		double y0=0;
		double angle=0;
		if(cacheMap.get(carId)!=null){
			String zb=(String)cacheMap.get(carId);
			String[] zbs=zb.split(",");
			x0=Double.valueOf(zbs[0]);
			y0=Double.valueOf(zbs[1]);	
			angle=this.OffsetAngle(x0, y0, x1, y1);
		}
		cacheMap.put(carId,(String)map.get("car_x")+","+(String)map.get("car_y"));
		Map resMap=(Map)list.get(0);
		resMap.put("ANGLE", angle);
		String status="0";
		String checkStatus="select * from car_current_data where to_char(ROUND(TO_NUMBER(sysdate - send_data) * 24 * 60)) <= 10";
		List<Map<String, Object>> checkList = query(checkStatus, YW);
		if(checkList.size()>0){
			status="1";	
		}
		resMap.put("STATUS", status);
		response(list);
	}
	
	public void checkStatus(){
		String carId = "";
		try {
			carId = URLDecoder.decode(request.getParameter("carId"), "utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String result="false";
		String sql="select * from car_current_data t where t.car_number='"+carId+"' and to_char(ROUND(TO_NUMBER(sysdate - t.send_data) * 24 * 60)) <= 10";
		List<Map<String, Object>> list = query(sql, YW);
		if(list.size()>0){
			result="true";
		}
		response(result);
	}
	
	
    /**
     * <br>Description:根据车牌号获取车辆信息
     * <br>Author:赵伟
     * <br>Date:2012-12-17
     * @return
     */
    public List<Map<String,Object>> getCarInfoByCarName(String carname){
    	String sql="select * from car_info where car_name='"+carname+"'";
    	List<Map<String,Object>> list=query(sql,YW);
    	return list;
    }
   
}
