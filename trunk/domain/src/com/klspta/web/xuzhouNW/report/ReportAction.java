package com.klspta.web.xuzhouNW.report;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletOutputStream;

import com.klspta.base.AbstractBaseBean;

public class ReportAction extends AbstractBaseBean
{
	public void backToSuperior() throws UnsupportedEncodingException
	{
		String userId=request.getParameter("userId");
		String tzIds=new String( request.getParameter("tzIds").getBytes("iso-8859-1"),"utf-8");
		try
		{	
		//	ReportManager.getInstance().sb(userId, tzIds,-1);
			response.getWriter().write("{'success':'true'}");
		} catch (Exception e)
		{
			try
			{
				response.getWriter().write("{failure:true}");
			} catch (IOException e1)
			{
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
			
		}
	}
	public void  reportToSuperior() throws UnsupportedEncodingException
	{
		String userId=request.getParameter("userId");
		String tzIds=new String( request.getParameter("tzIds").getBytes("iso-8859-1"),"utf-8");
		try
		{
//			ReportManager.getInstance().sb(userId, tzIds,1);
			response.getWriter().write("{'success':'true'}");
		} catch (Exception e)
		{
			try
			{
				response.getWriter().write("{failure:true}");
			} catch (IOException e1)
			{
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		
	}
	public void save()
	{
		Map<String,Object> map=new HashMap<String, Object>();
		save(map);
	}
	private void save(Map<String,Object> map) 
	{
		
		Map<String, Object> mapValues=request.getParameterMap();	
		ReportBean reportBean;
		String tzid="";

		try
		{
			tzid=request.getParameter("TZID");
			if(tzid==null)
			{
				tzid=getId();
			
				map.put("TZID", tzid);
			}
			reportBean=ReportManager.getInstance().getReportBeanById(tzid);	
			
			for(String key:mapValues.keySet())
			{
				
				map.put(key, new String(request.getParameter(key).getBytes("ISO-8859-1"),"utf-8"));
				
			}
		} catch (UnsupportedEncodingException e)
		{
			return;
		}
		if(reportBean==null)
		{
			reportBean=new ReportBean(map);
			ReportManager.getInstance().insertRecord(reportBean);
		}
		else
		{
			reportBean.resetBean(map);		
			ReportManager.getInstance().updateAllField(reportBean);
		}
		try
		{
			String path=request.getRequestURL().toString();
			path=path.substring(0, path.indexOf("service/rest"));
			//request.getSession().setAttribute("tzId", tzid);
			response.sendRedirect(path+"web/jinan/report/reportsForm.jsp?sbzt="+reportBean.getSBZT()+"&tzId="+reportBean.getTZID()+"&isShowMsg=true");
			
			
		} catch (IOException e)
		{
			
			e.printStackTrace();
		}
		
	}
	 public void delete()
	 {
		 try
		{
			String tzId=new String(request.getParameter("tzId").getBytes("ISO-8859-1"),"utf-8");
			
			ReportManager.getInstance().delete(tzId);
			response.getWriter().write("{success:true}");
					
			
		} catch (UnsupportedEncodingException e)
		{
			
		} catch (IOException e)
		{
			
		}
	 }
	public void collect()
	{
		try
		{
			
			String beginDate=request.getParameter("beginDate");
			String endDate=request.getParameter("endDate");
			String area=new String(request.getParameter("area").getBytes("ISO-8859-1"),"utf-8");
			//Map<String,String> map=ReportManager.getInstance().collect(beginDate, endDate, area);
		//	putParameter(map);
		} catch (UnsupportedEncodingException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response();
	}
	public void collectReport()
	{
	
		ServletOutputStream out=null;
		ByteArrayOutputStream output=null;
	
		try {	

			out = response.getOutputStream();	
			String beginDate=request.getParameter("beginDate");
			String endDate=request.getParameter("endDate");
			String area=new String(request.getParameter("area").getBytes("ISO-8859-1"),"utf-8");		
		
			output=ReportManager.getInstance().collectReport(beginDate, endDate, area);
			String fileName="台账汇总";
			//	response.setCharacterEncoding("UTF-8"); 
			fileName=new String(fileName.getBytes(),"ISO-8859-1");
			response.setContentType("application/x-msdownload");
			
			response.setHeader( "Content-Disposition", "attachment; filename="+fileName+".xls");
			
					
			out.write(output.toByteArray());
			
//			FileOutputStream fos = new FileOutputStream("E:/电路业务侧信息导入模板.xls");             
//			ByteArrayOutputStream bos = new ByteArrayOutputStream();            
//			ObjectOutputStream oos = new ObjectOutputStream(bos);   
			
		} catch (IOException e)
		{
			e.printStackTrace();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try {
				out.flush();
				out.close();
				output.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		
		}
	}

	public void query()
	{

		String json="[]";
		try
		{
			String beginDate=request.getParameter("beginDate");
			String endDate=request.getParameter("endDate");
			String area= new String(request.getParameter("area").getBytes("ISO-8859-1"),"utf-8");
			int state=Integer.parseInt(request.getParameter("state"));
						
			json = ReportManager.getInstance().getJsonByCondition(beginDate, endDate, area,state);
		} catch (UnsupportedEncodingException e)
		{
			e.printStackTrace();
		}
		
		response(json);
	}
	public void report()
	{
		
		ServletOutputStream out=null;
		ByteArrayOutputStream output=null;
		
		try {

			out = response.getOutputStream();	
			String beginDate=request.getParameter("beginDate");

			String endDate=request.getParameter("endDate");
			
			String area= new String(request.getParameter("area").getBytes("ISO-8859-1"),"utf-8");
			
			String type=request.getParameter("type");

			ReportManager.ReoprtZip reportZip =null;
			
			ReportManager m= ReportManager.getInstance();
			reportZip=m.toExcel(beginDate,endDate,area,type);
			output=reportZip.zipout;
			String fileName=reportZip.title;
			//	response.setCharacterEncoding("UTF-8"); 
			fileName=new String(fileName.getBytes(),"ISO-8859-1");
			response.setContentType("application/x-msdownload");
			
			response.setHeader( "Content-Disposition", "attachment; filename="+fileName+".xls");
			
					
			out.write(output.toByteArray());
			
//			FileOutputStream fos = new FileOutputStream("E:/电路业务侧信息导入模板.xls");             
//			ByteArrayOutputStream bos = new ByteArrayOutputStream();            
//			ObjectOutputStream oos = new ObjectOutputStream(bos);   
			
		} catch (IOException e)
		{
			e.printStackTrace();
		} catch (Exception e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	private String getId()
	{
	
		return System.currentTimeMillis()+""+new Random().nextInt(4);
	}
	public static void main(String[] args)
	{
		
	}


}
