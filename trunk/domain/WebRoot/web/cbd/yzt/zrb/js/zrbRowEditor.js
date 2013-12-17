var zrbbh = "";

//单击地图定位
function showMap(objid){
	//alert("showMap");
	var key = objid.cells[1].innerText;
	parent.parent.frames['east'].swfobject.getObjectById("FxGIS").clear();
	parent.parent.frames['east'].swfobject.getObjectById("FxGIS").findFeature("cbd", "0", key, "ZRBBH");
	
}

//双击编辑地图
function editMap(objid){
	var key = objid.cells[1].innerText;
	zrbbh = key;
	parent.parent.frames['east'].swfobject.getObjectById("FxGIS").clear();
	parent.parent.frames['east'].swfobject.getObjectById("FxGIS").drawPolygon();
}

//导出Excel
function print(){
	
}

//上图
function setRecord(polygon){
	putClientCommond("zrbHandle","drawZrb");
    putRestParameter("tbbh",escape(escape(zrbbh))); 
    putRestParameter("polygon",polygon); 
    var result = restRequest();
	parent.parent.frames['east'].swfobject.getObjectById("FxGIS").clear();
	parent.parent.frames['east'].swfobject.getObjectById("FxGIS").findFeature("cbd", "0", zrbbh, "ZRBBH");
	
}

