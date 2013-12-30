<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String xmmc = request.getParameter("xmmc");
	String yw_guid = request.getParameter("yw_guid");
	if(xmmc!=null){
		xmmc = new String(xmmc.getBytes("iso-8859-1"),"utf-8");
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>项目控规指标表</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@ include file="/base/include/ext.jspf"%>
		<%@ include file="/base/include/restRequest.jspf"%>
		<script src="DatePicker.js"></script>
		<style>
input,img {
	vertical-align: middle;
}
</style>
		<script>
		var basePath="<%=basePath%>";
		function ss(){
		var tb = document.getElementById("XMKGZBBCX"); 
		add(tb);
		}
		
var ydxzlx;
var data;
var formPanel;
var radio ;
var simple;
var fp;
var adding = false;

var url = basePath
		+ 'web/cbd/xmgl/xmkgzb/xmkgzbReport.jsp?yw_guid=<%=yw_guid%>&xmmc=<%=xmmc%>';
var condition = "";

Ext.onReady(function() {
			width = document.body.clientWidth;
			height = document.body.clientHeight;
			initComponent();
			
		});

function initComponent() {
	simple = new Ext.FormPanel({
				frame : true,
				title : '项目控规指标表',
				bodyStyle : 'padding:5px 5px 0',
				tbar : [{
							xtype : 'label',
							text : '关键字：'
						}, {xtype:'textfield',id:'keyword',width:200,emptyText:'请输入关键字进行查询'},'-', {
							xtype : 'button',
							text : '查询',
							handler : query
						}, '-', {
							xtype : 'button',
							text : '导出Excel',
							handler : exportExcel
						},'-',{
							xtype : 'button',
							text : '添加地块',
							handler : add
						}],
				items : [{
					html : "<iframe id='report' width=" + (width - 50)
							+ " height=" + (height - 80) + " src=" + url
							+ "></iframe>"
				}]
			});
	simple.render(document.body);
}

function query() {
	var keyword = Ext.getCmp("keyword").getValue();
	document.frames['report'].query( keyword);
}

function exportExcel() {
	document.frames['report'].print();
}

Ext.onReady(function(){   
  radio = { 
    		xtype: 'radiogroup',
            fieldLabel: '请选择地块类型',
            itemCls: 'x-check-group-alt',
            id:'lxs',
            name:'lxs',
            columns: 1,
            allowBlank :false,
            items: [   
                {boxLabel: '经营性建设用地', inputValue : "1",name: 'lx'},   
                {boxLabel: '非经营性建设用地', inputValue : "2",name: 'lx'},   
                {boxLabel: '代征绿地及水域',inputValue : "3", name: 'lx'},   
                {boxLabel: '代征道路',inputValue : "4", name: 'lx'}
            ] ,
         listeners :{
         'change':function(){
         ydxzlx= Ext.getCmp("lxs").getValue().inputValue;
          }
        }     
    }; 
      
    formPanel =new Ext.form.FormPanel({   
            frame:true,   
            items:[radio 
            ],
            buttons: [{
	                    text:'提交',
	                    handler: function(){
		                        if(ydxzlx!=null){
			                        fp.hide();
			                        adding = true;
			                        addb();
			                        }else{
			                        	alert("地块类型不能为空！！！");
			                        }
                	    }
                	},{
	                    text: '关闭',
	                    handler: function(){
	                        fp.hide();
                    }
			}]   
	});  
  
   fp = new Ext.Window({ 
   		closeAction:"hide",
    	title:'添加地块',    
        frame: true,   
        labelWidth:160,   
        width: 450,   
        height:180,   
        items: [   
            formPanel   
        ]   
    });  
      
    }) 

function add(){
	if(adding == false){
		fp.show();
	}else{
		alert("请将前一地块提交后再进行此操作！");
	}
 }
 function addb(){
		var tb = frames['report'].document.getElementById("XMKGZBBCX"); 
		var tr = tb.insertRow(1);     
		tr.style.cssText = tb.rows[1].style.trsingle; 
		
		var td1 = tr.insertCell();
		var td2 = tr.insertCell();
		var td3 = tr.insertCell();
		var td4 = tr.insertCell();
		var td5 = tr.insertCell();
		var td6 = tr.insertCell();
		var td7 = tr.insertCell();
		var td8 = tr.insertCell();
		var td9 = tr.insertCell();
		td1.innerHTML = "0";
		td2.innerHTML = "<input id='dkbh' style='width: 80px' type='text' value=''  />";
		td3.innerHTML = "<input id='ydxzdh' style='width: 20px' type='text' value=''  />";
		td4.innerHTML = "<input id='ydxz' style='width: 80px' type='text' value=''   />";
		td5.innerHTML = "<input id='ydmj' style='width: 80px' type='text' value=''   />";
		td6.innerHTML = "<input id='rjl' style='width: 80px' type='text' value=''   />";
		td7.innerHTML = "<input id='jzmj' style='width: 80px' type='text' value=''   />";
		td8.innerHTML = "<input id='kzgd' style='width: 80px' type='text' value=''   />";
		td9.innerHTML = "<input id='bz' style='width: 80px' type='text' value=''/><input type='button' value='保存' onclick='saves("+ydxzlx+","+adding+")'/>";
		
	} 
	
		</script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
		<div id="mygrid_container"></div>
		<div id="update" class="x-hidden">
			<div id="updateForm"
				style="width: 100%; height: 90%; margin-left: 10px; margin-top: 5px"></div>
		</div>
		
	</body>
</html>