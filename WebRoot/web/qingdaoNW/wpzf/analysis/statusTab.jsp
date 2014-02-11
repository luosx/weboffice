<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String extPath = basePath + "ext/";
    String yw_guid=request.getParameter("yw_guid");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
   <script>
Ext.onReady(function(){
   Ext.QuickTips.init();
   var scrHeight= document.body.offsetHeight-20; //(包括边线的高)457
   var accordion = new Ext.Panel({
    renderTo :"legendTab",
    layout:'accordion',
    layoutConfig: {
        // layout-specific configs go here
        titleCollapse: true,
        animate: true,
        activeOnTop: false,
        hideCollapseTool  : true,
        autoLoad : true
    },
   items: [
               		{   
		                title: '基本属性',
		                html: "<iframe style='height:"+(scrHeight-95)+"PX; width:350px;' src='jbsxList.jsp?yw_guid=<%=yw_guid %>' />"            
		       		}, 
	            	{
		                title: '批供分析',
		                html: "<iframe name='pigong' style='height:"+(scrHeight-95)+"PX; width:350px' src='ywTab.jsp?yw_guid=<%=yw_guid %>' />",
		                listeners :{
		                    activate: {
                            fn: function(){ setTimeout(function() {pigong.location.reload();},500); }
		                    }
		                }             
		       		}, 
	            	{   
		                title: '现状分析', 
		                html: "<iframe name='xianzhuang' style='height:"+(scrHeight-95)+"PX; width:350px' src='xzTab.jsp?yw_guid=<%=yw_guid %>' />",
		                listeners :{
		                    activate: {
                            fn: function(){ setTimeout(function() {xianzhuang.location.reload();},500); }
		                    }
		                }              
		       		}, 
	            	{
		                title: '规划分析',    
		                html: "<iframe name='guihua' style='height:"+(scrHeight-95)+"PX; width:350px' src='ghList.jsp?yw_guid=<%=yw_guid %>' />",
		                listeners :{
		                    activate: {
                            fn: function(){ setTimeout(function() {guihua.location.reload();},500); }
		                    }
		                }             
		       		}, 
	            	{
		                title: '历史核查情况分析',    
		                html: "<iframe name='lishi' style='height:"+(scrHeight-95)+"PX; width:350px' src='lshcqkList.jsp?yw_guid=<%=yw_guid %>' />",
		                listeners :{
		                    activate: {
                            fn: function(){ setTimeout(function() {lishi.location.reload();},500); }
		                    }
		                }              
		       		}
            ]
});

  });
   </script>
  </head>
	<body >
		<div id="legendTab" style='height:100%;width:100%; '></div>	
	</body>
</html>