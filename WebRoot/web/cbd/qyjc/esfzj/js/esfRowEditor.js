var xqmc = "";
var num = 0;
var table = new tableoper();
var lock = false;
//zrbTable.init(document.getElementById("ZRB"));

//单击地图定位
function showMap(objid){
	if(table.element == undefined){
		table.init(document.getElementById("ESFQK"));
	}
	var key ;
	if(objid.cells.length - objid.nextSibling.cells.length >0 ){
		key = objid.cells[2].innerText;
	}else{
		key = objid.cells[1].innerText;
	}
	if(-1 == key.indexOf("计")){
		table.addAnnotation(objid.rowIndex);
	}
	
	if(table.isLock == lock){
		return ;
	}
	lock = table.isLock;
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").findFeature("cbd", "8", key, "XQMC");
}

//双击编辑地图
function editMap(objid){
	//alert(view);
	if(view == "R"){
		return;
	}
	if(table.element == undefined){
		table.init(document.getElementById("ESFQK"));
	}
	if(objid.cells.length - objid.nextSibling.cells.length >0 ){
		xqmc = objid.cells[2].innerText;
	}else{
		xqmc = objid.cells[1].innerText;
	}
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").drawPolygonMultiple();
}

function end(){
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").drawPolygonMultipleEnd();
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").findFeature("cbd", "8", xqmc, "XQMC");
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

function dele(){
	Ext.MessageBox.confirm('确认', '系统将删除所有选中二手房，确定?', function(btn,text){
		if(btn == 'yes'){
			var choseValue = table.getAnnotations();
			var choseString = '';
			while(choseValue.length != 0){
				var temp = choseValue.pop();
				choseString += table.getValue(temp,table.element.rows[temp].cells.length-2) + ",";
			}
			putClientCommond("scjcManager","delByYwGuid");
			putRestParameter("yw_guid",escape(escape(choseString)));
//			putRestParameter("year",year);
//			putRestParameter("month",month);
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
		var key = objid.cells[objid.cells.length-2].innerText;
		xqmc = key;
		putClientCommond("scjcManager","queryByname");
		putRestParameter("yw_guid",escape(escape(xqmc)));
		var hxxmmc = restRequest();
		form.findById('ssqy').setValue(hxxmmc[0].SSQY);
		form.findById('xz').setValue(hxxmmc[0].XZ);
		form.findById('xqmc').setValue(hxxmmc[0].XQMC);
		form.findById('jsnd').setValue(hxxmmc[0].JSND);
		form.findById('jzlx').setValue(hxxmmc[0].JZLX);
		form.findById('wyf').setValue(hxxmmc[0].WYF);
		form.findById('qw').setValue(hxxmmc[0].QW);
		form.findById('ldzs').setValue(hxxmmc[0].LDZS);
		form.findById('fwzs').setValue(hxxmmc[0].FWZS);
		form.findById('lczk').setValue(hxxmmc[0].LCZK);
		form.findById('rjl').setValue(hxxmmc[0].RJL);
		form.findById('lhl').setValue(hxxmmc[0].LHL);
		form.findById('tcw').setValue(hxxmmc[0].TCW);
		form.findById('kfs').setValue(hxxmmc[0].KFS);
		form.findById('wygs').setValue(hxxmmc[0].WYGS);
		form.findById('dz').setValue(hxxmmc[0].DZ);
		form.findById('yw_guid').setValue(hxxmmc[0].YW_GUID);

//		var array = paneloper.getElements();
//		for(var i = 1; i < objid.cells.length; i++){
//			var value = objid.cells[i].innerText;
//			paneloper.insertValue(array[i+1], value);
//		}
		paneloper.show();
	}
}

//根据用地单位和关键字作过滤
function queryZrb(keyword){
	putClientCommond("scjcManager","getReport");
	putRestParameter("keyword",escape(escape(keyword)));
	myData = restRequest();
  	document.getElementById("show").innerHTML = myData;
  	var obj = document.getElementById("ESFQK");
	var rowlength = obj.rows.length;
	for(var i=0;i< rowlength;i++){
		//if(i!=1){
			obj.rows[i].cells[obj.rows[i].cells.length-1].style.display="none";
			obj.rows[i].cells[obj.rows[i].cells.length-2].style.display="none";
		//}
	}
	var width = document.body.clientWidth;
	var height = document.body.clientHeight * 0.95;
   	FixTable("ESFQK", 3,1, width, height);
}


