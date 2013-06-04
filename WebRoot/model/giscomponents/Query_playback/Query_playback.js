
Ext.onReady(function(){
	var _$ID = '';

    var store = new Ext.data.ArrayStore({
		proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
		   {name: 'objectid'},
           {name: 'no'},
           {name: 'name'},
           {name: 'senddate'}
        ]
    });
	
	var myData = [['','','','','','',''	]];
	function loadData(){
	    Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
		var startdt = dr.get('startdt').getValue();
		var enddt = dr.get('enddt').getValue();
		var pdaid = dr.get('pdaid').getValue();
		if(startdt != null && startdt != "" && enddt != null && enddt != ""){
		    startdt = startdt.format("Y-m-d");
			enddt = enddt.format("Y-m-d");
		}else{
			if(pdaid == null || pdaid == ""){
				return;
			}
		}
	    parent.center.center.putClientCommond("playback","queryPDA");
	    parent.center.center.putRestParameter("_$sid","aaa");
	    parent.center.center.putRestParameter("starttime",startdt);
	    parent.center.center.putRestParameter("endtime",enddt);
	    parent.center.center.putRestParameter("pdaidorname",escape(escape(pdaid)));
	    myData = parent.center.center.restRequest();
		store.loadData(myData);
	}

    var grid = new Ext.grid.GridPanel({
        store: store,
        columns: [
		    {header:'', width:0, sortable:true, dataIndex:'objectid'},
            {id:'no', header:'PDA编号', width:20, sortable:false, dataIndex:'no'},
            {header:'PDA名称', width:85, sortable:true, dataIndex:'name'},
            {header:'日期', width:105, sortable:true, dataIndex:'senddate'}
        ],
        stripeRows: true,
        autoExpandColumn: 'no',
        height: 480,
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
	
	
    grid.on('cellclick',function(e){
		var row = grid.getSelectionModel().getSelected();
		parent.center.center.putClientCommond("playback","queryPDADetail");
	    parent.center.center.putRestParameter("_$sid","aaa");
	    parent.center.center.putRestParameter("id",row.data.no);
	    parent.center.center.putRestParameter("dat",row.data.senddate);
	    var data = parent.center.center.restRequest();
		var pl = new esri.geometry.Polyline(parent.center.center.getMapSpatialReference());
		pl.addPath([[40446344,3591443],[40446544,3591443]],[[40446544,3591443],[40446944,3591443]]);
		//pl.addPath(data);
		var highlightGraphic = new esri.Graphic(pl,parent.center.center.commonsls);
		parent.center.center.addHighlight(highlightGraphic);
		//parent.center.center.setMapExtent(graphic.geometry.getExtent().expand(7));
		
		
    });
	
	store.load({params:{start:0, limit:20}});
	grid.render('form-ct');
	
	var dr = new Ext.FormPanel({
        labelWidth: 90,
        frame: true,
        bodyStyle:'padding:5px 5px 0',
        width: 300,
        defaults: {width: 175},
        defaultType: 'datefield',
	    items: [{
            fieldLabel: '开始时间',
            name: 'startdt',
			format : "Y-m-d",
			showToday:true,
			editable : false,
            id: 'startdt',
            vtype: 'daterange',
            endDateField: 'enddt' // id of the end date field
          },{
            fieldLabel: '结束时间',
            name: 'enddt',
			format : "Y-m-d",
			showToday:true,
			editable : false,
            id: 'enddt',
            vtype: 'daterange',
            startDateField: 'startdt' // id of the start date field
          },{
            fieldLabel: 'PDA名称或编号',
			xtype: 'field',
            id: 'pdaid',
            minValue: 0,
            maxValue: 200,
            allowDecimals: true,
            decimalPrecision: 1,
            incrementValue: 0.4,
            alternateIncrementValue: 2.1,
            accelerate: true
          }],
		   buttons: [{
            text: '查询',handler: function(){
				loadData();
            }
        },{
            text: '重置',
            type:'reset',
            handler: function(){
                dr.form.reset();
            }
        }]
    });
    dr.render('form-dr');
});

Ext.apply(Ext.form.VTypes, {
    daterange : function(val, field) {
        var date = field.parseDate(val);
        if(!date){
            return false;
        }
        if (field.startDateField && (!this.dateRangeMax || (date.getTime() != this.dateRangeMax.getTime()))) {
            var start = Ext.getCmp(field.startDateField);
            start.setMaxValue(date);
            start.validate();
            this.dateRangeMax = date;
        }
        else if (field.endDateField && (!this.dateRangeMin || (date.getTime() != this.dateRangeMin.getTime()))) {
            var end = Ext.getCmp(field.endDateField);
            end.setMinValue(date);
            end.validate();
            this.dateRangeMin = date;
        }
        return true;
    }
});