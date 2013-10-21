<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
    String yw_guid= request.getParameter("yw_guid").toString();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>供地体量列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/restRequest.jspf"%>
		<%@ include file="/base/include/ext.jspf"%>
 		<script type="text/javascript" src="cell-editing.js"></script>
		<!-- 根据办理时限不同修改数据的显示颜色 -->
		<style type="text/css">
  	.list_title_c{height:30px; text-align:center; margin-top:3px;border-bottom:1px solid #bddafe;}
.tableheader{color:#000000;font-size: 12px;height:30px;width:100%;margin-bottom:0px;border-bottom:1px solid #8DB2E3;}


</style>
		<script type="text/javascript">
var myData;
var win;
var store;
var grid;
var expWin;
var form;
Ext.onReady(function(){
    putClientCommond("hxxmManager","queryGdtl");
    putRestParameter("xmbh",'<%=yw_guid%>')
	myData = restRequest();
	var tbar1 = new Ext.Toolbar([ 
     {text:'添加按钮'},{text:'修改按钮'},{text:'删除按钮'}]); 
	
	
 	store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: 'XMMC'},
           {name: 'SX'},
           {name: 'DL'},
           {name: 'DLZ'},
           {name: 'GM'},
           {name: 'GMZ'},
           {name: 'CB'},
           {name: 'CBZ'},
           {name: 'SY'},
           {name: 'SYZ'},
           {name: 'ZJ'},
           {name: 'ZJZ'},
           {name: 'ZUJIN'},
           {name: 'MOD'},
           {name: 'DEL'}
        ]
    });
    
    store.load({params:{start:0, limit:15}});
    var width=document.body.clientWidth;
    var height=document.body.clientHeight*0.9;
    //base/thirdres/ext/resources/images/default/tabs/tab-btm-inactive-right-bg.gif
    //base/thirdres/ext/examples/chart/bar.gif
    //base/thirdres/ext/examples/image-organizer/images/selected.gif
   // var ht="<div style='height:60;background:url(base/thirdres/ext/examples/image-organizer/images/selected.gif)'>adad a d</div>"
	var con='<div style=" height:60; background:url(base/thirdres/ext/examples/image-organizer/images/selected.gif)"><table  cellpadding="0" cellspacing="0" style="border-top: 0px #2d8ade solid;" align="center" width="100%" ><tr  class="tableheader" ><td rowspan="2" class="list_title_c" style="border-left:1px solid #bddafe; border-right:1px solid #bddafe;"><label>序号</label></td><td rowspan="2" class="list_title_c"  style="border-right:1px solid #bddafe;"><label>编号</label></td><td class="list_title_c" rowspan="2"  style="border-right:1px solid #bddafe;"><label>占地<br/>面积</label></td><td class="list_title_c" colspan="2"  style="border-right:1px solid #bddafe; border-bottom:1px solid #bddafe;"><label>总计</label></td><td  class="list_title_c"  colspan="3"  style="border-right:1px solid #bddafe; border-bottom:1px solid #bddafe;"><label>住宅拆迁(户、人、㎡)</label></td><td class="list_title_c" colspan="2"  style="border-right:1px solid #bddafe; border-bottom:1px solid #bddafe;"><label>非住宅拆迁(㎡)</label></td><td class="list_title_c" rowspan="2"  style="border-right:1px solid #bddafe; width:200px;"><label>备注</label></td><td class="list_title_c" rowspan="2"  style="border-right:1px solid #bddafe;"><label>删除</label></td></tr><tr  class="tableheader" ><td class="list_title_c" style="border-right:1px solid #bddafe; "><label>楼座面积</label></td><td class="list_title_c" style="border-right:1px solid #bddafe; "><label>拆迁规模</label></td><td class="list_title_c" style="border-right:1px solid #bddafe; "><label>住宅楼座<br/>面积</label></td><td class="list_title_c" style="border-right:1px solid #bddafe; "><label>住宅拆迁<br/>规模</label></td><td class="list_title_c" style="border-right:1px solid #bddafe; "><label>预计户数</label></td><td class="list_title_c" style="border-right:1px solid #bddafe; "><label>非住宅<br/>楼座面积</label></td><td class="list_title_c" style="border-right:1px solid #bddafe; "><label>非住宅<br/>拆迁规模</label></td></tr></table>'
	var ht=con;
	var table = new Ext.Panel({
    layout:'table',
     height:60,
    layoutConfig: {
        // 这里指定总列数The total column count must be specified here
        columns: 3
    },
    items: [{
                id      : 'xmmc',
                height:60,
                html:ht,
                width:width
    }
    /**,{
       xtype: 'button',
       id      : 'xmmc1',
       text:'总计',
       height:30,
       width:width*0.1,
       colspan: 2
    },{
 		xtype: 'button',
       id      : 'xmmc2',
       text:'楼盘面积',
       height:30,
       width:width*0.05
    },{
 	   xtype: 'button',
       id      : 'xmmc3',
       text:'拆迁规模',
       height:30,
       width:width*0.05
    }**/]
});
    var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown:Ext.emptyFn});  
        grid = new Ext.grid.EditorGridPanel({
        store: store,
        sm:sm,
        hideHeaders: true,
        columns: [
           {header: '项目名称', dataIndex:'XMMC',width: width*0.1, sortable: false,       
           editor:new Ext.form.TextField({   
               allowBlank:false  
            }) },
           {header: '时序', dataIndex:'SX', width: width*0.1, sortable: false,renderer:changKeyword},
           {header: '地量', dataIndex:'DL', width: width*0.05, sortable: false },
           {header: '地量%', dataIndex:'DLZ', width: width*0.05, sortable: false},
           {header: '规模', dataIndex:'GM',width: width*0.1, sortable: false},
           {header: '规模%', dataIndex:'GMZ',width: width*0.05, sortable: false},
           {header: '成本', dataIndex:'CB',width: width*0.1, sortable: false},
           {header: '成本%', dataIndex:'GMZ',width: width*0.05, sortable: false},
           {header: '收益', dataIndex:'SY',width: width*0.05, sortable: false},
           {header: '收益%', dataIndex:'SYZ',width: width*0.05, sortable: false},
           {header: '总价', dataIndex:'ZJ',width: width*0.05, sortable: false},
           {header: '总价%', dataIndex:'ZJZ',width: width*0.05, sortable: false},
           {header: '租金', dataIndex:'ZJ',width: width*0.1, sortable: false},
           {header: '修改', dataIndex:'MOD',width: width*0.05, sortable: false, renderer: modify}, 
           {header: '删除',dataIndex:'DEL',width: width*0.05, sortable: false,renderer:del}
        ],
          tbar:[
        			
	    		 	 {xtype:'label',text:'快速查找:',width:60},
	    			 {xtype:'textfield',id:'keyword',width:240,emptyText:'请输入查询字段'},
	    			 {xtype: 'button',id:'button',text:'查询',handler: query},
	    			 {xtype:'button',text:'供地开发体量',width:60,handler: addTask}
	    ],
        stripeRows: true,
        listeners:{

		'render': function(){ 
            table.render(grid.tbar); 
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
        url:"<%=basePath%>service/rest/hxxmManager/addGdtl?xmbh=<%=yw_guid%>",
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
	                id      : 'xmdl',
	                value:'',
	                fieldLabel: '项目地量',
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
	                fieldLabel: '项目规模',
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
	                id      : 'lmcb',
	                value:'',
	                fieldLabel: '楼面成本',
	                 readOnly:true,
	                width :60
	                }]},{
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'cb',
	                value:'',
	                fieldLabel: '成本',
	                   readOnly:true,
	                 width :60
	                }]}, 
	                {
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'cbbl',
	                value:'',
	                minValue:0,
	                maxValue:100,
	                fieldLabel: '成本%',
	                   readOnly:true,
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
	                id      : 'cjj',
	                value:'',
	                fieldLabel: '楼面成交价',
	                readOnly:true,
	                width :60
	                }]},{
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'sy',
	                value:'',
	                fieldLabel: '收益',
	                   readOnly:true,
	                 width :60
	                }]}, 
	                {
           	    columnWidth: .33, 
           	  	layout : "form",
           	  	items : [{
	                xtype: 'numberfield',
	                id      : 'sybl',
	                value:'',
	                minValue:0,
	                maxValue:100,
	                fieldLabel: '收益%',
	                  readOnly:true,
	                  width : 60
	                
                }]
            }]},
            {
   			 layout : "column", 
           	 items:[
           	 {  
           	 columnWidth: .33, 
           	  	layout : "form",   
           	  	items :[  
           	  	{
	                xtype: 'numberfield',
	                id      : 'fwsj',
	                value:'',
	                fieldLabel: '房屋售价',
	                readOnly:true,
	                width :60
	                }]}
	            ,
           	 {
           	    columnWidth: .33, 
           	  	layout : "form",   
           	  	items :[     {
                xtype: 'numberfield',
                id      : 'zj',
                value:'',
                fieldLabel: '总价',
                   readOnly:true,
                 width : 60
            }]},
	            {
	            columnWidth: .33, 
           	  	layout : "form",
           	  	items :[  {
                xtype: 'numberfield',
                id      : 'zjbl',
                value:'',
                minValue:0,
	            maxValue:100,
                fieldLabel: '总价%',
                   readOnly:true,
                 width : 60
          		  }]}
            ]},{
   			 layout : "column", 
           	 items:[{
	            columnWidth: .33, 
           	  	layout : "form",
           	  	items :[  {
                xtype: 'numberfield',
                id      : 'xmzujin',
                value:'',
                fieldLabel: '项目租金',
                 width : 60
          		  }]},{
	            columnWidth: .33, 
           	  	layout : "form",
           	  	items :[{
                xtype: 'numberfield',
                id      : 'zujin',
                value:'',
                fieldLabel: '租金',
                 width : 60
          		  }]}]
              },{
	                xtype: 'label',
	                id      : 'sm',
	                value:'',
	                fieldLabel: '',
	                html:'<div style="color:red">&nbsp&nbsp地量:公顷&nbsp&nbsp规模:万m2&nbsp&nbsp成本收益:亿元&nbsp&nbsp&nbsp总价:万元/m2&nbsp&nbsp&nbsp租金:元/m2/天</div>',
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
  	 Ext.getCmp("dlbl").addListener('change',function(){   
	 	Ext.getCmp("dl").setValue(Ext.getCmp("xmdl").getValue()*Ext.getCmp("dlbl").getValue()/100);
	 });
	Ext.getCmp("gmbl").addListener('change',function(){   
	 	Ext.getCmp("gm").setValue(Ext.getCmp("xmgm").getValue()*Ext.getCmp("gmbl").getValue()/100);
	 	Ext.getCmp("cb").setValue(Ext.getCmp("gm").getValue()*Ext.getCmp("lmcb").getValue());
	 	Ext.getCmp("cbbl").setValue(Ext.getCmp("gmbl").getValue());
	 	Ext.getCmp("sybl").setValue(Ext.getCmp("gmbl").getValue());
	 	Ext.getCmp("zjbl").setValue(Ext.getCmp("gmbl").getValue());
	 });
  
    putClientCommond("hxxmManager","getXmmc");
    putRestParameter("xmbh",'<%=yw_guid%>')
	var info = restRequest();
	if(info[0]!=null){
	  Ext.getCmp("xmdl").setValue(info[0].ZD);
	  Ext.getCmp("xmgm").setValue(info[0].GM);
	  Ext.getCmp("lmcb").setValue(info[0].LMCB);
	  Ext.getCmp("zujin").setValue(info[0].ZJ); 
	  Ext.getCmp("xmzujin").setValue(info[0].ZJ); 
	  Ext.getCmp("cjj").setValue(info[0].LMCJJ);
	  Ext.getCmp("fwsj").setValue(info[0].FWSJ); 
	  Ext.getCmp("sy").setValue(Ext.getCmp("cjj").getValue()-Ext.getCmp("lmcb").getValue()); 
	  Ext.getCmp("zj").setValue(info[0].FWSJ);   	 
    }
  
   win2=new Ext.Window({
                applyTo:'addWin',
                title:'供地体量录入',
                width:410,
                height:330,
                closeAction:'hide',
				items:form2
    });
    putClientCommond("hxxmManager","getXmmc");
    putRestParameter("xmbh",'<%=yw_guid%>')
	var info = restRequest();
  //  Ext.getCmp("xmmc").setValue(info[0].XMNAME);	    
 /////////////////////////////////////
     grid.render('mygrid_container'); 				      
})
 function addTask(){
  win2.show();
 }

function modifyContent(id){
    //初始化数据
    var sinData=myData[id];
    Ext.getCmp("year").setValue(sinData.SX.split('-')[0]);
    win2.items.items[0].form.findField('month').setValue(sinData.YF);
    Ext.getCmp("dl").setValue(sinData.DL);
    Ext.getCmp("dlbl").setValue(sinData.DLZ);
    Ext.getCmp("gm").setValue(sinData.GM);
    Ext.getCmp("gmbl").setValue(sinData.GMZ);
    Ext.getCmp("cb").setValue(sinData.CB);
    Ext.getCmp("cbbl").setValue(sinData.CBZ);
    Ext.getCmp("sybl").setValue(sinData.SYZ);
    Ext.getCmp("zjbl").setValue(sinData.ZJZ);
    win2.items.items[0].form.url='<%=basePath%>service/rest/hxxmManager/updateGdtl?xmbh=<%=yw_guid%>&&gdbh='+sinData.GDBH;
    win2.setTitle("供地体量修改")
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
	    var path = "<%=basePath%>";
	    putClientCommond("hxxmManager","delGdtl");
	    putRestParameter("gdbh",myData[id].GDBH)
        var mes = restRequest(); 
   		if(mes.success){
           query();
        }else{
        Ext.MessageBox.alert("提示","删除失败");
        }
      }else{
			return false;
		}
	});
}

function query(){
  var keyWord = Ext.getCmp('keyword').getValue();
    keyWord=escape(escape(keyWord));
    putClientCommond("hxxmManager","queryGdtl");
    putRestParameter("xmbh",'<%=yw_guid%>')
    putRestParameter("keyWord",keyWord);
    myData = restRequest(); 
    var width=document.body.clientWidth;
	 store = new Ext.data.JsonStore({
     proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: 'XMMC'},
           {name: 'SX'},
           {name: 'DL'},
           {name: 'DLZ'},
           {name: 'GM'},
           {name: 'GMZ'},
           {name: 'CB'},
           {name: 'CBZ'},
           {name: 'SY'},
           {name: 'SYZ'},
           {name: 'ZJ'},
           {name: 'ZJZ'},
           {name: 'ZUJIN'},
           {name: 'MOD'},
           {name: 'DEL'}
        ]
    });
    grid.reconfigure(store, new Ext.grid.ColumnModel([
           {header: '项目名称', dataIndex:'XMMC', width: width*0.1, sortable: false},
           {header: '时序', dataIndex:'SX', width: width*0.1, sortable: false,renderer:changKeyword},
           {header: '地量', dataIndex:'DL', width: width*0.05, sortable: false},
           {header: '地量%', dataIndex:'DLZ', width: width*0.05, sortable: false},
           {header: '规模', dataIndex:'GM',width: width*0.1, sortable: false},
           {header: '规模%', dataIndex:'GMZ',width: width*0.05, sortable: false},
           {header: '成本', dataIndex:'CB',width: width*0.1, sortable: false},
           {header: '成本%', dataIndex:'GMZ',width: width*0.05, sortable: false},
           {header: '收益', dataIndex:'SY',width: width*0.05, sortable: false},
           {header: '收益%', dataIndex:'SYZ',width: width*0.05, sortable: false},
           {header: '总价', dataIndex:'ZJ',width: width*0.05, sortable: false},
           {header: '总价%', dataIndex:'ZJZ',width: width*0.05, sortable: false},
           {header: '租金', dataIndex:'ZJ',width: width*0.1, sortable: false},
           {header: '修改', dataIndex:'MOD',width: width*0.05, sortable: false, renderer: modify}, 
           {header: '删除',dataIndex:'DEL',width: width*0.05, sortable: false,renderer:del}
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