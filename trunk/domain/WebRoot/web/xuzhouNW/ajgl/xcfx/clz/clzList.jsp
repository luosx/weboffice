<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    String flag=request.getParameter("flag");
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    User user=null;
        if (principal instanceof User) {
            user =(User) principal;
        }
    String status=request.getParameter("status");//案件状态
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
			
		<title>执法监察总体数据预览</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script src="<%=basePath%>/base/include/ajax.js"></script>
		<%@ include file="/base/include/ext.jspf" %>
		<%@ include file="/base/include/restRequest.jspf" %>
		<script type="text/javascript" src="<%=basePath%>base/thirdres/ext/examples/ux/PagingMemoryProxy.js"></script>
		<script type="text/javascript" src="<%=basePath%>base/thirdres/ext/examples/ux/ProgressBarPager.js"></script>
		<style>
		input,img{vertical-align:middle;cursor:hand;}
		</style>
		<script type="text/javascript">
		var myData;
		var store;
		var grid;
		var _$ID = '';
		var scrWidth=screen.availWidth;
    	var scrHeight=screen.availHeight; 
Ext.onReady(function(){
	putClientCommond("dtxcList","getDtList");
    putRestParameter("flag",<%=flag%>);
    putRestParameter("status",<%=status%>);
	myData = restRequest();
    store = new Ext.data.ArrayStore({
	    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: [
	           {name: '编号'},
	           {name: '项目名称'},
	           {name: '单位名称'},
	           {name: '土地位置'},
	           {name: '巡查时间'},
	           {name: '状态'},
	           {name: '信息'}  
	        ]
    });
    
    store.load({params:{start:0, limit:10}});
    var width=document.body.clientWidth-10;
  	var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
    grid = new Ext.grid.GridPanel({
        store: store,
        sm:sm,
        columns: [
            sm,
            new Ext.grid.RowNumberer(),
        	{header: '编号', dataIndex:'编号',width: width*0.15, sortable: false},
            {header: '项目名称', dataIndex:'项目名称', width: width*0.15, sortable: false},
            {header: '单位名称', dataIndex:'单位名称', width: width*0.15, sortable: false},
            {header: '土地位置', dataIndex:'土地位置', width: width*0.20, sortable: false},
            {header: '巡查时间', dataIndex:'巡查时间', width: width*0.15, sortable: false},
            {header: '状态', dataIndex:'状态', width: width*0.1, sortable: false,renderer:check},
            {header: '信息', dataIndex:'信息', width: width*0.05, sortable: false, renderer:view}
            
        ],
         listeners:{
		       rowdblclick: viewDetail
         },
        stripeRows: true,
        height: 430,
        title: '任务信息列表',
        stateful: true,
        stateId: 'grid',
        buttonAlign:'center',
        bbar: new Ext.PagingToolbar({
	        pageSize: 10,
	        store: store,
	        displayInfo: true,
	            displayMsg: '共{2}条，当前为：{0} - {1}条',
	            emptyMsg: "无记录",
	        plugins: new Ext.ux.ProgressBarPager()
        })	
    }); 
    grid.render('mygrid_container'); 
 });

function view(id){
	return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='base/gis/images/view.png'></a>";
}
 

function viewDetail(id){
   // var id = grid.store.indexOf(grid.getSelectionModel().getSelected());
    var yw_guid=myData[id][0];
    var zfjcType=9;
    if('<%=flag %>'=='9'){
     zfjcType=7;
    }
window.open("<%=basePath%>/common/pages/resourcetree/resourceTree.jsp?zfjcType="+zfjcType+"&yw_guid="+yw_guid);
}

function checkLegal(){
  var ids="";
  if (grid.getSelectionModel().hasSelection()){
     var records=grid.getSelectionModel().getSelections();
	 for(var i=0;i<records.length;i++){
	   if(i==records.length-1){
	      ids=ids+records[i].get('编号');
	   }else{
	      ids=ids+records[i].get('编号')+",";
	   }
     }
     
      Ext.Msg.confirm("请确认","是否要判定为合法案件", function(button,text){   
                if(button=="yes"){//这个是通过yes or no 来确定的点击值 
                	//var path = "<%=basePath%>";
    				//var actionName = "outTaskAC";
					//var actionMethod = "expTempResults";
					//var parameter="ids="+ids+"&flag=5";
    				//var result = ajaxRequest(path,actionName,actionMethod,parameter);
    				//if(result!=""){
    				//   window.open("downCG.jsp?file_path="+result);
    				//}
    				Ext.MessageBox.minWidth=200; 
    				Ext.Msg.alert("该案件已判定为合法案件！");  
                } 
            });  
  	
  }else{
    Ext.Msg.alert('提示','请选择任务！');
  }
}

function issuedTask(){
  var ids="";
  if (grid.getSelectionModel().hasSelection()){
     var records=grid.getSelectionModel().getSelections();
	 for(var i=0;i<records.length;i++){
	   if(i==records.length-1){
	      ids=ids+records[i].get('编号');
	   }else{
	      ids=ids+records[i].get('编号')+",";
	   }
     }
     
      Ext.Msg.confirm("请确认","是否要下发核查任务", function(button,text){   
                if(button=="yes"){//这个是通过yes or no 来确定的点击值 
                	//var path = "<%=basePath%>";
    				//var actionName = "outTaskAC";
					//var actionMethod = "expTempResults";
					//var parameter="ids="+ids+"&flag=5";
    				//var result = ajaxRequest(path,actionName,actionMethod,parameter);
    				//if(result!=""){
    				//   window.open("downCG.jsp?file_path="+result);
    				//}
    				Ext.MessageBox.minWidth=200; 
    				Ext.Msg.alert("该案件已下发！");  
                } 
            });  
  	
  }else{
    Ext.Msg.alert('提示','请选择任务！');
  }
}
function check(){
var flag='<%=flag%>';
if(flag=='2'){
	return "<font size='1'>核查中</font>"; 
}
if(flag=='3'){
	return "<font size='1'>内业审核中</font>";
}
}
</script>
	</head>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container" style="width: 100%; height: 85%;"></div>	
		<br>
		<center><input type="button" value=" 合 法 " onclick="checkLegal()">&nbsp;&nbsp;&nbsp;<input type="button" value="下发核查任务" onclick="issuedTask()"></center>
	</body>
</html>
<script>
</script>