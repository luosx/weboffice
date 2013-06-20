<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.web.xuzhouNW.dtxc.DtxcManager"%>
<%@page import="com.klspta.base.util.bean.ftputil.AccessoryBean"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String yw_guid = request.getParameter("yw_guid");
String file_id = request.getParameter("file_id");
String flag = request.getParameter("flag");
// String subofficename = request.getParameter("subofficename");
List<Map<String, Object>> showList = new DtxcManager().getXzrqbyYw_guid(yw_guid);
String tempFolder = "";
String ftpFileName = "";
//文件已存在，将文件从ftp中下载到缓冲区中打开已存在的文件
if(flag.equals("false")){
	ftpFileName = file_id+ ".doc";
	AccessoryBean bean = new AccessoryBean();
	bean.setFile_id(file_id);
	bean.setFile_type("file");
	String tem = new java.io.File(application.getRealPath(request.getRequestURI())).getParent();
	String temp = (tem.substring(0,tem.lastIndexOf(path.substring(1))-1)+tem.substring(tem.lastIndexOf(path.substring(1))+6)+"/cache/").replace("\\","/");
	UtilFactory.getFtpUtil().downloadFile(ftpFileName,temp+ftpFileName); //将ftp服务器中指定的文档下载到服务器临时文件夹下(weOffice模块下的documentTemporaryFolder)
	String base = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() + request.getRequestURI();
	tempFolder = base.substring(0,base.lastIndexOf("/")) + "/cache/";
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>文书加载</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="<%=basePath%>/base/include/ajax.js"></script> 
  </head>
  
  <script type="text/javascript">
  	var path = "<%=basePath%>";
  
  	function webofficeInit(){
  		var webObj=document.getElementById("WebOffice1");
		var vCurItem = document.all.WebOffice1.HideMenuItem(0);
		if(vCurItem & 0x01){
			webObj.HideMenuItem(0x01);
		}else{
			webObj.HideMenuItem(0x01 + 0x8000);    
		}
		if(vCurItem & 0x02){
			webObj.HideMenuItem(0x02);
		}else{
			webObj.HideMenuItem(0x02 + 0x8000);   
		}
		if(vCurItem & 0x04){
			webObj.HideMenuItem(0x04); 
		}else{
			webObj.HideMenuItem(0x04 + 0x8000); 
		} 
		downloadDoc();
  	}
  	
  	function downloadDoc(){
  		if("<%=flag%>" == "true"){
  			//第一次加载时，加载模板
			var webObj=document.getElementById("WebOffice1"); 
			webObj.Close();  
  			
  			//当对应的抄告单不存在时
			document.all.WebOffice1.LoadOriginalFile('<%=basePath%>web/xuzhouNW/dtxc/webOffice/'+encodeURI(unescape("抄告单"))+'.doc', "doc");
			document.getElementById("save").disabled = false; 
			document.all.WebOffice1.HideMenuArea("hideall","","","");  
			
			//添加标签值
			document.all.WebOffice1.SetFieldValue("subofficename", '<%=(String)showList.get(0).get(request.getParameter("subofficename"))%>', ""); 
			document.all.WebOffice1.SetFieldValue("number", "<%=(String)showList.get(0).get(request.getParameter("number"))%>", ""); 
			document.all.WebOffice1.SetFieldValue("districtname", "<%=(String)showList.get(0).get(request.getParameter("districtname"))%>", ""); 
			document.all.WebOffice1.SetFieldValue("townname", "<%=(String)showList.get(0).get(request.getParameter("townname"))%>", ""); 
			document.all.WebOffice1.SetFieldValue("countyname", "<%=(String)showList.get(0).get(request.getParameter("countyname"))%>", ""); 
			document.all.WebOffice1.SetFieldValue("projectname", "<%=(String)showList.get(0).get(request.getParameter("projectname"))%>", ""); 
			document.all.WebOffice1.SetFieldValue("location", "<%=(String)showList.get(0).get(request.getParameter("location"))%>", ""); 
			document.all.WebOffice1.SetFieldValue("area", "<%=(String)showList.get(0).get(request.getParameter("area"))%>", ""); 
			document.all.WebOffice1.SetFieldValue("buildDate", "<%=(String)showList.get(0).get(request.getParameter("buildDate"))%>", ""); 
			document.all.WebOffice1.SetFieldValue("Date", "<%=(String)showList.get(0).get(request.getParameter("Date"))%>", ""); 	
  		
  			//将文档上传到ftp
  			uploadDoc();
  		}else{
  			//加载第二次时，直接从ftp中读取word文档
  			document.all.WebOffice1.LoadOriginalFile("<%=tempFolder%><%=ftpFileName%>", "doc");	
  			document.all.WebOffice1.HideMenuArea("hideall","","",""); 
  			document.getElementById("save").disabled = false;  
  		}
  	}
  	
  	//抄告单上传 
  	function  uploadDoc(){
  		var yw_guid = "<%=yw_guid%>";
  		var webObj = document.getElementById("WebOffice1");
  		webObj.HttpInit();
  		webObj.HttpAddPostString("id", "<%=file_id%>");
  		webObj.HttpAddPostString("DocTitle", "抄告单.doc");
  		webObj.HttpAddPostString("DocId", "<%=file_id%>");
  		webObj.HttpAddPostString("DocType", "doc");
  		webObj.HttpAddPostCurrFile("1", "<%=file_id%>");
  		returnValue = webObj.HttpPost("<%=basePath%>/model/webOffice/webOffice_save.jsp?yw_guid=<%=file_id%>");
		return returnValue;
  	}
  	
  	function save(){
  		var returnValue = uploadDoc();
  		returnValue = returnValue.replace(/(^\s*)|(\s*$)/g, "") 
		if(returnValue){	//returnValue 文书是否上传成功
			alert("保存成功！");
		}else{
			alert("保存失败！");
		} 
  	}
  
  </script>
  
  <body leftmargin="0" bottommargin="0" rightmargin="0" topmargin="0"  onload="webofficeInit();return false;"> 
    <div style="width:100%; height:25px;float:left;background-color: gray">
    	<input style="width:150" value="抄告单:<%=yw_guid%>"/>
    	<input id="save" style="width:50" type="button" value="保存" onclick="save()" disabled="disabled"/>
    </div>
	<div>
		<TABLE class=TableBlock width="100%">
		  <TBODY><TR><TD class=TableData vAlign=top width="100%"><SCRIPT src="LoadWebOffice.js"></SCRIPT></TD></TR></TBODY>
		</TABLE>
	</div>
 </body>
</html>
