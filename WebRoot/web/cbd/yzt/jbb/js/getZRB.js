//打开自然斑选择框
function getZRB(id,check){
   	win = new Ext.Window({
	    layout: 'fit',
	    title: '请选择人员列表',
	    closeAction: 'hide',
	    width:600,
	    height:440,
	    x: 40,
	    y: 110,
	    items:winForm
	});
   	win.show();
}

function toRecord(obj, num){
	//alert(obj.record.data.DKMC);
	dkmc = obj.record.data.DKMC;
}