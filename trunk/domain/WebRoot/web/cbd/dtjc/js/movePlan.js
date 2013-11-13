
var stack = new Stack();
stack.Init();

//实现一个类，用来实现季度的修改
var Table = function(){};
Table.prototype={
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
		var j =-1;
		if((this.row == 2 || this.row == (parseInt(kftlNum) + 2))){
			j = 0;
		}
		for(i = cell; i > j; i--){
			var cells = moveTable.rows[this.row].cells[i];
			if(cells.className == "no" || cells.className == ""){
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
			if(number < this.minnum || ((this.row == 2 || this.row == (parseInt(kftlNum) + 2)) && number < 2 )){
				//当季度为表格中最早的季度时
				Ext.MessageBox.alert('错误','当前计划已提前至最前，不能继续提前！', function(){
					return ;
				})	
			}else{
				this.swapProperty(number, parseInt(number) - 1 );
				blockArray[i] = parseInt(number) - 1;
			}
			this.changePosition(-1);
		}
		
		if(type != "callback"){
			blockArray.push("moveLeft");
			blockArray.push(this.row);
			stack.Push(blockArray);
			//stack.Push("moveLeft");
			//stack.Push
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
			this.changePosition(1);
		}
		if(type != "callback"){
			blockArray.push("moveRight");
			blockArray.push(this.row);
			stack.Push(blockArray);
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
		this.saveChange(oldquarter, newquarter);
	},
	callBack: function(){
		var typeArray = stack.Pop();
		var length = typeArray.length;
		var typeName = typeArray[length - 2];
		this.row = typeArray[length - 1];
		typeArray.length = length - 2;
		if(typeName == "moveLeft"){
			this.moveRight("callback", typeArray);
		}else if(typeName == "moveRight"){
			this.moveLeft("callback", typeArray);
		}
	},
	//将前台改动保存到数据库
	saveChange:function(oldcell, newcell){
		//alert(minyear);
		//alert(kftlNum);
		var projectName = "";
		var oldquarter = 0;
		var newquarter = 0;
		var oldyear = 0;
		var newyear = 0;
		var formname = "hx_kftl";
		if(this.row == 2 || this.row == (parseInt(kftlNum) + 2)){
			projectName = this.moveTable.rows[this.row].cells[1].innerText;
			oldquarter = (parseInt(oldcell) - 1)%4;
			newquarter = (parseInt(newcell) - 1)%4;
			oldyear = (parseInt(oldcell) - 1)/4;
			newyear = (parseInt(newcell) - 1)/4;
		}else{
			projectName = this.moveTable.rows[this.row].cells[0].innerText;
			oldquarter = (parseInt(oldcell) - 0)%4;
			newquarter = (parseInt(newcell) - 0)%4;
			oldyear = (parseInt(oldcell) - 0)/4;
			newyear = (parseInt(newcell) - 0)/4;
		}
		if(oldquarter == 0){
			oldyear = oldyear - 1;
			oldquarter = 4;
		}
		if(newquarter == 0){
			newyear = newyear - 1;
			newquarter = 4;
		}
		oldyear = parseInt(oldyear) + parseInt(minyear);
		newyear = parseInt(newyear) + parseInt(minyear);
		if(this.row >= (2 + parseInt(kftlNum))){
			formname = "hx_gdtl";
		}
		
       putClientCommond("tjbbManager","changePlan");
       putRestParameter("projectname",escape(escape(projectName)));
       putRestParameter("formname",formname);
       putRestParameter("oldyear",oldyear);
       putRestParameter("oldquarter",oldquarter);
       putRestParameter("newyear",newyear);
       putRestParameter("newquarter",newquarter);
       restRequest();
       
	},
	changePosition: function(type){
		/**
		var newquarter = this.cell + type;
		var newCell = this.moveTable.rows[this.row].cells[newquarter];
		var obj = newCell.getBoundingClientRect();
		var left = obj.left;
		var top = obj.top;
		changePosition(left, top);
		*/
	}
}
