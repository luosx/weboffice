<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.console.user.User"%> 
<%@page import="com.klspta.base.util.UtilFactory" %>
<%@page import="com.klspta.console.role.Role" %>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%
	String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    String zfjcType=request.getParameter("zfjcType");
    String year=request.getParameter("year");
    String type=request.getParameter("type");//卫片类型
    String zqbm=request.getParameter("zqbm");//政区编码
    String hczt=request.getParameter("hczt");//核查状态
  //获取当前登录用户
  Object user = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
  User userBean = (User)user;
  //从用户得到所属的角色
  List<Role> role = ManagerFactory.getRoleManager().getRoleWithUserID(userBean.getUserID());
  String []xzqhs=new String [3];
  xzqhs=role.get(0).getXzqh().split(",");
  String hzqhs1=xzqhs[0];
  String hzqhs2="";
  String hzqhs3="";
  if(xzqhs.length==2){
      hzqhs2=xzqhs[1];
  }
  if(xzqhs.length==3){
   hzqhs2=xzqhs[1];
   hzqhs3=xzqhs[2];
   }
   
  Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
      String fullName="";
        if (principal instanceof User) {
            fullName =((User) principal).getFullName();
        }else{
        	fullName=principal.toString();
        }
      System.out.println(fullName);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>执法监察线索管理</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
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
Ext.onReady(function(){
	putClientCommond("wpzfList","getyswfList");
    putRestParameter("year","2011");
    putRestParameter("hczt","<%=hczt%>");
    putRestParameter("hzqhs1","<%=hzqhs1%>");
    putRestParameter("hzqhs2","<%=hzqhs2%>");
    putRestParameter("hzqhs3","<%=hzqhs3%>");
	myData = restRequest();
	store = new Ext.data.JsonStore({
	    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: [
	           {name: 'TBBH'},
	           {name: 'XZQHMC'},
	           {name: 'YEAR'},
	           {name: 'TBMJ'},
	           {name: 'YXJSQMJ'},
	           {name: 'JZJSQMJ'},
	           {name: 'ZYJBNT'},
	           {name: 'ID'},
	           {name: 'ID'},
	        ]
    });
    store.load({params:{start:0, limit:12}});
    var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
    var width=document.body.clientWidth;
    var height=document.body.clientHeight*0.95;
        grid = new Ext.grid.GridPanel({
        store: store,
        sm:sm,
        columns: [
        	sm,
        	{header: '图斑编号', dataIndex:'TBBH', width: width*0.1, sortable: true,renderer:changKeyword},
            {header: '政区名称', dataIndex:'XZQHMC', width: width*0.11, sortable: true,renderer:changKeyword},
            {header: '卫片年度', dataIndex:'YEAR', width: width*0.10, sortable: true,renderer:changKeyword},
            {header: '图斑面积', dataIndex:'TBMJ', width: width*0.10, sortable: true,renderer:changKeyword},
            {header: '允许建设区面积', dataIndex:'YXJSQMJ', width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '禁止建设区面积', dataIndex:'JZJSQMJ', width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '占用基本农田', dataIndex:'ZYJBNT', width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '分析情况', dataIndex:'ID', width: width*0.1, sortable: false,renderer:view},
            {header: '流程受理', dataIndex:'ID', width: width*0.08, sortable: false,renderer:whcButton}
        ],
        
        tbar:[
	    			{xtype:'label',text:'快速查找:',width:60},
	    			{xtype:'textfield',id:'keyword',width:350,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',text:'查询',handler: query}
	    		],
                
        stripeRows: true,
        width:width,
        height: height+10,
        stateful: true,
        stateId: 'grid',
        buttonAlign:'center',
        bbar: new Ext.PagingToolbar({
        pageSize: 12,
        store: store,
        displayInfo: true,
            displayMsg: '共{2}条，当前为：{0} - {1}条',
            emptyMsg: "无记录",
        plugins: new Ext.ux.ProgressBarPager()
        }),
           buttons: [
         {
         	text:'下发',
         	handler: toXiafa
         }]
        });
    grid.render('mygrid_container');
}
)

function view(id){
 return "<a href='#' onclick='viewDetail("+id+");return false;'><img src='../images/view.png' alt='查看'></a>";
}
//下发按钮--转入未核查
function whcButton(id){
	return "<a href='#' onclick='whc("+id+");return false;'><img src='../images/lian.png'></a>";
}

function whc(id){
	//TBBH
	var tbbh=myData[id].TBBH;
	Ext.Msg.confirm("请确认","确定要启动流程吗？", function(button,text){   
                if(button=="yes"){//这个是通过yes or no 来确定的点击值 
					putClientCommond("startWorkflow","startWorkflow");
	                 putRestParameter("zfjcType","7");
	                 putRestParameter("yw_guid",tbbh);
	                 putRestParameter("flag","1");
	                 putRestParameter("lyType","WPZF_TB");
	                 var fullName= escape(escape("<%=fullName%>"));
	                 putRestParameter("fullName",fullName);
	                 var path=restRequest();
	               // window.open("<%=basePath%>"+path.urlPath);
	               // document.location.reload(); 
	               var url=path.urlPath;
	               location.href="<%=basePath%>"+url+"&returnPath=<%=basePath%>/web/xuzhouNW/wpzf/wfTB/wpzfjcyswflist.jsp";
                } 
            });  
}


function viewDetail(id){
	var tbbh=myData[id].TBBH;
	window.open("<%=basePath%>web/xuzhouNW/wpzf/analysis/pdaStatus.jsp?yw_guid=" + tbbh);
}

function viewDetail1(id1,id2,id3){ 
var tbbh=store.getAt(id2).get('TBBH');
window.open("<%=basePath%>web/xuzhouNW/wpzf/pdaStatus.jsp?yw_guid=" + tbbh);
}

function changKeyword(val){
var key=Ext.getCmp('keyword').getValue();
if(key!=''){
  if(String(val).indexOf(key)>=0){
	return val.substring(0,val.indexOf(key))+"<font color='red'><b>"+val.substring(val.indexOf(key),val.indexOf(key)+key.length)+"</b></font>"
	+val.substring(val.indexOf(key)+key.length,val.length);
 }else{
    return val;
 }
}else{
   return val;
}
}   

function query(){
	var keyWord = Ext.getCmp('keyword').getValue();
	keyWord=escape(escape(keyWord));
	putClientCommond("wpzfList","getyswfList");
	putRestParameter("keyWord",keyWord);
	var myData = restRequest(); 
	//alert(myData2);
	var width=document.body.clientWidth  ;
    var height=document.body.clientHeight;
	store = new Ext.data.JsonStore({
	    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: [
	          {name: 'TBBH'},
	           {name: 'XZQHMC'},
	           {name: 'YEAR'},
	           {name: 'TBMJ'},
	           {name: 'YXJSQMJ'},
	           //{name: 'YTJJSQMJ'},
	           //{name: 'XZJSQMJ'},
	           {name: 'JZJSQMJ'},
	           {name: 'ZYJBNT'},
	           {name: 'ID'},
	        ]
    });   
    var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
	grid.reconfigure(store, new Ext.grid.ColumnModel([
			new Ext.grid.RowNumberer(),
        	{header: '图斑编号', dataIndex:'TBBH', width: width*0.10, sortable: true,renderer:changKeyword},
            {header: '政区名称', dataIndex:'XZQHMC', width: width*0.15, sortable: true,renderer:changKeyword},
            {header: '卫片年度', dataIndex:'YEAR', width: width*0.13, sortable: true,renderer:changKeyword},
            {header: '图斑面积', dataIndex:'TBMJ', width: width*0.10, sortable: true,renderer:changKeyword},
            {header: '允许建设区面积', dataIndex:'YXJSQMJ', width: width*0.13, sortable: true,renderer:changKeyword},
            {header: '禁止建设区面积', dataIndex:'JZJSQMJ', width: width*0.13, sortable: true,renderer:changKeyword},
            {header: '占用基本农田', dataIndex:'ZYJBNT', width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '分析情况', dataIndex:'ID', width: width*0.1, sortable: false,renderer:view}
	        ]));
	//重新绑定分页工具栏
	grid.getBottomToolbar().bind(store);//
	//重新加载数据集
	store.load({params:{start:0,limit:12}}); 
}
function toXiafa(){
alert("已下发！！");
}

</script>
	</head>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container"></div>
		<div id="importWin" class="x-hidden">
			<div id="importForm"></div>
		</div>
	</body>
</html>