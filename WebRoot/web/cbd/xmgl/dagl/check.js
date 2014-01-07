Ext.onReady(function(){
		Ext.QuickTips.init();
    	var leftDs = new Ext.data.ArrayStore({
	       data: '',
	       fields: ['value','text']
	   	}); 
    	
 		var rightDs = new Ext.data.ArrayStore({ 
	       fields: ['value','text'],
	       sortInfo: {
	           field: 'value',
	           direction: 'ASC'
	       }
	  	});
 		
 		winForm = new Ext.form.FormPanel({
	   		bodyStyle: 'padding:10px;',
     		width:500,
        	items:[{
	          	xtype: 'itemselector',
	            name: 'itemselector',
	            imagePath: '<%=extPath%>examples/ux/images/',
	            fieldLabel: '附件列表',
	            multiselects:[
	         		{
	                  width: 180,
	                  height: 245,
	                  store: leftDs,
	                  displayField: 'text',
	                  valueField: 'value'
	           		},{
	           		  width: 180,
		              height: 245,
		              store: rightDs,
		              displayField: 'text',
	                  valueField: 'value',	
	                  tbar:[{
	                  		text: '清空已选列表',
	                  		handler:function(){
	                  			winForm.getForm().findField('itemselector').reset();
	                  		}
				      }]
			     	}	
            	]
         }],
       		buttons: [{
       		text: '保存',
       		handler: function(){
       			if(winForm.getForm().isValid()){
       				var itemselector = winForm.form.findField('itemselector').getValue();
       				//将选择的基本地块数据保存到数据库
       				if(obj_id != undefined){
						var form=document.getElementById("reportppt");
						form.submit();
       				}
       				win.hide();
       			}
       		}
       	},{
		        text: '取消',
       		handler: function(){
				win.hide();
       		}
       	}]
	});
 		
   		win = new Ext.Window({
		    layout: 'fit',
		    title: '请选择PPT所用图层',
		    closeAction: 'hide',
		    width:550,
		    height:380,
		    x: 100,
		    y: 110,
		    items:winForm
		});
})
  
  