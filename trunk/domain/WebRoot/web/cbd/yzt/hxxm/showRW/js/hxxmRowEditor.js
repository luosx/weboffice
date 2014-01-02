var xmmc = "";
var num = 0;
var table = new tableoper();
//单击地图定位
function showMap(objid){
	//alert("showMap");
	if(table.element == undefined){
		table.init(document.getElementById("HXXM"));
	}
	var key = objid.cells[1].innerText;
	xmmc = key;
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").findFeature("cbd", "5", xmmc, "XMMC");

		//添加选中保存
	//var num = objid.rowIndex();
	table.addAnnotation(objid.rowIndex);
}

//双击编辑地图
function editMap(objid){
	var key = objid.cells[1].innerText;
	xmmc = key;
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").drawPolygon();
}

//上图
function setRecord(polygon){
	putClientCommond("hxxmHandle","draw");
    putRestParameter("guid",escape(escape(xmmc))); 
    putRestParameter("polygon",polygon); 
    var result = restRequest();
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").clear();
	parent.parent.document.frames[0].frames['center'].frames["lower"].swfobject.getObjectById("FxGIS").findFeature("cbd", "5", xmmc, "XMMC");
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
	Ext.MessageBox.confirm('确认', '系统将删除所有选中红线项目，确定?', function(btn,text){
		if(btn == 'yes'){
			var choseValue = table.getAnnotations();
			var choseString = '';
			while(choseValue.length != 0){
				choseString += table.getValue(choseValue.pop(),"1") + ",";
			}
			putClientCommond("hxxmHandle","delete");
			putRestParameter("xmmc",choseString);
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

//导出Excel
function print(){
    var curTbl = document.getElementById("HXXM"); 
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

//根据用地单位和关键字作过滤
function queryHxxm(keyword){
	putClientCommond("hxxmHandle","getReport");
	putRestParameter("keyword",escape(escape(keyword)));
	myData = restRequest();
  	document.getElementById("show").innerHTML = myData;
}

