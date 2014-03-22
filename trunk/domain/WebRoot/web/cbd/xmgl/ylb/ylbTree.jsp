<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.klspta.web.cbd.xmgl.Xmmanager" %>
<%@page import="com.klspta.model.accessory.dzfj.AccessoryOperation"%>
<%@page import="com.klspta.base.util.bean.ftputil.AccessoryBean"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String yw_guid = request.getParameter("yw_guid");
AccessoryOperation ao = AccessoryOperation.getInstance();
List<AccessoryBean> list = ao.getAccessorylistByYwGuid(yw_guid);
String type=request.getParameter("type");
String editor=request.getParameter("editor");
	String xmmc = request.getParameter("xmmc");
	if (xmmc != null) {
		xmmc = new String(xmmc.getBytes("iso-8859-1"), "utf-8");
	} else {
		xmmc = "";
	}
%>

<html>
  <head>
    <title>CBD核心区储备开发及资金管理研究辅助决策系统</title>
   <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf" %>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <style type="text/css">
    
table{
border-right:1px solid #C1DAD7;
border-bottom:1px solid #C1DAD7;
background-color:  #FDEFAC;
}
table td{
border-left:1px solid #C1DAD7;
border-top:1px solid #C1DAD7;

} 
    </style>
 <script type="text/javascript">
  Ext.onReady(function() {
        var i = 0;
	    var tree = new Ext.tree.TreePanel({
	        useArrows:true,
	        autoScroll:true,
	        animate:true,
	        enableDD:true,
	        margins: '0 0 0 0',
	        border: false,
	        containerScroll: true,
	        rootVisible: false,
	        frame: true,
	        loader: new Ext.tree.TreeLoader(),
	        root: new Ext.tree.AsyncTreeNode({
	            expanded: true,
	            children: [
	            	<%if(list.size()>0){%>
		                <%for(int i=0;i<list.size()-1;i++){
		                	if(list.get(i).getFile_type().equals("file")){
		                %>
		            	{text:'<%=list.get(i).getFile_name()%>',leaf:1,id:'<%=list.get(i).getFile_path()%>'},
		            	<%}}%>
		            	{text:'<%=list.get(list.size()-1).getFile_name()%>',leaf:1,id:'<%=list.get(list.size()-1).getFile_path()%>'}
	            	<%}%>
	            ]
	        }),
	         listeners: {//单击右侧进行修改
	         'click': function(node, e){
	                var nodeid=node.attributes.id;
	                var nodetest = node.attributes.text;
	                var parentMenuTreeId;
	                if(node.leaf){
	                	parentMapTreeId=node.attributes.parentId;
	                }else{
	                	parentMapTreeId='0';
	                }
	                if(i==0){
	                	i=1;
		                parent.right.document.getElementById("img1").src="<%=basePath%>//model//accessory//dzfj//download//"+nodeid;
	                }else if(i==1){
	                	i=2;
	                	parent.right.document.getElementById("img2").src="<%=basePath%>//model//accessory//dzfj//download//"+nodeid;
	                }else if(i==2){
	                	parent.right.document.getElementById("img3").src="<%=basePath%>//model//accessory//dzfj//download//"+nodeid;
	                	i=0
	                }
	             }
	         }
	    });
	    //表单FormPanel
        var form = new Ext.form.FormPanel({
        renderTo: 'mapTree',
        title   : '项目列表',
        autoHeight: true,
        width   : 500,
       
        bodyStyle: 'padding: 0px',
        defaults: {
            anchor: '0'
        },
        items   : [
        		tree
   				]
    });
   function lint(yw_guid,xmmc){
    var url=parent.right.location.href=('<%=basePath%>web/cbd/xmgl/contentTab.jsp?yw_guid='+yw_guid+'&xmmc='+xmmc+'&type=<%=type%>&editor=<%=editor %>');
    document.location.reload();
    }
    });
    
    </script>
</head>
<body bgcolor="#FFFFFF" >
		<div id="mapTree"  style="width:500px;height:500px;OVERFLOW-y:auto;  "/>
	</div></body>
</html>
