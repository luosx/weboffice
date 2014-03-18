<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@page import="com.klspta.model.CBDReport.tablestyle.ITableStyle"%>
<%@page import="com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String reportID = "zrbHandle";
String keyIndex = "1";
ITableStyle its = new TableStyleEditRow();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/reportEdit.jspf"%>
	<script src="web/cbd/zcgl/tdzcgl/js/table.js"></script>
	<script src="web/cbd/zcgl/tdzcgl/js/panel.js"></script>
	<script src="base/include/jquery-1.10.2.js"></script>
	<%@ include file="/base/include/restRequest.jspf"%>	
	<script src="web/cbd/zcgl/tdzcgl/js/tdzcRowEditor.js"></script>
	
	<%@ include file="/base/include/ext.jspf" %>
	
	
	<style type="text/css">
  		table{
		    font-size: 14px;
		    background-color: #A8CEFF;
		    border-color:#000000;
		    /**
		    border-left:1dp #000000 solid;
		    border-top:1dp #000000 solid;
		    **/
		    color:#000000;
		    border-collapse: collapse;
  		}
  		tr{
    		border-width: 0px;
    		text-align:center;
  		}
  		td{
    		text-align:center;
    		border-color:#000000;
		    /**
		    border-bottom:1dp #000000 solid;
		    border-right:1dp #000000 solid;
		    **/
		  }
		.title{
		    font-weight:bold;
		    font-size: 15px;
		    text-align:center;
		    line-height: 50px;
			margin-top: 3px;
		  }
	  	.trtotal{
		  	text-align:center;
		    font-weight:bold;
		    line-height: 30px;
		   }
	  	.trsingle{
		    background-color: #D1E5FB;
		    line-height: 20px;
		    text-align:center;
		   }
	</style>
  </head>
  <script type="text/javascript">
  	var form;
  	var form2;
  	var paneloper2 = new Paneloper();
  	 $(document).ready(function () { 
		var width = document.body.clientWidth+10;
		var height = document.body.clientHeight;
       	FixTable("TDZCGL", 1,3, width, height);
       	buildPanel();
    });
  	function buildPanel(){
	  form2 = new Ext.form.FormPanel({
	        autoHeight: true,
	        frame:true,
	        bodyStyle:'padding:5px 0px 0',
	        width: 800,
	  		labelWidth :130,   
	  		labelAlign : "right",
	        url:"",
	        title:"土地资产信息",
	        defaults: {
	            anchor: '0'
	        },
	        layout:'form',
	        items : [{
	        	layout : 'column',
	        	items : [{
	        		columnWidth:.5,
	        		layout:'form',
	        		items:[
	        		{
		                xtype: 'combo',
		                id      : 'xmmc',
		                value:'',
		                store :[],
		                fieldLabel: '项目名称',  
		                width:'200'	,
		                mode: "local",   
				    	allowBlank:false
				    }]                
	            },{
	            	columnWidth:.5,
		        	layout:'form',
	            	items:[          		
		        		{
		                xtype: 'combo',
		                id      : 'status',
		                value:'',
		                store :[[1,'已出库'],[2,'待清理'],[3,'未受偿'],[4,'未供地'],[5,'长期库存'],[6,'已出让但未入库']],
		                fieldLabel: '状态',  
		                width:'200'	,
		                mode: "local",   
				    	allowBlank:false                
	            	}]
	            }]
         	},{
	         	layout : 'column',
	        	items : [{
	        		columnWidth:.5,
	        		layout:'form',
	        		items:[{
		                xtype: 'combo',
		                id      : 'dkmc',
		                value:'',
		                store :[],
		                fieldLabel: '地块名称',  
		                width:'200'	,
		                mode: "local",   
				    	allowBlank:false                
	            	}]
	            },{
	            	columnWidth:.5,
	        		layout:'form',
	        		items:[
	            	{
			            xtype : 'textfield',   
					    fieldLabel : '用地性质',   
					    id : 'ydxz',   
					    value:'',
					    readOnly : true,
					    allowBlank:false,  
		                width:'200'
					}]
				}]
			},{
				layout:'column',
				items:[{
					columnWidth:.5,
	        		layout:'form',
					items:[{
		                xtype: 'numberfield',
		                id      : 'jsydmj',
		                value:'',
		                fieldLabel: '建设用地面积(公顷)',
		                readOnly : true,
		                width:'200'
            		}]
            	},{
            		columnWidth:.5,
	        		layout:'form',
					items:[{
		                xtype: 'textfield',
		                id   : 'rjl',
		                value:'',
		                readOnly : true,
		                fieldLabel: '容积率',
		                width:'200'
		            }]
		         }]
	      	},{
	           	layout:'column',
	           	items:[{
					columnWidth:.5,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'ghjzgm',
		                value:'',
		                readOnly : true,
		                fieldLabel: '规划建筑规模(万㎡)',
		                width:'200'
	            	}]
	            },{
	            	columnWidth:.5,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'jzkzgd',
		                value:'',
		                readOnly : true,
		                fieldLabel: '建筑控制高度(米)',
		                width:'200'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
					columnWidth:.3,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'djkzj',
		                value:'',
		                fieldLabel: '地价款总价',
		                width:'90'
	            	}]
	            },{
	            	columnWidth:.3,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'djkyjn',
		                value:'',
		                fieldLabel: '地价款已缴纳',
		                width:'90'
	            	}]
            	},{
	            	columnWidth:.3,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'djkyjnbl',
		                value:'',
		                fieldLabel: '地价款已缴纳比例',
		                width:'90'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
					columnWidth:.3,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'zfsyze',
		                value:'',
		                fieldLabel: '政府收益总额',
		                width:'90'
	            	}]
	            },{
	            	columnWidth:.3,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'zfsyyjn',
		                value:'',
		                fieldLabel: '政府收益已缴纳',
		                width:'90'
	            	}]
            	},{
	            	columnWidth:.3,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'zfsyyjnbl',
		                value:'',
		                fieldLabel: '政府收益已缴纳比例',
		                width:'90'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
					columnWidth:.5,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'zfsyydjnsj',
		                value:'',
		                fieldLabel: '政府收益预定缴纳时间',
		                width:'200'
	            	}]
	            },{
	            	columnWidth:.5,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'zfsywyj',
		                value:'',
		                fieldLabel: '政府收益已产生违约金',
		                width:'200'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
					columnWidth:.3,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'bcfze',
		                value:'',
		                fieldLabel: '补偿费总额',
		                width:'90'
	            	}]
	            },{
	            	columnWidth:.3,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'bcfyjn',
		                value:'',
		                fieldLabel: '补偿费已缴纳',
		                width:'90'
	            	}]
            	},{
	            	columnWidth:.3,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'bcfyjnbl',
		                value:'',
		                fieldLabel: '补偿费已缴纳比例',
		                width:'90'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
					columnWidth:.5,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'bcfydjnsj',
		                value:'',
		                fieldLabel: '补偿费预定缴纳时间',
		                width:'200'
	            	}]
	            },{
	            	columnWidth:.5,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'bcfwyj',
		                value:'',
		                fieldLabel: '补偿费已产生违约金',
		                width:'200'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
					columnWidth:.3,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'djkjnsj',
		                value:'',
		                fieldLabel: '地价款缴纳时间',
		                width:'90'
	            	}]
	            },{
	            	columnWidth:.3,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'cbzh',
		                value:'',
		                fieldLabel: '储备证号',
		                width:'90'
	            	}]
            	},{
	            	columnWidth:.3,
	        		layout:'form',
	           		items:[{
		                xtype: 'numberfield',
		                id   : 'zzmj',
		                value:'',
		                fieldLabel: '证载面积',
		                width:'90'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
					columnWidth:.3,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'crsj',
		                value:'',
		                fieldLabel: '出让时间',
		                width:'90'
	            	}]
	            },{
	            	columnWidth:.3,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'zbr',
		                value:'',
		                fieldLabel: '中标人',
		                width:'90'
	            	}]
            	},{
	            	columnWidth:.3,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'xyydjdsj',
		                value:'',
		                fieldLabel: '协议约定交地时间',
		                width:'90'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
					columnWidth:.3,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'tdyjsj',
		                value:'',
		                fieldLabel: '土地移交时间',
		                width:'90'
	            	}]
	            },{
	            	columnWidth:.3,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'xmkgsj',
		                value:'',
		                fieldLabel: '项目开工时间',
		                width:'90'
	            	}]
            	},{
	            	columnWidth:.3,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'tdxzsj',
		                value:'',
		                fieldLabel: '土地闲置时间',
		                width:'90'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
					columnWidth:.5,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'yt',
		                value:'',
		                fieldLabel: '用途',
		                width:'200'
	            	}]
	            },{
	            	columnWidth:.5,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'sfyl',
		                value:'',
		                fieldLabel: '是否盈利',
		                width:'200'
	            	}]
	            }]
            },{
            	layout:'column',
	           	items:[{
	            	columnWidth:.5,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'dgdw',
		                value:'',
		                fieldLabel: '代管单位',
		                width:'200'
	            	}]
            	},{
	            	columnWidth:.5,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'sx',
		                value:'',
		                fieldLabel: '时限',
		                width:'200'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
					columnWidth:1,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'bz',
		                value:'',
		                fieldLabel: '备注',
		                width:'600'
	            	}]
	            }]
	        }], 
	        buttons: [
	            {
	                text   : '保存',
	                handler: function() {
	            			paneloper2.setRestUrl("tdzcglManager/add");
							paneloper2.save();
	                	}
	            	},   
	            	{
	                	text   : '取消',
	                	handler: function() {
	            			paneloper2.cancel();
	                	}
	            	}
	        ]
	  });		
  		form2.render("deal2");
  		form2.hide();
  		var elements2 = new Array("xmmc","status","dkmc","ydxz","jsydmj","rjl","ghjzgm","jzkzgd","djkzj",
  		"djkyjn","djkyjnbl","zfsyze","zfsyyjn","zfsyyjnbl","zfsyydjnsj","zfsywyj","bcfze","bcfyjn","bcfyjnbl",
  		"bcfydjnsj","bcfwyj","djkjnsj","cbzh","zzmj","crsj","zbr","xyydjdsj","tdyjsj",
  		"xmkgsj","tdxzsj","yt","sfyl","dgdw","sx","bz");
  		paneloper2.init(form2,elements2);
  		paneloper2.hide();
  	}
  // })
  </script>
  <body  >
  	<div id='show' >
  		<%=new CBDReportManager().getReport("TDZCGL",its)%>
  	</div>
  	<div id="deal2" style="position:absolute; left:5px; top:5px; "></div>
  	<form id="attachfile" action="<%=basePath%>service/rest/zrbHandle/update" method="post">
	</form> 
  </body>
</html>
