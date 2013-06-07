<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    String flag=request.getParameter("flag");
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
      String fullName="";
        if (principal instanceof User) {
            fullName =((User) principal).getFullName();
        }else{
        	fullName=principal.toString();
        }
        
    String status=request.getParameter("status");//案件状态
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
			
		<title>执法监察总体数据预览</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script src="<%=basePath%>/base/include/ajax.js"></script>
		<%@ include file="/base/include/ext.jspf" %>
		<%@ include file="/base/include/restRequest.jspf" %>
		<script type="text/javascript" src="<%=basePath%>base/thirdres/ext/examples/ux/PagingMemoryProxy.js"></script>
		<script type="text/javascript" src="<%=basePath%>base/thirdres/ext/examples/ux/ProgressBarPager.js"></script>
		<script src="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/FileUploadField.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/css/fileuploadfield.css"/>
		<style>
		input,img{vertical-align:middle;cursor:hand;}
		</style>
		<script type="text/javascript">
		var myData;
		var store;
		var grid;
		var form;
		var win;
		var _$ID = '';
		var scrWidth=screen.availWidth;
    	var scrHeight=screen.availHeight; 
    	var sm;
    	var width;
Ext.onReady(function(){
	putClientCommond("anjianManager","getXcfxList");
    putRestParameter("flag","1");
    putRestParameter("status",<%=status%>);
	myData = restRequest();
    store = new Ext.data.JsonStore({
	    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: [
	           {name: 'GUID'},
	           {name: 'RWBH'},
	           {name: 'XMMC'},
	           {name: 'DWMC'},
	           {name: 'RWLX'},
	           {name: 'WFDD'},
	           {name: 'RWMS'},  
	           {name: 'XCQKMC'},  
	           {name: 'XCR'},  
	           {name: 'XCRQ'},  
	           {name: 'CJZB'},  
	           {name: 'JWZB'},
	           {name: 'IMGNAME'},
	           {name: 'SFWF'}, 
	           {name: 'GPSID'},  
	           {name: 'ROWNUM1'}
	        ]
    });
    
    store.load({params:{start:0, limit:15}});
    width=document.body.clientWidth ;
    var height = document.body.clientHeight ;
  	sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
    grid = new Ext.grid.GridPanel({
        store: store,
        id:'gridID',
        sm:sm,
        columns: [
            sm,
            //new Ext.grid.RowNumberer(),
            {header: '序号',dataIndex:'GUID',width: width*0.12, sortable: true,renderer:changKeyword},
            //{header: '任务编号',dataIndex:'RWBH', width: width*0.1, sortable: true,hidden:true},
            {header: '项目名称',dataIndex:'XMMC', width: width*0.15, sortable: true,renderer:changKeyword},
            {header: '单位名称', dataIndex:'DWMC',width: width*0.08, sortable: true},
          //  {header: '任务类型', dataIndex:'RWLX',width: width*0.1, sortable: true},
            {header: '违法地点', dataIndex:'WFDD',width: width*0.1, sortable: true,renderer:changKeyword},
           // {header: '任务描述',dataIndex:'RWMS', width: width*0.08, sortable: true}, 
            {header: '现场情况描述', dataIndex:'XCQKMC',width: width*0.12, sortable: true}, 
            //{header: '巡查人', dataIndex:'XCR',width: width*0.07, sortable: true},
            {header: '巡查时间', dataIndex:'XCRQ',width: width*0.1, sortable: false,renderer:changKeyword}, 
            {header: '采集坐标', dataIndex:'CJZB',width: width*0.05, sortable: false,hidden:true}, 
            {header: '照片编号', dataIndex:'CJZB',width: width*0.05, sortable: false,hidden:true}, 
            {header: '设备编号', dataIndex:'IMGNAME',width: width*0.04, sortable: false,hidden:true}, 
            {header: '是否违法',dataIndex:'SFWF', width: width*0.08, sortable: true,renderer:changKeyword}, 
            {header: '状态', dataIndex:'GPSID',width:width*0.06, sortable: false, renderer:check},
            {header: '详细信息', dataIndex:'ROWNUM1',width: width*0.08, sortable: false,renderer:view},
            {header: '立案', dataIndex:'ROWNUM1', width: width*0.08, sortable: false, renderer:lianButton}
        ],
        tbar:[
	    			{xtype:'label',text:'快速查找:',width:60},
	    			{xtype:'textfield',id:'keyword',width:350,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',text:'查询',handler: query}
	    ],
        stripeRows: true,
        height: height,
        width:width,
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
        }),
        buttons: [{
        	text:'设为合法',
        	handler: checkLegal
        } ] 		
    }); 
    grid.render('mygrid_container'); 
    
    	  form = new Ext.form.FormPanel({  
		  renderTo:'importForm',
		  labelAlign: 'right',    
		  labelWidth: 60,  
		  frame:true,
		  url: "<%=basePath%>/service/rest/outTaskAC/impTempResults",
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
	    }); 
 });
 //立案按钮
function lianButton(id){
	return "<a href='#' onclick='lian("+id+");return false;'><img src='base/gis/images/lian.png'></a>";
}
function lian(id){
	//guid
	var yw_guid=myData[id].GUID;
	Ext.Msg.confirm("请确认","确定要立案吗？", function(button,text){ 
                if(button=="yes"){//这个是通过yes or no 来确定的点击值 
    				putClientCommond("startWorkflow","startWorkflow");
	                 putRestParameter("zfjcType","7");
	                 putRestParameter("yw_guid",yw_guid);
	                 putRestParameter("lyType","WY_DEVICE_DATA");
	                 putRestParameter("fullName","<%=fullName%>");
	                 //	alert(yw_guid);
	                 var path=restRequest();
	                 
	                // path=eval('(' + path + ')');
	                // alert(path.urlPath);
	                 // window.open("<%=basePath%>"+path.urlPath); 
	                //document.location.reload();
	              document.location.href="<%=basePath%>"+path.urlPath+"&returnPath=<%=basePath%>web/xuzhouNW/ajgl/xcfx/wcl/wclList.jsp?status=1";
                } 
            });   
}
//详细信息
function view(id){
	return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='base/gis/images/view.png'></a>";
}
function viewDetail(id){
var guid=myData[id].GUID;
window.location.href="<%=basePath%>web/xuzhouNW/commandcenter/ExternalNetwork/PADDataList/PADXcInfoTab.jsp?yw_guid="+myData[id].GUID;
}
//合法按钮
function checkLegal(){
  var ids="";
  if (grid.getSelectionModel().hasSelection()){
     var records=grid.getSelectionModel().getSelections();
	 for(var i=0;i<records.length;i++){
	   if(i==records.length-1){
	      ids=ids+records[i].get('GUID');
	   }else{
	      ids=ids+records[i].get('GUID')+",";
	   }
     }
      Ext.Msg.confirm("请确认","是否要判定为合法案件", function(button,text){   
                if(button=="yes"){//这个是通过yes or no 来确定的点击值 
                	var path = "<%=basePath%>";
    				var actionName = "anjianManager";
					var actionMethod = "wlaXcfxSwHa";
					var parameter="ids="+ids;
    				var result = ajaxRequest(path,actionName,actionMethod,parameter);
    				//alert(result)
    				if(result=="0"){
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
function check(){
	  return "<font size='1'>未立案</font>";
}
function impXcTasks(){
  win.show();
}

//查询按钮
function query(){
var keyWord = Ext.getCmp('keyword').getValue();
keyWord=escape(escape(keyWord));
putClientCommond("anjianManager","getXcfxList");
putRestParameter("keyWord",keyWord);
putRestParameter("flag","1");
putRestParameter("status",<%=status%>);
var myData = restRequest(); 
store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
            {name: 'GUID'},
           {name: 'RWBH'},
           {name: 'XMMC'},
           {name: 'DWMC'},
           {name: 'RWLX'},
           {name: 'WFDD'},
           {name: 'RWMS'},  
           {name: 'XCQKMC'},  
           {name: 'XCR'},  
           {name: 'XCRQ'},  
           {name: 'CJZB'},  
           {name: 'JWZB'},
           {name: 'IMGNAME'},
           {name: 'SFWF'}, 
           {name: 'GPSID'},  
           {name: 'ROWNUM1'}
        ]
    });
//var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn}); 
grid.reconfigure(store,new Ext.grid.ColumnModel([
             sm,
             new Ext.grid.RowNumberer(),
      		{header: '序号',dataIndex:'GUID',width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '任务编号',dataIndex:'RWBH', width: width*0.1, sortable: true,hidden:true},
            {header: '项目名称',dataIndex:'XMMC', width: width*0.1, sortable: true,renderer:changKeyword},
            {header: '单位名称', dataIndex:'DWMC',width: width*0.08, sortable: true},
           // {header: '任务类型', dataIndex:'RWLX',width: width*0.1, sortable: true},
            {header: '违法地点', dataIndex:'WFDD',width: width*0.08, sortable: true,renderer:changKeyword},
          //  {header: '任务描述',dataIndex:'RWMS', width: width*0.08, sortable: true}, 
            {header: '现场情况描述', dataIndex:'XCQKMC',width: width*0.12, sortable: true}, 
           // {header: '巡查人', dataIndex:'XCR',width: width*0.07, sortable: true},
            {header: '巡查时间', dataIndex:'XCRQ',width: width*0.1, sortable: false,renderer:changKeyword}, 
            {header: '采集坐标', dataIndex:'CJZB',width: width*0.05, sortable: false,hidden:true}, 
            {header: '照片编号', dataIndex:'CJZB',width: width*0.05, sortable: false,hidden:true}, 
            {header: '设备编号', dataIndex:'IMGNAME',width: width*0.04, sortable: false,hidden:true}, 
            {header: '是否违法',dataIndex:'SFWF', width: width*0.08, sortable: true,renderer:changKeyword}, 
            {header: '状态', dataIndex:'GPSID',width:width*0.06, sortable: false, renderer:check},
            {header: '详细信息', dataIndex:'ROWNUM1',width: width*0.08, sortable: false,renderer:view},
            {header: '立案', dataIndex:'ROWNUM1', width: width*0.08, sortable: false, renderer:lianButton}
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
		<div id="mygrid_container" style="width: 100%; height: 85%;"></div>
		<div id="importWin" class="x-hidden">
			<div id="importForm"></div>
		</div>	
	</body>
</html>
<script>
</script>