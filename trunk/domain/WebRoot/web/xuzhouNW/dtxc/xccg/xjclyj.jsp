<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.console.ManagerFactory" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String yw_guid = request.getParameter("yw_guid");
	String returnPath = request.getParameter("returnPath");
	String flag = request.getParameter("flag");
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String fullName = ((User) principal).getFullName();
	String roleName = ManagerFactory.getRoleManager().getRoleWithUserID(((User)principal).getId()).get(0).getRolename();	
	boolean isCity = true;
	
	if(roleName.contains("区") || roleName.contains("县")){
		isCity = false;
	}
	
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
	
		<% if("1".equals(flag)){ %>
		
		Ext.get('jyla').on('click', function(e){
			parent.lower.Ext.MessageBox.show({
				title:'建议立案',
				msg:'请输入建议立案的原因',
				width:300,
				buttons:Ext.MessageBox.OKCANCEL,
				multiline:true,
				fn:jyla,
				animEl:'mb'
			});
		});
	
		Ext.get('hf').on('click', function(e){
			parent.lower.Ext.MessageBox.show({
				title:'合法',
				msg:'请输入合法的原因',
				width:300,
				buttons:Ext.MessageBox.OKCANCEL,
				multiline:true,
				fn:hf,
				animEl:'mb'
			});
		});
		
		<% }else if("0".equals(flag)){ %>
		
		Ext.get('byla').on('click', function(e){
			parent.lower.Ext.MessageBox.show({
				title:'不予立案',
				msg:'请输入不予立案的原因',
				width:300,
				buttons:Ext.MessageBox.OKCANCEL,
				multiline:true,
				fn:byla,
				animEl:'mb'
			});
		});	
		<%if(!isCity){ %>
		Ext.get('shangb').on('click', function(e){
			parent.lower.Ext.MessageBox.show({
				title:'上报',
				msg:'请输入上报的原因',
				width:300,
				buttons:Ext.MessageBox.OKCANCEL,
				multiline:true,
				fn:shangb,
				animEl:'mb'
			});
		});	
		<%}%>
		Ext.get('la').on('click', function(e){
			 var parameter="zfjcType=7&yw_guid=<%=yw_guid%>&flag=1&lyType='DTXC'&fullName=<%=fullName%>&returnPath=<%=returnPath%>";
			 var result=window.showModalDialog("<%=basePath%>web/jinan/dtxc/xccg/laccORfgb.jsp?"+parameter,window,"dialogWidth=300px;dialogHeight=200px;status=no;scroll=no"); 
	         if(result[0]=="1")
	         {
		        parent.location.href="<%=returnPath%>";
		   	}
		     if(result[0]=="3")
		     {  
		     	var path=result[1];
		     	 parent.location.href="<%=basePath%>"+path+"&returnPath=<%=returnPath%>";
		     }
		});
		
			Ext.get('hf').on('click', function(e){
			parent.lower.Ext.MessageBox.show({
				title:'合法',
				msg:'请输入合法的原因',
				width:300,
				buttons:Ext.MessageBox.OKCANCEL,
				multiline:true,
				fn:hf,
				animEl:'mb'
			});
		});
		
		<%}else if("3".equals(flag)){ %>
			Ext.get('ty').on('click', function(e){
					parent.lower.Ext.MessageBox.show({
						title:'同意不予立案',
						msg:'请输入审批意见',
						width:300,
						buttons:Ext.MessageBox.OKCANCEL,
						multiline:true,
						fn:ty,
						animEl:'mb'
					});
			});
			
			Ext.get('zcl').on('click', function(e){
				parent.lower.Ext.MessageBox.show({
					title:'不同意不予立案',
					msg:'请输入审批意见',
					width:300,
					buttons:Ext.MessageBox.OKCANCEL,
					multiline:true,
					fn:zcl,
					animEl:'mb'
				});
			});
		<% }%>
		function zcl(btn, text){
			var reason = text;
			if(btn == "ok"){
				<%if(isCity){%>
		          putClientCommond("dtcc", "setCityView");
		          putRestParameter("status", "9");
		         <%}else{%> 
		          putClientCommond("dtcc", "setCountyView");
		          putRestParameter("status", "5");
		         <%}%>
		         // putClientCommond("dtcc", "setCountyView");
		          putRestParameter("yw_guid", "<%=yw_guid%>");
		          putRestParameter("reason", reason);
		          putRestParameter("way", "合法");
		          //putRestParameter("status", "5");
		          var myData = restRequest();
		          if(myData == true){
		            back();
		          }else{
		            alert("保存失败，请重新保存或联系管理员");
		          }    
        	}
		}
		function ty(btn, text){
			var reason = text;
			if(btn == "ok"){
				<%if(isCity){%>
		          putClientCommond("dtcc", "setCityView");
		          putRestParameter("status", "8");
		         <%}else{%> 
		          putClientCommond("dtcc", "setCountyView");
		          putRestParameter("status", "2");
		         <%}%>
		          putRestParameter("yw_guid", "<%=yw_guid%>");
		          putRestParameter("reason", reason);
		          putRestParameter("way", "合法");
		          putRestParameter("status", "2");
		          var myData = restRequest();
		          if(myData == true){
		            back();
		          }else{
		            alert("保存失败，请重新保存或联系管理员");
		          }    
        	}
		}
		
	//上报
	function shangb(btn, text){
		var reason = text;
		if(btn == "ok"){
          putClientCommond("dtcc", "setCountyView");
          putRestParameter("yw_guid", "<%=yw_guid%>");
          putRestParameter("reason", reason);
          putRestParameter("way", "上报");
          putRestParameter("status", "4");
          var myData = restRequest();
          if(myData == true){
            back();
          }else{
            alert("保存失败，请重新保存或联系管理员");
          }    
        }
	}
	
	//不予立案
function byla(btn, text){
		var reason = text;
		if(btn == "ok"){
			<%if(isCity){%>
          		putClientCommond("dtcc", "setCityView");
          		putRestParameter("status", "7");
          	<%}else{%>
          		putClientCommond("dtcc", "setCountyView");
          		putRestParameter("status", "3");
          	<%}%>
          putRestParameter("yw_guid", "<%=yw_guid%>");
          putRestParameter("reason", reason);
          putRestParameter("way", "不予立案");
          
          var myData = restRequest();
          if(myData == true){
            back();
          }else{
            alert("保存失败，请重新保存或联系管理员");
          }    
        }
	}
	
		
	function hf(btn, text){
        var reason = text;
        if(btn == "ok"){
          //putClientCommond("dtcc", "setCountyView");
          <%if(isCity){%>
          		putClientCommond("dtcc", "setCityView");
          		putRestParameter("status", "7");
          	<%}else{%>
          		putClientCommond("dtcc", "setCountyView");
          		putRestParameter("status", "2")
          	<%}%>
          putRestParameter("yw_guid", "<%=yw_guid%>");
          putRestParameter("reason", reason);
          putRestParameter("way", "合法");
       
          var myData = restRequest();
          if(myData == true){
            back();
          }else{
            alert("保存失败，请重新保存或联系管理员");
          }    
        }
 
      }

    function jyla(btn, text){
        var reason = text;
        if(btn == "ok"){
          putClientCommond("dtcc", "setCountyView");
          putRestParameter("yw_guid", "<%=yw_guid%>");
          putRestParameter("reason", reason);
          putRestParameter("way", "建议立案");
          putRestParameter("status", "10")
          var myData = restRequest();
          if(myData == true){
            back();
          }else{
            alert("保存失败，请重新保存或联系管理员");
          }    
        }
      }
	});	
	  
	</script>
	<body background="<%=basePath%>workflow/images/bg.png">

		<table width="100%">
			<tr>
				<td valign="middle"><font color="#804000" size="2"> </font>
				</td>
				<td align="right" valign="middle">
					<button class='btn' onclick="back()">
						返 回
					</button>
					<% if("1".equals(flag)){ %>
					&nbsp;&nbsp;
					<button class='btn' id='jyla'>
						建议立案
					</button>
					&nbsp;&nbsp;
					<button class='btn' id="byla">
						不予立案
					</button>
					<% }else if("0".equals(flag)){ %>
					&nbsp;&nbsp;
					<button class='btn' id='byla' >不予立案</button>
					&nbsp;&nbsp;
					<button class='btn' id='la'>立案</button>
					&nbsp;&nbsp;
					<button class='btn' id='hf'>合法</button>
					<%if(!isCity){ %>
					&nbsp;&nbsp;
					<button class= 'btn' id='shangb'>上报</button>
					<%} }else if("3".equals(flag)){%>
					&nbsp;&nbsp;
					<button class='btn' id='ty'>同意</button>
					&nbsp;&nbsp;
					<button class= 'btn' id='zcl'>再处理</button>
					<%} %>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</body>
</html>
