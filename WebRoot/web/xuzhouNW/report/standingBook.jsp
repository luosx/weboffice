<%@page import="com.klspta.web.jinan.report.ReportManager"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.console.role.RoleManager"%>
<%@page import="com.klspta.console.role.Role"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    //用户信息
    Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    String userName="";
    String fullName="";
    String userID="";
    if (principal instanceof User) {
        userName =((User) principal).getUsername();
        fullName=((User)principal).getFullName();
        userID=((User)principal).getUserID();
    }else{
        userName=principal.toString();
        fullName=principal.toString();
        userID=principal.toString();
    }
    //根据用户id得到角色列表（一个用户可能有多个角色）
    List<Role> roleList = RoleManager.getInstance("NEW WITH MANAGER FACTORY!").getRoleWithUserID(userID);
    //接收后台传来的行政区划编码字符创（得到用户角色列表的行政区划）
	String Strxzqh = "";
	for(int i=0;i<roleList.size();i++){
		Strxzqh = Strxzqh + roleList.get(i).getXzqh() + ",";
	}
	String[] xzqh_array = Strxzqh.split(",");
	//处理行政区划时的标志位（默认是xian）
	String flag = "xian";
	//用于去掉数组中可能存在的重复的行政区划编码
	HashSet hs = new HashSet();
	for(int j=0;j<xzqh_array.length;j++){
		if(xzqh_array[j].equals("370100")){//如果这个用户的角色的行政区划编码有370100（济南）则将标志位修改
			flag = "jinan";
		}
		//将数组中的数据放到set中去掉重复项
		hs.add(xzqh_array[j]);
	}
	//用于ComboBox中显示该用户角色下的行政区划code，name键值对
	String sjxzqh = "";
	if(flag.equals("xian")){
		sjxzqh = UtilFactory.getXzqhUtil().getXzqhDataByCodes(hs);
	}
	if(flag.equals("jinan")){
		sjxzqh = UtilFactory.getXzqhUtil().generateOptionByList(UtilFactory.getXzqhUtil().getChildListByParentId("370100"));
	}
	//用于根据行政区划过滤显示的数据（GridPanel中显示的数据）
	String xzqhNames = UtilFactory.getXzqhUtil().getXzqhNamesByCodes(hs);
	
	boolean isShowReport=ReportManager.getInstance().getAreaStr(userID).indexOf("济南市")==-1?false:true;	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>县审核中列表</title>
		<%@ include file="/base/include/ext.jspf" %>
		<%@ include file="/base/include/restRequest.jspf" %>
		<script type="text/javascript" src="<%=basePath%>base/thirdres/ext/examples/ux/PagingMemoryProxy.js"></script>
		<script type="text/javascript" src="<%=basePath%>base/thirdres/ext/examples/ux/ProgressBarPager.js"></script>
	
		<script type="text/javascript" src="js/DatePicker.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/css/fileuploadfield.css"/>
		<style>
			input,img{vertical-align:middle;cursor:hand;}
			.area
			{
				list-style:none;
				margin-left:40px;
			
			}
			.area li
			{
				list-style:none;
				display:block;
				width:80px;
				float:left;
			}
			.area li input
			{
				margin-right:5px;
				vertical-align:middle;
			}
			.dateText
			{
			font-size:12px;
			color:#2C2B29;
			margin:0 0 0 3px;
			padding:3 0 0 3px;
			border:#999 1px solid;
			width:173px;
			height:20px;
			background:white url(<%=basePath%>base/form/DatePicker/skin/datePicker.gif) no-repeat right;
			
			}
		
		</style>
		<script type="text/javascript">
			var myData;
			var store;
			var grid;
			var test;
			var width;
			var scrWidth = screen.availWidth;
	    	var scrHeight = screen.availHeight; 
			Ext.onReady(function(){
				
				myData =<%=ReportManager.getInstance().getJsonByCondition("", "",ReportManager.getInstance().getAreaStr(userID))%>
			    store = new Ext.data.JsonStore({
				    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
			        fields: [
			           {name: 'TZID'},
			           {name: 'WFYDXMMC'},
			           {name: 'WFYDWZ'},
			           {name: 'SJTDMJ'},
			           {name: 'SFFHGH'},
			           {name: 'WFLX'},
			           {name: 'JHSJ'},    
			           {name: 'SB'},   
			           {name: 'TZID'} ,
			           {name: 'TZID'} 
			        ]
			    });
			    
			    store.load({params:{start:0, limit:10}});
			    
			    var countyStore = new Ext.data.JsonStore({
			        fields: ['code', 'name'],
			        data : <%=sjxzqh%> 
			    });
			    
			    var landStore=new Ext.data.JsonStore({
			    	fields: ['code', 'name'],
			        data : [] 
			    });
			    
			    var countyCombo = new Ext.form.ComboBox({
			    	id:'county',
			        store: countyStore,
			        displayField:'name',
			        valueField: 'code',
			        editable:false,
			        width:120,
			        mode: 'local',  
			        forceSelection: false,    
			        triggerAction: 'all',
			        emptyText:'请选择县区分局...',
			        selectOnFocus:false,
			        listeners:{
				    	'select':function(){ 
			 			    Ext.getCmp("land").getStore().clearData();
			 				Ext.getCmp("land").clearValue();
			        		var temp = Ext.getCmp("county").getValue();
			        		var landData=getData(temp);
			        		landStore.loadData(landData[0]);       		      		         
			       	 	}   
			       } 
			    });
			    
			    var landCombo = new Ext.form.ComboBox({
			        id:'land',
			        store: landStore,
			        displayField:'name',
			        valueField: 'code',
			        editable:false,
			        typeAhead: true,
			        width:120,
			        mode: 'local',
			        forceSelection: true,
			        triggerAction: 'all',
			        emptyText:'请选择国土所...',
			        selectOnFocus:true
			    });
	
			    
			    width = document.body.clientWidth - 20;
			    var height = document.body.clientHeight * 0.92; 
			    grid = new Ext.grid.GridPanel({
			        store: store,
			        id:'gridId',
			        columns: [
			            new Ext.grid.RowNumberer(),
			        	{header: '编号',dataIndex:'TZID',width: width*0.1, sortable: true},
			            {header: '项目名称',dataIndex:'WFYDXMMC', width: width*0.09, sortable: true},
			            {header: '用地位置',dataIndex:'WFYDWZ', width: width*0.23, sortable: true},
			            {header: '用地面积', dataIndex:'SJTDMJ',width: width*0.1, sortable: true},
			            {header: '是否符合规划', dataIndex:'SFFHGH',width: width*0.1, sortable: true},
			            {header: '违法类型',dataIndex:'WFLX', width: width*0.1, sortable: true}, 
			            {header: '结案时间', dataIndex:'JHSJ',width: width*0.1, sortable: true}, 
			            {header: '状态', dataIndex:'SB',width: width*0.06, sortable: true}, 
			            {header: '查看', dataIndex:'TZID',width: width*0.05, sortable: false,renderer:view},
			            {header: '删除', dataIndex:'TZID',width: width*0.05, sortable: false,renderer:deleteView}
			        ],
			    
			        tbar:['时间：<input id="beginDate" type="text" name="QZZXSJ" id="QZZXSJ" class="dateText"  readonly="true" onClick="setmonth(this)"/> &nbsp;到<input id="endDate" type="text" name="QZZXSJ" id="begin" class="dateText"   readonly="true" onClick="setmonth(this)"/>'
			 
			            
					    ],
			        listeners:{
					    rowdblclick: viewDetail
			        },
			      	
			        stripeRows: true,
			        height: height,
			        stateful: true,
			        stateId: 'grid',
			        buttonAlign:'center',
			        bbar: new Ext.PagingToolbar({
				        pageSize: 10,
				        store: store,
				        displayInfo: true,
				        displayMsg: '共{2}条，当前为：{0} - {1}条',
				        emptyMsg: "无记录",
				        plugins: new Ext.ux.ProgressBarPager()
			        })
			
			    });
			
			    
		      	grid.render('mygrid_container');
		      	 		
		      	this.tb = new Ext.Toolbar({   
		      		renderTo:grid.tbar,   
		      		          
		      		items:[   
		      		   '<ul class="area"><%=ReportManager.getInstance().getAreaCheckCode(userID)%></ul>',
		      		 '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;',
		      		   {xtype: 'button',text:'查询',handler: query},'&nbsp;'
		      		  <%=isShowReport?",{xtype: 'button',text:'导出',handler: report},'&nbsp;'":""%> 
		      		]
		      	 }); 
				
			 				 
			})
		
			
			//获取行政区
			function getData(xzqh){
				var path = "<%=basePath%>";
				var actionName = "xzqh";
				var actionMethod = "getNextPlace";
				var parameter = "code=" + xzqh;
				var myDataXzqh = ajaxRequest(path, actionName, actionMethod, parameter);
				var obj = eval('(' + myDataXzqh + ')');
	    	    return obj;		
			}
	
			
			//详细信息
			function view(id){
				id="\""+id+"\"";
				
				return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='<%=basePath%>base/gis/images/view.png'></a>";
			}
			function deleteView(id){
				id="\""+id+"\"";
				return "<a href='#' onclick='viewDetele("+id+");return false;'><img src='<%=basePath%>base/gis/images/delete.png'></a>";
			}
			function viewDetail(id){
			    var returnPath=window.location.href;			  
			    var url='<%=basePath%>web/jinan/report/reportsForm.jsp?tzId='+id;
			    window.open(url,'newwindow','height=768,width=1024,top=0,left=0,location=yes,scrollbars=yes,status=no') 
			}
			
			
			//查询按钮
			function query(){
				var beginTime=document.getElementById("beginDate").value;
				var endTime=document.getElementById("endDate").value;
				var area="";
				var areas=document.getElementsByName("area");
				for(var i=0;i<areas.length;i++)
				{		
					if(areas[i].checked)
						area+=areas[i].value+",";		
				}
				if(area!="")
				{
					area=area.substring(0,area.length-1);
				}
				
				putClientCommond("reportAction","query");
			 	putRestParameter("beginDate",beginTime);
				putRestParameter("endDate",endTime);
				putRestParameter("area",area);
				
				myData = restRequest();	 
				store = new Ext.data.JsonStore({
				    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
			        fields: [
							{name: 'TZID'},
							{name: 'WFYDXMMC'},
							{name: 'WFYDWZ'},
							{name: 'SJTDMJ'},
							{name: 'SFFHGH'},
							{name: 'WFLX'},
							{name: 'JHSJ'},    
							{name: 'SB'},   
							{name: 'TZID'} ,
							{name: 'TZID'} 
			        ]
				});
				 
				grid.reconfigure(store, new Ext.grid.ColumnModel([
		            new Ext.grid.RowNumberer(),
		            new Ext.grid.RowNumberer(),
		        	{header: '编号',dataIndex:'TZID',width: width*0.1, sortable: true},
		            {header: '项目名称',dataIndex:'WFYDXMMC', width: width*0.09, sortable: true},
		            {header: '用地位置',dataIndex:'WFYDWZ', width: width*0.23, sortable: true},
		            {header: '用地面积', dataIndex:'SJTDMJ',width: width*0.1, sortable: true},
		            {header: '是否符合规划', dataIndex:'SFFHGH',width: width*0.1, sortable: true},
		            {header: '违法类型',dataIndex:'WFLX', width: width*0.1, sortable: true}, 
		            {header: '结案时间', dataIndex:'JHSJ',width: width*0.1, sortable: true}, 
		            {header: '状态', dataIndex:'SB',width: width*0.06, sortable: true}, 
		            {header: '查看', dataIndex:'TZID',width: width*0.05, sortable: false,renderer:view},
		            {header: '删除', dataIndex:'TZID',width: width*0.05, sortable: false,renderer:deleteView}
				]));
				//重新绑定分页工具栏
				grid.getBottomToolbar().bind(store);
				//重新加载数据集
				store.load({params:{start:0,limit:10}});  
			}
			
			function viewDetele(id){
				var rowIndex = grid.store.indexOf(grid.getSelectionModel().getSelected());
				var bjId = grid.getStore().getAt(rowIndex).get('系统编号');
				//alert( grid.getSelectionModel().getSelected()); 
				Ext.MessageBox.confirm('注意', '删除后不能恢复，您确定吗？',function(btn){
				    if(btn=='yes'){
						putClientCommond("reportAction","delete");
					 	putRestParameter("tzId",id);

						var result =restRequest();	
						if(result){ 
							//服务器端数据成功删除后，同步删除客户端列表中的数据
							 var ds =  grid.getStore(); 
							 var selectedRow = grid.getSelectionModel().getSelected(); 
							
				             if (selectedRow){ 
				                ds.remove(selectedRow);
				             } 
						     Ext.Msg.alert('提示','删除信息成功。'); 
					    }
					    else
					    {
					         Ext.Msg.alert('删除失败,请重试！'); 
					    }
					}
					else{
					   return false;
					}
				  });
				 }
			
			//查询全部数据
			function report(){
			
				var parameter="";
				
				var beginDate=document.getElementById("beginDate").value
				var endDate=document.getElementById("endDate").value
				if(beginDate=="")
				{
					alert("请输入开始时间");
					return;
				}
				if(endDate!="")
				{
					var beginTime=beginDate.split("-");
					var endTime=endDate.split("-");
				
					if(parseInt(endTime[0])<parseInt(beginTime[0]))
					{
						alert("结束时间必须大于开始时间");
						return;
					}
	
					else if(parseInt(endTime[1])<parseInt(beginTime[1])&&parseInt(endTime[0])>=parseInt(beginTime[0]))
					{
						alert("结束时间必须大于开始时间");
						return;
					}
					
				}
				var area="";
				var areas=document.getElementsByName("area");
				for(var i=0;i<areas.length;i++)
				{
				
					if(areas[i].checked)
						area+=areas[i].value+",";		
				}
				if(area!="")
				{
					area=area.substring(0,area.length-1);
				}
				else
				{
					alert("请选择地区");
					return;
				}
				
				parameter="beginDate="+beginDate+"&&endDate="+endDate+"&&area="+area;
				document.forms[0].action=document.forms[0].action+"service/rest/reportAction/report?"+parameter;
				document.forms[0].submit();
			}
		</script>
</head>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
	<!-- reduce/service/rest/wyrwmanager/uploadResult -->
	<form action="<%=basePath%>" method="post">
	
	</form>
			<div id="mygrid_container" style="width: 100%; height: 85%;"></div>	
	<div id="importWin" class="x-hidden">
			<div id="importForm"></div>
		</div>
	</body>
</html>