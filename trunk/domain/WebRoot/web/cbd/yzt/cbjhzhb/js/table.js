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
	},
	fixzeTable:function(row, cell){
		var TableID = this.element.id;
		var width = self.innerWidth;
		var height = self.innerHeight;
		if ($("#" + TableID + "_tableLayout").length != 0) {
        	$("#" + TableID + "_tableLayout").before($("#" + TableID));
        	$("#" + TableID + "_tableLayout").empty();
        }else{
        	$("#" + TableID).after("<div id='" + TableID + "_tableLayout' style='overflow:hidden;height:" + height + "px; width:" + width + "px;'></div>");
        }
	    $('<div id="' + TableID + '_tableFix"></div>'
	    + '<div id="' + TableID + '_tableHead"></div>'
	    + '<div id="' + TableID + '_tableColumn"></div>'
	    + '<div id="' + TableID + '_tableData"></div>').appendTo("#" + TableID + "_tableLayout");
	    var oldtable = $("#" + TableID);
	    var tableFixClone = oldtable.clone(true);
	    tableFixClone.attr("id", TableID + "_tableFixClone");
	    var tableHeadClone = oldtable.clone(true);
	    tableHeadClone.attr("id", TableID + "_tableHeadClone");
	    $("#" + TableID + "_tableHead").append(tableHeadClone);
	    var tableColumnClone = oldtable.clone(true);
	    tableColumnClone.attr("id", TableID + "_tableColumnClone");
	    $("#" + TableID + "_tableColumn").append(tableColumnClone);
    	$("#" + TableID + "_tableData").append(oldtable);
	    $("#" + TableID + "_tableLayout table").each(function () {
        	$(this).css("margin", "0");
    	});
	    //确定列的高度
	    var height = 0;
	    if (typeof(cell) == 'string'){  
      		cell = parseInt(cell);
      	}
	    for(var i = 0; i < cell; i++){
	    	height += this.element.rows[0].cells[i].height;
	    }
	    height += 2;
        $("#" + TableID + "_tableHead").css("height", HeadHeight);
    	$("#" + TableID + "_tableFix").css("height", HeadHeight);
	    var ColumnsWidth = 0;
	    var ColumnsNumber = 0;
	    $("#" + TableID + "_tableColumn tr:last td:lt(" + FixColumnNumber + ")").each(function () {
	        ColumnsWidth += $(this).outerWidth(true);
	        ColumnsNumber++;
	    });
	    ColumnsWidth += 2;
    	if (ColumnsNumber >= 2) ColumnsWidth--;
	    $("#" + TableID + "_tableColumn").css("width", ColumnsWidth);
	    $("#" + TableID + "_tableFix").css("width", ColumnsWidth);
	    $("#" + TableID + "_tableData").scroll(function () {
	        $("#" + TableID + "_tableHead").scrollLeft($("#" + TableID + "_tableData").scrollLeft());
	        $("#" + TableID + "_tableColumn").scrollTop($("#" + TableID + "_tableData").scrollTop());
	    });
	    $("#" + TableID + "_tableFix").css({ "overflow": "hidden", "position": "relative", "z-index": "50", "background-color": "Silver" });
	    $("#" + TableID + "_tableHead").css({ "overflow": "hidden", "width": width - 17, "position": "relative", "z-index": "45", "background-color": "Silver" });
	    $("#" + TableID + "_tableColumn").css({ "overflow": "hidden", "height": height - 17, "position": "relative", "z-index": "40", "background-color": "Silver" });
	    $("#" + TableID + "_tableData").css({ "overflow": "scroll", "width": width, "height": height, "position": "relative", "z-index": "35" });
	    if ($("#" + TableID + "_tableHead").width() > $("#" + TableID + "_tableFix table").width()) {
	        $("#" + TableID + "_tableHead").css("width", $("#" + TableID + "_tableFix table").width());
	        $("#" + TableID + "_tableData").css("width", $("#" + TableID + "_tableFix table").width() + 17);
	    }
	    if ($("#" + TableID + "_tableColumn").height() > $("#" + TableID + "_tableColumn table").height()) {
	        $("#" + TableID + "_tableColumn").css("height", $("#" + TableID + "_tableColumn table").height());
	        $("#" + TableID + "_tableData").css("height", $("#" + TableID + "_tableColumn table").height() + 17);
	    }
	    $("#" + TableID + "_tableFix").offset($("#" + TableID + "_tableLayout").offset());
	    $("#" + TableID + "_tableHead").offset($("#" + TableID + "_tableLayout").offset());
	    $("#" + TableID + "_tableColumn").offset($("#" + TableID + "_tableLayout").offset());
	    $("#" + TableID + "_tableData").offset($("#" + TableID + "_tableLayout").offset());
	}
}

    function FixTable(TableID, FixColumnNumber, width, height) {
    /// <summary>
    ///     锁定表头和列
    ///     <para> sorex.cnblogs.com </para>
    /// </summary>
    /// <param name="TableID" type="String">
    ///     要锁定的Table的ID
    /// </param>
    /// <param name="FixColumnNumber" type="Number">
    ///     要锁定列的个数
    /// </param>
    /// <param name="width" type="Number">
    ///     显示的宽度
    /// </param>
    /// <param name="height" type="Number">
    ///     显示的高度
    /// </param>
    if ($("#" + TableID + "_tableLayout").length != 0) {
        $("#" + TableID + "_tableLayout").before($("#" + TableID));
        $("#" + TableID + "_tableLayout").empty();
    }
    else {
        $("#" + TableID).after("<div id='" + TableID + "_tableLayout' style='overflow:hidden;height:" + height + "px; width:" + width + "px;'></div>");
    }
    $('<div id="' + TableID + '_tableFix"></div>'
    + '<div id="' + TableID + '_tableHead"></div>'
    + '<div id="' + TableID + '_tableColumn"></div>'
    + '<div id="' + TableID + '_tableData"></div>').appendTo("#" + TableID + "_tableLayout");
    var oldtable = $("#" + TableID);
    var tableFixClone = oldtable.clone(true);
    tableFixClone.attr("id", TableID + "_tableFixClone");
    $("#" + TableID + "_tableFix").append(tableFixClone);
    var tableHeadClone = oldtable.clone(true);
    tableHeadClone.attr("id", TableID + "_tableHeadClone");
    $("#" + TableID + "_tableHead").append(tableHeadClone);
    var tableColumnClone = oldtable.clone(true);
    tableColumnClone.attr("id", TableID + "_tableColumnClone");
    $("#" + TableID + "_tableColumn").append(tableColumnClone);
    $("#" + TableID + "_tableData").append(oldtable);
    $("#" + TableID + "_tableLayout table").each(function () {
        $(this).css("margin", "0");
    });
    //var HeadHeight = $("#title ").height();
	var HeadHeight = 80;
    HeadHeight += 2;
    $("#" + TableID + "_tableHead").css("height", HeadHeight);
    $("#" + TableID + "_tableFix").css("height", HeadHeight);
    var ColumnsWidth = 0;
    var ColumnsNumber = 0;
    $("#" + TableID + "_tableColumn tr:last td:lt(" + FixColumnNumber + ")").each(function () {
        ColumnsWidth += $(this).outerWidth(true);
        ColumnsNumber++;
    });
    ColumnsWidth += 2;

	if (ColumnsNumber >= 2) ColumnsWidth--;

    $("#" + TableID + "_tableColumn").css("width", ColumnsWidth);
    $("#" + TableID + "_tableFix").css("width", ColumnsWidth);
    $("#" + TableID + "_tableData").scroll(function () {
        $("#" + TableID + "_tableHead").scrollLeft($("#" + TableID + "_tableData").scrollLeft());
        $("#" + TableID + "_tableColumn").scrollTop($("#" + TableID + "_tableData").scrollTop());
    });
    $("#" + TableID + "_tableFix").css({ "overflow": "hidden", "position": "relative", "z-index": "50", "background-color": "Silver" });
    $("#" + TableID + "_tableHead").css({ "overflow": "hidden", "width": width - 17, "position": "relative", "z-index": "45", "background-color": "Silver" });
    $("#" + TableID + "_tableColumn").css({ "overflow": "hidden", "height": height - 17, "position": "relative", "z-index": "40", "background-color": "Silver" });
    $("#" + TableID + "_tableData").css({ "overflow": "scroll", "width": width, "height": height, "position": "relative", "z-index": "35" });
    if ($("#" + TableID + "_tableHead").width() > $("#" + TableID + "_tableFix table").width()) {
        $("#" + TableID + "_tableHead").css("width", $("#" + TableID + "_tableFix table").width());
        $("#" + TableID + "_tableData").css("width", $("#" + TableID + "_tableFix table").width() + 17);
    }
    if ($("#" + TableID + "_tableColumn").height() > $("#" + TableID + "_tableColumn table").height()) {
        $("#" + TableID + "_tableColumn").css("height", $("#" + TableID + "_tableColumn table").height());
        $("#" + TableID + "_tableData").css("height", $("#" + TableID + "_tableColumn table").height() + 17);
    }
    $("#" + TableID + "_tableFix").offset($("#" + TableID + "_tableLayout").offset());
    $("#" + TableID + "_tableHead").offset($("#" + TableID + "_tableLayout").offset());
    $("#" + TableID + "_tableColumn").offset($("#" + TableID + "_tableLayout").offset());
    $("#" + TableID + "_tableData").offset($("#" + TableID + "_tableLayout").offset());
}

