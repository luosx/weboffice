<%@ page language="java"  pageEncoding="utf-8"%>
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
	String fullName=((User) principal).getFullName();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>立案查处已查处</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf" %>
		<script type="text/javascript">
var myData;
var grid;
var width;
Ext.onReady(function(){
	putClientCommond("lacc","getCompleteList");
	putRestParameter("fullName",escape(escape("<%=fullName%>")));
	myData = restRequest();
    var store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
       remoteSort:true,
        fields: [
           {name:'AJBH'},
           {name: 'AY'},
           {name: 'AJLY'},
           {name: 'DSR'},
           {name: 'SLRQ'},
           {name: 'BAZT'},
           {name: 'CREATE_'},
           {name: 'YJSJ'},
           {name: 'INDEX'}
        ]
    });
    
    store.load({params:{start:0, limit:15}}); 
     width=document.body.clientWidth;
    var height=document.body.clientHeight*0.95;//高度
    grid = new Ext.grid.GridPanel({
        title:'已办案件',
        store: store,
        columns: [
        	//new Ext.grid.RowNumberer(),
           {header: '立案编号',dataIndex:'AJBH',width: width*0.16, sortable: true,renderer:changKeyword},
           {header: '案由',dataIndex:'AY',width: width*0.20, sortable: true,renderer:changKeyword},
           {header: '案件来源',dataIndex:'AJLY',width: width*0.08, sortable: true,renderer:changKeyword},
           {header: '当事人',dataIndex:'DSR',width: width*0.07, sortable: true,renderer:changKeyword},
           {header: '受理日期',dataIndex:'SLRQ',width: width*0.08, sortable: true,renderer:changKeyword},
           {header: '办案状态',dataIndex:'BAZT',width: width*0.12, sortable: true,renderer:changKeyword},
           {header: '接收时间',dataIndex:'CREATE_',width: width*0.1, sortable: true,renderer:changKeyword},
           {header: '移交时间',dataIndex:'YJSJ',width: width*0.1, sortable: true,renderer:changKeyword},
           {header: '详细',dataIndex:'INDEX',width: width*0.08, sortable: false,renderer:pro}
        ],
        tbar:[
        	{xtype:'label',text:'快速查找:',width:60},
        	{xtype:'textfield',id:'keyword',width:450,emptyText:'请输入关键字进行查询'},
        	{xtype: 'button',id:'query',text:'查询',handler: query}
        ],
        // stripeRows: true,
        height:height+10,  
        width:width,
        // config options for stateful behavior
        stateful: true,
        stateId: 'grid',
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
 //id = id -1;
 return "<a href='#'onclick='process("+id+");return false;'><img src='<%=basePath%>web/xuzhouNW/lacc/dbaj/images/view.png' alt='详细'></a>";
}

function process(id){
	var wfInsId=myData[id].WFINSID;
	var yw_guid=myData[id].YW_GUID;
	var returnPath=window.location.href;
	returnPath = returnPath.split("?")[0] + "&edit=false" ;
	var buttonHidden = "delete,la,tran,back";
	var url='<%=basePath%>model/workflow/wf.jsp?yw_guid='+yw_guid+'&zfjcName=立案查处&zfjcType=90&wfInsId='+wfInsId+'&returnPath='+returnPath+'&buttonHidden='+buttonHidden;  
	//window.open(url); 
	document.location.href=url;
}
function viewDetail(){
	var rowIndex = grid.store.indexOf(grid.getSelectionModel().getSelected());
	process(grid.getSelectionModel().getSelected().json[0]-1);  
}



 function document.onkeydown(){ 
     var e=event.srcElement; 
     if(event.keyCode==13){ 
        Ext.getCmp('keyword').click(); 
        return false; 
     } 
 } 


        <!--查询方法 add by 赵伟 2012-9-7-->
        function query(){
           var keyWord=Ext.getCmp('keyword').getValue();
           keyWord=keyWord.toUpperCase();
           putClientCommond("lacc","getCompleteList");
           putRestParameter("fullName",escape(escape("<%=fullName%>")));
           putRestParameter("keyWord",escape(escape(keyWord)));
           var myData = restRequest(); 
           var store = new Ext.data.JsonStore({
                proxy: new Ext.ux.data.PagingMemoryProxy(myData),
                remoteSort:true,
                fields: [
                {name:'AJBH'},
           {name: 'AY'},
           {name: 'AJLY'},
           {name: 'DSR'},
           {name: 'SLRQ'},
           {name: 'BAZT'},
           {name: 'CREATE_'},
           {name: 'YJSJ'},
           {name: 'INDEX'}
                ]
          });
          grid.reconfigure(store, new Ext.grid.ColumnModel([
        	//    new Ext.grid.RowNumberer(),
           {header: '立案编号',dataIndex:'AJBH',width: width*0.16, sortable: true,renderer:changKeyword},
           {header: '案由',dataIndex:'AY',width: width*0.20, sortable: true,renderer:changKeyword},
           {header: '案件来源',dataIndex:'AJLY',width: width*0.08, sortable: true,renderer:changKeyword},
           {header: '当事人',dataIndex:'DSR',width: width*0.07, sortable: true,renderer:changKeyword},
           {header: '受理日期',dataIndex:'SLRQ',width: width*0.08, sortable: true,renderer:changKeyword},
           {header: '办案状态',dataIndex:'BAZT',width: width*0.12, sortable: true,renderer:changKeyword},
           {header: '接收时间',dataIndex:'CREATE_',width: width*0.10, sortable: true,renderer:changKeyword},
           {header: '移交时间',dataIndex:'YJSJ',width: width*0.10, sortable: true,renderer:changKeyword},
           {header: '详细',dataIndex:'INDEX',width: width*0.08, sortable: false,renderer:pro}
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

		<div id="mygrid_container"></div>
		<div id="win1" class="x-hidden">
			<div id="import"></div>
		</div>
	</body>
</html>