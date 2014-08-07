var year;
var month;
var gps_id;
var win;
var width;
var height;
var isplay = false;
//显示一个设备一天的的轨迹，value为日
function showTrack(value) {
	frames["center"].swfobject.getObjectById("FxGIS").queryHistory(gps_id,year,month,value,"device_track","0","true");
	Ext.getCmp("tbar_btn_play").setDisabled(false);
	if(isplay){
		isplay = false;
	}else{
		
	}
}

function changeDate(value) {
	if (value == "<<<") {
		year = year - 1;
		init_tbar_btn(year + "," + month);
	}
	if (value == "<<") {
		if (month == 1) {
			month = 12;
			year = year - 1;
		} else {
			month = month - 1;
		}
		init_tbar_btn(year + "," + month);
	}
	if (value == ">") {
		if (month == 12) {
			month = 1;
			year = year + 1;
		} else {
			month = month + 1;
		}
		init_tbar_btn(year + "," + month);
	}
	if (value == ">>") {
		year = year + 1;
		init_tbar_btn(year + "," + month);
	}
	putClientCommond("location", "getGPSLog");
	putRestParameter("year", year);
	putRestParameter("month", month);
	putRestParameter("gps_id", gps_id);
	var myData = restRequest();
	if (myData != "") {
		myData = myData.substring(0, myData.length - 1);
	}
	init_main_btn(myData);
}

function changeSpeed(value){
	if(isplay){
		frames["center"].swfobject.getObjectById("FxGIS").changeSpeed(value);
		Ext.getCmp("field_speed").setValue("&nbsp;回放速度&nbsp;&nbsp;"+value);
	}else{
		Ext.MessageBox.alert("提示","轨迹还未开始回放!");
	}
}

function play(value) {
	frames["center"].swfobject.getObjectById("FxGIS").playHistory();
	isplay = true;
}

// 例如"1,4,9,14,25,29"
function init_main_btn(where) {
	var temp = main_btn.items.items;// 得到主面板中的所有元素
	var where_Array = where.split(",");// 得到有轨迹的天数
	for (var i = 0; i < temp.length; i++) {
		if (temp[i].id.substring(0, 4) == "btn_") {// 将所有按钮初始化为不可用
			temp[i].setDisabled(true);
		}
	}
	for (var i = 0; i < where_Array.length; i++) {// 将有轨迹的按钮初始化为可用
		if (where_Array[i] != "") {
			Ext.getCmp("btn_" + where_Array[i]).setDisabled(false);
		}
	}
}

// 例如2014,8
function init_tbar_btn(where) {
	var where_Array = where.split(",");
	Ext.getCmp("field_date").setValue("&nbsp;&nbsp;" + where_Array[0] + "年"
			+ where_Array[1] + "月");
}

function init_win_btn() {
	// 获取当前日期
	var myDate = new Date();
	year = myDate.getFullYear();
	month = myDate.getMonth() + 1;
	// 确定Window位置
	width = document.body.clientWidth - 362;
	// 初始化面板
	init_tbar_btn(year + "," + month);//初始化年、月
	Ext.getCmp("tbar_btn_play").setDisabled(true);
	putClientCommond("location", "getGPSLog");
	putRestParameter("year", year);
	putRestParameter("month", month);
	putRestParameter("gps_id", gps_id);
	var myData = restRequest();
	if (myData != "") {
		myData = myData.substring(0, myData.length - 1);
	}
	init_main_btn(myData);//初始化日
}

function showWindow(var_gps_id, gps_unit, gps_name) {
	gps_id = var_gps_id;
	init_win_btn();
	var panel = new Ext.Panel({
				id : 'panel_btn',
				title : '历史轨迹------' + gps_unit + gps_name,
				items : [tbar_btn, main_btn, speed_btn]
			});
	if (!win) {
		win = new Ext.Window({
					layout : 'fit',
					x : width,
					y : 40,
					width : 350,
					height : 260,
					plain : true,
					closeAction : 'hide',
					items : panel,
					listeners:{
						beforehide:function(){
							clear();//在窗口关闭之前清屏
						}
					}
				});
	} else {
		win.items.removeAt(0);
		win.items.add("panel_btn", panel);
		win.doLayout();
	}
	win.show();
}