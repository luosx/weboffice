<%@ page language="java"  pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
     ProjectInfo project=ProjectInfo.getInstance();
    String name = project.getProjectName();
    String loginname1=project.getProjectLoginName1();
    String loginname2=project.getProjectLoginName2();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>执法监察系统</title>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <meta http-equiv="description" content="This is my page">
        <style type="text/css">

body {
    margin-left: 0px;
    margin-top: 0px;
    margin-right: 0px;
    margin-bottom: 0px;
}
    font.style1 {
    font-family: "微软雅黑";
    color: #FFFFFF;
    font-size:26px;
    font-weight: bolder;
  }
  font.style2 {
    color: #BAF7FF;
    font-size:15px;
    font-weight: bolder;
   }
</style>
        <link href="web/<%=name%>/framework/css/style.css" rel="stylesheet"
            type="text/css" />
</head>
    <body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="607" background="<%=basePath%>web/<%=name%>/framework/images/logo_bak.gif">
    <div  style="margin-top: 2%;margin-left: 20%"><font class="style1"><%=loginname1 %></font></div>
    <div  style="margin-top: 0.5%;margin-left: 21%"><font class="style2"><%=loginname2 %></font></div>
    </td>
    <td background="<%=basePath%>web/<%=name%>/framework/images/webbj.jpg">&nbsp;</td>
    <td width="397"  background="<%=basePath%>web/<%=name%>/framework/images/banner_bk.gif">
    <object id="FlashID" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="397" height="106">
      <param name="movie" value="<%=basePath%>web/<%=name%>/framework/images/banner.swf" />
      <param name="quality" value="high" />
      <param name="swfversion" value="8.0.35.0" />
      <!-- 此 param 标签提示使用 Flash Player 6.0 r65 和更高版本的用户下载最新版本的 Flash Player。如果您不想让用户看到该提示，请将其删除。 -->
      <param name="expressinstall" value="<%=basePath%>web/<%=name%>/framework/js/expressInstall.swf" />
      <!-- 下一个对象标签用于非 IE 浏览器。所以使用 IECC 将其从 IE 隐藏。 -->
      <!--[if !IE]>-->
      <object type="application/x-shockwave-flash" data="<%=basePath%>web/<%=name%>/framework/images/banner.swf" width="476" height="106">
        <!--<![endif]-->
        <param name="quality" value="high" />
        <param name="swfversion" value="8.0.35.0" />
        <param name="expressinstall" value="<%=basePath%>web/<%=name%>/framework/js/expressInstall.swf" />
        <!-- 浏览器将以下替代内容显示给使用 Flash Player 6.0 和更低版本的用户。 -->
        <div>
          <h4>此页面上的内容需要较新版本的 Adobe Flash Player。</h4>
          <p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="获取 Adobe Flash Player" width="112" height="33" /></a></p>
        </div>
        <!--[if !IE]>-->
      </object>
      <!--<![endif]-->
    </object></td>
  </tr>
</table>
    </body>
</html>
