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
Ext.onReady(function(){
    putClientCommond("padDataManager","getQueryData");
    putRestParameter("userId",'<%=userid%>')
    putRestParameter("flag",'<%=flag%>')
	myData = restRequest();
 	store = new Ext.data.JsonStore({
    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
		remoteSort:true,
        fields: [
           {name: 'READFLAG'},
           {name: 'XMMC'},
           {name: 'SL'},
           {name: 'DJ'},
           {name: 'GM'},
           {name: 'CB'},
           {name: 'SY'},
           {name: 'ZJ'},
           {name: 'ZUJIN'},
           {name: 'DELETE'}
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
           {header: '时历', dataIndex:'SL', width: width*0.1, sortable: false},
           {header: '地量', dataIndex:'DL', width: width*0.15, sortable: false},
           {header: '规模', dataIndex:'GM',width: width*0.1, sortable: false},
            {header: '成本', dataIndex:'CB',width: width*0.15, sortable: false},
            {header: '收益', dataIndex:'SY',width: width*0.1, sortable: false},
            {header: '总价', dataIndex:'ZJ',width: width*0.1, sortable: false},
           {header: '租金', dataIndex:'ZJ',width: width*0.15, sortable: false},
            {header: '删除',dataIndex:'DELETE',width: width*0.05, sortable: false,renderer:del}
        ],
          tbar:[
        			
	    		 	 {xtype:'label',text:'快速查找:',width:60},
	    			 {xtype:'textfield',id:'keyword',width:240,emptyText:'请输入查询字段'},
	    			 {xtype: 'button',id:'button',text:'查询',handler: query},
	    			  {xtype:'button',text:'供地开发体量',width:60,handler: addTask}
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
                fields: ['id','name'],
                 data: [[1,'第一季度'], [2,'第二季度'], [3,'第三季度'], [4,'第四季度']]
             });
    var comboboxS = new Ext.form.ComboBox({
                fieldLabel: '时序季度',
                 store: combostore,
                 displayField: 'name',
                 valueField: 'id',
                 triggerAction: 'all',
                 emptyText: '请选择季度...',
                 allowBlank: false,
                 blankText: '请选择季度',
                 editable: false,
                 mode: 'local'
             });           
   
   var form2 = new Ext.form.FormPanel({
        autoHeight: true,
        frame:true,
        bodyStyle:'padding:5px 0px 0',
        width: 300,
        url:"<%=basePath%>service/rest/taskdeal/addTask",
        defaults: {
            anchor: '0'
        },
        items   : [
           	{
                xtype: 'textfield',
                id      : 'xmmc',
                value:'',
                fieldLabel: '项目名称'
            },
            combobox,
    		comboboxS,
            {
                xtype     : 'textfield',
           		id:'dl',
                value:'',
                fieldLabel: '地量'            
            },
             {
                xtype: 'textfield',
                id      : 'gm',
                value:'',
                fieldLabel: '规模'
            }, 
            {
                xtype: 'textfield',
                id      : 'cb',
                value:'',
                fieldLabel: '成本'
            },{
                xtype: 'textfield',
                id      : 'sy',
                value:'',
                fieldLabel: '收益'
            },
            {
                xtype: 'textfield',
                id      : 'zj',
                value:'',
                fieldLabel: '总价'
            },
            {
                xtype: 'textfield',
                id      : 'zujin',
                value:'',
                fieldLabel: '租金'
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
							  document.location.reload();
							 });
							
							}, 
							failure:function(){ 
								Ext.Msg.alert('提示','保存失败，请稍后重试或联系管理员。');
							} 
						});
                	}
            	},   
            {
                text   : '重置',
                handler: function() {

                  //Ext.getCmp('rwlx').reset();
                }
            }
        ]
  });		
  
   win2=new Ext.Window({
                applyTo:'addWin',
                title:'供地体量录入',
                width:310,
                height:330,
                closeAction:'hide',
				items:form2
    }); 	    
 /////////////////////////////////////
     grid.render('mygrid_container'); 				      
})
 function addTask(){
  win2.show();
 }

function view(id){
	return "<a href='#' onclick='showDetail("+id+");return false;'><img src='base/form/images/view.png' alt='详细信息'></a>";
}
function del(id){
 	return "<a href='#' onclick='delTask("+id+");return false;'><img src='base/form/images/delete.png' alt='删除'></a>";
}

function delTask(id){
	Ext.MessageBox.confirm('注意', '删除后不能恢复，您确定吗？',function(btn){
	  if(btn=='yes'){
	    var path = "<%=basePath%>";
	    putClientCommond("padDataManager","delData");
	    putRestParameter("yw_guid",myData[id].GUID)
        var mes = restRequest(); 
		document.location.reload();
		}
		else{
		return false;
		}
	});
}


function showDetail(id){
    var url = "<%=basePath%>web/jizeNW/dtxc/wyxc/xjclyjframe.jsp?zfjcType=11&yw_guid="+myData[id].GUID;     
	//document.location.href=url;
	var height = window.screen.availHeight;
	var width = window.screen.availWidth;
	window.showModalDialog(url,"","dialogWidth="+width+";dialogHeight="+height);
}

function query(){
  var keyWord = Ext.getCmp('keyword').getValue();
    keyWord=escape(escape(keyWord));
    putClientCommond("padDataManager","getQueryData");
    putRestParameter("userId",'<%=userid%>')
    putRestParameter("flag",'<%=flag%>')
    putRestParameter("keyWord",keyWord);
    var myData1 = restRequest(); 
    var width=document.body.clientWidth;
 store = new Ext.data.JsonStore({
     proxy: new Ext.ux.data.PagingMemoryProxy(myData1),
		remoteSort:true,
        fields: [
           {name: 'READFLAG'},
           {name: 'XMMC'},
           {name: 'SL'},
           {name: 'DJ'},
           {name: 'GM'},
           {name: 'CB'},
           {name: 'SY'},
           {name: 'ZJ'},
           {name: 'ZUJIN'},
           {name: 'DELETE'}
        ]
    });
    grid.reconfigure(store, new Ext.grid.ColumnModel([
           {header: '项目名称', dataIndex:'XMMC', width: width*0.1, sortable: false},
           {header: '时历', dataIndex:'SL', width: width*0.1, sortable: false},
           {header: '地量', dataIndex:'DL', width: width*0.15, sortable: false},
           {header: '规模', dataIndex:'GM',width: width*0.1, sortable: false},
            {header: '成本', dataIndex:'CB',width: width*0.15, sortable: false},
            {header: '收益', dataIndex:'SY',width: width*0.1, sortable: false},
            {header: '总价', dataIndex:'ZJ',width: width*0.1, sortable: false},
           {header: '租金', dataIndex:'ZJ',width: width*0.15, sortable: false},
            {header: '删除',dataIndex:'DELETE',width: width*0.05, sortable: false,renderer:del}
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