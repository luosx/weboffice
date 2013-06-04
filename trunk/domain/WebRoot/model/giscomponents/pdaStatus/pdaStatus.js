
Ext.onReady(function(){
	//Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
	parent.center.center.putClientCommond("pdastatus","doit");
	parent.center.center.putRestParameter("_$sid","aaa");
	var myData = parent.center.center.restRequest();
	
	var _$ID = '';
    function change(val){
        if(val < 10){
            return '<span style="color:green;">√</span>';
        }else{
            return '<span style="color:red;size=20">×</span>';
        }
        return val;
    }

    var store = new Ext.data.ArrayStore({
		proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
		   {name: 'minute'},
           {name: 'pda_id'},
           {name: 'pda_name'},
		   {name: 'send_time'},
           {name: 'pda_x'},
           {name: 'pda_y'}
        ]
    });

    store.loadData(myData);

    var grid = new Ext.grid.GridPanel({
        store: store,
        columns: [
		    {header:'', width:25, sortable:true, renderer:change, dataIndex:'minute'},
            {id:'no', header:'编号', width:60, sortable:true, dataIndex:'pda_id'},
            {header:'牌号', width:130, sortable:true, dataIndex:'pda_name'},
			{header:'时间', width:85, sortable:false, dataIndex:'send_time'},
            {header:'', width:0, sortable:true, dataIndex:'pda_x'},
            {header:'', width:0, sortable:true, dataIndex:'pda_y'}
        ],
        stripeRows: true,
        autoExpandColumn: 'no',
        height: 400,
        width: 310,
        stateful: true,
        stateId: 'grid',
		
	    plugins: new Ext.ux.PanelResizer({
            minHeight: 100
        }),

        bbar: new Ext.PagingToolbar({
            pageSize: 20,
            store: store,
            displayInfo: false,
            plugins: new Ext.ux.ProgressBarPager()
        })
    });
    
        var locationForm = new Ext.FormPanel({
        labelWidth: 45, // label settings here cascade unless overridden
        labelAlign:"center",
        frame:true,
        bodyStyle:'padding:0px 0px 0',
        width: 300,
        defaults: {width: 135},
        defaultType: 'textfield',

      reset:function(){
          this.getEl().dom.reset();
          parent.center.center.clearMap('location');
      },
       
        buttons: [{
            text: '跟踪1',handler: function(){
			parent.center.center.drawTrack(40571679,3461254,40573723,3461909);
            }
        },{
            text: '跟踪2',handler: function(){
			parent.center.center.drawTrack(40573723,3461909,40574610,3464531);
            }
        },{
            text: '跟踪3',handler: function(){
			parent.center.center.drawTrack(40574610,3464531,40571216,3464609);
            }
        },{
            text: '跟踪4',handler: function(){
			parent.center.center.drawTrack(40571216,3464609,40571293,3467655);
            }
        }]
    });
    
    
    
    grid.render('form-ct');
    locationForm.render('form-ct');
    grid.on('cellclick',function(e){
        var row = grid.getSelectionModel().getSelected();
        parent.center.center.doLocationItWithPoint('pdaStatus', row.data.pda_x, row.data.pda_y,true);
    });

	store.load({params:{start:0, limit:20}});
	
});