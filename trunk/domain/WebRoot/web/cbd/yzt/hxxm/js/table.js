tableoper = function(){
	var element;
}
tableoper.prototype = {
	init:function(dom){
		this.element = dom;
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
	}
}