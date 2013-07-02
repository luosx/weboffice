<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.web.xuzhouWW.TaskList"%>
<%@ taglib uri="/WEB-INF/taglib/queryLabel.tld" prefix="common"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    String extPath = basePath + "ext/";
    TaskList taskList=new TaskList();
    String rows=taskList.getWptbList("320111");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>2011年度卫片执法检查统计汇总表</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
        <%@ include file="/base/include/ext.jspf"%>
		<script src="<%=basePath%>/base/include/ajax.js"></script>
	    
	    <style type="text/css">
	    html,body {
	        margin: 0;
	        padding: 0;
	        margin-right: 1;
	        height: 100%;
	        background-color: #FFFFFF;
	        font: normal 15px verdana;
	    }

	    .los {
	        width: 100%;
	        height: 30px;
	        line-height:30px;
	        background-image: url('images/left/left_bg.PNG');
	    }
	    </style>
	    
		<script type="text/javascript">
		var myData;
		var grid;
Ext.onReady(function(){
	myData= <%=rows%>;//采用json格式存储的数组
    // create the data store
    var store = new Ext.data.ArrayStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: '图斑编号'},
           {name: '政区名称'},
           {name: '用地单位'},
           {name: '用地时间'},
           {name: '建设情况'},
           {name: '违法类型'},
           {name: '监测面积'},
           {name: '农用地'},
           {name: '其中耕地'},
           {name: '建设用地'},
           {name: '未利用地'},
           {name: '符合规划（允许建设区）'},
           {name: '其中现状建设用地'},
           {name: '其中新增建设用地'},
           {name: '不符合规划'},
           {name: '其中有条件建设区'},
           {name: '其中限制建设区'},
           {name: '其中禁止建设区'},
           {name: '其中基本农田'}
        ]
    });

        var group = new Ext.ux.grid.ColumnHeaderGroup({
        rows: [
		[{header: '图斑属性', colspan: 7, align: 'center'},
        {header: '现状压盖分析', colspan: 4, align: 'center'},
        {header: '规划压盖分析', colspan: 8, align: 'center'}
        ]
        ]
    });
    
    var	comboData = [{key:'aa',value:'bb'},
    {key:'aa',value:'bb'}];
    //comboData=eval(comboData);
    var comboStore= new Ext.data.JsonStore({
		  data: comboData,
		  fields:['key','value']
	});
    var Combo = new Ext.form.ComboBox({
			id:'Combo',
			store: comboStore,
			displayField:'key',
	        valueField: 'value',
			editable:false,
			typeAhead: true,
			mode:'local',
			width:120,
		    forceSelection: true,
		    triggerAction: 'all',
			selectOnFocus:true,
			listeners:{
				   'select':function(){ 
			        temp = Ext.getCmp("Combo").getValue();
			}}
	});
    store.load({params:{start:0, limit:100}});
    var width=document.body.clientWidth;
    var height=document.body.clientHeight;
        grid = new Ext.grid.GridPanel({
        store: store,
        columns: [
            {header: '编号', width: width*0.06, sortable: true},
            {header: '政区', width: width*0.06, sortable: true},
            {header: '用地单位', width: width*0.12, sortable: true},
            {header: '用地时间', width: width*0.1, sortable: true},
            {header: '建设情况', width: width*0.1, sortable: true},
            {header: '违法类型', width: width*0.1, sortable: true},
            {header: '面积', width: width*0.1, sortable: true},
            {header: '农用地', width: width*0.1, sortable: true},
            {header: '<font color=red>其中耕地</font>', width: width*0.1, sortable: false},
            {header: '建设用地', width: width*0.1, sortable: true},
            {header: '未利用地', width: width*0.1, sortable: true},
            {header: '符合规划<br>(允许建设区)', width: width*0.14, sortable: true},
            {header: '其中现状<br>建设用地', width: width*0.12, sortable: true},
            {header: '其中新增<br>建设用地', width: width*0.1, sortable: true},
            {header: '不符合规划', width: width*0.12, sortable: true},
            {header: '其中<br>有条件建设区', width: width*0.14, sortable: false},
            {header: '其中<br>限制建设区', width: width*0.12, sortable: true},
            {header: '其中<br>禁止建设区', width: width*0.12, sortable: true},
            {header: '<font color=red>其中<br>基本农田</font>', width: width*0.12, sortable: true}

        ],
        viewConfig: {
            forceFit: true
        },
        plugins: group,  
        stripeRows: true,
        width:1200,
        height: height*0.88,
        stateful: true,
        stateId: 'grid',
        bbar: new Ext.PagingToolbar({
        pageSize: 100,
       // buttons: [{
       //     text: '图斑匹配分析',handler:analysis 
       // }],
        store: store,
        displayInfo: true,
            displayMsg: '共{2}条，当前为：{0} - {1}条',
            emptyMsg: "无记录",
        plugins: new Ext.ux.ProgressBarPager()      
        })
    });
    
    grid.render('mygrid_container'); 
}
)


function analysis(){
   document.location.href="<%=basePath%>web/xuzhouWW/analyse/fxjg_main.jsp";
} 

function query(){
    var year=document.getElementById('year').value;
	var qx=document.getElementById('qx').value;
	var xz=document.getElementById('xz').value;
	var xzqhdm='321';//扬州政区编码321000
	if(qx!='all'){
	    xzqhdm=qx;
	}
	if(xz!='all'){
	    xzqhdm=xz;
	}
	document.location.href="<%=basePath%>supervisory/wpzfjc/pages/wpzfjc2011.jsp?xzqhdm="+xzqhdm+"&year="+year;
}
//区县下拉选中事件
function change(qx){
	var xz=document.getElementById('xz');
	//删除现有选项  第一项【全部】不删除
	var xzCount=xz.options.length;
	for(var i=1;i<xz.options.length;) 
	{ 
		xz.removeChild(xz.options[i]); 
	}
	
	if(qx.value!='all'){
		xz.disabled=false;
		//动态添加乡镇
		var xzqhs=xzqh.split('],[');
		for(var i=0;i<xzqhs.length;i++){
			var a=xzqhs[i].split(',');
			if(a[0].length!=6 && a[0].indexOf(qx.value)>=0){
				var varItem = new Option(a[1], a[0]);      
		        xz.options.add(varItem);     
			}
		}
	}
	else{
		xz.disabled=true;
	}
}
</script>
	</head>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">

		<div id="mygrid_container" style=" float:left;overflow:auto; height:470px; width:1000px"></div>
		</body>
</html>