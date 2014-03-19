var data;
var simple;
var condition = "";
var win;
var	grid;
Ext.onReady(function() {
			width = document.body.clientWidth;
			height = document.body.clientHeight;
			initComponent();
		});

function initComponent() {

	simple = new Ext.FormPanel({
				frame : true,
				
				bodyStyle : 'padding:5px 5px 0',
				tbar : [{
							xtype : 'label',
							text : '关键字：'
						}, {xtype:'textfield',id:'keyword',width:200,emptyText:'请输入关键字进行查询'},'-', {
							xtype : 'button',
							text : '查询',
							handler : query
						}, '-', {
							xtype : 'button',
							text : '导出Excel',
							handler : exportExcel
						},{
							xtype : 'button',
							text : '选择地块',
							handler : select
						}],
				items : [{
					html : "<iframe id='report' width=" + (width)
							+ " height=" + (height) + " src=" + url
							+ "></iframe>"
				}]
			});
	simple.render(document.body);
}

function query() {
	var keyword = Ext.getCmp("keyword").getValue();
	document.frames['report'].queryJBB(keyword);
}

function exportExcel() {
	document.frames['report'].print();
}

function select(){
	putClientCommond("cbjhzhb","getName");
 	var myData = restRequest();
	var	store = new Ext.data.JsonStore({
		proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
		fields: [
			{name: 'DKMC'}
		]
		});
    store.load({params:{start:0, limit:myData[0].length}});
	var	    	sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});
   grid = new Ext.grid.GridPanel({
    	store: store,
    	sm:sm,
    	columns: [
    		new Ext.grid.RowNumberer(),
    		sm,
           	{header: '地块名称',dataIndex:'DKMC',width:130, sortable: true}
    	],
        stripeRows: true,
        height: 500,
        title: '',
        stateId: 'grid'
	});	
	win = new Ext.Window({
		layout: 'fit',
        title: '地块选择',
        closeAction: 'hide',
        width:200,
        height:300,
        x: 40,
        y: 50,
        items:[grid],
        buttons:[{
        	text:'保存',
        	handler:function(){
        		var rows = grid.getSelectionModel().getSelections();
        		var dkmc = "";
        		for(var i=0;i<rows.length;i++){
        			dkmc = dkmc + rows[i].get("DKMC")+",";
        		}
        		putClientCommond("cbjhzhb","save");
        		putRestParameter("dkmc", dkmc);
        		var myData2 = restRequest();
        		if(myData2.success){
        		  Ext.Msg.alert("提示","保存成功",function(){
        			  document.location.reload();
        		  });
        		
        		}
        	}
        },{
        	text:'关闭',
        	handler:function(){
        	 	win.hide();
        	}	
        }]
        });
	win.show();
}




