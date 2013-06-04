<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.util.Map.Entry" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String extPath = basePath + "thirdres/ext/";
StringBuffer sb_parameter = new StringBuffer();
Map maps=request.getParameterMap();
Iterator its = maps.entrySet().iterator();
while (its.hasNext()){
    Entry entry =(Entry)(its.next());
    String id=entry.getKey().toString().trim();
    String value=new String(request.getParameter(id).trim().getBytes("ISO-8859-1"),"utf-8");
    int i = value.indexOf("\"");
    if(i!=-1){
    	int a = value.indexOf("\"",i+1);
    	value = value.substring(i+1,a);
    }
    sb_parameter.append(id+"="+value);
  	if(its.hasNext()){
  		sb_parameter.append("&");
  	}
}
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
 		<script src="<%=basePath%>/common/js/json2String.js"></script>
	</head>
  
<body>
<script type="text/javascript">
<%
Date d = new Date();
int year = d.getYear()+1900;
StringBuffer sb = new StringBuffer();
sb.append("[");
for(int i=year;i>1948;i--){
	sb.append("{text:'" + i + "',value:'" + i +"'}");
	if(i>1949){
		sb.append(",");
	}
}
sb.append("]");
String data = sb.toString();
%>	
	
Ext.onReady(function(){ 
	Ext.QuickTips.init();
	
	var yearStore = new Ext.data.JsonStore({
		data: <%=data%>,
		fields: ["text","value"]
	});
	
	var beginyearCombo = new Ext.form.ComboBox({
		emptyText:"请选择年份",
		fieldLabel:'起始时间',
		id:'begin_year',
		width:150,
		store:yearStore,
		displayField:"text",
		valueField:"value",
		mode:"local",
		triggerAction:"all"
	});

	var endyearCombo = new Ext.form.ComboBox({
		emptyText:"请选择年份",
		fieldLabel:'截止时间',
		id:'end_year',
		width:150,
		store:yearStore,
		displayField:"text",
		valueField:"value",
		mode:"local",
		triggerAction:"all"
	});

	 var form = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 55,
         height: 35,
        buttonAlign: 'center',
        title: 'form',
		header:false,
        frame:true,
        autoWidth: true,
        url:"<%=basePath%>formOperationAC.do",

        items: [{
            layout:'column',
            items: [{
                columnWidth:.2,
                layout: 'form',
                items:[{xtype: 'combo',
                		id: 'KC02',
		                mode: 'local',
                		triggerAction:  'all',
                		forceSelection: true,
                		fieldLabel: '政区',
                		displayField:   'text',
               			valueField:     'value',
               			emptyText: '请选择行政区',
                		store:  new Ext.data.JsonStore({
                    									fields : ['text', 'value'],
                    									data   : [
                        											{text:'全部',value:''}
                   												 ]
               											})
                	  }]
            },{
                columnWidth:.19,
                layout: 'form',
                items:[beginyearCombo]
            },{
                columnWidth:.19,
                layout: 'form',
                items:[endyearCombo]
            },{
				columnWidth:.05,
				layout: 'form',
				items:[{xtype:'button', text:'查询',icon:'<%=basePath%>common/pages/report/img/find.png',
					    handler: function() {
											 var str = Ext.getCmp("KC02").getValue();
											 str = encodeURIComponent(encodeURIComponent(Ext.encode(str)));
											 var parmeters = "";
											 var begin_year = Ext.getCmp("begin_year").getValue();
											 var end_year = Ext.getCmp("end_year").getValue();
                							 //Ext.Msg.alert('信息',str);
                							 											 
											 if(begin_year!=""){
											 	parmeters += "&begin_year="+begin_year; 
											 }else{
											 	parmeters += "&begin_year=1949";
											 }
											 
											 if(end_year!=""){
											 	parmeters += "&end_year="+end_year; 
											 }else{
											 	parmeters += "&end_year=<%=year%>"; 
											 }            																	 											 
											 if(str!="%2522%2522"){
										 		parmeters += "&MC=" + str;
										 	 }
											 mid_src = document.getElementById("ifr").src;										 	 
										 	 var i = mid_src.indexOf("?");
											 if(i!=-1){		
												 mid_src = mid_src.substring(0,i+1);
												 mid_src = mid_src+"<%=sb_parameter.toString()%>"+parmeters;
												 //Ext.Msg.alert('信息',mid_src);
												 document.getElementById("ifr").src = mid_src;								
											 }
            								}
						}]
			}]
        }]
    });

	form.render("container");
});
</script>
<div id='container'></div>
</body>
</html>