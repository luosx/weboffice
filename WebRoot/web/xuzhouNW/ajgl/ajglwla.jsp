<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>案件管理未立案</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="<%=basePath%>/base/include/ajax.js"></script>
	<%@ include file="/base/include/ext.jspf" %>
	<script type="text/javascript">
  		var scrWidth=screen.availWidth;
    	var scrHeight=screen.availHeight;
    	Ext.onReady(function(){
	    	//请求数据
	    	var path = "<%=basePath%>";
			var actionName = "anjianManager";
			var actionMethod = "getWLA";
			var parameter = "";
			var data = ajaxRequest(path, actionName, actionMethod, parameter);
			myData = eval(data);
	    	store = new Ext.data.ArrayStore({
			    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
			        fields: [
			           {name: '线索号'},
			           {name: '案件来源'},
			           {name: '项目名称'},
			           {name: '单位名称'},
			           {name: '土地位置'},
			           {name: '占地面积'},
			           {name: '情况描述'},
			           {name: '用地性质'},
			           {name: '状态'},
			           {name: '巡查人'},
			           {name: '发生时间'},
			           {name: '查看'},
			           {name: '立案'},
			        ]
	    	});
    		store.load({params:{start:0, limit:15}});
    		var width=document.body.clientWidth*0.96 - 510;
   			var height=document.body.clientHeight*0.99;
   			grid = new Ext.grid.GridPanel({
   				store: store,
   				columns:[
   					{header: '线索号', width: 120, sortable: false},
		            {header: '案件来源', width: 60, sortable: false},
		            {header: '单位名称', width: width*0.15, sortable: false},
		            {header: '土地位置', width: width*0.15, sortable: false},
		            {header: '占地面积', width: 60, sortable: false},
		            {header: '情况描述', width: width*0.4, sortable: false},
		            {header: '用地性质', width: width*0.3, sortable: false},
		            {header: '状态', width: 50, sortable: false},
		            {header: '巡查人', width: 50, sortable: false},
		            {header: '发生时间', width: 70, sortable: false},
		            {header: '查看', width: 40, sortable: false, renderer:view},
		            {header: '立案',width: 60, sortable: false, renderer:lian}
   				],
   				listeners:{
   					'rowdblclick': function(grid, rowIndex, e){
   						var record = grid.store.getAt(rowIndex);
   						var id = record.get('yw_guid');
   						// 根据案件类型确定访问的页面
   							//window.location.href="<%=basePath%>web/xuzhouNW/recordclue/wfxsdjbl.jsp?jdbcname=YWTemplate&yw_guid="+id;
   						window.open("<%=basePath%>common/pages/resourcetree/resourceTree.jsp?zfjcType=7&yw_guid=" + id);
   						//window.open("<%=basePath%>/common/pages/resourcetree/resourceTree.jsp?zfjcType="+zfjcType+"&yw_guid="+id);
   					} 
   				},
   				tbar:[
	    			{xtype:'label',text:'快速查找:',width:60},
	    			{xtype:'textfield',id:'keyword',width:450,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',text:'查询',handler: query}
	    		],
   				stripeRows: true,
        		height: height,
        		fitToFrame: true,
   				// title: '未立案可疑线索列表',
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
   			store.sort("发生时间","desc"); 
    		grid.render('mygrid_container');
    	})
  	
  		//点击立案时触发
  		function lian(id){
  			return "<a href='#' onclick='lianDetail("+id+");return false;'><img src='web/xuzhouNW/lacc/image/lian.png' ></a>";
  		}
  		
  		function view(id){
  			return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='base/gis/images/view.png'></a>";
  		}
  		function viewDetail(id){
    		//var id=myData[id][myData[id].length - 3];
    		var id = myData[id][0];
    		//window.location.href="<%=basePath%>web/xuzhouNW/recordclue/wfxsdjbl.jsp?jdbcname=YWTemplate&yw_guid="+id;
    		window.open("<%=basePath%>common/pages/resourcetree/resourceTree.jsp?zfjcType=7&yw_guid=" + id);
    	}
    	
    	function lianDetail(id){
    		//var id = myData[id][myData[id].length - 3];
    		var id = myData[id][0];
    		//var userconfirm = confirm("当前案件将立案处理,确定？");
			Ext.MessageBox.confirm('确认框', '当前案件将立案处理,确定？',function (btn){
				if(btn == 'yes'){
					//做立案处理
					window.location.href="<%=basePath%>service/rest/lacpbManager/greateLA?yw_guid=" + id;
				}
			});
			//刷新页面
			//document.location.reload();
    	}
    	
		function query(){
			var keyWord = Ext.getCmp('keyword').getValue();
			//document.location.href="<%=basePath%>web/xuzhouNW/ajgl/ajglwla.jsp?keyword="+keyWord;
			var path = "<%=basePath%>";
			var actionName = "anjianManager";
			var actionMethod = "getWLA";
			var parameter = "keyword=" + keyWord;
			var data = ajaxRequest(path, actionName, actionMethod, parameter);
			myData = eval(data);
			
			//var page = grid.getBottonToolbar().cursor;
			var page=grid.getBottomToolbar().cursor;
			grid.reconfigure(
				new Ext.data.ArrayStore({
				proxy: new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
			        fields: [
			           {name: '线索号'},
			           {name: '案件来源'},
			           {name: '项目名称'},
			           {name: '单位名称'},
			           {name: '土地位置'},
			           {name: '占地面积'},
			           {name: '情况描述'},
			           {name: '用地性质'},
			           {name: '状态'},
			           {name: '巡查人'},
			           {name: '发生时间'},
			           {name: '查看'},
			           {name: '立案'},
			        ]
				}),
				grid.getColumnModel());
				
				store = grid.getStore();
				grid.getBottomToolbar().bind(store);
				store.load({params:{start:page, limit:2}});
			
		}
		
  	</script>
  </head>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container" style="width: 100%; height: 100%;"></div>	
	</body>
</html>
