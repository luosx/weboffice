<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.klspta.web.xiamen.jcl.BuildDTPro"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String yw_guid=request.getParameter("yw_guid");
String type = request.getParameter("type");
String pra = "";
if(!(type == null || type.equals("") || type.equals("null"))){
    pra = BuildDTPro.getPar(yw_guid, Integer.parseInt(type));
}
//String url=basePath+"base/fxgis/fx/FxGIS.html?debug=true&i=true&is=xq,0,parea,123.05";
String url=basePath+"base/fxgis/fx/FxGIS.html?debug=true&i=false";
url += "&"+pra;
System.out.println(url);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>中上</title>
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf" %>
  </head>
      <script type="text/javascript" src="<%=basePath%>base/fxgis/framework/js/menu.js"></script>
      <script type="text/javascript" src="<%=basePath%>base/fxgis/framework/js/flexCallback.js"></script>
      <script type="text/javascript" src="<%=basePath%>base/fxgis/framework/js/fields_to_chinese.js"></script>
      <script src="<%=basePath%>/base/fxgis/framework/js/toJson.js"></script>
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
							    text : '属性查询',
								cls : 'x-btn-text-icon',
								icon : '<%=basePath%>base/fxgis/framework/images/isearch.png',
								tooltip : '属性查询',
								handler : identify
								},{
							     text : '图斑查询',
								cls : 'x-btn-text-icon',
								icon : '<%=basePath%>base/fxgis/framework/images/ygfx.png',
								tooltip : '图斑查询',
								handler:tbQuery							
							},{
								xtype : 'splitbutton',
								text : '工具箱',							
								handler : function(){
									this.showMenu();
									frames["lower"].swfobject.getObjectById("FxGIS").panmap();
								},
								icon : '<%=basePath%>base/fxgis/framework/images/box.png',
								menu : [{
											text : 'shape导入',
											cls : 'x-btn-text-icon',
											icon : '<%=basePath%>base/fxgis/framework/images/importshp.png',
											tooltip : 'shape导入',
											handler : shpimport
										},{
											text : '坐标定位',
											cls : 'x-btn-text-icon',
											icon : '<%=basePath%>base/fxgis/framework/images/location.png',
											tooltip : '坐标定位',
											handler : doLocation
										},{
											text : '地图图例',
											cls : 'x-btn-text-icon',
											icon : '<%=basePath%>base/fxgis/framework/images/legend.png',
											tooltip : '地图图例',
											handler : legend
										},{
											text : '图层透视',
											cls : 'x-btn-text-icon',
											icon : '<%=basePath%>base/fxgis/framework/images/torch.png',
											tooltip : '图层透视',
											handler : doShutter
										},{
											text : '多窗口对比',
											cls : 'x-btn-text-icon',
											icon : '<%=basePath%>base/fxgis/framework/images/multi-window.png',
											tooltip : '多窗口对比',
											handler : morewindows
										},{
											text : '打印',
											cls : 'x-btn-text-icon',
											icon : '<%=basePath%>base/fxgis/framework/images/printer.png',
											tooltip : '打印',
											handler : mapPrint
										},{
									    	text : '点标记',
											id : 'drawPoint',
											cls : 'x-btn-text-icon',
											icon : '<%=basePath%>base/fxgis/framework/images/point1.png',
											tooltip : '点标记',
											handler : drawPoint
										},{
									    	text : '面标记',
											id : 'drawPolygon',
											cls : 'x-btn-text-icon',
											icon : '<%=basePath%>base/fxgis/framework/images/showVertices.png',
											tooltip : '面标记',
											handler : drawPolygon
										}]
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
    <div id="result-win" class="x-hidden">    </div>
    <div id="result-tabs"></div>
    <div id='properties'   title="图斑属性" style="overflow: scroll;"></div>
    <div id='xz'  title="现状叠加分析" style="overflow: scroll; "></div>
    <div id='gh'   title="规划叠加分析" style="overflow: scroll;"></div>
  </body>

</html>
