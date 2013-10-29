

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
	move = new Move();
	move.Init(moveTable, row, cell);
	
	//获取当前鼠标点击位置
	var showDiv = document.getElementById(divName);
	var type = showDiv.style.display;
	changePosition(0, 0);
	showDiv.style.display = "";		
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

//显示基本信息
function showDetail(){

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