<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
    Object userprincipal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    String userid = ((User)userprincipal).getUserID();
    String flag = request.getParameter("flag");
    String yw_guid= request.getParameter("yw_guid").toString();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>开发体量列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/restRequest.jspf"%>
		<%@ include file="/base/include/ext.jspf"%>

		<!-- 根据办理时限不同修改数据的显示颜色 -->
		<style type="text/css">
.my_row_Green table {
	color: green
}

.my_row_Gray table {
	color: gray
}
</style>

		<script type="text/javascript">
var myData;
var win;
var store;
var grid;
var expWin;
var form;
var xmmc;
Ext.onReady(function(){
    putClientCommond("hxxmManager","queryKftl");
    putRestParameter("xmbh",'<%=yw_guid%>')
	myData = restRequest();
 	store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: 'READFLAG'},
           {name: 'XMMC'},
           {name: 'SX'},
           {name: 'HS'},
           {name: 'HSZ'},
           {name: 'DL'},
 		   {name: 'DLZ'},	         
           {name: 'GM'},
           {name: 'GMZ'},
           {name: 'TZ'},
           {name: 'TZZ'},
           {name: 'Z'},
           {name: 'ZHUZ'},
           {name: 'Q'},
           {name: 'QIZ'},
           {name: 'LM'},
           {name: 'CJ'},
           {name: 'MOD'},
           {name: 'DEL'}
        ]
    });
    
    store.load({params:{start:0, limit:15}});
    var width=document.body.clientWidth;
    var height=document.body.clientHeight*0.9;
    var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
        grid = new Ext.grid.GridPanel({
        store: store,
        sm:sm,
        columns: [
           {header: '项目名称', dataIndex:'XMMC', width: width*0.1, sortable: false},
           {header: '时序', dataIndex:'SX', width: width*0.05, sortable: false},
           {header: '户数', dataIndex:'HS', width: width*0.1, sortable: false},
           {header: '户数%', dataIndex:'HSZ', width: width*0.05, sortable: false},
           {header: '地量', dataIndex:'DL',width: width*0.05, sortable: false},
           {header: '地量%', dataIndex:'DLZ', width: width*0.05, sortable: false},
           {header: '规模', dataIndex:'GM',width: width*0.05, sortable: false},
           {header: '规模%', dataIndex:'GMZ', width: width*0.05, sortable: false},
           {header: '投资', dataIndex:'TZ',width: width*0.05, sortable: false},
           {header: '投资%', dataIndex:'TZZ', width: width*0.05, sortable: false},
           {header: '住',  dataIndex:'Z',width: width*0.05, sortable: false},
           {header: '住%', dataIndex:'ZHUZ', width: width*0.05, sortable: false},
           {header: '企',  dataIndex:'Q',width: width*0.05, sortable: false},
           {header: '企%',  dataIndex:'QIZ',width: width*0.05, sortable: false},
           {header: '楼面', dataIndex:'LM',width: width*0.05, sortable: false},
           {header: '成交', dataIndex:'CJ',width: width*0.05, sortable: false},
           {header: '修改', dataIndex:'MOD',width: width*0.05, sortable: false,renderer: modify}, 
           {header: '删除', dataIndex:'DEL',width: width*0.05, sortable: false,renderer:del}
        ],
          tbar:[
        			
	    		 	 {xtype:'label',text:'快速查找:',width:60},
	    			 {xtype:'textfield',id:'keyword',width:240,emptyText:'请输入查询字段'},
	    			 {xtype: 'button',id:'button',text:'查询',handler: query},
	    			  {xtype:'button',text:'新增开发体量',width:60,handler: addTask}
	    ],
        stripeRows: true,
        listeners:{
		  rowdblclick : function(grid, rowIndex, e)
				{
				   showDetail(grid.getStore().getAt(rowIndex).data.XIANGXI);
				}
        },
        height: height+40,
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
        
        viewConfig:{//配置GridPanel的显示样式
	    		forceFit : true,
	            getRowClass : function(record,rowIndex,rowParams,store){   
	                //设置数据的显示颜色，并弹出提示信息
	                if(record.data.READFLAG == "0"){   
	                    return 'my_row_Green';
	                }else{
	                	return 'my_row_Gray';
	                }
	            }   
	        }   
    });
    ///////////////////////////////////////////////////
    var combostore = new Ext.data.ArrayStore({
                fields: ['name'],
                data: [['2010'],['2011'], ['2012'],['2013'],['2014']]
             });
    var combobox = new Ext.form.ComboBox({
                fieldLabel: '时序年份',
                width:120,
                  id      : 'year',
                 store: combostore,
                 displayField: 'name',
                 valueField: 'name',
                 triggerAction: 'all',
                 emptyText: '请选择年份...',
                 allowBlank: false,
                 blankText: '请选择年份',
                 editable: false,
                 mode: 'local'
             });
     var combostoreS = new Ext.data.ArrayStore({
                fields: ['month','name'],
                 data: [[1,'一月份'], [2,'二月份'], [3,'三月份'], [4,'四月份'], [5,'五月份'], [6,'六月份'], [7,'七月份'], [8,'八月份'], [9,'九月份'], [10,'十月份'], [11,'十一月份'], [12,'十二月份']]
             });
    var comboboxS = new Ext.form.ComboBox({
                 name     : 'month',
                 fieldLabel: '时序月份',
                  width:120,
                 store: combostoreS,
                 displayField: 'name',
                 valueField: 'month',
                 hiddenName:'month',
                 triggerAction: 'all',
                 emptyText: '请选择月份...',
                 allowBlank: false,
                 blankText: '请选择月份',
                 editable: false,
                 mode: 'local'
             });           
   
   var form2 = new Ext.form.FormPanel({
        autoHeight: true,
        frame:true,
        bodyStyle:'padding:5px 0px 0',
        width: 400,
  		labelWidth :60,   
  		labelAlign : "right",
        url:"<%=basePath%>service/rest/hxxmManager/addKftl?xmbh=<%=yw_guid%>",
        defaults: {
            anchor: '0'
        },
        items   : [
           	{
                xtype: 'textfield',
                id      : 'xmmc',
                value:'',
                fieldLabel: '项目名称',
                readOnly:true
            },
    		{
   			 layout : "column", 
           	 items:[{
           	    columnWidth: .5, 
           	  	layout : "form",   
           	  	items :combobox},
	            {
	            columnWidth: .5, 
           	  	layout : "form",
           	  	items :comboboxS 
            }]},
   			{
   			 layout : "column", 
           	 items:[{
           	    columnWidth: .33, 
           	  	layout : "form",   
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'xmhs',
	                value:'',
	                fieldLabel: '项目户数',
	                readOnly:true,
	                width :60
	                }]},{
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'hs',
	                value:'',
	                fieldLabel: '户数',
	                 readOnly:true,
	                 width :60
	                }]}, 
	                {
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'hsbl',
	                value:'',
	                minValue:0,
	                maxValue:100,
	                fieldLabel: '户数%',
	                width : 60
                }]
            }]},
           {
   			 layout : "column", 
           	 items:[{
           	    columnWidth: .33, 
           	  	layout : "form",   
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'xmdl',
	                value:'',
	                fieldLabel: '地量总数',
	                readOnly:true,
	                width :60
	                }]},{
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'dl',
	                value:'',
	                fieldLabel: '地量',
	                readOnly:true,
	                 width :60
	                }]}, 
	                {
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'dlbl',
	                value:'',
	                minValue:0,
	                maxValue:100,
	                fieldLabel: '地量%',
	                  width : 60
	                
                }]
            }]},
			{
   			 layout : "column", 
           	 items:[{
           	    columnWidth: .33, 
           	  	layout : "form",   
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'xmgm',
	                value:'',
	                fieldLabel: '规模总数',
	                readOnly:true,
	                width :60
	                }]},{
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'gm',
	                value:'',
	                fieldLabel: '规模',
	                readOnly:true,
	                width :60
	                }]}, 
	                {
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'gmbl',
	                value:'',
	                minValue:0,
	                maxValue:100,
	                fieldLabel: '规模%',
	                width : 60
                }]
            }]}, 
           {
   			 layout : "column", 
           	 items:[{
           	    columnWidth: .33, 
           	  	layout : "form",   
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'xmtz',
	                value:'',
	                fieldLabel: '投资总数',
	                readOnly:true,
	                width :60
	                }]},{
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'tz',
	                value:'',
	                fieldLabel: '投资',
	                readOnly:true,
	                 width :60
	                }]}, 
	                {
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'tzbl',
	                value:'',
	                minValue:0,
	                maxValue:100,
	                fieldLabel: '投资%',
	                readOnly:true,
	                width : 60
                }]
            }]},{
   			 layout : "column", 
           	 items:[{
           	    columnWidth: .33, 
           	  	layout : "form",   
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'xmz',
	                value:'',
	                fieldLabel: '住总数',
	                readOnly:true,
	                width :60
	                }]},{
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'z',
	                value:'',
	                fieldLabel: '住',
	                readOnly:true,
	                 width :60
	                }]}, 
	                {
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'zbl',
	                value:'',
	                minValue:0,
	                maxValue:100,
	                fieldLabel: '住%',
	                width : 60
	                
                }]
            }]},
			{
   			 layout : "column", 
           	 items:[{
           	    columnWidth: .33, 
           	  	layout : "form",   
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'xmq',
	                value:'',
	                fieldLabel: '企总数',
	                readOnly:true,
	                width :60
	                }]},{
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'q',
	                value:'',
	                fieldLabel: '企',
	                readOnly:true,
	                 width :60
	                }]}, 
	                {
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'qbl',
	                value:'',
	                minValue:0,
	                maxValue:100,
	                fieldLabel: '企%',
	                width : 60
                }]
            }]},{
   			 layout : "column", 
           	 items:[{
           	    columnWidth: .33, 
           	  	layout : "form",   
           	  	items :[{
	           	    xtype: 'numberfield',
	                id      : 'lm',
	                value:'',
	                fieldLabel: '楼面',
	                readOnly:true,
	                width : 60
           	  	}]},
	            {
	            columnWidth: .33, 
           	  	layout : "form",
           	  	items :[{
	           	    xtype: 'numberfield',
	                id      : 'cj',
	                value:'',
	                minValue:0,
	                fieldLabel: '成交',
	                readOnly:true,
	                width : 60
           	  	}]}
            ]},
           	  	{
	                xtype: 'label',
	                id      : 'sm',
	                value:'',
	                fieldLabel: '',
	                html:'<div style="color:red">&nbsp&nbsp&nbsp&nbsp&nbsp地量:公顷&nbsp&nbsp&nbsp规模:万m2&nbsp&nbsp&nbsp住企投资:亿元&nbsp&nbsp&nbsp楼面成交:万元/m2</div>',
	                readOnly:true
           		 }       
        ],
        buttons: [
            {
                text   : '保存',
                handler: function() {
						form2.form.submit({ 
							waitMsg: '正在保存,请稍候... ', 		
							success:function(){ 
							 Ext.Msg.alert('提示','保存成功。',function(){
							   query();	
							 });
							
							}, 
							failure:function(){ 
								Ext.Msg.alert('提示','保存失败，请稍后重试或联系管理员。');
							} 
						});
                	}
            	},   
            {
                text   : '关闭',
                handler: function() {
				    win2.hide();
                }
            }
        ]
  });		
	 Ext.getCmp("hsbl").addListener('change',function(){   
	 	Ext.getCmp("hs").setValue(Ext.getCmp("xmhs").getValue()*Ext.getCmp("hsbl").getValue()/100);
	 });
	 Ext.getCmp("dlbl").addListener('change',function(){   
	 	Ext.getCmp("dl").setValue(Ext.getCmp("xmdl").getValue()*Ext.getCmp("dlbl").getValue()/100);
	 });
	 Ext.getCmp("gmbl").addListener('change',function(){   
	 	Ext.getCmp("gm").setValue(Ext.getCmp("xmgm").getValue()*Ext.getCmp("gmbl").getValue()/100);
	 });
  	 Ext.getCmp("zbl").addListener('change',function(){   
	 	Ext.getCmp("z").setValue(Ext.getCmp("xmz").getValue()*Ext.getCmp("zbl").getValue()/100);
	 	Ext.getCmp("tz").setValue(Ext.getCmp("z").getValue()+Ext.getCmp("q").getValue());
	 	Ext.getCmp("tzbl").setValue(Ext.getCmp("tz").getValue()*100/Ext.getCmp("xmtz").getValue());
	 });
  	 Ext.getCmp("qbl").addListener('change',function(){   
	 	Ext.getCmp("q").setValue(Ext.getCmp("xmq").getValue()*Ext.getCmp("qbl").getValue()/100);
	 	Ext.getCmp("tz").setValue(Ext.getCmp("z").getValue()+Ext.getCmp("q").getValue());
	 	Ext.getCmp("tzbl").setValue(Ext.getCmp("tz").getValue()*100/Ext.getCmp("xmtz").getValue());
	 });	 
  
   win2=new Ext.Window({
                applyTo:'addWin',
                title:'开发体量录入',
                width:410,
                height:330,
                closeAction:'hide',
				items:form2
    });
    putClientCommond("hxxmManager","getXmmc");
    putRestParameter("xmbh",'<%=yw_guid%>')
	var info = restRequest();
	if(info[0]!=null){
  	  Ext.getCmp("xmmc").setValue(info[0].XMNAME);
  	  Ext.getCmp("xmhs").setValue(info[0].HS);
  	  Ext.getCmp("xmdl").setValue(info[0].ZD);
  	  Ext.getCmp("xmgm").setValue(info[0].GM);
  	  Ext.getCmp("xmz").setValue(info[0].ZZCQFY);
  	  Ext.getCmp("xmq").setValue(info[0].QYCQFY);
  	  Ext.getCmp("xmtz").setValue(info[0].CQHBTZ);
  	  Ext.getCmp("lm").setValue(info[0].LMCB);
  	  Ext.getCmp("cj").setValue(info[0].LMCJJ);
  	 
    }
 /////////////////////////////////////
     grid.render('mygrid_container'); 				      
})
 function addTask(){
    win2.items.items[0].form.url='<%=basePath%>service/rest/hxxmManager/addKftl?xmbh=<%=yw_guid%>';
    win2.setTitle("开发体量录入");
    Ext.getCmp("hs").reset();
    Ext.getCmp("dl").reset();
    Ext.getCmp("gm").reset();
    Ext.getCmp("tz").reset();
    Ext.getCmp("z").reset();
    Ext.getCmp("q").reset();
    Ext.getCmp("hsbl").reset();
    Ext.getCmp("dlbl").reset();
    Ext.getCmp("gmbl").reset();
    Ext.getCmp("tzbl").reset();
    Ext.getCmp("zbl").reset();
    Ext.getCmp("qbl").reset();
    win2.show();
 }
 
function modifyContent(id){
    //初始化数据
    var sinData=myData[id];
    Ext.getCmp("year").setValue(sinData.SX.split('-')[0]);
    win2.items.items[0].form.findField('month').setValue(sinData.SX.split('-')[1]);
    Ext.getCmp("hs").setValue(sinData.HS);
    Ext.getCmp("dl").setValue(sinData.DL);
    Ext.getCmp("gm").setValue(sinData.GM);
    Ext.getCmp("tz").setValue(sinData.TZ);
    Ext.getCmp("z").setValue(sinData.Z);
    Ext.getCmp("q").setValue(sinData.Q);
    Ext.getCmp("hsbl").setValue(sinData.HSZ);
    Ext.getCmp("dlbl").setValue(sinData.DLZ);
    Ext.getCmp("gmbl").setValue(sinData.GMZ);
    Ext.getCmp("tzbl").setValue(sinData.TZZ);
    Ext.getCmp("zbl").setValue(sinData.ZHUZ);
    Ext.getCmp("qbl").setValue(sinData.QIZ);
    Ext.getCmp("lm").setValue(sinData.LM);
    Ext.getCmp("cj").setValue(sinData.CJ);
    
    win2.items.items[0].form.url='<%=basePath%>service/rest/hxxmManager/updateKftl?xmbh=<%=yw_guid%>&&kfbh='+sinData.KFBH;
    win2.setTitle("开发体量修改")
    win2.show();
}

function modify(id){
 return "<span style='cursor:pointer;' onclick='modifyContent(\""+id+"\")'><img src='base/form/images/conf.png' alt='修改'/></span>";
}

function del(id){
 	return "<span href='#' onclick='delTask("+id+");return false;'><img src='base/form/images/delete.png' alt='删除'></span>";
}

function delTask(id){
	  Ext.MessageBox.confirm('注意', '删除后不能恢复，您确定吗？',function(btn){
	  if(btn=='yes'){
	    putClientCommond("hxxmManager","delKftl");
	    putRestParameter("kfbh",myData[id].KFBH);
        var mes = restRequest(); 
        if(mes.success){
          query();
        }
	  }else{
	    return false;
		}
	});
}


function query(){
  var keyWord = Ext.getCmp('keyword').getValue();
    keyWord=escape(escape(keyWord));
    putClientCommond("hxxmManager","queryKftl");
    putRestParameter("xmbh",'<%=yw_guid%>')
    putRestParameter("keyWord",keyWord);
    myData = restRequest(); 
    var width=document.body.clientWidth;
    store = new Ext.data.JsonStore({
     proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: 'READFLAG'},
           {name: 'XMMC'},
           {name: 'SX'},
           {name: 'HS'},
           {name: 'HSZ'},
           {name: 'DL'},
 		   {name: 'DLZ'},	         
           {name: 'GM'},
           {name: 'GMZ'},
           {name: 'TZ'},
           {name: 'TZZ'},
           {name: 'Z'},
           {name: 'ZHUZ'},
           {name: 'Q'},
           {name: 'QIZ'},
           {name: 'LM'},
           {name: 'CJ'},
           {name: 'MOD'},
           {name: 'DEL'}
        ]
    });
    grid.reconfigure(store, new Ext.grid.ColumnModel([
           {header: '项目名称', dataIndex:'XMMC', width: width*0.1, sortable: false},
           {header: '时序', dataIndex:'SX', width: width*0.05, sortable: false,renderer:changKeyword},
           {header: '户数', dataIndex:'HS', width: width*0.1, sortable: false},
           {header: '户数%', dataIndex:'HSZ', width: width*0.05, sortable: false},
           {header: '地量', dataIndex:'DL',width: width*0.05, sortable: false},
           {header: '地量%', dataIndex:'DLZ', width: width*0.05, sortable: false},
           {header: '规模', dataIndex:'GM',width: width*0.05, sortable: false},
           {header: '规模%', dataIndex:'GMZ', width: width*0.05, sortable: false},
           {header: '投资', dataIndex:'TZ',width: width*0.05, sortable: false},
           {header: '投资%', dataIndex:'TZZ', width: width*0.05, sortable: false},
           {header: '住',  dataIndex:'Z',width: width*0.05, sortable: false},
           {header: '住%', dataIndex:'ZHUZ', width: width*0.05, sortable: false},
           {header: '企',  dataIndex:'Q',width: width*0.05, sortable: false},
           {header: '企%',  dataIndex:'QIZ',width: width*0.05, sortable: false},
           {header: '楼面', dataIndex:'LM',width: width*0.05, sortable: false},
           {header: '成交', dataIndex:'CJ',width: width*0.05, sortable: false},
           {header: '修改', dataIndex:'MOD',width: width*0.05, sortable: false,renderer: modify}, 
           {header: '删除', dataIndex:'DEL',width: width*0.05, sortable: false,renderer:del}
        ]));
//重新绑定分页工具栏
 grid.getBottomToolbar().bind(store);
//重新加载数据集
store.load({params:{start:0,limit:15}});  
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
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container" style=""></div>
			<div id="addWin" class="x-hidden">
				<div id="addForm"></div>
			</div>
	</body>
</html>