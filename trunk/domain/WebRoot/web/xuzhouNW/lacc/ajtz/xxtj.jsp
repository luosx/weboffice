<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>信息汇总表</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/base/include/restRequest.jspf"%>
		<%@ include file="/base/include/ext.jspf"%>
		<script type="text/javascript">
		//add by zhaow 2012-10-26
		var myData;
		var grid;
		var width;
		var height;
		Ext.onReady(function(){
		   width=document.body.clientWidth-20;
           height=document.body.clientHeight;
		   var store = new Ext.data.JsonStore({
              proxy: new Ext.ux.data.PagingMemoryProxy(myData),
              remoteSort:true,
              fields:[
                 {name:'key'},
                 {name:'value'}
               ]
           });
		   var timeStore=new Ext.data.JsonStore({
                 data:[                     
                    	   <%
                    	   Calendar ca=Calendar.getInstance();
                    	  
                    	   	for(int i=1990;i<ca.get(Calendar.YEAR);i++)
                    	   	{
                    	   	
                  	   		
                    	   		out.print(" { \"key\":\""+i+"\",\"value\":\""+i+"\"},");
                   	   		
                    	   		
                    	   	}
                    	   	out.print(" { \"key\":\""+ca.get(Calendar.YEAR)+"\",\"value\":\""+ca.get(Calendar.YEAR)+"\"}");
                    	   
               	   
                    	   %>
                       ],
                 fields:["key","value"]
           });
		   var districtStore=new Ext.data.JsonStore({
                 data:[{"key":"市辖区","value":"市辖区"},{"key":"历下区","value":"历下区"},{"key":"市中区","value":"市中区"},{"key":"槐萌区","value":"槐萌区"},{"key":"天桥区","value":"天桥区"},{"key":"历城区","value":"历城区"}
                 ,{"key":"长清区","value":"长清区"},{"key":"高新区","value":"高新区"},{"key":"平阴县","value":"平阴县"},{"key":"商河县","value":"商河县"},{"key":"济阳县","value":"济阳县"},{"key":"章丘县","value":"章丘县"}
 				],
                 fields:["key","value"]
           });
		   grid=new Ext.grid.GridPanel({
		      title:'信息汇总表',
		      store:store,
		      columns:[
		        {header: '统计类别',dataIndex:'key',width: width*0.3, sortable: true},
                {header: '数值',dataIndex:'value',width: width*0.3, sortable: true} 
		      ],
		      tbar:[
		        {xtype:'label',text:' 按年度统计:',width:45},	
		        {xtype:'combo',id:'time',store:timeStore,width:120,emptyText:'请选择年度',
		                       displayField:'key',valueField:'value',mode:'local',
		                       triggerAction:"all"},'-',
		        {xtype:'label',text:' 按区域统计:',width:45},	
		        {xtype:'combo',id:'district',store:districtStore,width:120,emptyText:'请选择区域',
		                       displayField:'key',valueField:'value',mode:'local',
		                       triggerAction:"all"},'-',
		        {xtype: 'button',text:'查询',handler:query}
		      ],
		      width:width+20,
              height:height*0.99, 
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
		function query(){
		    var time=Ext.getCmp('time').getValue();
		    var district=Ext.getCmp('district').getValue();
		   	if(time=="")
		   	{
		   		alert("请选择年度");
		   		return;
		   	}
		   	if(district=="")
		   	{
		   		alert("请选择地区");
		   		return;
		   	}
		    putClientCommond("queryAction","getXxhzbData");
            putRestParameter("time",time);
            putRestParameter("district",district);
            var myData=restRequest();
            var store=new Ext.data.JsonStore({
               proxy:new Ext.ux.data.PagingMemoryProxy(myData),
               remoteSort:true,
               fields:[
                 {name:'key'},
                 {name:'value'}
               ]
            });
            grid.reconfigure(store,new Ext.grid.ColumnModel([
               {header: '统计类别',dataIndex:'key',width: width*0.3, sortable: true},
               {header: '数值',dataIndex:'value',width: width*0.3, sortable: true} 
            ]));
            grid.getBottomToolbar().bind(store);
            store.load({params:{start:0,limit:15}});
		}
		</script>
	</head>
	<body>
	<div id="mygrid_container" style="width: 100%; height: 80%;"></div>
	</body>
</html>
