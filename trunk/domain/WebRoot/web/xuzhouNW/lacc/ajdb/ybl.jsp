<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="/WEB-INF/taglib/queryLabel.tld" prefix="common"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String condition = request.getParameter("condition");
    if (condition != null && !"".equals(condition)) {
        condition = UtilFactory.getStrUtil().unescape(condition);
    } else {
        condition = "";
    }
    String accord = request.getParameter("accord");
    String parameters = "&condition="
            + UtilFactory.getStrUtil().escape(UtilFactory.getStrUtil().escape(condition))
            + "&accord=" + accord;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>立案查处未查处</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script src="<%=basePath%>/base/include/ajax.js"></script>
		<%@ include file="/base/include/ext.jspf"%>
		<style type="text/css">
html,body {
	font: normal 12px verdana;
	margin: 0;
	padding: 0;
	border: 0 none;
	overflow: hidden;
	height: 100%;
	width: 100%;
}

input,img {
	vertical-align: middle;
}
</style>
		<script type="text/javascript">
 var myData;
 var grid;
Ext.onReady(function(){
myData= ajaxRequest("<%=basePath%>", "lacc", "getYBAJdata", '<%=parameters%>');
	myData=eval(myData);
	//putClientCommond("lacc","getYBAJdata");
	//myData = restRequest();
    // create the data store
    var store = new Ext.data.ArrayStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: '序号'},
           {name: '案件编号'},
           {name: '案件类型'},
           {name: '项目名称'},
           {name: '单位名称'},
           {name: '土地位置'},
           {name: '巡查时间'},
           {name: '巡查情况描述'},
           {name: '巡查人员'},
           {name: '立案时间'},
           {name: '办理状态'},
           {name: '查看'}
        ]
    });
    
    store.load({params:{start:0, limit:10}}); 
    var width=document.body.clientWidth*0.98;
    var height = document.body.clientHeight*0.80;
    grid = new Ext.grid.EditorGridPanel({
        title:"已办案件任务列表",
        store: store,
        columns: [
           {header: '序号',dataIndex:'序号',width: width*0.05, sortable: true},
           {header: '案件编号',dataIndex:'案件编号',width: width*0.1, sortable: true},
           {header: '案件来源类型',dataIndex:'案件来源类型',width: width*0.08, sortable: true},
           {header: '项目名称',dataIndex:'项目名称',width: width*0.1, sortable: true},
           {header: '土地位置',dataIndex:'土地位置',width: width*0.1, sortable: true},
           {header: '巡查时间',dataIndex:'巡查时间',width: width*0.08, sortable: true},
           {header: '巡查情况描述',dataIndex:'巡查情况描述',width: width*0.2, sortable: true},
           {header: '巡查人员',dataIndex:'巡查人员',width: width*0.08, sortable: true},
           {header: '立案时间',dataIndex:'立案时间',width: width*0.08, sortable: true},
           {header: '办理状态',dataIndex:'办理状态',width: width*0.1, sortable: true,editor: 
              new Ext.form.ComboBox({     
              store:new Ext.data.SimpleStore({     
              fields: ['TYPEID', 'TYPENAME'],data: [['调查取证', '调查取证'], ['处理意见', '处理意见'], ['移送', '移送'], ['听证', '听证'], ['处罚决定', '处罚决定'], ['执行', '执行'], ['结案备案', '结案备案'], ['归档', '归档']]}),
              valueField: 'TYPEID', displayField: 'TYPENAME',      
              editable: true,
              forceSelection: true,
              mode:'local',
              width:150, 
              listWidth:100,     
              blankText:'选择', 
              emptyText:'选择' ,
              triggerAction: 'all'})   },
           
           {header: '详细',dataIndex:'序号',width: width*0.05, sortable: false,renderer:pro}
        ],
        tbar:[
        	{xtype:'label',text:'快速查找:',width:60},
        	{xtype:'textfield',id:'keyword',width:450,emptyText:'请输入关键字进行查询'},
        	{xtype: 'button',text:'查询',handler: query}
        ],
        listeners:{
		  			rowdblclick : function(grid, rowIndex, e)
					{
				   		// showDetail(grid.getStore().getAt(rowIndex).data.XIANGXI);
				   		process(grid.getStore().getAt(rowIndex).data.INDEX);
					}
        },        
        // stripeRows: true,
        // height: 453,
        height: height,
        // config options for stateful behavior
        stateful: true,
        stateId: 'grid',
        bbar: new Ext.PagingToolbar({
        pageSize: 10,
        store: store,
        displayInfo: true,
            displayMsg: '共{2}条，当前为：{0} - {1}条',
            emptyMsg: "无记录",
        plugins: new Ext.ux.ProgressBarPager()
        })
    });
    
    grid.render('mygrid_container'); 
   
//	Ext.getCmp('keyword').setValue("");
});

//立案功能
function check(){
   
   return "<img src='<%=basePath%>web/default/lacc/image/lian.png'/>";
	
}



function pro(id){
 id=id-1;
 return "<a href='#'onclick='process("+id+");return false;'><img src='<%=basePath%>web/default/lacc/image/view.png' alt='办理'></a>";
}


function process(id){
	var zfjcType=myData[id][12];
	var yw_guid = "AJ201112211109";
	//var url='<%=basePath%>common/pages/resourcetree/resourceTree.jsp?zfjcType=7&yw_guid='+myData[id][1]; 
	
	var url='<%=basePath%>common/pages/resourcetree/resourceTree.jsp?zfjcType=7&yw_guid='+yw_guid;
	window.open(url,'_blank','height=100, width=400, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no, fullscreen=yes'); 
}
function viewDetail(){
	var rowIndex = grid.store.indexOf(grid.getSelectionModel().getSelected());
	process(grid.getSelectionModel().getSelected().json[0]-1);  
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

function query(){
var condition=Ext.getCmp('keyword').getValue();

condition=escape(escape(condition));
document.location.href="<%=basePath%>web/default/lacc/finish.jsp?condition="+condition;
}
</script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
	
		<div id="mygrid_container" style="width: 100%; height: 100%;"></div>
		<div id="win1" class="x-hidden">
			<div id="import"></div>
		</div>
	</body>
</html>