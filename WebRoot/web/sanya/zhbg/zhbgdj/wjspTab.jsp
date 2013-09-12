<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String yw_guid = request.getParameter("yw_guid");
	String type = request.getParameter("type");
	String flag = request.getParameter("flag");
	if(yw_guid == null || "".equals(yw_guid)){
		yw_guid = UtilFactory.getStrUtil().getGuid();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>综合办公</title>
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
   <script>
   Ext.onReady(function(){
   	Ext.QuickTips.init();
    var w=document.body.clientWidth;
	var h=document.body.clientHeight - 30; 
    var tabs = new Ext.TabPanel({
        renderTo:'statusTab',
        activeTab: 0,  
        frame:true,
        items:[
        	{
                title: '<font size="2">登记表</font>',
                html: "<iframe width='"+w+"' height='"+h+"' src='wjspdjb.jsp?yw_guid=<%=yw_guid%>&type=<%=type%>&flag=<%=flag%>'/>" 
            },{
                title: '<font size="2">附件管理</font>',
                html: "<iframe width='"+w+"' height='"+h+"' src='/domain/model/accessory/dzfj/accessorymain.jsp?yw_guid=<%=yw_guid%>'/>" 
            }
        ]
    })
  });
  function back(){
			if("ybl" == "<%=type%>"){
				document.location.href = "/domain/web/sanya/zhbg/zhbgList/zhbgybl.jsp?flag=<%=flag%>";
			}else if("blz" == "<%=type%>"){ 
				document.location.href = "/domain/web/sanya/zhbg/zhbgList/zhbgblz.jsp";
			}else{
			}
		}
  
   </script>
  </head>
	<body bgcolor="#FFFFFF">
		<div id="return" align="right">
		  		<button class='btn' id="return" style="position: absolute; top: 3px; right: 5px" onclick="back()">
							返 回
				</button>
		  </div>
		<div id="statusTab" style="width:100%"></div>
		<div id="graphwin" class="x-hidden">
			<div id="updateForm" style="margin-left:10px; margin-top:5px"></div>
		</div>
	</body>
</html>
