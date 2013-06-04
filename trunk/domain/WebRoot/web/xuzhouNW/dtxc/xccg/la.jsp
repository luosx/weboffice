<%@ page language="java" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	String yw_guid = request.getParameter("yw_guid");
	String returnPath = request.getParameter("returnPath");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">


		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script src="<%=basePath%>/base/include/ajax.js"></script>
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
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
	function back(){
	   this.parent.location.href="<%=returnPath%>";
	  }
	  
	Ext.onReady(function(){ 
	  Ext.get('tran').on('click', function(e){
	           		parent.lower.Ext.MessageBox.show({
	               	title: '不予立案',
	               	msg: '请输入不予立案的原因：',
	               	width:300,            
	               	buttons: Ext.MessageBox.OKCANCEL,            
	               	multiline: true,            
	              	fn: showResultText,            
	               	animEl: 'mb'        
	            });     
		});    
	function showResultText(btn, text){         
	                       //Ext.example.msg('Button Click', 'You clicked the {0} button and entered the text "{1}".', btn, text);     
	       	var reason = text;
	     	if(btn == "ok"){
		       	putClientCommond("dtcc","setNotCase");
		      	putRestParameter("yw_guid","<%=yw_guid%>");
		      	putRestParameter("reason", reason);
		      	myData = restRequest();
	          	if(myData==true){
	          		back();
	          	}else{
	          		alert("处理异常");
	          	}
	          }
	      }; 
	});

	</script>
	<body background="<%=basePath%>workflow/images/bg.png">

		<table width="100%">
			<tr>
				<td valign="middle">
					<font color="#804000" size="2"><b></b> </font>
				</td>
				<td align="right" valign="middle">
					<button class='btn' onclick="back()">
						返 回
					</button>
					&nbsp;&nbsp;
					<button class='btn' id='delete' onclick="parent.la()">
						立案
					</button>
					&nbsp;&nbsp;
					<button class='btn' id="tran">
						不予立案
					</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</body>
</html>
