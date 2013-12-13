//record对象
Record = function(){
	var myRecordType;
	var myRecordValue;
	var ZRBBH;
	var store;
}
Record.prototype = {
	build:function(){
		this.myRecordType = Ext.data.Record.create(
			{name: 'YW_GUID'},
           	{name: 'ZRBBH'},
           	{name: 'ZDMJ'},
           	{name: 'LZMJ'},
           	{name: 'CQGM'},
           	{name: 'ZZLZMJ'},
           	{name: 'ZZCQGM'},
           	{name: 'YJHS'},
           	{name: 'FZZLZMJ'},
           	{name: 'FZZCQGM'},
           	{name: 'BZ'});
	},
	create:function(){
		//确定自然斑编号
		Ext.MessageBox.prompt('输入', '请输入自然斑编号:', function(btn, text){
			addZRB(text);
		});
	},
	add:function(store,text){
		this.myRecordValue = new this.myRecordType(
			{
				YW_GUID:'0',
				ZRBBH:'',
				ZDMJ:'',
				LZMJ:'',
				CQGM:'',
				ZZLZMJ:'',
				ZZCQGM:'',
				YJHS:'',
				FZZLZMJ:'',
				FZZCQGM:'',
				BZ:''
			}		
		);
		this.myRecordValue.data.ZRBBH = text;
		/*
		store.load({
			scope:this,
			add:true
		});
		*/
		if(this.myRecordValue != undefined){
			store.insert(0,this.myRecordValue);
			//store.add(this.myRecordValue);	
		}else{
			Ext.MessageBox.alert('提醒','添加数据出错，请联系管理员');
		}
		return store;
		//addZRB(store);
	}
	
}
