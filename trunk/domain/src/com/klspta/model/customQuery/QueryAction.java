package com.klspta.model.customQuery;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.util.bean.xzqhutil.XzqhBean;
import com.klspta.web.jinan.report.ReportBean;
import com.mysql.jdbc.Util;

public class QueryAction extends AbstractBaseBean {
	/**
	 * 
	 * <br>
	 * Description:获取查询结果 <br>
	 * Author:任宝龙 <br>
	 * Date:2012-8-7
	 */
	public void getQueryData() {
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String columns = request.getParameter("columns");
		Map<String, String> data = QueryManager.getInstance().getQueryData(startTime, endTime, columns);
		clearParameter();
		putParameter(data);
		response();

	}

	/**
	 * 
	 * <br>
	 * Description:导出成excel <br>
	 * Author:任宝龙 <br>
	 * Date:2012-8-7
	 */
	public void report() {
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String columns = request.getParameter("columns");

		// String
		// data=QueryManager.getInstance().downloadExcel(startTime,endTime,columns);

		ServletOutputStream out = null;
		ByteArrayOutputStream output = null;
		try {

			String fileName = new String(request.getParameter("queryName").getBytes("ISO-8859-1"), "UTF-8");
			output = QueryManager.getInstance().getReportData(startTime, endTime, columns, fileName);
			// response.setCharacterEncoding("UTF-8");
			fileName = new String(fileName.getBytes(), "ISO-8859-1");
			response.setContentType("application/x-msdownload");
			// response.setContentLength();
			response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ".xls");
			out = response.getOutputStream();
			
			out.write(output.toByteArray());
		} catch (IOException e) {
		} finally {
			try {
				out.flush();
				out.close();
				output.close();
			} catch (IOException e) {

			}

		}
	}

	/**
	 * 
	 * <br>
	 * Description:保存查询条件 <br>
	 * Author:任宝龙 <br>
	 * Date:2012-8-7
	 */
	public void save() {
		String queryName = null;
		String oldQueryName = null;
		try {
			queryName = new String(request.getParameter("queryName").getBytes("ISO-8859-1"), "utf-8");
			oldQueryName = new String(request.getParameter("oldQueryName").getBytes("ISO-8859-1"), "utf-8");
		} catch (UnsupportedEncodingException e2) {
		}

		String userId = request.getParameter("userId");
		String columnses = request.getParameter("columns");
		if (columnses.indexOf("SHIJIAN") != -1) {
			columnses = "SHIJIAN," + columnses.replace("SHIJIAN,", "");
			System.out.println(columnses);
		}

		QueryCondition qc = new QueryCondition(userId, oldQueryName, columnses);

		QueryCondition oldQc = QueryManager.getInstance().containQuery(qc);

		qc.setStatisticsName(queryName);
		if (oldQc == null) {
			QueryManager.getInstance().insertQuery(qc);
		} else {
			QueryManager.getInstance().updateQuery(qc, oldQueryName);
			oldQc.setStatisticsName(queryName);
			oldQc.setStatisticsValue(columnses);
		}
		try {
			response.getWriter().write("{success:true,msg:true}");
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	/**
	 * 
	 * <br>
	 * Description:删除查询条件 <br>
	 * Author:任宝龙 <br>
	 * Date:2012-8-7
	 */
	public void delete() {
		String queryName = null;
		try {
			queryName = new String(request.getParameter("queryName").getBytes("ISO-8859-1"), "utf-8");
		} catch (UnsupportedEncodingException e2) {
		}

		String userId = request.getParameter("userId");
		String columnses = request.getParameter("columns");

		QueryCondition qc = new QueryCondition(userId, queryName, columnses);

		QueryCondition oldQc = QueryManager.getInstance().containQuery(qc);
		try {
			if (oldQc != null) {
				QueryManager.getInstance().deleteQuery(oldQc);
				response.getWriter().write("{success:true,msg:true}");
			} else
				response.getWriter().write("{failure:true,msg:true}");

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void getXxhzbData() {
		String time = request.getParameter("time");
		String district="";
		try
		{
			district = new String(request.getParameter("district").getBytes("ISO-8859-1"), "utf-8");
		} catch (UnsupportedEncodingException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(time+"     "+ district);
		
		Map<String, String> map=new HashMap<String, String>();
	
		String[] sql =new String[5];
		
		sql[0]="select count(t.立案编号) as 查处违法用地总宗数,sum(t.总面积) as 查处违法用地总面积,sum(t.耕地面积) as 占用耕地面积,sum(t.其中基本农田) as  其中查处基本农田面积 ,sum(t.符合规划面积) as 符合规划面积,sum(t.不符合规划面积) as 符合规划面积  from 基表 t where t.案件年度时间 like '%"+time+"%' and t.案件区域='"+district+"' ";	
		sql[1]="select count(t1.立案编号) as 下达处罚宗数  from  基表 t1 where t1.案件年度时间 like '%"+time+"%' and t1.案件区域='"+district+"' and t1.立案编号 in (select cft.立案编号 from 处罚信息表 cft)";
		sql[2]="select sum(cftt.拆除建筑物面积) as 应拆除建筑面积,sum(cftt.没收建筑物面积) as 应没收建筑面积,sum(cftt.罚款金额) as 应收罚款金额 from 处罚信息表 cftt  where cftt.立案编号 in( select t1.立案编号 from  基表 t1 where t1.案件年度时间 like '%"+time+"%' and t1.案件区域='"+district+"')";
		sql[3]="select sum(lscftt.拆除建筑物面积) as 已拆除建筑面积 ,sum(lscftt.没收建筑物面积) as 已没收建筑面积,sum(lscftt.罚款金额) as 已收缴罚款金额 from 落实处罚信息表 lscftt where lscftt.立案编号 in( select t1.立案编号 from  基表 t1 where t1.案件年度时间 like '%"+time+"%' and t1.案件区域='"+district+"')";
		sql[4]="select cfqkb.处分类型,count(cfqkb.立案编号) as 处分人数 from 落实处分人基本情况表 cfqkb where cfqkb.立案编号 in ( select t1.立案编号 from  基表 t1 where t1.案件年度时间 like '%"+time+"%' and t1.案件区域='"+district+"') group by( cfqkb.处分类型)";

		
		
		Map<String, Object> result;
		
		for(int i=0;i<sql.length;i++)
		{   
			
			
			if(i!=4)
			{
				result = query(sql[i], GTJC).get(0);
				for(String str:result.keySet())
				{
					map.put(str, result.get(str)==null?"0":result.get(str).toString());
				}
			}
			else
			{
				List<Map<String, Object>> resultList=query(sql[i], GTJC);
				
				if(resultList.size()==0)
				{
					map.put("移送公安机关","0");
					map.put("移送纪检部门","0");
					break;
				}
				
				if("行政处分".equals((String)resultList.get(0).get("处分类型")))
				{
					map.put("移送纪检部门",resultList.get(0).get("处分人数").toString());
					if(resultList.size()>1)
						map.put("移送公安机关",resultList.get(1).get("处分人数").toString());
				}
				else
				{
					
					map.put("移送公安机关",resultList.get(0).get("处分人数").toString());
					if(resultList.size()>1)
						map.put("移送纪检部门",resultList.get(1).get("处分人数").toString());
				}
				
			}
			
	
		}
		Map<String,Object> resultMap;
		List<Map<String, Object>> data=new ArrayList<Map<String,Object>>();
		for(String key:map.keySet())
		{
			resultMap=new HashMap<String, Object>();
			resultMap.put("key", key);
			resultMap.put("value",map.get(key));
			data.add(resultMap);
			
		}
//		
		
		
//	List<XzqhBean> list= UtilFactory.getXzqhUtil().getChildListByParentId("370100");
//	for(XzqhBean b:list)
//	{
//		System.out.println(b.get);
//	}
//		Map<String, Object> resultMap = result.get(0);
//
//		List<Map<String, Object>> data = new ArrayList<Map<String, Object>>();
//		Map<String, Object> map = null;
//
//		String zzs = resultMap.get("zzs").toString();
//		map = new HashMap<String, Object>();
//		map.put("key", "查处违法用地总宗数");
//		map.put("value", zzs);
//		data.add(map);
//
//		String wfmj = resultMap.get("wfmj").toString();
//		map = new HashMap<String, Object>();
//		map.put("key", "查处违法用地总面积（亩数、公顷数）");
//		map.put("value", wfmj);
//		data.add(map);
		
		response(data);
	}
	public static void main(String[] args)
	{
		new QueryAction().getXxhzbData();
	}
}
