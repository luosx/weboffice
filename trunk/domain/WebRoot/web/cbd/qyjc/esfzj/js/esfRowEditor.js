var xqmc = "";
var num = 0;
var table = new tableoper();
//zrbTable.init(document.getElementById("ZRB"));

//单击地图定位
function showMap(objid){
	if(table.element == undefined){
		table.init(document.getElementById("ESFQK"));
	}
	//alert("showMap");
	var key = objid.cells[1].innerText;
	//parent.parent.frames['east'].swfobject.getObjectById("FxGIS").clear();
	//parent.parent.frames['east'].swfobject.getObjectById("FxGIS").findFeature("cbd", "0", key, "ZRBBH");
	//parent.parent.dhxLayout.cells("a").getFrame().contentWindow.document.swfobject.getObjectById("FxGIS").clear();
	//parent.parent.dhxLayout.cells("a").getFrame().contentWindow.document.swfobject.getObjectById("FxGIS").findFeature("cbd", "0", key, "ZRBBH");
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").findFeature("cbd", "8", key, "XQMC");

	//添加选中保存
	//var num = objid.rowIndex();
	table.addAnnotation(objid.rowIndex);
}

//双击编辑地图
function editMap(objid){
	if(view == "R"){
		return;
	}
	//parent.parent.frames['east'].swfobject.getObjectById("FxGIS").clear();
	//parent.parent.frames['east'].swfobject.getObjectById("FxGIS").drawPolygon();
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").drawPolygon();
}

//导出Excel
function print(){
    var curTbl = document.getElementById("ESFQK"); 
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
	putClientCommond("qyjcManager","drawEsf");
    putRestParameter("xqmc",escape(escape(xqmc))); 
    putRestParameter("polygon",polygon); 
    var result = restRequest();
	//parent.parent.frames['east'].swfobject.getObjectById("FxGIS").clear();
	//parent.parent.frames['east'].swfobject.getObjectById("FxGIS").findFeature("cbd", "0", zrbbh, "ZRBBH");
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").findFeature("cbd", "8",xqmc , "XQMC");
}

function add(){
	if(table.element == undefined){
		table.init(document.getElementById("ESFQK"));
	}
	paneloper.show();
}

function dele(year,month){
	Ext.MessageBox.confirm('确认', '系统将删除所有选中二手房，确定?', function(btn,text){
		if(btn == 'yes'){
			var choseValue = table.getAnnotations();
			var choseString = '';
			while(choseValue.length != 0){
				choseString += table.getValue(choseValue.pop(),"1") + ",";
			}
			putClientCommond("scjcManager","delByYwGuid");
			putRestParameter("xqmc",escape(escape(choseString)));
			putRestParameter("year",year);
			putRestParameter("month",month);
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

function modify(){
	var annoations = table.getAnnotations();
	if(annoations.length > 0){
		var objid = table.element.rows[annoations[0]];
		if(table.element == undefined){
		table.init(document.getElementById("ESFQK"));
		}
		var key = objid.cells[1].innerText;
		xqmc = key;
		var array = paneloper.getElements();
		for(var i = 1; i < objid.cells.length; i++){
			var value = objid.cells[i].innerText;
			paneloper.insertValue(array[i+1], value);
		}
		paneloper.show();
	}
}

//根据用地单位和关键字作过滤
function queryZrb(year,month,keyword){
	putClientCommond("scjcManager","getReport");
	putRestParameter("keyword",escape(escape(keyword)));
	putRestParameter("year",year);
	putRestParameter("month",month);
	myData = restRequest();
  	document.getElementById("show").innerHTML = myData;
}


