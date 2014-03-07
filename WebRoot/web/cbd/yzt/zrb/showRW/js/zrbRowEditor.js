var zrbbh = "";
var num = 0;
var table = new tableoper();
//zrbTable.init(document.getElementById("ZRB"));



//单击地图定位
function showMap(objid){
	if(table.element == undefined){
		table.init(document.getElementById("ZRB"));
	}
	var key = objid.cells[1].innerText;
	//parent.parent.frames['east'].swfobject.getObjectById("FxGIS").clear();
	//parent.parent.frames['east'].swfobject.getObjectById("FxGIS").findFeature("cbd", "0", key, "ZRBBH");
	//parent.parent.dhxLayout.cells("a").getFrame().contentWindow.document.swfobject.getObjectById("FxGIS").clear();
	//parent.parent.dhxLayout.cells("a").getFrame().contentWindow.document.swfobject.getObjectById("FxGIS").findFeature("cbd", "0", key, "ZRBBH");
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").findFeature("cbd", "3", key, "ZRBBH");

	//添加选中保存
	//var num = objid.rowIndex();
	table.addAnnotation(objid.rowIndex);
}

//双击编辑地图
function editMap(objid){
	//没有编辑权限时，直接回退。
	if(view == "R"){
		return;
	}
	if(table.element == undefined){
		table.init(document.getElementById("ZRB"));
	}
	 zrbbh = objid.cells[1].innerText;
	//form.show();
	
	//parent.parent.frames['east'].swfobject.getObjectById("FxGIS").clear();
	//parent.parent.frames['east'].swfobject.getObjectById("FxGIS").drawPolygon();
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").drawPolygon();
}

//导出Excel
function print(){
    var curTbl = document.getElementById("ZRB"); 
    try{
    	var oXL = new ActiveXObject("Excel.Application");
    }catch(err){
    	Ext.Msg.alert('提示','Excel生成失败，请先确定系统已安装office，并在浏览器的\'工具\' - Internet选项 -安全 - 自定义级别 - ActiveX控件和插件 - 对未标记为可安全执行脚本的ActiveX控件.. 标记为\'启用\'');
    	return;
    } 
    //创建AX对象excel 
    var oWB = oXL.Workbooks.Add(); 
    //获取workbook对象 
        var oSheet = oWB.ActiveSheet; 
    //激活当前sheet 
    var sel = document.body.createTextRange(); 
    sel.moveToElementText(curTbl); 
    //把表格中的内容移到TextRange中 
    sel.select(); 
    //全选TextRange中内容 
    sel.execCommand("Copy"); 
    //复制TextRange中内容  
    oSheet.Paste(); 
    //粘贴到活动的EXCEL中       
    oXL.Visible = true; 
    //设置excel可见属性 
}

//上图
function setRecord(polygon){
	putClientCommond("zrbHandle","drawZrb");
    putRestParameter("tbbh",escape(escape(zrbbh))); 
    putRestParameter("polygon",polygon); 
    var result = restRequest();
	//parent.parent.frames['east'].swfobject.getObjectById("FxGIS").clear();
	//parent.parent.frames['east'].swfobject.getObjectById("FxGIS").findFeature("cbd", "0", zrbbh, "ZRBBH");
    parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").findFeature("cbd", "3", zrbbh, "ZRBBH");
}

function add(){
	if(table.element == undefined){
		table.init(document.getElementById("ZRB"));
	}
//	Ext.MessageBox.prompt('输入', '请输入自然斑编号(“基本斑编号-自然斑编号“):', function(btn, text){
//		if(btn == 'ok'){
//			//判断自然斑编号是否符合条件
//			var reg = /^\w+-\w+/;
//			if(!reg.test(text)){
//				Ext.MessageBox.alert('提醒', '自然斑编号不规范，正确的自然斑编号应该是“基本斑编号-自然斑编号“，请重新输入', function(btn, text){
//					add();
//				});
//				return;	
//			}
//			var rows = table.addRow(2,3,num);
//			num++;
//			rows.cells[1].innerHTML = text;
//			//向后台库中添加一笔数据
//			putClientCommond("zrbHandle","insertZrb");
//	    	putRestParameter("ZRBBH",escape(escape(text))); 
//	    	var result = restRequest();
//    	}
//	});
	paneloper.show();
}

function modify(){
	var annoations = table.getAnnotations();
	if(annoations.length > 0){
		var objid = table.element.rows[annoations[0]];
		if(table.element == undefined){
			table.init(document.getElementById("ZRB"));
		}
		var key = objid.cells[1].innerText;
		zrbbh = key;
		
		//编辑基本属性
		var array = paneloper.getElements();
		for(var i = 0; i < array.length; i++){
			var value = objid.cells[i+1].innerText;
			paneloper.insertValue(array[i], value);
		}
		paneloper.show();	
	}
}

function dele(){
	Ext.MessageBox.confirm('确认', '系统将删除所有选中自然斑，确定?', function(btn,text){
		if(btn == 'yes'){
			var choseValue = table.getAnnotations();
			var choseString = '';
			while(choseValue.length != 0){
				choseString += table.getValue(choseValue.pop(),"1") + ",";
			}
			putClientCommond("zrbHandle","delete");
			putRestParameter("zrbbh",choseString);
			myData = restRequest();
			if(myData){
				Ext.MessageBox.alert('提醒', '删除成功！', function(btn, text){
					document.location.reload();
					return;
				});
			}else{
				Ext.MessageBox.alert('提醒', '删除失败，请联系管理员或重试', function(btn, text){
					return;
				});
			}
			
		}
	});
}

//根据用地单位和关键字作过滤
function queryZrb(keyword){
	putClientCommond("zrbHandle","getReport");
	putRestParameter("keyword",escape(escape(keyword)));
	myData = restRequest();
  	document.getElementById("show").innerHTML = myData;
  	
  	var width = document.body.clientWidth;
	var height = document.body.clientHeight * 0.82;
    FixTable("ZRB", 1,2, width, height);
}


