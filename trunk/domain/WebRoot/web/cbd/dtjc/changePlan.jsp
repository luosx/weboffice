<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.web.cbd.hxxm.jdjh.JhHandler" %>
<%@page import="com.klspta.web.cbd.hxxm.jdjh.DataManager"%>
<%@page import="com.klspta.web.cbd.dtjc.TjbbManager"%>
<%@page import="com.klspta.web.cbd.dtjc.TjbbBuild"%>
<%@page import="com.klspta.web.cbd.dtjc.TjbbData"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
String userId = ((User)principal).getUserID();
String extPath = basePath + "base/thirdres/ext/";
Map planYear = DataManager.getInstance().getPlanYear();
Map<String, String> proMap = TjbbManager.getProjectByUserId(userId);
int width = Integer.parseInt(String.valueOf(planYear.get("maxyear"))) - Integer.parseInt(String.valueOf(planYear.get("minyear")));
width = width * 1200 + 490;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>实施计划编辑页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf"%>
	<script type="text/javascript" src="web/cbd/dtjc/js/modify.js"></script>
	<script type="text/javascript" src="web/cbd/dtjc/js/changePlan.js"></script>
	<script type="text/javascript" src="web/cbd/dtjc/js/planStack.js"></script>
	<script type="text/javascript" src="web/cbd/dtjc/js/movePlan.js"></script>
	<script type="text/javascript" src="<%=extPath%>examples/ux/MultiSelect.js"></script>
	<script type="text/javascript" src="<%=extPath%>examples/ux/ItemSelector.js"></script>
 	<link rel="stylesheet" type="text/css" href="<%=extPath%>examples/ux/css/MultiSelect.css"/>
	<style type="text/css">
		table{
			border-left:1px #000000 solid;
			border-top:1px #000000 solid;
			border-color:#E2EAF3;
		}
		td{
			border-right:1px #000000 solid;
			border-color:#E2EAF3;
			cursor:hand;
			}
		tr{
			height:30px;
			
		}
		.no{
			border-right:0px #000000 solid;
			width:50px;
		}
		.yes{
			border-right:0px #000000 solid;
			background-color:#66FF00;
			width:50px;
		}
		.divstyle{
			width:80px;
			height:30px;
			left:0px;
			top:0px;
			position:absolute;
			background-color:#E2EAF3;
			filter:alpha(opacity=90);
		}
		.showDetail{
			font-size:12px;
			width:300px;
			height:200px;
			left:100px;
			top:100px;
			position:absolute;
			background-color:#E2EAF3;
			filter:alpha(opacity=90);
		}
		.planDetail{
			width:300px;
			height:200px;
			right:5px;
			top:5px;
			position:absolute;
			background-color:#E2EAF3;
		}
		.spring{
			background-color:#0BF72C;
		}
		.summer{
			background-color:#F3FB1E;
		}
		.fall{
			background-color:#231EFB
		}
		.winter{
			background-color:#5B0985
		}
		.kftltr{
			border-bottom:1px #0C1289 solid;
		}
		#deal{
		  position: absolute;
		  top:30;
		  right: 0;
		}
		.changeProject{
		  position: absolute;
		  top:0;
		  right: 100;
		  background-color:#E2EAF3;
		}
		.form{
		  position: absolute;
		  top:50;
		  left: 200;
		  background-color:#E2EAF3;
		}
	</style>
  </head>
  <script type="text/javascript" >
  		

	  		//记录位置
		var row = 0;
		var cell = 0;
		var step = 1;
		var positionX = 0;
		var positionY = 0;
		var divName = "showDiv";
		var minyear = "<%=TjbbBuild.MIN_YEAR%>";		
		var kftlNum = "<%=TjbbManager.getxmNumByUserId(userId)%>";
		
		
		//修改项目列表
		Ext.onReady(function() {
    		Ext.QuickTips.init();
    		
       		var leftDs = new Ext.data.ArrayStore({
		        data: <%=proMap.get("left")%>,
		        fields: ['value','text'],
		        sortInfo: {
		            field: 'value',
		            direction: 'ASC'
		        }
		    }); 
		    var rightDs = new Ext.data.ArrayStore({
		        data: <%=proMap.get("right")%>,
		        fields: ['value','text'],
		        sortInfo: {
		            field: 'value',
		            direction: 'ASC'
		        }
		    });       	
		    	
			winForm = new Ext.form.FormPanel({
		        url:'<%=basePath%>service/rest/tjbbManager/setProjectsByUser?userId=<%=userId%>',
		        bodyStyle: 'padding:10px;',
		        renderTo: 'itemselector',
		        title: '请选择项目和年度',
        		width:550,
        		bodyStyle: 'padding:10px;',
	        	items:[
	        		new Ext.ux.form.SpinnerField({
                		fieldLabel: '开始年度',
                		name: 'beginYear',
                		id:'beginYear',
       					value:'2013',
       					width:'100'
            		}),
            		new Ext.ux.form.SpinnerField({
                		fieldLabel: '结束年度',
                		name: 'endYear',
                		id:'endYear',
                		value:'2017',
                		width:'100'
            		}),
            		{
            			xtype: 'itemselector',
            			name: 'itemselector',
            			imagePath: '<%=extPath%>examples/ux/images/',
            			fieldLabel: '项目列表',
            			multiselects:[
            				{
			                  width: 180,
			                  height: 245,
			                  store: leftDs,
			                  displayField: 'text',
			                  valueField: 'value'
			           		},{
			           		  width: 180,
				              height: 200,
				              store: rightDs,
				              displayField: 'text',
			                  valueField: 'value',	
			                  tbar:[{
			                  	text: '清空已选项目',
			                  	handler:function(){
			                  		winForm.getForm().findField('itemselector').reset();
			                  	}
			                  }]
			           		}	
            			]
            		
            		}
	        	],
	        	buttons: [{
	        		text: '保存',
	        		handler: function(){
	        			if(winForm.getForm().isValid()){
	        				var itemselector = winForm.form.findField('itemselector').getValue();
	        				var beginYear=Ext.getCmp('beginYear').getValue();
	        				var endYear=Ext.getCmp('endYear').getValue();
     				       	putClientCommond("tjbbManager","setProjectsByUserId");
			           	   	putRestParameter("beginYear",beginYear);
			           	   	putRestParameter("endYear",endYear);
			           	   	putRestParameter("userId","<%=userId%>");
       						putRestParameter("itemselector",escape(escape(itemselector)));
				           	var myData = restRequest(); 
	        				document.getElementById("itemselector").style.display = "none";
	        				window.location.reload();	
	        			}
	        		}
	        	},{
 			        text: '取消',
	        		handler: function(){
	        			if(winForm.getForm().isValid()){
	        				document.getElementById("itemselector").style.display = "none";
	        			}
	        		}
	        	}
	        	]
	        })
	        //changeProject();
	        //winForm.hide();
	        
	    });
	    
	    function changeProject(){
	    	document.getElementById("itemselector").style.display = "";
	    	
	    }
	    
	    
	    		
		//添加键盘快捷键
		document.onkeydown = function(ev){
			var oevent = ev || event;
			//按住Ctrl + Z键
			if(oevent.ctrlKey && oevent.keyCode == 90){
				callback();
			
			}else if(oevent.ctrlKey && oevent.keyCode == 37){
				//按Ctrl + 向左键 向左移动一年
			
			
			}else if(oevent.ctrlKey && oevent.keyCode == 39){
			
			}else if(oevent.keyCode == 37){
			//按住向左键
			
			}else if(oevent.keyCode == 39){
			//按住向右键
			
			}
		}


  </script>
  <body>
  	<div id="showDiv" class="divstyle" style="display:none; width:50px;" onDblClick="showDetail(); return false;">
  	  <table  style="width:50px; height:30px;" cellpadding="0px" cellspacing="0px" >
	  	<!--
	  	<tr>
			<td colspan="2" align="right">
				<label style="color:#FF0000" onClick="hiddleDiv(); return false;"> X </label>&nbsp;&nbsp;
			</td>
		</tr>
	  	<tr>
			<td colspan="2" align="center">
				<input type="button" value="查看详细" onClick="showDetail(); return false;">
			</td>
		</tr>
		-->
		<tr>
			<td align="center" bordercolor="">
				<label onClick="moveLeft(); return false;"><</label>
			</td>
			<td align="center">
				<label onClick="moveRight(); return false;">></label>
			</td>
		</tr>
	  </table>
  	</div>
	<div id="body" style=" overflow-x:scroll; height:100%;">
				<%=TjbbManager.getPlan(userId)%>
	</div>
	<div id="changeProject" class="changeProject">
		<input type="button" value="修改项目和时间" onClick="changeProject(); return false" />
	</div>
	<div id="itemselector" class="form" style="display:none"></div>
	<div id="deal"></div>
  </body>
  <script type="text/javascript">
  		document.getElementById("body").style.width = document.body.clientWidth - 400;
  </script>
</html>
