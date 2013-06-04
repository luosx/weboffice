<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.gisapp.components.gpsstatusmonitor.GpsStatusUtil"%>
<%@page import="com.klspta.common.util.GpsDataSort" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	GpsStatusUtil gsu = GpsStatusUtil.getInstance();
	//Extent extent = su.getExtentByCoordinates(ilo.getAllLocation());
	GpsDataSort eds = new GpsDataSort();
	String combodate = eds.getComboData(gsu.getGpsType());	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>analysis</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/common/include/ext.jspf" %>
		<%@ include file="/gisapp/arcgis/esri.jspf" %>
						<script type="text/javascript"
			src="<%=basePath%>/gisapp/pages/components/gps/statusMonitor/statusListTab.js"></script>
   <style type="text/css">
    html,body {
	    font: normal 12px verdana;
	    margin: 0;
	    padding: 0;
	    border: 0 none;
	    overflow: hidden;
	    height: 100%;
    }
   </style>
   <script>
    var basePath="<%=basePath%>";
   var win;
   var dataForm;
   var form;
   var todayDate = new Date();
   var showMileageForm;
   var showMileageWin;
   Ext.onReady(function(){
   	Ext.QuickTips.init();

	var store=new parent.Ext.data.JsonStore({
			data:[{name:'全部',value:'all',no:[{no:"全部",value:"all"}]},<%=combodate%>],
			fields:["name","value","no"]
											});
	
	var nostore=new parent.Ext.data.JsonStore({
			data:[],fields:["no","value"]
											});
		
	var combo=new parent.Ext.form.ComboBox({
										emptyText:"==请选择设备类型==",
										fieldLabel:"类型",
										id:'type',
										width:150,
										store:store,
										displayField:"name",
										valueField:"value",
										mode:"local",
										triggerAction:"all",
										listeners:{
													"select":function(combo,record,index){
																							//alert(combo.getValue());
																							nocombo.clearValue();
																							nostore.loadData(record.data.no);
																						  }
												  }
								  });                        

	var nocombo=new parent.Ext.form.ComboBox({
											emptyText:"==请选择设备编号==",
											fieldLabel:"编号",
											id:'no',
											width:150,
											store:nostore,
											displayField:"no",
											valueField:"value",
											mode:"local",
											triggerAction:"all",
											listeners:{
														"select":function(combo,record,index){
																								//alert(combo.getValue());
													   										 }
													   }
									  });	
	

	 form = new parent.Ext.form.FormPanel({
		region:'north',
        labelAlign: 'right',
        labelWidth: 40,
        buttonAlign: 'center',
        title: 'form',
		header:false,
        frame:true,
        autoWidth: true,
		autoHeight: true,
        //url: '04_01_01.jsp',

        items: [{
            layout:'column',
            items: [{
                columnWidth:.22,
                layout: 'form',
                items:[combo]
            },{
                columnWidth:.22,
                layout: 'form',
                items:[nocombo]
            },{
                columnWidth:.18,
                layout: 'form',
                items:[{xtype:'datefield', fieldLabel:'日期', emptyText:'请选择开始日期', id:"begin_date", width:120, format:'Y-m-d', maxValue:todayDate}]
            },{
                columnWidth:.195,
                layout: 'form',
                items:[{xtype:'datefield', fieldLabel:'至', labelSeparator:'', emptyText:'请选择结束日期', labelStyle:'width:30px', id:"end_date", width:120, format:'Y-m-d',maxValue:todayDate, 
                		listeners:{'focus':function(){parent.Ext.getCmp("end_date").setMinValue(parent.Ext.getCmp("begin_date").getValue());}}}]
            },{
				columnWidth:.16,
				layout: 'form',
				items:[{xtype:'button', text:'查询', id:'query', width:60,
					    handler: function() {
												var type = parent.Ext.getCmp("type").getValue();
												var no = parent.Ext.getCmp("no").getValue();
												var begin_date="";
												var end_date="";
												if(parent.Ext.getCmp("begin_date").getValue()!=""){
													begin_date = parent.Ext.getCmp("begin_date").getValue().format('Y-m-d');
												}
												if(parent.Ext.getCmp("end_date").getValue()!=""){
													end_date = parent.Ext.getCmp("end_date").getValue().format('Y-mm-d');
												}
												//Ext.Msg.alert('信息',type);
												var url = 'data.jsp?type='+type+'&no='+no+'&begin_date='+begin_date+'&end_date='+end_date;
												url = encodeURI(url);
												url = encodeURI(url);
												parent.frames['ifr'].location = url;
            								}
						}]
			}]
        }]
    });
  
    dataForm = new parent.Ext.form.FormPanel({
    	region:'center',
    	frame:true,
    	html:"<iframe id='ifr' name='ifr' width=100% height=100%></iframe>"
    }); 
    
    dataForm = new parent.Ext.form.FormPanel({
    	region:'center',
    	frame:true,
    	html:"<iframe id='ifr' name='ifr' width=100% height=100%></iframe>"
    }); 
      
    var tabs = new Ext.TabPanel({
        renderTo:'statusTab',
        activeTab: 0,     
        frame:true,
        items:[{
                title: '巡查车',
                html: "<iframe style='height:700px' src='statusList.jsp?type=1'/>"
            },{
                title: 'PDA',
                html: "<iframe style='height:700px' src='statusList.jsp?type=2'/>"
            },{
                title: '平板电脑',
                html: "<iframe style='height:700px' src='statusList.jsp?type=3'/>"
            }
        ]
    })
  });
  
    //运行统计
  function statistics(){
	if(!win){
	   win = new parent.Ext.Window({
	  		title:'运行统计',
	  		id:'win',
	  		closeAction:'close',
			frame:true,
			modal: false,
			resizable: false,
			width: 1000,
			height: 450,
			layout:'border',
			items:[dataForm,form],
			listeners:{"close":function(){window.location.reload();}}
	  	});
	 } 	
	 win.show();	 	   	  	
   }
   //统计里程
   function MileageStatistics1(){
      if(!showMileageWin){
         showMileageWin = new parent.Ext.Window({
                layout:'border',
                title:'里程统计',
                width:280,
                height:240,
                modal: false,
			    resizable: false,
                closeAction:'hide',
				items:dataForm
         }); 
       }
       showMileageWin.show();
   }
   </script>
  </head>
	<body bgcolor="#FFFFFF">
	    <div style="width:300px; height:30px; background-color:#C4E1FF;padding-left:40px;">
	       <br>
	       <input type="button" value="清除地图车辆" style="width:100px;border:1px #ccc solid;cursor:hand" onclick="clearCar()" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	     
	       <input type="button" value="车辆里程统计" style="width:100px;border:1px #ccc solid;cursor:hand" onclick="MileageStatistics()" ><br><br>
	       <input id="showInfo" type="button" value="显示车辆信息" style="width:100px;border:1px #ccc solid;cursor:hand" disabled="true" onclick="checkInfo()" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	       <input id="showAll" type="button" value="车辆全局监控" style="width:100px;border:1px #ccc solid;cursor:hand" onclick="overview()" >
	       <br><br>
	    </div>
		<div id="statusTab" style="width:300px;"></div>
		<div id="graphwin" class="x-hidden">
			<div id="updateForm" style="margin-left:10px; margin-top:5px"></div>
		</div>	
	</body>
</html>
