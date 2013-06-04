<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/taglib/queryLabel.tld" prefix="common"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String type = request.getParameter("type");
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
			src="<%=basePath%>/thirdres/ext/examples/ux/PagingMemoryProxy.js"></script>
		<script type="text/javascript"
			src="<%=basePath%>/thirdres/ext/examples/ux/ProgressBarPager.js"></script>
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>/common/css/query.css" />
	</head>
	<script>
    Ext.onReady(function(){
    parent.parent.center.putClientCommond("gpsPosition","getGPSStatusByType");
    parent.parent.center.putRestParameter("type","<%=type%>");
	var myData = parent.parent.center.restRequest();
    function change(val){
     if(val=='运行'){
            return '<span style="color:green;">' + val + '</span>';
     }else if(val=='停止'){
            return '<span style="color:red;">' + val + '</span>';
     }else{
            return '<span style="color:red;">' + val + '</span>';
     }
      return val;
    }
    var store = new Ext.data.ArrayStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
        fields: [
           {name: '编号'},
           {name: '名称'},
           {name: '状态'}
        ]
    });  
       var grid = new Ext.grid.GridPanel({
        store: store, 
        height:300,
        width:300,
        columns: [
            {header: '编号', width: 75},
            {header: '名称', width: 120},
            {header: '状态', width: 100, renderer: change}
        ],
         listeners:{
		       rowclick:function(grid,row){	
		           var tb1=document.getElementById("a");
		           tb1.innerText=store.getAt(row).get('名称');              
		           var tb2=document.getElementById("c");
		           tb2.innerText=store.getAt(row).get('状态');
		           var tb3=document.getElementById("b");
		           tb3.innerText='5km/h';
		           var tb4=document.getElementById("d");
		           tb4.innerText='国土资源局';
		           parent.selectSingle(myData[row][0]); 
		           parent.document.getElementById("showInfo").disabled=false;
		       }
         }      
    });  
    store.load(); 
    grid.render('status_grid');
      setInterval(function(){ 
                  parent.parent.center.putClientCommond("gpsPosition","checkStatusFlag");
				  parent.parent.center.putRestParameter("type","<%=type%>");
				  if('<%=type%>'=='1'){
				     parent.parent.center.putRestParameter("sflag","true");
				     var result = parent.parent.center.restRequest();
			         if(result=="false") myData[0][2]="停止";
			         if(result=="true") myData[0][2]="运行";
				  }
                  store.loadData(myData);    
     },1000); 
 })
	</script>
	<body>
		<div id="status_grid"></div>
		<div style="width: 300px; height: 300px; background-color: #C4E1FF;">
			<table id="statusTable" width="290" border="0" cellpadding="0"
				cellspacing="0"
				style="font-size: 12px; margin-top: 10px; margin-left: 7px">
				<tr>
					<td height="25px" width="139">
						名称：
						<span id="a" style="color: #643200"></span>
					</td>
					<td width="155">
						速度：
						<span id="b" style="color: #643200"></span>
					</td>
				</tr>
				<tr>
					<td height="25px" colspan="2">
						状态：
						<span id="c" style="color: #643200"></span>
					</td>
				</tr>
				<tr>
					<td height="25px" colspan="2">
						地址：
						<span id="d" style="color: #643200"></span>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>