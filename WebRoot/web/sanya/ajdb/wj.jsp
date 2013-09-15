<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.klspta.web.sanya.ajdb.CaseSupervision"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String dbts = new CaseSupervision().getDbDateByType("文件审批");				
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>文件</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/base/include/restRequest.jspf" %>
		<%@ include file="/base/include/ext.jspf"%>
		<script type="text/javascript">
var myData;
var grid;
var sm;
var width;
var height;
Ext.onReady(function(){
	putClientCommond("caseSupervision","getWjdbList");
	myData = restRequest();
    var store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
       remoteSort:true,
        fields: [
           {name: 'YJ'},
           {name: 'SYTS'},
           {name: 'YW_GUID'},
           {name: 'WJSPSX'},
           {name: 'WJLX'},
           {name: 'BLSX'},
           {name: 'WJSQ'},
           {name: 'ZHBLR'},
           {name: 'CREATEDATE'},		
           {name: 'INDEX'}
        ]
    });
    
    store.load({params:{start:0, limit:10}}); 
    width=document.body.clientWidth;
    height=document.body.clientHeight;//高度
    grid = new Ext.grid.GridPanel({
        store: store,
        columns: [
           {header: '预警',dataIndex:'YJ',width:30, sortable:false,renderer:warn},   
           {header: '剩余天数',dataIndex:'SYTS',width: 60, sortable: true}, 
           {header: '编号',dataIndex:'INDEX',width: 30, sortable: true},
           {header: '文件审批事项',dataIndex:'WJSPSX',width: width-550, sortable: true},
           {header: '文件类型',dataIndex:'WJLX',width: 120, sortable: true},
           {header: '截止日期',dataIndex:'BLSX',width: 70, sortable: true},
           {header: '文件申请',dataIndex:'WJSQ',width: 60, sortable: true},
           {header: '最后办理人',dataIndex:'ZHBLR',width: 70, sortable: true},
           {header: '创建时间',dataIndex:'CREATEDATE',width: 70, sortable: true},
           {header: '查看',dataIndex:'INDEX',width: 30, sortable: false,renderer:view}
        ],
        tbar:[
        	{xtype:'label',text:'快速查找:',width:60},
        	{xtype:'textfield',id:'keyword',width:450,emptyText:'请输入关键字进行查询'},
        	{xtype: 'button',text:'查询', id:'button',handler: query}
        ],
        listeners:{
		  			rowdblclick : function(grid, rowIndex, e)
					{
				   		viewDetail(rowIndex+1);
					}
        },        
        // stripeRows: true,
        width:width,
        height:height-50,  
        // config options for stateful behavior
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
    //grid.store.sort('SYTS','ASC');
    grid.render('mygrid_container'); 
    
   
});


function warn(XZSJ){
	   var syts=parseInt(XZSJ);//剩余办理天数
	    if(syts<0){
	    	return "<img src='<%=basePath%>web/sanya/framework/images/red.png'>";
	    }
	    else if(syts>=0 && syts <="<%=dbts%>" ){
	       return "<img src='<%=basePath%>web/sanya/framework/images/yellow.png'>";
	    }
	    else {
	    	return "<img src='<%=basePath%>web/sanya/framework/images/green.png'>";
	    }
}


function view(id){
	 return "<a href='#'onclick='viewDetail("+id+");return false;'><img src='<%=basePath%>base/form/images/view.png' alt='查看'></a>";
}

function viewDetail(id){	
	var url = "<%=basePath%>web/sanya/zhbg/zhbgdj/wjspTab.jsp?type=blz&yw_guid=" + myData[id-1].YW_GUID;
	document.location.href = url;	
}

function document.onkeydown() 
{ 
var e=event.srcElement; 
if(event.keyCode==13) 
{ 
document.getElementById("button").click(); 
return false; 
} 
} 


function query(){
   var keyWord=Ext.getCmp('keyword').getValue();
   keyWord=keyWord.toUpperCase();
   putClientCommond("caseSupervision","getWjdbList");           
   putRestParameter("keyWord",escape(escape(keyWord)));
   myData = restRequest(); 
   var store = new Ext.data.JsonStore({
        proxy: new Ext.ux.data.PagingMemoryProxy(myData),
        remoteSort:true,
        fields: [
           {name: 'YJ'},
           {name: 'SYTS'},
           {name: 'YW_GUID'},
           {name: 'WJSPSX'},
           {name: 'WJLX'},
           {name: 'BLSX'},
           {name: 'WJSQ'},
           {name: 'ZHBLR'},
           {name: 'CREATEDATE'},		
           {name: 'INDEX'}
        ]
  });
  grid.reconfigure(store, new Ext.grid.ColumnModel([
   {header: '预警',dataIndex:'YJ',width:30, sortable:false,renderer:warn},  
   {header: '剩余天数',dataIndex:'SYTS',width: 60, sortable: true,renderer:changKeyword},  
   {header: '编号',dataIndex:'INDEX',width: 30, sortable: true,renderer:changKeyword},
   {header: '文件审批事项',dataIndex:'WJSPSX',width: width-550, sortable: true,renderer:changKeyword},
   {header: '文件类型',dataIndex:'WJLX',width: 120, sortable: true,renderer:changKeyword},
   {header: '截止日期',dataIndex:'BLSX',width: 70, sortable: true,renderer:changKeyword},
   {header: '文件申请',dataIndex:'WJSQ',width: 60, sortable: true,renderer:changKeyword},
   {header: '最后办理人',dataIndex:'ZHBLR',width: 70, sortable: true,renderer:changKeyword},
   {header: '创建时间',dataIndex:'CREATEDATE',width: 70, sortable: true,renderer:changKeyword},
   {header: '查看',dataIndex:'INDEX',width: 30, sortable: false,renderer:view}
  ]));
  grid.getBottomToolbar().bind(store);
  store.load({params:{start:0,limit:10}});  
}
 <!--改变关键字方法 add by 王雷 2013-9-4-->
 function changKeyword(val){	
    var key=Ext.getCmp('keyword').getValue();
    if(key!=''&& val!=null){
      var val=val+'';
      var temp=val+'';
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
		<div align="center" style="margin:10px 0 0 0;padding:0;">
		    剩余期限：
			<img src='<%=basePath%>web/sanya/framework/images/red.png'>
			已超时&nbsp;&nbsp;&nbsp;
			<img src='<%=basePath%>web/sanya/framework/images/yellow.png'>
			不足<%=dbts%>个工作日&nbsp;&nbsp;&nbsp;
			<img src='<%=basePath%>web/sanya/framework/images/green.png'>
			超过<%=dbts%>个工作日 &nbsp;&nbsp;&nbsp;
			<br />
			<br />
			<!-- 督办案件将会红色高亮显示&nbsp;&nbsp;&nbsp; -->
		</div>
	</body>
</html>