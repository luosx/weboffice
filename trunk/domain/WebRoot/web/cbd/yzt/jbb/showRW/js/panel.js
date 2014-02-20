var Paneloper = function(){
	var object;
	var elements = new Array();
}

Paneloper.prototype = {
	init:function(object, element){
		this.object = object;
		this.elements = element;
		this.monitor();
	},
	monitor:function(){
		//录入自然斑编号时添加验证
		var obj = this;
		Ext.getCmp("gjjzgm").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("gjjzgm").getValue();
			var jzjzgm = Ext.getCmp("jzjzgm").getValue();
			var szjzgm = Ext.getCmp("szjzgm").getValue();
			Ext.getCmp("jzgm").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		Ext.getCmp("jzjzgm").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("gjjzgm").getValue();
			var jzjzgm = Ext.getCmp("jzjzgm").getValue();
			var szjzgm = Ext.getCmp("szjzgm").getValue();
			Ext.getCmp("jzgm").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		Ext.getCmp("szjzgm").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("gjjzgm").getValue();
			var jzjzgm = Ext.getCmp("jzjzgm").getValue();
			var szjzgm = Ext.getCmp("szjzgm").getValue();
			Ext.getCmp("jzgm").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		Ext.getCmp("zd").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var zd = Ext.getCmp("zd").getValue();
			var zzsgm = Ext.getCmp("zzsgm").getValue();
			Ext.getCmp("cqqd").setValue((zd*1/zzsgm*1).toFixed(2));
		});
	},
	insertValue:function(name, value){
		var extObject = Ext.getCmp(name);
		if(undefined == extObject){
			Ext.MessageBox.alert('提醒', name + '不存在', function(btn){});
		}else{
			extObject.setValue(value);
		}
	},
	removeValue:function(name){
		this.insertValue(name,"");
	},
	addElement:function(){
		
	},
	removeElement:function(){
		
	},
	clear:function(){
		for(var i = 0; i < this.elements.length; i++){
			this.insertValue(this.elements[i],"");
		}
	},
	show:function(){
		this.object.show();
	},
	hide:function(){
		this.object.hide();
	},
	save:function(){
		var obj = this;
		this.object.form.submit({
			waitMsg:'正在保存，请稍后...',
			success:function(){
			 	Ext.Msg.alert('提示','保存成功。',function(){
			 		obj.clear();
			 		obj.hide();
			 		document.location.reload();
			 	});
			},
			failure:function(){
				Ext.Msg.alert('提示','保存失败，请稍后重试或联系管理员。');
			}
		});
	},
	cancel:function(){
		this.clear();
		this.hide();
	},
	getElements:function(){
		return this.elements;
	},
	getObjects:function(){
		return this.object;
	},
	setRestUrl:function(url){
		this.object.form.url=restUrl + url;
	}
	
}