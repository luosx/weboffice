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
  //String rolename = role.get(0).getRolename();
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
	putClientCommond("wpzfList","getspyswfList");
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
	           {name: 'TBMJ'},
	           {name: 'YEAR'},
	           {name: 'YGMJ'},
	           {name: 'YGBL'},
	           {name: 'XMMC'},
	           {name: 'PZWH'},
	           {name: 'XIAFA'},
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
        	//new Ext.grid.RowNumberer(),
        	{header: '图斑编号', dataIndex:'TBBH', width: width*0.08, sortable: true,renderer:changKeyword},
            {header: '政区名称', dataIndex:'XZQHMC', width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '监测面积', dataIndex:'TBMJ', width: width*0.08, sortable: true,renderer:changKeyword},
            {header: '时间', dataIndex:'YEAR', width: width*0.08, sortable: true,renderer:changKeyword},
            {header: '压盖面积', dataIndex:'YGMJ', width: width*0.08, sortable: true,renderer:changKeyword},
            {header: '压盖比率', dataIndex:'YGBL', width: width*0.08, sortable: true,renderer:changKeyword},
            {header: '项目审批名称', dataIndex:'XMMC', width: width*0.15, sortable: true,renderer:changKeyword},
            {header: '批准文号', dataIndex:'PZWH', width: width*0.15, sortable: true,renderer:changKeyword},
            {header: '下发情况', dataIndex:'XIAFA', width: width*0.06,  sortable: true,renderer:changKeyword},
            {header: '分析情况', dataIndex:'ID', width: width*0.06, sortable: false,renderer:view}
        ],
        
        tbar:[
	    			{xtype:'label',text:'快速查找:',width:60},
	    			{xtype:'textfield',id:'keyword',width:350,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',text:'查询',handler: query}
	    		],
                
        stripeRows: true,
        width:width,
        height: height +10,
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
function viewDetail(id){
	var tbbh=myData[id].TBBH;
	window.open("<%=basePath%>web/xuzhouNW/wpzf/analysis/pdaStatus.jsp?yw_guid=" + tbbh);
}
//下发按钮
function toXiafa(){
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
      Ext.Msg.confirm("请确认","是否要下发案件到待核查列表", function(button,text){   
                if(button=="yes"){//这个是通过yes or no 来确定的点击值 
                	var path = "<%=basePath%>";
    				var actionName = "anjian";
					var actionMethod = "xiaFa";
					var parameter="ids="+ids;
    				var result = ajaxRequest(path,actionName,actionMethod,parameter);
    				if(result == "0"){
    				  //window.open("downCG.jsp?file_path="+result);
    				  Ext.MessageBox.minWidth=200; 
    				  Ext.Msg.alert("已转入待核查，任务已下发！"); 
    				  document.location.reload();
    				}else{
    				  Ext.Msg.alert("下发失败！");
    				}				 
                } 
            });  
  }else{
    Ext.Msg.alert('提示','请选择任务！');
  }
}
function viewDetail1(id1,id2,id3){ 
var tbbh=store.getAt(id2).get('TBBH');
window.open("<%=basePath%>web/xuzhouNW/wpzf/pdaStatus.jsp?yw_guid=" + tbbh);
}

function query(){
	var keyWord = Ext.getCmp('keyword').getValue();
	keyWord=escape(escape(keyWord));
	putClientCommond("wpzfList","getspyswfList");
	putRestParameter("keyWord",keyWord);
	putRestParameter("year","2011");
    putRestParameter("hczt","<%=hczt%>");
    putRestParameter("hzqhs1","<%=hzqhs1%>");
    putRestParameter("hzqhs2","<%=hzqhs2%>");
    putRestParameter("hzqhs3","<%=hzqhs3%>");
	var myData = restRequest(); 
	//alert(myData2);
	var width=document.body.clientWidth  ;
    var height=document.body.clientHeight ;
	store = new Ext.data.JsonStore({
	    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
			remoteSort:true,
	        fields: [
	           {name: 'TBBH'},
	           {name: 'XZQHMC'},
	           {name: 'TBMJ'},
	           {name: 'YEAR'},
	           {name: 'YGMJ'},
	           {name: 'YGBL'},
	           {name: 'XMMC'},
	           {name: 'PZWH'},
	           {name: 'XIAFA'},
	           {name: 'ID'},
	        ]
    });   
    var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
	grid.reconfigure(store, new Ext.grid.ColumnModel([
			sm,
        	new Ext.grid.RowNumberer(),
        	{header: '图斑编号', dataIndex:'TBBH', width: width*0.08, sortable: true,renderer:changKeyword},
            {header: '政区名称', dataIndex:'XZQHMC', width: width*0.12, sortable: true,renderer:changKeyword},
            {header: '监测面积', dataIndex:'TBMJ', width: width*0.08, sortable: true,renderer:changKeyword},
            {header: '时间', dataIndex:'YEAR', width: width*0.08, sortable: true,renderer:changKeyword},
            {header: '压盖面积', dataIndex:'YGMJ', width: width*0.08, sortable: true,renderer:changKeyword},
            {header: '压盖比率', dataIndex:'YGBL', width: width*0.08, sortable: true,renderer:changKeyword},
            {header: '项目审批名称', dataIndex:'XMMC', width: width*0.15, sortable: true,renderer:changKeyword},
            {header: '批准文号', dataIndex:'PZWH', width: width*0.15, sortable: true,renderer:changKeyword},
            {header: '下发情况', dataIndex:'XIAFA', width: width*0.06,  sortable: true,renderer:changKeyword},
            {header: '分析情况', dataIndex:'ID', width: width*0.06, sortable: false,renderer:view}
	        ]));
	//重新绑定分页工具栏
	grid.getBottomToolbar().bind(store);//
	//重新加载数据集
	store.load({params:{start:0,limit:12}}); 
}

function changKeyword(val){
            var key=Ext.getCmp('keyword').getValue().toUpperCase();
            if(key!=''&& val!=null){
              var temp=(""+val).toUpperCase();
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
</script>
	</head>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container"></div>
		<div id="importWin" class="x-hidden">
			<div id="importForm"></div>
		</div>
		</body>
</html>