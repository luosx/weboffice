function showTable() {
	if (document.getElementById('table1').checked) {
		document.getElementById('kftl').style.display = '';
	} else {
		document.getElementById('kftl').style.display = 'none';
	}
	if (document.getElementById('table2').checked) {
		document.getElementById('azfjs').style.display = '';
	} else {
		document.getElementById('azfjs').style.display = 'none';
	}
	if (document.getElementById('table3').checked) {
		document.getElementById('gdtl').style.display = '';
	} else {
		document.getElementById('gdtl').style.display = 'none';
	}
	if (document.getElementById('table4').checked) {
		document.getElementById('trzqk').style.display = '';
	} else {
		document.getElementById('trzqk').style.display = 'none';
	}
}

function showCross() {
	if (document.getElementById('table5').checked) {
		document.getElementById('leftright').style.display = '';
		document.getElementById('topdown').style.display = '';
	} else {
		document.getElementById('leftright').style.display = 'none';
		document.getElementById('topdown').style.display = 'none';
	}
}

var preParentColor;
var preColor;
function overEvent() {
	var object = window.event.srcElement;
	preParentColor = object.parentElement.style.background;
	//preColor = object.style.background;
	object.parentElement.style.background = "#00C5CD";
	//object.style.background = "#76EE00";
}
function outEvent() {
	var object = window.event.srcElement;
	//object.style.background = preColor;
	object.parentElement.style.background = preParentColor;
}

// 给各个项目添加上点击事件
function addEvent() {
	//开发体量
	var kftl = document.getElementById("kftl");
	if (kftl.children.length > 4) {
		for (var i = 0; i < (kftl.children.length - 4) / 8; i++) {
			kftl.children[(8 * i + 4)].cells[2].addEventListener("click",
					function() {
						var object=window.event.srcElement;
						window.open("kftl/kftlmodel.jsp?xmmc="+object.innerText);
					});
		}
	}
	//azfjs
	var azfjs = document.getElementById("azfjs");
	if (azfjs.children.length > 4) {
		for (var i = 0; i < (azfjs.children.length - 4) / 8; i++) {
			azfjs.children[(8 * i + 4)].cells[2].addEventListener("click",
					function() {
						alert(2);
					});
		}
	}
	//gdtl
	var gdtl = document.getElementById("gdtl");
	if (gdtl.children.length > 4) {
		for (var i = 0; i < (gdtl.children.length - 4) / 6; i++) {
			gdtl.children[(6 * i + 4)].cells[2].addEventListener("click",
					function() {
						var object=window.event.srcElement;
						window.open("gdtl/gdtl.jsp?xmmc="+object.innerText);
					});
		}
	}
	//trzqk
	var trzqk = document.getElementById("trzqk");
	if (trzqk.children.length > 4) {
		for (var i = 0; i < (trzqk.children.length - 4) / 8; i++) {
			trzqk.children[(8 * i + 4)].cells[2].addEventListener("click",
					function() {
						alert(4);
					});
		}
	}
}
