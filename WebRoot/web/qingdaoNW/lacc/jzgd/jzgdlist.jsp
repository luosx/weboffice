<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%
	String path = request.getContextPath();
   String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
   Object principal = SecurityContextHolder.getContext()
			.getAuthentication().getPrincipal();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>卷宗归档列表</title>
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
		   	putClientCommond("jzgd","getList");
			var myData = restRequest();
			store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
				remoteSort: true,
				fields: [
		           {name: 'BH'},
		           {name: 'AY'},
		           {name: 'DWMC'},
		           {name: 'FDDBR'},
		           {name: 'DWDZ'},
		           {name: 'AJLY'},
		           {name: 'SLRQ'},
		           {name: 'YW_GUID'}
                    ]
			});
    		store.load({params:{start:0, limit:10}});
    		var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
    		var width=document.body.clientWidth  ;
    		var height=document.body.clientHeight - 10;
        	grid = new Ext.grid.GridPanel({
          		//title:'卷宗归档列表',
        		store: store,
        		sm:sm,
        		columns: [
        			new Ext.grid.RowNumberer(),
		        	 {header: '立案编号',dataIndex:'BH',width: width*0.16, sortable: true},
			           {header: '案由',dataIndex:'AY',width: width*0.2, sortable: true},
			           {header: '单位名称',dataIndex:'DWMC',width: width*0.12, sortable: true},
			           {header: '法定代表人',dataIndex:'FDDBR',width: width*0.1, sortable: true},
			           {header: '单位地址',dataIndex:'DWDZ',width: width*0.12, sortable: true},
			           {header: '案件来源',dataIndex:'AJLY',width: width*0.08, sortable: true},
			           {header: '受理日期',dataIndex:'SLRQ',width: width*0.12, sortable: true},
			           {header: '详细',dataIndex:'YW_GUID',width: width*0.05, sortable: false,renderer:pro}
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
        		buttons: [{
				        	text:'新增归档卷宗',
				        	handler: addGD
				        } ] ,
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
}
);

function pro(id){
 	return "<a href='#'onclick='process(\""+id+"\");return false;'><img src='base/form/images/view.png' alt='查看'></a>";
}

//点击查看时，查看详细信息
function process(id){
	var url = "<%=basePath%>/web/qingdaoNW/lacc/jzgd/jzgdTab.jsp?yw_guid=" + id;
	document.location.href = url;
}
//新增归档
function addGD(){
putClientCommond("jzgd","addGD");
 var myData = restRequest();
 if("false"==myData){
 alert("新增失败！");
 }else{
 var url = "<%=basePath%>/web/qingdaoNW/lacc/jzgd/jzgdTab.jsp?yw_guid=" + myData;
	document.location.href = url;
 }
}

//模糊查询
function query(){
	var keyWord=Ext.getCmp('keyword').getValue();
   	 	putClientCommond("jzgd","getList");
    	putRestParameter("keyword",escape(escape(keyWord)));
	   var myData = restRequest();
	store = new Ext.data.JsonStore({
		proxy:new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort: true,
		fields:[
            {name: 'BH'},
           {name: 'AY'},
           {name: 'DWMC'},
           {name: 'FDDBR'},
           {name: 'DWDZ'},
           {name: 'AJLY'},
           {name: 'SLRQ'},
           {name: 'YW_GUID'}		
		   ]
	});
    var width=document.body.clientWidth  ;
	var height=document.body.clientHeight - 10;
	grid.reconfigure(store, new Ext.grid.ColumnModel([
      	new Ext.grid.RowNumberer(),
      		{header: '立案编号',dataIndex:'BH',width: width*0.16, sortable: true},
           {header: '案由',dataIndex:'AY',width: width*0.2, sortable: true},
           {header: '单位名称',dataIndex:'DWMC',width: width*0.12, sortable: true},
           {header: '法定代表人',dataIndex:'FDDBR',width: width*0.1, sortable: true},
           {header: '单位地址',dataIndex:'DWDZ',width: width*0.12, sortable: true},
           {header: '案件来源',dataIndex:'AJLY',width: width*0.08, sortable: true},
           {header: '受理日期',dataIndex:'SLRQ',width: width*0.12, sortable: true},
           {header: '详细',dataIndex:'YW_GUID',width: width*0.05, sortable: false,renderer:pro}
    ]));
        
	//重新绑定分页工具栏
 	grid.getBottomToolbar().bind(store);
	//重新加载数据集
	store.load({params:{start:0,limit:10}});  
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