<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/taglib/queryLabel.tld" prefix="common"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String extPath = basePath + "thirdres/ext/";
	String year = request.getParameter("year");
	String yw_guid = request.getParameter("yw_guid");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>内网卫片图斑管理</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
		<style>
input,img {
	vertical-align: middle;
}
</style>
		<script type="text/javascript">
       Ext.onReady(function(){
       var w=document.body.clientWidth-20;
       var h=document.body.clientHeight-30;
       var tabs;
	   var tabs = new Ext.TabPanel({
        renderTo:'wpzfjcTab',
        activeTab: 0,     
        frame:true,
        items:[{
                title: '审批叠加',
               html: "<iframe width='"+w+"' height='"+h+"' src='<%=basePath%>/web/jizeNW/wpzf/analysis/spList.jsp?yw_guid=<%=yw_guid%>' />" 
           },{
                title: '供地叠加',
               html: "<iframe width='"+w+"' height='"+h+"' src='<%=basePath%>/web/jizeNW/wpzf/analysis/gdList.jsp?yw_guid=<%=yw_guid%>' />" 
           }
        ]
    })
       
    });
    function reurl(){
          url = location.href; //把当前页面的地址赋给变量 url
          var times = url.split("$"); //分切变量 url 分隔符号为 "$"
          if(times[1] != 1){ //如果$后的值不等于1表示没有刷新
          url += "&$1"; //把变量 url 的值加入 $1
          self.location.replace(url); //刷新页面
          }
    }
window.onload = function () { setTimeout("reurl();",1000) }
   
</script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="wpzfjcTab" style="width: 100%;"></div>
		
	</body>
</html>