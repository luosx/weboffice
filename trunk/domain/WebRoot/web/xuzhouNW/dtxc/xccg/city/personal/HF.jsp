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
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
			
		<title>县审核中列表</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script src="<%=basePath%>/base/include/ajax.js"></script>
		<%@ include file="/base/include/ext.jspf" %>
		<%@ include file="/base/include/restRequest.jspf" %>
		<script type="text/javascript" src="<%=basePath%>base/thirdres/ext/examples/ux/PagingMemoryProxy.js"></script>
		<script type="text/javascript" src="<%=basePath%>base/thirdres/ext/examples/ux/ProgressBarPager.js"></script>
		<script src="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/FileUploadField.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/css/fileuploadfield.css"/>
		<style>
			input,img{vertical-align:middle;cursor:hand;}
		</style>
		<script type="text/javascript">
			var myData;
			var store;
			var grid;
			var width;
			var scrWidth = screen.availWidth;
	    	var scrHeight = screen.availHeight; 
			Ext.onReady(function(){
				putClientCommond("dtxcCG","getXccgData");
			    putRestParameter("status",5);
			    putRestParameter("xzqhNames",escape(escape('<%=xzqhNames%>')));
				myData = restRequest();
			    store = new Ext.data.JsonStore({
				    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
			        fields: [
			           {name: 'YW_GUID'},
			           {name: 'XCDW'},
			           {name: 'XCSJ'},
			           {name: 'XCDD'},
			           {name: 'JSDW'},
			           {name: 'JSXM'},
			           {name: 'JSQK'},    
			           {name: 'ROWNUM1'} 
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
			       
			    width = document.body.clientWidth - 5;
			    var height = document.body.clientHeight * 0.955; 
			    grid = new Ext.grid.GridPanel({
			        store: store,
			        id:'gridId',
			        columns: [
			            new Ext.grid.RowNumberer(),
			        	{header: '编号',dataIndex:'YW_GUID',width: width*0.1, sortable: true},
			            {header: '巡查单位',dataIndex:'XCDW', width: width*0.19, sortable: true},
			            {header: '巡查时间',dataIndex:'XCSJ', width: width*0.1, sortable: true},
			            {header: '巡查地点', dataIndex:'XCDD',width: width*0.2, sortable: true},
			            {header: '建设单位', dataIndex:'JSDW',width: width*0.1, sortable: true},
			            {header: '建设项目',dataIndex:'JSXM', width: width*0.1, sortable: true}, 
			            {header: '建设情况', dataIndex:'JSQK',width: width*0.12, sortable: true}, 
			            {header: '查看', dataIndex:'ROWNUM1',width: width*0.05, sortable: false,renderer:view}
			        ],
			         tbar:[
		         		countyCombo,'区/县分局&nbsp;&nbsp;',landCombo,'国土所&nbsp;&nbsp;&nbsp;&nbsp;巡查日期：',
		         		{xtype:'datefield',id:'startdate',width:100,format:'Y-m-d'},'至',
		    			{xtype:'datefield',id:'enddate',width:100,format:'Y-m-d'},'&nbsp;',
		    			{xtype: 'button',text:'搜索',handler: query},'&nbsp;',
		    			{xtype: 'button',text:'重置',handler: resetData},'&nbsp;',
		    			{xtype: 'button',text:'全部',handler: queryAll}
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
		      	 		
		      	form = new Ext.form.FormPanel({  
				  	renderTo:'importForm',
				  	labelAlign: 'right',    
				  	labelWidth: 60,  
				  	frame:true,
				  	url:  "http://" + window.location.href.split("/")[2] + '/reduce/service/rest/wyrwmanager/uploadResult',
			      	method:'POST', 
				  	width: 500, 
				  	fileUpload: true,
				  	autoHeight: true,
		        	bodyStyle: 'padding: 10px 10px 0 10px;',
		        	labelWidth: 60,
		        	defaults: {
		            	anchor: '98%',
		            	allowBlank: false,
		            	msgTarget: 'side'
		        	},  
					items: [{
					    xtype: 'fileuploadfield',
					    emptyText: '请选择...',
					    fieldLabel: '文件路径',
					    name: 'file',
					    buttonText: '浏览&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;',
					    buttonCfg: {
					    	iconCls: 'upload-icon'
					    }
			        }],  
					buttons: [{  
						text: '导入',  
						handler: function() {
						    var filePath=form.getForm().findField('file').getRawValue();
							var re = /(\\+)/g;  
							var filename=filePath.replace(re,"#"); 
							//对路径字符串进行剪切截取
						    var one=filename.split("#"); 
							//获取数组中最后一个，即文件名
							var two=one[one.length-1]; 
						    //再对文件名进行截取，以取得后缀名
							var three=two.split("."); 
							//获取截取的最后一个字符串，即为后缀名
							var last=three[three.length-1];
							//添加需要判断的后缀名类型
							var tp ="zip";
							//返回符合条件的后缀名在字符串中的位置
							var rs=tp.indexOf(last); 
							//如果返回的结果大于或等于0，说明包含允许上传的文件类型
							if(rs>=0&&filePath!=""){ 
						    	form.getForm().submit({  
							        success: function(form, action){  
							           alert('文件导入成功！,共导入'+action.result.msg+'条成果！');  
							           document.location.reload();
							        },  
							        failure: function(){  
							           Ext.Msg.alert('错误', '文件导入失败');  
							        }  
						      	});
						    }else if(filePath==""){
						    	Ext.Msg.alert('错误', '请选择需要导入的文件！');
						    }
						    else{
						        Ext.Msg.alert('错误', '导入文件类型错误！请选择zip文件,字母大写');  
						    }  
					    }  
					},{
						text: '重置',
					    handler: function(){    
					    	form.getForm().reset();
					    }
					}]  
				});  
				
				win = new Ext.Window({
	                applyTo:'importWin',
	                title:'请选择zip成果文件',
	                width:515,
	                height:116,
	                closeAction:'hide',
					items:form
				});  				 
			})
			//ext部分结束
			
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
			
			//导出成果包
			function sendTask(){
				var ids="";
				if(grid.getSelectionModel().hasSelection()){
				    var records=grid.getSelectionModel().getSelections();
					for(var i=0;i<records.length;i++){
					   if(i==records.length-1){
					      ids=ids+records[i].get('GUID');
					   }else{
					      ids=ids+records[i].get('GUID')+"@";
					   }
				    }
				  	var path = "<%=basePath%>";
				    var actionName = "wyrwmanager";
					var actionMethod = "downResult";
					var parameter="ids="+ids;
				    var result = ajaxRequest(path,actionName,actionMethod,parameter);
				    if(result!=""){
				       window.open("downCG.jsp?file_path="+result);
				       document.location.reload();
				    }   
			    }else{
			    	Ext.Msg.alert('提示','请选择任务！');
			    }
			}
			
			//详细信息
			function view(id){
				return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='base/gis/images/view.png'></a>";
			}
			function viewDetail(id){
				var yw_guid=myData[id].YW_GUID;
			    var returnPath=window.location.href;
			    //var url='<%=basePath%>model/resourcetree/resourceTree.jsp?zfjcType=11&yw_guid='+yw_guid+'&returnPath='+returnPath+'&edit=false'; 
			   	 var url='<%=basePath%>web/jinan/dtxc/xccg/xjclyjframe.jsp?zfjcType=11&yw_guid='+yw_guid+'&returnPath='+returnPath + '&flag=5' + '&edit=false'; 
			    document.location.href=url;
			}
			
			//查询按钮
			function query(){
				var county = Ext.getCmp('county').getValue();
				var land = Ext.getCmp('land').getValue();
				var startdate=Ext.getCmp('startdate').getValue();
				var enddate=Ext.getCmp('enddate').getValue();
				startdate = Ext.util.Format.date(startdate, 'Y-m-d');
				enddate = Ext.util.Format.date(enddate,'Y-m-d');
				putClientCommond("dtxcCG","getXccgData");
				putRestParameter("status",5);
				putRestParameter("xzqhNames",escape(escape('<%=xzqhNames%>')));
				putRestParameter("county",county);
				putRestParameter("land",land);
				putRestParameter("startdate",startdate);
				putRestParameter("enddate",enddate);
				myData = restRequest();
				 
				store = new Ext.data.JsonStore({
				    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
			        fields: [
				           {name: 'YW_GUID'},
				           {name: 'XCDW'},
				           {name: 'XCSJ'},
				           {name: 'XCDD'},
				           {name: 'JSDW'},
				           {name: 'JSXM'},
				           {name: 'JSQK'},    
				           {name: 'ROWNUM1'} 
			        ]
				});
				 
				grid.reconfigure(store, new Ext.grid.ColumnModel([
		            new Ext.grid.RowNumberer(),
		        	{header: '编号',dataIndex:'YW_GUID',width: width*0.1, sortable: true},
		            {header: '巡查单位',dataIndex:'XCDW', width: width*0.19, sortable: true},
		            {header: '巡查时间',dataIndex:'XCSJ', width: width*0.1, sortable: true},
		            {header: '巡查地点', dataIndex:'XCDD',width: width*0.2, sortable: true},
		            {header: '建设单位', dataIndex:'JSDW',width: width*0.1, sortable: true},
		            {header: '建设项目',dataIndex:'JSXM', width: width*0.1, sortable: true}, 
		            {header: '建设情况', dataIndex:'JSQK',width: width*0.12, sortable: true}, 
		            {header: '查看', dataIndex:'ROWNUM1',width: width*0.05, sortable: false,renderer:view}
				]));
				//重新绑定分页工具栏
				grid.getBottomToolbar().bind(store);
				//重新加载数据集
				store.load({params:{start:0,limit:10}});  
			}
			
			//重置选择框中的数据
			function resetData(){
				Ext.getCmp("county").reset();
				Ext.getCmp("startdate").reset();
				Ext.getCmp("enddate").reset();
				Ext.getCmp("land").getStore().clearData();
				Ext.getCmp("land").clearValue();
			}
			
			//查询全部数据
			function queryAll(){
				putClientCommond("dtxcCG","getXccgData");
			    putRestParameter("status",5);
			    putRestParameter("xzqhNames",escape(escape('<%=xzqhNames%>')));
				myData = restRequest();
				
				store = new Ext.data.JsonStore({
			    	proxy: new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
			        fields: [
				           {name: 'YW_GUID'},
				           {name: 'XCDW'},
				           {name: 'XCSJ'},
				           {name: 'XCDD'},
				           {name: 'JSDW'},
				           {name: 'JSXM'},
				           {name: 'JSQK'},    
				           {name: 'ROWNUM1'} 
			        ]
			    }); 
			    
				grid.reconfigure(store, new Ext.grid.ColumnModel([
		            new Ext.grid.RowNumberer(),
		        	{header: '编号',dataIndex:'YW_GUID',width: width*0.1, sortable: true},
		            {header: '巡查单位',dataIndex:'XCDW', width: width*0.19, sortable: true},
		            {header: '巡查时间',dataIndex:'XCSJ', width: width*0.1, sortable: true},
		            {header: '巡查地点', dataIndex:'XCDD',width: width*0.2, sortable: true},
		            {header: '建设单位', dataIndex:'JSDW',width: width*0.1, sortable: true},
		            {header: '建设项目',dataIndex:'JSXM', width: width*0.1, sortable: true}, 
		            {header: '建设情况', dataIndex:'JSQK',width: width*0.12, sortable: true}, 
		            {header: '查看', dataIndex:'ROWNUM1',width: width*0.05, sortable: false,renderer:view}
			    ]));
				//重新绑定分页工具栏
				grid.getBottomToolbar().bind(store);//
				//重新加载数据集
				store.load({params:{start:0,limit:10}});  
			}
		</script>
</head>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container" style="width: 100%; height: 85%;"></div>	
	<div id="importWin" class="x-hidden">
			<div id="importForm"></div>
		</div>
	</body>
</html>
