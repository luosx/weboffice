<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.console.role.Role" %>
<%@page import="com.klspta.base.util.UtilFactory" %>
<%@page import="com.klspta.web.jinan.dtcc.Dxcc"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String userId = ((User) principal).getUserID();
	String xianData=new Dxcc().getXianByUserId(userId);
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
		<base href="<%=basePath%>">

		<title>县分局巡查成果</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
		<script src="<%=basePath%>/base/include/ajax.js"></script>
		<script src="<%=_$basePath%>/base/form/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript"
			src="<%=basePath%>base/thirdres/ext/examples/ux/PagingMemoryProxy.js"></script>
		<script type="text/javascript"
			src="<%=basePath%>base/thirdres/ext/examples/ux/ProgressBarPager.js"></script>
		<script
			src="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/FileUploadField.js"
			type="text/javascript"></script>
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>base/thirdres/ext/examples/ux/fileuploadfield/css/fileuploadfield.css" />
		<script type="text/javascript">
       var myData;
       var grid;
       var width;
       var height;
       var xianStore;
       var xianData=<%=xianData%>;
       var suoStore;
       Ext.onReady(function(){
          //alert('<%=hzqhs1%>');
	       putClientCommond("dtcc","getyswfdclList");
	       putRestParameter("userId",'<%=userId%>');
	       putRestParameter("hzqhs1",'<%=hzqhs1%>');
           putRestParameter("hzqhs2",'<%=hzqhs2%>');
           putRestParameter("hzqhs3",'<%=hzqhs3%>');
           putRestParameter("status", '8');
	       myData = eval(restRequest());
           var store = new Ext.data.JsonStore({
           proxy: new Ext.ux.data.PagingMemoryProxy(myData),
           remoteSort:true,
           fields: [
              {name: 'YW_GUID'},
              {name: 'XCDW'},
              {name: 'XCSJ'},
              {name: 'JSXM'},
              {name: 'SJCLYJ'},
              {name: 'XJCLYJ'},
              {name: 'XCDD'},
              {name: 'INDEX'}
          ]
       });
       
      xianStore=new Ext.data.JsonStore({
      data:xianData,
      fields:["code","name"]
      }); 
      suoStore=new Ext.data.JsonStore({
      data:[],
      fields:["code","name"]
      }); 
      wayStore=new Ext.data.JsonStore({
      data:[{"code":"1","name":"合法"},{"code":"2","name":"进一步审核"},{"code":"3","name":"现场制止"},{"code":"4","name":"下达责令停工通知书"},{"code":"5","name":"建议立案查处"},{"code":"6","name":"其他说明"}],
      fields:["code","name"]
      });
      
           
      store.load({params:{start:0, limit:15}}); 
      width=document.body.clientWidth-20;
      height=document.body.clientHeight;//高度
      grid = new Ext.grid.GridPanel({
          store: store,
          columns: [
        	new Ext.grid.RowNumberer(),        
           {header: '巡查单位',dataIndex:'XCDW',width: width*0.18, sortable: true},
           {header: '巡查时间',dataIndex:'XCSJ',width: width*0.10, sortable: true},
           {header: '巡查地点',dataIndex:'XCDD',width: width*0.15, sortable: true},
           {header: '建设项目',dataIndex:'JSXM',width: width*0.20, sortable: true},
           {header: '所处理意见',dataIndex:'SJCLYJ',width: width*0.15, sortable: true},
           {header: '县处理意见',dataIndex:'XJCLYJ',width: width*0.15, sortable: true},
           {header: '办理',dataIndex:'INDEX',width: width*0.05, sortable: true,renderer:pro}
          ],
          tbar:[
        	{xtype:'combo',id:'xian',store:xianStore,<%=xianData.indexOf("name") == xianData.lastIndexOf("name") ? "disabled:true," : ""%>
										width:120,emptyText:'请选择县区分局...',
										displayField:"name",
										valueField:"code",
										mode:"local",
										triggerAction:"all",
										hidden:true,
										listeners:{
			                              select:{
                                            fn: function(){
                                            Ext.getCmp("suo").getStore().clearData();
 				                            Ext.getCmp("suo").clearValue();
        		                            var temp = Ext.getCmp("xian").getValue();
        		                            var landData=getData(temp);
        		                            suoStore.loadData(landData[0]);       		
                                            }}<%=xianData.indexOf("name") == xianData.lastIndexOf("name") ? ",afterRender:{fn: function(){var firstValue = xianData[0].code;Ext.getCmp('xian').setValue(firstValue);Ext.getCmp('suo').getStore().clearData();Ext.getCmp('suo').clearValue();var temp = Ext.getCmp('xian').getValue();var landData=getData(temp);suoStore.loadData(landData[0]);}} " : ""%>
                                       		
                                        }},'-',
			{xtype:'label',text:' 国土所:',width:45},							
			{xtype:'combo',id:'suo',store:suoStore,emptyText:'请选择国土所...',
										width:120,
										displayField:"name",
										valueField:"code",
										mode:"local",
										triggerAction:"all"},'-',
			{xtype:'label',text:' 巡查日期：',width:45},	
			{xtype:'datefield',emptyText: '开始时间',id:'startdate',width:120,format:'Y-m-d'},'&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;',
    		{xtype:'datefield',emptyText: '结束时间',id:'enddate',width:120,format:'Y-m-d'},'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;',								
        	{xtype:'combo', id:'way', store:wayStore, emptyText:'请选择处理方式...',
        		width:120,
        		displayField:"name",
        		valueField:"code",
        		mode:"local",
        		triggerAction:"all"},
        	{xtype: 'button',text:'查询',handler: query},
        	{xtype: 'button',text:'全部列表',handler: searchall}
          ],
           // stripeRows: true,
          width:width+20,
          height:height*0.99, 
          // config options for stateful behavior
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
      });
      grid.render('mygrid_container'); 
      });	
      function pro(id){
        return "<a href='#'onclick='process("+id+");return false;'><img src='<%=basePath%>web/default/lacc/image/view.png' alt='办理'></a>";
      }


      function process(id){
	     var yw_guid=myData[id].YW_GUID;
	     var returnPath=window.location.href;
	     var sjclyj=myData[id].SJCLYJ
	     var xjclyj=myData[id].XJCLYJ;
	     var flag = '2';
	     url='<%=basePath%>web/jinan/dtxc/xccg/xjclyjframe.jsp?zfjcType=11&yw_guid='+yw_guid+'&returnPath='+returnPath + '&flag=' + flag;
	     document.location.href=url;
      }
      
      function  getData(xzqh){
			var path = "<%=basePath%>";
			var actionName = "xzqh";
			var actionMethod = "getNextPlace";
			var parameter = "code=" + xzqh;
			var Data = ajaxRequest(path, actionName, actionMethod, parameter);
			var obj = eval('(' + Data + ')');
    	    return obj;		
     }
  
     //查询按钮
      function query(){
           var xian = Ext.getCmp('xian').getValue();
           xian=escape(escape(xian));
           var suo = Ext.getCmp('suo').getValue();
           suo=escape(escape(suo));
           var way = Ext.getCmp('way').getValue();
           way=escape(escape(way));
           var startdate=Ext.getCmp('startdate').getValue();
           startdate = Ext.util.Format.date(startdate, 'Y-m-d');
           startdate=escape(escape(startdate));
           var enddate=Ext.getCmp('enddate').getValue();
           enddate = Ext.util.Format.date(enddate,'Y-m-d');
           enddate=escape(escape(enddate));
           putClientCommond("dtcc","getyswfdclList");
           putRestParameter("status",1);
           putRestParameter("hzqhs1",'<%=hzqhs1%>');
           putRestParameter("hzqhs2",'<%=hzqhs2%>');
           putRestParameter("hzqhs3",'<%=hzqhs3%>');
           putRestParameter("status", "0");
           putRestParameter("xian",xian);
           putRestParameter("suo",suo);
           putRestParameter("way",way);
           putRestParameter("startdate",startdate);
           putRestParameter("enddate",enddate);
           putRestParameter("userId",'<%=userId%>');
           myData = restRequest(); 
             store = new Ext.data.JsonStore({
             proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		     remoteSort:true,
             fields: [
                {name: 'YW_GUID'},
                {name: 'XCDW'},
                {name: 'XCSJ'},
                {name: 'JSXM'},
                {name: 'SJCLYJ'},
                {name: 'XJCLYJ'},
                {name: 'XCDD'},
                {name: 'INDEX'}
              ]
             }); 
            grid.reconfigure(store, new Ext.grid.ColumnModel([
               new Ext.grid.RowNumberer(),        
               {header: '巡查单位',dataIndex:'XCDW',width: width*0.18, sortable: true},
               {header: '巡查时间',dataIndex:'XCSJ',width: width*0.10, sortable: true},
               {header: '巡查地点',dataIndex:'XCDD',width: width*0.15, sortable: true},
               {header: '建设项目',dataIndex:'JSXM',width: width*0.20, sortable: true},
               {header: '所处理意见',dataIndex:'SJCLYJ',width: width*0.15, sortable: true},
               {header: '县处理意见',dataIndex:'XJCLYJ',width: width*0.15, sortable: true},
               {header: '办理',dataIndex:'INDEX',width: width*0.05, sortable: true,renderer:pro}
            ]));
           grid.getBottomToolbar().bind(store);
           store.load({params:{start:0,limit:15}});  
}
//查询全部列表
 function searchall(){
           putClientCommond("dtcc","getyswfdclList");
           putRestParameter("userId",'<%=userId%>');
           putRestParameter("hzqhs1",'<%=hzqhs1%>');
           putRestParameter("hzqhs2",'<%=hzqhs2%>');
           putRestParameter("hzqhs3",'<%=hzqhs3%>');
           putRestParameter("xian","");
           putRestParameter("suo","");
           putRestParameter("way","");
           putRestParameter("startdate","");
           putRestParameter("enddate","");
           putRestParameter("status","2");
           myData = restRequest(); 
             store = new Ext.data.JsonStore({
             proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		     remoteSort:true,
             fields: [
                {name: 'YW_GUID'},
                {name: 'XCDW'},
                {name: 'XCSJ'},
                {name: 'JSXM'},
                {name: 'SJCLYJ'},
                {name: 'XJCLYJ'},
                {name: 'XCDD'},
                {name: 'INDEX'}
              ]
             }); 
            grid.reconfigure(store, new Ext.grid.ColumnModel([
               new Ext.grid.RowNumberer(),        
               {header: '巡查单位',dataIndex:'XCDW',width: width*0.18, sortable: true},
               {header: '巡查时间',dataIndex:'XCSJ',width: width*0.10, sortable: true},
               {header: '巡查地点',dataIndex:'XCDD',width: width*0.15, sortable: true},
               {header: '建设项目',dataIndex:'JSXM',width: width*0.20, sortable: true},
               {header: '所处理意见',dataIndex:'SJCLYJ',width: width*0.15, sortable: true},
               {header: '县处理意见',dataIndex:'XJCLYJ',width: width*0.15, sortable: true},
               {header: '办理',dataIndex:'INDEX',width: width*0.05, sortable: true,renderer:pro}
            ]));
           grid.getBottomToolbar().bind(store);
           store.load({params:{start:0,limit:15}});  
}
</script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">

		<div id="mygrid_container" style="width: 100%; height: 80%;"></div>
		<div id="win1" class="x-hidden">
			<div id="import"></div>
		</div>
		<div id="importWin" class="x-hidden">
			<div id="importForm"></div>
		</div>
	</body>
</html>