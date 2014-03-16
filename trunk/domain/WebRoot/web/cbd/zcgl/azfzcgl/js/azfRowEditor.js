var dkmc = "";
var num = 0;

var table = new tableoper();
//单击地图定位
function showMap(objid){
	if(table.element == undefined){
		table.init(document.getElementById("AZFZC"));
	}
	//alert("showMap");
	var key = objid.cells[1].innerText;
	table.addAnnotation(objid.rowIndex);
	//parent.parent.frames['east'].swfobject.getObjectById("FxGIS").clear();
	//parent.parent.frames['east'].swfobject.getObjectById("FxGIS").findFeature("cbd", "0", key, "ZRBBH");
	
}

//双击编辑地图
function editMap(objid){
	
	if(table.element == undefined){
		table.init(document.getElementById("AZFZC"));
	}
	var key = objid.cells[1].innerText;
	dkmc = key;
	var array = paneloper2.getElements();
	for(var i = 1; i < objid.cells.length; i++){
		var value = objid.cells[i].innerText;	
		paneloper2.insertValue(array[i-1], value);
	}

	//Ext.getCmp("xmmc").getEl().dom.readOnly= true;
	paneloper2.show();
	//parent.parent.frames['east'].swfobject.getObjectById("FxGIS").clear();
	//parent.parent.frames['east'].swfobject.getObjectById("FxGIS").drawPolygon();
}

//导出Excel
function print(){
    var curTbl = document.getElementById("AZFZC"); 
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


function add(){
	if(table.element == undefined){
		table.init(document.getElementById("AZFZC"));
	}
	paneloper2.show();
	
}

function dele(){
	Ext.MessageBox.confirm('确认', '系统将删除所有选中安置房资产，确定?', function(btn,text){
		if(btn == 'yes'){
			var choseValue = table.getAnnotations();
			var choseString = '';
			if(choseValue.length != 0){
				choseString += table.getValue(choseValue.pop(),"19")+ ",";
			}
			putClientCommond("zafzc","delByYwGuid");
			putRestParameter("yw_guid",escape(escape(choseString)));
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
	putClientCommond("zafzc","getReport");
	putRestParameter("keyword",escape(escape(keyword)));
	myData = restRequest();
  	document.getElementById("show").innerHTML = myData;
}
function modify(){
	var annoations = table.getAnnotations();
	if(annoations.length > 0){
		var objid = table.element.rows[annoations[0]];
		editMap(objid);
	}
}

