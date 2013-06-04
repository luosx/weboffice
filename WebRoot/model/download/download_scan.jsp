<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String extPath = basePath + "base/thirdres/ext/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title></title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script src="<%=extPath%>adapter/ext/ext-base.js"
			type="text/javascript"></script>
		<script src="<%=extPath%>ext-all.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css"
			href="<%=extPath%>resources/css/ext-all.css" />
		<script type="text/javascript"
			src="<%=extPath%>/src/locale/ext-lang-zh_CN.js"></script>		
	</head>
<script type="text/javascript">

Ext.onReady(function(){ 
	Ext.QuickTips.init();
	
	var comboData=[{
			text:"全部",value:"all",sub:[{text:"包含",value:"in"},{text:"匹配",value:"equal"}]
		},{
			text:"标题",value:"KC02",sub:[{text:"包含",value:"in"},{text:"匹配",value:"equal"}]
		},{
			text:"上传者",value:"KC03",sub:[{text:"包含",value:"in"},{text:"匹配",value:"equal"}]
		},{
			text:"日期",value:"KC04",sub:[{text:"之前",value:"before"},{text:"之后",value:"after"},{text:"当前",value:"equal"}]
		},{
			text:"类别",value:"KC05",sub:[{text:"包含",value:"in"},{text:"匹配",value:"equal"}]
		},{
			text:"上传部门",value:"KC06",sub:[{text:"包含",value:"in"},{text:"匹配",value:"equal"}]
		}];
	
	
	var store=new Ext.data.JsonStore({
		data: comboData,
		fields:["text","value","sub"]
	});
	
	var substore=new Ext.data.JsonStore({
		data:[],
		fields:["text","value"]
	});
	
	
	var combo=new Ext.form.ComboBox({
		emptyText: "查询类别",
		id:'type',
		width:80,
		store:store,
		displayField:"text",
		valueField:"value",
		mode:"local",
		triggerAction:"all",
		listeners:{
			"select":function(combo,record,index){
				subcombo.clearValue();
				substore.loadData(record.data.sub);
			}
		}
	});                        

	var subcombo=new Ext.form.ComboBox({
		emptyText:"查询条件",
		id:'condition',
		width:80,
		store:substore,
		displayField:"text",
		valueField:"value",
		mode:"local",
		triggerAction:"all"
	});	
	
	
	
	
	
	
	
	 var form = new Ext.form.FormPanel({
		region:'north',
        labelAlign: 'right',
        labelWidth: 1,
        buttonAlign: 'center',
        title: '下载浏览',
		header:false,
        frame:true,
		height: 35,

        items: [{
            layout:'column',
            items: [{
                columnWidth:.1,
                layout: 'form',
                items:[combo]
            },{
                columnWidth:.1,
                layout: 'form',
                items:[subcombo]
            },{
                columnWidth:.2,
                layout: 'form',
                items:[{xtype:'textfield', id:"content", emptyText:"查询内容", width:140}]
            },{
				columnWidth:.1,
				layout: 'form',
				items:[{xtype:'button', text:'查询', id:'query', width:60,
					    handler: function() {
												var type = Ext.getCmp("type").getValue();
												var content = Ext.getCmp("content").getValue();
												var condition = Ext.getCmp("condition").getValue();
												//Ext.Msg.alert('信息',type);
												//Ext.Msg.alert('信息',no);
												//Ext.Msg.alert('信息',begin_date);
												//Ext.Msg.alert('信息',end_date);
												document.getElementById("ifr").src = "model/download/queryData.jsp?type="+type+"&content="+content+"&condition="+condition;

            								}
						}]
			}]
        }]
    });
	
    dataForm = new Ext.form.FormPanel({
    	region: 'center',
    	frame: true,
    	html: "<iframe id='ifr' name='ifr' width=100% height=100% src='model/download/queryData.jsp?type=&content=&condition='></iframe>"
    }); 
	
	var viewport = new Ext.Viewport({
		layout:'border',
		items:[dataForm]
	});
	
});


</script>
<body>
</body>
</html>
