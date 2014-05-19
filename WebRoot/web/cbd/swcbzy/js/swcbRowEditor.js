var zrbbh = "";
var table = new tableoper();
//单击地图定位
function showMap(objid){
	//alert("showMap");
	if(table.element == undefined){
		table.init(document.getElementById("SWCBR"));
	}
	var key = objid.cells[1].innerText;
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").findFeature("cbd", "5", key, "DKMC");
	if(-1 == key.indexOf("计")){
		table.addAnnotation(objid.rowIndex);
	}
}

//双击编辑地图
function editMap(objid){
	var key = objid.cells[0].innerText;
	zrbbh = key;
	//parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
	//parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").drawPolygon();
}

//导出Excel
function print(){
    var curTbl = document.getElementById("SWCBR"); 
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
	putClientCommond("jbbHandle","drawZrb");
    putRestParameter("tbbh",escape(escape(zrbbh))); 
    putRestParameter("polygon",polygon); 
    var result = restRequest();
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").findFeature("cbd", "5", zrbbh, "DKMC");
}

function queryJBB(keyword){
	putClientCommond("kgzbmanager","getReport");
	putRestParameter("keyword",escape(escape(keyword)));
	putRestParameter("type","reader");
	myData = restRequest();
  	document.getElementById("show").innerHTML = myData;
  	
  	var width = document.body.clientWidth;
	var height = document.body.clientHeight*0.95;
  	FixTable("SWCBR", 1,1, width, height-30);
}

