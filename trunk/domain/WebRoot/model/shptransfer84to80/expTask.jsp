<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page  import= "java.io.* "%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
response.setContentType("application/x-download");  
response.addHeader("Content-Type:text/html"," charset=utf-8");
response.addHeader("content-type","application/x-msdownload");
String filePath=request.getParameter("filePath");
String filedisplay="\"" + new String("shp坐标转换.zip".getBytes("GBK"),"ISO8859_1") + "\"";
response.addHeader("Content-Disposition","attachment;filename="+filedisplay);
  OutputStream output = null;  
   FileInputStream in = null;    
 try{ 
  	output = response.getOutputStream();  
    in=new FileInputStream(new File(filePath+".zip"));  
      
   byte[] b = new byte[1024];    
   int i = 0;    
   
   while((i = in.read(b)) > 0)    
   {    
   output.write(b, 0, i);    
   }    
   output.flush(); 
   out.clear();
   out = pageContext.pushBody();      
  }catch(Exception e){
   e.printStackTrace();
  }finally{
  
   if(in != null)    
    {    
    in.close();    
    in = null;    
  }
  }



%> 
