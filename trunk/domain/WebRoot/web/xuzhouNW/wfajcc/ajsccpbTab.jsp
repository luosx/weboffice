<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.web.jinan.lach.LaccManager"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";
	String yw_guid = request.getParameter("yw_guid");
	String wfInsTaskId = request.getParameter("wfInsTaskId");
	String wfId = request.getParameter("wfId");
	String returnPath = request.getParameter("returnPath");
	String wfInsId = request.getParameter("wfInsId");
	String activityName = new String(request.getParameter(
							"activityName").getBytes("iso-8859-1"),
							"UTF-8");
	int num = new LaccManager().getNumAjdccl(yw_guid);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>analysis</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <%@ include file="/base/include/ext.jspf" %>
    <style type="text/css">
		html,body {
			font: normal 12px verdana;
			margin: 0;
			padding: 0;
			border: 0 none;
			overflow: hidden;
			height: 100%;
		}
	</style>
	<script type="text/javascript">
		Ext.onReady(function(){
			Ext.QuickTips.init();
			var w = document.body.clientWidth;
			var h = document.body.clientHeight * 0.95;
			var showPathF = "<%=basePath%>reduce/web/jinan/wfajcc/ajsccpb.jsp?jdbcname=YWTemplate&&zfjcName=违法案件查处&yw_guid=<%=yw_guid%>&wfInsTaskId=<%=wfInsTaskId%>&wfId=<%=wfId%>&edit=null&lyType=null&returnPath=<%=returnPath%>?*closeMenu*&zfjcType=7&activityName=<%=activityName%>&wfInsId=<%=wfInsId%>&docNodeName=案件调查处理审批表";
			var showPathN = "<%=basePath%>reduce/web/jinan/wfajcc/ajsccpb.jsp?jdbcname=YWTemplate&&zfjcName=违法案件查处&yw_guid=<%=yw_guid%>v02&wfInsTaskId=<%=wfInsTaskId%>&wfId=<%=wfId%>&edit=null&lyType=null&returnPath=<%=returnPath%>?*closeMenu*&zfjcType=7&activityName=<%=activityName%>&wfInsId=<%=wfInsId%>&docNodeName=案件调查处理审批表";
			var tabs = new Ext.TabPanel({
				renderTo:'statusTab',
				<% if(num == 2){ %>
					activeTab: 1,
				<% }else{%>
					activeTab:0,
				<%}%>
				frame:true,
				items:[
				{
					title:'表一',
					html:"<iframe width='" + w + "' height='" + h + "' src=" + showPathF + "/>"
				}
				<% if(num == 2){ %>
					
					,{
					title:'表二',
					html:"<iframe width='" + w + "' height='" + h + "' src=" + showPathN + "/>"
					}
				<%}%>
				]
			})
		})	
	</script>
</head>
  <body bgcolor="#FFFFFF">
    <div id="statusTab" style="width:100%"></div>
    <div id="graphwin" class="x-hidden">
      <div id="updateForm" style="margin-left:10px; margin-top:5px"></div>
    </div>  
  </body>
</html>