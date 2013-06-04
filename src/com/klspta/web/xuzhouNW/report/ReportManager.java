package com.klspta.web.xuzhouNW.report;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import jxl.CellView;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.util.Region;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.util.bean.xzqhutil.XzqhBean;
import com.klspta.console.ManagerFactory;
import com.klspta.console.role.Role;
import com.klspta.console.user.User;

public class ReportManager extends AbstractBaseBean
{
	private Map<String,ReportBean> reportIdMap;
	private static ReportManager instance=new ReportManager();
	private ReportManager()
	{
		bulidList();
	}
	public static ReportManager getInstance()
	{
		return instance;
	}
	private void bulidList()
	{
		reportIdMap=new HashMap<String, ReportBean>();
		String sql="select * from wfajtj";
		List<Map<String,Object>> list=query(sql,this.YW);
		ReportBean report;
		String tzgzsSQL = "select t.file_bh as tzgzsbh from atta_accessory t where t.yw_guid = ? and t.file_name like '%听证告知书%'";
		String cfgzsSQL = "select t.file_bh as cfgzsbh from atta_accessory t where t.yw_guid = ? and t.file_name like '%处罚告知书%'";
		Map<String,Object> map =null;
		List<Map<String,Object>> tzgzslist= null;
		List<Map<String,Object>> cfgzslist=null;
		for(int i=0;i<list.size();i++)
		{
			tzgzslist = query(tzgzsSQL, CORE,new Object[]{list.get(i).get("yw_guid")});
			cfgzslist = query(cfgzsSQL, CORE,new Object[]{list.get(i).get("yw_guid")});
			map = list.get(i);
			if(tzgzslist.size()>0){
				map.put("TZGZSBH", tzgzslist.get(0).get("tzgzsbh").toString());
			}
			if(cfgzslist.size()>0){
				map.put("CFGZSBH", cfgzslist.get(0).get("cfgzsbh").toString());
			}
		
			report=new ReportBean(map);
			reportIdMap.put(report.getTZID(), report);
		}
	}
	public int getState(String userId) throws Exception
	{
		List<Role> roleList=ManagerFactory.getRoleManager().getRoleWithUserID(userId);
		int state=0;
		for(Role role: roleList)
		{
			if(role==null)
				continue;
			if("556c467b831d31528a8cc54e98f65751".equals(role.getParentroleid()))
			{
				if(state<1)
					state=1;
			}
			else if("21f3fd149fb49b7325d29a0a353350d5".equals(role.getParentroleid()))
			{
				if(state<2)
					state=2;
			}
			else if("综合处统计员".equals(role.getName()))
			{
				return state=3;
			}
			else if(role.getXzqh().indexOf("370100")!=-1)
			{
				if(state<4)
					state=4;
			}
		}	
		return state;
	}
	public String getRoleName(String userId) throws Exception
	{
		List<Role> roleList=ManagerFactory.getRoleManager().getRoleWithUserID(userId);
		int state=0;
		String roleName="";
		for(Role role: roleList)
		{
			if("556c467b831d31528a8cc54e98f65751".equals(role.getParentroleid()))
			{
				if(state<1)
					state=1;
			
			}
			else if("21f3fd149fb49b7325d29a0a353350d5".equals(role.getParentroleid()))
			{
				if(state<2)
					state=2;
				
			}
			else if("综合处统计员".equals(role.getName()))
			{
				state=3;
				return role.getName();
			}
			else if(role.getXzqh().indexOf("370100")!=-1)
			{
				if(state<4)
					state=4;
			}
			roleName=role.getName();
		}	
		return roleName;
	}
	
	
	public void updateAllField(ReportBean bean)
	{
		StringBuffer sql=new StringBuffer("update  wfhdtz set ");
		Map<String, Object> map=bean.getMap();
		List<Object> parameters=new ArrayList<Object>();
		Object obj;
		for(String key:map.keySet())
		{
			if("SAVETIME".equals(key))
				continue;
			obj=map.get(key);
			if(obj!=null&&!("".equals(obj.toString())))
			{
				sql.append(key);
				sql.append("=?,");
				parameters.add(map.get(key));
			}
		
		}
		String sqlStr=sql.substring(0, sql.length()-1)+" where TZID=?";
		parameters.add(bean.getTZID());
		update(sqlStr, YW,parameters.toArray());
	}

	public void delete(String id)
	{
		String sql="delete from wfhdtz where TZID=?";
		update(sql, YW,new Object[]{id});
		reportIdMap.remove(id);
	}
	private Set<String> getAreaSet(String userId)
	{
		Set<String> set=new HashSet<String>();
		try
		{
			List<Role> roles = ManagerFactory.getRoleManager().getRoleWithUserID(userId);
	
			String xzqh;
			for(Role role:roles)
			{
				xzqh=role.getXzqh();
				if(!"".equals(xzqh))
				{
					for(String str:xzqh.split(","))
					{
						set.add(str);
					}
				}
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return set;
	}
	public String getAreaStr(String userId)
	{
		StringBuffer areas=new StringBuffer();
		for(String str:getAreaSet(userId))
		{
			if("370100".equals(str))
			{
				List<XzqhBean> xzqhList=UtilFactory.getXzqhUtil().getChildListByParentId("370100");
				areas=new StringBuffer();
				for(XzqhBean bean:xzqhList)
				{
					areas.append(bean.getCatonname());
					areas.append(",");
				}
				break;
			}			
			areas.append(UtilFactory.getXzqhUtil().getNameByCode(str));
			areas.append(",");
			
		}
		
		String result="";
		if(areas.length()>0)
			result=areas.substring(0, areas.length()-1);
		return result;
	}
	public String getAreaCheckCode(String userId)
	{
		
		StringBuffer code=new StringBuffer();	
		String area;
		for(String str:getAreaSet(userId))
		{
			area=UtilFactory.getXzqhUtil().getNameByCode(str);
			code.append("<li><input type=\"checkbox\" name=\"area\" checked=\"true\" value=\"");
			code.append(area);
			code.append("\">");
			code.append(area);
			code.append("</li>");
		}	
		
		return code.toString();
	}
	
	public String getAreaSelectCode(String userId)
	{
		StringBuffer code=new StringBuffer();	
		String area;
		for(String str:getAreaSet(userId))
		{
			area=UtilFactory.getXzqhUtil().getNameByCode(str);
			if("济南市".equals(area))
			{
				List<XzqhBean> xzqhList=UtilFactory.getXzqhUtil().getChildListByParentId("370100");
				code=new StringBuffer();
				for(XzqhBean bean:xzqhList)
				{
					code.append("<option value='");
					code.append(bean.getCatonname());
					code.append("'>");
					code.append(bean.getCatonname());
					code.append("</option>");
				}
						
				return code.toString();
			}
			code.append("<option value='");
			code.append(area);
			code.append("'>");
			code.append(area);
			code.append("</option>");			
		}	
		return code.toString();
		
	}

	public Map<String,String> getAreaSelectCodeMap(String userId)
	{
		
		Map<String,List<String>> map=new HashMap<String, List<String>>();
		String area;
		for(String str:getAreaSet(userId))
		{
			area=UtilFactory.getXzqhUtil().getNameByCode(str);
			if("济南市".equals(area))
			{
				map.clear();
				List<String> list=new ArrayList<String>();
				List<XzqhBean> xzqhList=UtilFactory.getXzqhUtil().getChildListByParentId("370100");
				for(XzqhBean bean:xzqhList)
					list.add(bean.getCatonname());				
				map.put("济南市",list);
				
				break;
			}
			else if(area.indexOf("区")!=-1)
			{
				if(!map.containsKey("市本级"))
					map.put("市本级", new ArrayList<String>());
				map.get("市本级").add(area);
			}
			else if(area.indexOf("县")!=-1||area.indexOf("市")!=-1)
			{
				if(!map.containsKey("县(市)"))
					map.put("县(市)", new ArrayList<String>());
				map.get("县(市)").add(area);
				
			}	
		}
		Map<String, String> codemap=new HashMap<String, String>();
		StringBuffer cityCode=new StringBuffer("[");
		StringBuffer areaCode=new StringBuffer("[");
		int index;
		for(String key:map.keySet())
		{
			cityCode.append("'");
			cityCode.append(key);
			cityCode.append("',");
			areaCode.append("[");
			index=0;
			for(String ca:map.get(key))
			{
				if(index!=0)
					areaCode.append(",");
				areaCode.append("'");
				areaCode.append(ca);
				areaCode.append("'");
				index++;			
			}
			areaCode.append("],");	
		}
		codemap.put("city",cityCode.substring(0,cityCode.length()-1)+"]");
		codemap.put("area",areaCode.substring(0,areaCode.length()-1)+"]");	
		return codemap;
		
	}
	public void insertRecord(ReportBean bean)
	{
		StringBuffer sql=new StringBuffer("insert into wfhdtz(");
		StringBuffer values=new StringBuffer("(");
		Map<String, Object> map=bean.getMap();
		List<Object> parameters=new ArrayList<Object>();
		Object obj;
		
		for(String key:map.keySet())
		{
			obj=map.get(key);
			if(obj!=null&&!("".equals(obj.toString())))
			{
				sql.append(key);
				sql.append(",");
				values.append("?,");
				parameters.add(obj);
			}
		}
		
		Date date=new Date(new java.util.Date().getTime());
		bean.setSAVETIME(date);
		bean.getMap().put("SAVETIME",date);
	
		String sqlStr=sql.substring(0, sql.length()-1)+") values"+values.substring(0, values.length()-1)+")";
		update(sqlStr, YW,parameters.toArray());
		reportIdMap.put(bean.getTZID(), bean);
		
	}
	private List<Map<String,Object>> getReportBeanByCondition(String beginDate,String endDate,String area)
	{
		return getReportBeanByCondition(beginDate,endDate, area,0);
	}
	
	private int[] days={31,28,31,30,31,30,31,31,30,31,30,31};
	public List<Map<String,Object>> getReportBeanByCondition(String beginDate,String endDate,String area,int status)
	{

		StringBuffer sql=new StringBuffer("select t.tzid ");
		
		StringBuffer where=new StringBuffer(" where ");
		String whereStr="";
		boolean isOrder=true;;
		List<Object> parameters=new ArrayList<Object>();
		if(!"".equals(beginDate))
		{
			
			if("".equals(endDate))
				endDate=beginDate;
			beginDate=beginDate+"-1";
			String[] endDates=endDate.split("-");
			if(endDates.length==2)
			{
				int month=Integer.parseInt(endDates[1]);
				if(month==2)
				{
					int year=Integer.parseInt(endDates[0]);
					if((year%4==0&&year%100!=0)||year%400==0)
						endDate+="-29";
					else
						endDate+="-28";
				}
				else
				{
					month--;
					endDate= endDate+"-"+days[month];
				}
			}
			where.append("(t.LARQ between '"+beginDate+"' and '"+endDate+"') and ");
		}
	
		
			where.append(" t.szqy in (");
			String[] areaStrs=area.split(",");
			
			for(int i=0;i<areaStrs.length;i++)
			{
				where.append("?,");
				parameters.add(areaStrs[i]);
			}
			whereStr=where.substring(0,where.length()-1)+")";
		sql.append(" from wfajtj t ");
		if(parameters.size()==0)
		{
		
			return query(sql.toString(),YW);
		}
		else
		{
			
			sql.append(whereStr);			
			return query(sql.toString(),YW,parameters.toArray());
		}
	}
	
	private  List<ReportBean> getBeanByMap(List<Map<String,Object>>  data)
	{
		List<ReportBean> list=new ArrayList<ReportBean>();
		ReportBean reportBean;
		for(Map<String,Object> map:data)
		{
			reportBean=getReportBeanById(map.get("TZID").toString());
			if(reportBean!=null)
				list.add(reportBean);
		}
		return list;
	}
	public String getJsonByCondition(String beginDate,String endDate,String area,int state)
	{
		
		List<ReportBean> list= getBeanByMap(getReportBeanByCondition(beginDate,endDate,area,state));
		List<Map<String,String>> mapList=new ArrayList<Map<String,String>>(); 
		for(ReportBean bean:list)
		{
			mapList.add(bean.getStringMap());
		}
		
		String json="";
		try
		{
			json = UtilFactory.getJSONUtil().objectToJSON(mapList);
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return json;
	}
	public ReoprtZip toExcel(String beginDate,String endDate,String area,String type) throws Exception
	{
		
		String path= this.getClass().getResource("").getPath();
		InputStream input;
		String[] columns;

		input= new BufferedInputStream(new FileInputStream(path+"model.xls"));
		columns=new String[]{"tzid","WFZT","SZQY","MJ","YT","AJLY","AYDJRQ","TZWFTZSBH","TZWFTZSXDRQ","LABH","LARQ","TZGZSBH","TZGZSXDRQ","CFGZSBH","CFGZSXDRQ","CFJDSBH","CFJDSXDRQ","ZLLXTZSBH","ZLLXTZSXDRQ","YSJJBH","YSJJSJ","YSGABH","YSGASJ","QZZXSBH","QZZXSSJ","CWYJSBH","CWYJSSJ","JACPBH","JASJ","WLAYY","QYJGZRR","BZ"};
		
		
		HSSFWorkbook excel=new HSSFWorkbook(input);
		HSSFSheet sheet=excel.getSheetAt(0);

		HSSFRow row;
		HSSFCell cell;
		List<ReportBean> list=getBeanByMap(getReportBeanByCondition(beginDate,endDate,area,5));
	
		HSSFCellStyle style=excel.createCellStyle();
		HSSFFont font=excel.createFont();
		//font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		
	
		CellView cv = new CellView();
		cv.setAutosize(true);
		
		//时间处理
		String beginTime="";
		String endTime="";
		if(!"".equals(beginDate))
		{	
			String[] beginDates=beginDate.split("-");
			beginTime=beginDates[0]+"年"+beginDates[1]+"月";
			endTime="";
			if(!"".equals(endDate))
				endTime=" - "+endDate.split("-")[0]+"年"+endDate.split("-")[1]+"月";
			
		}
		//2012年1—9月违法用地台账	
		row=sheet.getRow(0);
		cell=row.getCell(0);
		String title="徐州市"+beginTime+endTime+"国土资源违法案件台账";
		cell.setCellValue(title);
	
		int i;		
		int length=columns.length;
		int index=7;
		int sequence=1;
		Map<String,String> map;
		for(ReportBean bean:list)
		{
			if(bean==null)
				continue;
			map=bean.getStringMap();
			row=sheet.createRow(index);
			cell=row.createCell(0);
			cell.setCellStyle(style);
			cell.setCellValue(sequence++);
			for(i=1;i<length;i++)
			{
				cell=row.createCell(i);
				cell.setCellStyle(style);				
				cell.setCellValue(map.get(columns[i]));
			}
			index++;
		}
		
		ByteArrayOutputStream output=new ByteArrayOutputStream();		
		excel.write(output);		
		output.close();		
		input.close();
		
		ReoprtZip reportZip=new ReoprtZip();
		reportZip.title=title;
		reportZip.zipout=output;
	
		return reportZip;
	}
	
	public ByteArrayOutputStream collectReport(String beginDate,String endDate,String area) throws Exception
	{
		List<ReportBean> data=getBeanByMap(getReportBeanByCondition(beginDate,endDate,area,5));
		int wfzs=data.size();
		double wfydmj=0;
		double gdmj=0;
		double jbntmj=0;

		double fhghmj=0;
		double bfghmj=0;
		int lazs=data.size();
		int cfzs=0;

		double ysfk=0;
		double usfk=0;
		
		int  cczs=0;
		double ccmj=0;
		double ccgdmj=0;

		int ysjjrs=0;
	 	int ysgars=0;
	 	
	 	int sjysjjrs=0;
	 	int sjysgars=0;
		int sqqzzx=0;
		
		
		double sjmj=0;
		for(ReportBean reportBean:data)
		{
					}

		
		HSSFWorkbook excel=new HSSFWorkbook();
		HSSFSheet sheet=excel.createSheet();
	
		String[] columName={"违法用地宗数","违法用地面积（亩数、公顷数）","其中耕地面积","其中基本农田面积","符合规划面积","不符合规划面积","立案宗数","处罚宗数","应收罚款数","已收缴罚款数","拆除宗数","拆除宗数","其中耕地面积","提出建议移送纪检部门人数","实际移送纪检部门人数","实际移送纪检部门人数","实际移送公安机关人数","实际移送公安机关人数"};
		String[] columValue={wfzs+"",wfydmj+"",gdmj+"",jbntmj+"",fhghmj+"",bfghmj+"",lazs+"", cfzs+"",ysfk+"",usfk+"",cczs+"", ccmj+"", ccgdmj+"",ysjjrs+"",sjysjjrs+"", ysgars+"", sjysgars+"", sqqzzx+""};
		HSSFRow row;
		HSSFCell cell;
		row=sheet.createRow(0);
		
		HSSFCellStyle style=excel.createCellStyle();
		HSSFFont font=excel.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontHeight((short)300);
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		
		row=sheet.createRow(0);
		row.setHeight((short)800);
		
		sheet.addMergedRegion(new Region(0,(short)0,0,(short)(columName.length-1)));
		
		String beginTime="";
		String endTime="";
		if(!"".equals(beginDate))
		{	
			String[] beginDates=beginDate.split("-");
			beginTime=beginDates[0]+"年"+beginDates[1]+"月";
			endTime="";
			if(!"".equals(endDate))
				endTime=" - "+endDate.split("-")[1]+"月";
			
		}
		
		String title=beginTime+endTime+"统计汇总";
		
		
		cell=row.createCell(0);
		cell.setCellValue(title);
		cell.setCellStyle(style);
		
		row=sheet.createRow(1);
		for(int i=0;i<columName.length;i++)
		{
			sheet.setColumnWidth(i,4000);
			cell=row.createCell(i);
			cell.setCellValue(columName[i]);
			
		}
		row=sheet.createRow(2);
		for(int i=0;i<columValue.length;i++)
		{
			cell=row.createCell(i);
			cell.setCellValue(columValue[i]);
		}
		ByteArrayOutputStream output=new ByteArrayOutputStream();
		
		excel.write(output);
	
		return output;
		
	}

	private Date toDate(String time)
	{
		if("".equals(time))
			return null;
	
		String[] dateStr=time.split("-");
		Calendar ca=Calendar.getInstance();
		ca.set(Integer.parseInt(dateStr[0]), Integer.parseInt(dateStr[1]),Integer.parseInt(dateStr[2]));
		Date date=new Date(ca.getTimeInMillis());	
		return date;
	}
	
	public ReportBean getReportBeanById(String id)
	{
		if(reportIdMap.containsKey(id))
			return reportIdMap.get(id);
		return null;
	}
	public class ReoprtZip
	{
		public String title;
		public ByteArrayOutputStream zipout;
	}

	public static void main(String[] args)
	{
		
		
		List<XzqhBean> list=UtilFactory.getXzqhUtil().getChildListByParentId("370100");
		User user=new User();
		user.getRoleList().get(0).getName();
		
		//ReportManager.getInstance().Test();
//		String ss="";
//		Object obj=(Object)ss;
//		System.out.println(new Date(Calendar.getInstance().getTimeInMillis()).toString());
//		ByteArrayOutputStream out;
//		FileOutputStream out2;
////		
////		String path= ReportAction.class.getResource("").getPath();
////		File file=new File(path+"model.xls");
////		System.out.println(file.exists());
//		try
//		{
//
//		ReportManager.ReoprtZip reportZip= ReportManager.getInstance().toExcel("2012-1","2012-12","济南市");
//	
//		out=reportZip.zipout;
//		out2=new FileOutputStream("E:/aaaa.zip");
//		out2.write(out.toByteArray());
//		out.close();
//		out2.close();
//		} catch (IOException e)
//		{
//			// 
//			e.printStackTrace();
//		}
//		finally
//		{
//			System.out.println("end");
//			
//		}
//		
	}
}
