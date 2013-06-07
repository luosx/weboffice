<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    String zfjcType=request.getParameter("zfjcType");
    String year=request.getParameter("year");
     String type=request.getParameter("type");//卫片类型
     String zqbm=request.getParameter("zqbm");//政区编码
     String hczt=request.getParameter("hczt");//核查状态
     String status=request.getParameter("status");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>执法监察线索管理</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script src="<%=basePath%>/base/include/ajax.js"></script>
		<%@ include file="/base/include/ext.jspf" %>
		<%@ include file="/base/include/restRequest.jspf" %>
		<script src="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/FileUploadField.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/css/fileuploadfield.css"/>
		<style>
		input,img{vertical-align:middle;}
html, body { 
				margin-left: 0px;
				margin-top: 0px;
				margin-right: 0px;
				margin-bottom: 0px;
	            font: normal 11px verdana;
}
        #main-panel td {
            padding:1.5px;
        }
        .x-grid3-cell-text-visible .x-grid3-cell-inner{overflow:visible;padding:3px 3px 3px 5px;white-space:normal;}
		</style>
		<script type="text/javascript">
		var myData;
	    var grid;
	    var store;
	    var win;
	    var form;
	    var _$ID = '';
	    var width;
Ext.onReady(function(){
	putClientCommond("anjianManager","getWpzfList");
    putRestParameter("year","2011");
    putRestParameter("hczt","<%=hczt%>");
    putRestParameter("status",'<%=status%>');
    putRestParameter("sfhf","1");
	myData = restRequest();
    store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: 'TBBH'},
           {name: 'XZQHMC'},
           {name: 'TBMJ'},
           {name: 'QSX'},
           {name: 'HSX'},
           {name: 'ISHF'},
           {name: 'ROWNUM1'}
        ]
    });
    
    store.load({params:{start:0, limit:15}});
    var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
    width=document.body.clientWidth  ;
    var height=document.body.clientHeight *0.955;
        grid = new Ext.grid.GridPanel({
        store: store,
        sm:sm,
        columns: [
        	//sm,
        	 new Ext.grid.RowNumberer(),
        	{header: '图斑编号', dataIndex:'TBBH', width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '政区名称', dataIndex:'XZQHMC', width: width*0.16, sortable: true,renderer:changKeyword},
            {header: '监测面积', dataIndex:'TBMJ', width: width*0.14, sortable: true},
            {header: '前时相特征', dataIndex:'QSX', width: width*0.2, sortable: true},
            {header: '后时相特征', dataIndex:'HSX', width: width*0.2, sortable: true},
            {header: '分析结果', dataIndex:'ROWNUM1', width: width*0.08, sortable:false,renderer:fxjg},
            {header: '查看', dataIndex:'ROWNUM1', width: width*0.05, sortable: false,renderer:view}
            
        ], 
        
        tbar:[
   			{xtype:'label',text:'快速查找:',width:60},
   			{xtype:'textfield',id:'keyword',width:350,emptyText:'请输入关键字进行查询'},
   			{xtype: 'button',text:'查询',handler: query}
	    ],
        listeners:{
		       rowdblclick: viewDetail1
         },   
        stripeRows: true,
        width:width,
        height: height,
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
        //,
        // buttons: [{
         //	text:'下发核查任务',
        // 	handler: sendTask
        // },{
       //  	text:'立案办结',
        // 	handler: toBj
        // }]
        });
    grid.render('mygrid_container');
    form = new Ext.form.FormPanel({  
	  renderTo:'importForm',
	  labelAlign: 'right',    
	  labelWidth: 60,  
	  frame:true,
	  url: "<%=basePath%>outTaskAC.do?method=impHCResults&flag=3",
	  // width: 500, 
	  width: width, 
	  fileUpload: true,
	  autoHeight: true,
	        bodyStyle: 'padding: 10px 10px 0 10px;',
	        labelWidth: 50,
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
    });  
}
)
function impTask(){
   win.show();
}
//分析结果
function fxjg(id){
 return "<a href='#' onclick='fxjgDetail("+id+");return false;'><img src='base/gis/images/view.png' alt='分析结果'></a>";
}
function fxjgDetail(id){
var yw_guid=myData[id].TBBH;
window.open("<%=basePath%>web/xuzhouNW/wpzf/pdaStatus.jsp?id="+yw_guid);
}
//详细信息
function view(id){
 return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='base/gis/images/view.png' alt='查看'></a>";
}
function viewDetail(id){
var yw_guid=myData[id].TBBH;
     zfjcType=7;
     var activityName='承办';
     url="<%=basePath%>model/resourcetree/resourceTree.jsp?zfjcType="+zfjcType+"&activityName="+activityName+"&yw_guid="+yw_guid;
     location.href=url;
}

function viewDetail1(id1,id2,id3){ 
var yw_guid=store.getAt(id2).get('图斑编号');
window.open("<%=basePath%>web/xuzhouNW/wpzf/pdaStatus.jsp");
}

function sendTask(){
    var ids="";
    if(grid.getSelectionModel().hasSelection()){
     var records=grid.getSelectionModel().getSelections();
	 for(var i=0;i<records.length;i++){
	   if(i==records.length-1){
	      ids=ids+records[i].get('图斑编号');
	   }else{
	      ids=ids+records[i].get('图斑编号')+"@";
	   }
     }
    var path = "<%=basePath%>";
    var actionName = "taskOperation";
    var actionMethod = "sendWPTask";
    var parameter="year=2011&ids="+ids+"&flag=6";
	var zipPath=ajaxRequest(path,actionName,actionMethod,parameter);
	alert(zipPath);
	if(zipPath){
	 window.open("expTask.jsp");
	}
  }else{
    Ext.Msg.alert('提示','请选择任务！');
  }
 }

function sendAllTask(){
	var path = "<%=basePath%>";
    var actionName = "outTaskAC";
    var actionMethod = "sendAllWPTask";
    var parameter="year=<%=year%>&flag=7";
	var zipPath=ajaxRequest(path,actionName,actionMethod,parameter);
	if(zipPath){
	window.open('<%=basePath%>'+zipPath);
	}
  }
  
  
function toBj(){
    var ids="";
    if(grid.getSelectionModel().hasSelection()){
     var records=grid.getSelectionModel().getSelections();
	 for(var i=0;i<records.length;i++){
	   if(i==records.length-1){
	      ids=ids+records[i].get('图斑编号');
	   }else{
	      ids=ids+records[i].get('图斑编号')+"@";
	   }
     }
		putClientCommond("wpstatusdeal","changeWpStatus");
	    putRestParameter("year","2011");
	    putRestParameter("bh",ids);
	    putRestParameter("ajstatus","5");
	    restRequest();
	    document.location.reload();
	  }else{
	    Ext.Msg.alert('提示','请选择案件！');
	  }
}


//查询按钮
function query(){
var keyWord = Ext.getCmp('keyword').getValue();
keyWord=escape(escape(keyWord));
putClientCommond("anjianManager","getWpzfList");
putRestParameter("flag","1");
putRestParameter("status",'<%=status%>');
putRestParameter("keyWord",keyWord);
var myData = restRequest(); 
store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: 'TBBH'},
           {name: 'XZQHMC'},
           {name: 'TBMJ'},
           {name: 'QSX'},
           {name: 'HSX'},
           {name: 'ISHF'},
           {name: 'ROWNUM1'}
        ]
    });
var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn}); 
grid.reconfigure(store, new Ext.grid.ColumnModel([
           new Ext.grid.RowNumberer(),
        	{header: '图斑编号', dataIndex:'TBBH', width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '政区名称', dataIndex:'XZQHMC', width: width*0.16, sortable: true,renderer:changKeyword},
            {header: '监测面积', dataIndex:'TBMJ', width: width*0.14, sortable: true},
            {header: '前时相特征', dataIndex:'QSX', width: width*0.2, sortable: true},
            {header: '后时相特征', dataIndex:'HSX', width: width*0.2, sortable: true},
            {header: '分析结果', dataIndex:'ROWNUM1', width: width*0.08, sortable:false,renderer:fxjg},
            {header: '查看', dataIndex:'ROWNUM1', width: width*0.05, sortable: false,renderer:view}
            
        ]));
//重新绑定分页工具栏
grid.getBottomToolbar().bind(store);//
//重新加载数据集
store.load({params:{start:0,limit:15}});  
}
function changKeyword(val){
var key=Ext.getCmp('keyword').getValue();
if(key!=''){
  if(val.indexOf(key)>=0){
	return val.substring(0,val.indexOf(key))+"<font color='red'><b>"+val.substring(val.indexOf(key),val.indexOf(key)+key.length)+"</b></font>"
	+val.substring(val.indexOf(key)+key.length,val.length);
 }else{
    return val;
 }
}else{
   return val;
}
}

</script>
	</head>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
	<!-- 
	<div align='left' style='font-size: 13px;width:500px;'>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;所在政区：
	<select id="zqbm" >
	<option value="全部">全部</option>
	<option value="370783001">杭州</option>
	<option value="370783003">宁波</option>
	</select>
	卫片图斑类别：
	<select id="type" >
	<option value="全部">全部</option>
	<option value="1">第一类</option>
	<option value="2">第二类</option>
	<option value="3">第三类</option>
	<option value="4">第四类</option>
	<option value="5">第五类</option>
	<option value="6">第六类</option>
	</select>
	<img src='<%=basePath%>web/xuzhouNW/phjg/images/query.png' id='button' onClick='query()' style='border-bottom-width:0px;cursor : hand;position:relative;top:0px;'>
	</div>
	 -->
		<div id="mygrid_container"></div>
		<div id="importWin" class="x-hidden">
			<div id="importForm"></div>
		</div>
		</body>
</html>