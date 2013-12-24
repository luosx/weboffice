var zrbbh = "";
var num = 0;


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
    var curTbl = document.getElementById("NDJH"); 
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
	parent.parent.frames['east'].swfobject.getObjectById("FxGIS").clear();
	parent.parent.frames['east'].swfobject.getObjectById("FxGIS").findFeature("cbd", "0", zrbbh, "ZRBBH");
}

function add(){
	var table = new tableoper();
	table.init(document.getElementById("ZRB"));
	Ext.MessageBox.prompt('输入', '请输入自然斑编号:', function(btn, text){
		if(btn == 'ok'){
			var rows = table.addRow(2,3,num);
			num++;
			rows.cells[1].innerHTML = text;
			//向后台库中添加一笔数据
			putClientCommond("zrbHandle","insertZrb");
	    	putRestParameter("ZRBBH",escape(escape(text))); 
	    	var result = restRequest();
    	}
	});
}

function dele(){
	alert("dele");
}



