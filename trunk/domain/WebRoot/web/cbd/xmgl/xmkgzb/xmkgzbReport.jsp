<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.console.role.Role"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Object userprincipal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
String xmmc = request.getParameter("xmmc");	
String yw_guid = request.getParameter("yw_guid");
if(xmmc!=null){
	xmmc = new String(xmmc.getBytes("iso-8859-1"),"utf-8");
}
Map<String, String> conditionMap = new HashMap<String, String>();
conditionMap.put("query", " yw_guid = '" + yw_guid + "'");

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html> 
  <head>
    <base href='<%=basePath%>' />
    <title>项目控规指标表</title>
	<meta http-equiv="pragma" content="no-cache"/>
	<meta http-equiv="cache-control" content="no-cache"/>
	<meta http-equiv="expires" content="0"/>    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3"/>
	<meta http-equiv="description" content="This is my page"/>
	<%@ include file="/base/include/ext.jspf"%>
	<%@ include file="/base/include/restRequest.jspf"%>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		  table{
    font-size: 14px;
    background-color: #A8CEFF;
    border-color:#000000;
    /**
    border-left:1dp #000000 solid;
    border-top:1dp #000000 solid;
    **/
    color:#000000;
    border-collapse: collapse;
  }
  tr{
    border-width: 0px;
    text-align:center;
  }
  td{
    text-align:center;
    border-color:#000000;
    /**
    border-bottom:1dp #000000 solid;
    border-right:1dp #000000 solid;
    **/
  }
  h1{
  font-size: 24px;
  }
  span{
  float:right;
  }
  .title{
    font-weight:bold;
    font-size: 15px;
    text-align:center;
    line-height: 30px;
	margin-top: 3px;
  }
  .title2{
    font-weight:bold;
    font-size: 15px;
    text-align:center;
    line-height: 15px;
	margin-top: 3px;
  }
  .trtotal{
  	text-align:center;
    font-weight:bold;
    line-height: 30px;
   }
  .trsingle{
    background-color: #D1E5FB;
    line-height: 20px;
    text-align:center;
   }
 
	</style>
	 <script type="text/javascript">
  		function print(){
		    var curTbl = document.getElementById("XMKGZBBCX"); 
 			try{
		    	var oXL = new ActiveXObject("Excel.Application");
		    }catch(err){
		    	Ext.Msg.alert('提示','Excel生成失败，请先确定系统已安装office，并在浏览器的\'工具\' - Internet选项 -安全 - 自定义级别 - ActiveX控件和插件 - 对未标记为可安全执行脚本的ActiveX控件.. 标记为\'启用\'');
		    	return;
		    } 
		    //创建AX对象excel 
		    var oWB = oXL.Workbooks.Add(); 
		    //获取workbook对象 
		    var oSheet = oWB.ActiveSheet; 
		    //激活当前sheet 
		    var sel = document.body.createTextRange(); 
		    sel.moveToElementText(curTbl); 
		    //把表格中的内容移到TextRange中 
		    sel.select(); 
		    //全选TextRange中内容 
		    sel.execCommand("Copy"); 
		    //复制TextRange中内容 
		    //oSheet.Paste(); 
		    oSheet.Paste(); 
		    //粘贴到活动的EXCEL中       
		    oXL.Visible = true; 
		    //设置excel可见属性 
		}
		//根据用地单位和关键字作过滤
  		function query(keyword){
 			putClientCommond("xmkgzbbmanager","getReport");
 			putRestParameter("yw_guid", "<%=yw_guid%>")
		    putRestParameter("keyword",escape(escape(keyword)));
			myData = restRequest();
  			document.getElementById("center").innerHTML = myData;
  		}
		
		
		function saves(ydxzlx,adding){
		var dkbh=document.getElementById("dkbh").value;
		var ydxz=document.getElementById("ydxz").value;
		var ydxzdh=document.getElementById("ydxzdh").value;
		var ydmj=document.getElementById("ydmj").value;
		var rjl=document.getElementById("rjl").value;
		var jzmj=document.getElementById("jzmj").value;
		var kzgd=document.getElementById("kzgd").value;
		var bz=document.getElementById("bz").value;
		if(dkbh==null||dkbh==''||ydxz==null||ydxz==''||ydxzdh==null||ydxzdh==''||ydmj==null||ydmj==''||rjl==null||rjl==''||jzmj==null||jzmj==''){
			alert("请填写完整之后再保存！！"); 
		}else{
	    	putClientCommond("xmkgzbbmanager","saveDK");
			putRestParameter("yw_guid","<%=yw_guid%>");
			putRestParameter("dkbh",dkbh);
			putRestParameter("ydxz",ydxz);
			putRestParameter("ydxzdh",ydxzdh);
			putRestParameter("ydmj",ydmj);
			putRestParameter("rjl",rjl);
			putRestParameter("jzmj",jzmj);
			putRestParameter("kzgd",kzgd);
			putRestParameter("bz",bz);
			putRestParameter("ydxzlx",ydxzlx);
			var msg=restRequest();
			if('success'==msg){
				alert("保存成功！");
				alert(window.parent.adding);
				 window.parent.adding=false;
				document.location.reload();
			}else{
				alert("保存失败！");
			}
		}
	}
  </script>
  </head>
  <body >
	<div align="center" style="margin-top: 15px;  width:800px;">
	      <h1><%=xmmc%>控规指标表</h1>
	</div>
	<div align="center" id="center" style="position:absolute; top:65px; left: 20px;">
  		<%=new CBDReportManager().getReport("XMKGZBBCX",new Object[]{conditionMap})%>
  	</div>
  </body>
</html>
