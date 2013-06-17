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
    String userName = ((User) principal).getUsername();
	String fullName = ((User) principal).getFullName();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>立案查处未查处</title>

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
	putClientCommond("lacc","getProcessList");
	putRestParameter("fullName",escape(escape("<%=fullName%>")));
	myData = restRequest();
    var store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
       remoteSort:true,
        fields: [
           {name: 'AJBH'},
           {name: 'AY'},
           {name: 'AJLY'},
           {name: 'DSR'},
           {name: 'SLRQ'},
           {name: 'BAZT'},
           {name: 'JSSJ'},
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
           {header: '立案编号',dataIndex:'AJBH',width: width*0.15, sortable: true},
           {header: '案由',dataIndex:'AY',width: width*0.25, sortable: true},
           {header: '案件来源',dataIndex:'AJLY',width: width*0.05, sortable: true},
           {header: '当事人',dataIndex:'DSR',width: width*0.1, sortable: true},
           {header: '受理日期',dataIndex:'SLRQ',width: width*0.12, sortable: true},
           {header: '办案状态',dataIndex:'BAZT',width: width*0.1, sortable: true},
           {header: '接收时间',dataIndex:'JSSJ',width: width*0.12, sortable: true},
           {header: '办理',dataIndex:'INDEX',width: width*0.08, sortable: false,renderer:pro}
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
 return "<a href='#'onclick='process("+id+");return false;'><img src='<%=basePath%>web/default/lacc/image/view.png' alt='办理'></a>";
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
	var zfjcType="90";
	var returnPath=window.location.href;
	var buttonHien = "delete,la";
	var url='<%=basePath%>web/xuzhouNW/lacc/laccWorkflow/wf.jsp?yw_guid='+yw_guid+'&wfInsId='+wfInsId+'&zfjcType='+zfjcType+'&returnPath='+returnPath+'&buttonHidden='+buttonHien;  
	//window.open(url); 
	document.location.href=url;
}
function viewDetail(){
	var rowIndex = grid.store.indexOf(grid.getSelectionModel().getSelected());
	process(grid.getSelectionModel().getSelected().json[0]-1);  
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

        <!--查询方法 add by 赵伟 2012-9-7-->
        function query(){
           var keyWord=Ext.getCmp('keyword').getValue();
           keyWord=keyWord.toUpperCase();
           putClientCommond("lacc","getProcessList");
           putRestParameter("fullName",escape(escape("<%=fullName%>")));
           putRestParameter("keyWord",escape(escape(keyWord)));
           var myData = restRequest(); 
           var store = new Ext.data.JsonStore({
                proxy: new Ext.ux.data.PagingMemoryProxy(myData),
                remoteSort:true,
                fields: [
                  {name: 'AJBH'},
                  {name: 'AY'},
                  {name: 'AJLY'},
                  {name: 'DSR'},
                  {name: 'SLRQ'},
                  {name: 'BAZT'},
                  {name: 'JSSJ'},
                  {name: 'INDEX'}
                ]
          });
          grid.reconfigure(store, new Ext.grid.ColumnModel([
               // sm,
            //new Ext.grid.RowNumberer(),        
           {header: '立案编号',dataIndex:'AJBH',width: width*0.15, sortable: true},
           {header: '案由',dataIndex:'AY',width: width*0.25, sortable: true},
           {header: '案件来源',dataIndex:'AJLY',width: width*0.05, sortable: true},
           {header: '当事人',dataIndex:'DSR',width: width*0.1, sortable: true},
           {header: '受理日期',dataIndex:'SLRQ',width: width*0.12, sortable: true},
           {header: '办案状态',dataIndex:'BAZT',width: width*0.1, sortable: true},
           {header: '接收时间',dataIndex:'JSSJ',width: width*0.12, sortable: true},
           {header: '办理',dataIndex:'INDEX',width: width*0.08, sortable: false,renderer:pro}
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
         
function sendTask(){
/*
  var ids="";
  var lys="";
  if (grid.getSelectionModel().hasSelection()){
     var records=grid.getSelectionModel().getSelections();
	 for(var i=0;i<records.length;i++){
	   if(i==records.length-1){
	      lys=lys+records[i].get('案件来源');
	      ids=ids+records[i].get('编号');
	   }else{
	      ids=ids+records[i].get('编号')+"@";
	      lys=lys+records[i].get('案件来源')+"@";
	   }
     }
     var lys=encodeURI(encodeURI(lys));
     var path = "<%=basePath%>";
     var actionName = "wyrwmanager";
     var actionMethod = "downTask";
     var parameter="ids="+ids+"&lys="+lys;
	 var zipPath=ajaxRequest(path,actionName,actionMethod,parameter);
     if(zipPath!=""){
			window.open("<%=basePath%>web/default/wpzf/xiafa/expTask.jsp?file_path="+zipPath);
			document.location.reload();
	 } 
  	}else{
    	Ext.Msg.alert('提示','请选择任务！');
  	} 
  	*/
  	window.showModalDialog("<%=basePath%>web/jinan/lacc/lb/xiafa/xiafa.jsp?userName=<%=userName%>","","dialogWidth=650px;dialogHeight=450px;status=no;scroll=no");
    query();
}

function impResult(){
	win.show();
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