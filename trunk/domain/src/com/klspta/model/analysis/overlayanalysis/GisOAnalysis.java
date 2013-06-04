package com.klspta.model.analysis.overlayanalysis;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.Namespace;
import org.jdom.input.SAXBuilder;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;


public class GisOAnalysis extends AbstractBaseBean {
	
	
	private String flag = "1";
	private String gdbserver = "";
	private String gdbname = "";
	private String username = "";
	private String password = "";
	private String layername = "";
	private String layertype = "";
	private String isnetdata = "";
	private String isrecalculate = "";
	private String clipflag = "";
	private String radius = "";
	private String ipLocation = "";
	private String showName = "";
	
	/**
	 * 
	 * <br>Description:构造函数用于设定默认访问参数
	 * <br>Author:黎春行
	 * <br>Date:2012-10-12
	 */
	public GisOAnalysis() {
	}

	/**
	 * 
	 * <br>Description:获取叠加分析结果
	 * <br>Author:黎春行
	 * <br>Date:2012-10-12
	 */
	public List overLayA(String yw_guid, String layer, String yw_flag){
		//String yw_guid = request.getParameter("yw_guid");
		//String yw_flag = request.getParameter("flag");
		
		//根据layer重写layername
		
		
		if(null == yw_flag){
			yw_flag = flag;
		}
		if(!yw_flag.equals(flag)){
			flag = yw_flag;
		}
		changeConfig(yw_flag);
		
		//获取yu_guid所对应的地址(现场巡查情况表)
		String sql = "select t.cjzb, t.xcx from xcxcqkb t where t.yw_guid=?";
		List<Map<String, Object>> resultList = query(sql, YW, new Object[]{yw_guid});
		String clipregion = String.valueOf(resultList.get(0).get("cjzb"));
		String[] loaction = {String.valueOf(resultList.get(0).get("xcx"))};
		String locationNum = UtilFactory.getXzqhUtil().getListByName(loaction).get(0).getCatoncode();
		locationNum = "D" + locationNum;

		StringBuffer URL = new StringBuffer();
		URL.append("http://");
		URL.append(ipLocation);
		URL.append("/MapgisOGCWebService/REST/WPSHandler.ashx?service=wps&Request=execute&version=1.0.0&ResponseForm=&language=&Identifer=ClipByPolygon&");
		URL.append("DataInputs=gdbserver=");
		URL.append(gdbserver);
		URL.append(";gdbname=");
		URL.append(gdbname);
		URL.append(";user=");
		URL.append(username);
		URL.append(";password=");
		URL.append(password);
		URL.append(";layername=");
		URL.append(locationNum + layername);
		URL.append(";layertype=");
		URL.append(layertype);
		URL.append(";clipregion=");
		URL.append(clipregion);
		URL.append(";radius=");
		URL.append(radius);
		URL.append(";isnetdata=");
		URL.append(isnetdata);
		URL.append(";isrecalculate=");
		URL.append(isrecalculate);
		URL.append(";clipflag=");
		URL.append(clipflag);
		System.out.println(URL.toString());
		List<Map<String, Object>> responseList = getReturnXML(URL.toString());
		return responseList;
	}
	
	private List<Map<String, Object>> getReturnXML(String URL){
		//URL = "http://10.11.2.11/MapgisOGCWebService/REST/WPSHandler.ashx?service=wps&Request=execute&version=1.0.0&ResponseForm=&language=&Identifer=ClipByPolygon&DataInputs=gdbserver=MPDC;";
		//URL += "gdbname=MPDC;user=mpdc;password=zdmpdc;";
		//URL += "layername=D370112DC2009GDLTB;layertype=30;";
		//URL += "clipregion=39516261.27,4055965.09,39516545.13,4055875.04,39516413.97,4055455.13,39515110.54,4055469.82,39516261.27,4055965.09;";
		//URL += "radius=0.0001;";
		//URL += "isnetdata=true;";
		//URL += "isrecalculate=true;";
		//URL += "clipflag=3";
		List<Map<String, Object>> responseList = new ArrayList<Map<String,Object>>();
		HttpClient httpClient = new HttpClient();
		GetMethod getMethod = new GetMethod(URL.toString());
		getMethod.getParams().setParameter(HttpMethodParams.RETRY_HANDLER, new DefaultHttpMethodRetryHandler());
		int statusCode;
		
		try {
			statusCode = httpClient.executeMethod(getMethod);
			//获取失败时
			if(statusCode != HttpStatus.SC_OK){
				String msg = UtilFactory.getJSONUtil().format("Method failed" + getMethod.getStatusLine());
			}else{
				InputStream in = (InputStream) getMethod.getResponseBodyAsStream();
				//测试用时读取固定文本
				//File file = new File("D:\\WPS2.XML");
				//InputStream in = new FileInputStream(file);
				
				SAXBuilder builder = new SAXBuilder(false);
				Document resDocument = builder.build(in);
				Element featureCollection = resDocument.getRootElement();
				Namespace rootSpace = featureCollection.getNamespace("gmi");
				Namespace childSpace = featureCollection.getNamespace("http://www.mapgis.com.cn");
				List<Element> featureList = featureCollection.getChildren("featureMember", rootSpace);
				String[] name = showName.split(",");
				for(int i = 0; i < name.length; i++){
					String realName = name[i];
					String realValue = "0";
					String realNum = "0";
					Set<String> needSet = getNumConfig(realName);
					Map<String, Object> responseMap = new TreeMap<String, Object>();
					for(Element feature : featureList){
						realNum = feature.getChild("地类编码", childSpace).getValue();
						if(needSet.contains(realNum) || needSet.contains("all")){
							String realarea = feature.getChild("图斑面积", childSpace).getValue();
							realValue =String.valueOf( Float.parseFloat(realValue) + Float.parseFloat(realarea));
						}
					}
					responseMap.put("SXM", realName);
					responseMap.put("SXZ", realValue);
					responseList.add(responseMap);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return responseList;
	}
	
	/**
	 * 
	 * <br>Description:获取参数配置
	 * <br>Author:黎春行
	 * <br>Date:2012-10-12
	 * @param yw_flag
	 */
	private void changeConfig(String yw_flag) {
		String sql = "select * from gis_overlay where use_flags = ?";
		Object[] args = {yw_flag};
		List<Map<String, Object>> resultList = query(sql, CORE, args);
		//因use_flags唯一，故获取的结果应唯一
		if(resultList.size() > 0){
			Map<String, Object> resultMap = resultList.get(0);
			gdbserver = String.valueOf(resultMap.get("gdbserver"));
			gdbname = String.valueOf(resultMap.get("gdbname"));
			username = String.valueOf(resultMap.get("username"));
			password = String.valueOf(resultMap.get("password"));
			layername = String.valueOf(resultMap.get("layername"));
			layertype = String.valueOf(resultMap.get("layertype"));
			isnetdata = String.valueOf(resultMap.get("isnetdata"));
			isrecalculate = String.valueOf(resultMap.get("isrecalculate"));
			clipflag = String.valueOf(resultMap.get("clipflag"));
			radius = String.valueOf(resultMap.get("radius"));
			ipLocation = String.valueOf(resultMap.get("ipLocation"));
			showName = String.valueOf(resultMap.get("showname"));
		}
	}
	
	/**
	 * 
	 * <br>Description:获取对应的num
	 * <br>Author:黎春行
	 * <br>Date:2012-11-19
	 * @param name
	 */
	private Set<String> getNumConfig(String name){
		String sql = "select * from gis_overlay_value where overlayname = ?";
		Object[] args = {name};
		List<Map<String, Object>> resultList = query(sql, CORE, args);
		Set<String> returnNum = new HashSet<String>() ;
		if(resultList.size() > 0){
			String[] returnvalue = String.valueOf(resultList.get(0).get("overlayvalue")).split(",");
			for(int i = 0; i < returnvalue.length; i++){
				returnNum.add(returnvalue[i]);
			}
		}
		return returnNum;
	}
}
