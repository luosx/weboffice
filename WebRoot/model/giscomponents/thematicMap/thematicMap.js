Ext.onReady(function(){
    //  Create code view Panels. Ignore.
	
	var subStore = new Ext.data.JsonStore({
        fields:["text","value","all"],
        data : [{text:'新增建设用地专题',value:'1',all:[{all:'规划符合情况',value:'1'},{all:'区域分布情况',value:'2'},{all:'审批分析供地分析',value:'3'},{all:'核查结论',value:'4'}]},
        	    {text:'建设用地审批专题',value:'2',all:[{all:'建设用地审批专题1',value:'1'},{all:'建设用地审批专题2',value:'2'}]},
        	    {text:'土地利用现状专题',value:'3',all:[{all:'土地利用现状专题1',value:'1'},{all:'土地利用现状专题2',value:'2'}]},
        	    {text:'土地利用规划专题',value:'4',all:[{all:'土地利用规划专题1',value:'1'},{all:'土地利用规划专题2',value:'2'}]},
        	    {text:'供地专题',value:'5',all:[{all:'供地专题1',value:'1'},{all:'供地专题2',value:'2'}]}
        	    ]
    });
	
	
    var store= new Ext.data.JsonStore({
		data:[],
		fields:["all","value"]
											});
										
											
	var subjects=new Ext.form.ComboBox({
	                    id: 'subject1',
		                mode: 'local',
                		triggerAction:  'all',               		
                		fieldLabel: '专题类别',
                		displayField:   'text',
               			valueField:     'value',
               			emptyText: '请选择专题',
                		store: subStore,
                		listeners:{
									"select":function(combo,record,index){
											subjects2.clearValue();
											store.loadData(record.data.all);										
								  }
												  }
	});										
											
	var subjects2=new Ext.form.ComboBox({
	                    id:'subject2',
		                mode: 'local',
                		triggerAction:  'all',               		
                		fieldLabel: '',
                		displayField:   'all',
               			valueField:     'value',
               			emptyText: '请选择',
                		store: store,
                		listeners:{
									"select":function(combo,record,index){
																								
													   					 }
										}
	});																				
	
  var locationForm = new Ext.FormPanel({
        labelWidth: 70, // label settings here cascade unless overridden
        labelAlign:"center",
        frame:true,
        width: 300,
        bodyStyle:'padding:0px 0px 0',
        defaultType: 'textfield',
    	renderTo: 'panel',
    	items:[subjects,subjects2,
                	  {
                	  xtype:'button', 
                	  text:'确定',
					    handler: function() {
					    						if(!Ext.getCmp('subject1').getValue()){
					    							Ext.Msg.alert('提示','请选择专题类别！');
					    							return false;
					    						}
					    						if(!Ext.getCmp('subject2').getValue()){
					    							Ext.Msg.alert('提示','请选择专题类别2！');
					    							return false;
					    						}
					    					  alert(Ext.getCmp('subject1').getValue())
					    					  alert(Ext.getCmp('subject2').getValue())
											  parent.center.center.setMapVisiable('YZ_ZTFX',[0])
											  var type=Ext.getCmp('subject1').getValue()+(Ext.getCmp('subject2').getValue());
											  alert(type);
    										  document.all.legend.src=basePath+'/gisapp/pages/components/legend/legend.jsp?type='+type;
            								}
						}
                	  ]
    });
   
}


);