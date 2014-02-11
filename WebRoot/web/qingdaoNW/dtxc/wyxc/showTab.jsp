<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.net.URLDecoder" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.klspta.web.qingdaoWW.moblie.MobileDataList"%>
<%
	String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String yw_guid = request.getParameter("yw_guid"); 
    MobileDataList padlist=new MobileDataList();
	List list = padlist.getPADDataByYwguid(yw_guid); 
    Map map = (Map)list.get(0);
    String ydwz = (String)map.get("YDWZ")==null?"":(String)map.get("YDWZ");
   	String xmmc = (String)map.get("XMMC")==null?"":(String)map.get("XMMC");
   	String yddw = (String)map.get("yddw")==null?"":(String)map.get("yddw");
   	String ydsj = (String)map.get("ydsj")==null?"":(String)map.get("ydsj");
   	String jsqk = (String)map.get("jsqk")==null?"":(String)map.get("jsqk");
   	String ydxz = (String)map.get("ydxz")==null?"":(String)map.get("ydxz");
   	String xcr = (String)map.get("xcr")==null?"":(String)map.get("xcr");
   	String xcrq = (String)map.get("xcrq")==null?"":(String)map.get("xcrq");
   	String bz = (String)map.get("bz")==null?"":(String)map.get("bz");
   	String pmzb = (String)map.get("pmzb")==null?"":(String)map.get("pmzb");
   	String imgname = (String)map.get("imgname")==null?"":(String)map.get("imgname");
   	String jwzb = (String)map.get("jwzb")==null?"":(String)map.get("jwzb");	//经纬度坐标，外网服务器采集成果展现使用
   	String url=basePath+"web/qingdaoWW/baidumap/pages/baiduMap.jsp?points="+jwzb;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>详细信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/base/include/ext.jspf" %>
		<%@ include file="/base/include/restRequest.jspf"%>
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
    var height = document.body.clientHeight;
    var tabs = new Ext.TabPanel({
        renderTo:'statusTab',
        activeTab: 0,     
        frame:true,
		height:700,
        items:[{
                title: '实地核查信息',
				html: "<iframe style='height:100%;width:100%' src='xchcqk.jsp?guid=<%=yw_guid%>&xmmc=<%=xmmc%>&ydwz=<%=ydwz%>&yddw=<%=yddw%>&ydsj=<%=ydsj%>&jsqk=<%=jsqk%>&xcr=<%=xcr%>&xcrq=<%=xcrq%>&ydxz=<%=ydxz%>&bz=<%=bz%>&pmzb=<%=pmzb%>&imgname=<%=imgname%>'/>"   
            },{
                title: '图斑位置', 
                html: "<iframe style='height:100%;width:100%' src='<%=url%>' />" 
            },{
                title: '叠加分析结果', 
                html: "<iframe style='height:100%;width:100%' src='bdfxResult.jsp' />" 
            }
        ]
    })
  });
  
   </script>
  </head>
	<body bgcolor="#FFFFFF">
		<div id="statusTab" style="width:100%;height:100%"></div>
		<div id="graphwin" class="x-hidden">
			<div id="updateForm" style="margin-left:10px; margin-top:5px"></div>
		</div>	
	</body>
</html>

