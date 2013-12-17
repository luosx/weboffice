﻿<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.klspta.web.cbd.xmgl.Xmmanager" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
  Xmmanager hxzm=new Xmmanager();
List<Map<String, Object>> list=hxzm.getHXXM();

%>

<html>
  <head>
    <title>CBD核心区储备开发及资金管理研究辅助决策系统</title>
    <style type="text/css">
table{
border-right:1px solid #C1DAD7;
border-bottom:1px solid #C1DAD7;
background-color:  #FDEFAC
}
table td{
border-left:1px solid #C1DAD7;
border-top:1px solid #C1DAD7;

} 
    </style>
 <script type="text/javascript">
   function lint(yw_guid){
   alert(yw_guid);
    var url=parent.right.location.href=('<%=basePath%>web/cbd/xmgl/contentTab.jsp?yw_guid='+yw_guid);
    document.location.reload();
    }
    
    </script>
</head>
  	<body>
  	<table  topmargin="0" leftmargin="0" style="overflow: scroll;">
  	<tr bgcolor="#FEA639">
  	<td align="center" onclick="">编号</td>
    <td align="center" onclick=""> 红线项目名称</td>
  	</tr>
  	<%for(int i=0;i<list.size();i++){%>
  	<tr  onclick="lint('<%=list.get(i).get("yw_guid").toString() %>')">
  	<td align="center"> <%=list.get(i).get("rownum").toString() %></td>
    <td align="center"> <%=list.get(i).get("xmname") .toString()%></td>
  	</tr>
   <%} %>
  	</table>
  	</body>
</html>
