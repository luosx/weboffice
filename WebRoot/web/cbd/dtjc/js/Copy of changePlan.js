
//定义一个栈对象
var stack = new Stack();
stack.Init();

var move = new Move();


//计划提前
function moveLeft(type){
	/*
	//向栈中添加操作记录
	if(type != "callback"){
		var str = "";
		str = row + "##" + cell + "##" + "moveLeft";
		stack.Push(str);
	}
	
	var moveTable = document.getElementById("planTable");
	//确定鼠标点击区域存在计划季度的最小值
	var i = 0;
	for(i = cell; i > 0; i--){
		var cells = moveTable.rows[row].cells[i];
		if(cells.className == "no"){
			i++;
			break;
		}	
	}
	while(true){
		var cells = moveTable.rows[row].cells[i];
		var newcellnum = i - step;
		if(newcellnum <= 0){
			//当季度为表格中最早的季度时
			Ext.MessageBox.alert('错误','当前计划已提前至最前，不能继续提前！', function(){
				return ;
			})
			break;
		}else if(cells.className == "yes"){
			swapProperty(i, newcellnum, moveTable);
			i++;
		}else{
			break;
		}
	}
	*/
	move.moveLeft();
}

//调整季度计划
function swapProperty(oldquarter, newquarter, moveTable){
	var oldCell = moveTable.rows[row].cells[oldquarter];
	var newCell = moveTable.rows[row].cells[newquarter];
	newCell.innerHTML = oldCell.innerHTML;
	newCell.className = "yes";
	newCell.onmouseover = function(){
		changePlan(this, 1);
	}
	oldCell.innerHTML = "";
	oldCell.className = "no";
	oldCell.onmouseover = function(){
		hiddleDiv();
	}	
}

//计划推迟
function moveRight(){
	/*
	//向栈中添加操作记录
	if(type != "callback"){
		var str = "";
		str = row + "##" + cell + "##" + "moveRight";
		stack.Push(str);
	}
	
	var moveTable = document.getElementById("planTable");
	var maxLength = moveTable.rows[row].cells.length;//列数   
	var i = 0;
	for(i = cell; i < maxLength; i++){
		var cells = moveTable.rows[row].cells[i];
		if(cells.className == "no"){
			i--;
			break;
		}
	}
	while(true){
		var cells = moveTable.rows[row].cells[i];
		var newcellnum = i + step;
		if(newcellnum > maxLength){
			Ext.MessageBox.alert("错误","当前计划已经推迟到最后，不能继续推迟", function(){
				return ;
			})
			break;
		}else if(cells.className == "yes"){
			swapProperty(i, newcellnum, moveTable);
			i--;
		}else{
			break;
		}
	}
	*/
	move.moveRight();
}

//删除上一次的修改
function callback(){
	/*
	var str = stack.Pop().toString();
	if(str != "empty"){
		var strs = str.split("##");
		row = strs[0];
		cell = strs[1];
		if(strs[2] == "moveLeft"){
			moveRight("callback");		
		}else if(strs[2] == "moveRight"){
			moveLeft("callback");
		}	
	}else{
		Ext.MessageBox.alert("错误","当前页面已无季度修改记录，无法回退！", function(){
			return ;
		})
	}
	*/
	move.callBack();
	
	
	
}

//显示修改计划
function changePlan(check, step){
	//获取当前点击的行号
	cell = check.cellIndex;
	row = check.parentElement.rowIndex;
	step = step;
	var moveTable = document.getElementById("planTable");
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

//获取鼠标点击位置
function mousePosition(ev){
	if(ev.pageX || ev.pageY){ 
		return {x:ev.pageX, y:ev.pageY}; 
	} 
	return { 
		x:ev.clientX + document.body.scrollLeft - document.body.clientLeft, 
		y:ev.clientY + document.body.scrollTop - document.body.clientTop 
	};
}

function mouseMove(){ 
	ev =  window.event; 
	var mousePos = mousePosition(ev); 
	positionX = mousePos.x; 
	positionY = mousePos.y; 
}