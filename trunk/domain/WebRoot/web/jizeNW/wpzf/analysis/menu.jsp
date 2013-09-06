<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.web.jizeNW.wpzf.WpzfListManager"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String flag=request.getParameter("flag");
String yw_guid=request.getParameter("yw_guid");
String tbbh = request.getParameter("tbbh");
String pra;
if(yw_guid==null||"null".equals(yw_guid)){
   // PADDataList pDataList=new PADDataList();
	//String zb = pDataList.getTBZB(tbbh);
	//String[] zbs = zb.split(";");
	//String zbString = "";
	//for(String string : zbs){
	//	if(string.equals(zbs[zbs.length-1])){
	//		zbString += "[" + string + "]";
	//	}else {
	//		zbString += "[" + string + "],";
	 //   }
//	}
	pra="dolocation=true";
	//pra="dolocation=true&p={\"rings\":[[[117.245217,31.75036],[117.245213,31.749162],[117.245725,31.749154],[117.245725,31.749154],[117.246677,31.74915],[117.246781,31.749246],[117.246772,31.749845]]],\"spatialReference\":{\"wkid\":2362}}";
}else{
	WpzfListManager pDataList=new WpzfListManager();
	pra="dolocation=true&p="+pDataList.getXmzb(yw_guid);
}
String url=basePath+"web/dtjg/fxgis/fx/FxGIS.html?debug=true";
if(flag!=null&&!flag.equals("null")){
  //System.out.print("1");
  //url=basePath+"base/fxgis/fx/FxGIS.html?debug=true";
  url=basePath+"web/dtjg/fxgis/fx/FxGIS.html?"+pra;
  }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>中上</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<%@ include file="/base/include/ext.jspf" %>
  </head>
      <script type="text/javascript" src="<%=basePath%>web/dtjg/fxgis/framework/js/menu.js"></script>
<script type="text/javascript">
var yw_guid='<%=yw_guid%>';
var basePath='<%=basePath%>';
 var view;
Ext.onReady(function(){
 view=new Ext.Viewport({
		layout : "border",
		items : [{
					region : "north",
					contentEl : 'toolbar',
					height:40,
					margins : '0 0 -12 0',
					tbar : [{
								xtype : 'tbbutton',
								text : ' 放大',
								cls : 'x-btn-text-icon',
								icon : '<%=basePath%>base/fxgis/framework/images/zoom-in.png',
								tooltip : '放大',
								handler : zoomIn
							}, {
								xtype : 'tbbutton',
								text : '缩小',
								cls : 'x-btn-text-icon',
								icon : '<%=basePath%>base/fxgis/framework/images/zoom-out.png',
								tooltip : '缩小',
								handler :zoomOut
							},{
								xtype : 'tbbutton',
								text : '  漫游',
								cls : 'x-btn-text-icon',
								icon : '<%=basePath%>base/fxgis/framework/images/hand.png',
								tooltip : '漫游',
								handler : pan
							}, {
								xtype : 'tbbutton',
								text : '  全图',
								cls : 'x-btn-text-icon',
								icon : '<%=basePath%>base/fxgis/framework/images/Full_Extent.png',
								tooltip : '全图',
								handler : zoomToFullExtent
							}, {
								xtype : 'tbbutton',
								text : '前图',
								cls : 'x-btn-text-icon',
								icon : '<%=basePath%>base/fxgis/framework/images/Zoom_Back.png',
								tooltip : '前图',
								handler : zoomToPrevExtent
							}, {
								xtype : 'tbbutton',
								text : '后图',
								cls : 'x-btn-text-icon',
								icon : '<%=basePath%>base/fxgis/framework/images/Zoom_Forward.png',
								tooltip : '后图',
								handler : zoomToNextExtent
							}, {
								xtype : 'splitbutton',
								text : '量算',
								handler : function(){
									this.showMenu();
									frames["lower"].swfobject.getObjectById("FxGIS").panmap();
								},
								icon : '<%=basePath%>base/fxgis/framework/images/rule.png',
								menu : [{
											text : '直线量算',
											cls : 'x-btn-text-icon',
											icon : '<%=basePath%>base/fxgis/framework/images/line.png',
											tooltip : '直线量算',
											handler : measureLengths
										},{
											text : '面积量算',
											cls : 'x-btn-text-icon',
											icon : '<%=basePath%>base/fxgis/framework/images/showVertices.png',
											tooltip : '面积量算',
											handler : measureAreas
										}]
							},{
								xtype : 'tbbutton',
								text : '清除',
								cls : 'x-btn-text-icon',
								icon : '<%=basePath%>base/fxgis/framework/images/Clear.png',
								tooltip : '清除',
								handler : clear
							},{
									    	text : '全屏',
											id:'full_screen',
											cls : 'x-btn-text-icon',
											icon : '<%=basePath%>base/fxgis/framework/images/computer_16x16.png',
											tooltip : '全屏',
											handler : fullScreen
										},{
									    	text : '退出全屏',
											id : 'quit_full_screen',
											hidden : true,
											cls : 'x-btn-text-icon',
											icon : '<%=basePath%>base/fxgis/framework/images/nofullscreen.png',
											tooltip : '退出全屏',
											handler : quitFullScreen
										}]
				}, {
					region : "center",
					margins : '0 0 0 0',
					contentEl : 'mapDiv'
				}]
	});
	if(!parent.parent.content){
		Ext.getCmp('full_screen').setVisible(false);
	}	
});

</script>
  <body>
  <div id="toolbar" style="width:100%;height:40"></div>
  <div id="mapDiv">
  <iframe id="lower" name="lower"  style="width: 100%;height:100%; overflow: auto;" src=<%=url%>></iframe>
</div>
  </body>
</html>
