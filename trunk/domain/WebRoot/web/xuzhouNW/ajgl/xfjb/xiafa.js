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
		{name: 'XSH',    mapping : 'XSH'},
		{name: 'DJR', mapping : 'DJR'},
		{name: 'BJBDW', mapping : 'BJBDW'}
	];

    // create the data store
    firstGridStore = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
        remoteSort:true,
        fields: [
           {name: 'XSH'},
           {name: 'DJR'},
           {name: 'BJBDW'}
        ]
    });
    firstGridStore.load({params:{start:0,limit:15}});
	// Column Model shortcut array
	var cols = [
		{ id : 'XSH', header: "线索号", width: 200, sortable: true, dataIndex: 'XSH'},
		{header: "登记人", width: 80, sortable: true, dataIndex: 'DJR'},
		{header: "被举报单位", width: 100, sortable: true, dataIndex: 'BJBDW'}
	];

	// declare the source Grid
    firstGrid = new Ext.grid.GridPanel({
	    ddGroup          : 'secondGridDDGroup',
        store            : firstGridStore,
        columns          : cols,
	    enableDragDrop   : true,
        stripeRows       : true,
        autoExpandColumn : 'XSH',
        title            : '信访举报&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查询：<input onkeyup="search(this)"  onfocus="reset(this)" type="text" value="输入关键字查询" style="font-size:10px;height:18px;width:150px;border:1px solid #ccc;">',
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
        autoExpandColumn : 'XSH',
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
                        firstGrid.store.sort('XSH', 'ASC');
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
                        secondGrid.store.sort('XSH', 'ASC');
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
	putClientCommond("anjianManager","getXfjbList");
    putRestParameter("flag","1");
    putRestParameter("status","1");
	putRestParameter("keyWord",keyWord);
	var myData = restRequest(); 
	firstGridStore = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: 'XSH'},
           {name: 'DJR'},
           {name: 'BJBDW'}       
        ]
    });
	firstGrid.reconfigure(firstGridStore, new Ext.grid.ColumnModel([
          { id : 'XSH', header: "线索号", width: 200, sortable: true, dataIndex: 'XSH'},
		  {header: "登记人", width: 80, sortable: true, dataIndex: 'DJR'},
		  {header: "被举报单位", width: 100, sortable: true, dataIndex: 'BJBDW'}
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