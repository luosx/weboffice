
var move;

//计划提前
function moveLeft(type){

	move.moveLeft();
}

//计划推迟
function moveRight(){
	move.moveRight();
}

//删除上一次的修改
function callback(){
	move.callBack();
}

//显示修改计划
function changePlan(check, step){
	//获取当前点击的行号
	var obj = check.getBoundingClientRect()
	var left = obj.left;
	var top = obj.top;
	cell = check.cellIndex;
	row = check.parentElement.rowIndex;
	var moveTable = document.getElementById("planTable");
	minyear = moveTable.rows[0].cells[1].innerText;
	move = new Table();
	move.Init(moveTable, row, cell);
	
	//获取当前鼠标点击位置
	var showDiv = document.getElementById(divName);
	var type = showDiv.style.display;
	changePosition(left, top);
	showDiv.style.display = "";		
}

function getPosition(check){
	//获取当前点击的行号

}

//修改div显示的位置
function changePosition(x, y ){
	var showDiv = document.getElementById(divName);
	showDiv.style.left = x;
	showDiv.style.top = y;
}

function addDetail(check){
	cell = check.cellIndex;
	row = check.parentElement.rowIndex;
	showDetail();
}


//显示基本信息
function showDetail(){
	var moveTable = document.getElementById("planTable");
	minyear = moveTable.rows[0].cells[1].innerText;
	//cell = check.cellIndex;
	//row = check.parentElement.rowIndex;
	var moveTable = document.getElementById("planTable");
	var projectName = "";
	var quarter = 0;
	var year = 0;
	if(row == 2 || row == (parseInt(kftlNum) + 2)){
		projectName = moveTable.rows[row].cells[1].innerText;
		quarter = (parseInt(cell) - 1)%4;
		year = (parseInt(cell) - 1)/4;
	}else{
		projectName = moveTable.rows[row].cells[0].innerText;
		quarter = (parseInt(cell) - 0)%4;
		year = (parseInt(cell) - 0)/4;
	}
	if(quarter == 0){
		year = year - 1;
		quarter = 4;
	}
	year = parseInt(year) + parseInt(minyear);
	if(row >= parseInt(kftlNum) + 2){
		dealGdtl(projectName,year,quarter);
	}else{
		dealKftl(projectName,year,quarter);
	}
} 

//隐藏DIV
function hiddleDiv(){
	var showDiv = document.getElementById(divName);
	showDiv.style.display = "none";
}

function mouseMove(){ 
	ev =  window.event; 
	if(ev.pageX || ev.pageY){ 
		positionX = ev.pageX;
		positionY = ev.pageY; 
	}else if(ev != undefined){ 
		positionX = ev.clientX + document.body.scrollLeft - document.body.clientLeft;
		positionY = ev.clientY + document.body.scrollTop - document.body.clientTop; 
	}else{
		positionX = 0;
		positionY = 0;
	};
}

//修改项目
function changeProject(){
	if(!win){
		win = new Ext.Window({
            layout: 'fit',
            title: '请选择',
            closeAction: 'hide',
            width:600,
            height:440,
            x: 40,
            y: 110,
            items:winForm
        });
        win.show();
	}
}

//添加融资需求
function addrzxq(check){
	var value = check.value;
	if(isNaN(value)){
		alert("数字格式错误");
		return ;
	}
	var changeCell = check.parentNode.cellIndex;
	//计算年度和季度
	var moveTable = document.getElementById("planTable");
	var minyear = moveTable.rows[0].cells[1].innerText;
	var quarter = (parseInt(changeCell) - 0)%4;
	var year = (parseInt(changeCell) - 0)/4;
	if(quarter == 0){
		year = year - 1;
		quarter = 4;
	}
	year = parseInt(year) + parseInt(minyear);
   	putClientCommond("tjbbManager","changeTrzqk");
	putRestParameter("type", "rzxq");
   	putRestParameter("year",year);
   	putRestParameter("quarter",quarter);
   	putRestParameter("value",value);
   	restRequest();
}


//添加权益资金注入
function addzjzr(check){
	var value = check.value;
	if(isNaN(value)){
		alert("数字格式错误");
		return ;
	}
	var changeCell = check.parentNode.cellIndex;
	//计算年度和季度
	var moveTable = document.getElementById("planTable");
	var minyear = moveTable.rows[0].cells[1].innerText;
	var quarter = (parseInt(changeCell) - 0)%4;
	var year = (parseInt(changeCell) - 0)/4;
	if(quarter == 0){
		year = year - 1;
		quarter = 4;
	}
	year = parseInt(year) + parseInt(minyear);
   	putClientCommond("tjbbManager","changeTrzqk");
	putRestParameter("type", "zjzr");
   	putRestParameter("year",year);
   	putRestParameter("quarter",quarter);
   	putRestParameter("value",value);
   	restRequest();
}

function addkg(check){
	var value = check.value;
	if(isNaN(value)){
		alert("数字格式错误");
		return ;
	}
	var changeCell = check.parentNode.cellIndex;
	var changeRow = check.parentNode.parentNode.rowIndex;
	//计算年度和季度
	var moveTable = document.getElementById("planTable");
	var minyear = moveTable.rows[0].cells[1].innerText;
	var quarter = (parseInt(changeCell) - 1)%4;
	var year = (parseInt(changeCell) - 1)/4;
	var xmmc = moveTable.rows[parseInt(changeRow)].cells[1].innerText;
	var tzmc = moveTable.rows[parseInt(changeRow)+1].cells[1].innerText;
	
	if(quarter == 0){
		year = year - 1;
		quarter = 4;
	}	
	
	year = parseInt(year) + parseInt(minyear);
   	putClientCommond("tjbbManager","changeTrzqk");
	putRestParameter("type", "kg");
   	putRestParameter("year",year);
   	putRestParameter("quarter",quarter);
   	putRestParameter("value",value);
   	putRestParameter("xmmc",xmmc);
   	putRestParameter("tzmc",tzmc);
   	restRequest();
}

function addtz(check){
	var value = check.value;
	if(isNaN(value)){
		alert("数字格式错误");
		return ;
	}
		
	var changeCell = check.parentNode.cellIndex;
	var changeRow = check.parentNode.parentNode.rowIndex;
	//计算年度和季度
	var moveTable = document.getElementById("planTable");
	var minyear = moveTable.rows[0].cells[1].innerText;
	var quarter = (parseInt(changeCell) - 1)%4;
	var year = (parseInt(changeCell) - 1)/4;
	var xmmc = moveTable.rows[parseInt(changeRow)-1].cells[1].innerText;
	var tzmc = moveTable.rows[parseInt(changeRow)].cells[1].innerText;
	if(quarter == 0){
		year = year - 1;
		quarter = 4;
	}
	year = parseInt(year) + parseInt(minyear);
   	putClientCommond("tjbbManager","changeTrzqk");
	putRestParameter("type", "tz");
   	putRestParameter("year",year);
   	putRestParameter("quarter",quarter);
   	putRestParameter("value",value);
   	putRestParameter("xmmc",xmmc);
   	putRestParameter("tzmc",tzmc);
   	restRequest();
}