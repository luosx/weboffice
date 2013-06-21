<%@ page language="java" pageEncoding="utf-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>信访案件待办理</title>

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
		Ext.onReady(function(){
			putClientCommond("xfAction","getAllList");
			myData = restRequest();
		    var store = new Ext.data.JsonStore({
		    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		       remoteSort:true,
		        fields: [
		           {name: 'BH'},
		           {name: 'XSLX'},
		           {name: 'JBR'},
		           {name: 'JBFS'},
		           {name: 'BJBDW'},
		           {name: 'LXCZ'},
		           {name: 'WTFSD'},
		           {name: 'SLRQ'},
		           {name: 'AJBLZT'},
		           {name: 'INDEX'}
		        ]
		    });
		    
		    store.load({params:{start:0, limit:15}}); 
		    width=document.body.clientWidth;
		    height=document.body.clientHeight;//高度
		    sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});
		    grid = new Ext.grid.GridPanel({
		        title:'案件任务待办列表',
		        store: store,
		        columns: [
		            //new Ext.grid.RowNumberer(),        
		           {header: '编号',dataIndex:'BH',width: width*0.16, sortable: true},
		           {header: '举报人',dataIndex:'JBR',width: width*0.08, sortable: true},
		           {header: '举报方式',dataIndex:'JBFS',width: width*0.10, sortable: true},
		           {header: '被举报单位',dataIndex:'BJBDW',width: width*0.15, sortable: true},
		           {header: '问题发生地',dataIndex:'WTFSD',width: width*0.15, sortable: true},
		           {header: '登记时间',dataIndex:'SLRQ',width: width*0.15, sortable: true},
		           {header: '案件办理状态',dataIndex:'AJBLZT',width: width*0.15, sortable: true},
		           {header: '查看',dataIndex:'INDEX',width: width*0.05, sortable: false,renderer:pro}
		        ],
		        tbar:[
		        	{xtype:'label',text:'快速查找:',width:60},
		        	{xtype:'textfield',id:'keyword',width:450,emptyText:'请输入关键字进行查询'},
		        	{xtype: 'button',text:'查询',handler: query}
		        ],
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
		 return "<a href='#'onclick='process("+id+");return false;'><img src='<%=basePath%>web/xuzhouNW/xfaj/images/view.png' alt='办理'></a>";
		}

		function process(id){
		    var wfInsTaskId=myData[id].DBID_;
			var activityName=myData[id].ACTIVITY_NAME_;
			var isFirst;
			if(activityName=="受理立案"){
				isFirst='yes';
			}
			var wfInsId=myData[id].WFINSID;
			var yw_guid=myData[id].YW_GUID;
			var zfjcType="91";
			var returnPath="web/xuzhouNW/xfaj/xfajcx.jsp";;
			var buttonHien = "delete,la,back,tran";
			var url='<%=basePath%>model/workflow/wf.jsp?yw_guid='+yw_guid+'&wfInsId='+wfInsId+'&zfjcType='+zfjcType+'&returnPath='+returnPath+'&zfjcName=信访举报&buttonHidden='+buttonHien;  
			//window.open(url); 
			document.location.href=url;
		}

      function query(){
         var keyWord=Ext.getCmp('keyword').getValue();
         keyWord=keyWord.toUpperCase();
         putClientCommond("xfAction","getAllList");
         putRestParameter("keyWord",escape(escape(keyWord)));
         var myData = restRequest(); 
         var store = new Ext.data.JsonStore({
              proxy: new Ext.ux.data.PagingMemoryProxy(myData),
              remoteSort:true,
              fields: [
           {name: 'BH'},
           {name: 'XSLX'},
           {name: 'JBR'},
           {name: 'JBFS'},
           {name: 'BJBDW'},
           {name: 'LXCZ'},
           {name: 'WTFSD'},
           {name: 'WTFSSJ'},
           {name: 'SLRQ'},
           {name: 'INDEX'}
              ]
        });
        
        grid.reconfigure(store, new Ext.grid.ColumnModel([
          //new Ext.grid.RowNumberer(),        
         {header: '编号',dataIndex:'BH',width: width*0.16, sortable: true},
         {header: '举报人',dataIndex:'JBR',width: width*0.08, sortable: true},
         {header: '举报方式',dataIndex:'JBFS',width: width*0.10, sortable: true},
         {header: '被举报单位',dataIndex:'BJBDW',width: width*0.15, sortable: true},
         {header: '问题发生地',dataIndex:'WTFSD',width: width*0.15, sortable: true},
         {header: '问题发生时间',dataIndex:'WTFSSJ',width: width*0.15, sortable: true},
         {header: '登记时间',dataIndex:'SLRQ',width: width*0.15, sortable: true},
         {header: '查看',dataIndex:'INDEX',width: width*0.05, sortable: false,renderer:pro}
        ]));
        grid.getBottomToolbar().bind(store);
        store.load({params:{start:0,limit:10}});  
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