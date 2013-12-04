<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
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
		<title>基本斑列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
		<script type="text/javascript"
			src="<%=basePath%>/web/cbd/yzt/RowEditor.js"></script>
		<style type="text/css">
.list_title_c {
	height: 30px;
	text-align: center;
	margin-top: 3px;
	border-bottom: 1px solid #D0D0D0;
}

.tableheader {
	color: #000000;
	font-size: 12px;
	height: 30px;
	width: 100%;
	margin-bottom: 0px;
	border-bottom: 1px solid #8DB2E3;
}
.div1{
   	float:left;position:relative;left:5px;
   }
   .div2{
   	float:left;margin-left:10px;position:relative;left:0px;
   }
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
			width = document.body.clientWidth;
			var tableWidth = document.body.clientWidth;
			height = document.body.clientHeight * 0.995;
			
			//定义title
 			var con="<div style=\"height:80;width:"+(width)+"; background:url(base/thirdres/ext/examples/image-organizer/images/selected.gif);border-right:1px solid #D0D0D0\" >"+
 			"<table  cellpadding=\"0\" cellspacing=\"0\" align=\"center\" width='tableWidth'>"+
 			"<tr  class=\"tableheader\" >"+
 			"<td rowspan=\"2\" class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0;\" width='" + (width * 0.05) + "'><label>序号</label></td>"+
 			"<td  rowspan=\"2\"  class=\"list_title_c\"  style=\"border-right:1px solid #D0D0D0;\" width='" + (width * 0.05) + "'><label>基本地块编号</label></td>"+
 			"<td class=\"list_title_c\" colspan=\"8\"  style=\"border-right:1px solid #D0D0D0; border-bottom:1px solid #D0D0D0;\" ><label>规划数据（公顷、万㎡）</label></td><td  class=\"list_title_c\"  colspan=\"6\"  style=\"border-right:1px solid #D0D0D0; border-bottom:1px solid #D0D0D0;\" ><label>拆迁数据（万㎡、户）</label></td>"+
 			"<td class=\"list_title_c\" colspan=\"6\"  style=\"border-right:1px solid #D0D0D0; border-bottom:1px solid #D0D0D0;\"  ><label>成本及收益情况(亿元、元/㎡)</label></td>"+
 			"<td rowspan=\"2\" class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0;\" width='" + (width * 0.05) + "'><label>拆迁强度(万㎡/公顷)</label></td><td rowspan=\"2\" class=\"list_title_c\"  style=\"border-right:1px solid #D0D0D0;\" width='" + (width * 0.05) + "'><label>成本覆盖率</label></td>"+
 			"<td rowspan=\"2\" class=\"list_title_c\"  style=\"border-right:1px solid #D0D0D0;\" width='" + (width * 0.05) + "'><label>自然斑</label></td></tr>"+
 			"<tr class=\"tableheader\" ><td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.05)+  "'><label>占地</label></td>"+
 			"<td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.05)+  "'><label>建设用地</label></td><td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.05)+  "'><label>容积率</label></td>"+
 			"<td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.05)+  "'><label>建筑规模</label></td><td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.05)+  "'><label>规划用途</label></td>"+
 			"<td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.05)+  "'><label>公建建筑规模</label></td><td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.05)+  "'><label>居住建筑规模</label></td>"+
 			"<td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.05)+  "'><label>市政建筑规模</label></td><td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.05)+  "'><label>总征收规模</label></td>"+
 			"<td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.05)+  "'><label>住宅征收规模</label></td><td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.05)+  "'><label>住宅征收户数</label></td>"+
 			"<td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.05)+  "'><label>户均面积</label></td><td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.05)+  "'><label>非住宅征收规模</label></td>"+
 			"<td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.05)+  "'><label>非住宅家数</label></td><td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.05)+  "'><label>开发成本</label></td>"+
 			"<td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.05)+  "'><label>楼面成本</label></td><td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.05)+  "'><label>楼面保本点</label></td>"+
 			"<td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.05)+  "'><label>地面成本</label></td><td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.05)+  "'><label>预计政府土地收益</label></td>"+
 			"<td class=\"list_title_c\" style=\"border-right:1px solid #D0D0D0; \" width='" + (width * 0.05)+  "'><label>存蓄比</label></td></tr></table>"
			var ht=con;
			var table = new Ext.Panel({
    			layout:'table',
     			height:80,
    			layoutConfig: {
       				columns: 3
    			},
    			items: [{
                	id: 'xmmc',
                	height:80,
                	html:ht,
                	width:width*2.15+5
    			}]
			});
    	
			//获取数据
			putClientCommond("jbbHandle", "getJbb");
			myData = restRequest();
			store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
				remoteSort:true,
				fields:[
	           		{name: 'XH'},
		           	{name: 'DKMC'},
		           	{name: 'ZD'},
		           	{name: 'JSYD'},
		           	{name: 'RJL'},
		           	{name: 'JZGM'},
		           	{name: 'GHYT'},
		           	{name: 'GJJZGM'},
		           	{name: 'JZJZGM'},
		           	{name: 'SZJZGM'},
		           	{name: 'ZZSGM'},
		           	{name: 'ZZZSGM'},
		           	{name: 'ZZZSHS'},
		           	{name: 'HJMJ'},
		           	{name: 'FZZZSGM'},
		           	{name: 'FZZJS'},
		           	{name: 'KFCB'},
		           	{name: 'LMCB'},
		           	{name: 'LMBBD'},
		           	{name: 'DMCB'},
		           	{name: 'YJZFTDSY'},
		           	{name: 'CXB'},
		           	{name: 'CQQD'},
		           	{name: 'CBFGL'},
		            {name: 'ZRBBH'},
		            {name: 'DKBH'},
		            {name: 'YW_GUID'}
				]
			});
			store.load({params:{start:0, limit:10}});
			grid = new Ext.grid.GridPanel({
				title:'基本斑列表',
		        store: store,
		        region:'center',
                margins: '0 5 5 5',
        	  	hideHeaders: true,
		        columns: [
		           {header: '序号', dataIndex:'XH',width:width*0.03, sortable: false},       
		           {header: '基本地块编号', dataIndex:'DKMC', width:width*0.04, sortable: false,renderer:changKeyword},
		           //{header: '位置查看', dataIndex:'DKBH',width:width*0.05, sortable: false,renderer:view},
		           {header: '占地', dataIndex:'ZD', width:width*0.05-5, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '建设用地', dataIndex:'JSYD',width:width*0.05-5, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '容积率', dataIndex:'RJL',width:width*0.04-5, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '建筑规模', dataIndex:'JZGM', width:width*0.05-5, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '规划用途', dataIndex:'GHYT',width:width*0.04, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '公建建筑规模', dataIndex:'GJJZGM',width:width*0.05-7, sortable: false, editor: {xtype: 'textfield',allowBlank:true},renderer:changKeyword},
		           {header: '居住建筑规模', dataIndex:'JZJZGM',width:width*0.05-7, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '市政建筑规模', dataIndex:'SZJZGM',width:width*0.05-7, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '总征收规模', dataIndex:'ZZSGM',width:width*0.05-7, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '住宅征收规模', dataIndex:'ZZZSGM',width:width*0.05-7, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '住宅征收户数', dataIndex:'ZZZSHS',width:width*0.05-7, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '户均面积', dataIndex:'HJMJ',width:width*0.03, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '非住宅征收规模', dataIndex:'FZZZSGM',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '非住宅家数', dataIndex:'FZZJS',width:width*0.04-3, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '开发成本', dataIndex:'KFCB',width:width*0.04-4, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '楼面成本', dataIndex:'LMCB',width:width*0.05-3, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '楼面保本点', dataIndex:'LMBBD',width:width*0.04-3, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '地面成本', dataIndex:'DMCB',width:width*0.05-4, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '预计政府土地收益', dataIndex:'YJZFTDSY',width:width*0.04, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '存蓄比', dataIndex:'CXB',width:width*0.05-4, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '拆迁强度', dataIndex:'CQQD',width:width*0.04-5, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '成本覆盖率', dataIndex:'CBFGL',width:width*0.04, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '自然斑', dataIndex:'ZRBBH',width:width*0.04, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword}		           
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
        			 
        			  	 var bh=grid.getStore().getAt(r).data.DKBH;
        			 	  showLocation(bh);
        			   
        			} 
        		},  
        		viewConfig: {
        		},      
		        stripeRows: true,
		        forceFit:false,
		        width:width,
		        height: height-30,
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
           putClientCommond("jbbHandle","getQuery");
           putRestParameter("keyWord",escape(escape(keyWord)));
           var myData = restRequest(); 
           store = new Ext.data.JsonStore({
				proxy:new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
					fields:[
	           		{name: 'XH'},
		           	{name: 'DKMC'},
		           	{name: 'ZD'},
		           	{name: 'JSYD'},
		           	{name: 'RJL'},
		           	{name: 'JZGM'},
		           	{name: 'GHYT'},
		           	{name: 'GJJZGM'},
		           	{name: 'JZJZGM'},
		           	{name: 'SZJZGM'},
		           	{name: 'ZZSGM'},
		           	{name: 'ZZZSGM'},
		           	{name: 'ZZZSHS'},
		           	{name: 'HJMJ'},
		           	{name: 'FZZZSGM'},
		           	{name: 'FZZJS'},
		           	{name: 'KFCB'},
		           	{name: 'LMCB'},
		           	{name: 'LMBBD'},
		           	{name: 'DMCB'},
		           	{name: 'YJZFTDSY'},
		           	{name: 'CXB'},
		           	{name: 'CQQD'},
		           	{name: 'CBFGL'},
		            {name: 'ZRBBH'},
		            {name: 'DKBH'},
		            {name: 'YW_GUID'}
					]
			});
          grid.reconfigure(store, new Ext.grid.ColumnModel([
			      {header: '序号', dataIndex:'XH',width:width*0.03, sortable: false},       
		           {header: '基本地块编号', dataIndex:'DKMC', width:width*0.04, sortable: false,renderer:changKeyword},
		           //{header: '位置查看', dataIndex:'DKBH',width:width*0.05, sortable: false,renderer:view},
		           {header: '占地', dataIndex:'ZD', width:width*0.05-5, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '建设用地', dataIndex:'JSYD',width:width*0.05-5, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '容积率', dataIndex:'RJL',width:width*0.04-5, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '建筑规模', dataIndex:'JZGM', width:width*0.05-5, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '规划用途', dataIndex:'GHYT',width:width*0.04, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '公建建筑规模', dataIndex:'GJJZGM',width:width*0.05-7, sortable: false, editor: {xtype: 'textfield',allowBlank:true},renderer:changKeyword},
		           {header: '居住建筑规模', dataIndex:'JZJZGM',width:width*0.05-7, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '市政建筑规模', dataIndex:'SZJZGM',width:width*0.05-7, sortable: false, editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '总征收规模', dataIndex:'ZZSGM',width:width*0.05-7, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '住宅征收规模', dataIndex:'ZZZSGM',width:width*0.05-7, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '住宅征收户数', dataIndex:'ZZZSHS',width:width*0.05-7, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '户均面积', dataIndex:'HJMJ',width:width*0.03, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '非住宅征收规模', dataIndex:'FZZZSGM',width:width*0.05, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '非住宅家数', dataIndex:'FZZJS',width:width*0.04-3, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '开发成本', dataIndex:'KFCB',width:width*0.04-4, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '楼面成本', dataIndex:'LMCB',width:width*0.05-3, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '楼面保本点', dataIndex:'LMBBD',width:width*0.04-3, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '地面成本', dataIndex:'DMCB',width:width*0.05-4, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '预计政府土地收益', dataIndex:'YJZFTDSY',width:width*0.04, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '存蓄比', dataIndex:'CXB',width:width*0.05-4, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '拆迁强度', dataIndex:'CQQD',width:width*0.04-5, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '成本覆盖率', dataIndex:'CBFGL',width:width*0.04, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword},
		           {header: '自然斑', dataIndex:'ZRBBH',width:width*0.04, sortable: false,editor: {xtype: 'textfield',allowBlank: true},renderer:changKeyword}		           
          ]));
          	//重新绑定分页工具栏
			grid.getBottomToolbar().bind(store);
			//重新加载数据集
			store.load({params:{start:0,limit:15}}); 
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
     putClientCommond("jbbHandle","updateJbb");
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
         
  function view(bh){
 		return "<span style='cursor:pointer;'return false;'><img src='base/form/images/view.png' alt='地图位置'></span>";		
 		}
 
 function showLocation(bh){
 //document.getElementById("map");
 // var ring = {"rings":[[[40560762.895622835,3467853.4509063377],[40568435.82763537,3466583.448366333],[40568433.181796744,3467641.7838163367],[40567110.26248424,3465789.696778829],[40567163.17925674,3468065.1179963383],[40565152.341901734,3465578.0296888286],[40565152.341901734,3468012.201223838],[40563511.92195422,3465419.2793713277],[40563511.92195422,3468012.201223838],[40560762.895622835,3465207.612281327],[40560762.895622835,3467853.4509063377]]],"spatialReference":{"wkid":2364}}
  //parent.frames["east"].frames["lower"].swfobject.getObjectById("FxGIS").findFeature('cbd',1,yw_guid,'OBJECTID');
parent.frames['east'].swfobject.getObjectById("FxGIS").findFeature("cbd", "1", bh, "TBBH");
 }		
 		
</script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0" style="overflow: scroll;">
		<div id="mygrid_container" ></div>
		
		<div id="importWin" class="x-hidden">
			<div id="importForm"></div>
		</div>
	</body>
</html>
