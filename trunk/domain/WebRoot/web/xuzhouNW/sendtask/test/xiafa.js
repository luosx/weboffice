var firstGrid;
var firstGridStore;
var secondGridStore;
var secondGrid; 
Ext.onReady(function(){
	putClientCommond("anjianManager","getXfjbList");
    putRestParameter("flag","1");
    putRestParameter("status","1");
    myData = restRequest();
	// Generic fields array to use in both store defs.
	var fields = [
		{name: 'TBBH',    mapping :'TBBH'},
        {name: 'XZQHMC',    mapping :'XZQHMC'},
        {name: 'TBMJ',    mapping :'TBMJ'}  
	];

    firstGridStore = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
        remoteSort:true,
        fields: [
           {name: 'TBBH'},
           {name: 'XZQHMC'},
           {name: 'TBMJ'}
        ]
    });
    firstGridStore.load({params:{start:0,limit:15}});
	var cols = [
		{ id : 'TBBH', header: "图斑编号", width: 100, sortable: true, dataIndex: 'TBBH'},
		{header: "行政区划", width: 100, sortable: true, dataIndex: 'XZQHMC'},
		{header: "图斑面积", width: 100, sortable: true, dataIndex: 'TBMJ'}
	];
    var searchText = new Ext.form.TextField({
		id:'searchText',
		name: 'searchText',
		value:'',
		emptyText:'请输入关键字...',
		width:'150',
		enableKeyEvents : true
	});

    firstGrid = new Ext.grid.GridPanel({
	    ddGroup          : 'secondGridDDGroup',
        store            : firstGridStore,
        columns          : cols,
	    enableDragDrop   : true,
        stripeRows       : true,
        autoExpandColumn : 'TBBH',
        bbar: new Ext.PagingToolbar({
        pageSize: 15,
        store: firstGridStore,       
        displayInfo: false
        }), tbar:[
        	    	{xtype: 'button',text:'卫片执法',width:80,handler: query},
        	    	{xtype: 'button',text:'立案查处',width:80,handler: query},
        	    	{xtype:'label',text:'',width:40},
	    			{xtype:'label',text:'精确查找:',width:60},
	    			searchText
	    ]
    });
    
   searchText.on('keyup',function(field,e){ 
   	var keyWord=field.getRawValue();
	keyWord=escape(escape(keyWord));
	putClientCommond("anjianManager","getXfjbList");
    putRestParameter("flag","1");
    putRestParameter("status","1");
	putRestParameter("keyWord",keyWord);
	var myData = restRequest(); 
	firstGridStore = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: 'TBBH'},
           {name: 'XZQHMC'},
           {name: 'TBMJ'}       
        ]
    });
	firstGrid.reconfigure(firstGridStore, new Ext.grid.ColumnModel([
          { id : 'TBBH', header: "图斑编号", width: 100, sortable: true, dataIndex: 'TBBH'},
		  {header: "行政区划", width: 100, sortable: true, dataIndex: 'XZQHMC'},
		  {header: "图斑面积", width: 100, sortable: true, dataIndex: 'TBMJ'}
        ]));
	firstGrid.getBottomToolbar().bind(firstGridStore);//
	firstGridStore.load({params:{start:0,limit:15}});  
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
        autoExpandColumn : 'TBBH',
        title            : '待下发任务',
        bbar: new Ext.PagingToolbar({
        pageSize: 15,
        store: firstGridStore,
        displayInfo: false,
        buttons: [{
        	text:'导出核查任务',
        	handler: expTasks
        },{
        	text:'导入核查成果',
        	handler: expTasks
        }] 	
        })
    });
    var height=document.body.clientHeight-10;
    var width=document.body.clientWidth-10;
	var displayPanel = new Ext.Panel({
		width        : width,
		height       : height,
		layout       : 'hbox',
		renderTo     : 'panel',
		defaults     : { flex : 1 }, //auto stretch
		layoutConfig : { align : 'stretch' },
		items        : [
			firstGrid,
			secondGrid
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
                        firstGrid.store.sort('TBBH', 'ASC');
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
                        secondGrid.store.sort('TBBH', 'ASC');
                        return true
                }
        });
        firstGridStore.loadData(myData);
});

function expTasks(){
     var ids="";
     //var count = secondGridStore.getCount(); 
     var records= secondGridStore.data.items;
	 for(var i=0;i<records.length;i++){
	   if(i==records.length-1){
	      ids=ids+records[i].data.XSH;
	   }else{
	      ids=ids+records[i].data.XSH+"@";
	   }
     }
     	var path = basePath;
        var actionName = "wyrwmanager";
        var actionMethod = "downTask";
        var parameter="ids="+ids+"&flag=xf";
	    var zipPath=ajaxRequest(path,actionName,actionMethod,parameter);
    	if(zipPath!=""){
			window.open("expTask.jsp?file_path="+zipPath);
			document.location.reload();
		}  
}