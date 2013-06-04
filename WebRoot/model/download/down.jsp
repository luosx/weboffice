<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page   import= "java.io.* "%>
<%@page import="com.klspta.common.accessory.AccessoryOperation" %>
<%@page import="com.klspta.common.accessory.AccessoryBean" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String filePath = request.getParameter("file_path");
String hzm=filePath.substring(filePath.lastIndexOf(".")+1,filePath.length());
String flag = request.getParameter("flag");
int a = filePath.lastIndexOf("/");
filePath = filePath.substring(a+1);
AccessoryBean bean = new AccessoryBean();
bean = AccessoryOperation.getInstance().getAccessoryByFile_path(filePath);
String fileName = bean.getFile_name();
fileName = new String(fileName.getBytes(), "ISO8859-1");
if(!flag.equals("0")){
response.setContentType("application/x-download");  
response.addHeader("Content-Type:text/html"," charset=utf-8");
response.addHeader("content-type","application/x-msdownload");
response.addHeader("Content-Disposition","attachment;filename="+fileName+"\"");
}
String classPath = Thread.currentThread().getContextClassLoader().getResource("/").getPath();
String dirpath = classPath.substring(0, classPath.lastIndexOf("WEB-INF/classes"));
dirpath=dirpath+"common/pages/accessory/download/";
if(hzm.toLowerCase().equals("txt")){
//FileInputStream fis = new FileInputStream(new File("D:\\yangzhou\\code\\WebRoot\\common\\pages\\accessory\\download\\"+filePath));
FileInputStream fis = new FileInputStream(new File(dirpath+filePath));

BufferedReader in = new BufferedReader(new InputStreamReader(fis,"GBK"));
String   inputLine;
while((inputLine = in.readLine()) != null){
out.println(inputLine);
}
in.close();
}else{
  OutputStream output = null;  
   FileInputStream in = null;    
 try{
  
  	output = response.getOutputStream();  
   in=new FileInputStream(new File(dirpath+filePath));  
      
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
}
%> 
