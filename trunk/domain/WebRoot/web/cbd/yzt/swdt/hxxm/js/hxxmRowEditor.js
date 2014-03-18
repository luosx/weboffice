var xmmc = "";
var num = 0;

//单击地图定位
function showMap(objid){
	//alert("showMap");
	var key = objid.cells[1].innerText;
	parent.parent.frames['east'].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
	parent.parent.frames['east'].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").findFeature("hxxm", "27", xmmc, "XMMC");
	
}

//双击编辑地图
function editMap(objid){
	var key = objid.cells[1].innerText;
	xmmc = key;
	parent.parent.frames['east'].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
	parent.parent.frames['east'].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").drawPolygon();
}

//导出Excel
function print(){
	
}

//上图
function setRecord(polygon){
	putClientCommond("hxxmHandle","draw");
    putRestParameter("guid",escape(escape(xmmc))); 
    putRestParameter("polygon",polygon); 
    var result = restRequest();
	parent.parent.frames['east'].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
	parent.parent.frames['east'].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").findFeature("hxxm", "27", xmmc, "XMMC");
}


function add(){
	var table = new tableoper();
	table.init(document.getElementById("HXXM"));
	Ext.MessageBox.prompt('输入', '项目名称:', function(btn, text){
		if(btn == 'ok'){
			var rows = table.addRow(3,4,num);
			num++;
			rows.cells[1].innerHTML = text;
			//向后台库中添加一笔数据
			putClientCommond("hxxmHandle","insert");
	    	putRestParameter("xmmc",escape(escape(text))); 
	    	var result = restRequest();
    	}
	});
}

function dele(){
	alert("dele");
}


