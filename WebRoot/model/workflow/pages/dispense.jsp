<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.klspta.base.workflow.foundations.WorkflowOp"%>
<%@page import="com.klspta.base.workflow.foundations.IWorkflowOp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	String yw_guid = request.getParameter("yw_guid");
	String wfInsId = request.getParameter("wfInsId");
	String zfjcType = request.getParameter("zfjcType");
	String edit = request.getParameter("edit");
	IWorkflowOp workflow = WorkflowOp.getInstance();
	String zfjcName = workflow.getWfDescriptionByWfID("lacc-1");
	
	String activityName = workflow.getActivityNameByWfInsID(wfInsId);
	String returnPath = request.getParameter("returnPath");
	//String returnPath = "http://127.0.0.1:8080/reduce/web/jinan/xfaj/dbxf/dbxf.jsp?*closeMenu*";
	String buttonHidden = request.getParameter("buttonHidden");
	if (buttonHidden == null || buttonHidden.equals("null")) {
		buttonHidden = "la";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">


		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/base/include/restRequest.jspf" %>
		<%@ include file="/base/include/ext.jspf"%>
	</head>
	<style>
html,body {
	FONT-SIZE: 12px;
	color: #CC3300;
	font-weight: bold;
	margin: 0;
	padding: 0;
	border: 0 none;
	overflow: hidden;
	height: 100%;
}

.btn {
	background: url('<%=basePath%>/base/form/images/button.png');
	height: 23;
	width: 73;
	CURSOR: hand;
	FONT-SIZE: 12px;
	color: #CC3300;
	BORDER-RIGHT: #002D96 0px solid;
	BORDER-TOP: #002D96 0px solid;
	BORDER-LEFT: #002D96 0px solid;
	BORDER-BOTTOM: #002D96 0px solid
}
</style>
	<script type="text/javascript">
	function initEdit(){
		var edit="<%=edit%>";
		if(edit=='false'){
			document.getElementById('delete').disabled=true;
			document.getElementById('tran').disabled=true;
			document.getElementById('back').disabled=true;
		}
		var bH='<%=buttonHidden%>';
		var buttonHiddens=bH.split(",");
		for(var i=0;i<buttonHiddens.length;i++){
			if(buttonHiddens[i]=='back'){
				document.getElementById('back').style.display= "none"; 
			}else if(buttonHiddens[i]=='delete'){
				document.getElementById('delete').style.display= "none"; 
			}else if(buttonHiddens[i]=='tran'){
				document.getElementById('tran').style.display= "none"; 
			}else if(buttonHiddens[i]=='return'){
				document.getElementById('return').style.display= "none"; 
			}else if(buttonHiddens[i]=='la'){
				document.getElementById('la').style.display= "none"; 
			}	
		}
	}
	
	function transfer(){
		   var result=window.showModalDialog("<%=basePath%>model/workflow/transfer.jsp?wfInsId=<%=wfInsId%>&yw_guid=<%=yw_guid%>&returnPath=<%=returnPath%>",window,"dialogWidth=400px;dialogHeight=330px;status=no;scroll=no"); 
		   if(result){
		      back();
		   }
	}
	
	function back(){
 		//history.back();
 		parent.location.href="<%=returnPath%>";
	}
	
	function rollBack(){
			/*
	        var path = "<%=basePath%>";
		    var actionName = "workflowNodeOperation";
		    var actionMethod = "backTask";
		    var parameter="wfInsId=<%=wfInsId%>";
			var result = ajaxRequest(path,actionName,actionMethod,parameter);
			*/
			putClientCommond("workflowNodeOperation","backTask");
			putRestParameter("wfInsId", "<%=wfInsId%>");
			var result=restRequest();
			
			if(result=="success"){
	              //parent.show("回退成功！");
	              alert("回退成功！") ;
	              back();
			}else if(result=="false"){		
			      //parent.show("当前环节不可回退！");
			      alert("当前环节不可回退！");
			}else if(result=="error"){		
			      //parent.show("回退出现异常！");
			      alert("回退出现异常！")
			}
	}
	
	function stopTask(btn){
     if(btn=='yes'){
	 var path = "<%=basePath%>";
	    /*
	    var actionName = "startWorkflow";
	    var actionMethod = "deleteTask";
	    var parameter="wfInsId=<%=wfInsId%>&yw_guid=<%=yw_guid%>";
		var result = ajaxRequest(path,actionName,actionMethod,parameter);
		*/
		putClientCommond("startWorkflow","deleteTask");
		putRestParameter("wfInsId", "<%=wfInsId%>");
		putRestParameter("yw_guid", "<%=yw_guid%>");
		var result=restRequest();
		if(result=="true"){
              parent.show("已中止！");           
              back();
		}else{		
		      parent.show("操作出错了，请您稍后重试或联系管理员！");
		}
	   };
	}
	
	function shrinkTree(){
		if(parent.parent.content.cols=="203,9,*"){
		 	 parent.parent.content.cols="0,9,*";
		 }
	}
	</script>
	<body background="<%=basePath%>workflow/images/bg.png"
		onload="initEdit()">

		<table width="100%">
			<tr>
				<td valign="middle">
					<font color="#804000" size="2"><b><%=zfjcName%><%=activityName%></b>
					</font>
				</td>
				<td align="right" valign="middle">
					<button class='btn' id='la' onclick="parent.la()">
						立案
					</button>
					&nbsp;&nbsp;
					<button class='btn' id="return" onclick="back()">
						返 回
					</button>
					&nbsp;&nbsp;
					<button class='btn' id='delete' onclick="parent.deleteTask()">
						终 止
					</button>
					&nbsp;&nbsp;
					<button class='btn' id="tran" onclick="transfer()">
						移 交
					</button>
					&nbsp;&nbsp;
					<button class='btn' id="back" onclick="rollBack()">
						回 退
					</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</body>
</html>
