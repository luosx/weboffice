<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.web.xiamen.xchc.XchcManager"%> 
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String userid = ((User)principal).getUserID();
	String[][] showList = XchcManager.showXCList;
	String xzq = UtilFactory.getXzqhUtil().generateOptionByList(UtilFactory.getXzqhUtil().getChildListByParentId("350200"));
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>动态巡查成果</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf" %>
	<script type="text/javascript">
		var myData;
		var grid;
		var store;
		var xzqstore;
		var limitNum;
		Ext.onReady(function(){
			//将是这个用户填写的巡查日志查询出来
	  		putClientCommond("xchc","getDclList");
		    putRestParameter("userid","<%=userid%>");
			myData = restRequest();
			store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
					fields:[
					<%for(int i = 0; i < showList.length - 1; i++){%>
						{name: '<%=showList[i][0]%>'},
					<%}%>
						{name: '<%=showList[showList.length - 1][0]%>'}
					]
			});
			xzqstore = new Ext.data.JsonStore({
				fields : ['name','code'],
				data :   <%=xzq%>
			});
			width = document.body.clientWidth;
			height = document.body.clientHeight * 0.995;
			limitNum = parseInt(height/31);
			store.load({params:{start:0, limit:limitNum}});
			
			grid = new Ext.grid.GridPanel({
		        store: store,
		        columns: [
		        	new Ext.grid.RowNumberer(),
			<%for(int i = 0; i < showList.length-4; i++){
				if(!"hidden".equals(showList[i][3])){
			%>
				{header: '<%=showList[i][2]%>', dataIndex:'<%=showList[i][0]%>', width: width*<%=Float.parseFloat(showList[i][1])%>, sortable: true,renderer:changKeyword},
			<%}else{%>
				{header: '<%=showList[i][2]%>', dataIndex:'<%=showList[i][0]%>', width: width*<%=Float.parseFloat(showList[i][1])%>, sortable: true,renderer:changKeyword,hidden:true},
				<%}
				}%>
	          	{header: '详细信息', dataIndex:'XIANGXI',width: width*0.05, sortable: false,renderer:view,hidden:true},
	          	{header: '发送短信', dataIndex:'SEND',width: width*0.05, sortable: false,renderer:send},
	          	{header: '立案', dataIndex:'LIAN',width: width*0.05, sortable: false,renderer:lian},
          		{header: '删除',dataIndex:'DELETE',width: width*0.05, sortable: false,renderer:del}
		        ], 
		        tbar:[
		            {xtype:'label',text:'行政区:',width:60},
		            {
		            	id : 'xzqh',
						xtype : 'combo',
						width :100,
						store : xzqstore,
						emptyText:'请选择行政区',
						displayField : 'name',
						valueField : 'code',
						typeAhead : true,
						mode : 'local',
						triggerAction : 'all',
						selectOnFocus : true
		            },
	    			{xtype:'label',text:'  快速查询:',width:60},
	    			{xtype:'textfield',id:'keyword',width:350,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',text:'查询',handler: query}
			    ],  
			    listeners:{
		  			rowdblclick : function(grid, rowIndex, e)
					{
				   		showDetail(rowIndex);
					}
        		},
		        stripeRows: true,
		        width:width,
		        height: height ,
		        stateful: true,
		        stateId: 'grid',
		        buttonAlign:'center',
		        bbar: new Ext.PagingToolbar({
			        pageSize: limitNum,
			        store: store,
			        displayInfo: true,
			            displayMsg: '共{2}条，当前为：{0} - {1}条',
			            emptyMsg: "无记录",
			        plugins: new Ext.ux.ProgressBarPager()
		        }),
     		    buttons: [
		         {
		         	text:'外业成果导入',
		         	handler: impTask
		         }]
        	});
    	grid.render('mygrid_container');
	});
	
	function view(id){
		return "<a href='#' onclick='showDetail(\""+id+"\");return false;'><img src='/domain/base/form/images/view.png' alt='详细信息'></a>";
	}
	function send(id){
		return "<a href='#' onclick='sendMessage(\""+id+"\");return false;'><img src='/domain/base/form/images/message.png' alt='发送短信'></a>";
	}
	function lian(id){
		return "<a href='#' onclick='register(\""+id+"\");return false;'><img src='/domain/base/form/images/record.gif' alt='立案'></a>";
	}
	function del(id){
 		return "<a href='#' onclick='delTask(\""+id+"\");return false;'><img src='/domain/base/form/images/delete.png' alt='删除'></a>";
	}
	
	function delTask(id){
		Ext.MessageBox.confirm('注意', '删除后不能恢复，您确定吗？',function(btn){
		  if(btn=='yes'){
		    var path = "<%=basePath%>";
		    putClientCommond("xchc","delData");
		    putRestParameter("yw_guid",myData[id].GUID)
	        var mes = restRequest(); 
			document.location.reload();
			}
			else{
			return false;
			}
		});
	}
	function showDetail(id){
	    var url = "/domain/web/xiamen/xchc/cglb/xjclyjframe.jsp?zfjcType=11&yw_guid="+myData[id].GUID;     
		//var url = "/domain/web/xiamen/xchc/cglb/xjclyjframe.jsp";
		//window.showModalDialog(url,"","dialogWidth=600px;dialogHeight=268px");
		var height = window.screen.availHeight;
		var width = window.screen.availWidth;
		window.open(url,"","width="+width+",height="+height);
	}
	function sendMessage(id){
		var guid = myData[id].GUID;
		var ydzt = myData[id].YDZT;
		var ydwz = myData[id].YDWZ;
		var zdmj = myData[id].ZDMJ;
		var url = "<%=basePath%>web/xiamen/shortmessage/sendmessage.jsp?guid="+guid+"&ydzt="+escape(escape(ydzt))+"&ydwz="+escape(escape(ydwz))+"&zdmj="+zdmj;
		var top = (window.screen.availHeight-30-600)/2; //获得窗口的垂直位置;
		var left = (window.screen.availWidth-10-800)/2; //获得窗口的水平位置;		
		window.open(url,"","width=800,height=600,top="+top+",left="+left);
	}
	
	function register(id){

  		Ext.MessageBox.confirm('注意', '此案件涉及土地违法，需要立案查处',function(btn){
	  		if(btn=='yes'){
				putClientCommond("xchc","updateState");
				putRestParameter("id",myData[id].GUID);
				var result=restRequest();
				document.location.reload();
				var url = "http://192.168.8.132/xzcf/sys/login/login.aspx";
				var height = window.screen.availHeight;
				var width = window.screen.availWidth;
				window.open(url,"","width="+width+",height="+height);					
			}else{
				return false;
			}
  		});			
	}
	
		<!--查询方法 add by 姚建林 2013-6-20-->
        function query(){
           var keyWord=Ext.getCmp('keyword').getValue();
           var xzqh = Ext.getCmp('xzqh').getValue();
  		   putClientCommond("xchc","getDclList");
	       putRestParameter("userid","<%=userid%>");
           putRestParameter("keyword",escape(escape(keyWord)));
           putRestParameter("xzqh",xzqh);
           myData = restRequest(); 
           store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
					fields:[
					<%for(int i = 0; i < showList.length - 1; i++){%>
						{name: '<%=showList[i][0]%>'},
					<%}%>
						{name: '<%=showList[showList.length - 1][0]%>'}
					]
			});
          grid.reconfigure(store, new Ext.grid.ColumnModel([
        	new Ext.grid.RowNumberer(),
			<%for(int i = 0; i < showList.length-4 ; i++){
				if(!"hidden".equals(showList[i][3])){
			%>
				{header: '<%=showList[i][2]%>', dataIndex:'<%=showList[i][0]%>', width: width*<%=Float.parseFloat(showList[i][1])%>, sortable: true,renderer:changKeyword},
				<%}else{%>
				{header: '<%=showList[i][2]%>', dataIndex:'<%=showList[i][0]%>', width: width*<%=Float.parseFloat(showList[i][1])%>, sortable: true,renderer:changKeyword,hidden:true},
				<%}
				}%>
	          	{header: '详细信息', dataIndex:'XIANGXI',width: width*0.05, sortable: false,renderer:view,hidden:true},
	          	{header: '发送短信', dataIndex:'SEND',width: width*0.05, sortable: false,renderer:send},
	          	{header: '立案', dataIndex:'LIAN',width: width*0.05, sortable: false,renderer:lian},
          		{header: '删除',dataIndex:'DELETE',width: width*0.05, sortable: false,renderer:del}
          ]));
          	//重新绑定分页工具栏
			grid.getBottomToolbar().bind(store);
			//重新加载数据集
			store.load({params:{start:0,limit:limitNum}}); 
        }
        
        function changKeyword(val){
            var key=Ext.getCmp('keyword').getValue().toUpperCase();
            if(key!=''&& val!=null){
              var temp=(""+val).toUpperCase();
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
        
        //导入巡查成果
        function impTask(){
       		var url = "/domain/web/xiamen/xchc/cgdr/importCgfile.jsp";
			//var height = window.screen.availHeight;
			//var width = window.screen.availWidth;
			var retrunValue = window.showModalDialog(url,"","dialogWidth=600px;dialogHeight=268px");
			if(retrunValue=="success"){
				document.location.reload(); 
			}
        }
        
        //新建巡查成果
        function newTask(){
      		var url = "/domain/web/xiamen/xchc/cglb/xjclyjframe.jsp?zfjcType=11";    
        	//window.showModalDialog(url,"","dialogWidth=800px;dialogHeight=600px");
        	window.open(url);
        }
		
		
</script>
</head>
<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
	<div id="mygrid_container" style="width: 100%; height: 85%;"></div>
	<div id="importWin" class="x-hidden">
		<div id="importForm"></div>
	</div>
</body>
</html>
