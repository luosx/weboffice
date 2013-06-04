<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.klspta.gisapp.components.shtc.ShtcDataOperation"%>
<%@ taglib uri="/WEB-INF/taglib/queryLabel.tld" prefix="common"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String extPath = basePath + "thirdres/ext/";
    String rows=ShtcDataOperation.getInstance().getShtc();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>PDA列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script src="<%=basePath%>/common/js/ajax.js"></script>
		<%@ include file="/common/include/ext.jspf" %>
		<script type="text/javascript"
			src="<%=extPath%>/examples/ux/PagingMemoryProxy.js"></script>
		<script type="text/javascript"
			src="<%=extPath%>/examples/ux/ProgressBarPager.js"></script>
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>/common/css/query.css" />
	</head>
<script>
	var win;
	var updateForm;
	var grid;
	var store;
  Ext.onReady(function(){
	var myData =<%=rows%>;
    store = new Ext.data.ArrayStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
        fields: [
           {name: '编号'},
           {name: '名称'},
           {name: '描述'},
           {name: '类型'},
           {name: '时间'},
           {name: '修改'},
           {name: '删除'}
        ]
    });  
        store.load({params:{start:0, limit:10}});
        var width=document.body.clientWidth;
        var height=document.body.clientHeight;
        grid = new Ext.grid.GridPanel({
        store: store, 
        height: height*0.95,
        columns: [
            {header: '编号', width: width*0.15},
            {header: '名称', width: width*0.15},
            {header: '描述', width: width*0.2},
            {header: '类型', width: width*0.15},
            {header: '时间', hidden: true},
            {header: '修改', width: width*0.15, sortable: false, renderer: modify},        
            {header: '删除', width: width*0.15, sortable: false, renderer: del}
        ],
        bbar: new Ext.PagingToolbar({
        pageSize: 10,
        store: store,
        plugins: new Ext.ux.ProgressBarPager()
        }),
        listeners:{
		       rowclick:function(grid,row){	
		       var layerid=0;
		       if(store.getAt(row).get('类型')=="区域") layerid=2;
		       if(store.getAt(row).get('类型')=="路线") layerid=1;
		       var id=store.getAt(row).get('编号');
		       parent.center.center.queryAndLocation('YZ_EDIT',layerid,"BJID='"+id+"'",7,true);
		 }
       }        
    });  
    store.reload(); 
    store.sort("时间","desc"); 
    grid.render('status_grid');
     updateForm=new Ext.form.FormPanel({
	   applyTo:'updateForm',
	   baseCls: 'x-plain',
       labelWidth:60,	
       width:240, 
       url:"<%=basePath%>shtcDataOperationAC.do?method=saveShtc",
       defaults:{xtype:"textfield",anchor:'100%'},   
       items: [{	
            name:'id',
            id:'id',
            allowBlank: false,
            fieldLabel:'编号'      			
        },{	
            name:'name',
            fieldLabel:'名称'        			
        },{
            xtype:'textarea',
            name: 'describe',
            fieldLabel: '描述'
        },{ 
        	xtype:'radiogroup', 
        	name:'shareflag',
           	fieldLabel: '可见程度',
           	items:[{boxLabel: '所有人', name: 'flag', inputValue: 1, checked: true},
                {boxLabel: '仅自己', name: 'flag', inputValue: 0}]
        },{
            name:'type',
            hidden: true
        },{
            name:'dateflag',
            hidden: true
        }],				
             buttons: [{
                    text:'确定', handler: function() {
                    if (updateForm.getForm().isValid()){  	
			    	  updateForm.form.submit({ 
			 	       waitMsg: '正在保存,请稍候... ', 
				       success:function(form, action){ 
						Ext.MessageBox.alert('提示：',action.result.info); 
						win.hide();
				        document.location.reload();
			           }, 
				       failure:function(form, action){ 
				         Ext.Msg.alert('提示：',action.result.info);
				       } 
				     });
				    }
                   }
                  }]
            });  
             win = new Ext.Window({
                applyTo:'graphwin',
                title:'修改',
                width:280,
                height:240,
                closeAction:'hide',
				items:updateForm
        }); 
   })
  function del(){
   return "<a href='#' onclick='delInfo();return false;'><img src='gisapp/images/delete.png' alt='删除'></a>";
  }
  function modify(){
     return "<a href='#' onclick='modifyShtc();return false;'><img src='gisapp/images/conf.png' alt='修改'></a>";
  }
  
  function modifyShtc(){
    var rowIndex = grid.store.indexOf(grid.getSelectionModel().getSelected());
    Ext.getCmp('id').getEl().dom.readOnly = true;
    updateForm.getForm().findField('id').setValue(store.getAt(rowIndex).get('编号'));
    updateForm.getForm().findField('name').setValue(store.getAt(rowIndex).get('名称'));
    updateForm.getForm().findField('describe').setValue(store.getAt(rowIndex).get('描述'));
    updateForm.getForm().findField('type').setValue(store.getAt(rowIndex).get('类型'));
    updateForm.getForm().findField('dateflag').setValue(store.getAt(rowIndex).get('时间'));
    win.show();
  }
  function delInfo(){ 
    var rowIndex = grid.store.indexOf(grid.getSelectionModel().getSelected());
    var id = store.getAt(rowIndex).get('编号');
    var ringType=store.getAt(rowIndex).get('类型');
    if(ringType=="区域") type="1";
    if(ringType=="路线") type="2";
    if(ringType=="地点") type="3";
    Ext.MessageBox.confirm('注意', '删除后不能恢复，您确定吗？',function(btn){
    if(btn=='yes'){
	    var path = "<%=basePath%>";
	    var actionName = "shtcDataOperationAC";
	    var actionMethod = "delShtc";
	    var parameter="id="+id+"&type="+type;
		var result = ajaxRequest(path,actionName,actionMethod,parameter);
		if(result){
		   var ds = grid.getStore(); 		   
		   var selectedRow = grid.getSelectionModel().getSelected(); 
		   if(selectedRow){
		      ds.remove(selectedRow); 	 
		   }  
		}
	}
	else{
	return false;
	}
   });
  } 

 </script>
	<body>
		 <div id="graphwin" class="x-hidden">
			<div id="updateForm" style="margin-left:10px; margin-top:5px"></div>
		</div>	
		 <div id="status_grid"></div>
	</body>
</html>