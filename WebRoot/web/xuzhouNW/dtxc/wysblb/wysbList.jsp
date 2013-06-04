<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/taglib/queryLabel.tld" prefix="common"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.console.role.Role" %>
<%@page import="com.klspta.base.util.UtilFactory" %>
<%@page import="com.klspta.web.jinan.dtcc.Dxcc"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%
	String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    String extPath = basePath + "base/thirdres/ext/"; 
    String fromBeanType="gpsFormBean";
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

		<title>PDA列表</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script src="<%=basePath%>/base/include/ajax.js"></script>
		<%@ include file="/base/include/ext.jspf" %>
		<%@ include file="/base/include/restRequest.jspf" %>
	
		 <style>
		input,img{vertical-align:middle;}
		</style>
		<script type="text/javascript">
		var myData;
		var win;
		var store;
		var grid;
		var updateForm;
		var comboStore;
		var width;
		var height;
		var suoStore;
		function initComponent(){		
     	store = new Ext.data.JsonStore({
        proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: 'GPS_ID'},
           {name: 'GPS_NAME'},
           {name: 'GPS_TYPE'},
           {name: 'EQUIPMENT_TYPE'},
           {name: 'GPS_CANTONCODE'},
           {name: '修改'},
           {name: '删除'}
        ]
    });
    
        suoStore=new Ext.data.JsonStore({
    	fields: ['code', 'name'],
        data: [] 
    	});
    	
    	var temp = "<%=hzqhs1%>";
        landData=getData(temp);
        suoStore.loadData(landData[0]); 
    
    store.load({params:{start:0, limit:15}});
      width=document.body.clientWidth;
      height=document.body.clientHeight;
        grid = new Ext.grid.GridPanel({
        store: store,
        columns:[
            {header: '编号', width: width*0.15, sortable: true,renderer:changKeyword},
            {header: '名称', width: width*0.15, sortable: true,renderer:changKeyword},
            {header: '设备类别', width: width*0.15, sortable: true,renderer:changKeyword},
            {header: '设备型号', width: width*0.15, sortable: false,renderer:changKeyword},
            {header: '行政区', width: width*0.15, sortable: false,renderer:changKeyword},
            {header: '修改', width: width*0.1, sortable: false, renderer: modify},
            {header: '删除', width: width*0.1,  ortable: false, renderer: del}
        ],
        tbar:[
	    			{xtype:'label',text:'快速查找:',width:60},
	    			{xtype:'textfield',id:'keyword',width:350,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',id:'button',text:'查询',handler: query}
	    			//{xtype: 'button',id:'button',text:'回退',handler: back},
	    ],
        listeners:{
		       rowdblclick: modifyGPS
         },
        stripeRows: true,
        height: height*0.9,
        stateful: true,
         buttonAlign:'center',
        stateId: 'grid',
        bbar: new Ext.PagingToolbar({
        pageSize: 15,
       // buttons: [{
          //  text: '新增',handler: addGPS
       // }],
        store: store,
        displayInfo: true,
        displayMsg: '共{2}条，当前为：{0} - {1}条',
        emptyMsg: "无记录",
        plugins: new Ext.ux.ProgressBarPager()
        }),
         buttons: [{
         	text:'新增',
         	handler: addGPS
         }]
    });
    grid.render('mygrid_container'); 

	  
	    var comboData=[['1','巡查车'],['2','PDA手持机'],['3','平板电脑']];
	    comboStore = new Ext.data.ArrayStore({
	      proxy: new Ext.ux.data.PagingMemoryProxy(comboData),
          fields: ['value','text']
	    });
	    
	         		  
	    
	    

	   updateForm=new Ext.form.FormPanel({
	   applyTo:'updateForm',
	   baseCls: 'x-plain',
       labelWidth:80,	
       url:"<%=basePath%>/service/rest/dtxcList/saveGPS",
       width:330, 
       defaults:{xtype:"textfield",anchor:'90%'},   
       items: [{	
            name:'GPSId',
            id:'GPSId',
            allowBlank: false,
            fieldLabel:'编号'      			
        },{	
            name:'GPSName',
            id:'GPSName',
            fieldLabel:'名称'        			
        },{ 
        	xtype:'radiogroup', 
           	fieldLabel: '是否启用',
           	items:[{boxLabel: '是', name: 'flag', inputValue: 1, checked: true},
                {boxLabel: '否', name: 'flag', inputValue: 0}]
        },new Ext.form.ComboBox({
		    fieldLabel: '类别',
		    anchor:'100%',
		    name:'GPSType',
		    hiddenName:'GPSType',
		    value:'3',
	        store: comboStore,
	        displayField:'text',
	        valueField: 'value',
		    typeAhead: true,
		    editable: false,
		    mode: 'remote',
		    triggerAction: 'all',
		    emptyText:'Select a state...',
		    selectOnFocus:true,
		    lazyInit:'false'		  
		   })
        ,{
            name: 'equipmentType',
            id:'equipmentType',
            fieldLabel: '型号'
        },new Ext.form.ComboBox({
		    fieldLabel: '国土所',
		    anchor:'100%',
		    name:'GPSCantonCode',
		    hiddenName:'GPSCantonCode',
	        store: suoStore,
	        displayField:'name',
	        valueField: 'name',
		    typeAhead: true,
		    editable: false,
		    mode: 'local',
		    triggerAction: 'all',
		    emptyText:'请选择国土所...',
		    selectOnFocus:true,
		    lazyInit:'false'
        })],				
             buttons: [{
                    text:'保存', handler: function() {
                    if (updateForm.getForm().isValid()){  	
			    	  updateForm.form.submit({ 
			 	       waitMsg: '正在保存,请稍候... ', 
				       success:function(){ 
						 Ext.Msg.alert('提示','保存成功。');
						 win.hide();
				         document.location.reload();
			           }, 
				       failure:function(){ 
				         Ext.Msg.alert('提示','保存失败，请稍后重试或联系管理员。');
				       } 
				     });
				    }
                   }
                  }]
            });  
             win = new Ext.Window({
                applyTo:'updateGPS',
                width:350,
                height:250,
                closeAction:'hide',
				items:updateForm
        	 }); 
        	comboStore.load();  
		}
 Ext.onReady(function(){
 	putClientCommond("dtxcList","getWysbList");
	myData = restRequest();
    initComponent();    	   	 
       })

      function  getData(xzqh){
			var path = "<%=basePath%>";
			var actionName = "xzqh";
			var actionMethod = "getNextPlace";
			var parameter = "code=" + xzqh;
			var Data = ajaxRequest(path, actionName, actionMethod, parameter);
			var obj = eval('(' + Data + ')');
    	    return obj;		
     }


/*处理删除操作 add by 王峰 2011-5-16*/
function del(){
 return "<a href='#' onclick='delGPS();return false;'><img src='base/gis/images/delete.png' alt='删除'></a>";
}

/*处理修改操作 add by 王峰 2011-5-16*/
function modify(){
 return "<a href='#' onclick='modifyGPS();return false;'><img src='base/gis/images/conf.png' alt='修改'></a>";
}

/*处理新增操作 add by 王峰 2011-5-16*/
 function addGPS(){
      updateForm.getForm().reset();
      win.show(); 
      win.setTitle('新增');
      Ext.getCmp('GPSId').getEl().dom.readOnly = false;
 }
 
 /*处理更新操作 add by 王峰 2011-5-16*/
 function modifyGPS(){
      var rowIndex = grid.store.indexOf(grid.getSelectionModel().getSelected());
      updateForm.getForm().findField('GPSId').setValue(store.getAt(rowIndex).get('GPS_ID'));
      
      Ext.getCmp('GPSId').getEl().dom.readOnly = true;
      updateForm.getForm().findField('GPSName').setValue(store.getAt(rowIndex).get('GPS_NAME')); 
    
      updateForm.getForm().findField('GPSType').setValue(store.getAt(rowIndex).get('GPS_TYPE'));
      updateForm.getForm().findField('equipmentType').setValue(store.getAt(rowIndex).get('EQUIPMENT_TYPE'));
      updateForm.getForm().findField('GPSCantonCode').setValue(store.getAt(rowIndex).get('GPS_CANTONCODE'));   
      win.setTitle('修改');
      win.show();
 }
  
/*删除 add by 郭 2011-1-20*/
function delGPS(){
var rowIndex = grid.store.indexOf(grid.getSelectionModel().getSelected());
var gpsId=grid.getStore().getAt(rowIndex).get('GPS_ID');
Ext.MessageBox.confirm('注意', '删除后不能恢复，您确定吗？',function(btn){
   if(btn=='yes'){
	    var path = "<%=basePath%>";
	    var actionName = "dtxcList";
	    var actionMethod = "delGPS";
	    var parameter="gpsId="+gpsId;
		var result = ajaxRequest(path,actionName,actionMethod,parameter);
		if(result=='success'){    
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

  
function query(){

//var condition=document.getElementById('condition').value;
//var accord=document.getElementById('accord').checked;
//condition=escape(escape(condition));
//document.location.href="<%=basePath%>web/zhejiang/dtxc/wysblb/wysbList.jsp?condition="+condition+"&accord="+accord;
var keyWord = Ext.getCmp('keyword').getValue();
keyWord=escape(escape(keyWord));
putClientCommond("dtxcList","getWysbList");
putRestParameter("keyWord",keyWord);
var myData = restRequest(); 
//alert(myData2)
store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: 'GPS_ID'},
           {name: 'GPS_NAME'},
           {name: 'GPS_TYPE'},
           {name: 'EQUIPMENT_TYPE'},
           {name: 'GPS_CANTONCODE'},
           {name: '修改'},
           {name: '删除'}
        ]
    });
grid.reconfigure(store, new Ext.grid.ColumnModel([
           {header: '编号', width: width*0.15, sortable: true,renderer:changKeyword},
           {header: '名称', width: width*0.15, sortable: true,renderer:changKeyword},
            {header: '设备类别', width: width*0.15, sortable: true,renderer:changKeyword},
            {header: '设备型号', width: width*0.15, sortable: false,renderer:changKeyword},
            {header: '行政区', width: width*0.15, sortable: false,renderer:changKeyword},
            {header: '修改', width: width*0.1, sortable: false, renderer: modify},
            {header: '删除', width: width*0.1,  ortable: false, renderer: del}
        ]));
//重新绑定分页工具栏
grid.getBottomToolbar().bind(store);//
//重新加载数据集
store.load({params:{start:0,limit:15}});  





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
</script>
	</head>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container"></div>
		<div id="updateGPS" class="x-hidden">
			<div id="updateForm" style="margin-left:10px; margin-top:5px"></div>
		</div>						
	</body>
</html>