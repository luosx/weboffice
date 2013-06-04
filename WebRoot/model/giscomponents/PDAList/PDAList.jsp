<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.common.utils.StrTools"%>
<%@page import="com.klspta.gisapp.components.pda.pdalist.PDAList"%>
<%@ taglib uri="/WEB-INF/taglib/queryLabel.tld" prefix="common"%>
<%
	String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
    + request.getServerPort() + path + "/";
    String extPath = basePath + "thirdres/ext/"; 
    String fromBeanType="pdaFormBean";
    String condition=request.getParameter("condition");
	if(condition!=null&&!"".equals(condition)){
	condition=StrTools.unescape(condition);
	}else{
		condition="";
	}
	String accord=request.getParameter("accord");
	List list=new ArrayList();
	list.add(condition);
	list.add(accord);
    PDAList pdaList=new PDAList();
    String rows=pdaList.getPDAList(list);
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
		<script type="text/javascript" src="<%=extPath%>/examples/ux/PagingMemoryProxy.js"></script>
		<script type="text/javascript" src="<%=extPath%>/examples/ux/ProgressBarPager.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/common/css/query.css"/>
		<style>
		input,img{vertical-align:middle;}
		</style>
		<script type="text/javascript">
		var myData;
		var win;
		var store;
		var grid;
		var updateForm;
 Ext.onReady(function(){
	myData= <%=rows%>;//采用json格式存储的数组
    // create the data store
    store = new Ext.data.ArrayStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: '编号'},
           {name: '名称'},
           {name: 'PDA型号'},
           {name: '所属单位'},
           {name: '保管人'},
           {name: '保管人手机'},
           {name: 'PDA内置手机号码'},
           {name: '修改'},
           {name: '删除'}
        ]
    });
    
    store.load({params:{start:0, limit:15}});
    
        grid = new Ext.grid.GridPanel({
        store: store,
        columns: [
            {header: '编号', width: 80, sortable: true},
            {header: '名称', width: 120, sortable: true},
            {header: 'PDA型号', width: 120, sortable: true},
            {header: '所属单位', width: 120, sortable: true},
            {header: '保管人', width: 80, sortable: true},
            {header: '保管人手机', width: 100, sortable: true},
            {header: 'PDA内置手机号码', width: 120, sortable: false},
            {header: '修改', width: 50, sortable: false, renderer: modify},
            {header: '删除', width: 50, sortable: false, renderer: del}
        ],
        stripeRows: true,
        height: 450,
        title: '手持GPS/PDA设备列表',
        stateful: true,
        stateId: 'grid',
        bbar: new Ext.PagingToolbar({
        pageSize: 15,
        store: store,
        displayInfo: true,
        displayMsg: '共{2}条，当前为：{0} - {1}条',
        emptyMsg: "无记录",
        plugins: new Ext.ux.ProgressBarPager()
        }),
                buttons: [{
            text: '新增',handler: addGPS
        }]
    });
    grid.render('mygrid_container'); 
    document.getElementById('accord').checked=<%=accord%>;
	document.getElementById('condition').value="<%=condition%>";
	
	   updateForm=new Ext.form.FormPanel({
	   applyTo:'updateForm',
	   baseCls: 'x-plain',
       labelWidth:120,	
       width:380, 
       url:"<%=basePath%>formOperationAC.do?method=saveForm&formBeanType=<%=fromBeanType%>",
       defaults:{xtype:"textfield",anchor:'90%'},   
       items: [{	
            name:'PDAId',
            id:'PDAId',
            allowBlank: false,
            fieldLabel:'PDA编号'      			
        },{	
            name:'PDAName',
            fieldLabel:'PDA名称'        			
        },{          
            name:'PDAUnit',
           	fieldLabel: 'PDA所示单位'
        },{           	
            name:'PDAPerson',
           	fieldLabel: 'PDA保管人'
        },{           	
            name:'PDAPhone',
           	fieldLabel: 'PDA内置手机编号'
        },{ 
        	xtype:'radiogroup', 
           	fieldLabel: '是否启用',
           	items:[{boxLabel: '是', name: 'flag', inputValue: 1, checked: true},
                {boxLabel: '否', name: 'flag', inputValue: 0}]
        },{
            name: 'PDAType',
            fieldLabel: 'PDA型号'
        },{
            name: 'PDAPersonPhone',
            fieldLabel: 'PDA保管人联系电话'
        },{
            name: 'PDACantonCode',
            fieldLabel: '所在政区'
        }],				
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
                  },{
                    text: '重置',
                    handler: function(){
                        updateForm.getForm().reset();
                    }
                }]
            });  
             win = new Ext.Window({
                applyTo:'updateGPS',
                width:400,
                height:350,
                closeAction:'hide',
				items:updateForm
        	 });
  }
)

/*处理删除操作 add by 王峰 2011-5-16*/
function del(id){
 return "<a href='#' onclick='delGPS("+id+");return false;'><img src='gisapp/images/delete.png' alt='删除'></a>";
}

/*处理修改操作 add by 王峰 2011-5-16*/
function modify(id){
 return "<a href='#' onclick='modifyGPS("+id+");return false;'><img src='gisapp/images/conf.png' alt='修改'></a>";
}

/*处理新增操作 add by 王峰 2011-5-16*/
 function addGPS(){
      updateForm.getForm().reset();
      win.show(); 
      win.setTitle('新增');
      Ext.getCmp('PDAId').getEl().dom.readOnly = false;
 }
 
 /*处理更新操作 add by 王峰 2011-5-16*/
 function modifyGPS(id){
      updateForm.getForm().findField('PDAId').setValue(myData[id][0]);
      Ext.getCmp('PDAId').getEl().dom.readOnly = true;
      updateForm.getForm().findField('PDAName').setValue(myData[id][1]); 
      updateForm.getForm().findField('PDAUnit').setValue(myData[id][2]); 
      updateForm.getForm().findField('PDAPerson').setValue(myData[id][3]); 
      updateForm.getForm().findField('PDAPhone').setValue(myData[id][4]); 
      updateForm.getForm().findField('PDAType').setValue(myData[id][5]);
      updateForm.getForm().findField('PDAPersonPhone').setValue(myData[id][6]);
      updateForm.getForm().findField('PDACantonCode').setValue(myData[id][9]);   
      win.setTitle('修改');
      win.show();
 }
  
/*删除 add by 郭 2011-1-20*/
function delGPS(id){
var gpsId=myData[id][0]
Ext.MessageBox.confirm('注意', '删除后不能恢复，您确定吗？',function(btn){
   if(btn=='yes'){
	    var path = "<%=basePath%>";
	    var actionName = "pdaManageAC";
	    var actionMethod = "delGPS";
	    var parameter="gpsId="+gpsId;
		var result = ajaxRequest(path,actionName,actionMethod,parameter);
		if(result){
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
function query(){
var condition=document.getElementById('condition').value;
var accord=document.getElementById('accord').checked;
condition=escape(escape(condition));
document.location.href="<%=basePath%>gisapp/pages/components/PDAList/PDAList.jsp?condition="+condition+"&accord="+accord;
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
		<common:queryLabel/>
		<div id="mygrid_container" style="width: 100%; height: 100%;"></div>
		<div id="updateGPS" class="x-hidden">
			<div id="updateForm" style="margin-left:10px; margin-top:5px"></div>
		</div>						
	</body>
</html>