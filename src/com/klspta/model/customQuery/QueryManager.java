package com.klspta.model.customQuery;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.util.Region;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;


public class QueryManager extends AbstractBaseBean{
	private static QueryManager instance=new QueryManager();
	private String columnsCode;
	private Map<String,List<QueryCondition>> userQuery;
	
	private Map<String,String> columsData;
	private QueryManager()
	{
		userQuery=new HashMap<String, List<QueryCondition>>();
		buildUserQuery();
	}
	public static QueryManager getInstance()
	{
		return instance;
	}
	/**
	 * 
	 * <br>Description:插入查询条件
	 * <br>Author:任宝龙
	 * <br>Date:2012-8-7
	 * @param qc
	 */
	public void insertQuery(QueryCondition qc)
	{
		String sql="insert into custiomQuery(USERID,STATISTICNAME,STATISTICVALUE) values(?,?,?)";
		update(sql,YW,new Object[]{qc.getUserId(),qc.getStatisticsName(),qc.getStatisticsValue()});
		userQuery.get(qc.getUserId()).add(qc);
	}
	/**
	 * 
	 * <br>Description:修改查询条件
	 * <br>Author:任宝龙
	 * <br>Date:2012-8-7
	 * @param qc
	 * @param oldQueryName
	 */
	public void updateQuery(QueryCondition qc,String oldQueryName)
	{
		String sql="update custiomQuery set statisticName=?,statisticValue=? where userId=? and statisticName=?";
		update(sql,YW,new Object[]{qc.getStatisticsName(),qc.getStatisticsValue(),qc.getUserId(),oldQueryName});
	}
	/**
	 * 
	 * <br>Description:删除查询条件
	 * <br>Author:任宝龙
	 * <br>Date:2012-8-7
	 * @param qc
	 */
	public void deleteQuery(QueryCondition qc)
	{
		String sql="delete from custiomQuery where userId=? and statisticName=?";
		update(sql,YW,new Object[]{qc.getUserId(),qc.getStatisticsName()});
		userQuery.get(qc.getUserId()).remove(qc);
	}
	/**
	 * 
	 * <br>Description:将用户的查询条件保存到内存中
	 * <br>Author:任宝龙
	 * <br>Date:2012-8-7
	 */
	public void buildUserQuery()
	{
		String sql="select userId,statisticName,statisticValue from custiomQuery";
		List<Map<String,Object>> list=query(sql, YW);
		QueryCondition queryCondition;
		for(Map<String, Object> map:list)
		{
			queryCondition=new QueryCondition(map);
			if(!userQuery.containsKey(queryCondition.getUserId()))
				userQuery.put(queryCondition.getUserId(), new ArrayList<QueryCondition>());
			userQuery.get(queryCondition.getUserId()).add(queryCondition);	
		}
	 
	}
	/**
	 * 
	 * <br>Description:根据查询名称获取查询条件bean
	 * <br>Author:任宝龙
	 * <br>Date:2012-8-7
	 * @param qc
	 * @return
	 */
	public QueryCondition containQuery(QueryCondition qc)
	{
		List<QueryCondition> list=userQuery.get(qc.getUserId());
		if(list==null)
			list=new ArrayList<QueryCondition>();

		for(QueryCondition q:list)
		{
			if(q.getStatisticsName().equals(qc.getStatisticsName()))
				return q;
		}
		return null;
	}

	/**
	 * <br>Description:保存用户查询条件
	 * <br>Author:任宝龙
	 * <br>Date:2012-6-20
	 * @param list
	 */
	public void saveUserQuery(List<QueryCondition> list,String userId)
	{
		String deleteSql="delete from custiomQuery where userid=?";
		update(deleteSql, YW,new Object[]{userId});
		StringBuffer sql=new StringBuffer("insert into custiomQuery(statisticsid,statisticName,statisticValue,userId) (");
		Object[] args=new Object[list.size()*4];
		
		int i=0;
		for(QueryCondition qc:list)
		{
			sql.append("select ?,?,?,? from dual union all ");
			args[i++]=getQueryConditionID();
			args[i++]=qc.getStatisticsName();
			args[i++]=qc.getStatisticsValue();
			args[i++]=userId;
		}
		String sql2=sql.substring(0, sql.length()-10)+")";
		update(sql2,YW,args);
		
		userQuery.remove(userId);
		userQuery.put(userId, list);
		
	}
	/**
	 * 
	 * <br>Description:生成id
	 * <br>Author:任宝龙
	 * <br>Date:2012-8-7
	 * @return
	 */
	private String getQueryConditionID()
	{		
		return new Date().getTime()+""+new Random().nextInt(1000)+"";
	}
	/**
	 * 
	 * <br>Description:生成查询字段的列表
	 * <br>Author:任宝龙
	 * <br>Date:2012-8-7
	 * @return
	 */
	private String buildColumnsCode()
	{
		StringBuffer columsCode=new StringBuffer();
    	Map<String, String> colums=getColumnsData();
    	int index=0;
    	for(String column:colums.keySet())
    	{  	
    		columsCode.append("<li><input type='checkbox' name='column' id='c"+index+"' value='");
    		columsCode.append(column);
    		columsCode.append("'><span onclick='selectCheck(\"c"+index+"\")'>");		
    		columsCode.append(colums.get(column));
    		columsCode.append("</span></li>");
    		index++;
    	}
		return columsCode.toString();
	}
	/**]
	 * 
	 * <br>Description:建立表字段键值对
	 * <br>Author:任宝龙
	 * <br>Date:2012-8-7
	 * @return
	 */
	public Map<String, String> getColumnsData()
	{
		if(columsData==null)
		{
			columsData=new HashMap<String, String>();//WFXSDJBL 
			String sql="SELECT COLUMN_NAME,COMMENTS FROM USER_COL_COMMENTS WHERE TABLE_NAME = 'XCTJ'";
			//String sql="SELECT COLUMN_NAME,COMMENTS FROM USER_COL_COMMENTS WHERE TABLE_NAME = 'WFXSDJBL' order by COLUMN_NAME";
	    	List<Map<String, Object>> list=query(sql,super.YW);
	    	String comment;
	    	for(Map<String,Object> map:list)
	    	{
	    		comment=(String)map.get("COMMENTS");
	    		if(comment.charAt(0)=='.')
	    			continue;
	    		if(comment.indexOf(',')!=-1)
	    			comment=comment.substring(0,comment.lastIndexOf(','));

	    		columsData.put((String)map.get("COLUMN_NAME"),comment);
	    	}
		}
		return  columsData;
	}
	/**
	 * 
	 * <br>Description:获取字段列表
	 * <br>Author:任宝龙
	 * <br>Date:2012-8-7
	 * @return
	 */
	public String getColumnsCode()
	{
		if(columnsCode==null)
			columnsCode=buildColumnsCode();
		return columnsCode;
	}
	/**
	 * 
	 * <br>Description:获取查询数据集
	 * <br>Author:任宝龙
	 * <br>Date:2012-8-7
	 * @param startTime
	 * @param endTime
	 * @param columns
	 * @return
	 */
	public List<Map<String, Object>> getQueryList(String startTime,String endTime,String columns)
	{	
		startTime=startTime.length()>10?startTime:startTime+" 00:00:00";
		endTime=endTime.length()>10?endTime:endTime+" 23:59:59";
		
		//String sql="select "+columns+" from WFXSDJBL where (DJRQ between to_date('"+startTime+"','yyyy-mm-dd hh24:mi:ss') and to_date('"+endTime+"','yyyy-mm-dd hh24:mi:ss' ))  order by DJRQ";
		String sql="select "+columns+" from xctj  order by shijian";
		return  zhejiang(query(sql, super.YW),columns);
	}
	/**
	 * 
	 * <br>Description:浙江项目临时方法 ，用于过滤字段
	 * <br>Author:任宝龙
	 * <br>Date:2012-8-7
	 * @param list
	 * @param columns
	 * @return
	 */
	public List<Map<String, Object>> zhejiang(List<Map<String, Object>> list,String columns)
	{
		String[] column=columns.split(",");
		String col;
		double sum=0;
		Map<String, Object> map=new HashMap<String, Object>();
		for(int i=0;i<column.length;i++)
		{
			col= column[i];
			if("TUBN".equals(col)||"CISHU".equals(col)||"WEIFAGE".equals(col)||"MIANJI".equals(col))
			{
				for(Map<String, Object> obj:list)
				{
					sum+=obj.get(col)==null?0:Double.parseDouble(obj.get(col).toString());
				}
				map.put(col, "合计 ："+sum);
				sum=0;
			}

		}
		list.add(map);
		return list;
		
	}
	/**
	 * 
	 * <br>Description:获取查询结果并建立html
	 * <br>Author:任宝龙
	 * <br>Date:2012-8-7
	 * @param startTime
	 * @param endTime
	 * @param columns
	 * @return
	 */
	public Map<String,String> getQueryData(String startTime,String endTime,String columns)
	{
		List<Map<String, Object>> data=getQueryList(startTime,endTime,columns);
		String[] columnNames=columns.split(",");
		
		Map<String,String> dataCode=new HashMap<String, String>();
		StringBuffer queryData=new StringBuffer();
		queryData.append("<tr style='background-color:#A0C6F7;'>");
		Map<String, String> columnsData=getColumnsData();
		//表头
		for(String columnName:columnNames)
		{
			queryData.append("<td>");
			queryData.append(columnsData.get(columnName));
			queryData.append("</td>");
		}
		queryData.append("</tr>");
		dataCode.put("column",queryData.toString());
		
		queryData=new StringBuffer();
		//数据
		for(Map<String,Object> map:data)
		{
			queryData.append("<tr>");
			for(String columnName:columnNames)
			{
				queryData.append("<td>");
				queryData.append(getValueData(columnName,map.get(columnName)+"","&nbsp"));
				queryData.append("</td>");		
			}
			queryData.append("</tr>");
		}
	
		dataCode.put("data",queryData.toString());
		return dataCode;
	}
	/**
	 * 
	 * <br>Description:获取查询结果的输出流
	 * <br>Author:任宝龙
	 * <br>Date:2012-8-7
	 * @param startTime
	 * @param endTime
	 * @param columns
	 * @param queryName
	 * @return
	 */
	public ByteArrayOutputStream getReportData(String startTime,String endTime,String columns,String queryName)
	{
		HSSFWorkbook excel=new HSSFWorkbook();
		HSSFSheet sheet=excel.createSheet();
		HSSFRow row;
		HSSFCell cell;
		List<Map<String, Object>> data=getQueryList(startTime,endTime,columns);
		Map<String, String> columnsData=getColumnsData();
		String[] columnNames=columns.split(",");
		
		HSSFCellStyle style=excel.createCellStyle();
		HSSFFont font=excel.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontHeight((short)400);
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		
		row=sheet.createRow(0);
		row.setHeight((short)800);
		
		sheet.addMergedRegion(new Region(0,(short)0,0,(short)(columnNames.length-1)));
		
		cell=row.createCell(0);
		cell.setCellValue(queryName);
		cell.setCellStyle(style);
		
		HSSFCellStyle style2=excel.createCellStyle();
		HSSFFont font2=excel.createFont();
		font2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		style2.setFont(font2);
		style2.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		
		row=sheet.createRow(1);
		row.setHeight((short)450);
		for(int i=0;i<columnNames.length;i++)
		{
			sheet.setColumnWidth(i,4500);//单位是1/20点。。。
			cell=row.createCell(i);
			cell.setCellValue(columnsData.get(columnNames[i]));
			cell.setCellStyle(style2);
		}
		int length=data.size();
		Map<String,Object> map;
		for(int i=0;i<length;i++)
		{
			map=data.get(i);
			row=sheet.createRow(i+2);
			for(int j=0;j<columnNames.length;j++)
			{
				cell=row.createCell(j);
				cell.setCellValue(getValueData(columnNames[j],map.get(columnNames[j])+"",""));
			}
		}
		ByteArrayOutputStream output=new ByteArrayOutputStream();
		try {
			excel.write(output);
		} catch (IOException e) {
		}		
		return output;
	}
	/**
	 * 
	 * <br>Description:输出数据过滤
	 * <br>Author:任宝龙
	 * <br>Date:2012-8-7
	 * @param columnName
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	private String getValueData(String columnName,String value,String defaultValue)
	{
		if("null".equals(value))
			return defaultValue;
		if("NM".equals(columnName)||"FYQKDC".equals(columnName)||"SFLA".equals(columnName)||"BJ".equals(columnName))
		{
			value=("1").equals(value)?"是":"否";
		}
		else if("BLFS1".equals(columnName)||"BLFS2".equals(columnName)||"BLFS3".equals(columnName))
		{
			if("1".equals(value))
				value="直接转办";
			else if("2".equals(value))
				value="建议作为重大违法案件线索";
		}

		else if("WFLX".equals(columnName))
		{
			if("1".equals(value))
				value="土地违法";
			else if("2".equals(value))
				value="矿产违法";
		}
		else if("XJLX".equals(columnName))
		{
			if("1".equals(value))
				value="一般信件";
			else if("2".equals(value))
				value="挂号信";
			else if("3".equals(value))
				value="特别挂号信";
		}
		else if("JBRDZ1".equals(columnName)||"JBRDZ2".equals(columnName)||"JBRDZ3".equals(columnName)||"JBRDZ4".equals(columnName)||"WTFSD1".equals(columnName)||"WTFSD2".equals(columnName)||"WTFSD3".equals(columnName)||"WTFSD4".equals(columnName)||"WTFSD5".equals(columnName))
		{
			if("请选择".equals(value))
				value=defaultValue;
			else
			    value=UtilFactory.getXzqhUtil().getNameByCode(value);
		}
		else if("WTFSD6".equals(columnName))
		{
			if("请选择".equals(value))
				value=defaultValue;
		}
		
		//浙江
		
		else if("SHIJIAN".equals(columnName))
		{
			if("".equals(value))
				return defaultValue;
			else
			{

				
				return value.toString().substring(0,10);
			}
		}

		return value;
	}
	/**
	 * 
	 * <br>Description:根据用户id获取查询条件集
	 * <br>Author:任宝龙
	 * <br>Date:2012-8-7
	 * @param userId
	 * @return
	 */
	public String getQueryCOnditionByUserId(String userId)
	{
		if(!userQuery.containsKey(userId))
			return "";
		StringBuffer queryConditionCode=new StringBuffer();
		List<QueryCondition> list=userQuery.get(userId);
		for(QueryCondition qc:list)
		{
			queryConditionCode.append("<option value='");
			queryConditionCode.append(qc.getStatisticsValue());
			queryConditionCode.append("'>");
			queryConditionCode.append(qc.getStatisticsName());
			queryConditionCode.append("</option>");
		}
		return queryConditionCode.toString();
	}

}
