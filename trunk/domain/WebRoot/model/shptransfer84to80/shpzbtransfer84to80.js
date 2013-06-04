var d = new Date();
var years = d.getYear();
var month = add_zero(d.getMonth()+1);
var days = add_zero(d.getDate());
var hours = add_zero(d.getHours());
var minutes = add_zero(d.getMinutes());
var seconds=add_zero(d.getSeconds());

function add_zero(temp){
 	if(temp<10) return "0"+temp;
 	else return temp;
}
var currentTime = years+month+days+hours+minutes+seconds;

Ext.onReady(function(){
	var type = "";
	var store=new parent.Ext.data.JsonStore({
		fields:["name","value"],
		data:[
			{name:'84大地坐标-->西安80大地坐标',value:'84bl_80bl'},
			{name:'84大地坐标-->西安80平面坐标',value:'84bl_80plant'},
			{name:'84大地坐标-->为百度地图坐标',value:'84bl_baidu'},
			{name:'84大地坐标-->谷歌地图坐标',value:'84bl_google'},
			{name:'西安80大地坐标-->西安80平面坐标',value:'80bl_80plant'},
			{name:'西安80平面坐标-->西安80大地坐标',value:'80plant_80bl'},
			{name:'84GPS模块输出坐标-->84大地坐标',value:'84gps_84bl'},
			{name:'84GPS模块输出坐标-->西安80大地坐标',value:'84gps_80bl'},
			{name:'84GPS模块输出坐标-->西安80平面坐标',value:'84gps_80plant'},
			{name:'格网法坐标转换',value:'grid'}			
		]
	});    
										
	var combo=new Ext.form.ComboBox({
		emptyText:"==请选择转换类型==",
		//fieldLabel:"类型",
		id:'type',
		width:220,
		bodyStyle: 'padding: 0px 0px 10 15px;',
		store:store,
		displayField:"name",
		valueField:"value",
		editable:false,
		mode:"local",
		triggerAction:"all",
		listeners:{
			'select':function(combo,record,index){
				type = Ext.getCmp("type").getValue();
				Ext.getCmp("change").disable().enable();
			}
		}
  	});   
	
	
	var fp = new Ext.form.FormPanel({
        renderTo: 'form-ct',
        fileUpload: true,
        id:'aa',
        autoWidth: 550,
        autoHeight: true,
        border : false,
		bodyStyle: 'padding: 10px 0px 0 10px;',
        labelWidth: 10,
		items: [{
            layout:'column',
            items: [{
		            xtype: 'fileuploadfield',
		            id: 'form-file',
		            emptyText: '请选择包含需要转换shp文件的zip包',
		            name: 'shape-path',
		            buttonText: '浏览',            
					width:350
        		},{
	                width:230,
	                border : false,
	                bodyStyle: 'padding: 0px 0px 0px 10px',
	                items:[combo]
            }]
		}],
        buttons: [{
            text: '转换',
            id:'change',
            disabled:true,
            handler: function(){
            	var fileType = Ext.getCmp("form-file").getValue().substring(Ext.getCmp("form-file").getValue().lastIndexOf(".")+1);  
                if(fp.getForm().isValid()){
                	if(fileType == "zip"){
		                fp.getForm().submit({
		                	url:"http://" + window.location.href.split("/")[2] + "/reduce/service/rest/coord/shpZIP?currentTime="+currentTime+"&type="+type,
        					method:'POST', 
							waitTitle:'提示',
		                    waitMsg: '正在转换,请稍后...',
		                    success: function(form,action){
		                    	path = unescape(action.result.msg);
		                    	if(path.indexOf(currentTime)>=0){
		                    		Ext.Msg.alert('提示', 'shp文件坐标转换成功！');
		                    		Ext.getCmp("download").disable().enable();
		                    	}else{
		                    		Ext.Msg.alert('提示', path);
		                    		Ext.getCmp("download").disable().enable();
		                    	}
		                    },
	                        failure:function(){
								Ext.Msg.alert('提示', 'shp文件坐标转换失败！');	
	                        }
		                });
                	}else{
                		Ext.Msg.alert('提示', '请选择zip文件！');	
                	}
                }
            }
        },{
            text: '下载',
            id:'download', 
            disabled:true,
            handler: function(){
          	    window.open("expTask.jsp?filePath="+path);
            }        
        }]
    });
});
