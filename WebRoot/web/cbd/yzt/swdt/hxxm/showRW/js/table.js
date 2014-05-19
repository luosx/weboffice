var tableoper = function(){
	var element;
	var chose;
	var isLock = false;
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
				newcell.width = stycell.width;
				newcell.height = stycell.height;
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
		if(this.element==null){
			this.element = document.getElementById("HXXM");
		}
		var color = this.element.rows[row].style.backgroundColor;
		if(!this.isLock){
			if(color != "#d1e5fb" && color != ""){
				this.chose[row] = '';
				this.changeColor(row,"#d1e5fb");
			}else{
				this.chose[row] = true;
				this.isLock = true;
				this.changeColor(row,"#E4F7D6");
			}
		}else{
			if(color != "#d1e5fb" && color != ""){
				this.chose[row] = '';
				this.isLock = false;
				this.changeColor(row,"#d1e5fb");
			}
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
	//获取某个TD的值
	getValue:function(row, num){
		return this.element.rows[row].cells[num].innerText;
	},
	//设定某个TD的值
	setValue:function(row, num, value){
		this.element.rows[row].cells[num].innerHTML = "<div id='0' style='display:none;width:10'></div>" + value;
		return true;
	},
	toAnnotation:function(s){
		var tempValue = eval('(' + s + ')');
		var hxxmmc = tempValue[0].attributes.项目名称;
		this.findRowByfiled(hxxmmc);
	},
	findRowByfiled:function(field){
		var dom = document.getElementById("HXXM");
		for(var i=0;i<dom.rows.length;i++){
			if(dom.rows[i].cells[1].innerText==field){
				this.init(dom);
				this.addAnnotation(i);
			}
		}
	}
	
}