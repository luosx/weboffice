<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			String name = ProjectInfo.getInstance().PROJECT_NAME;
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
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>

		<style>
input,img {
	vertical-align: middle;
}
</style>
		<script type="text/javascript">
		var carid='';
		var myData;
		var win;
		var store;
		var grid;
		var updateForm;
		var comboStore;
		var width;
		var height;
		var suoStore;
		 var temp='' ;
		 var comboData;
			    
function initComponent(){	
		 putClientCommond("carManager","getxzqhData");
	     comboData = restRequest();
		 comboStore= new Ext.data.JsonStore({
		  data: comboData,
		  fields: 
		   ['QT_CTN_CODE','NA_CTN_NAME']
	});
		 comboStore2= new Ext.data.JsonStore({
		  data: comboData,
		  fields: 
		   ['QT_CTN_CODE','NA_CTN_NAME']
	});
		  var Combo = new Ext.form.ComboBox({
			        id:'Combo',
			        store: comboStore,
			        displayField:'NA_CTN_NAME',
	                valueField: 'QT_CTN_CODE',
			        editable:false,
			        typeAhead: true,
			        width:120,
			        mode: 'local',
			        forceSelection: true,
			        triggerAction: 'all',
			       // emptyText:'',
			        selectOnFocus:true,
			         listeners:{
				    	'select':function(){ 
			        		temp = Ext.getCmp("Combo").getValue();
			        		}}
			    });
			    	
store = new Ext.data.JsonStore({

        proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
                {name: 'CAR_ID'},
                {name: 'CAR_NAME'},
                {name: 'CAR_UNIT'},
                {name: 'CAR_PERSON'},
                {name: 'CAR_PERSON_PHONE'},
          	    {name: 'CAR_NUMBER'},
           		{name: 'CAR_INFO_XZQH_NAME'},
          		{name: 'CAR_STYLE'},
           		{name: 'CAR_GMRQ'}
        ]
    });
    
        suoStore=new Ext.data.JsonStore({
    	fields: ['code', 'name'],
        data: [] 
    	});
    	
    
    store.load({params:{start:0, limit:14}});
      width=document.body.clientWidth;
      height=document.body.clientHeight;
grid = new Ext.grid.GridPanel({
        store: store,
        columns:[
            new Ext.grid.RowNumberer(),
            {header: '车辆名称',dataIndex:'CAR_NAME', width: width*0.11, sortable: true},
            {header: '车型号',dataIndex:'CAR_STYLE', width: width*0.11, sortable: false},
            {header: '车牌号',dataIndex:'CAR_NUMBER', width: width*0.11, sortable: false},
            {header: '负责人',dataIndex:'CAR_PERSON',width: width*0.11, sortable: true},
            {header: '联系电话',dataIndex:'CAR_PERSON_PHONE', width: width*0.1, sortable: true},
            {header: '行政区', dataIndex:'CAR_INFO_XZQH_NAME',width: width*0.14, sortable: false},
            {header: '购买日期', dataIndex:'CAR_GMRQ',width: width*0.11, sortable: false},
            {header: '修改',width: width*0.1, sortable: false, renderer: modify},
            {header: '删除', width: width*0.1,  ortable: false, renderer: del}
        ],
        tbar:[      {xtype:'label',text:'选择政区:',width:60},
                    Combo,
	    			{xtype:'label',text:'车牌号:',width:60},
	    			{xtype:'textfield',id:'keyword',width:350,emptyText:'请输入关键字进行查询'},
	    			{xtype: 'button',id:'button',text:'查询',handler: query}
	    ],
        listeners:{
		       rowdblclick: modifyCar
         },
        stripeRows: true,
        height: height*0.9+20,
        stateful: true,
        buttonAlign:'center',
        stateId: 'grid',
        bbar: new Ext.PagingToolbar({
        pageSize: 14,
        store: store,
        displayInfo: true,
        displayMsg: '共{2}条，当前为：{0} - {1}条',
        emptyMsg: "无记录",
        plugins: new Ext.ux.ProgressBarPager()
        }),
         buttons: [{
         	text:'新增车辆',
         	handler: addCar
          }]
     });
 grid.render('mygrid_container'); 
   
 updateForm=new Ext.form.FormPanel({
	   applyTo:'updateForm',
	   baseCls: 'x-plain',
       labelWidth:80,	
       url:"<%=basePath%>/service/rest/carManager/addCarData",
       width:330, 
       defaults:{xtype:"textfield",anchor:'90%'},   
       items: [{	
            name:'car_name',
            id:'car_name',
            fieldLabel:'车辆名称'      			
        },{	
            name:'car_style',
            id:'car_style',
            fieldLabel:'车型号'        			
        },{	
            name:'car_number',
            id:'car_number',
             allowBlank: false,
            fieldLabel:'车牌号'        			
        },{	
            name:'car_unit',
            id:'car_unit',
            fieldLabel:'车所在单位'        			
        },{	
            name:'car_person',
            id:'car_person',
            fieldLabel:'车辆负责人'        			
        },{	
            name:'car_id',
            id:'car_id',
            hidden:true, 
            hideLabel:true, 
            fieldLabel:'车辆id'        			
        },{	
            name:'car_person_phone',
            id:'car_person_phone',
            fieldLabel:'负责人电话'        			
        },new Ext.form.ComboBox({
		    fieldLabel: '所在政区',
		    anchor:'100%',
		    name:'car_info_xzqh_name',
		    hiddenName:'car_info_xzqh_name',
		    value:'市局',
	        store: comboStore,
		    displayField:'NA_CTN_NAME',
	        valueField: 'QT_CTN_CODE',
		    typeAhead: true,
		    editable: false,
		    mode: 'local',
		    triggerAction: 'all',
		    emptyText:'Select a state...',
		    selectOnFocus:true,
		    lazyInit:'false'		  
		   }),
         new Ext.form.DateField({
            name: 'car_gmrq',
            id:'car_gmrq',
           fieldLabel:'购买日期',
           emptyText:'请选择日期！',
           format:'Y-m-d',
           disableDay:[0,1,2,3,4,5,6,7],
           allowBlank:false,
           msgTarget:'qtip',
          width:122
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
                applyTo:'updateCar',
                width:350,
                height:305,
                closeAction:'hide',
				items:updateForm
        	 }); 

		}
 Ext.onReady(function(){
 	putClientCommond("carManager","getAllCarData");
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

function del(){
           return "<a href='#' onclick='delCar();return false;'><img src='web/<%=name%>/framework/images/listbutton/delete.png' alt='删除'></a>";
         }
         
function modify(){
			flag = "modify";
          return "<a href='#' onclick='modifyCar();return false;'><img src='web/<%=name%>/framework/images/listbutton/conf.png' alt='修改'></a>";
         }
         
 function addCar(){
 		   carid='';
          updateForm.getForm().reset();
          win.show(); 
          win.setTitle('新增');
          Ext.getCmp('car_number').getEl().dom.readOnly = false;
        }
 //修改操作
 function modifyCar(){
      var rowIndex = grid.store.indexOf(grid.getSelectionModel().getSelected());
       updateForm.getForm().findField('car_id').setValue(store.getAt(rowIndex).get('CAR_ID'));
      updateForm.getForm().findField('car_name').setValue(store.getAt(rowIndex).get('CAR_NAME'));
      updateForm.getForm().findField('car_unit').setValue(store.getAt(rowIndex).get('CAR_UNIT')); 
       updateForm.getForm().findField('car_person').setValue(store.getAt(rowIndex).get('CAR_PERSON')); 
      updateForm.getForm().findField('car_person_phone').setValue(store.getAt(rowIndex).get('CAR_PERSON_PHONE'));
      updateForm.getForm().findField('car_gmrq').setValue(store.getAt(rowIndex).get('CAR_GMRQ'));
       updateForm.getForm().findField('car_number').setValue(store.getAt(rowIndex).get('CAR_NUMBER'));
        updateForm.getForm().findField('car_style').setValue(store.getAt(rowIndex).get('CAR_STYLE'));
      updateForm.getForm().findField('car_info_xzqh_name').setValue(store.getAt(rowIndex).get('CAR_INFO_XZQH_NAME'));   
      win.setTitle('修改');
      win.show();
 }
  //删除操作
function delCar(){
var rowIndex = grid.store.indexOf(grid.getSelectionModel().getSelected());
var car_id=grid.store.getAt(rowIndex).get('CAR_ID');
//编码处理
   car_number=escape(escape(car_id))
  Ext.MessageBox.confirm('注意', '删除后不能恢复，您确定吗？',function(btn){
   if(btn=='yes'){
	    var path = "<%=basePath%>";
	    var actionName = "carManager";
	    var actionMethod = "deleteCarData";
	    var parameter="car_id="+car_id;
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
    var keyWord = Ext.getCmp('keyword').getValue();
     var xzqh= Ext.getCmp("Combo").getValue();
    keyWord=escape(escape(keyWord));
    putClientCommond("carManager","queryCarData");
     putRestParameter("xzqh",xzqh);
      putRestParameter("keyWord",keyWord);
     myData = restRequest(); 
    store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
                //{name: 'CAR_ID'},
                {name: 'CAR_NAME'},
                {name: 'CAR_UNIT'},
                {name: 'CAR_PERSON'},
                {name: 'CAR_PERSON_PHONE'},
          	    {name: 'CAR_NUMBER'},
           		{name: 'CAR_INFO_XZQH_NAME'},
          		{name: 'CAR_STYLE'},
           		{name: 'CAR_GMRQ'}
        ]
      });
 grid.reconfigure(store, new Ext.grid.ColumnModel([
 			new Ext.grid.RowNumberer(),
            {header: '车辆名称',dataIndex:'CAR_NAME', width: width*0.11, sortable: true,renderer:changKeyword},
            {header: '车型号',dataIndex:'CAR_STYLE', width: width*0.11, sortable: false,renderer:changKeyword},
            {header: '车牌号',dataIndex:'CAR_NUMBER', width: width*0.11, sortable: false,renderer:changKeyword},
            {header: '负责人',dataIndex:'CAR_PERSON',width: width*0.11, sortable: true},
            {header: '联系电话',dataIndex:'CAR_PERSON_PHONE', width: width*0.1, sortable: true},
            {header: '行政区', dataIndex:'CAR_INFO_XZQH_NAME',width: width*0.14, sortable: false},
            {header: '购买日期', dataIndex:'CAR_GMRQ',width: width*0.11, sortable: false},
            {header: '修改',width: width*0.1, sortable: false, renderer: modify},
            {header: '删除', width: width*0.1,  ortable: false, renderer: del}
        ]));
//重新绑定分页工具栏
grid.getBottomToolbar().bind(store);
//重新加载数据集
store.load({params:{start:0,limit:14}});  

}

function document.onkeydown(){  
     var e=event.srcElement; 
      if(event.keyCode==13){  
      document.getElementById("button").click(); 
    return false; 
    } 
    } 
</script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container"></div>
		<div id="updateCar" class="x-hidden">
			<div id="updateForm" style="width: 102%; height: 90%;margin-left: 10px; margin-top: 5px"></div>
		</div>
	</body>
</html>