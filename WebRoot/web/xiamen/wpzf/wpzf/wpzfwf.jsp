<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.web.xiamen.jcl.BuildDTPro"%>
<%@page import="com.klspta.web.xiamen.wpzf.wpzf.WptbManager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String userid = ((User)principal).getUserID();
	String[][] showList = WptbManager.showList_BG;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>合法</title>
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
		Ext.onReady(function(){
			//将是这个用户填写的巡查日志查询出来
	  		putClientCommond("wptb","getWFlist");
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
			
			store.load({params:{start:0, limit:15}});
			width = document.body.clientWidth;
			height = document.body.clientHeight * 0.995;
			
			grid = new Ext.grid.GridPanel({
				title:'巡查日志列表',
		        store: store,
		        columns: [
		        	new Ext.grid.RowNumberer(),
			<%for(int i = 0; i < showList.length - 1; i++){
				if(!"hiddlen".equals(showList[i][2])){
			%>
				{header: '<%=showList[i][2]%>', dataIndex:'<%=showList[i][0]%>', width: width*<%=Float.parseFloat(showList[i][1])%>, sortable: true,renderer:changKeyword},
			<%}}%>
		        {header: '<%=showList[showList.length - 1][2]%>', dataIndex:'<%=showList[showList.length - 1][0]%>', width: width*<%=Float.parseFloat(showList[showList.length - 1][1])%>, sortable: true,renderer:changKeyword}
		        ], 
		        tbar:[
	    			{xtype:'label',text:'快速查询:',width:60},
	    			{xtype:'textfield',id:'keyword',width:350,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',text:'查询',handler: query}
			    ],  
			    listeners:{
		  			rowdblclick : function(grid, rowIndex, e)
					{
						showMap(grid.getStore().getAt(rowIndex).data.YW_GUID);
					}
        		},
		        stripeRows: true,
		        width:width,
		        height: height ,
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
	
	function view(id){
		return "<a href='#' onclick='viewDetail(\""+id+"\");return false;'><img src='web/jizeNW/dtxc/images/view.png' alt='查看'></a>";
	}
	
	function viewDetail(id){
		document.getElementById("choseway").style.display = "";
	}
	
	function showMap(id){
		var url ="/domain/base/fxgis/framework/gisViewFrame.jsp?type=<%=BuildDTPro.CKLX_WP%>&yw_guid="+ id;     
		var height = window.screen.availHeight;
		var width = window.screen.availWidth;
		window.showModalDialog(url,"","dialogWidth="+width+";dialogHeight="+height);
	}
		<!--查询方法 add by 姚建林 2013-6-20-->
        function query(){
           var keyWord=Ext.getCmp('keyword').getValue();
  		   putClientCommond("wptb","getWFlist");
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
			<%for(int i = 0; i < showList.length - 1; i++){
				if(!"hiddlen".equals(showList[i][2])){
			%>
				{header: '<%=showList[i][2]%>', dataIndex:'<%=showList[i][0]%>', width: width*<%=Float.parseFloat(showList[i][1])%>, sortable: true,renderer:changKeyword},
			<%}}%>
				{header: '<%=showList[showList.length - 1][2]%>', dataIndex:'<%=showList[showList.length - 1][0]%>', width: width*<%=Float.parseFloat(showList[showList.length - 1][1])%>, sortable: true,renderer:changKeyword}
          ]));
          	//重新绑定分页工具栏
			grid.getBottomToolbar().bind(store);
			//重新加载数据集
			store.load({params:{start:0,limit:15}}); 
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
</script>
</head>
<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
	<div id="mygrid_container" style="width: 100%; height: 85%;"></div>	
	<div id="importWin" class="x-hidden">
		<div id="importForm"></div>
	</div>
</body>
</html>
