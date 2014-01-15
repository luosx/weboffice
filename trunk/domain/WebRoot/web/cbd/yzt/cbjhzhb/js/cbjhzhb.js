var zrbbh = "";
var num = 0;
var table = new tableoper();
//zrbTable.init(document.getElementById("ZRB"));

//初始化
function init(){
	table.init(document.getElementById("CBJHZHB"));
	// table.fixzeTable('3','3');
}


function showMap(objid){
	if(table.element == undefined){
		table.init(document.getElementById("CBJHZHB"));
	}
	//添加选中保存
	//var num = objid.rowIndex();
	table.addAnnotation(objid.rowIndex);
}


function editMap(objid){
	showMap(objid);
}

//导出Excel
function print(){
    var curTbl = document.getElementById("CBJHZHB"); 
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

$(document).ready(function () {
	var width = document.body.clientWidth;
	var height = document.body.clientHeight;
    FixTable("CBJHZHB", 1, width, height);
});

