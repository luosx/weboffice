<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
String userid = ((User)principal).getUserID();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>变更调查数据列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf" %>
	<script src="<%=basePath%>/base/fxgis/framework/js/json2.js"></script>
  </head>
  <script type="text/javascript">
  	var myData;
  	var store;
  	var limitNum;
  	Ext.onReady(function(){
  		putClientCommond("tdbgdc","getBGList");
	    putRestParameter("userid","<%=userid%>");
		myData = restRequest();
  		store = new Ext.data.JsonStore({
	        proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: [
       			{name:'YW_GUID'},
	           {name: 'TBBH'},
	           {name: 'XMC'},
	           {name: 'XZDM'}
	        ]
  	  	});
		width = document.body.clientWidth-10;
		height = document.body.clientHeight * 0.995;
		limitNum = parseInt(height/25);
		
		store.load({params:{start:0, limit:limitNum}});
		grid = new Ext.grid.GridPanel({
		     store: store,
		     columns: [
		        {header: '图斑编号', dataIndex:'TBBH', width: width*0.5, sortable: true,renderer:changKeyword},
		        {header: '行政区', dataIndex:'XMC', width: width*0.5, sortable: true,renderer:changKeyword}
		     ], 
	        tbar:[
    			{xtype:'textfield',id:'keyword',width:150,emptyText:'请输入关键字进行查询'},
    			{xtype: 'button',text:'查询',handler: query}
		    ],  
		    listeners:{
	  			rowclick : function(grid, rowIndex, e)
				{   
					var tbbh = grid.getStore().getAt(rowIndex).data.TBBH;
					var xzdm = grid.getStore().getAt(rowIndex).data.XZDM;
					showMap(tbbh,xzdm);
				}
       		},
	        stripeRows: true,
	        width:width+10,
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
  	})
  	
  	function showMap(tbbh,xzdm){
  		/*
  		//获取中心点坐标
  		putClientCommond("wptb","getZXDList");
	    putRestParameter("objectId",yw_guid);
		myData = restRequest();
		var flexObject = parent.frames['right'].frames["center"].frames["lower"].swfobject.getObjectById("FxGIS");
  		flexObject.clear();
		flexObject.findFeature('jz_yw',0,yw_guid,'OBJECTID');
  		flexObject.drawPoint("[{\"y\":"+myData[0].YZB+",\"x\":"+myData[0].XZB+",\"icon\":\"a.png\",\"url\":\"web/xiamen/wpzf/wpzf/djfx.jsp\"}]");
  		*/
  		putClientCommond("tdbgdc","getWkt");
	    putRestParameter("tbbh",tbbh);
	    putRestParameter("xzdm",xzdm);
		var res = restRequest(); 
		res = JSON.stringify(res);
  		var flexObject = parent.frames['right'].frames["center"].frames["lower"].swfobject.getObjectById("FxGIS");
  		flexObject.clear();
  		flexObject.doLocation(res);
  		//flexObject.doLocation("{\"rings\":[[[60265.03097703,10789.92030516],[60258.11421995,10818.92207053],[60235.05370561,10870.75837163],[60151.16113747,10825.86863531],[60148.81124883,10824.09765788],[60158.40985556,10804.06652389],[60173.08599036,10802.88063078],[60174.26210331,10779.34956523],[60189.55760719,10777.87886508],[60175.68573298,10768.0143837],[60181.61603558,10756.11240031],[60190.1705737,10758.83434781],[60194.55806713,10760.23042252],[60195.218365,10759.34060586],[60197.35309224,10756.46329795],[60265.03097703,10789.92030516],[60265.03097703,10789.92030516]]],\"spatialReference\":{\"wkid\":0}}");  		
  	}
  
   function query(){
      var keyWord=Ext.getCmp('keyword').getValue();
	  putClientCommond("tdbgdc","getBGList");
      putRestParameter("userid","<%=userid%>");
      putRestParameter("keyword",escape(escape(keyWord)));
      var myData = restRequest(); 
 	  store = new Ext.data.JsonStore({
      proxy: new Ext.ux.data.PagingMemoryProxy(myData),
	  remoteSort:true,
      fields: [
     	  {name:'YW_GUID'},
          {name: 'TBBH'},
          {name: 'XMC'},
          {name: 'XZDM'}
       ]
	  });
      grid.reconfigure(store, new Ext.grid.ColumnModel([
      {header: '图斑编号', dataIndex:'TBBH', width: width*0.5, sortable: true,renderer:changKeyword},
      {header: '行政区', dataIndex:'XMC', width: width*0.5, sortable: true,renderer:changKeyword}
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
  </script>
  <body>
  	<div id="mygrid_container" style="width: 100%; height: 85%;"></div>	  	
  </body>
</html>
