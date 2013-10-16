<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>安置房建设列表</title>
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
    putClientCommond("azfjs","query");
	myData = restRequest();
 	store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: 'KGMC'},
           {name: 'SX'},
           {name: 'ZGM'},
           {name: 'KG'},
           {name: 'KGBL'},
           {name: 'TZ'},
           {name: 'TZMC'},
 		   {name: 'SYL'},	         
           {name: 'KC'},
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
           {header: '开工名称', dataIndex:'KGMC', width: width*0.1, sortable: false},
           {header: '时序', dataIndex:'SX', width: width*0.05, sortable: false,renderer:changKeyword},
           {header: '总规模', dataIndex:'ZGM', width: width*0.1, sortable: false},
           {header: '开工', dataIndex:'KG', width: width*0.1, sortable: false},
           {header: '开工%', dataIndex:'KGBL', width: width*0.05, sortable: false},
           {header: '投资名称', dataIndex:'TZMC',width: width*0.1, sortable: false},
           {header: '投资', dataIndex:'TZ', width: width*0.1, sortable: false},
           {header: '使用量', dataIndex:'SYL',width: width*0.1, sortable: false},
           {header: '安置房库存', dataIndex:'KC', width: width*0.1, sortable: false},
           {header: '修改', dataIndex:'MOD',width: width*0.05, sortable: false,renderer: modify}, 
           {header: '删除', dataIndex:'DEL',width: width*0.05, sortable: false,renderer:del}
        ],
          tbar:[
        			
	    		 	 {xtype:'label',text:'快速查找:',width:60},
	    			 {xtype:'textfield',id:'keyword',width:240,emptyText:'请输入查询字段'},
	    			 {xtype: 'button',id:'button',text:'查询',handler: query},
	    			 {xtype:'button',text:'新增安置房建设',width:100,handler: addTask}
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
        url:"<%=basePath%>service/rest/azfjs/add",
        defaults: {
            anchor: '0'
        },
        items   : [{
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
           	    columnWidth: .5, 
           	  	layout : "form",   
           	  	items : [{
	                xtype: 'textfield',
	                id      : 'tzmc',
	                value:'',
	                fieldLabel: '投资名称',
	                 width :120
          		  }]},
          	  		{
          		columnWidth: .5, 
           	  	layout : "form",   
           	  	items : [{
	                xtype: 'textfield',
	                id      : 'kgmc',
	                value:'',
	                fieldLabel: '开工名称',
	                 width :120
	                
           		 }]
           	  }
            ]},
   			{layout : "column", 
           	 items:[{
           	    columnWidth: .5, 
           	  	layout : "form",   
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'zgm',
	                value:'',
	                fieldLabel: '总规模',
	                width :120
	                }]},{
           	    columnWidth: .5, 
           	  	layout : "form",   
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'tz',
	                value:'',
	                fieldLabel: '投资',
	                width :120
	                }]},{
           	    columnWidth: .5, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'kg',
	                value:'',
	                fieldLabel: '开工',
	                 readOnly:true,
	                 width :120
	                }]}, 
	                {
           	    columnWidth: .5, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'kgbl',
	                value:'',
	                minValue:0,
	                maxValue:100,
	                fieldLabel: '开工%',
	                width : 120
                }]
            }]},
           {
   			 layout : "column", 
           	 items:[{
           	    columnWidth: .5, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'dl',
	                value:'',
	                fieldLabel: '使用量',
	                width :120
	                }]}, 
	                {
           	    columnWidth: .5, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'kc',
	                value:'',
	                minValue:0,
	                maxValue:100,
	                fieldLabel: '库存',
	                  width :120
	                
                }]
            }]},
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
	 Ext.getCmp("kgbl").addListener('change',function(){   
	 	Ext.getCmp("kg").setValue(Ext.getCmp("zgm").getValue()*Ext.getCmp("kgbl").getValue()/100);
	 }); 
  
   win2=new Ext.Window({
                applyTo:'addWin',
                title:'安置房建设录入',
                width:410,
                height:240,
                closeAction:'hide',
				items:form2
    });
 /////////////////////////////////////
     grid.render('mygrid_container'); 				      
})
 function addTask(){
    win2.items.items[0].form.url='<%=basePath%>service/rest/azfjs/add';
    win2.setTitle("安置房建设录入");
    win2.show();
 }
 
function modifyContent(id){
    //初始化数据
    var sinData=myData[id];
    Ext.getCmp("year").setValue(sinData.SX.split('-')[0]);
    win2.items.items[0].form.findField('month').setValue(sinData.YF);
    win2.items.items[0].form.url='<%=basePath%>service/rest/azfjs/update?&&azfbh='+sinData.AZFBH;
    win2.setTitle("安置房建设修改")
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
	    putClientCommond("azfjs","delete");
	    putRestParameter("azfbh",myData[id].AZFBH);
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
    putClientCommond("azfjs","query");
    putRestParameter("keyWord",keyWord);
    myData = restRequest(); 
    var width=document.body.clientWidth;
    store = new Ext.data.JsonStore({
     proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: 'KGMC'},
           {name: 'SX'},
           {name: 'ZGM'},
           {name: 'KG'},
           {name: 'KGBL'},
           {name: 'TZ'},
           {name: 'TZMC'},
 		   {name: 'SYL'},	         
           {name: 'KC'},
           {name: 'MOD'},
           {name: 'DEL'}
        ]
    });
    grid.reconfigure(store, new Ext.grid.ColumnModel([
          {header: '开工名称', dataIndex:'KGMC', width: width*0.1, sortable: false,renderer:changKeyword},
           {header: '时序', dataIndex:'SX', width: width*0.05, sortable: false,renderer:changKeyword},
           {header: '总规模', dataIndex:'ZGM', width: width*0.1, sortable: false},
           {header: '开工', dataIndex:'KG', width: width*0.1, sortable: false},
           {header: '开工%', dataIndex:'KGBL', width: width*0.05, sortable: false},
           {header: '投资名称', dataIndex:'TZMC',width: width*0.1, sortable: false,renderer:changKeyword},
           {header: '投资', dataIndex:'TZ', width: width*0.1, sortable: false},
           {header: '使用量', dataIndex:'SYL',width: width*0.1, sortable: false},
           {header: '安置房库存', dataIndex:'KC', width: width*0.1, sortable: false},
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