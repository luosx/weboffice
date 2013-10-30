

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
	cell = check.cellIndex;
	row = check.parentElement.rowIndex;
	step = step;
	var moveTable = document.getElementById("planTable");
	move = new Table();
	move.Init(moveTable, row, cell);
	
	//获取当前鼠标点击位置
	var showDiv = document.getElementById(divName);
	var type = showDiv.style.display;
	changePosition(0, 0);
	showDiv.style.display = "";		
}

function getPosition(check){
	//获取当前点击的行号

}

//修改div显示的位置
function changePosition(x, y ){
	var showDiv = document.getElementById(divName);
	mouseMove();
	showDiv.style.left = positionX - 60 + x;
	var top  = positionY - 10 + y;
	if(top < 0){
		top = 5;
	}
	showDiv.style.top = top;
}

function addDetail(check){
	cell = check.cellIndex;
	row = check.parentElement.rowIndex;
	showDetail();
}


//显示基本信息
function showDetail(){
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
	//addTask();
	if(this.row >= (2 + parseInt(kftlNum))){
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