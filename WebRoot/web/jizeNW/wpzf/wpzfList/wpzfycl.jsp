<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.web.sanya.ajdb.CaseSupervision"%>
<%
	String path = request.getContextPath();
   String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
   String year = request.getParameter("year");
   Object principal = SecurityContextHolder.getContext()
			.getAuthentication().getPrincipal();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>卫片执法线索管理</title>
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
	    var grid;
	    var store;
		Ext.onReady(function(){
		   	putClientCommond("wpzfHandler","getYCLList");
		   	putRestParameter("year","<%=year%>");
			var myData = restRequest();
			store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
				remoteSort: true,
				fields:[
		           {name:'OBJECTID'},
		           {name: 'JCBH'},
		           {name: 'XMC'},
		           {name: 'AREA'},
		           {name: 'YEAR'},
		           {name: 'TBLX'},
		           {name: 'YDSJ'},
		           {name: 'YDDW'},
		           {name: 'JSQK'},
		           {name: 'XMMC'}		
				]
			});
    		store.load({params:{start:0, limit:15}});
    		var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
    		var width=document.body.clientWidth  ;
    		var height=document.body.clientHeight - 10;
        	grid = new Ext.grid.GridPanel({
          		title:'卫片图斑已核查列表',
        		store: store,
        		sm:sm,
        		columns: [
        			new Ext.grid.RowNumberer(),
		        	{header: '图斑编号', dataIndex:'JCBH', width: 80, sortable: true,renderer:changKeyword},
		            {header: '图斑位置', dataIndex:'XMC', width: 80, sortable: true,renderer:changKeyword},
		            {header: '用地单位', dataIndex:'YDDW', width: (width-570) * 0.25, sortable: true,renderer:changKeyword},
		            {header: '建设情况', dataIndex:'JSQK', width: (width-570) * 0.5, sortable: true,renderer:changKeyword},
		            {header: '项目名称', dataIndex:'XMMC', width: (width-570) * 0.25, sortable: true,renderer:changKeyword},
		            {header: '图斑类型', dataIndex:'TBLX', width: 80, sortable: true,renderer:changKeyword},
		            {header: '图斑年度', dataIndex:'YEAR', width: 80, sortable: true,renderer:changKeyword},
		            {header: '图斑面积', dataIndex:'AREA', width: 80, sortable: true,renderer:changKeyword},
        		    {header: '用地时间', dataIndex:'YDSJ', width: 100, sortable: true,renderer:changKeyword},
		            {header: '查看', dataIndex:'OBJECTID', width: 40, sortable: true,renderer:pro}
        		], 
        		tbar:[
	    			{xtype:'label',text:'快速查找:',width:60},
	    			{xtype:'textfield',id:'keyword',width:300,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',text:'查询',width:50,handler: query}
	    		],
        		listeners:{
         		},   
        		stripeRows: true,
        		width:width,
        		height: height,
        		stateful: true,
        		stateId: 'grid',
        		buttonAlign:'center',
        		bbar: new Ext.PagingToolbar({
        			pageSize: 15,
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

function pro(id){
 	return "<a href='#'onclick='process(\""+id+"\");return false;'><img src='base/form/images/view.png' alt='办理'></a>";
}

//点击查看时，查看详细信息
function process(id){
	var url = "<%=basePath%>/web/jizeNW/wpzf/wpzfNR/wpTab.jsp?year=<%=year%>&yw_guid=" + id;
	document.location.href = url;
	//window.open(url);
}

//模糊查询
function query(){
	var keyWord=Ext.getCmp('keyword').getValue();
   	putClientCommond("wpzfHandler","getYCLList");
   	putRestParameter("year","<%=year%>");
   	putRestParameter("keyword",escape(escape(keyWord)));
	var myData = restRequest();
	store = new Ext.data.JsonStore({
		proxy:new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort: true,
		fields:[
           {name:'OBJECTID'},
           {name: 'JCBH'},
           {name: 'XMC'},
           {name: 'AREA'},
           {name: 'YEAR'},
           {name: 'TBLX'},
           {name: 'YDSJ'},
           {name: 'YDDW'},
           {name: 'JSQK'},
           {name: 'XMMC'}			
		]
	});
    var width=document.body.clientWidth  ;
	var height=document.body.clientHeight - 10;
	grid.reconfigure(store, new Ext.grid.ColumnModel([
      		new Ext.grid.RowNumberer(),
        	{header: '图斑编号', dataIndex:'JCBH', width: 80, sortable: true,renderer:changKeyword},
            {header: '图斑位置', dataIndex:'XMC', width: 80, sortable: true,renderer:changKeyword},
            {header: '用地单位', dataIndex:'YDDW', width: (width-570) * 0.25, sortable: true,renderer:changKeyword},
            {header: '建设情况', dataIndex:'JSQK', width: (width-570) * 0.5, sortable: true,renderer:changKeyword},
            {header: '项目名称', dataIndex:'XMMC', width: (width-570) * 0.25, sortable: true,renderer:changKeyword},
            {header: '图斑类型', dataIndex:'TBLX', width: 80, sortable: true,renderer:changKeyword},
            {header: '图斑年度', dataIndex:'YEAR', width: 80, sortable: true,renderer:changKeyword},
            {header: '图斑面积', dataIndex:'AREA', width: 80, sortable: true,renderer:changKeyword},
      		{header: '用地时间', dataIndex:'YDSJ', width: 100, sortable: true,renderer:changKeyword},
            {header: '查看', dataIndex:'OBJECTID', width: 40, sortable: true,renderer:pro}
    ]));
        
	//重新绑定分页工具栏
 	grid.getBottomToolbar().bind(store);
	//重新加载数据集
	store.load({params:{start:0,limit:15}});  
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
		</body>
</html>