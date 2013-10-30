Ext.onReady(function(){           
   var form2 = new Ext.form.FormPanel({
        autoHeight: true,
        frame:true,
        bodyStyle:'padding:5px 0px 0',
        width: 400,
  		labelWidth :60,   
  		labelAlign : "right",
        url:"",
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
	                xtype: 'numberfield',
	                id      : 'nd',
	                value:'',
	                fieldLabel: '年度',
	                maxValue:2030,
	                minValue:2012,
	                 readOnly:true,
	                 width :120
	                }]
           	  	},
	            {
	            columnWidth: .5, 
           	  	layout : "form",
           	  	items :[{
	                xtype: 'numberfield',
	                id      : 'jd',
	                value:'',
	                fieldLabel: '季度',
	                maxValue:4,
	                minValue:1,
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
							 	
							 });
							
							}, 
							failure:function(){ 
								Ext.Msg.alert('提示','保存失败，请稍后重试或联系管理员。');
							} 
						});
                	}
            	},   
            	            {
                text   : '删除',
                handler: function() {
						 	Ext.Msg.confirm("删除确认","是否真的要删除该计划?",function(btuuon){
                              	 if(btuuon=="yes"){
                              	 	  putClientCommond("planManager","delKftl");
  									  putRestParameter("xmmc",escape(escape(Ext.getCmp("xmmc").getValue())));
									  putRestParameter("nd",Ext.getCmp("nd").getValue());
									  putRestParameter("jd",Ext.getCmp("jd").getValue());
									   var msg= restRequest();
									   Ext.Msg.alert("提示","删除"+(msg.success==true?"成功":"失败"));
									        win2.hide();                               	
									   }
							 });
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
    
    
    
    //////////////////////////////////////////////////////////////////////////
	   
	    var form3 = new Ext.form.FormPanel({
        autoHeight: true,
        frame:true,
        bodyStyle:'padding:5px 0px 0',
        width: 400,
        labelWidth :60,   
  		labelAlign : "right",
        url:"",
        defaults: {
            anchor: '0'
        },
        items   : [
           	{
                xtype: 'textfield',
                id      : 'gdxmmc',
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
	                xtype: 'numberfield',
	                id      : 'gdnd',
	                value:'',
	                fieldLabel: '年度',
	                maxValue:2030,
	                minValue:2012,
	                 readOnly:true,
	                 width :120
	                }]
           	  	},
	            {
	            columnWidth: .5, 
           	  	layout : "form",
           	  	items :[{
	                xtype: 'numberfield',
	                id      : 'gdjd',
	                value:'',
	                fieldLabel: '季度',
	                maxValue:4,
	                minValue:1,
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
	                id      : 'gdxmdl',
	                value:'',
	                fieldLabel: '项目地量',
	                 readOnly:true,
	                width :60
	                }]},{
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'gddl',
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
	                id      : 'gddlbl',
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
	                id      : 'gdxmgm',
	                value:'',
	                fieldLabel: '项目规模',
	                 readOnly:true,
	                width :60
	                }]},{
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'gdgm',
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
	                id      : 'gdgmbl',
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
	                id      : 'gdlmcb',
	                value:'',
	                fieldLabel: '楼面成本',
	                 readOnly:true,
	                width :60
	                }]},{
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'gdcb',
	                value:'',
	                fieldLabel: '成本',
	                   readOnly:true,
	                 width :60
	                }]}, 
	                {
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'gdcbbl',
	                value:'',
	                minValue:0,
	                maxValue:100,
	                fieldLabel: '成本%',
	                   readOnly:true,
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
	                id      : 'gdcjj',
	                value:'',
	                fieldLabel: '楼面成交价',
	                readOnly:true,
	                width :60
	                }]},{
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'gdsy',
	                value:'',
	                fieldLabel: '收益',
	                   readOnly:true,
	                 width :60
	                }]}, 
	                {
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'gdsybl',
	                value:'',
	                minValue:0,
	                maxValue:100,
	                fieldLabel: '收益%',
	                  readOnly:true,
	                  width : 60
	                
                }]
            }]},
            {
   			 layout : "column", 
           	 items:[
           	 {  
           	 columnWidth: .33, 
           	  	layout : "form",   
           	  	items :[  
           	  	{
	                xtype: 'numberfield',
	                id      : 'gdfwsj',
	                value:'',
	                fieldLabel: '房屋售价',
	                readOnly:true,
	                width :60
	                }]}
	            ,
           	 {
           	    columnWidth: .33, 
           	  	layout : "form",   
           	  	items :[     {
                xtype: 'numberfield',
                id      : 'gdzj',
                value:'',
                fieldLabel: '总价',
                   readOnly:true,
                 width : 60
            }]},
	            {
	            columnWidth: .33, 
           	  	layout : "form",
           	  	items :[  {
                xtype: 'numberfield',
                id      : 'gdzjbl',
                value:'',
                minValue:0,
	            maxValue:100,
                fieldLabel: '总价%',
                   readOnly:true,
                 width : 60
          		  }]}
            ]},{
   			 layout : "column", 
           	 items:[{
	            columnWidth: .33, 
           	  	layout : "form",
           	  	items :[  {
                xtype: 'numberfield',
                id      : 'gdxmzujin',
                value:'',
                fieldLabel: '项目租金',
                 width : 60
          		  }]},{
	            columnWidth: .33, 
           	  	layout : "form",
           	  	items :[{
                xtype: 'numberfield',
                id      : 'gdzujin',
                value:'',
                fieldLabel: '租金',
                 width : 60
          		  }]}]
              },{
	                xtype: 'label',
	                id      : 'gdsm',
	                value:'',
	                fieldLabel: '',
	                html:'<div style="color:red">&nbsp&nbsp地量:公顷&nbsp&nbsp规模:万m2&nbsp&nbsp成本收益:亿元&nbsp&nbsp&nbsp总价:万元/m2&nbsp&nbsp&nbsp租金:元/m2/天</div>',
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
  
        Ext.getCmp("gddlbl").addListener('change',function(){   
	 	Ext.getCmp("gddl").setValue(Ext.getCmp("gdxmdl").getValue()*Ext.getCmp("gddlbl").getValue()/100);
	 	});
	   Ext.getCmp("gdgmbl").addListener('change',function(){   
	 	Ext.getCmp("gdgm").setValue(Ext.getCmp("gdxmgm").getValue()*Ext.getCmp("gdgmbl").getValue()/100);
	 	Ext.getCmp("gdcb").setValue(Ext.getCmp("gdgm").getValue()*Ext.getCmp("gdlmcb").getValue());
	 	Ext.getCmp("gdcbbl").setValue(Ext.getCmp("gdgmbl").getValue());
	 	Ext.getCmp("gdsybl").setValue(Ext.getCmp("gdgmbl").getValue());
	 	Ext.getCmp("gdzjbl").setValue(Ext.getCmp("gdgmbl").getValue());
	 });
  
   win3=new Ext.Window({
                applyTo:'addWin2',
                title:'供地体量录入',
                width:410,
                height:335,
                closeAction:'hide',
				items:form3
    });

})

 function dealGdtl(xmmc,nd,jd){
 	 putClientCommond("planManager","getXm");
     putRestParameter("xmmc",escape(escape(xmmc)));
   	 var info = restRequest();
   	 	  Ext.getCmp("gdxmmc").setValue(xmmc);
	  	  Ext.getCmp("gdnd").setValue(nd);
	  	  Ext.getCmp("gdjd").setValue(jd);
	 if(info[0]!=null){
		  Ext.getCmp("gdxmdl").setValue(info[0].ZD);
		  Ext.getCmp("gdxmgm").setValue(info[0].GM);
		  Ext.getCmp("gdlmcb").setValue(info[0].LMCB);
		  Ext.getCmp("gdzujin").setValue(info[0].ZJ); 
		  Ext.getCmp("gdxmzujin").setValue(info[0].ZJ); 
		  Ext.getCmp("gdcjj").setValue(info[0].LMCJJ);
		  Ext.getCmp("gdfwsj").setValue(info[0].FWSJ); 
		  Ext.getCmp("gdsy").setValue(Ext.getCmp("gdcjj").getValue()-Ext.getCmp("gdlmcb").getValue()); 
		  Ext.getCmp("gdzj").setValue(info[0].FWSJ); 
	 }
	  putClientCommond("hxxmManager","getGdtl");
      putRestParameter("xmmc",escape(escape(xmmc)));
	  putRestParameter("nd",nd);
	  putRestParameter("jd",jd);
	  var sinData= restRequest();
	  if(sinData[0]!=null){
	  		    win3.items.items[0].form.url=restUrl+'planManager/updateGdtl';
   			    win3.setTitle("供地体量修改");
			    Ext.getCmp("gddl").setValue(sinData[0].DL);
			    Ext.getCmp("gddlbl").setValue(sinData[0].DLZ);
			    Ext.getCmp("gdgm").setValue(sinData[0].GM);
			    Ext.getCmp("gdgmbl").setValue(sinData[0].GMZ);
			    Ext.getCmp("gdcb").setValue(sinData[0].CB);
			    Ext.getCmp("gdcbbl").setValue(sinData[0].CBZ);
			    Ext.getCmp("gdsybl").setValue(sinData[0].SYZ);
			    Ext.getCmp("gdzjbl").setValue(sinData[0].ZJZ);
	  }else{
	        win3.items.items[0].form.url=restUrl+'planManager/addGdtll';
   			win3.setTitle("供地体量录入");
	  }
	  win3.show();
 }

 function dealKftl(xmmc,nd,jd){
 	 putClientCommond("planManager","getXm");
     putRestParameter("xmmc",escape(escape(xmmc)));
   	 var info = restRequest();
   	 	  Ext.getCmp("xmmc").setValue(xmmc);
	  	  Ext.getCmp("nd").setValue(nd);
	  	  Ext.getCmp("jd").setValue(jd);
	 if(info[0]!=null){
	   	  Ext.getCmp("xmhs").setValue(info[0].HS);
	  	  Ext.getCmp("xmdl").setValue(info[0].ZD);
	  	  Ext.getCmp("xmgm").setValue(info[0].GM);
	  	  Ext.getCmp("xmz").setValue(info[0].ZZCQFY);
	  	  Ext.getCmp("xmq").setValue(info[0].QYCQFY);
	  	  Ext.getCmp("xmtz").setValue(info[0].CQHBTZ);
	  	  Ext.getCmp("lm").setValue(info[0].LMCB);
	  	  Ext.getCmp("cj").setValue(info[0].LMCJJ);
	 }
	  putClientCommond("hxxmManager","getKftl");
      putRestParameter("xmmc",escape(escape(xmmc)));
	  putRestParameter("nd",nd);
	  putRestParameter("jd",jd);
	  var sinData= restRequest();
	  if(sinData[0]!=null){
	  		   win2.items.items[0].form.url=restUrl+'planManager/updateKftl';
   			    win2.setTitle("开发体量修改")
	            Ext.getCmp("hs").setValue(sinData[0].HS);
			    Ext.getCmp("dl").setValue(sinData[0].DL);
			    Ext.getCmp("gm").setValue(sinData[0].GM);
			    Ext.getCmp("tz").setValue(sinData[0].TZ);
			    Ext.getCmp("z").setValue(sinData[0].Z);
			    Ext.getCmp("q").setValue(sinData[0].Q);
			    Ext.getCmp("hsbl").setValue(sinData[0].HSZ);
			    Ext.getCmp("dlbl").setValue(sinData[0].DLZ);
			    Ext.getCmp("gmbl").setValue(sinData[0].GMZ);
			    Ext.getCmp("tzbl").setValue(sinData[0].TZZ);
			    Ext.getCmp("zbl").setValue(sinData[0].ZHUZ);
			    Ext.getCmp("qbl").setValue(sinData[0].QIZ);
			    Ext.getCmp("lm").setValue(sinData[0].LM);
			    Ext.getCmp("cj").setValue(sinData[0].CJ);
	  }else{
	         win2.items.items[0].form.url=restUrl+'planManager/addKftl';
   			 win2.setTitle("开发体量录入");
	  }
	   win2.show();
 }
