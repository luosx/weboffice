<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.web.cbd.dtjc.TjbbManager"%>
<%@page import="com.klspta.web.cbd.yzt.jbb.JbbManager"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String extPath = basePath + "base/thirdres/ext/";
	Map<String, String> proMap = JbbManager.getDKMCMap();
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String userId = ((User)principal).getUserID();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>红线项目列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf" %>
	<script type="text/javascript" src="<%=basePath%>/web/cbd/yzt/RowEditor.js"></script>
	<script type="text/javascript" src="<%=extPath%>examples/ux/MultiSelect.js"></script>
	<script type="text/javascript" src="<%=extPath%>examples/ux/ItemSelector.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=extPath%>examples/ux/css/MultiSelect.css"/>
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
 			window.onscroll = function(){ 
   				editor.positionButtons();
  			 }
			width = document.body.clientWidth - 150;
			var tableWidth = document.body.clientWidth;
			height = document.body.clientHeight * 0.995;

    	
			//获取数据
			putClientCommond("hxxmHandle", "getHxxm");
			myData = restRequest();
			store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
				remoteSort:true,
				fields:[
	           		{name: 'XH'},
	           		{name: 'XMNAME'},
		           	{name: 'ZD'},
		           	{name: 'GM'},
		           	{name: 'HS'},
		           	{name: 'CB'},
		           	{name: 'ZZCQFY'},
		           	{name: 'QYCQFY'},
		           	{name: 'QTFY'},
		           	{name: 'AZFTZCB'},
		           	{name: 'ZZHBTZCB'},
		           	{name: 'CQHBTZ'},
		            {name: 'QTFYZB'},
		           	{name: 'LMCB'},
		           	{name: 'LMBBD'},
		           	{name: 'LMCJJ'},
		           	{name: 'FWSJ'},
		           	{name: 'ZJ'},
		           	{name: 'PGTDJZ'},
		           	{name: 'TYL'},
		           	{name: 'RZSS'},
		           	{name: 'BHDK'},
		           	{name: 'DKMC'},
		           	{name: 'YW_GUID'}
				]
			});
			store.load({params:{start:0, limit:10}});
			grid = new Ext.grid.GridPanel({
				title:'红线项目列表',
		        store: store,
		        region:'center',
                margins: '0 5 5 5',
        		//hideHeaders: true,
		        columns: [
		           {header: '序号', dataIndex:'XH',width: width*0.03, sortable: false,renderer:changKeyword},       
		           {header: '项目名称', dataIndex:'XMNAME', width: width*0.15, sortable: false,renderer:changKeyword},
		          // {header: '位置查看', dataIndex:'XMBH',width:width*0.05, sortable: false,renderer:view}	,
		           {header: '占地', dataIndex:'ZD', width: width*0.05, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '规模', dataIndex:'GM',width: width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '户数', dataIndex:'HS',width: width*0.05, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '成本', dataIndex:'CB', width: width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '住宅拆迁费用', dataIndex:'ZZCQFY',width: width*0.07, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '企业拆迁费用', dataIndex:'QYCQFY',width: width*0.07, sortable: false, editor: {xtype: 'textfield',allowBlank:true},renderer:changKeyword},
		           {header: '其他费用', dataIndex:'QTFY',width: width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '安置房货币投资成本', dataIndex:'AZFTZCB',width: width*0.1, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '住宅货币投资成本', dataIndex:'ZZHBTZCB',width:width*0.1, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '拆迁货币投资', dataIndex:'CQHBTZ',width:width*0.06, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '其他费用占比', dataIndex:'QTFYZB',width:width*0.08, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},  
		     	   {header: '楼面成本', dataIndex:'LMCB',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '楼面保本点', dataIndex:'LMBBD',width:width*0.06, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '楼面成交价', dataIndex:'LMCJJ',width:width*0.06, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '房屋售价', dataIndex:'FWSJ',width:width*0.07, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '租金', dataIndex:'ZJ',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword}, 
		     	   {header: '评估土地价值', dataIndex:'PGTDJZ',width:width*0.08, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '抵押率', dataIndex:'TYL',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '基本地块', dataIndex:'DKMC',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true,listeners:{'focus':function(id){getJbb(id,this);}}},renderer:changKeyword},
		     	   {header: '融资损失', dataIndex:'RZSS',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '包含地块', dataIndex:'BHDK',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword}
		        ], 
		        tbar:[
	    			{xtype:'label',text:'快速查询:',width:60},
	    			{xtype:'textfield',id:'keyword',width:350,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',text:'查询',handler: query}
			    ],  
			    listeners:{
        			'cellmousedown':function(grid,r,c,e){
        			  if(c==2){
        			  	 var bh=grid.getStore().getAt(r).data.XMBH;
        			 	  showLocation(bh);
        			   }
        			} 
        		},  
        		viewConfig: {
        		},      
		        stripeRows: true,
		        width:width*1.49+5,
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
    	
    	var leftDs = new Ext.data.ArrayStore({
	       data: <%=proMap.get("left")%>,
	       fields: ['value','text']
	   	}); 
	  var rightDs = new Ext.data.ArrayStore({ 
	       fields: ['value','text'],
	       sortInfo: {
	           field: 'value',
	           direction: 'ASC'
	       }
	  });
    	
    	winForm = new Ext.form.FormPanel({
	   	bodyStyle: 'padding:10px;',
     	width:550,
        items:[{
          	xtype: 'itemselector',
            name: 'itemselector',
            imagePath: '<%=extPath%>examples/ux/images/',
            fieldLabel: '基本地块列表',
            multiselects:[
         		{
                  width: 180,
                  height: 245,
                  store: leftDs,
                  displayField: 'text',
                  valueField: 'value'
           		},{
	           		  width: 180,
		              height: 245,
		              store: rightDs,
		              displayField: 'text',
	                  valueField: 'value',	
	                  tbar:[{
	                  		text: '清空已选列表',
	                  		handler:function(){
	                  			winForm.getForm().findField('itemselector').reset();
	                  		}
				      }]
			     }	
            ]
            		
         }],
       	buttons: [{
       		text: '保存',
       		handler: function(){
       			if(winForm.getForm().isValid()){
       				var itemselector = winForm.form.findField('itemselector').getValue();
       				//chose.value = itemselector;
       				chose.setValue(itemselector);
       				
       				win.hide();
       			}
       		}
       	},{
		        text: '取消',
       		handler: function(){
				win.hide();
       		}
       	}]
	});
	  
 			   	win = new Ext.Window({
				    layout: 'fit',
				    title: '请选择基本地块',
				    closeAction: 'hide',
				    width:600,
				    height:440,
				    x: 40,
				    y: 110,
				    items:winForm
				});
	});
	

        function query(){
           var keyWord=Ext.getCmp('keyword').getValue();
           putClientCommond("hxxmHandle","getQuery");
           putRestParameter("keyWord",escape(escape(keyWord)));
           var myData = restRequest(); 
           store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
					fields:[
		           	{name: 'XH'},
	           		{name: 'XMNAME'},
		           	{name: 'ZD'},
		           	{name: 'GM'},
		           	{name: 'HS'},
		           	{name: 'CB'},
		           	{name: 'ZZCQFY'},
		           	{name: 'QYCQFY'},
		           	{name: 'QTFY'},
		           	{name: 'AZFTZCB'},
		           	{name: 'ZZHBTZCB'},
		           	{name: 'CQHBTZ'},
		            {name: 'QTFYZB'},
		           	{name: 'LMCB'},
		           	{name: 'LMBBD'},
		           	{name: 'LMCJJ'},
		           	{name: 'FWSJ'},
		           	{name: 'ZJ'},
		           	{name: 'PGTDJZ'},
		           	{name: 'TYL'},
		           	{name: 'RZSS'},
		           	{name: 'BHDK'},
		           	{name: 'XMBH'},
		           	{name: 'YW_GUID'}
					]
			});
          grid.reconfigure(store, new Ext.grid.ColumnModel([
		           {header: '序号', dataIndex:'XH',width: width*0.05, sortable: false,renderer:changKeyword},       
		           {header: '项目名称', dataIndex:'XMNAME', width: width*0.15, sortable: false,renderer:changKeyword},
		           {header: '位置查看', dataIndex:'XMBH',width:width*0.07, sortable: false,renderer:view}	,
		           {header: '占地', dataIndex:'ZD', width: width*0.05, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '规模', dataIndex:'GM',width: width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '户数', dataIndex:'HS',width: width*0.05, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '成本', dataIndex:'CB', width: width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '住宅拆迁费用', dataIndex:'ZZCQFY',width: width*0.1, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '企业拆迁费用', dataIndex:'QYCQFY',width: width*0.1, sortable: false, editor: {xtype: 'textfield',allowBlank:true},renderer:changKeyword},
		           {header: '其他费用', dataIndex:'QTFY',width: width*0.07, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '安置房货币投资成本', dataIndex:'AZFTZCB',width: width*0.12, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '住宅货币投资成本', dataIndex:'ZZHBTZCB',width:width*0.12, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '拆迁货币投资', dataIndex:'CQHBTZ',width:width*0.1, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '其他费用占比', dataIndex:'QTFYZB',width:width*0.1, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},  
		     	   {header: '楼面成本', dataIndex:'LMCB',width:width*0.07, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '楼面保本点', dataIndex:'LMBBD',width:width*0.07, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '楼面成交价', dataIndex:'LMCJJ',width:width*0.08, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '房屋售价', dataIndex:'FWSJ',width:width*0.07, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '租金', dataIndex:'ZJ',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword}, 
		     	   {header: '评估土地价值', dataIndex:'PGTDJZ',width:width*0.1, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '抵押率', dataIndex:'TYL',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '融资损失', dataIndex:'RZSS',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		     	   {header: '包含地块', dataIndex:'BHDK',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword}
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
     putClientCommond("hxxmHandle","updateHxxm");
     //putRestParameter("tbname","jc_xiangmu");
     putRestParameter("tbbh",r.data.YW_GUID); 
     var cc=new Array();
     cc.push(changes);
     putRestParameter("tbchanges",escape(escape(Ext.encode(cc)))); 
     var result = restRequest(); 
     if(result.success){
     	Ext.Msg.alert('提示',"更新成功"); 
     }else{
     	Ext.Msg.alert('提示',"更新失败");
     }
  }        
         
function showLocation(bh){
  // var url="<%=basePath%>"+"base/fxgis/fx/FxGIS.html?initFunction=[{\"name\":\"findFeature\",\"parameters\":\"CBD,1,"+bh+",TBBH\"}]";
   //var hxxm=window.open(url);
   //hxxm.document.title="红线项目";
   parent.frames['east'].swfobject.getObjectById("FxGIS").findFeature("cbd", "1", bh, "TBBH");
   }
function getJbb(id,check){
	chose = check;
   	win.show();
}      
function toRecord(){
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
