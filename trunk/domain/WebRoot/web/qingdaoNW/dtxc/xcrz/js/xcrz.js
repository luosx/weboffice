function addcgd(){
	var allnum = document.getElementById("allnum");
	var num = allnum.value;
	num = String(parseInt(num)/5 + 1);
	var fieldname1 = new Array();
	fieldname1.push("<div align=\"center\"><input type=\"checkbox\" id='check_" + num + "' /></div>");
	fieldname1.push("<div align=\"center\">建设项目</div>");
	fieldname1.push("<input type=\"text\" class=\"noborder\" name=\"jsxm_" + num + "\" id=\"jsxm_" + num + "\" style=\"width: 97%\"/>");
	fieldname1.push("<div align=\"center\">建设单位</div>");
	fieldname1.push("<input type=\"text\" class=\"noborder\" name=\"jsdw_" + num + "\" id=\"jsdw_" + num + "\" style=\"width: 97%\"/>");
	addccft("allnum", "xcrztable", "5", fieldname1, "1");
	
	var fieldname2 = new Array();
	fieldname2.push("<div align=\"center\">动工时间</div>");
	fieldname2.push("<input type=\"text\" class=\"noborder\"  onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd'})\" name=\"dgsj_" + num + "\" id=\"dgsj_" + num + "\" readonly style=\"width: 97%\"/>");
	fieldname2.push("<div align=\"center\">建设情况</div>");
	fieldname2.push("<input type=\"text\" class=\"noborder\" name=\"jsqk_" + num + "\" id=\"jsqk_" + num + "\" style=\"width: 97%\"/>");
	addccft("allnum", "xcrztable", "5", fieldname2, "2");
	
	var fieldname3 = new Array();
	fieldname3.push("<div align=\"center\">占地面积</div>");
	fieldname3.push("<input type=\"text\" class=\"noborder\" name=\"zdmj_" + num + "\" id=\"zdmj_" + num + "\" style=\"width: 97%\"/>");
	fieldname3.push("<div align=\"center\">占地位置</div>");
	fieldname3.push("<input type=\"text\" class=\"noborder\" name=\"zdwz_" + num + "\" id=\"zdwz_" + num + "\" style=\"width: 97%\"/>");
	fieldname3.push("<input type=\"text\" class=\"noborder\" name=\"ywguid_" + num + "\" id=\"ywguid_" + num + "\" style=\"display:none\"/>");	
	addccft("allnum", "xcrztable", "5", fieldname3, "3");
	
	var fieldname4 = new Array();
	fieldname4.push("<div align=\"center\">镇(办事处)</div>");
	fieldname4.push("<input type=\"text\" class=\"noborder\" name=\"townname_" + num + "\" id=\"townname_" + num + "\" style=\"width: 97%\"/>");
	fieldname4.push("<div align=\"center\">村辖区</div>");
	fieldname4.push("<input type=\"text\" class=\"noborder\" name=\"countyname_" + num + "\" id=\"countyname_" + num + "\" style=\"width: 97%\"/>");	
	addccft("allnum", "xcrztable", "5", fieldname4, "4");
	
	var fieldname5 = new Array();
	fieldname5.push("<div align=\"center\">抄告单状态</div>");
	fieldname5.push("<div id=\"divcgd_"+num+"\"><span style=\"color:red\">抄告单未生成</span>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"javascript:void(0);\" id=\"cgd_"+num+"\" onclick=\"createCgd(this.id,0)\" style=\"text-decoration:none\">生成抄告单</a><input type=\"hidden\" name=\"cgdqk_"+num+"\" id=\"cgdqk_"+num+"\" value=\"0\"></div>");
	addccft("allnum", "xcrztable", "5", fieldname5, "5");
}
//创建抄告单
function buildcgd(){
	


}


function deletecgd(){
	var name = new Array("check", "jsxm", "jsdw", "dgsj", "jsqk", "zdmj", "zdwz","townname","countyname","divcgd");
	deleteccjl("allnum", "xcrztable", "4", name);
}

function deleteccjl(allnum, tablename, number, name){
	var recordnum = document.getElementById(allnum);
	var num = String(parseInt(recordnum.value)/5);
	var deletetable = document.getElementById(tablename);
	for(var i = 1; i <= num; i++){
		var isdelete = document.getElementById(name[0]+ "_" + String(i));
		if(isdelete.checked){
			for(var j = i; j < num; j++){
				replacevalue(j + 1, j, name);
			}
			deletetable.deleteRow(parseInt(recordnum.value) + parseInt(number));
			deletetable.deleteRow(parseInt(recordnum.value) + parseInt(number) - 1);
			deletetable.deleteRow(parseInt(recordnum.value) + parseInt(number) - 2);
			deletetable.deleteRow(parseInt(recordnum.value) + parseInt(number) - 3);
			deletetable.deleteRow(parseInt(recordnum.value) + parseInt(number) - 4);			
			recordnum.value = String(parseInt(recordnum.value) - 5);
			num = String(parseInt(recordnum.value)/5);
			i--;
		}
	}
}

function replacevalue(newnum , oldnum, name){
	var oldfieldcheck = document.getElementById(name[0] + "_" +String(oldnum));
	var newfieldcheck = document.getElementById(name[0] + "_" + String(newnum));
	oldfieldcheck.checked = newfieldcheck.checked;
	for(i = 1 ; i < name.length; i++){
		var fieldname = name[i];
		var oldfieldname = document.getElementById(fieldname + "_"+ oldnum);
		var newfieldname = document.getElementById(fieldname + "_" +newnum);
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
				newCell.rowSpan = "5";
			}
		}else if(style == "5"){
			var newCell = newRow.insertCell(i);
			newCell.innerHTML = newfield[i];
			if(i == newfield.length-1){
				newCell.colSpan = "3";
				newCell.align = "center";
			}
		}else{
			var newCell = newRow.insertCell(i);
			newCell.innerHTML = newfield[i];
		}
	}
}