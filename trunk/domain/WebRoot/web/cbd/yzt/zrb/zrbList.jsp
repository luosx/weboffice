<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String userId = ((User)principal).getUserID();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>自然斑列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf" %>
	<script type="text/javascript" src="<%=basePath%>/web/cbd/yzt/RowEditor.js"></script>
	<style type="text/css">
  		.list_title_c{height:30px; text-align:center; margin-top:3px;border-bottom:1px solid #D0D0D0;}
		.tableheader{color:#000000;font-size: 12px;height:30px;width:100%;margin-bottom:0px;border-bottom:1px solid #8DB2E3;}
	</style>
	<script type="text/javascript">
		var myData;
		var grid;
		Ext.onReady(function(){
		
			Ext.QuickTips.init();
			    // use RowEditor for editing
    		var editor = new Ext.ux.grid.RowEditor({
    			saveText: ' 保存 ',
            	cancelText:' 取消 '
    		});

			width = document.body.clientWidth - 150;
			var tableWidth = document.body.clientWidth;
			height = document.body.clientHeight * 0.995;
			
			//定义title
 			var con="<div style=\"height:60;width:"+tableWidth+"; background:url(base/thirdres/ext/examples/image-organizer/images/selected.gif);border-right:1px solid #D0D0D0\" ><table  cellpadding=\"0\" cellspacing=\"0\" align=\"center\" width='tableWidth'><tr  class=\"tableheader\" ><td rowspan=\"2\" class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0;\" width='" + (width * 0.1 - 17) + "'><label>序号</label></td><td rowspan=\"2\" class=\"list_title_c\"  style=\"border-right:1px solid #D0D0D0;\" width='" + (width * 0.1 - 2) + "'><label>自然斑编号</label></td><td class=\"list_title_c\" rowspan=\"2\"  style=\"border-right:1px solid #D0D0D0;\" width='" + (width*0.1-2) + "'><label>占地面积</label></td><td class=\"list_title_c\" colspan=\"2\"  style=\"border-right:1px solid #D0D0D0; border-bottom:1px solid #D0D0D0;\" width='" + (width* 0.2 - 5) + "'><label>总计</label></td><td  class=\"list_title_c\"  colspan=\"3\"  style=\"border-right:1px solid #D0D0D0; border-bottom:1px solid #D0D0D0;\" width='" + (width * 0.3 - 7)+ "' ><label>住宅拆迁(户、人、㎡)</label></td><td class=\"list_title_c\" colspan=\"2\"  style=\"border-right:1px solid #D0D0D0; border-bottom:1px solid #D0D0D0;\" width='" + (width * 0.2)+ "' ><label>非住宅拆迁(㎡)</label></td><td class=\"list_title_c\" rowspan=\"2\"  style=\"border-right:1px solid #D0D0D0;\" width='140'><label>备注</label></td><td class=\"list_title_c\" rowspan=\"2\"  style=\"border-right:1px solid #D0D0D0;\" width='60'><label>位置查看</label></td></tr><tr class=\"tableheader\" ><td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" ><label>楼座面积</label></td><td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" ><label>拆迁规模</label></td><td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.1)+  "'><label>住宅楼座面积</label></td><td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" +(width * 0.1)+ "'><label>住宅拆迁规模</label></td><td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" +(width * 0.1)+ "'><label>预计户数</label></td><td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" ><label>非住宅楼座面积</label></td><td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" ><label>非住宅拆迁规模</label></td></tr></table>"
			var ht=con;
			var table = new Ext.Panel({
    			layout:'table',
     			height:60,
    			layoutConfig: {
        		// 这里指定总列数The total column count must be specified here
       				columns: 3
    			},
    			items: [{
                	id: 'xmmc',
                	height:60,
                	html:ht,
                	width:tableWidth
    			}]
			});
    	
			//获取数据
			putClientCommond("zrbHandle", "getZrb");
			myData = restRequest();
			store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
				remoteSort:true,
				fields:[
	           		{name: 'YW_GUID'},
		           	{name: 'ZRBBH'},
		           	{name: 'ZDMJ'},
		           	{name: 'LZMJ'},
		           	{name: 'CQGM'},
		           	{name: 'ZZLZMJ'},
		           	{name: 'ZZCQGM'},
		           	{name: 'YJHS'},
		           	{name: 'FZZLZMJ'},
		           	{name: 'FZZCQGM'},
		           	{name: 'BZ'}
				]
			});
			store.load({params:{start:0, limit:10}});
			grid = new Ext.grid.GridPanel({
				title:'自然斑列表',
		        store: store,
		        region:'center',
                margins: '0 5 5 5',
        		hideHeaders: true,
		        columns: [
		           {header: '序号', dataIndex:'YW_GUID',width: width*0.08, sortable: false,renderer:changKeyword},       
		           {header: '自然斑编号', dataIndex:'ZRBBH', width: width*0.1, sortable: false,renderer:changKeyword},
		           {header: '占地面积', dataIndex:'ZDMJ', width: width*0.1, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '楼座面积', dataIndex:'LZMJ',width: width*0.09, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '拆迁规模', dataIndex:'CQGM',width: width*0.09, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '住宅楼座面积', dataIndex:'ZZLZMJ', width: width*0.1, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '住宅拆迁规模', dataIndex:'ZZCQGM',width: width*0.1, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '预计户数', dataIndex:'YJHS',width: width*0.1, sortable: false, editor: {xtype: 'textfield',allowBlank:true},renderer:changKeyword},
		           {header: '非住宅楼座面积', dataIndex:'FZZLZMJ',width: width*0.09, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '非住宅拆迁规模', dataIndex:'FZZCQGM',width: width*0.09, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '备注', dataIndex:'BZ',width: 140, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     		{header: '位置查看', dataIndex:'DKBH',width:50, sortable: false,renderer:view}	
		        ], 
		        tbar:[
	    			{xtype:'label',text:'快速查询:',width:60},
	    			{xtype:'textfield',id:'keyword',width:350,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',text:'查询',handler: query}
			    ],  
			    listeners:{
					'render': function(){ 
            			table.render(grid.tbar); 
        			},
        			'cellmousedown':function(grid,r,c,e){
        			  if(c==11){
        			  	 var bh=grid.getStore().getAt(r).data.ZRBBH;
        			 	  showLocation(bh);
        			   }
        			} 
        		},  
        		viewConfig: {
        			//forceFit: true
        		},      
		        stripeRows: true,
		        width:width+150,
		        height: height-20 ,
		        stateful: true,
		        stateId: 'grid',
		        buttonAlign:'center',
		        plugins: [editor],
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
           var keyWord=Ext.getCmp('keyword').getValue();
           putClientCommond("zrbHandle","getQuery");
           putRestParameter("userId","<%=userId%>");
           putRestParameter("keyWord",escape(escape(keyWord)));
           var myData = restRequest(); 
           store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
					fields:[
			           {name: 'YW_GUID'},
			           {name: 'ZRBBH'},
			           {name: 'ZDMJ'},
			           {name: 'LZMJ'},
			           {name: 'CQGM'},
			           {name: 'ZZLZMJ'},
			           {name: 'ZZCQGM'},
			           {name: 'YJHS'},
			           {name: 'FZZLZMJ'},
			           {name: 'FZZCQGM'},
			           {name: 'BZ'}
					]
			});
          grid.reconfigure(store, new Ext.grid.ColumnModel([
				 {header: '序号', dataIndex:'YW_GUID',width: width*0.08, sortable: false,renderer:changKeyword},       
		           {header: '自然斑编号', dataIndex:'ZRBBH', width: width*0.1, sortable: false,renderer:changKeyword},
		           {header: '占地面积', dataIndex:'ZDMJ', width: width*0.1, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '楼座面积', dataIndex:'LZMJ',width: width*0.09, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '拆迁规模', dataIndex:'CQGM',width: width*0.09, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '住宅楼座面积', dataIndex:'ZZLZMJ', width: width*0.1, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '住宅拆迁规模', dataIndex:'ZZCQGM',width: width*0.1, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '预计户数', dataIndex:'YJHS',width: width*0.1, sortable: false, editor: {xtype: 'textfield',allowBlank:true},renderer:changKeyword},
		           {header: '非住宅楼座面积', dataIndex:'FZZLZMJ',width: width*0.09, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '非住宅拆迁规模', dataIndex:'FZZCQGM',width: width*0.09, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '备注', dataIndex:'BZ',width: 150, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     		{header: '位置查看', dataIndex:'DKBH',width:50, sortable: false,renderer:view}	
          ]));
          	//重新绑定分页工具栏
			grid.getBottomToolbar().bind(store);
			//重新加载数据集
			store.load({params:{start:0,limit:10}}); 
        }

  function view(bh){
 		return "<span style='cursor:pointer;'return false;'><img src='base/form/images/view.png' alt='地图位置'></span>";		
 		}

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
         
   function toSave(obj,changes,r,num){
     putClientCommond("jbbHandle","update");
     putRestParameter("tbname","jc_ziran");
     putRestParameter("tbbh",r.YW_GUID); 
     var cc=new Array();
     cc.push(changes);
     putRestParameter("tbchanges",escape(escape(Ext.encode(cc)))); 
     var result = restRequest(); 
  }
         
function showLocation(bh){
   var url="<%=basePath%>"+"base/fxgis/fx/FxGIS.html?initFunction=[{\"name\":\"findFeature\",\"parameters\":\"CBD,1,"+bh+",TBBH\"}]";
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
