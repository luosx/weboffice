<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.console.role.Role"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
  Object principal = SecurityContextHolder.getContext()
			.getAuthentication().getPrincipal();
  String userName = ((User) principal).getUsername();
  //获取当前登录用户
  Object user = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
  User userBean = (User)user;
  //从用户得到所属的角色
  List<Role> role = ManagerFactory.getRoleManager().getRoleWithUserID(userBean.getUserID());
  //String []xzqhs=new String [3];
  //xzqhs=role.get(0).getXzqh().split(",");
  //Role r=role.get(0);
  //System.out.print(r.getRolename()+"===============================================");
  //String sqlwhere=" and ";
  //if(xzqhs.length==1){
  //  sqlwhere+="t.xzqhdm ='"+xzqhs[0]+"'";
  //}else{
  //  sqlwhere +="(";
	//for(int i=0;i<xzqhs.length;i++){
	//   if(i==xzqhs.length-1){
	//     sqlwhere+="t.xzqhdm ='"+xzqhs[i]+"')";
	//   }else{
	//     sqlwhere+="t.xzqhdm ='"+xzqhs[i]+"' or ";
	//   }
   // }
  //}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>下发</title>
 
	<script src="<%=basePath%>/base/include/ajax.js"></script>
	<%@ include file="/base/include/ext.jspf" %>
	<%@ include file="/base/include/restRequest.jspf"%>
	<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=basePath%>base/thirdres/ext/examples/ux/PagingMemoryProxy.js"></script>
		<script type="text/javascript" src="<%=basePath%>base/thirdres/ext/examples/ux/ProgressBarPager.js"></script>
		<script src="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/FileUploadField.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/css/fileuploadfield.css"/>
  </head>
  	<script>
  	var basePath="<%=basePath%>";
var firstGrid;
var firstGridStore;
var secondGridStore;
var secondGrid; 
var searchText;
var fields;
var cols;
var win;
Ext.onReady(function(){
	putClientCommond("taskManager","getWpzf");
    //putRestParameter("year","2011");
    putRestParameter("status","1@6"); 
    //putRestParameter("xzqh","sqlwhere");
    //putRestParameter("sfhf","1");
    myData = restRequest();
	fields = [
		{name: 'RWBH'},
		{name: 'RWMS'},
		{name: 'XZQH'},
		{name: 'STATUS'}
	];
	
	cols = [
		{header: "任务编号", width: 100, sortable: true, dataIndex: 'RWBH'},
		{header: "任务描述", width: 100, sortable: true, dataIndex: 'RWMS'},
		{header: "行政区划", width: 100, sortable: true, dataIndex: 'XZQH'},
		{header: "核查状态", width: 100, sortable: true, dataIndex: 'STATUS'}
	];
	
    firstGridStore = new Ext.data.JsonStore({
    	proxy: new Ext.ux.data.PagingMemoryProxy(myData),
        remoteSort:true,
        fields:  fields
    });
    firstGridStore.load({params:{start:0,limit:15}});
	
     searchText = new Ext.form.TextField({
		id:'searchText',
		name: 'searchText',
		value:'',
		emptyText:'请输入关键字...',
		width:'150',
		enableKeyEvents : true
	});
	
    firstGrid = new Ext.grid.GridPanel({
	    ddGroup          : 'secondGridDDGroup',
        store            : firstGridStore,
        columns          : cols,
	    enableDragDrop   : true,
        stripeRows       : true,
        //autoExpandColumn : 'TBBH',
        bbar: new Ext.PagingToolbar({
        pageSize: 15,
        store: firstGridStore,
        displayInfo: false
        }),tbar:[
        	    	{xtype: 'button',text:'卫片执法',width:80,handler: wpzf},
        	    	{xtype: 'button',text:'立案查处',width:80,handler: lacc},
        	    	{xtype:'label',text:'',width:40},
	    			{xtype:'label',text:'精确查找:',width:60},
	    			searchText
	    ]
    });
    
    searchText.on('keyup',function(field,e){ 
	   	var keyWord=field.getRawValue();
	    keyWord=escape(escape(keyWord));
		putClientCommond("taskManager","getWpzfList");
		putRestParameter("keyWord",keyWord);
		var myData = restRequest(); 
		firstGridStore = new Ext.data.JsonStore({
	    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: fields
	    });
		firstGrid.reconfigure(firstGridStore, new Ext.grid.ColumnModel(cols));
		firstGrid.getBottomToolbar().bind(firstGridStore);
		firstGridStore.load({params:{start:0,limit:15}});  	
   });
    putClientCommond("taskManager","getDaiFa");
    putRestParameter("status","2@8@9@10"); 
    myData1 = restRequest();
    fields1 = [
		{name: 'RWBH'},
		{name: 'RWMS'},
		{name: 'XZQH'}
	];
	
	cols1 = [
		{header: "任务编号", width: 100, sortable: true, dataIndex: 'RWBH'},
		{header: "任务描述", width: 100, sortable: true, dataIndex: 'RWMS'},
		{header: "行政区划", width: 100, sortable: true, dataIndex: 'XZQH'}
	];
    secondGridStore = new Ext.data.JsonStore({
     proxy: new Ext.ux.data.PagingMemoryProxy(myData1),
        fields : fields1
    });
    secondGridStore.load({params:{start:0,limit:15}});
 secondGrid = new Ext.grid.GridPanel({
	    ddGroup          : 'firstGridDDGroup',
        store            : secondGridStore,
        columns          : cols1,
	    enableDragDrop   : true,
        stripeRows       : true,
        //autoExpandColumn : 'TBBH',
        title            : '待下发任务',
 		 buttons: [{
        	text:'导出核查任务',
        	handler: expTasks
        },{
        	text:'导入核查成果',
        	handler: impResult
        }]  
    });


    var height=document.body.clientHeight-10; 
    var width=document.body.clientWidth-10;
	var displayPanel = new Ext.Panel({
		width        : width,
		height       : height,
		layout       : 'hbox',
		renderTo     : 'panel',
		defaults     : { flex : 1 },
		layoutConfig : { align : 'stretch' },
		items        : [
			firstGrid,
			secondGrid
		]
	});
	    var blankRecord =  Ext.data.Record.create(fields);
        var firstGridDropTargetEl =  firstGrid.getView().scroller.dom;
        var firstGridDropTarget = new Ext.dd.DropTarget(firstGridDropTargetEl, {
                ddGroup    : 'firstGridDDGroup',
                notifyDrop : function(ddSource, e, data){
                        var records =  ddSource.dragData.selections;
                        Ext.each(records, ddSource.grid.store.remove, ddSource.grid.store);
                        firstGrid.store.add(records);
                        //firstGrid.store.sort('TBBH', 'ASC');
                        change("first");
                        return true
                }
        });
        var secondGridDropTargetEl = secondGrid.getView().scroller.dom;
        var secondGridDropTarget = new Ext.dd.DropTarget(secondGridDropTargetEl, {
                ddGroup    : 'secondGridDDGroup',
                notifyDrop : function(ddSource, e, data){
                        var records =  ddSource.dragData.selections;
                        Ext.each(records, ddSource.grid.store.remove, ddSource.grid.store);
                        //secondGrid.store.sort('TBBH', 'ASC');
                        secondGrid.store.add(records);
                        change("second");
                        return true
                }
        });

 form = new Ext.form.FormPanel({  
	  renderTo:'importForm',
	  labelAlign: 'right',    
	  labelWidth: 60,  
	  frame:true,
	  url: "<%=basePath%>service/rest/taskManager/uploadTask",
	  width: 500,  
	  fileUpload: true,
	  autoHeight: true,
	  bodyStyle: 'padding: 10px 10px 0 10px;',
	  labelWidth: 60,
	        defaults: {
	            anchor: '98%',
	            allowBlank: false,
	            msgTarget: 'side'
	        },  
	
	  items: [{
	            xtype: 'fileuploadfield',
	            emptyText: '请选择...',
	            fieldLabel: '文件路径',
	            name: 'file',
	            buttonText: '浏览&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;',
	            buttonCfg: {
	                iconCls: 'upload-icon'
	            }
	        }],  
	    
	  buttons: [{  
	  text: '导入',  
	  handler: function() {
	    var filePath=form.getForm().findField('file').getRawValue();
		var re = /(\\+)/g;  
		var filename=filePath.replace(re,"#"); 
		//对路径字符串进行剪切截取
	    var one=filename.split("#"); 
		//获取数组中最后一个，即文件名
		var two=one[one.length-1]; 
	    //再对文件名进行截取，以取得后缀名
		var three=two.split("."); 
		//获取截取的最后一个字符串，即为后缀名
		var last=three[three.length-1];
		//添加需要判断的后缀名类型
		var tp ="zip";
		//返回符合条件的后缀名在字符串中的位置
		var rs=tp.indexOf(last); 
		//如果返回的结果大于或等于0，说明包含允许上传的文件类型
		if(rs>=0&&filePath!=""){ 
	      form.getForm().submit({  
	        success: function(form, action){            
	           alert('文件导入成功！,共导入'+action.result.msg+'条记录！');  
	           document.location.reload();
	        },  
	        failure: function(){  
	           Ext.Msg.alert('错误', '文件导入失败');  
	        }  
	      });
	    }else if(filePath==""){
	    	Ext.Msg.alert('错误', '请选择需要导入的文件！');
	    }
	    else{
	        Ext.Msg.alert('错误', '导入文件类型错误！请选择zip文件,字母大写');  
	    }  
	   }  
	  },{
	            text: '重置',
	            handler: function(){    
	               form.getForm().reset();
	            }
	        }]  
	  });  
    win = new Ext.Window({
                applyTo:'importWin',
                title:'请选择zip文件',
                width:515,
                height:116,
                closeAction:'hide',
				items:form
    })
});
//拖拽时改变事件
function change(string){
	if(string == "second"){
	  var records= secondGridStore.data.items;
	  do_move(records,string);
	  
	}else if(string =="first"){
	  var records= firstGridStore.data.items;
	  do_move(records,string);  
	  if(records[records.length-1].data.RWMS=="卫片核查"){
	  	wpzf();
	  }	else if(records[records.length-1].data.RWMS=="立案查处"){
	  	lacc();
	  }
	}
}
function do_move(records,string){
	if(records[records.length-1].data.RWMS=="卫片核查"){
	  	putClientCommond("taskManager","downTask");
	  	putRestParameter("ajly","wpzf");
	  	putRestParameter("rwbh",records[records.length-1].data.RWBH);
	  	putRestParameter("fangxiang",string);
    	var myData = restRequest();
	 }else if(records[records.length-1].data.RWMS=="立案查处"){
	 	putClientCommond("taskManager","downTask");
	  	putRestParameter("ajly","lacc");
	  	putRestParameter("rwbh",records[records.length-1].data.RWBH);
	  	putRestParameter("fangxiang",string);
    	var myData = restRequest();
	 }
}
function wpzf(){
    putClientCommond("taskManager","getWpzf");
     putRestParameter("status","1@6"); 
    var myData = restRequest();
    firstGridStore = new Ext.data.JsonStore({
	    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: fields
	    });
    firstGrid.reconfigure(firstGridStore, new Ext.grid.ColumnModel(cols));
    firstGrid.getBottomToolbar().bind(firstGridStore);
	firstGridStore.load({params:{start:0,limit:15}});  	
}

function lacc(){
	putClientCommond("taskManager","getLacc");
	putRestParameter("status","5@3");
    myData = restRequest();
    firstGridStore = new Ext.data.JsonStore({
	    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: fields
	    });
    firstGrid.reconfigure(firstGridStore, new Ext.grid.ColumnModel(cols));
    firstGrid.getBottomToolbar().bind(firstGridStore);
	firstGridStore.load({params:{start:0,limit:15}});  	
}

function expTasks(){
     var ids=""; 
     var lys="";
     var ly = "" ;
     var records= secondGridStore.data.items;
	 for(var i=0;i<records.length;i++){
	   if(i==records.length-1){
	      ids=ids+records[i].data.RWBH;
	   }else{
	      ids=ids+records[i].data.RWBH+"@";
	   }
     }
     for(var i=0;i<records.length;i++){
    
       if(records[i].data.RWMS=="卫片核查")
       ly='wp';
       if(records[i].data.RWMS=="立案查处")
       ly='cc';
	   if(i==records.length-1){
	      lys=lys+ly;
	   }else{
	      lys=lys+ly+"@";
	   }
     }
     	var path = basePath;
        var actionName = "taskManager";
        var actionMethod = "extTasks";
        var parameter="ids="+ids+"&flag="+lys;
	    var zipPath=ajaxRequest(path,actionName,actionMethod,parameter);
    	if(zipPath!=""){
			window.open("expTask.jsp?file_path="+zipPath);
		} 
		document.location.reload();
}
function impResult(){
	win.show();
}

	</script>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
	    <div id="panel"></div>
	    <div id="importWin" class="x-hidden">
			<div id="importForm"></div>
		</div>
	</body>
</html>