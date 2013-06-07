<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    String status=request.getParameter("status");
    String zfjcType=request.getParameter("zfjcType");
    String year=request.getParameter("year");
     String type=request.getParameter("type");//卫片类型
     String zqbm=request.getParameter("zqbm");//政区编码
     String hczt=request.getParameter("hczt");//核查状态
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
	    var sm ;
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
    
    store.load({params:{start:0, limit:9}});
    sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
    width=document.body.clientWidth - 10 ;
    var height=document.body.clientHeight - 10;
        grid = new Ext.grid.GridPanel({
        store: store,
        sm:sm,
        columns: [
        	sm,
        	{header: '图斑编号', dataIndex:'TBBH', width: width*0.10, sortable: true},
            {header: '政区名称', dataIndex:'XZQHMC', width: width*0.15, sortable: true},
            {header: '监测面积', dataIndex:'TBMJ', width: width*0.1, sortable: true},
            {header: '前时相特征', dataIndex:'QSX', width: width*0.2, sortable: true},
            {header: '后时相特征', dataIndex:'HSX', width: width*0.18, sortable: true},
            //{header: '自动分析结果', dataIndex:'ROWNUM1', width: width*0.14, sortable:false,renderer:fxjg},
            {header: '查看', dataIndex:'ROWNUM1', width: width*0.04, sortable: false,renderer:view},
       		{header: '立案', dataIndex:'ROWNUM1', width: width*0.06, sortable: false, renderer:lianButton}
            
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
        pageSize: 9,
        store: store,
        displayInfo: true,
            displayMsg: '共{2}条，当前为：{0} - {1}条',
            emptyMsg: "无记录",
        plugins: new Ext.ux.ProgressBarPager()
        }),
         buttons: [{
         	text:'导入核查成果',
         	handler: impTask
         },
         {
         	text:'设为合法',
         	handler: toHefa
         }]});
    grid.render('mygrid_container');
   
	if("<%=zqbm%>"=="null"||"<%=type%>"=="null"){
		//document.getElementById('zqbm').value="全部";
		//document.getElementById('type').value="全部";
	}else{
	 	//document.getElementById('zqbm').value="<%=zqbm%>";
		//document.getElementById('type').value="<%=type%>";
	}
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
//立案按钮
function lianButton(id){
	return "<a href='#' onclick='lian("+id+");return false;'><img src='base/gis/images/lian.png'></a>";
}
function lian(id){
	//TBBH
	var tbbh=myData[id].TBBH;
	Ext.Msg.confirm("请确认","确定要立案吗？", function(button,text){   
                if(button=="yes"){//这个是通过yes or no 来确定的点击值 
					 putClientCommond("anjianManager","clzWpLa");
    				 //putClientCommond("startWorkflow","startWorkflow");
	                 putRestParameter("zfjcType","7");
	                 putRestParameter("tbbh",tbbh);
	                 putRestParameter("flag","0");
	                 var result=restRequest();
					if(result == '0'){
    				  Ext.Msg.alert("已立案！");  
    				  document.location.reload();
    				}else{
    				  Ext.Msg.alert("立案失败！");
					}	                 
	                 //window.open("<%=basePath%>"+path.urlPath); 
                } 
            });  
}
//合法按钮
function toHefa(){
  var ids="";
  if (grid.getSelectionModel().hasSelection()){
     var records=grid.getSelectionModel().getSelections();
	 for(var i=0;i<records.length;i++){
	   if(i==records.length-1){
	      ids=ids+records[i].get('TBBH');
	   }else{
	      ids=ids+records[i].get('TBBH')+",";
	   }
     }
      Ext.Msg.confirm("请确认","是否要判定为合法案件", function(button,text){   
                if(button=="yes"){//这个是通过yes or no 来确定的点击值 
                	var path = "<%=basePath%>";
    				var actionName = "anjianManager";
					var actionMethod = "changeWpStatus";
					var parameter="ids="+ids;
    				var result = ajaxRequest(path,actionName,actionMethod,parameter);
    				if(result == "0"){
    				  //window.open("downCG.jsp?file_path="+result);
    				  Ext.MessageBox.minWidth=200; 
    				  Ext.Msg.alert("已判定为合法案件！"); 
    				  document.location.reload();
    				}else{
    				  Ext.Msg.alert("判定合法案件失败！");
    				}				 
                } 
            });  
  }else{
    Ext.Msg.alert('提示','请选择任务！');
  }
}
//详细信息
function view(id){
 return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='base/gis/images/view.png' alt='查看'></a>";
}
function viewDetail(id){
var yw_guid=myData[id].TBBH;
zfjcType=7;
window.open("<%=basePath%>model/resourcetree/resourceTree.jsp?zfjcType="+zfjcType+"&yw_guid="+yw_guid);
//var yw_guid=myData[id].TBBH;
//window.open("<%=basePath%>web/xuzhouNW/wpzf/pdaStatus.jsp");
}
function viewDetail1(id1,id2,id3){ 
var yw_guid=store.getAt(id2).get('图斑编号');
window.open("<%=basePath%>web/xuzhouNW/wpzf/pdaStatus.jsp");
}
//分析结果
function fxjg(id){
 return "<a href='#' onclick='fxjgDetail("+id+");return false;'><img src='base/gis/images/view.png' alt='查看'></a>";
}
function fxjgDetail(id){
var yw_guid=myData[id].TBBH;
window.open("<%=basePath%>web/xuzhouNW/wpzf/pdaStatus.jsp?id="+yw_guid);
}
function query(){
var zqbm=document.getElementById('zqbm').value;
var type=document.getElementById('type').value;
document.location.href="<%=basePath%>web/xuzhouNW/wpzf/nw_wptask/wpzfjc_dkxxb.jsp?zqbm="+zqbm+"&hczt=<%=hczt%>&type="+type+"&year=<%=year%>&zfjcType=<%=zfjcType%>";
}

function document.onkeydown() 
{ 
var e=event.srcElement; 
if(event.keyCode==13) 
{ 
document.getElementById("button").click(); 
return false; 
} 
} 
//查询按钮
function query(){
var keyWord = Ext.getCmp('keyword').getValue();
keyWord=escape(escape(keyWord));
putClientCommond("anjianManager","getWpzfList");
putRestParameter("keyWord",keyWord);
putRestParameter("status",'<%=status%>');
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
//var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn}); 
grid.reconfigure(store,new Ext.grid.ColumnModel([
             sm,
            {header: '图斑编号', dataIndex:'TBBH', width: width*0.10, sortable: true,renderer:changKeyword},
            {header: '政区名称', dataIndex:'XZQHMC', width: width*0.15, sortable: true,renderer:changKeyword},
            {header: '监测面积', dataIndex:'TBMJ', width: width*0.1, sortable: true},
            {header: '前时相特征', dataIndex:'QSX', width: width*0.2, sortable: true},
            {header: '后时相特征', dataIndex:'HSX', width: width*0.18, sortable: true},
            //{header: '自动分析结果', dataIndex:'ROWNUM1', width: width*0.14, sortable:false,renderer:fxjg},
            {header: '查看', dataIndex:'ROWNUM1', width: width*0.04, sortable: false,renderer:view},
       		{header: '立案', dataIndex:'ROWNUM1', width: width*0.06, sortable: false, renderer:lianButton}
            
        ]));
//重新绑定分页工具栏
grid.getBottomToolbar().bind(store);
//重新加载数据集
store.load({params:{start:0,limit:12}});  
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