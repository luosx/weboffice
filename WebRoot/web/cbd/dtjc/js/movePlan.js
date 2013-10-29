
var stack = new Stack();
stack.Init();

//实现一个类，用来实现季度的修改
var Move = function(){};
Move.prototype={
	Init:function(moveTable,row,cell){
		this.row = row;
		this.moveTable = moveTable;
		this.minnum = 1;
		this.getArray(cell);
		//定义一个栈对象
	},
	getArray:function(cell){
		var moveTable = this.moveTable;
		var blockArray = new Array();
		var i = 0;
		for(i = cell; i > 0; i--){
			var cells = moveTable.rows[this.row].cells[i];
			if(cells.className == "no"){
				i++;
				break;
			}
		}
		var maxLength = moveTable.rows[row].cells.length;
		for(i ; i < maxLength; i++){
			var cells = moveTable.rows[this.row].cells[i];
			if(cells.className == "no"){
				break;	
			}else{
				blockArray.push(i);
			}
		}
		
		this.cellArray = blockArray;
	},
	moveLeft:function( type, blockArray){
		if(type == "callback"){
			var blockArray = blockArray;
		}else{
			this.getArray(cell);
			var blockArray = this.cellArray;
		}
		for(var i = 0; i < blockArray.length; i++){
			var number = blockArray[i];
			if(number < this.minnum){
				//当季度为表格中最早的季度时
				Ext.MessageBox.alert('错误','当前计划已提前至最前，不能继续提前！', function(){
					return ;
				})	
			}else{
				this.swapProperty(number, parseInt(number) - 1 );
				blockArray[i] = parseInt(number) - 1;
			}
		}
		if(type != "callback"){
			stack.Push(blockArray);
			stack.Push("moveLeft");
		}
	},
	moveRight:function(type, blockArray){
		if(type == "callback"){
			var blockArray = blockArray;
		}else{
			this.getArray(cell);
			var blockArray = this.cellArray;
		}
		var maxLength = this.moveTable.rows[row].cells.length;
		for(var i = blockArray.length - 1; i >= 0; i--){
			var number = blockArray[i];
			if(number >= maxLength){
				Ext.MessageBox.alert('错误','当前计划已是最迟计划，不能再向后推迟！', function(){
					return;
				})
			}else{
				this.swapProperty(number, parseInt(number) + 1);
				blockArray[i] = parseInt(number) + 1;
			}
		}
		if(type != "callback"){
			stack.Push(blockArray);
			stack.Push("moveRight");
		}
	},
	swapProperty:function(oldquarter, newquarter){
		var oldCell = this.moveTable.rows[this.row].cells[oldquarter];
		var newCell = this.moveTable.rows[this.row].cells[newquarter];
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
	},
	callBack: function(){
		var typeName = stack.Pop();
		var typeArray = stack.Pop();
		if(typeName == "moveLeft"){
			this.moveRight("callback", typeArray);
		}else if(typeName == "moveRight"){
			this.moveLeft("callback", typeArray);
		}
	}
}
