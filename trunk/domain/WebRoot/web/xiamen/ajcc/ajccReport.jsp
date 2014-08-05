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
	String userid = ((User)userprincipal).getUserID();
	String userXzqh = ((User)userprincipal).getXzqh();
	List<Role> list = null;
    String parent_role="";
	try {
		list = ManagerFactory.getUserManager().getUserWithId(userid).getRoleList();
		if(list.size()>0){
			Role role=(Role)list.get(0);
			parent_role=ManagerFactory.getRoleManager().getParantRoleName(role.getRoleid());
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	String xzq = request.getParameter("xzq");
	String begindate = request.getParameter("begindate");
	String enddate = request.getParameter("enddate");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml"> 
  <head>
    <base href="<%=basePath%>" >
    <title>巡查核查成果统计表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/restRequest.jspf"%>
	<%@ include file="/base/include/ext.jspf" %>
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
  img{
  	cursor:hand;
  }
	</style>
  </head>
  <script type="text/javascript">
  		function exportExcel(){
		    var curTbl = document.getElementById("center"); 
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
		    
		    //去掉表格背景颜色
		    var AJCCtable = document.all.AJCC;//指定要写入的数据源的id
			var hang = AJCCtable.rows.length;//取数据源行数
			var lie = AJCCtable.rows(0).cells.length;//取数据源列数
			for (var i=1;i<=hang;i++){
				oSheet.Range(oSheet.Cells(i,1),oSheet.Cells(i,lie+1)).Interior.ColorIndex=2;
			}
		           
		    oXL.Visible = true; 
		    //设置excel可见属性 
		}
		
  </script>
  <body >
  	<div id="fixed" style="position: fixed; top: 5px; left: 0px">
  		&nbsp;
	</div>
	
	   <div align="center" style="margin-top: 15px">
	      <h1>发现制止土地违法行为清单</h1>
	   </div>
	    <div style="position:absolute; top:45px; left: 20px; width:1000px;" >
	    <font style="font-size: 13px ;">填报单位：
	    <input id="tbdw" name="textBox" type="text" style="width:260px;border:0;padding:0;" value=<%=parent_role %> />
	    </font>
		<font style="font-size: 13px; float: right">计量单位：件、亩</font>
	    </div>
	    
	<div align="center" id="center" style="position:absolute; top:65px; left: 20px;">
  		<%=new CBDReportManager().getReport("AJCC",new Object[]{userid,xzq,begindate,enddate})%>
  	</div>
  </body>
</html>
