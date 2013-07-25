<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.net.URLDecoder" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.klspta.web.xuzhouWW.paddata.PadDatalist"%>
<%
	String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String yw_guid = request.getParameter("yw_guid"); 
    PadDatalist padlist=new PadDatalist();
	List list = padlist.getPADDataByYwguid(yw_guid); 
    Map map = (Map)list.get(0);
   	String xmmc = (String)map.get("XMMC")==null?"":(String)map.get("XMMC");
   	String xzqmc = (String)map.get("XZQMC")==null?"":(String)map.get("XZQMC");
   	String rwlx = (String)map.get("RWLX")==null?"":(String)map.get("RWLX");
   	String sfwf = (String)map.get("SFWF")==null?"":(String)map.get("SFWF");
   	String xcr = (String)map.get("XCR")==null?"":(String)map.get("XCR");
   	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
   	String xcrq = (String)map.get("XCRQ");
   	String xz = (String)map.get("XZ")==null?"":(String)map.get("XZ");;
   	String zmj = (String)map.get("ZMJ")==null?"":(String)map.get("ZMJ");;
   	String imgname = (String)map.get("IMGNAME")==null?"":(String)map.get("IMGNAME");
   	String cjzb = (String)map.get("CJZB")==null?"":(String)map.get("CJZB");
   	String jwzb = (String)map.get("JWZB")==null?"":(String)map.get("JWZB");	//经纬度坐标，外网服务器采集成果展现使用
   	String jwzbPolygon=padlist.getPolygon(jwzb);
   	jwzbPolygon=jwzbPolygon.replaceAll("\"","\\\\\"");
   	String url=basePath+"web/xuzhouWW/tdMap/fxgis/FxGIS.html?dolocation=true&p="+jwzbPolygon;
   	String xcqkms = (String)map.get("XCQKMC")==null?"":(String)map.get("XCQKMC");
       	System.out.println(url);
    String[] points = null;
    points = cjzb.split(",");
    String type = "polygon";
    if(points.length/2>3){
    	type = "polygon";
    }else if(points.length == 1){
    	type = "point";
    }
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
                title: '现场核查情况',
				html: "<iframe style='height:100%;width:100%' src='xchcqk.jsp?yw_guid=<%=yw_guid%>&xmmc=<%=xmmc%>&xzqmc=<%=xzqmc%>&rwlx=<%=rwlx%>&sfwf=<%=sfwf%>&xcr=<%=xcr%>&xcrq=<%=xcrq%>&xz=<%=xz%>&zmj=<%=zmj%>&imgname=<%=imgname%>&xcqkms=<%=xcqkms%>'/>"   
            },{
                title: '核查位置', 
                html: "<iframe style='height:100%;width:100%' src='<%=url%>' />" 
            },{
                title: '系统比对分析结果', 
                html: "<iframe style='height:100%;width:100%' src='bdfxResult.jsp?yw_guid=<%=yw_guid%>'/>"  
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

