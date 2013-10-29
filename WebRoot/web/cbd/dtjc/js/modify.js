Ext.onReady(function(){           
   var form2 = new Ext.form.FormPanel({
        autoHeight: true,
        frame:true,
        bodyStyle:'padding:5px 0px 0',
        width: 400,
  		labelWidth :60,   
  		labelAlign : "right",
        url:"<%=basePath%>service/rest/hxxmManager/addKftl?xmbh=<%=yw_guid%>",
        defaults: {
            anchor: '0'
        },
        items   : [
           	{
                xtype: 'textfield',
                id      : 'xmmc',
                value:'',
                fieldLabel: '项目名称',
                readOnly:true
            },
    		{
   			 layout : "column", 
           	 items:[{
           	    columnWidth: .5, 
           	  	layout : "form",   
           	  	items :[{
	                xtype: 'textfield',
	                id      : 'nd',
	                value:'',
	                fieldLabel: '年度',
	                 readOnly:true,
	                 width :120
	                }]
           	  	},
	            {
	            columnWidth: .5, 
           	  	layout : "form",
           	  	items :[{
	                xtype: 'textfield',
	                id      : 'jd',
	                value:'',
	                fieldLabel: '季度',
	                 readOnly:true,
	                 width :120
	                }] 
            }]},
   			{
   			 layout : "column", 
           	 items:[{
           	    columnWidth: .33, 
           	  	layout : "form",   
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'xmhs',
	                value:'',
	                fieldLabel: '项目户数',
	                readOnly:true,
	                width :60
	                }]},{
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'hs',
	                value:'',
	                fieldLabel: '户数',
	                 readOnly:true,
	                 width :60
	                }]}, 
	                {
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'hsbl',
	                value:'',
	                minValue:0,
	                maxValue:100,
	                fieldLabel: '户数%',
	                width : 60
                }]
            }]},
           {
   			 layout : "column", 
           	 items:[{
           	    columnWidth: .33, 
           	  	layout : "form",   
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'xmdl',
	                value:'',
	                fieldLabel: '地量总数',
	                readOnly:true,
	                width :60
	                }]},{
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'dl',
	                value:'',
	                fieldLabel: '地量',
	                readOnly:true,
	                width :60
	                }]}, 
	                {
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'dlbl',
	                value:'',
	                minValue:0,
	                maxValue:100,
	                fieldLabel: '地量%',
	                  width : 60
	                
                }]
            }]},
			{
   			 layout : "column", 
           	 items:[{
           	    columnWidth: .33, 
           	  	layout : "form",   
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'xmgm',
	                value:'',
	                fieldLabel: '规模总数',
	                readOnly:true,
	                width :60
	                }]},{
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'gm',
	                value:'',
	                fieldLabel: '规模',
	                readOnly:true,
	                width :60
	                }]}, 
	                {
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'gmbl',
	                value:'',
	                minValue:0,
	                maxValue:100,
	                fieldLabel: '规模%',
	                width : 60
                }]
            }]}, 
           {
   			 layout : "column", 
           	 items:[{
           	    columnWidth: .33, 
           	  	layout : "form",   
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'xmtz',
	                value:'',
	                fieldLabel: '投资总数',
	                readOnly:true,
	                width :60
	                }]},{
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'tz',
	                value:'',
	                fieldLabel: '投资',
	                readOnly:true,
	                 width :60
	                }]}, 
	                {
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'tzbl',
	                value:'',
	                minValue:0,
	                maxValue:100,
	                fieldLabel: '投资%',
	                readOnly:true,
	                width : 60
                }]
            }]},{
   			 layout : "column", 
           	 items:[{
           	    columnWidth: .33, 
           	  	layout : "form",   
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'xmz',
	                value:'',
	                fieldLabel: '住总数',
	                readOnly:true,
	                width :60
	                }]},{
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'z',
	                value:'',
	                fieldLabel: '住',
	                readOnly:true,
	                 width :60
	                }]}, 
	                {
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'zbl',
	                value:'',
	                minValue:0,
	                maxValue:100,
	                fieldLabel: '住%',
	                width : 60
	                
                }]
            }]},
			{
   			 layout : "column", 
           	 items:[{
           	    columnWidth: .33, 
           	  	layout : "form",   
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'xmq',
	                value:'',
	                fieldLabel: '企总数',
	                readOnly:true,
	                width :60
	                }]},{
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'q',
	                value:'',
	                fieldLabel: '企',
	                readOnly:true,
	                 width :60
	                }]}, 
	                {
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'qbl',
	                value:'',
	                minValue:0,
	                maxValue:100,
	                fieldLabel: '企%',
	                width : 60
                }]
            }]},{
   			 layout : "column", 
           	 items:[{
           	    columnWidth: .33, 
           	  	layout : "form",   
           	  	items :[{
	           	    xtype: 'numberfield',
	                id      : 'lm',
	                value:'',
	                fieldLabel: '楼面',
	                readOnly:true,
	                width : 60
           	  	}]},
	            {
	            columnWidth: .33, 
           	  	layout : "form",
           	  	items :[{
	           	    xtype: 'numberfield',
	                id      : 'cj',
	                value:'',
	                minValue:0,
	                fieldLabel: '成交',
	                readOnly:true,
	                width : 60
           	  	}]}
            ]},
           	  	{
	                xtype: 'label',
	                id      : 'sm',
	                value:'',
	                fieldLabel: '',
	                html:'<div style="color:red">&nbsp&nbsp&nbsp&nbsp&nbsp地量:公顷&nbsp&nbsp&nbsp规模:万m2&nbsp&nbsp&nbsp住企投资:亿元&nbsp&nbsp&nbsp楼面成交:万元/m2</div>',
	                readOnly:true
           		 }       
        ],
        buttons: [
            {
                text   : '保存',
                handler: function() {
						form2.form.submit({ 
							waitMsg: '正在保存,请稍候... ', 		
							success:function(){ 
							 Ext.Msg.alert('提示','保存成功。',function(){
							   query();	
							 });
							
							}, 
							failure:function(){ 
								Ext.Msg.alert('提示','保存失败，请稍后重试或联系管理员。');
							} 
						});
                	}
            	},   
            {
                text   : '关闭',
                handler: function() {
				    win2.hide();
                }
            }
        ]
  });		
	 Ext.getCmp("hsbl").addListener('change',function(){   
	 	Ext.getCmp("hs").setValue(Ext.getCmp("xmhs").getValue()*Ext.getCmp("hsbl").getValue()/100);
	 });
	 Ext.getCmp("dlbl").addListener('change',function(){   
	 	Ext.getCmp("dl").setValue(Ext.getCmp("xmdl").getValue()*Ext.getCmp("dlbl").getValue()/100);
	 });
	 Ext.getCmp("gmbl").addListener('change',function(){   
	 	Ext.getCmp("gm").setValue(Ext.getCmp("xmgm").getValue()*Ext.getCmp("gmbl").getValue()/100);
	 });
  	 Ext.getCmp("zbl").addListener('change',function(){   
	 	Ext.getCmp("z").setValue(Ext.getCmp("xmz").getValue()*Ext.getCmp("zbl").getValue()/100);
	 	Ext.getCmp("tz").setValue(Ext.getCmp("z").getValue()+Ext.getCmp("q").getValue());
	 	Ext.getCmp("tzbl").setValue(Ext.getCmp("tz").getValue()*100/Ext.getCmp("xmtz").getValue());
	 });
  	 Ext.getCmp("qbl").addListener('change',function(){   
	 	Ext.getCmp("q").setValue(Ext.getCmp("xmq").getValue()*Ext.getCmp("qbl").getValue()/100);
	 	Ext.getCmp("tz").setValue(Ext.getCmp("z").getValue()+Ext.getCmp("q").getValue());
	 	Ext.getCmp("tzbl").setValue(Ext.getCmp("tz").getValue()*100/Ext.getCmp("xmtz").getValue());
	 });	 
  
   win2=new Ext.Window({
                applyTo:'addWin',
                title:'开发体量录入',
                width:410,
                height:350,
                closeAction:'hide',
				items:form2
    });
    putClientCommond("hxxmManager","getXmmc");
    putRestParameter("xmbh",'<%=yw_guid%>')
	var info = restRequest();
	if(info[0]!=null){
  	  Ext.getCmp("xmmc").setValue(info[0].XMNAME);
  	  Ext.getCmp("xmhs").setValue(info[0].HS);
  	  Ext.getCmp("xmdl").setValue(info[0].ZD);
  	  Ext.getCmp("xmgm").setValue(info[0].GM);
  	  Ext.getCmp("xmz").setValue(info[0].ZZCQFY);
  	  Ext.getCmp("xmq").setValue(info[0].QYCQFY);
  	  Ext.getCmp("xmtz").setValue(info[0].CQHBTZ);
  	  Ext.getCmp("lm").setValue(info[0].LMCB);
  	  Ext.getCmp("cj").setValue(info[0].LMCJJ);
    }
})

 function addTask(){
    win2.items.items[0].form.url='<%=basePath%>service/rest/hxxmManager/addKftl?xmbh=<%=yw_guid%>';
    win2.setTitle("开发体量录入");
    Ext.getCmp("hs").reset();
    Ext.getCmp("dl").reset();
    Ext.getCmp("gm").reset();
    Ext.getCmp("tz").reset();
    Ext.getCmp("z").reset();
    Ext.getCmp("q").reset();
    Ext.getCmp("hsbl").reset();
    Ext.getCmp("dlbl").reset();
    Ext.getCmp("gmbl").reset();
    Ext.getCmp("tzbl").reset();
    Ext.getCmp("zbl").reset();
    Ext.getCmp("qbl").reset();
    win2.show();
 }