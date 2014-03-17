<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    		+ request.getServerPort() + path + "/";
    String gridPath = basePath + "base/thirdres/dhtmlx/dhtmlxGrid";
    String extPath = basePath + "base/thirdres/ext/";
    
    Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	User user=(User) principal;
	String userId = user.getId();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>意见建议列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/restRequest.jspf"%>
		<%@ include file="/base/include/ext.jspf" %>
		<script type="text/javascript" src="<%=extPath%>/examples/ux/PagingMemoryProxy.js"></script>
		<script type="text/javascript" src="<%=extPath%>/examples/ux/ProgressBarPager.js"></script>
		<script type="text/javascript">
			var winForm;
			var myData;
			var grid;
			var width;
			var height;
			var win;
			var tab;
			Ext.onReady(function(){
				putClientCommond("xxfkManager","getAllXxfk");
				myData = restRequest();
				store = new Ext.data.JsonStore({
					proxy: new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
					fields: [
						{name: 'YW_GUID'},
			           	{name: 'WTFKDW'},
			           	{name: 'WTFKR'},
			           	{name: 'WTFKMS'},
			           	{name: 'WTFKSJ'},
			           	{name: 'WTJDXQ'},
			           	{name: 'WTJDRY'},
			           	{name: 'WTJDSJ'},
			           	{name: 'WTFKZT'}
	        		]
  	  			});
    
			    store.load({params:{start:0, limit:15}});
			    width=document.body.clientWidth;
		    	height=document.body.clientHeight;
		    	sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});
    
		     	grid = new Ext.grid.GridPanel({
		        	store: store,
		        	sm:sm,
		        	columns: [
		        		new Ext.grid.RowNumberer(),
		        		sm,
			           	{header: '问题反馈单位',dataIndex:'WTFKDW',width: width*0.1, sortable: true},
			           	{header: '问题反馈人',dataIndex:'WTFKR',width: width*0.07, sortable: true},
			           	{header: '问题反馈描述',dataIndex:'WTFKMS',width: width*0.2, sortable: true},
			           	{header: '问题反馈时间',dataIndex:'WTFKSJ',width: width*0.1, sortable: true},
			           	{header: '问题解答详情',dataIndex:'WTJDXQ',width: width*0.2, sortable: true},
			           	{header: '问题解答人员',dataIndex:'WTJDRY',width: width*0.07, sortable: true},
			           	{header: '问题解答时间',dataIndex:'WTJDSJ',width: width*0.1, sortable: true},
			           	{header: '问题解答状态',dataIndex:'WTFKZT',width: width*0.065, sortable: true},
			           	{header: '查看',dataIndex:'YW_GUID',width: width*0.05, sortable: false,renderer:modify}
		        	],
		         	tbar:[
				    	{xtype:'label',text:'快速查找:',width:60},
				    	{xtype:'textfield',id:'keyword',width:450,emptyText:'请输入关键字进行查询'},
				    	{xtype: 'button',text:'查询',handler: query}
					],
			        stripeRows: true,
			        height: 500,
			        title: '问题反馈列表',
			        stateful: true,
			        stateId: 'grid',
			        bbar: new Ext.PagingToolbar({
			        	pageSize: 15,
			        	store: store,
			        	displayInfo: true,
			            	displayMsg: '共{2}条，当前为：{0} - {1}条',
			            	emptyMsg: "无记录",
			        	plugins: new Ext.ux.ProgressBarPager()
			        }),
			        buttons: [{
			            text: '新增',
			            handler: createXxfk
			        },
			        {
			        	text:'导出Excel',
		        		handler: expExcel
			        }]
		    	});
    
    			grid.render('mygrid_container');
    			
		        var winForm = new Ext.form.FormPanel({
		        	region: 'center',//定位
			        autoHeight: true,
			        frame: true,
			        bodyStyle: 'padding:5px 0px 0',
			        width: 500,
			        url: "<%=basePath%>service/rest/xxfkManager/saveOneXxfk?userId=<%=userId%>",
			        defaults: {
			            anchor: '95%',
			            allowBlank: true,
			            msgTarget: 'side'
			        },
			        items:[
			   			{
			                xtype: 'textfield',
			                id: 'wtfkdw',
			                width: 350,
			                fieldLabel: '问题反馈单位'
			            },
			            {
			                xtype: 'textfield',
			           		id: 'wtfkr',
			           		width: 350,
			                fieldLabel: '问题反馈人'            
			            },
			             {
			                xtype: 'hidden',
			           		id: 'wtfkr_id',
			           		width: 350,
			                fieldLabel: '问题反馈人id'            
			            },
			             {
			                xtype: 'textarea',
			                id: 'wtfkms',
			                width: 350,
			                allowBlank: false,
			                fieldLabel: '问题反馈描述'
			            },
			            {
			                xtype: 'textfield',
			                id: 'wtfksj',
			                width: 350,
			                fieldLabel: '问题反馈时间'
			            },
			            {
			                xtype: 'textarea',
			                id: 'wtjdxq',
			                width: 350,
			                fieldLabel: '问题解答详情'
			            },
			            {
			                xtype: 'textfield',
			                id: 'wtjdry',
			                width: 350,
			                fieldLabel: '问题解答人员'
			            },
			            {
			                xtype: 'textfield',
			                id: 'wtjdsj',
			                width: 350,
			                fieldLabel: '问题解答时间'
			            },
			            {
			                xtype: 'hidden',
			           		id: 'yw_guid',
			           		width: 350,
			                fieldLabel: 'yw_guid'            
			            },
			            {
			                xtype: 'hidden',
			           		id: 'enterFlag',
			           		width: 350,
			                fieldLabel: 'enterFlag'            
			            }    
        			],
			        buttons: [
			            {
			                text   : '保存',
			                id: 'savebtn',
			                handler: function() {
									winForm.form.submit({ 
										waitMsg: '正在保存,请稍候... ', 		
										success:function(){ 
											Ext.Msg.alert('提示','保存成功。');
											document.location.reload();
										}, 
										failure:function(){ 
											Ext.Msg.alert('提示','保存失败，请稍后重试或联系管理员。');
										} 
									});
			                	}
			            	},   
			            {
			                text   : '刷新',
			                handler: function() {
			                   document.location.reload();
			                }
			            }
			        ]
  				});
  				
  				tab=new Ext.TabPanel({
				    region:'center',
				    margins:'3 3 3 0',
				    activeTab:0,
				    defaults:{autoScroll:true},
				    items:[
				     winForm,{
				     title:'图片附件',//width='"+w+"' height='"+h+"'
				     html:"<iframe width='100%' height='100%' src='<%=basePath%>web/xiamen/xxfk/accessorymain.jsp'/>"
				    }]
				   });
				 tab.items.items[0].setTitle("基本信息");
  				win = new Ext.Window({
	                layout: 'fit',
	                title: '请填写反馈问题',
	                closeAction: 'hide',
	                width:600,
	                height:400,
	                x: 80,
	                y: 110,
	                items:tab
				});     
			})

			function modify(id){
				return "<span style='cursor:pointer;' onclick='modifyXxfk(\""+id+"\")'><img src='<%=basePath%>web/xiamen/xfgl/image/view.png' alt='查看'/></span>";
			}
			
			function createXxfk(){
				putClientCommond("xxfkManager","getOneXxfk");
				putRestParameter("userId","<%=userId%>");
				myData = restRequest();
				Ext.getCmp('wtfkdw').setValue(myData[0].WTFKDW); 
				Ext.getCmp('wtfkr').setValue(myData[0].WTFKR); 
				Ext.getCmp('wtfkr_id').setValue(myData[0].WTFKR_ID); 
				Ext.getCmp('wtfkms').setValue(myData[0].WTFKMS); 
				Ext.getCmp('wtfksj').setValue(myData[0].WTFKSJ);
				Ext.getCmp('wtjdxq').setValue(myData[0].WTJDXQ); 
				Ext.getCmp('wtjdry').setValue(myData[0].WTJDRY); 
				Ext.getCmp('wtjdsj').setValue(myData[0].WTJDSJ);
				
				Ext.getCmp('yw_guid').setValue(myData[0].YW_GUID); 
				Ext.getCmp('enterFlag').setValue("new");  
				myData[0].YW_GUID="12345"
				tab.items.items[1].html="<iframe width='100%' height='100%' src='<%=basePath%>web/xiamen/xxfk/accessorymain.jsp?yw_guid="+myData[0].YW_GUID+"'/>"
				win.show();
				Ext.getCmp('wtfkdw').setDisabled(false);			
				Ext.getCmp('wtfkr').setDisabled(false);			
				Ext.getCmp('wtfkms').setDisabled(false);	
				Ext.getCmp('wtfksj').setDisabled(false);
				Ext.getCmp('wtjdxq').setDisabled(true);			
				Ext.getCmp('wtjdry').setDisabled(true);			
				Ext.getCmp('wtjdsj').setDisabled(true);			
			}
			
			function modifyXxfk(id){
				putClientCommond("xxfkManager","getOneXxfk");
				putRestParameter("userId","<%=userId%>");
				putRestParameter("yw_guid",id);
				myData = restRequest();
				Ext.getCmp('wtfkdw').setValue(myData[0].WTFKDW); 
				Ext.getCmp('wtfkr').setValue(myData[0].WTFKR); 
				Ext.getCmp('wtfkr_id').setValue(myData[0].WTFKR_ID); 
				Ext.getCmp('wtfkms').setValue(myData[0].WTFKMS); 
				Ext.getCmp('wtfksj').setValue(myData[0].WTFKSJ); 
				Ext.getCmp('wtjdxq').setValue(myData[0].WTJDXQ); 
				Ext.getCmp('wtjdry').setValue(myData[0].WTJDRY); 
				Ext.getCmp('wtjdsj').setValue(myData[0].WTJDSJ);
				
				Ext.getCmp('yw_guid').setValue(myData[0].YW_GUID); 
				Ext.getCmp('enterFlag').setValue("update"); 
				
				win.show();
				Ext.getCmp('wtjdxq').setDisabled(false);			
				Ext.getCmp('wtjdry').setDisabled(false);			
				Ext.getCmp('wtjdsj').setDisabled(false);
				if("09D31706EB0B487EB605F64386D573F8" == "<%=userId%>"){//只有王峰可以回复问题
					Ext.getCmp('savebtn').setDisabled(false);
				}else{
					Ext.getCmp('savebtn').setDisabled(true);
				}	
			}
			
			function query(){
				var keyword=Ext.getCmp('keyword').getValue();
				putClientCommond("xxfkManager","getAllXxfk");
				putRestParameter("keyword",escape(escape(keyword)));
				myData = restRequest(); 
	         	var store = new Ext.data.JsonStore({
	            	proxy: new Ext.ux.data.PagingMemoryProxy(myData),
	            	remoteSort:true,
					fields: [
						{name: 'YW_GUID'},
			           	{name: 'WTFKDW'},
			           	{name: 'WTFKR'},
			           	{name: 'WTFKMS'},
			           	{name: 'WTFKSJ'},
			           	{name: 'WTJDXQ'},
			           	{name: 'WTJDRY'},
			           	{name: 'WTJDSJ'},
			           	{name: 'WTFKZT'}
					]
	        	});
	        	grid.reconfigure(store, new Ext.grid.ColumnModel([
	        		new Ext.grid.RowNumberer(),
	        		sm,
		           	{header: '问题反馈单位',dataIndex:'WTFKDW',width: width*0.1, sortable: true},
		           	{header: '问题反馈人',dataIndex:'WTFKR',width: width*0.07, sortable: true},
		           	{header: '问题反馈描述',dataIndex:'WTFKMS',width: width*0.2, sortable: true},
		           	{header: '问题反馈时间',dataIndex:'WTFKSJ',width: width*0.1, sortable: true},
		           	{header: '问题解答详情',dataIndex:'WTJDXQ',width: width*0.2, sortable: true},
		           	{header: '问题解答人员',dataIndex:'WTJDRY',width: width*0.07, sortable: true},
		           	{header: '问题解答时间',dataIndex:'WTJDSJ',width: width*0.1, sortable: true},
		           	{header: '问题解答状态',dataIndex:'WTFKZT',width: width*0.065, sortable: true},
		           	{header: '查看',dataIndex:'YW_GUID',width: width*0.05, sortable: false,renderer:modify}
	        	]));
	        	grid.getBottomToolbar().bind(store);
	        	store.load({params:{start:0,limit:15}});
			}
			
			//导出Excel
			function expExcel(){
				downloadViewData(grid);	
			}
	
			function downloadViewData(grid){		
				if(grid.getSelectionModel().hasSelection()){
			   		var records=grid.getSelectionModel().getSelections();
					try {
						var xls = new ActiveXObject("Excel.Application");
						} catch (e) {
							alert("要打印该表，您必须安装Excel电子表格软件，同时浏览器须使用“ActiveX 控件”，您的浏览器须允许执行控件。 请点击【帮助】了解浏览器设置方法！");
							return "";  
						}
						var cm = grid.getColumnModel();
				   		var colCount = cm.getColumnCount();
				   		xls.visible = true; // 设置excel为可见
				   		var xlBook = xls.Workbooks.Add;
				   		var xlSheet = xlBook.Worksheets(1);    
				   		var temp_obj = [];
				   		// 只下载没有隐藏的列(isHidden()为true表示隐藏,其他都为显示)    
				   		for (i = 2; i < colCount; i++) {
				    		if (cm.isHidden(i) == true) {
				    		} else {
				     			temp_obj.push(i);   
				     		}
				   		}
			   			for (l = 1; l <= temp_obj.length; l++) {
			    			xlSheet.Cells(1, l).Value = cm.getColumnHeader(temp_obj[l-1]); 
			   			}
		    			var store = grid.getStore();
		   				var recordCount = store.getCount();
		   				var view = grid.getView();
		   				for (k = 1; k <= records.length; k++) {
		    				for (j = 1; j < temp_obj.length ; j++) {
		     					xlSheet.Cells(k + 1, j).Value = records[k-1].get(records[k-1].fields.items[j].name);
		     				}		   					
						}
						xlSheet.Columns.AutoFit;
		   				xls.ActiveWindow.Zoom = 75;
		   				xls.UserControl = true; // 很重要,不能省略,不然会出问题 意思是excel交由用户控制
		   				xls = null;
		   				xlBook = null;
		   				xlSheet = null;
		   		    }else{
		    			Ext.Msg.alert('提示','请选择数据！');
		  			}
			}
		</script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container" style="width: 100%; height: 100%;"></div>
	</body>
</html>