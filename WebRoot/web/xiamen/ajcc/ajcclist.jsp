<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.web.xiamen.xchc.XchcManager"%> 
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String userid = ((User)principal).getUserID();
	String[][] showList = XchcManager.showLAList;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>案件查处列表</title>
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
		var limitNum;
		Ext.onReady(function(){
			//将是这个用户填写的巡查日志查询出来
	  		putClientCommond("xchc","getYlaList");
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
			width = document.body.clientWidth;
			height = document.body.clientHeight * 0.995;
			limitNum = parseInt(height/31);
			store.load({params:{start:0, limit:limitNum}});
			
			grid = new Ext.grid.GridPanel({
		        store: store,
		        columns: [
		        	new Ext.grid.RowNumberer(),
			<%for(int i = 0; i < showList.length-4; i++){
				if(!"hiddlen".equals(showList[i][2])){
			%>
				{header: '<%=showList[i][2]%>', dataIndex:'<%=showList[i][0]%>', width: width*<%=Float.parseFloat(showList[i][1])%>, sortable: true,renderer:changKeyword},
			<%}}%>
          		{header: '查看',dataIndex:'XIANGXI',width: width*0.05, sortable: false,renderer:view_ck}
		        ], 
		        tbar:[
	    			{xtype:'label',text:'快速查询:',width:60},
	    			{xtype:'textfield',id:'keyword',width:350,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',text:'查询',handler: query}
			    ],  
			    listeners:{
		  			rowdblclick : function(grid, rowIndex, e)
					{
				   		showView_ck(rowIndex);
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
		        })
        	});
    	grid.render('mygrid_container');
	});
	
	
		<!--查询方法 add by 姚建林 2013-6-20-->
        function query(){
           var keyWord=Ext.getCmp('keyword').getValue();
  		   putClientCommond("xchc","getYlaList");
	       putRestParameter("userid","<%=userid%>");
           putRestParameter("keyword",escape(escape(keyWord)));
           var myData = restRequest(); 
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
				if(!"hiddlen".equals(showList[i][2])){
			%>
				{header: '<%=showList[i][2]%>', dataIndex:'<%=showList[i][0]%>', width: width*<%=Float.parseFloat(showList[i][1])%>, sortable: true,renderer:changKeyword},
			<%}}%>
          		{header: '查看',dataIndex:'XIANGXI',width: width*0.05, sortable: false,renderer:view_ck}
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
        
		function view_ck(){
			return "<a href='#' onclick='showView_ck(\""+id+"\");return false;'><img src='/domain/base/form/images/view.png' alt='查看'></a>";
		}
		
		function showView_ck(id){
			var url = "http://192.168.8.132/xzcf/sys/login/login.aspx";
			var height = window.screen.availHeight;
			var width = window.screen.availWidth;
			window.open(url,"","width="+width+",height="+height);	
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
