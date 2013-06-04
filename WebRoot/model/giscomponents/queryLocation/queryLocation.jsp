<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String zfjcType=request.getParameter("zfjcType");
String yw_guid=request.getParameter("yw_guid");
if("43".equals(zfjcType)){;
   yw_guid=yw_guid.split("\\$")[1];
}
System.out.print(yw_guid);
String dkid = request.getParameter("dkId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>地图定位</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <%@ include file="/base/include/ext.jspf" %>
	<script src="<%=basePath%>ext/examples/ux/fileuploadfield/FileUploadField.js" type="text/javascript"></script>
	<script src="<%=basePath%>common/js/json2String.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>ext/examples/ux/fileuploadfield/css/fileuploadfield.css"/>	
	<script type="text/javascript" src="<%=basePath%>/gisapp/pages/components/queryLocation/queryLocation.js"></script>
  	<style>		
		.btn {
	background: url('<%=basePath%>base/form/images/button.png');
	height:23;
	width:73;
	CURSOR: hand;
	FONT-SIZE: 12px;
	color:#CC3300 ;
	BORDER-RIGHT: #002D96 0px solid;
	BORDER-TOP:#002D96 0px solid; 
	BORDER-LEFT: #002D96 0px solid;
	BORDER-BOTTOM: #002D96 0px solid
	}
	</style>
	<script type="text/javascript">
	var zfjcType="<%=zfjcType%>";
	var yw_guid="<%=yw_guid%>";
	var basePath="<%=basePath%>";
	var dkid = "<%=dkid%>";
	</script>
  </head>

	<body onload="initYw()">
	<button onClick='queryLocation()' class='btn'>定位</button>
	<%
	if("2".equals(zfjcType)){
	%>
	<button onClick="drawLocation('polyline')" class='btn'>路线规划</button>
	<button onClick="delLocation()" class='btn'>删除</button>
	<%
	}
	if("1".equals(zfjcType)){
	%>
	<button onClick="drawLocation('point')" class='btn'>举报地点</button>
	<button onClick="drawLocation('polyline')" class='btn'>举报路线</button>
	<button onClick="drawLocation('polygon')" class='btn'>举报区域</button>
	<button onClick="delLocation()" class='btn'>删除</button>
	<%
	}
	if("21".equals(zfjcType)){
    %>
<script type="text/javascript">
Ext.onReady(function(){
	var _$ID = '';
	var shapefileType;
	
	var fp = new Ext.form.FormPanel({
        renderTo: 'scan',
        fileUpload: true,
        autoWidth: true,
        autoHeight: true,
		bodyStyle: 'padding: 5px 0px 0 5px;',
        labelWidth: 10,
        items: [{
            xtype: 'fileuploadfield',
            id: 'form_file',
            emptyText: '请选择shp文件',
            name: 'shape_path',
            buttonText: '浏览',
			width:270
        },{
        	xtype: 'textfield',
            name:'yw_guid',
            id: 'yw_guid',
            value: yw_guid,
            hidden: true
        },{
        	xtype: 'textfield',
            name:'dkid',
            id: 'dkid',
            value: dkid,
            hidden: true        	
        },{
        	xtype: 'textfield',
            name:'zfjcType',
            id: 'zfjcType',
            value: zfjcType,
            hidden: true        	
        },{
        	xtype: 'textfield',
            name:'shapefileType',
            id: 'shapeType',
            hidden: true        	
        },{
        	xtype: 'textfield',
            name:'arrays',
            id: 'arrays',
            hidden: true        	
        }],
        buttons: [{
            text: '预览',
            handler: function(){
            	var fileType = Ext.getCmp("form_file").getValue().substring(Ext.getCmp("form_file").getValue().lastIndexOf(".")+1);  
                if(fp.getForm().isValid()){
                	if(fileType == "shp"){
		                fp.getForm().submit({
							url: center.center.restUrl + 'parseShapefile/parseShapefile?objectid=0&bjectid2=' + _$ID,
							method:'POST', 
							waitTitle:'提示',
		                    waitMsg: '正在导入,请稍后...',
		                    success: function(form,action){
		                    	
		                    },
	                        failure:function(form,action){
								var json=strToJson(action.response.responseText);
								//alert(json[0].geo);
								var polygon = new esri.geometry.Polygon(center.center.getMapSpatialReference());
								shapefileType = json[0].shapefileType;
								Ext.getCmp("shapeType").setValue(shapefileType);
								Ext.getCmp("arrays").setValue(json[0].geo);
								//alert(shapefileType);
								for(var i = 0; i < json[0].geo.length; i++){
									var geo = json[0].geo;
									polygon.addRing(geo[i]);
								}
								//if(shapefileType == "ploygon"){
									Ext.getCmp("save").disable().enable();
								//}							
								var highlightGraphic = new esri.Graphic(polygon,center.center.commonbluelight);
			                    center.center.addHighlight(highlightGraphic);
			                    center.center.setMapExtent(polygon.getExtent().expand(3));
	                        }
		                });
                	}else{
                		alert("请选择shp文件！");
                	}
                }
            }
        },{
            text: '保存',
            id:'save', 
            disabled:true,  
            handler: function(){
            	shapefileType = Ext.getCmp("shapeType").getValue();
            	arrays = Ext.getCmp("arrays").getValue();
            	zfjcType = Ext.getCmp("zfjcType").getValue();
            	yw_guid = Ext.getCmp("yw_guid").getValue();
            	dkid = Ext.getCmp("dkid").getValue();
            	fp.getForm().submit({
					url: basePath + "sdxcDataOperationAC.do?method=saveSdxc&yw_guid="+yw_guid+"&zfjcType="+zfjcType+"&arrays="+arrays+"&dkid="+dkid+"&shapefileType="+shapefileType,
					method:'POST', 
					waitTitle:'提示',
		            waitMsg: '正在保存,请稍后...',
		            success: function(form,action){
		            	Ext.MessageBox.alert('提示','保存成功！'); 
		            },
	                failure:function(form,action){
						Ext.MessageBox.alert('提示','保存失败！'); 
	                }
		      });
            }
        }]
    });
});
</script>	
	<button onClick="delSdxc()" class='btn'>删除</button>
	<div id="scan" style="width:100%"></div>    
    <%
	}
    %>
		<iframe id="center" style="width: 100%; height: 95%;overflow: auto;"
			src="<%=basePath%>/base/gis/pages/gisViewFrame.jsp"></iframe>

	</body>
</html>

