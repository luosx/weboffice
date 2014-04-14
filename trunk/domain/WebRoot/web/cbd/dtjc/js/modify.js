var nd;
var jd;
Ext.onReady(function(){           
     form2 = new Ext.form.FormPanel({
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
	                fieldLabel: '拆迁户数',
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
	                fieldLabel: '占地面积',
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
	                fieldLabel: '建筑规模',
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
	                fieldLabel: '货币投资',
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
	                fieldLabel: '住宅',
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
	                fieldLabel: '非住宅',
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
	                fieldLabel: '楼面成本',
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
	                fieldLabel: '成交价',
	                readOnly:true,
	                width : 60
           	  	}]}
            ]},
           	  	{
	                xtype: 'label',
	                id      : 'sm',
	                value:'',
	                fieldLabel: '',
	                html:'<div style="color:red">&nbsp&nbsp&nbsp&nbsp&nbsp地量:公顷&nbsp&nbsp&nbsp规模:万m2&nbsp&nbsp&nbsp住、企、投资:亿元&nbsp&nbsp&nbsp楼面成交:万元/m2</div>',
	                readOnly:true
           		 }       
        ],
        buttons: [
            {
                text   : '保存',
                id:'btnkf',
                handler: function() {
						form2.form.submit({ 
							waitMsg: '正在保存,请稍候... ', 		
							success:function(){ 
							 Ext.Msg.alert('提示','保存成功。',function(){
							        form2.form.url=restUrl+'planManager/updateKftl?year='+nd+'&jd='+jd;
	  							    Ext.getCmp("btnkf").setText("修改开发体量");
	  							    window.location.reload();
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
									   window.location.reload();                           	
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
  form2.render("deal");
  form2.hide();
	 /**
   win2=new Ext.Window({
                applyTo:'addWin',
                title:'开发体量录入',
                width:410,
                height:350,
                closeAction:'hide',
				items:form2
    });
    **/

    
    //////////////////////////////////////////////////////////////////////////
	   
	     form3 = new Ext.form.FormPanel({
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
	                fieldLabel: '占地面积',
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
	                fieldLabel: '建筑规模',
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
	                id      : 'gdxmsy',
	                value:'',
	                fieldLabel: '项目收益',
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
            }]} ,
           	 {
           	    columnWidth: .33, 
           	  	layout : "form",   
           	  	items :[     {
                xtype: 'numberfield',
                id      : 'gdzjbl',
                value:'',
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
	                html:'<div style="color:red">&nbsp&nbsp占地面积:公顷&nbsp&nbsp规模:万m2&nbsp&nbsp成本、收益:亿元&nbsp&nbsp&nbsp楼面成本、总价:万元/m2&nbsp&nbsp&nbsp租金:元/m2/天</div>',
	                readOnly:true
           		 }            
        ],
        buttons: [
            {
                text   : '保存',
                id:'btngd',
                handler: function() {
						form3.form.submit({ 
							waitMsg: '正在保存,请稍候... ', 		
							success:function(){ 
							 Ext.Msg.alert('提示','保存成功。',function(){
							 	  form3.form.url=restUrl+'planManager/updateGdtl?year='+this.nd+'&jd='+this.jd;
	  							    Ext.getCmp("btngd").setText("修改供地体量");
	  							    window.location.reload();      
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
                              	 	  putClientCommond("planManager","delGdtl");
  									  putRestParameter("xmmc",escape(escape(Ext.getCmp("xmmc").getValue())));
									  putRestParameter("nd",Ext.getCmp("nd").getValue());
									  putRestParameter("jd",Ext.getCmp("jd").getValue());
									   var msg= restRequest();
									   Ext.Msg.alert("提示","删除"+(msg.success==true?"成功":"失败"));
									   window.location.reload();                           	
									   }
							 });
                	}
            	}
        ]
  });		
  
        Ext.getCmp("gddlbl").addListener('change',function(){   
	 	Ext.getCmp("gddl").setValue(Ext.getCmp("gdxmdl").getValue()*Ext.getCmp("gddlbl").getValue()/100);
	 	});
	   Ext.getCmp("gdgmbl").addListener('change',function(){   
	 	Ext.getCmp("gdgm").setValue(Ext.getCmp("gdxmgm").getValue()*Ext.getCmp("gdgmbl").getValue()/100);
	 	Ext.getCmp("gdcb").setValue(Ext.getCmp("gdgm").getValue()*(Ext.getCmp("gdlmcb").getValue()));
	 	Ext.getCmp("gdsy").setValue((Ext.getCmp("gdxmsy").getValue()-Ext.getCmp("gdlmcb").getValue())*Ext.getCmp("gdgm").getValue()); 
	 	Ext.getCmp("gdcbbl").setValue(Ext.getCmp("gdgmbl").getValue());
	 	Ext.getCmp("gdsybl").setValue(Ext.getCmp("gdgmbl").getValue());
	 	Ext.getCmp("gdzjbl").setValue(Ext.getCmp("gdgmbl").getValue());
	 });
form3.render("deal");
  form3.hide();
})

 function dealGdtl(xmmc,nd,jd){
 	this.nd=nd;
 	this.jd=jd;
 	 form3.show();
 	 form2.hide();
 	 //form3.render("deal");
 	 putClientCommond("planManager","getXm");
     putRestParameter("xmmc",escape(escape(xmmc)));
   	 var info = restRequest();
   	 	  Ext.getCmp("gdxmmc").setValue(xmmc);
	  	  Ext.getCmp("gdnd").setValue(nd);
	  	  Ext.getCmp("gdjd").setValue(jd);
	  	  
	 if(info[0]!=null){
		  Ext.getCmp("gdxmdl").setValue(info[0].ZD);
		  Ext.getCmp("gdxmgm").setValue(info[0].JZGM);
		  Ext.getCmp("gdlmcb").setValue(info[0].LMCB/10000);
		  Ext.getCmp("gdzujin").setValue(info[0].ZJ); 
		  Ext.getCmp("gdxmzujin").setValue(info[0].ZJ); 
		  Ext.getCmp("gdxmsy").setValue(info[0].LMCJJ);
		  Ext.getCmp("gdfwsj").setValue(info[0].FWSJ); 
		  
		  Ext.getCmp("gdzj").setValue(info[0].FWSJ); 
	 }
	  putClientCommond("planManager","queryGdtl");
      putRestParameter("xmmc",escape(escape(xmmc)));
	  putRestParameter("nd",nd);
	  putRestParameter("jd",jd);
	  var sinData= restRequest();
	  if(sinData[0]!=null){
	  		   form3.form.url=restUrl+'planManager/updateGdtl?year='+nd+'&jd='+jd;
	  		    Ext.getCmp("btngd").setText("修改供地体量");
			    Ext.getCmp("gddl").setValue(sinData[0].DL);
			    Ext.getCmp("gddlbl").setValue(sinData[0].DLZ);
			    Ext.getCmp("gdgm").setValue(sinData[0].GM);
			    Ext.getCmp("gdgmbl").setValue(sinData[0].GMZ);
			    Ext.getCmp("gdcb").setValue(sinData[0].CB);
			    Ext.getCmp("gdcbbl").setValue(sinData[0].CBZ);
			    Ext.getCmp("gdsybl").setValue(sinData[0].SYZ);
			    Ext.getCmp("gdzjbl").setValue(sinData[0].ZJZ);
	  }else{
			    Ext.getCmp("gddl").reset();
			    Ext.getCmp("gddlbl").reset();
			    Ext.getCmp("gdgm").reset();
			    Ext.getCmp("gdgmbl").reset();
			    Ext.getCmp("gdcb").reset();
			    Ext.getCmp("gdcbbl").reset();
			    Ext.getCmp("gdsybl").reset();
			    Ext.getCmp("gdzjbl").reset();
	        form3.form.url=restUrl+'planManager/addGdtl';
	         Ext.getCmp("btngd").setText("新增供地体量");
	  }
 }

 function dealKftl(xmmc,nd,jd){
 	// form3.render("deal");
 	this.nd=nd;
 	this.jd=jd;
 	 form2.show();
 	 form3.hide();
 	 putClientCommond("planManager","getXm");
     putRestParameter("xmmc",escape(escape(xmmc)));
   	 var info = restRequest();
   	 	  Ext.getCmp("xmmc").setValue(xmmc);
	  	  Ext.getCmp("nd").setValue(nd);
	  	  Ext.getCmp("jd").setValue(jd);
	 if(info[0]!=null){
	   	  Ext.getCmp("xmhs").setValue(info[0].ZZZSHS);
	  	  Ext.getCmp("xmdl").setValue(info[0].ZD);
	  	  Ext.getCmp("xmgm").setValue(info[0].JZGM);
	  	  Ext.getCmp("xmtz").setValue(info[0].CQHBTZ);
	  	  Ext.getCmp("xmz").setValue(info[0].ZZHBTZCB);
	  	  Ext.getCmp("xmq").setValue(info[0].QYCQFY);	  
	  	  Ext.getCmp("lm").setValue(info[0].LMCB/10000);
	  	  Ext.getCmp("cj").setValue(info[0].LMCJJ);
	 }
	  putClientCommond("planManager","queryKftl");
      putRestParameter("xmmc",escape(escape(xmmc)));
	  putRestParameter("nd",nd);
	  putRestParameter("jd",jd);
	  var sinData= restRequest();
	  if(sinData[0]!=null){
	  		   form2.form.url=restUrl+'planManager/updateKftl?year='+nd+'&jd='+jd;
	  		    Ext.getCmp("btnkf").setText("修改开发体量");
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
			    Ext.getCmp("lm").setValue(sinData[0].LM/10000);
			    Ext.getCmp("cj").setValue(sinData[0].CJ);
	  }else{
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
	        form2.form.url=restUrl+'planManager/addKftl';
	         Ext.getCmp("btnkf").setText("增加开发体量");
	  }
 }
