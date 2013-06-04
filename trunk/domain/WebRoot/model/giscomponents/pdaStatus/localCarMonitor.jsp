<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
var restUrl = "";

if(restUrl == null || restUrl == ""){
	var query = window.location.href;
	var ss = query.split("/");
	restUrl = "http://" + ss[2] + "/gisland/service/rest/";
}
</script>
<script type="text/javascript" src="<%=basePath%>gisapp/pages/framework/frameworkHttpRequest.js"></script>
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	margin-right: 1;
	height: 100%;
	background-color: #FFFFFF;
	font: normal 12px verdana;
}

.los {
	width: 100%;
	height: 30px;
	line-height:30px;
	background-image: url('images/left/left_bg.PNG');
}
</style>
<SCRIPT LANGUAGE=javascript FOR=MSComm1 EVENT=OnComm>     
// MSComm1控件每遇到 OnComm 事件就调用 MSComm1_OnComm()函数    
MSComm1_OnComm()    
</SCRIPT>   
</head>

<body >
<div width:100%;height:100%;overflow:auto;">
<table width=80>
<tr>
<td><input  id="start" name="start" type="button" onclick='OpenPort()' value="开始跟踪" style="color:#00509F"/></td>
<td><input  id="end" name="end" type="button" onclick='closePort()' value="停止跟踪" style="color:#00509F" disabled="disabled" /></td>
<td><input  id="autoCenter" name="autoCenter" type="button" onclick='change()' value="非自动居中" style="color:#00509F" disabled="disabled" /></td>
</tr>
</table>
</div>
<OBJECT CLASSID="clsid:648A5600-2C6E-101B-82B6-000000000014" id=MSComm1 codebase="MSCOMM32.OCX" type="application/x-oleobject"    
style="LEFT: 54px; TOP: 14px" >    
<PARAM NAME="CommPort" VALUE="34">    
<PARAM NAME="DTREnable" VALUE="1">    
<PARAM NAME="Handshaking" VALUE="0">    
<PARAM NAME="InBufferSize" VALUE="1024">    
<PARAM NAME="InputLen" VALUE="0">    
<PARAM NAME="NullDiscard" VALUE="0">    
<PARAM NAME="OutBufferSize" VALUE="512">    
<PARAM NAME="ParityReplace" VALUE="?">    
<PARAM NAME="RThreshold" VALUE="1">    
<PARAM NAME="RTSEnable" VALUE="1">    
<PARAM NAME="SThreshold" VALUE="2">    
<PARAM NAME="EOFEnable" VALUE="0">    
<PARAM NAME="InputMode" VALUE="0">   

<PARAM NAME="DataBits" VALUE="8">    
<PARAM NAME="StopBits" VALUE="1">    
<PARAM NAME="BaudRate" VALUE="4800">    
<PARAM NAME="Settings" VALUE="4800,N,8,1">
</OBJECT> 
<form name="form1">    
<TEXTAREA  ID=txtReceive cols=25 rows=10 value=''></TEXTAREA>
  
</form> 
</body>
</html>
<script>
//打开端口并发送命令程序 
var inpotBuffer;   
var xy;
var isAutoCenter=true;
var start_x='';
var start_y='';
var end_x='';
var end_y='';
function OpenPort()    
{
	document.getElementById("end").disabled=false;
	document.getElementById("start").disabled=true;  
	document.getElementById("autoCenter").disabled=false;
	if(!MSComm1.PortOpen)    
	{    
		MSComm1.PortOpen=true;    
		MSComm1.Output="R";//发送命令    
		//window.alert("成功发出命令！"); 
	}    
	else    
	{    
	    window.alert ("已经开始接收数据!");    
	}    
}   
function closePort(){
	if(MSComm1.PortOpen){
		document.getElementById("start").disabled=false;
		document.getElementById("end").disabled=true; 
		document.getElementById("autoCenter").disabled=true;
		MSComm1.PortOpen=false; 
	}else{
		alert('端口已关闭');
	}
} 

function change(){
	if(document.getElementById("autoCenter").value == "非自动居中"){
		document.getElementById("autoCenter").value = "自动居中";
		isAutoCenter=false;

				
	}else{	
		document.getElementById("autoCenter").value = "非自动居中";		
		isAutoCenter=true;	
	}
}

//重写 mscomm 控件的唯一事件处理代码    
function MSComm1_OnComm()    
{      
if(MSComm1.CommEvent==2)//如果是接收事件    
{    
        //document.form1.txtReceive.value=document.form1.txtReceive.value + filter(MSComm1.Input); 
        var gpgga=filter(MSComm1.Input).split(','); 
        if(gpgga[0]=='$GPGGA'){
        if((gpgga[1]%5)==0){
        var x=gpgga[2]/100;
        x=(x-parseInt(x))*5/3+parseInt(x);
        var y=gpgga[4]/100;
        y=(y-parseInt(y))*5/3+parseInt(y);
        if(x!='NaN' && y!='NaN'){
        	var status=gpgga[6];
        	if(status==0) status='未定位';
        	if(status==1) status='一般定位';
        	if(status==2) status='精确定位';
        	if(status==3) status='无效定位';
        	if(status==6) status='正在估算';
        
        //开始纠偏
		var anttnaURL='http://www.anttna.com/goffset/goffset1.php?lat='+x+'&lon='+y;
		var result = ajaxRequest(anttnaURL,'','','');
		
		if(result.indexOf('0,0')<0){
		document.form1.txtReceive.value=gpgga[1]+'\n'+ x+' '+y+'\n搜到卫星数:'+gpgga[7]+'\nGPS状态:'+status+'\n纠偏后：'+result;
		//根据是否居中定位显示按钮的值判断
		parent.parent.center.mark(result.split(',')[0],result.split(',')[1],isAutoCenter,true,'当前车辆','car');
		if(start_x=='' || start_y==''){
		start_x=result.split(',')[0];
		start_y=result.split(',')[1];
		}else{
		end_x=result.split(',')[0];
		end_y=result.split(',')[1];
		parent.parent.center.drawLine(start_x, start_y,end_x, end_y);
		start_x=end_x;
		start_y=end_y;
		}
		
		//将结果保存到数据库
ajaxRequest("http://61.177.187.246:8080/gisland/service/rest/wyrw/gpsInfo?owner=wangf&pwd=a&id="+parent.parent.noteBookName+"&info="+result.split(',')[0]+","+result.split(',')[1]);
		}else{
		document.form1.txtReceive.value= x+' '+y+'\n搜到卫星数:'+gpgga[7]+'\nGPS状态:'+status+'\n纠偏服务未及时反馈！';
		
		
        }
        }
} }   
}
}    


function filter(v){
inpotBuffer+=v;

var i=inpotBuffer.indexOf('$GPGGA');
var j;
if(i>=0){
v=inpotBuffer.substr(i);
var j=inpotBuffer.indexOf('\r\n');
v='$GPGGA'+inpotBuffer.substring(0,j+1);
inpotBuffer='';
return v;
}else{
return '';
}
}
//定义ajax方法
function ajaxRequest(path) {
	var objXMLReq = new ActiveXObject("Microsoft.XMLHTTP");
		objXMLReq.open("get", path, false);
		objXMLReq.send();
		var result = objXMLReq.responseText;            
		return result;
	}
</script>
