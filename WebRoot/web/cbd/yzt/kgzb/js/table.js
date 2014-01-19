var tableoper = function(){
	var element;
	var chose;
}
tableoper.prototype = {
	init:function(dom){
		this.element = dom;
		this.chose = new Array(this.element.rows.length);
	},
	addRow:function(rownum,stylerow,num){
		var styleRow = this.element.rows[stylerow];
		var stylecells = styleRow.cells;
		var newRow = this.element.insertRow(rownum);
		newRow.className = styleRow.className;
		newRow.onclick = styleRow.onclick;
		newRow.ondblclick = styleRow.ondblclick;
		for(var i = 0; i < stylecells.length; i++){
			var stycell = stylecells[i];
			var newcell = newRow.insertCell(i);
			if(i == 0){
				newcell.innerText = "0";
			}else{
				newcell.onclick = stycell.onclick;
				newcell.onmouseover = stycell.onmouseover;
				newcell.onmouseout = stycell.onmouseout;
				newcell.innerHTML = "<div id='0' style='display:none;width:10'></div>";
			}
			newcell.id = num + "new_" + i;
		}
		return newRow;

	},
	deleteRow:function(rownum){
		this.element.deleteRow(rownum);
	},
	//添加选中标记
	addAnnotation:function(row){
		var color = this.element.rows[row].style.backgroundColor;
		if(color != "#d1e5fb" && color != ""){
			this.chose[row] = '';
			this.changeColor(row,"#d1e5fb");
		}else{
			this.chose[row] = true;
			this.changeColor(row,"#E4F7D6");
		}
	},
	//删除选中标记
	deleAnnotation:function(row){
		this.chose[row]='';
	},
	//获取所有含有选中标记
	getAnnotations:function(){
		var allChose = new Array();
		for(var i = 0; i < this.chose.length; i++){
			if(this.chose[i] == true){
				allChose.push(i);
			}
		}
		return allChose;
	},
	//清空所有选中标记
	clearAnnotations:function(){
		for(var i = 0; i < this.chose.length; i++){
			this.chose[i] = '';
			this.changeColor(i,"#d1e5fb");
		}
	},
	//修改行颜色
	changeColor:function(row,color){
		this.element.rows[row].style.backgroundColor = color;
	},
	getValue:function(row, num){
		return this.element.rows[row].cells[num].innerText;
	}
	
}