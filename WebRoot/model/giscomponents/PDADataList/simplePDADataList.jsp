<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/taglib/label.tld" prefix="common"%>
<%@page import="com.klspta.gisapp.components.pda.pdadataList.PDADataList" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    String gridPath = basePath + "thirdres/dhtmlx/dhtmlxGrid";
    String extPath = basePath + "thirdres/ext/";
    PDADataList list=new PDADataList();
    String rows=list.getSimplePDADataList();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>PDA发回的外业核查成果列表</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="../componentsbase.jspf" %>
		<%@ include file="/common/include/ext.jspf" %>
		<script src="<%=basePath%>/common/js/ajax.js"></script>
		<script type="text/javascript">
		var myData;
Ext.onReady(function(){
	myData= <%=rows%>;//采用json格式存储的数组
    // create the data store
    var store = new Ext.data.ArrayStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: '序号'},
           {name: 'PDA名称'},
           {name: '接收时间'},
           {name: '数据类型'}
        ]
    });
    
    store.load({params:{start:0, limit:15}});
    
    var grid = new Ext.grid.GridPanel({
        store: store,
        columns: [
            {header: '序号', width: 40, sortable: true},
            {header: '名称', width: 60, sortable: true},
            {header: '接收时间', width: 90, sortable: false},
            {header: '类型', width: 70, sortable: true}
        ],
        stripeRows: true,
        height: 420,
        // config options for stateful behavior
        stateful: true,
        stateId: 'grid',
        bbar: new Ext.PagingToolbar({
        pageSize: 15,
        store: store
        })
    });
    
    grid.render('mygrid_container'); 
    
        grid.on('cellclick',function(e){
        var row = grid.getSelectionModel().getSelected();
        var rowid=row.data.序号-1;
        //alert(rowid)
		var dataid = myData[rowid][6];
		var dataType=myData[rowid][3];
		//alert(dataid)
		//alert(dataType)
		var url = 'http://gisserver:8399/arcgis/rest/services/YZ_WYXCHC/MapServer/2';
		//var infoTemplate = new esri.InfoTemplate();
		//infoTemplate.setTitle("${NAME}");
        //infoTemplate.setContent("<b>2000 Population: </b>${POP2000}<br/>"
            //                 + "<b>2000 Population per Sq. Mi.: </b>${POP00_SQMI}<br/>"
            //                 + "<b>2007 Population: </b>${POP2007}<br/>"
            //                 + "<b>2007 Population per Sq. Mi.: </b>${POP07_SQMI}");
		
		var query = new esri.tasks.Query();
        query.outFields = ["*"];
        query.returnGeometry = true;
        query.where = "dataid='"+dataid+"'";
        query.outSpatialReference = parent.center.center.getMapSpatialReference();
	    var queryTask = new esri.tasks.QueryTask(url);
        queryTask.execute(query,showResults,errback);
		
		//fbutton.onEnable(true);
		
    });
    
    function errback(obj){
	alert('定位失败。')
	}
   function showResults(featureSet) {
		    parent.center.center.clearHighlight();
		    var graphic = featureSet.features[0];
			//graphic.setInfoTemplate(infoTemplate);
			//alert(featureSet.features[0].getContent());
	        var highlightGraphic = new esri.Graphic(graphic.geometry,parent.center.center.commonsfs);
		    parent.center.center.addHighlight(highlightGraphic);
		    parent.center.center.setMapExtent(graphic.geometry.getExtent().expand(7));
   } 
}
)
/*处理删除操作 add by 郭 2011-1-20*/
function del(id){
 return "<a href='#' onclick='delteTask("+id+");return false;'><img src='gisapp/images/delete.png' alt='删除'></a>";
}
/*处理查看操作 add by 郭 2011-1-20*/
function view(id){
 return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='gisapp/images/view.png' alt='查看'></a>";
}
/*导出成功包*/
function exp(id){
 return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='gisapp/images/export.png' alt='导出'></a>";
}
function createTask(){
window.open("<%=basePath%>/createTask.do?method=createTask");
}
function viewDetail(id){
var yw_guid=myData[id][9]
window.open("<%=basePath%>/common/pages/resourcetree/resourceTree.jsp?yw_guid="+yw_guid);   

}
/*删除 add by 郭 2011-1-20*/
function delteTask(id){
var yw_guid=myData[id][9]
Ext.MessageBox.confirm('注意', '删除后不能恢复，您确定吗？',function(btn){
  if(btn=='yes'){
var path = "<%=basePath%>";
    var actionName = "taskManageAC";
    var actionMethod = "deleteTask";
    var parameter="yw_guid="+yw_guid;
	var result = ajaxRequest(path,actionName,actionMethod,parameter);
	document.location.reload();
	}
	else{
	return false;
	}
});

  }
</script>
	</head>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container" style="width: 100%; height: 80%;"></div>
		</body>
</html>