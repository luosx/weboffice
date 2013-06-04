<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.console.role.Role" %>
<%@page import="com.klspta.base.util.UtilFactory" %>
<%@page import="com.klspta.web.jinan.ajcc.AjQuery"%>

<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String userId = ((User) principal).getUserID();

	 //获取当前登录用户
  Object user = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
  User userBean = (User)user;
  //从用户得到所属的角色
  List<Role> role = ManagerFactory.getRoleManager().getRoleWithUserID(userBean.getUserID());
  //String rolename = role.get(0).getRolename();
  String []xzqhs=new String [3];
  System.out.println(role.get(0).getXzqh());
  
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
  String key = new AjQuery().getKeyList();
  
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
		<script type="text/javascript">
			
       var myData;
       var grid;
       var width;
       var height;
       var anjianStore;
        Ext.onReady(function(){
         
	       putClientCommond("ajcc","getAjList");
	       putRestParameter("userId",'<%=userId%>');
	       putRestParameter("hzqhs1",'<%=hzqhs1%>');
           putRestParameter("hzqhs2",'<%=hzqhs2%>');
           putRestParameter("hzqhs3",'<%=hzqhs3%>');
	       myData = eval(restRequest());
           var store = new Ext.data.JsonStore({
           proxy: new Ext.ux.data.PagingMemoryProxy(myData),
           remoteSort:true,
           fields: [
                        {name: 'AJNDSJ'},
                        {name: 'AJQY'},
                        {name: 'ZDWZ'},
                        {name: 'WFYDXZ'},
                        {name: 'FHGHMIANJI'},
                        {name: 'BFHGHMIANJI'},
                        {name: 'GDMIANJI'},
                        {name: 'QZJBNTMIANJI'},
                        {name: 'LASJ'},
                        {name: 'YW_GUID'},
                        {name: 'CFSJ'},
                        {name: 'TBBH'},
                        {name: 'AJH'}
          ]
       });
       
          var yunscomboData=[['like','='],['>=','>='],['<=','<=']];
          
	      yunscomboStore = new Ext.data.ArrayStore({
	      proxy: new Ext.ux.data.PagingMemoryProxy(yunscomboData),
          fields: ['value','text']
	    });
	    
	    
	      var luojcomboData=[['and','和'],['or','或者']];
          luojcomboStore = new Ext.data.ArrayStore({
	      proxy: new Ext.ux.data.PagingMemoryProxy(luojcomboData),
          fields: ['value','text']
	    });
	    
	    
	    var obj = eval('(<%=key%>)');
	
	      var keycomboStore = new Ext.data.JsonStore({
			        fields: ['CODE','NAME'],
			        data : <%=key%>
			    });
       
          var yunsCombo = new Ext.form.ComboBox({
			        id:'operator',
			        store: yunscomboStore,
			        displayField:'text',
			        valueField: 'value',
			        editable:true,
			        typeAhead: true,
			        width:90,
			        mode: 'remote',
			        forceSelection: true,
			        triggerAction: 'all',
			        selectOnFocus:true,
			        emptyText:'选择运算符...',
			        lazyInit:'false' 			        
		           });
		            yunscomboStore.on('load',function(store,record,opts){  
   					 var combo = Ext.getCmp("operator");  
        			 var firstValue = store.getRange()[0].data.value;//这种方法可以获得第一项的值  
    				// var firstValue  = record[0].data.value;//这种方法也可以获得第一项的值  
    				combo.setValue(firstValue);//选中  
    				//alert("value="+combo.getValue());//查看选中的value  
    				//alert("text="+combo.getRawValue());//查看选中的文本  
    				});
		           
		         var keyCombo = new Ext.form.ComboBox({
			    	id:'keywords',
			        store: keycomboStore,
			        displayField:'NAME',
			        valueField: 'CODE',
			        editable:true,
			        width:120,
			        mode: 'local',  
			        forceSelection: false,    
			        triggerAction: 'all',
			        emptyText:'选择关键字...',
			        selectOnFocus:false
			       
			    });
			    
			    
			       var luojCombo = new Ext.form.ComboBox({
			        id:'luoji',
			        store:luojcomboStore,
			        displayField:'text',
			        valueField: 'value',
			        editable:true,
			        typeAhead: true,
			        width:60,
			        mode: 'remote',
			        forceSelection: true,
			        triggerAction: 'all',
			        selectOnFocus:true,
			        emptyText:'选择逻辑符...',
			        lazyInit:'false' 			        
		           });
		           
      store.load({params:{start:0, limit:15}}); 
      width=document.body.clientWidth-20;
      height=document.body.clientHeight-22;//高度
      grid = new Ext.grid.GridPanel({
          title:'案件信息列表',
          store: store,
          columns: [
        	new Ext.grid.RowNumberer(),        
         			        		 {header: '案件年度时间',dataIndex:'AJNDSJ',width: width*0.12, sortable: true},
                         {header: '案件区域',dataIndex:'AJQY',width: width*0.07, sortable: true},
                         {header: '立案编号',dataIndex:'YW_GUID',width: width*0.10, sortable: true},
                         {header: '立案时间',dataIndex:'LASJ',width: width*0.10, sortable: true},
                         {header: '处罚时间',dataIndex:'CFSJ',width: width*0.10, sortable: true},
                         {header: '宗地位置',dataIndex:'ZDWZ',width: width*0.15, sortable: true},
                         {header: '违法用地性质',dataIndex:'WFYDXZ',width: width*0.12, sortable: true},
                         {header: '符合规划面积',dataIndex:'FHGHMIANJI',width: width*0.09, sortable: true},
                         {header: '不符合规划面积',dataIndex:'BFHGHMIANJI',width: width*0.10, sortable: true},
                         {header: '耕地面积',dataIndex:'GDMIANJI',width: width*0.10, sortable: true},
                         {header: '其中基本农田',dataIndex:'QZJBNTMIANJI',width: width*0.10, sortable: true},
                         {header: '图斑号',dataIndex:'TBBH',width: width*0.10, sortable: true},
                         {header: '案卷号',dataIndex:'AJH',width: width*0.10, sortable: true}
          ],
           tbar:[
		         		{xtype:'label',text:'关键字:',width:45},keyCombo,'&nbsp;',
		         		{xtype:'label',text:'运算符:',width:45},yunsCombo,'&nbsp;',
		         		{xtype:'label',text:'属性值:',width:45},
		         		{xtype:'textfield',id:'sxz',width:100},'&nbsp;',	
		         		{xtype:'label',text:'逻辑符:',width:45},luojCombo,'&nbsp;',
		         		{xtype: 'button',text:'添加',handler: addTj}
		    			
		         		 
				    ],listeners:{    
                       rowdblclick:function(grid,row){    
                       //alert(row)   
                       var num = grid.getBottomToolbar().cursor;
                       //alert(num)
                       var lanum=myData[row+num].YW_GUID;
                       //alert(lanum)
                       var yw_guid=lanum;
                       var returnPath=window.location.href;
					   var url='<%=basePath%>web/jinan/ajcc/v_jb.jsp?yw_guid='+yw_guid+'&jdbcname=GTJCTemplate&returnPath='+returnPath;
					   document.location.href=url;                        
                     }    
                   }, 
				    
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
      
      this.tb = new Ext.Toolbar({   
				renderTo:grid.tbar,            
				items:[   
					{xtype:'textfield',id:'tjsum',width:485},'&nbsp;',
					{xtype: 'button',text:'查询',handler: query},'&nbsp;',
		    		{xtype: 'button',text:'重置',handler: resetData},'&nbsp;',
		    		{xtype: 'button',text:'全部',handler: queryAll}
				]
		      	});
		      	Ext.getCmp("tjsum").getEl().dom.readOnly =true;
      });	
      
      
      function query(){
         //var keywords =Ext.getCmp('keywords').getValue();
         //var operator= Ext.getCmp('operator').getValue();
         var tjsum= Ext.getCmp('tjsum').getValue();
         putClientCommond("ajcc","getXcajData");
         putRestParameter("hzqhs1",'<%=hzqhs1%>');
         putRestParameter("hzqhs2",'<%=hzqhs2%>');
         putRestParameter("hzqhs3",'<%=hzqhs3%>');
         //putRestParameter("keywords",keywords);
		 //putRestParameter("operator",operator);
		 //alert(tjsum);
		 tjsum = escape(escape(tjsum));
		 putRestParameter("sum",tjsum);
		 myData = restRequest();
		 
		 store = new Ext.data.JsonStore({
				    proxy: new Ext.ux.data.PagingMemoryProxy(myData),
					remoteSort:true,
			        fields: [
                        {name: 'AJNDSJ'},
                        {name: 'AJQY'},
                        {name: 'ZDWZ'},
                        {name: 'WFYDXZ'},
                        {name: 'FHGHMIANJI'},
                        {name: 'BFHGHMIANJI'},
                        {name: 'GDMIANJI'},
                        {name: 'QZJBNTMIANJI'},
                        {name: 'LASJ'},
                        {name: 'YW_GUID'},
                        {name: 'CFSJ'},
                        {name: 'TBBH'},
                        {name: 'AJH'}
                   ]
				});
				 
				grid.reconfigure(store, new Ext.grid.ColumnModel([
		            new Ext.grid.RowNumberer(),
		        		 {header: '案件年度时间',dataIndex:'AJNDSJ',width: width*0.12, sortable: true},
                         {header: '案件区域',dataIndex:'AJQY',width: width*0.07, sortable: true},
                         {header: '立案编号',dataIndex:'YW_GUID',width: width*0.10, sortable: true},
                         {header: '立案时间',dataIndex:'LASJ',width: width*0.10, sortable: true},
                         {header: '处罚时间',dataIndex:'CFSJ',width: width*0.10, sortable: true},
                         {header: '宗地位置',dataIndex:'ZDWZ',width: width*0.15, sortable: true},
                         {header: '违法用地性质',dataIndex:'WFYDXZ',width: width*0.12, sortable: true},
                         {header: '符合规划面积',dataIndex:'FHGHMIANJI',width: width*0.09, sortable: true},
                         {header: '不符合规划面积',dataIndex:'BFHGHMIANJI',width: width*0.10, sortable: true},
                         {header: '耕地面积',dataIndex:'GDMIANJI',width: width*0.10, sortable: true},
                         {header: '其中基本农田',dataIndex:'QZJBNTMIANJI',width: width*0.10, sortable: true},
                         {header: '图斑号',dataIndex:'TBBH',width: width*0.10, sortable: true},
                         {header: '案卷号',dataIndex:'AJH',width: width*0.10, sortable: true}
                     
				]));
				//重新绑定分页工具栏
				grid.getBottomToolbar().bind(store);
				//重新加载数据集
				store.load({params:{start:0,limit:15}});  
			}
         
      
      	//重置选择框中的数据
			function resetData(){
				Ext.getCmp("keywords").reset();
				Ext.getCmp("operator").reset();
				Ext.getCmp("sxz").reset();
				Ext.getCmp("tjsum").reset();
				Ext.getCmp("luoji").reset();
				sum="";
				
				
			
			}
			
			function queryAll(){
			    putClientCommond("ajcc","getAjList");
	            putRestParameter("userId",'<%=userId%>');
	            putRestParameter("hzqhs1",'<%=hzqhs1%>');
                putRestParameter("hzqhs2",'<%=hzqhs2%>');
                putRestParameter("hzqhs3",'<%=hzqhs3%>');
	            myData = eval(restRequest());
	            
	            var store = new Ext.data.JsonStore({
                proxy: new Ext.ux.data.PagingMemoryProxy(myData),
                remoteSort:true,
                fields: [
                        {name: 'AJNDSJ'},
                        {name: 'AJQY'},
                        {name: 'ZDWZ'},
                        {name: 'WFYDXZ'},
                        {name: 'FHGHMIANJI'},
                        {name: 'BFHGHMIANJI'},
                        {name: 'GDMIANJI'},
                        {name: 'QZJBNTMIANJI'},
                        {name: 'LASJ'},
                        {name: 'YW_GUID'},
                        {name: 'CFSJ'},
                        {name: 'TBBH'},
                        {name: 'AJH'}
                 ]
               });
               
               grid.reconfigure(store, new Ext.grid.ColumnModel([
		            new Ext.grid.RowNumberer(),
		        		 {header: '案件年度时间',dataIndex:'AJNDSJ',width: width*0.12, sortable: true},
                         {header: '案件区域',dataIndex:'AJQY',width: width*0.07, sortable: true},
                         {header: '立案编号',dataIndex:'YW_GUID',width: width*0.10, sortable: true},
                         {header: '立案时间',dataIndex:'LASJ',width: width*0.10, sortable: true},
                         {header: '处罚时间',dataIndex:'CFSJ',width: width*0.10, sortable: true},
                         {header: '宗地位置',dataIndex:'ZDWZ',width: width*0.15, sortable: true},
                         {header: '违法用地性质',dataIndex:'WFYDXZ',width: width*0.12, sortable: true},
                         {header: '符合规划面积',dataIndex:'FHGHMIANJI',width: width*0.09, sortable: true},
                         {header: '不符合规划面积',dataIndex:'BFHGHMIANJI',width: width*0.10, sortable: true},
                         {header: '耕地面积',dataIndex:'GDMIANJI',width: width*0.10, sortable: true},
                         {header: '其中基本农田',dataIndex:'QZJBNTMIANJI',width: width*0.10, sortable: true},
                         {header: '图斑号',dataIndex:'TBBH',width: width*0.10, sortable: true},
                         {header: '案卷号',dataIndex:'AJH',width: width*0.10, sortable: true}
				]));
				//重新绑定分页工具栏
				grid.getBottomToolbar().bind(store);
				//重新加载数据集
				store.load({params:{start:0,limit:15}});  
			}
			
			sum = "";
           function addTj(){
               var keywords =Ext.getCmp('keywords').getValue();
               var operator= Ext.getCmp('operator').getValue();
               var sxz= Ext.getCmp('sxz').getValue();
               var luoji= Ext.getCmp('luoji').getValue();
              if(keywords!=null&&operator!=null&&sxz!=null){
                  if(sum==""||sum==null){
                    if("like"==operator){
				      sum=keywords+' '+operator+' '+"'"+'%'+sxz+'%'+"'";
			      	}else if("<="==operator ||">="==operator){
			      	  if(keywords.indexOf('MIANJI')!=-1){			      	  	
			      	  	 sum=keywords+' '+operator+' '+sxz;
			      	  }else{
				      	 sum=keywords+' '+operator+' '+"'"+sxz+"'";
				      }
			     	}
               	}else{
                   if(luoji==""||luoji==null){
                       luoji='and';
                   }
                   if("like"==operator){
				      sum="("+sum+") "+luoji+' '+keywords+' '+operator+' '+"'"+'%'+sxz+'%'+"'";
			       }else if("<="==operator ||">="==operator){
			       	  if(keywords.indexOf('mianji')!=-1){
			      	   	sum="("+sum+") "+luoji+' '+keywords+' '+operator+' '+sxz;
			      	  }else{
				      	sum="("+sum+") "+luoji+' '+keywords+' '+operator+' '+"'"+sxz+"'";
				      }
                  }
                }
              }
			    
			// alert(sum);
			 
			    Ext.getCmp("keywords").reset();
				Ext.getCmp("operator").reset();
				Ext.getCmp("sxz").reset();
				Ext.getCmp("luoji").reset();
				//alert(sum);
				
				 Ext.getCmp('tjsum').setValue(sum);
	         }
         
         
      
      
      
      
      </script>
	</head>
	<body  bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container"></div>
		
	</body>
</html>
      