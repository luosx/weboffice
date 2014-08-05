<%@ page language="java" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	Object principal = SecurityContextHolder.getContext()
			.getAuthentication().getPrincipal();
    String userid =((User) principal).getUserID();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>信访案件已办理</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/base/include/restRequest.jspf" %>
		<%@ include file="/base/include/ext.jspf"%>
		<script src="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/FileUploadField.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/css/fileuploadfield.css"/>
		<script type="text/javascript">
		var myData;
		var grid;
		var sm;
		var width;
		var height;
		var XZQData=[{key:'局机关',value:'局机关'},
		                {key:'直属分局',value:'直属分局'},
						{key:'集美分局',value:'集美分局'},
						{key:'海沧分局',value:'海沧分局'},
						{key:'同安分局',value:'同安分局'},
						{key:'翔安分局',value:'翔安分局'}];
       var XZQStore= new Ext.data.JsonStore({
							  data: XZQData,
							  fields: 
							   ['key','value']
						     });
         var LXData=[{key:'电话',value:'电话'},
					 {key:'传真',value:'传真'}];
		var LXStore= new Ext.data.JsonStore({
						  data: LXData,
						  fields: 
						   ['key','value']
					     });
		Ext.onReady(function(){
			putClientCommond("XfjbManager","getXfjbYcl");
			putRestParameter("userId","<%=userid%>");
			myData = restRequest();
			//myData=eval(myData);
		    var store = new Ext.data.JsonStore({
		    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		       remoteSort:true,
		        fields: [
		           {name:'BH'},
		           {name: 'JBR'},
		           {name: 'JBXS'},
		           {name: 'LXDZ'},
		           {name: 'JBSJ'},
		           {name: 'LXDH'},
		           {name: 'JBZYWT'},
		           {name: 'JSR'},
		            {name: 'XZQ'},
		            {name: 'JLR'},
		            {name: 'INDEX'},
		           {name: 'YW_GUID'}
		        ]
		    });
		    
		    store.load({params:{start:0, limit:15}}); 
		    width=document.body.clientWidth;
		    height=document.body.clientHeight;//高度
		    sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});
		    grid = new Ext.grid.GridPanel({
		        title:'12336举报已办列表',
		        store: store,
		        columns: [
		            //new Ext.grid.RowNumberer(),  
		           {header: '登记号',dataIndex:'BH',width: width*0.08, sortable: true},
		            {header: '处理机关',dataIndex:'XZQ',width: width*0.08, sortable: true},
		           {header: '举报人',dataIndex:'JBR',width: width*0.1, sortable: true},
		           {header: '举报形式',dataIndex:'JBXS',width: width*0.08, sortable: true},
		           {header: '联系地址',dataIndex:'LXDZ',width: width*0.16, sortable: true},
		           {header: '举报时间',dataIndex:'JBSJ',width: width*0.08, sortable: true},
		           {header: '联系电话',dataIndex:'LXDH',width: width*0.08, sortable: true},
		           {header: '举报主要问题',dataIndex:'JBZYWT',width: width*0.16, sortable: true},
		            {header: '记录人',dataIndex:'JLR',width: width*0.06, sortable: true},
		             {header: '接收人',dataIndex:'JSR',width: width*0.06, sortable: true},
		           {header: '查看',dataIndex:'INDEX',width: width*0.05, sortable: false,renderer:pro}
		        ],
		        tbar:[
		            {xtype:'label',text:'处理机关:',width:30},
		           new Ext.form.ComboBox({
			                   id:'XZQcombo',
							    store:XZQStore,
							    displayField:'key',
							    valueField:'value',
							    editable:false,
							    typeAhead:true,
							    width:80,
							    mode:'local',
							    forceSelection:true,
							    triggerAction:'all',
									    selectOnFocus:true
					    }),
					{xtype:'label',text:'举报类型:',width:60},
					   new Ext.form.ComboBox({
			                   id:'LXcombo',
							    store:LXStore,
							    displayField:'key',
							    valueField:'value',
							    editable:false,
							    typeAhead:true,
							    width:80,
							    mode:'local',
							    forceSelection:true,
							    triggerAction:'all',
									    selectOnFocus:true
					    }),
		        	{xtype:'label',text:'快速查找:',width:60},
		        	{xtype:'textfield',id:'keyword',width:450,emptyText:'请输入关键字进行查询'},
		        	{xtype: 'button',text:'查询',handler: query}
		        ],
                listeners:{
		  			rowdblclick : function(grid, rowIndex, e)
					{
				   		// showDetail(grid.getStore().getAt(rowIndex).data.XIANGXI);
				   		process(grid.getStore().getAt(rowIndex).data.INDEX);
					}
        		},
		        // stripeRows: true,
		        width:width,
		        height:height,  
		        // config options for stateful behavior
		        stateful: true,
		        stateId: 'grid',
		        buttonAlign:'center',
		        bbar: new Ext.PagingToolbar({
		        pageSize: 15,
		        store: store,
		        displayInfo: true,
		            displayMsg: '共{2}条，当前为：{0} - {1}条',
		            emptyMsg: "无记录",
		        plugins: new Ext.ux.ProgressBarPager()
		        })
		    });
		    
		    grid.render('mygrid_container'); 
		});

		function pro(id){
		 return "<a href='#'onclick='process("+id+");return false;'><img src='<%=basePath%>web/xiamen/xfgl/image/view.png' alt='办理'></a>";
		}

		function process(id){
		     var wfInsTaskId=myData[id].DBID_
			var activityName=myData[id].ACTIVITY_NAME_;
			var isFirst;
			if(activityName=="受理立案"){
				isFirst='yes';
			}
			var wfInsId=myData[id].WFINSID;
			var yw_guid=myData[id].YW_GUID;
			var userid1=myData[id].USERID;
			putClientCommond("XfjbManager","isEnd");
         	putRestParameter("yw_guid", yw_guid);
         	var isEnd = restRequest();
			var zfjcType="10";
			var returnPath="web/xiamen/xfgl/yb/xfybaj.jsp";
//			var buttonHien = "delete,la,back,tran";
			var buttonHien = "";
			if(isEnd=="1"){
				buttonHien = "delete,la,back,tran";
			}else{
				buttonHien = "la";
			}
			var url='<%=basePath%>model/workflow/wf.jsp?yw_guid='+yw_guid+'&wfInsId='+wfInsId+'&zfjcType='+zfjcType+'&returnPath='+returnPath+'&zfjcName=信访举报&fixed=save&buttonHidden='+buttonHien+'&userid1='+userid1;  
			//window.open(url); 
			document.location.href=url;
		}

      function query(){
         var keyWord=Ext.getCmp('keyword').getValue();
         var LX=Ext.getCmp('LXcombo').getValue();
         var XZQ=Ext.getCmp('XZQcombo').getValue();
         var condition='';
         if(LX.length>0&&XZQ.length>0){
          LX=escape(escape("'"+LX+"'"));
          XZQ=escape(escape("'"+XZQ+"'"));
         condition="xzq="+XZQ+"  and jbxs="+LX ;
         }else if(XZQ.length>0){
          XZQ=escape(escape("'"+XZQ+"'"));
           condition="xzq="+XZQ;
         }else if(LX.length>0){
          LX=escape(escape("'"+LX+"'"));
          condition="jbxs="+LX ;
         }
         keyWord=keyWord.toUpperCase();
         putClientCommond("XfjbManager","getXfjbYcl");
         putRestParameter("userId", "<%=userid%>");
         putRestParameter("keyWord",escape(escape(keyWord)));
         putRestParameter("condition", condition);
          myData = restRequest(); 
          myData= eval(myData);
         var store = new Ext.data.JsonStore({
              proxy: new Ext.ux.data.PagingMemoryProxy(myData),
              remoteSort:true,
              fields: [
                   {name:'BH'},
		           {name: 'JBR'},
		           {name: 'JBXS'},
		           {name: 'LXDZ'},
		           {name: 'JBSJ'},
		           {name: 'LXDH'},
		           {name: 'JBZYWT'},
		           {name: 'JSR'},
		            {name: 'XZQ'},
		            {name: 'JLR'},
		            {name: 'INDEX'},
		           {name: 'YW_GUID'}
              ]
        });
        
        grid.reconfigure(store, new Ext.grid.ColumnModel([
           //new Ext.grid.RowNumberer(),        
		           {header: '登记号',dataIndex:'BH',width: width*0.08, sortable: true},
		           {header: '处理机关',dataIndex:'XZQ',width: width*0.08, sortable: true},
		           {header: '举报人',dataIndex:'JBR',width: width*0.1, sortable: true},
		           {header: '举报形式',dataIndex:'JBXS',width: width*0.08, sortable: true},
		           {header: '联系地址',dataIndex:'LXDZ',width: width*0.16, sortable: true},
		           {header: '举报时间',dataIndex:'JBSJ',width: width*0.08, sortable: true},
		           {header: '联系电话',dataIndex:'LXDH',width: width*0.08, sortable: true},
		           {header: '举报主要问题',dataIndex:'JBZYWT',width: width*0.16, sortable: true},
		           {header: '记录人',dataIndex:'JLR',width: width*0.06, sortable: true},
		           {header: '接收人',dataIndex:'JSR',width: width*0.06, sortable: true},
		           {header: '查看',dataIndex:'INDEX',width: width*0.05, sortable: false,renderer:pro}
        ]));
        grid.getBottomToolbar().bind(store);
        store.load({params:{start:0,limit:15}});  
      }
      
       <!--改变关键字方法 add by 赵伟 2012-9-7-->
       function changKeyword(val){
          var key=Ext.getCmp('keyword').getValue().toUpperCase();
          if(key!=''&& val!=null){
            var temp=val.toUpperCase();
            if(temp.indexOf(key)>=0){
            return val.substring(0,temp.indexOf(key))+"<B style='color:black;background-color:#CD8500;font-size:120%'>"+val.substring(temp.indexOf(key),temp.indexOf(key)+key.length)+"</B>"
              +temp.substring(temp.indexOf(key)+key.length,temp.length);
            }else{
              return val;
            }
         }else{
           return val;
         }
       } 

</script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">

		<div id="mygrid_container" style="width: 100%; height: 80%;"></div>
		<div id="win1" class="x-hidden">
			<div id="import"></div>
		</div>
		<div id="importWin" class="x-hidden">
			<div id="importForm"></div>
		</div>	
	</body>
</html>