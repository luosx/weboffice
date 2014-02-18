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
		Ext.getCmp("JSYDJZ").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("JSYDJZ").getValue();
			var jzjzgm = Ext.getCmp("JSYDSF").getValue();
			var szjzgm = Ext.getCmp("JSYDQT").getValue();
			Ext.getCmp("JSYDXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		Ext.getCmp("JSYDSF").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("JSYDJZ").getValue();
			var jzjzgm = Ext.getCmp("JSYDSF").getValue();
			var szjzgm = Ext.getCmp("JSYDQT").getValue();
			Ext.getCmp("JSYDXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		Ext.getCmp("JSYDQT").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("JSYDJZ").getValue();
			var jzjzgm = Ext.getCmp("JSYDSF").getValue();
			var szjzgm = Ext.getCmp("JSYDQT").getValue();
			Ext.getCmp("JSYDXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		
		Ext.getCmp("GHJZJZ").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("GHJZJZ").getValue();
			var jzjzgm = Ext.getCmp("GHJZSF").getValue();
			var szjzgm = Ext.getCmp("GHJZQT").getValue();
			Ext.getCmp("GHJZXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		Ext.getCmp("GHJZSF").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("GHJZJZ").getValue();
			var jzjzgm = Ext.getCmp("GHJZSF").getValue();
			var szjzgm = Ext.getCmp("GHJZQT").getValue();
			Ext.getCmp("GHJZXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		Ext.getCmp("GHJZQT").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("GHJZJZ").getValue();
			var jzjzgm = Ext.getCmp("GHJZSF").getValue();
			var szjzgm = Ext.getCmp("GHJZQT").getValue();
			Ext.getCmp("GHJZXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		
		
		Ext.getCmp("YTZSZX").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("YTZSZX").getValue();
			var jzjzgm = Ext.getCmp("YTZFZX").getValue();
			var szjzgm = Ext.getCmp("YTZQY").getValue();
			Ext.getCmp("YTZXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		Ext.getCmp("YTZFZX").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("YTZSZX").getValue();
			var jzjzgm = Ext.getCmp("YTZFZX").getValue();
			var szjzgm = Ext.getCmp("YTZQY").getValue();
			Ext.getCmp("YTZXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		Ext.getCmp("YTZQY").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("YTZSZX").getValue();
			var jzjzgm = Ext.getCmp("YTZFZX").getValue();
			var szjzgm = Ext.getCmp("YTZQY").getValue();
			Ext.getCmp("YTZXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		
		Ext.getCmp("JHZCB").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("JHZCB").getValue();
			var jzjzgm = Ext.getCmp("JHSZX").getValue();
			var szjzgm = Ext.getCmp("JHFZX").getValue();
			var jhqy = Ext.getCmp("JHQY").getValue();
			Ext.getCmp("JHXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1+jhqy*1);
		});
		Ext.getCmp("JHSZX").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("JHZCB").getValue();
			var jzjzgm = Ext.getCmp("JHSZX").getValue();
			var szjzgm = Ext.getCmp("JHFZX").getValue();
			var jhqy = Ext.getCmp("JHQY").getValue();
			Ext.getCmp("JHXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1+jhqy*1);
		});
		Ext.getCmp("JHFZX").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("JHZCB").getValue();
			var jzjzgm = Ext.getCmp("JHSZX").getValue();
			var szjzgm = Ext.getCmp("JHFZX").getValue();
			var jhqy = Ext.getCmp("JHQY").getValue();
			Ext.getCmp("JHXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1+jhqy*1);
		});
		Ext.getCmp("JHQY").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("JHZCB").getValue();
			var jzjzgm = Ext.getCmp("JHSZX").getValue();
			var szjzgm = Ext.getCmp("JHFZX").getValue();
			var jhqy = Ext.getCmp("JHQY").getValue();
			Ext.getCmp("JHXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1+jhqy*1);
		});
		
		
		
		
		Ext.getCmp("ZJHLSZX").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("ZJHLSZX").getValue();
			var jzjzgm = Ext.getCmp("ZJHLFZX").getValue();
			var szjzgm = Ext.getCmp("ZJHLQY").getValue();
			Ext.getCmp("ZJHLXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		Ext.getCmp("ZJHLFZX").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("ZJHLSZX").getValue();
			var jzjzgm = Ext.getCmp("ZJHLFZX").getValue();
			var szjzgm = Ext.getCmp("ZJHLQY").getValue();
			Ext.getCmp("ZJHLXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		Ext.getCmp("ZJHLQY").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("ZJHLSZX").getValue();
			var jzjzgm = Ext.getCmp("ZJHLFZX").getValue();
			var szjzgm = Ext.getCmp("ZJHLQY").getValue();
			Ext.getCmp("ZJHLXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		
		
		Ext.getCmp("GHYDJZ").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("GHYDJZ").getValue();
			var jzjzgm = Ext.getCmp("GHYDSF").getValue();
			var szjzgm = Ext.getCmp("GHYDQT").getValue();
			Ext.getCmp("GHYDXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		Ext.getCmp("GHYDSF").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("GHYDJZ").getValue();
			var jzjzgm = Ext.getCmp("GHYDSF").getValue();
			var szjzgm = Ext.getCmp("GHYDQT").getValue();
			Ext.getCmp("GHYDXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		Ext.getCmp("GHYDQT").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("GHYDJZ").getValue();
			var jzjzgm = Ext.getCmp("GHYDSF").getValue();
			var szjzgm = Ext.getCmp("GHYDQT").getValue();
			Ext.getCmp("GHYDXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		
		Ext.getCmp("WCGHJZJZ").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("WCGHJZJZ").getValue();
			var jzjzgm = Ext.getCmp("WCGHJZSF").getValue();
			var szjzgm = Ext.getCmp("WCGHJZQT").getValue();
			Ext.getCmp("WCGHJZXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		Ext.getCmp("WCGHJZSF").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("WCGHJZJZ").getValue();
			var jzjzgm = Ext.getCmp("WCGHJZSF").getValue();
			var szjzgm = Ext.getCmp("WCGHJZQT").getValue();
			Ext.getCmp("WCGHJZXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		Ext.getCmp("WCGHJZQT").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("WCGHJZJZ").getValue();
			var jzjzgm = Ext.getCmp("WCGHJZSF").getValue();
			var szjzgm = Ext.getCmp("WCGHJZQT").getValue();
			Ext.getCmp("WCGHJZXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		
		Ext.getCmp("GHYDMJJZ").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("GHYDMJJZ").getValue();
			var jzjzgm = Ext.getCmp("GHYDMJSF").getValue();
			var szjzgm = Ext.getCmp("GHYDMJQT").getValue();
			Ext.getCmp("GHYDMJXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		Ext.getCmp("GHYDMJSF").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("GHYDMJJZ").getValue();
			var jzjzgm = Ext.getCmp("GHYDMJSF").getValue();
			var szjzgm = Ext.getCmp("GHYDMJQT").getValue();
			Ext.getCmp("GHYDMJXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		Ext.getCmp("GHYDMJQT").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("GHYDMJJZ").getValue();
			var jzjzgm = Ext.getCmp("GHYDMJSF").getValue();
			var szjzgm = Ext.getCmp("GHYDMJQT").getValue();
			Ext.getCmp("GHYDMJXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		
		Ext.getCmp("GHJZGMJZ").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("GHJZGMJZ").getValue();
			var jzjzgm = Ext.getCmp("GHJZGMSF").getValue();
			var szjzgm = Ext.getCmp("GHJZGMQT").getValue();
			Ext.getCmp("GHJZGMXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		Ext.getCmp("GHJZGMSF").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("GHJZGMJZ").getValue();
			var jzjzgm = Ext.getCmp("GHJZGMSF").getValue();
			var szjzgm = Ext.getCmp("GHJZGMQT").getValue();
			Ext.getCmp("GHJZGMXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
		});
		Ext.getCmp("GHJZGMQT").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("GHJZGMJZ").getValue();
			var jzjzgm = Ext.getCmp("GHJZGMSF").getValue();
			var szjzgm = Ext.getCmp("GHJZGMQT").getValue();
			Ext.getCmp("GHJZGMXJ").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
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