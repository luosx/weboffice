<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.web.sanya.ajdb.CaseSupervision"%>
<%
	String path = request.getContextPath();
   String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
   String dbts = new CaseSupervision().getDbDateByType("信访");
   Object principal = SecurityContextHolder.getContext()
			.getAuthentication().getPrincipal();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>执法监察线索管理</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf" %>
		<%@ include file="/base/include/restRequest.jspf" %>
		<script src="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/FileUploadField.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/css/fileuploadfield.css"/>
		<style>
		input,img{vertical-align:middle;}
html, body { 
				margin-left: 0px;
				margin-top: 0px;
				margin-right: 0px;
				margin-bottom: 0px;
	            font: normal 11px verdana;
}
        #main-panel td {
            padding:1.5px;
        }
        .x-grid3-cell-text-visible .x-grid3-cell-inner{overflow:visible;padding:3px 3px 3px 5px;white-space:normal;}
		</style>

		<script type="text/javascript">
		var myData;
	    var grid;
	    var store;
	    var win;
	    var form;
	    var _$ID = '';
		Ext.onReady(function(){
		   	putClientCommond("xfajHandler","getAllDCLList");
			myData = restRequest();
			store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
				remoteSort: true,
				fields:[
		           {name:'XFSX'},
		           {name: 'XFLX'},
		           {name: 'BLSX'},
		           {name: 'BLKS'},
		           {name: 'ZHBLR'},
		           {name: 'YW_GUID'},
		           {name: 'CREATEDATE'},
		           {name: 'DELETE'}				
				]
			});
    		store.load({params:{start:0, limit:13}});
    		var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
    		var width=document.body.clientWidth  ;
    		var height=document.body.clientHeight - 10;
        	grid = new Ext.grid.GridPanel({
          		title:'信访案件办理中列表',
        		store: store,
        		sm:sm,
        		columns: [
        			new Ext.grid.RowNumberer(),
        			{header: '督办', dataIndex:'BLSX', width:40, sortable: true,renderer:view},
		        	{header: '信访事项', dataIndex:'XFSX', width: (width - 530), sortable: true,renderer:changKeyword},
		            {header: '信访类型', dataIndex:'XFLX', width: 70, sortable: true,renderer:changKeyword},
		            {header: '截止日期', dataIndex:'BLSX', width: 80, sortable: true,renderer:changKeyword},
		            {header: '受理科室', dataIndex:'BLKS', width: 80, sortable: true,renderer:changKeyword},
		            {header: '最后办理人', dataIndex:'ZHBLR', width: 70, sortable: true,renderer:changKeyword},
		            {header: '登记时间', dataIndex:'CREATEDATE', width: 80, sortable: true,renderer:changKeyword},
		            {header: '查看', dataIndex:'YW_GUID', width: 40, sortable: true,renderer:pro},
		            {header: '删除',dataIndex:'YW_GUID',width:40, sortable: false,renderer:del}
        		], 
        		tbar:[
	    			{xtype:'label',text:'快速查找:',width:60},
	    			{xtype:'textfield',id:'keyword',width:300,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',text:'查询',width:50,handler: query},
	    			{xtype: 'button',text:'新增信访',width:60,handler: add}
	    		],
        		listeners:{
         		},   
        		stripeRows: true,
        		width:width,
        		height: height-50,
        		stateful: true,
        		stateId: 'grid',
        		buttonAlign:'center',
        		bbar: new Ext.PagingToolbar({
        			pageSize: 13,
        			store: store,
        			displayInfo: true,
            		displayMsg: '共{2}条，当前为：{0} - {1}条',
            		emptyMsg: "无记录",
        			plugins: new Ext.ux.ProgressBarPager()
        		})
        	});
    		grid.render('mygrid_container');
}
);
//删除功能
function del(id){
          return "<a href='#' onclick='delTask(\""+id+"\");return false;'><img src='base/form/images/delete.png' alt='删除'></a>";
         }
function delTask(id){
	var  id=id;
    Ext.MessageBox.confirm('注意', '删除后不能恢复，您确定吗？',function(btn){
	  if(btn=='yes'){
		putClientCommond("xfajHandler","delete");
		putRestParameter("yw_guid",id);
	    var result = restRequest();
	    if(result=="success"){
		    alert("删除成功！");
		    document.location.reload();
	  	}else{
		    alert("删除失败！");
		    document.location.reload();
		}
	  }
	});
}
//新增信访
function add(){
	var url = "<%=basePath%>/web/sanya/xfaj/xfajdj/xfajTab.jsp";
	document.location.href = url;
	//window.open(url);
}

//预警
function view(date){
	//计算剩余天数
	var endTime = new Date();
	var dates = date.split("-");
	endTime.setFullYear(dates[0]);
	endTime.setMonth(dates[1]);
	endTime.setMonth(parseInt(endTime.getMonth()) - 1);
	var time = dates[2].split(" ");
	endTime.setDate(time[0]);
	var times = time[1].split(":");
	endTime.setHours(times[0]);
	endTime.setMinutes(times[1]);
	var startTime = new Date();
	var syts = parseFloat((endTime.getTime() - startTime.getTime()));
	
	//计算时间限制
	var limit = "<%=dbts%>";
	var limitDay = limit.substring(0, limit.indexOf("天"));
	var limitHour = limit.substring(limit.indexOf("天") + 1,limit.indexOf("时"));
	var limitMinuts = limit.substring(limit.indexOf("时") + 1, limit.indexOf("分"));
	var limits = parseInt(limitDay)*24*3600 + parseInt(limitHour)*3600 + parseInt(limitMinuts*60); 
	limits = limits * 1000;
	
    if(syts<0){
    	return "<img src='web/sanya/framework/images/red.png'>";
    }
    else if(syts>=0 && syts <= limits ){
       return "<img src='web/sanya/framework/images/yellow.png'>";
    }
    else {
    	return "<img src='web/sanya/framework/images/green.png'>";
    }
}

function pro(id){
 	return "<a href='#'onclick='process(\""+id+"\");return false;'><img src='base/form/images/view.png' alt='办理'></a>";
}

//点击查看时，查看详细信息
function process(id){
	var url = "<%=basePath%>/web/sanya/xfaj/xfajdj/xfajFrame.jsp?type=blz&yw_guid=" + id;
	document.location.href = url;
	//window.open(url);
}

//模糊查询
function query(){
	var keyWord=Ext.getCmp('keyword').getValue();
   	putClientCommond("xfajHandler","getDCLListByKeyWords");
   	putRestParameter("keyword",escape(escape(keyWord)));
	var myData = restRequest();
	store = new Ext.data.JsonStore({
		proxy:new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort: true,
		fields:[
	          {name:'XFSX'},
	          {name: 'XFLX'},
	          {name: 'BLSX'},
	          {name: 'BLKS'},
	          {name: 'ZHBLR'},
	          {name: 'YW_GUID'},
	          {name: 'CREATEDATE'},
	          {name: 'DELETE'}				
		]
	});
    var width=document.body.clientWidth  ;
	var height=document.body.clientHeight - 10;
	grid.reconfigure(store, new Ext.grid.ColumnModel([
		new Ext.grid.RowNumberer(),
   		{header: '督办', dataIndex:'BLSX', width:40, sortable: true,renderer:view},
    	{header: '信访事项', dataIndex:'XFSX', width: (width - 530) , sortable: true,renderer:changKeyword},
        {header: '信访类型', dataIndex:'XFLX', width: 70, sortable: true,renderer:changKeyword},
        {header: '截止日期', dataIndex:'BLSX', width: 80, sortable: true,renderer:changKeyword},
        {header: '受理科室', dataIndex:'BLKS', width: 80, sortable: true,renderer:changKeyword},
        {header: '最后办理人', dataIndex:'ZHBLR', width: 70, sortable: true,renderer:changKeyword},
        {header: '登记时间', dataIndex:'CREATEDATE', width: 80, sortable: true,renderer:changKeyword},
        {header: '查看', dataIndex:'YW_GUID', width: 40, sortable: true,renderer:pro},
        {header: '删除',dataIndex:'YW_GUID',width:40, sortable: false,renderer:del}
        ]));
        
    //重新绑定分页工具栏
	grid.getBottomToolbar().bind(store);//
	//重新加载数据集
	store.load({params:{start:0,limit:13}}); 
}

//给关键字添加颜色
function changKeyword(val){
      var key=Ext.getCmp('keyword').getValue();
      if(key!=''&& val!=null){
        var temp=(""+val);
        if(temp.indexOf(key)>=0){
        return val.substring(0,temp.indexOf(key))+"<B style='color:black;background-color:#CD8500;font-size:120%'>"+val.substring(temp.indexOf(key),temp.indexOf(key)+key.length)+"</B>"
          +temp.substring(temp.indexOf(key)+key.length,temp.length);
        }else{
          return val;
        }
     }else{
       return val;
     }
} 


</script>
	</head>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container"></div>
		<div id="importWin" class="x-hidden">
			<div id="importForm"></div>
		</div>
		<br/>
		<div align="center">
			 剩余期限：
			<img src='web/sanya/framework/images/red.png'>
			已超时&nbsp;&nbsp;&nbsp;
			<img src='web/sanya/framework/images/yellow.png'>
			不足<%=dbts%>&nbsp;&nbsp;&nbsp;
			<img src='web/sanya/framework/images/green.png'>
			超过<%=dbts%> &nbsp;&nbsp;&nbsp;
			<br />
			<br />
			<!-- 督办案件将会红色高亮显示&nbsp;&nbsp;&nbsp; -->
		</div>
		</body>
</html>