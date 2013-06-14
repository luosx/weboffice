<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String userName=request.getParameter("userName");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>下发</title>
 
	<script src="<%=basePath%>/base/include/ajax.js"></script>
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf"%>
  </head>
  	<script>
	var basePath="<%=basePath%>";

var firstGrid;
var firstGridStore;
var secondGridStore;
var secondGrid; 
Ext.onReady(function(){
	putClientCommond("lacc","getProcessListXf");
	putRestParameter("userName","<%=userName%>");
    myData = restRequest();
	// Generic fields array to use in both store defs.
	var fields = [
		{name: 'GUID',    mapping : 'GUID'},
		{name: '案由', mapping : 'AY'},
		{name: '案件来源', mapping : 'AJLY'}
	];

    // create the data store
    firstGridStore = new Ext.data.ArrayStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
        remoteSort:true,
        fields: [
		{name: 'GUID',    mapping : 'GUID'},
		{name: '案由', mapping : 'AY'},
		{name: '案件来源', mapping : 'AJLY'}
        ]
    });
    firstGridStore.load({params:{start:0,limit:15}});
	// Column Model shortcut array
	var cols = [
		{ id : '编号', header: "编号", width: 180, sortable: true, dataIndex: 'GUID'},
		{header: "案由", width: 100, sortable: true, dataIndex: '案由'},
		{header: "案件来源", width: 100, sortable: true, dataIndex: '案件来源'}
	];

	// declare the source Grid
    firstGrid = new Ext.grid.GridPanel({
	    ddGroup          : 'secondGridDDGroup',
        store            : firstGridStore,
        columns          : cols,
	    enableDragDrop   : true,
        stripeRows       : true,
        autoExpandColumn : '编号',
        title            : '待办列表&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查询：<input onkeyup="search(this)"  onfocus="reset(this)" type="text" value="输入关键字查询" style="font-size:10px;height:18px;width:150px;border:1px solid #ccc;">',
        bbar: new Ext.PagingToolbar({
        pageSize: 15,
        store: firstGridStore,
        displayInfo: false
        })
    });

    
    secondGridStore = new Ext.data.JsonStore({
        fields : fields,
		root   : 'records'
    });

    // create the destination Grid
    secondGrid = new Ext.grid.GridPanel({
	    ddGroup          : 'firstGridDDGroup',
        store            : secondGridStore,
        columns          : cols,
	    enableDragDrop   : true,
        stripeRows       : true,
        autoExpandColumn : '编号',
        title            : '待下发任务',
        bbar: new Ext.PagingToolbar({
        pageSize: 15,
        store: firstGridStore,
        displayInfo: false
        })
    });


	//Simple 'border layout' panel to house both grids
	var displayPanel = new Ext.Panel({
		width        : 650,
		height       : 450,
		layout       : 'hbox',
		renderTo     : 'panel',
		defaults     : { flex : 1 }, //auto stretch
		layoutConfig : { align : 'stretch' },
		items        : [
			firstGrid,
			secondGrid
		],
		bbar    : [
			'->', // Fill
			{
                text    : '导出',
                handler : function() {
                	 expTasks();
                    //refresh source grid
                    //firstGridStore.loadData(myData);

                    //purge destination grid
                    //secondGridStore.removeAll();
                }
            },
			{
				text    : '重置',
				handler : function() {
					//refresh source grid
					//firstGridStore.loadData(myData);

					//purge destination grid
					secondGridStore.removeAll();
				}
			}
		]
	});

	// used to add records to the destination stores
	var blankRecord =  Ext.data.Record.create(fields);

        /****
        * Setup Drop Targets
        ***/
        // This will make sure we only drop to the  view scroller element
        var firstGridDropTargetEl =  firstGrid.getView().scroller.dom;
        var firstGridDropTarget = new Ext.dd.DropTarget(firstGridDropTargetEl, {
                ddGroup    : 'firstGridDDGroup',
                notifyDrop : function(ddSource, e, data){
                        var records =  ddSource.dragData.selections;
                        Ext.each(records, ddSource.grid.store.remove, ddSource.grid.store);
                        firstGrid.store.add(records);
                        firstGrid.store.sort('编号', 'ASC');
                        return true
                }
        });


        // This will make sure we only drop to the view scroller element
        var secondGridDropTargetEl = secondGrid.getView().scroller.dom;
        var secondGridDropTarget = new Ext.dd.DropTarget(secondGridDropTargetEl, {
                ddGroup    : 'secondGridDDGroup',
                notifyDrop : function(ddSource, e, data){
                        var records =  ddSource.dragData.selections;
                        Ext.each(records, ddSource.grid.store.remove, ddSource.grid.store);
                        secondGrid.store.add(records);
                        secondGrid.store.sort('编号', 'ASC');
                        return true
                }
        });
        firstGridStore.loadData(myData);
});


function reset(text){
	if(text.value=='输入关键字查询'){
   		text.value="";
	}
}

function search(text){
	var keyWord=text.value;
	keyWord=escape(escape(keyWord));
	putClientCommond("lacc","getProcessListXf");
	putRestParameter("userName","<%=userName%>");
	putRestParameter("keyWord",keyWord);
	var myData = restRequest(); 
	firstGridStore = new Ext.data.ArrayStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
		{name: '编号',    mapping : 'GUID'},
		{name: '案由', mapping : 'AY'},
		{name: '案件来源', mapping : 'AJLY'}
        ]
    });
	firstGrid.reconfigure(firstGridStore, new Ext.grid.ColumnModel([
          { id : '编号', header: "编号", width: 180, sortable: true, dataIndex: '编号'},
		  {header: "案由", width: 100, sortable: true, dataIndex: '案由'},
		  {header: "案件来源", width: 100, sortable: true, dataIndex: '案件来源'}
        ]));
	firstGrid.getBottomToolbar().bind(firstGridStore);//
	firstGridStore.load({params:{start:0,limit:15}});  	
}

function expTasks(){
     var ids="";
     //var count = secondGridStore.getCount(); 
     var records= secondGridStore.data.items;
	 for(var i=0;i<records.length;i++){
	   if(i==records.length-1){
	      ids=ids+records[i].data.GUID;
	   }else{
	      ids=ids+records[i].data.GUID+"@";
	   }
     }
     	var path = basePath;
        var actionName = "wyrwmanager";
        var actionMethod = "downTasks";
        var parameter="ids="+ids+"&flag=cc";
	    var zipPath=ajaxRequest(path,actionName,actionMethod,parameter);
    	if(zipPath!=""){
			window.open("expTask.jsp?file_path="+zipPath);
			document.location.reload();
		}  
}
	</script>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
	    <div id="panel"></div>
	</body>
</html>
