

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
			putClientCommond("jbbHandle","getZZZSBZXS");
			var list = restRequest();
			var bcf = list[0].BCF;
			var bzf = list[0].BZF;
			var fzzbcbz = list[0].ZZZSBZ;
			
			var jzgm = Ext.getCmp("jzgm").getValue()*1;
			var zzzsgm = Ext.getCmp("zzzsgm").getValue()*1;
			var hjmj = Ext.getCmp("hjmj").getValue()*1;
			var fzzzsgm = Ext.getCmp("fzzzsgm").getValue()*1;
			if(zzzsgm!="" && zzzsgm != "0"){
				var a = (zzzsgm*(hjmj*bcf+parseInt(bzf)))/hjmj;
				var b = fzzzsgm*fzzbcbz;
				var c = (a + b)*1.12 + jzgm*480/10000;
				Ext.getCmp("kfcb").setValue(((c +  c *0.0665*2 )*1.03).toFixed(0));
			}else {
				Ext.getCmp("kfcb").setValue((((fzzzsgm*fzzbcbz*1.12+jzgm*480/10000)+((fzzzsgm*fzzbcbz)*1.12+jzgm*480/10000)*0.0665*2)*1.03).toFixed(0));
			}
			var kfcb = Ext.getCmp("kfcb").getValue();
			var yjcjj = Ext.getCmp("yjcjj").getValue();
			var jzgm = Ext.getCmp("jzgm").getValue();
			var jsyd = Ext.getCmp("jsyd").getValue();
			Ext.getCmp("lmcb").setValue((kfcb*1/jzgm*10000).toFixed(2));
			Ext.getCmp("dmcb").setValue((kfcb*1/jsyd*10000).toFixed(2));
			Ext.getCmp("cbfgl").setValue((jzgm*2.4/kfcb*100).toFixed(0)+"%");	
			Ext.getCmp("yjzftdsy").setValue(((yjcjj*jzgm/10000-kfcb)).toFixed(0));
			
			var yjzftdsy = Ext.getCmp("yjzftdsy").getValue();
			Ext.getCmp("cxb").setValue((yjzftdsy/(yjcjj*jzgm/10000)*100).toFixed(2)+"%");
			
			if(Ext.getCmp("jsyd").getValue()!=""){
				Ext.getCmp("rjl").setValue((Ext.getCmp("jzgm").getValue()/Ext.getCmp("jsyd").getValue()).toFixed(1));
			}else{
				Ext.getCmp("rjl").setValue("0");
			}
		});
		Ext.getCmp("jzjzgm").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("gjjzgm").getValue();
			var jzjzgm = Ext.getCmp("jzjzgm").getValue();
			var szjzgm = Ext.getCmp("szjzgm").getValue();
			Ext.getCmp("jzgm").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
			putClientCommond("jbbHandle","getZZZSBZXS");
			var list = restRequest();
			var bcf = list[0].BCF;
			var bzf = list[0].BZF;
			var fzzbcbz = list[0].ZZZSBZ;
			
			var jzgm = Ext.getCmp("jzgm").getValue()*1;
			var zzzsgm = Ext.getCmp("zzzsgm").getValue()*1;
			var hjmj = Ext.getCmp("hjmj").getValue()*1;
			var fzzzsgm = Ext.getCmp("fzzzsgm").getValue()*1;
			if(zzzsgm!="" && zzzsgm != "0"){
				var a = (zzzsgm*(hjmj*bcf+parseInt(bzf)))/hjmj;
				var b = fzzzsgm*fzzbcbz;
				var c = (a + b)*1.12 + jzgm*480/10000;
				Ext.getCmp("kfcb").setValue(((c +  c *0.0665*2 )*1.03).toFixed(0));
			}else {
				Ext.getCmp("kfcb").setValue((((fzzzsgm*fzzbcbz*1.12+jzgm*480/10000)+((fzzzsgm*fzzbcbz)*1.12+jzgm*480/10000)*0.0665*2)*1.03).toFixed(0));
			}
			var kfcb = Ext.getCmp("kfcb").getValue();
			var yjcjj = Ext.getCmp("yjcjj").getValue();
			var jzgm = Ext.getCmp("jzgm").getValue();
			var jsyd = Ext.getCmp("jsyd").getValue();
			Ext.getCmp("lmcb").setValue((kfcb*1/jzgm*10000).toFixed(2));
			Ext.getCmp("dmcb").setValue((kfcb*1/jsyd*10000).toFixed(2));
			Ext.getCmp("cbfgl").setValue((jzgm*2.4/kfcb*100).toFixed(0)+"%");	
			Ext.getCmp("yjzftdsy").setValue(((yjcjj*jzgm/10000-kfcb)).toFixed(0));
			
			var yjzftdsy = Ext.getCmp("yjzftdsy").getValue();
			Ext.getCmp("cxb").setValue((yjzftdsy/(yjcjj*jzgm/10000)*100).toFixed(2)+"%");
			if(Ext.getCmp("jsyd").getValue()!=""){
				Ext.getCmp("rjl").setValue(Ext.getCmp("jzgm").getValue()/Ext.getCmp("jsyd").getValue());
			}else{
				Ext.getCmp("rjl").setValue("0");
			}
		});
		Ext.getCmp("szjzgm").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var gjjzgm = Ext.getCmp("gjjzgm").getValue();
			var jzjzgm = Ext.getCmp("jzjzgm").getValue();
			var szjzgm = Ext.getCmp("szjzgm").getValue();
			Ext.getCmp("jzgm").setValue(gjjzgm*1+jzjzgm*1+szjzgm*1);
			putClientCommond("jbbHandle","getZZZSBZXS");
			var list = restRequest();
			var bcf = list[0].BCF;
			var bzf = list[0].BZF;
			var fzzbcbz = list[0].ZZZSBZ;
			
			var jzgm = Ext.getCmp("jzgm").getValue()*1;
			var zzzsgm = Ext.getCmp("zzzsgm").getValue()*1;
			var hjmj = Ext.getCmp("hjmj").getValue()*1;
			var fzzzsgm = Ext.getCmp("fzzzsgm").getValue()*1;
			if(zzzsgm!="" && zzzsgm != "0"){
				var a = (zzzsgm*(hjmj*bcf+parseInt(bzf)))/hjmj;
				var b = fzzzsgm*fzzbcbz;
				var c = (a + b)*1.12 + jzgm*480/10000;
				Ext.getCmp("kfcb").setValue(((c +  c *0.0665*2 )*1.03).toFixed(0));
			}else {
				Ext.getCmp("kfcb").setValue((((fzzzsgm*fzzbcbz*1.12+jzgm*480/10000)+((fzzzsgm*fzzbcbz)*1.12+jzgm*480/10000)*0.0665*2)*1.03).toFixed(0));
			}
			var kfcb = Ext.getCmp("kfcb").getValue();
			var yjcjj = Ext.getCmp("yjcjj").getValue();
			var jzgm = Ext.getCmp("jzgm").getValue();
			var jsyd = Ext.getCmp("jsyd").getValue();
			Ext.getCmp("lmcb").setValue((kfcb*1/jzgm*10000).toFixed(2));
			Ext.getCmp("dmcb").setValue((kfcb*1/jsyd*10000).toFixed(2));
			Ext.getCmp("cbfgl").setValue((jzgm*2.4/kfcb*100).toFixed(0)+"%");	
			Ext.getCmp("yjzftdsy").setValue(((yjcjj*jzgm/10000-kfcb)).toFixed(0));
			
			var yjzftdsy = Ext.getCmp("yjzftdsy").getValue();
			Ext.getCmp("cxb").setValue((yjzftdsy/(yjcjj*jzgm/10000)*100).toFixed(2)+"%");
			if(Ext.getCmp("jsyd").getValue()!=""){
				Ext.getCmp("rjl").setValue(Ext.getCmp("jzgm").getValue()/Ext.getCmp("jsyd").getValue());
			}else{
				Ext.getCmp("rjl").setValue("0");
			}
		});
		Ext.getCmp("zd").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var zd = Ext.getCmp("zd").getValue();
			var zzsgm = Ext.getCmp("zzsgm").getValue();
			Ext.getCmp("cqqd").setValue((zzsgm*1/zd*1).toFixed(1));
		});
		Ext.getCmp("kfcb").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var kfcb = Ext.getCmp("kfcb").getValue();
			var jzgm = Ext.getCmp("jzgm").getValue();
			var jsyd = Ext.getCmp("jsyd").getValue();
			var yjcjj = Ext.getCmp("yjcjj").getValue();
			Ext.getCmp("lmcb").setValue((kfcb*1/jzgm*10000).toFixed(2));
			Ext.getCmp("dmcb").setValue((kfcb*1/jsyd*10000).toFixed(2));
			Ext.getCmp("yjzftdsy").setValue((yjcjj*jzgm/10000-kfcb));
			Ext.getCmp("cbfgl").setValue((jzgm/kfcb).toFixed(2));	
		});
		
		Ext.getCmp("yjcjj").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var kfcb = Ext.getCmp("kfcb").getValue();
			var jzgm = Ext.getCmp("jzgm").getValue();
			var yjcjj = Ext.getCmp("yjcjj").getValue();
			Ext.getCmp("yjzftdsy").setValue((yjcjj*jzgm/10000-kfcb));
			
			var yjzftdsy = Ext.getCmp("yjzftdsy").getValue();
			Ext.getCmp("cxb").setValue(yjzftdsy/(yjcjj*jzgm/10000).toFixed(2));
		});
		Ext.getCmp("yjzftdsy").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var yjzftdsy = Ext.getCmp("yjzftdsy").getValue();
			var jzgm = Ext.getCmp("jzgm").getValue();
			var yjcjj = Ext.getCmp("yjcjj").getValue();
			Ext.getCmp("cxb").setValue(yjzftdsy/(yjcjj*jzgm/10000).toFixed(2));
		});
		
		Ext.getCmp("jsyd").addListener('change',function(){
			//判断自然斑编号是否符合条件
			var kfcb = Ext.getCmp("kfcb").getValue();
			var jsyd = Ext.getCmp("jzgm").getValue();
			Ext.getCmp("dmcb").setValue((kfcb*1/jsyd*1).toFixed(2));
			Ext.getCmp("rjl").setValue(Ext.getCmp("jzgm").getValue()/Ext.getCmp("jsyd").getValue());
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