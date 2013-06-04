<%@page language="java" contentType="application/x-msdownload"    pageEncoding="gb2312"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//String file=URLDecoder.decode(request.getParameter("file_path"),"GB2312"); 
//String filePath=new String(file.getBytes("ISO-8859-1"));
String file=request.getParameter("file_path");
//System.out.println(filePath);
response.setContentType("application/x-download");    
String filedisplay=new String("核查成果导出.zip".getBytes(), "ISO8859-1");
response.addHeader("Content-Disposition","attachment;filename=" + filedisplay);     
   OutputStream output = null;    
   FileInputStream in = null;    
 try{
   output = response.getOutputStream();  
   in=new FileInputStream(file);       
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