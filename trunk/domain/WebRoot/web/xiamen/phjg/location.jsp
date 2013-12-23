<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//String jsonstring = request.getParameter("jsonstring");
//String url = basePath+"base/fxgis/fx/FxGIS.html?i=false&dolocation=true&p="+jsonstring;
//System.out.println(url+"===========================");
String objectId = request.getParameter("objectId");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
  </head>
  	<%@ include file="/base/include/ext.jspf" %> 	
  <script type="text/javascript">
Ext.onReady(function(){
	border =new Ext.Viewport( 
		{
		layout:"border",
		items:[
			    center = new Ext.Panel({ 
                region: 'center', // a center region is ALWAYS required for border layout
                contentEl: 'center',
                collapsible: false,
                margins:'0 0 0 0'
            }),
            { 
                region: 'east', // a center region is ALWAYS required for border layout
                contentEl: 'east',
                id:'east-panel',
                collapsible: true,
                margins:'0 0 0 0',
                width: 300,
                minSize: 0,
                maxSize: 300,
                collapsed: true,
                title:''
            },
			{
                    region:'west',
					id:'west-panel',
                    contentEl: 'mapTree',
                    split:true,
                    width: 200,
                    minSize: 0,
                    maxSize: 300,
                    collapsible: true,
                    title:'图层树',
                    collapsed: true,
                    margins:'0 0 0 0'
                }
			  ]
		}
	);
	
	
}
);
</script>
	<body>
		<iframe id="mapTree"  name="mapTree"  style="width: 100%; height: 100%;overflow: auto;" src="<%=basePath%>base/fxgis/framework/mapTree.jsp"></iframe>
		<iframe id="center" name="center"  style="width: 100%; height:100%;overflow: auto;border: 0px" src="<%=basePath%>web/xiamen/xchc/cglb/showLocation.jsp?type=1&yw_guid=<%=objectId%>"></iframe>
		<iframe id="east"  name="east"  style="width: 100%; height: 100%;overflow: auto;" src=""></iframe>
	</body>
</html>
