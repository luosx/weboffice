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