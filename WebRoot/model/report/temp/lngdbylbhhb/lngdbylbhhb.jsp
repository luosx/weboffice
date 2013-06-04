<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.util.Map.Entry" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String extPath = basePath + "ext/";
StringBuffer sb_parameter = new StringBuffer();
Map maps=request.getParameterMap();
String isHaveChart = request.getParameter("isHaveChart");
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
    
    <title>My JSP 'query.jsp' starting page</title>
    
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
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <script type="text/javascript">
  <%
Date d = new Date();
int year = d.getYear()+1900;
StringBuffer sb = new StringBuffer();
sb.append("[{text:'',value:''},");
for(int i=year;i>1984;i--){
	sb.append("{text:'" + i + "',value:'" + i +"'}");
	if(i>1985){
		sb.append(",");
	}
}
sb.append("]");
String data = sb.toString();
%>	
	
    var form;
  	Ext.onReady(function(){
  		Ext.QuickTips.init();
  		
  		var yearStore = new Ext.data.JsonStore({
		data: <%=data%>,
		fields: ["text","value"]
	});
	
  		var canStore = new Ext.data.JsonStore({
        fields:["name","value","no"],
        data : [{name:'全部',value:'0',no:[{no:"全部",value:"0"}]},{name:'扬州',value:'1',no:[]},{name:'江都',value:'2',no:[]},{name:'仪征',value:'3',no:[]}]
    });
    
    	var store= new Ext.data.JsonStore({
			data:[],
			fields:["no","value"]
											});
  		var starttimes=new Ext.form.ComboBox({
										emptyText:"==请选择==",
										fieldLabel:"起始时间",
										id:'starttime',
										width:120,
										store:yearStore,
										displayField:"text",
										valueField:"value",
										mode:"local",
										triggerAction:"all",
										listeners:{
													"select":function(combo,record,index){
																						  }
												  }
								  });                        

		var endtimes=new Ext.form.ComboBox({
											emptyText:"==请选择==",
											fieldLabel:"截止时间",
											id:'endtime',
											width:120,
											store:yearStore,
											displayField:"text",
											valueField:"value",
											mode:"local",
											triggerAction:"all",
											listeners:{
														"select":function(combo,record,index){
																								
													   										 }
													   }
									  });	
									  
		form = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 55,
        height: 35,
        buttonAlign: 'center',
        title: 'form',
		header:false,
        frame:true,
        autoWidth: true,
		autoHeight: true,
        items: [{
            layout:'column',
            items: [{
                columnWidth:.20,
                layout: 'form',
                items:[starttimes]
            },{
                columnWidth:.20,
                layout: 'form',
                items:[endtimes]
            },{
				columnWidth:.06,
				layout: 'form',
				items:[{xtype:'button', text:'查询', icon:'<%=basePath%>base/gis/images/find.png', id:'query', width:50,
					    handler: function() {
											 var parmeters = "";
											 var starttime = Ext.getCmp("starttime").getValue();
											 var endtime = Ext.getCmp("endtime").getValue();
											 if(starttime!=""){
											 	parmeters += "&starttime="+starttime; 
											 }else{
											 	starttime += "&starttime=1949";
											 }
											 
											 if(endtime!=""){
											 	parmeters += "&endtime="+endtime; 
											 }else{
											 	parmeters += "&endtime=<%=year%>"; 
											 }          
											 mid_src = document.getElementById("ifr").src;										 	 
										 	 var i = mid_src.indexOf("?");
											 if(i!=-1){		
												 mid_src = mid_src.substring(0,i+1);
												 mid_src = mid_src+"<%=sb_parameter.toString()%>"+parmeters;
												 //Ext.Msg.alert('信息',mid_src);
												 document.getElementById("ifr").src = mid_src;								
											 }
            								}}]
			},{
					xtype: "button",
					text: "图表",
					width: 50,
					handler: function(){
						var win = frames[0].Ext.getCmp("win");
						if(win.hidden){
							win.show();
						}else{
							win.hide();
						}
					}
				}]
        }]
    });									  
  	form.render("container");
  	})
  	
  </script>
  <body>
  <div id="container"></div>
  </body>
</html>
