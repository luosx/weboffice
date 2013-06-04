
Ext.onReady(function(){
	//Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
	parent.putClientCommond("wpzfjc","doit");
	parent.putRestParameter("_$sid","aaa");
	var myData = parent.restRequest();
	
	var _$ID = '';
    function change(val){
        if(val > 10000){
            return '<span style="color:green;">√</span>';
        }else if(val < 10000){
            return '<span style="color:red;size=20">×</span>';
        }
        return val;
    }

    var store = new Ext.data.ArrayStore({
		proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
		   {name: 'objectid'},
           {name: 'no'},
           {name: 'xzmc'},
           {name: 'area'},
           {name: 'warning'}
		   
        ]
    });

    store.loadData(myData);

    var grid = new Ext.grid.GridPanel({
        store: store,
        columns: [
		    {header:'', width:0, sortable:true, dataIndex:'objectid'},
            {id:'no', header:'编号', width:20, sortable:false, dataIndex:'no'},
            {id:'no', header:'政区', width:90, sortable:false, dataIndex:'xzmc'},
            {header:'图斑面积', width:105, sortable:true, dataIndex:'area'},
            {header:'报警', width:35, sortable:true, renderer:change, dataIndex:'warning'}
        ],
        stripeRows: true,
        autoExpandColumn: 'no',
        height: 370,
        width: 310,
        stateful: true,
        stateId: 'grid',
		
	    plugins: new Ext.ux.PanelResizer({
            minHeight: 100
        }),

        bbar: new Ext.PagingToolbar({
            pageSize: 15,
            store: store,
            displayInfo: false,
            plugins: new Ext.ux.ProgressBarPager()
        })
    });
	
    grid.render('form-ct');

    grid.on('cellclick',function(e){
        var row = grid.getSelectionModel().getSelected();
		_$ID = row.data.objectid;
		var url = 'http://gisserver:8399/arcgis/rest/services/YZ_WPZFJC/MapServer/0';
		var infoTemplate = new esri.InfoTemplate();
		infoTemplate.setTitle("${NAME}");
        infoTemplate.setContent("<b>2000 Population: </b>${POP2000}<br/>"
                             + "<b>2000 Population per Sq. Mi.: </b>${POP00_SQMI}<br/>"
                             + "<b>2007 Population: </b>${POP2007}<br/>"
                             + "<b>2007 Population per Sq. Mi.: </b>${POP07_SQMI}");
		
		var query = new esri.tasks.Query();
        query.outFields = ["*"];
        query.returnGeometry = true;
        query.where = "objectid = " + _$ID;
        query.outSpatialReference = parent.getMapSpatialReference();
	    var queryTask = new esri.tasks.QueryTask(url);
	    dojo.connect(queryTask, "onComplete", function(featureSet) {
		    parent.clearHighlight();
		    var graphic = featureSet.features[0];
			graphic.setInfoTemplate(infoTemplate);
			//alert(featureSet.features[0].getContent());
	        var highlightGraphic = new esri.Graphic(graphic.geometry,parent.commonbluelight);
		    parent.addHighlight(highlightGraphic);
		    //parent.center.setMapExtent(graphic.geometry.getExtent().expand(7));
	    });
        queryTask.execute(query);
		
		//fbutton.onEnable(true);
		
    });

	store.load({params:{start:0, limit:15}});
	
	
	var fp = new Ext.form.FormPanel({
        renderTo: 'form-ct',
        fileUpload: true,
        autoWidth: true,
        autoHeight: true,
		bodyStyle: 'padding: 10px 10px 0 10px;',
        labelWidth: 10,
        items: [{
            xtype: 'fileuploadfield',
            id: 'form-file',
            emptyText: '可导入PDA采集shape文件',
            name: 'shape-path',
            buttonText: '浏览',
			width:270
        }],
        buttons: [{
            text: '预览',
            handler: function(){
                if(fp.getForm().isValid()){
	                fp.getForm().submit({
						url: parent.restUrl + 'importShapefile/perviewShapefile?objectid=0&bjectid2=' + _$ID,
						method:'POST', 
						waitTitle:'提示',
	                    waitMsg: '正在导入,请稍后...',
						
	                    success: function(form,action){

	                    },
                        failure:function(form,action){
							var json=strToJson(action.response.responseText);
							var polygon = new esri.geometry.Polygon(parent.getMapSpatialReference());
							for(var i = 0; i < json[0].geo.length; i++){
								var geo = json[0].geo;
								//alert(geo[i])
								polygon.addRing(geo[i]);
							}
							var highlightGraphic = new esri.Graphic(polygon,parent.commonbluelight);
		                    parent.addHighlight(highlightGraphic);
		                    parent.setMapExtent(polygon.getExtent().expand(3));
                        }
	                });
                }
            }
        },{
            text: '保存',
            handler: function(){
            }
        }]
    });
	
	
});

		function strToJson(str){
     var json = eval('(' + str + ')');
     return json;
}