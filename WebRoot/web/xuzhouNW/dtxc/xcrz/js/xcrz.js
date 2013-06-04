function addcgd(){
	var allnum = document.getElementById("allnum");
	var num = allnum.value;
	num = String(parseInt(num)/3 + 1);
	var fieldname1 = new Array();
	fieldname1.push("<div align=\"center\"><input type=\"checkbox\" id='check" + num + "' /></div>");
	fieldname1.push("<div align=\"center\">建设项目</div>");
	fieldname1.push("<input type=\"text\" class=\"noborder\" name=\"jsmj" + num + "\" id=\"jsmj" + num + "\" style=\"width: 97%\"/>");
	fieldname1.push("<div align=\"center\">建设单位</div>");
	fieldname1.push("<input type=\"text\" class=\"noborder\" name=\"jsdw" + num + "\" id=\"jsdw" + num + "\" style=\"width: 97%\"/>");
	addccft("allnum", "xcrztable", "5", fieldname1, "1");
	
	var fieldname2 = new Array();
	fieldname2.push("<div align=\"center\">动工时间</div>");
	fieldname2.push("<input type=\"text\" class=\"noborder\"  onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd'})\" name=\"dgsj" + num + "\" id=\"dgsj" + num + "\" readonly style=\"width: 97%\"/>");
	fieldname2.push("<div align=\"center\">建设情况</div>");
	fieldname2.push("<input type=\"text\" class=\"noborder\" name=\"jsqk" + num + "\" id=\"jsqk" + num + "\" style=\"width: 97%\"/>");
	addccft("allnum", "xcrztable", "5", fieldname2, "2");
	
	var fieldname3 = new Array();
	fieldname3.push("<div align=\"center\">占地面积</div>");
	fieldname3.push("<input type=\"text\" class=\"noborder\" name=\"zdmj" + num + "\" id=\"zdmj" + num + "\" style=\"width: 97%\"/>");
	fieldname3.push("<div align=\"center\">占地位置</div>");
	fieldname3.push("<input type=\"text\" class=\"noborder\" name=\"zdwz" + num + "\" id=\"zdwz" + num + "\" style=\"width: 97%\"/>");
	addccft("allnum", "xcrztable", "5", fieldname3, "3");
}

function deletecgd(){
	var name = new Array("check", "jsmj", "jsdw", "dgsj", "jsqk", "zdmj", "zdwz");
	deleteccjl("allnum", "xcrztable", "4", name);
}

function deleteccjl(allnum, tablename, number, name){
	var recordnum = document.getElementById(allnum);
	var num = String(parseInt(recordnum.value)/3);
	var deletetable = document.getElementById(tablename);
	for(var i = 1; i <= num; i++){
		var isdelete = document.getElementById(name[0] + String(i));
		if(isdelete.checked){
			for(var j = i; j < num; j++){
				replacevalue(j + 1, j, name);
			}
			deletetable.deleteRow(parseInt(recordnum.value) + parseInt(number));
			deletetable.deleteRow(parseInt(recordnum.value) + parseInt(number) - 1);
			deletetable.deleteRow(parseInt(recordnum.value) + parseInt(number) - 2);
			recordnum.value = String(parseInt(recordnum.value) - 3);
			num = String(parseInt(recordnum.value)/3);
			i--;
		}
	}
}

function replacevalue(newnum , oldnum, name){
	var oldfieldcheck = document.getElementById(name[0] + String(oldnum));
	var newfieldcheck = document.getElementById(name[0] + String(newnum));
	oldfieldcheck.checked = newfieldcheck.checked;
	for(i = 1 ; i < name.length; i++){
		var fieldname = name[i];
		var oldfieldname = document.getElementById(fieldname + oldnum);
		var newfieldname = document.getElementById(fieldname + newnum);
		oldfieldname.value = newfieldname.value;
	}
}

function addccft(allnum, tablename, number, newfield, style){
	var recordnum = document.getElementById(allnum);
	var num = recordnum.value;
	var addtable = document.getElementById(tablename);
	var newRow = addtable.insertRow(parseInt(num) + parseInt(number));
	newRow.align = "left";
	recordnum.value = parseInt(num) + 1;
	addnewRow(newRow, newfield, style);
}

function addnewRow(newRow, newfield, style){
	for(var i = 0; i < newfield.length; i++){
		if(style == "1"){
			var newCell = newRow.insertCell(i);
			newCell.innerHTML = newfield[i];
			if(i == 0){
				newCell.rowSpan = "3";
			}
		}else{
			var newCell = newRow.insertCell(i);
			newCell.innerHTML = newfield[i];
		}
	}
}