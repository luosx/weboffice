<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String userId = ((User)principal).getUserID();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>首页</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf" %>
	<style type="text/css">
	 body { background-image: url();}
	</style>
	<script type="text/javascript">
		
   </script>
</head>
<body>
	<div style="position:absolute; bottom: 20px;right: 30px" align="right"><img src="base/form/images/back1.png"  width="50px" height="50px" title="地图" onClick="javascript:window.location.href='sy.jsp'"  /></div>
   <div align="center" style="width: 100%;height: 95%">
     	<img src="web/cbd/sy/zkj.png" height="460px" width="850px" border="0" usemap="#planetmap" alt="总体设计图" />
              <map name="planetmap"  id="planetmap">
             	 <area shape="circle" coords="250,50,20"  href ="<%=basePath%>web/cbd/qyjc/esfzj/contentTab.jsp?closeMenu=*closeMenu*&view=R" alt="监测分析" /> 
             	 <area shape="circle" coords="530,50,20"  href ="<%=basePath%>web/cbd/dtjc/tjbbTab/contentTab.jsp?view=R" alt="实施监管" /> 
             	 <area shape="circle" coords="735,50,20"  href ="<%=basePath%>/web/cbd/zcgl/tdzcgl/tdzcEditor.jsp?view=R" alt="资产管理" />
             	 <area shape="circle" coords="160,108,20" href ="<%=basePath%>web/cbd/qyjc/esfzj/contentTab.jsp?closeMenu=*closeMenu*&view=R" alt="区域监测" /> 
             	 <area shape="circle" coords="340,108,20" href ="<%=basePath%>web/cbd/jtfx/ztt/zttredirectl.jsp?zttbh=1" alt="决策分析" />
             	 <area shape="circle" coords="480,108,20" href ="<%=basePath%>web/cbd/dtjc/tjbbTab/contentTab.jsp?view=R" alt="统筹决策" />
             	 <area shape="circle" coords="580,108,20" href ="<%=basePath%>web/cbd/yzt/cbjhzhb/xmcbEditor.jsp" alt="项目管理" />
             	 <area shape="circle" coords="660,108,20" href ="<%=basePath%>/web/cbd/zcgl/tdzcgl/tdzcEditor.jsp?view=R" alt="土地资产管理" />
             	 <area shape="circle" coords="730,108,20" href ="<%=basePath%>web/cbd/zcgl/fyzc/contentTab.jsp?view=R" alt="房源资产管理" />
             	 <area shape="circle" coords="800,108,20" href ="<%=basePath%>web/cbd/zcgl/azfzcgl/azfzcTab.jsp?view=R" alt="安置房用地资产管理" />
             	 <area shape="circle" coords="130,165,20" href ="<%=basePath%>web/cbd/qyjc/esfzj/contentTab.jsp?closeMenu=*closeMenu*&view=R" alt="二手房市场监测" />
             	 <area shape="circle" coords="195,165,20" href ="<%=basePath%>web/cbd/qyjc/xzlzjjc/xzljcTab.jsp?closeMenu=*closeMenu*&view=R" alt="写字楼租金监测" />
             	 <area shape="circle" coords="275,165,20" href ="<%=basePath%>web/cbd/jtfx/ztt/zttredirectl.jsp?zttbh=1" alt="静态均衡成本分析（横向）" />
             	 <area shape="circle" coords="335,165,20" href ="<%=basePath%>web/cbd/jtfx/sccsnlfx/sccsnlfxFrame.jsp" alt="市场承受能力分析（纵向）" />
             	 <area shape="circle" coords="390,165,20" href ="<%=basePath%>web/cbd/sccsl/gzzcyj.jsp?view=R" alt="搬迁政策研究" />
             	 <area shape="circle" coords="485,160,28" href ="<%=basePath%>web/cbd/dtjc/tjbbTab/contentTab.jsp?view=R" alt="全域决策" />
             	 <area shape="circle" coords="585,160,28" href ="<%=basePath%>web/cbd/xmgl/xmglMain.jsp?closeMenu=*closeMenu*&type=ZJLR@ZJZC@YJKFZC@QQFY@CQFY@SCFY@SZFY@CWFY@GLFY@CRZJFH@QTZC&editor=n@n@n@n@n@n@n@n@n@n@n" alt="项目开发管理" />
             	 <area shape="circle" coords="475,230,23" href ="<%=basePath%>web/cbd/zxzjgl/contentTab.jsp" alt="全域资金监管" />
             	 <area shape="circle" coords="575,230,23" href ="<%=basePath%>web/cbd/dtjc/tjbbTab/contentTab.jsp?view=R" alt="项目报告（输出）" />
             	 <area shape="circle" coords="40,305,30"  href ="<%=basePath%>/web/cbd/zcgl/tdzcgl/tdzcEditor.jsp?view=R" alt="土地储备库" />
             	 <area shape="circle" coords="250,305,30" href ="<%=basePath%>web/cbd/qyjc/esfzj/contentTab.jsp?closeMenu=*closeMenu*&view=R" alt="规划储备资源" />
             	 <area shape="circle" coords="530,305,30" href ="<%=basePath%>web/cbd/yzt/cbjhzhb/xmcbEditor.jsp" alt="红线储备资源" />
             	 <area shape="circle" coords="735,305,30" href ="<%=basePath%>web/cbd/swcbzy/swcbViewFrame.jsp?closeMenu=*closeMenu*" alt="实物储备资源" />
             	 <area shape="circle" coords="40,405,30"  href ="<%=basePath%>/web/cbd/yzt/zrb/showR/zrbEditor.jsp" alt="底层数据库" />
             	 <area shape="rect" coords="345,375,430,405" href ="<%=basePath%>web/cbd/yzt/jbb/showList/jbbEditor.jsp" alt="基本地块数据库" />
             	 <area shape="rect" coords="345,405,430,435" href ="<%=basePath%>/web/cbd/yzt/zrb/showR/zrbEditor.jsp" alt="自然斑数据库" />
             	 <area shape="circle" coords="735,385,30" href ="<%=basePath%>web/cbd/yzt/kgzb/kgzbViewFrame.jsp?closeMenu=*closeMenu*&view=R" alt="规划指标数据库" />
             	 
             </map>
              </div>
              <div align="center"><h3>系统总体设计图</h3></div>
</body>
</html>