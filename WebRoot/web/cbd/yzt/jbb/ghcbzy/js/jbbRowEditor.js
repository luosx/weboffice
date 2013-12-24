var zrbbh = "";

//单击地图定位
function showMap(objid){
	//alert("showMap");
	var key = objid.cells[0].innerText;
	parent.parent.frames['east'].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
	parent.parent.frames['east'].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").findFeature("cbd", "1", key, "TBBH");
	
}

//双击编辑地图
function editMap(objid){
	var key = objid.cells[0].innerText;
	zrbbh = key;
	parent.parent.frames['east'].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
	parent.parent.frames['east'].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").drawPolygon();
}

//导出Excel
function print(){
	
}

//上图
function setRecord(polygon){
	putClientCommond("jbbHandle","drawZrb");
    putRestParameter("tbbh",escape(escape(zrbbh))); 
    putRestParameter("polygon",polygon); 
    var result = restRequest();
	parent.parent.frames['east'].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
	parent.parent.frames['east'].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").findFeature("cbd", "1", zrbbh, "TBBH");
}

