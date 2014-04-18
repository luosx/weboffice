<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@page import="com.klspta.web.cbd.yzt.jbb.JbbManager"%>
<%@page import="com.klspta.model.CBDReport.tablestyle.ITableStyle"%>
<%@page import="com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Map<String, String> proMap = JbbManager.getDKMCMap();
String extPath = basePath + "base/thirdres/ext/";
String reportID = "CBJHZHB";
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
	<script src="web/cbd/yzt/cbjhzhb/js/table.js"></script>
	<script src="web/cbd/yzt/cbjhzhb/js/panel.js"></script>
	<script src="web/cbd/yzt/cbjhzhb/js/xmcbRowEditor.js"></script>
	<%@ include file="/base/include/ext.jspf" %>
	<script type="text/javascript" src="<%=extPath%>examples/ux/MultiSelect.js"></script>
	<script type="text/javascript" src="<%=extPath%>examples/ux/ItemSelector.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=extPath%>examples/ux/css/MultiSelect.css"/>
	<%@ include file="/base/include/restRequest.jspf"%>
	<%@ include file="/web/cbd/yzt/cbjhzhb/js/reportEdit.jspf"%>
	<script src="base/include/jquery-1.10.2.js"></script>
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
  </script>
  <script type="text/javascript">
  	var form;
  		var table = new tableoper();
  	var paneloper = new Paneloper();
  	$(document).ready(function () { 
		var width = document.body.clientWidth;
		var height = document.body.clientHeight-20;
       	FixTable("CBJHZHB", 1,3, width, height);
       	buildPanel();
	});
	function buildPanel(){
  		form = new Ext.form.FormPanel({
	        autoHeight: true,
	        frame:true,
	        bodyStyle:'padding:5px 0px 0',
	        width: 850,
	  		labelWidth :150,   
	  		labelAlign : "right",
	        url:"",
	        title:"项目储备计划信息",
	        defaults: {
	            anchor: '0'
	        },
	        layout:'form',
	        items : [{
	         	layout : 'column',
	        	items : [{
	        		columnWidth:.3,
	        		layout:'form',
	        		items:[{
		                xtype: 'textfield',
		                id      : 'XMMC',
		                value:'',
		                fieldLabel: '项目名称',
		                readOnly:true,  
		                width:'80'	            
	            	}]
	            },{
            		columnWidth:.4,
	        		layout:'form',
					items:[{
		                xtype: 'combo',
		                id   : 'XMLX',
		                value:'', 
		                store:[[1,"计划新增项目"],[2,"结转项目"],[3,"前期研究项目"]],
		                fieldLabel: '项目类型',
		                width:'100',
		                mode: "local",   
				    	allowBlank:false
		            }]
		         },{
            		columnWidth:.3,
	        		layout:'form',
					items:[{
		                xtype: 'textfield',
		                id   : 'XMQX',
		                value:'',  
		                fieldLabel: '区县',
		                width:'80'
		            }]
		         }]
		      },{
	           	layout:'column',
	           	items:[{
					columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'DKMC',
		                value:'',
		                fieldLabel: '地块名称',
		                width:'100'
	            	}]
	            },{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'XMWZ',
		                value:'',
		                fieldLabel: '项目位置',
		                width:'100'
	            	}]
            	},{
					columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'XMQW',
		                value:'',
		                fieldLabel: '项目区位',
		                width:'100'
	            	}]
	            }]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'XMLB',
		                value:'',
		                fieldLabel: '项目类别',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'XMZT',
		                value:'',
		                fieldLabel: '项目主体',
		                width:'100'
	            	}]
            	},{
					columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'SFDZ',
		                value:'',
		                fieldLabel: '实施主体是否带资',
		                width:'100'
	            	}]
	            }]
	        },{	
	        	layout:'column',
				items:[{
	            	columnWidth:.33,
	        		layout:'form',
	        		items:[
	            	{
			            xtype : 'textfield',   
					    fieldLabel : '项目单位带资实施比率',   
					    id : 'DZBV',   
					    value:'',
		                width:'100'
					}]
				},{
	            	columnWidth:.33,
	        		layout:'form',
	        		items:[
	            	{
			            xtype : 'textfield',   
					    fieldLabel : '项目状态',   
					    id : 'XMZTAI',   
					    value:'',
		                width:'100'
					}]
				},{
	            	columnWidth:.33,
	        		layout:'form',
	        		items:[
	            	{
			            xtype : 'textfield',   
					    fieldLabel : '总面积(不含代拆土地)',   
					    id : 'ZMJ',   
					    value:'',
		                width:'100'
					}]
				}]
			},{
				layout:'column',
				items:[{
	            	columnWidth:.33,
	        		layout:'form',
	        		items:[
	            	{
			            xtype : 'textfield',   
					    fieldLabel : '农用地面积',   
					    id : 'NYDMJ',  
					    value:'',
		                width:'100'
					}]
				},{
					columnWidth:.33,
	        		layout:'form',
					items:[{
		                xtype: 'numberfield',
		                id      : 'QZGDMJ',
		                value:'',
		                fieldLabel: '其中耕地面积', 
		                width:'100'
            		}]
	      		},{
            		columnWidth:.33,
	        		layout:'form',
					items:[{
		                xtype: 'textfield',
		                id   : 'DCTDMJ',
		                value:'', 
		                fieldLabel: '代拆土地面积(公顷)',
		                width:'100'
		            }]
		         }]
	      	},{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'JSYDXJ',
		                value:'',
		                readOnly:true,
		                fieldLabel: '规划建设用地小计',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'JSYDJZ',
		                value:'',
		                fieldLabel: '规划建设用地居住',
		                width:'100'
	            	}]
            	},{
					columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'JSYDSF',
		                value:'',
		                fieldLabel: '规划建设用地商服',
		                width:'100'
	            	}]
	            }]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'JSYDQT',
		                value:'',
		                fieldLabel: '规划建设用地其他',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'GHDZD',
		                value:'',
		                fieldLabel: '规划用地代征地',
		                width:'100'
	            	}]
            	},{
					columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'GHJZXJ',
		                value:'',
		                 readOnly:true,
		                fieldLabel: '规划建筑小计',
		                width:'100'
	            	}]
	            }]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'GHJZJZ',
		                value:'',
		                fieldLabel: '规划建筑居住',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'GHJZSF',
		                value:'',
		                fieldLabel: '规划建筑商服',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'GHJZQT',
		                value:'',
		                fieldLabel: '规划建筑其他',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'SXGHNF',
		                value:'',
		                fieldLabel: '过会年份',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'SXSQSJ',
		                value:'',
		                fieldLabel: '取得一级开发授权时间',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'SXGHTJ',
		                value:'',
		                fieldLabel: '一级规划条件',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'SXYSPF',
		                value:'',
		                fieldLabel: '用地预审批复',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'SXHZPF',
		                value:'',
		                fieldLabel: '核准批复',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'SXZDPF',
		                value:'',
		                fieldLabel: '征地批复',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'SXCQXK',
		                value:'',
		                fieldLabel: '拆迁许可',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'ZDZMJ',
		                value:'',
		                fieldLabel: '需征地总面积',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'YWCZDZMJ',
		                value:'',
		                fieldLabel: '已完成征地总面积',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'QYZDMJ',
		                value:'',
		                fieldLabel: '2013年以前已征地面积',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'YZDMJ',
		                value:'',
		                fieldLabel: '2013已征地面积',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'JHZDMJ',
		                value:'',
		                fieldLabel: '2014年计划征地面积',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'CQJZMJ',
		                value:'',
		                fieldLabel: '需拆迁建筑面积',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'CQCQBL',
		                value:'',
		                fieldLabel: '已完成拆迁比例',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'CQJHMJ',
		                value:'',
		                fieldLabel: '2014年计划拆迁建筑面积',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'TZJHTZ',
		                value:'',
		                fieldLabel: '计划总投资',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'TZYWC',
		                value:'',
		                fieldLabel: '已完成投资',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'YTZXJ',
		                value:'',
		                fieldLabel: '2013年已投姿小计',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'YTZSZX',
		                value:'',
		                fieldLabel: '市中心已投资',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'YTZFZX',
		                value:'',
		                fieldLabel: '分中心已投资',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'YTZQY',
		                value:'',
		                fieldLabel: '企业已投资',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'JHXJ',
		                value:'',
		                fieldLabel: '计划投资小计',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'JHZCB',
		                value:'',
		                fieldLabel: '土地储备开发总成本',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'JHSZX',
		                value:'',
		                fieldLabel: '市中心投资',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'JHFZX',
		                value:'',
		                fieldLabel: '分中心投资',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'JHQY',
		                value:'',
		                fieldLabel: '企业投资',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'ZJHLXJ',
		                value:'',
		                fieldLabel: '预计回笼资金小计',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'ZJHLSZX',
		                value:'',
		                fieldLabel: '市中心回笼',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'ZJHLFZX',
		                value:'',
		                fieldLabel: '分中心回笼',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'ZJHLQY',
		                value:'',
		                fieldLabel: '企业回笼',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'LJWCKF',
		                value:'',
		                fieldLabel: '累计完成开发面积',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'XCYSMJ',
		                value:'',
		                fieldLabel: '现场验收面积',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'SFJHWC',
		                value:'',
		                fieldLabel: '是否计划完成开发',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'JHWCSJ',
		                value:'',
		                fieldLabel: '计划完成开发时间',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'JHWCMJ',
		                value:'',
		                fieldLabel: '计划完成开发面积',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'GHYDXJ',
		                value:'',
		                fieldLabel: '完成规划用地小计',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'GHYDJZ',
		                value:'',
		                fieldLabel: '完成规划用地居住',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'GHYDSF',
		                value:'',
		                fieldLabel: '完成规划用地商服',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'GHYDQT',
		                value:'',
		                fieldLabel: '完成规划用地其他',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'WCGHJZXJ',
		                value:'',
		                fieldLabel: '完成规划建筑小计',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'WCGHJZJZ',
		                value:'',
		                fieldLabel: '完成规划建筑居住',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'WCGHJZSF',
		                value:'',
		                fieldLabel: '完成规划建筑商服',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'WCGHJZQT',
		                value:'',
		                fieldLabel: '完成规划建筑其他',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'WCKFQBCD',
		                value:'',
		                fieldLabel: '完成开发确保程度',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'WCKFPX',
		                value:'',
		                fieldLabel: '完成开发可能性排序',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'LJGYMJ',
		                value:'',
		                fieldLabel: '累计供应面积',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'DNGYMJ',
		                value:'',
		                fieldLabel: '2013年供应面积',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'SFJMNGY',
		                value:'',
		                fieldLabel: '是否计2014年供应',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'JHGYSJ',
		                value:'',
		                fieldLabel: '计划供应时间',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'JHGYMJ',
		                value:'',
		                fieldLabel: '计划供应面积',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'GHYDMJXJ',
		                value:'',
		                fieldLabel: '计划规划用地小计',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'GHYDMJJZ',
		                value:'',
		                fieldLabel: '计划规划用地居住',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'GHYDMJSF',
		                value:'',
		                fieldLabel: '计划规划用地商服',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'GHYDMJQT',
		                value:'',
		                fieldLabel: '计划规划用地其他',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'GHJZGMXJ',
		                value:'',
		                fieldLabel: '计划规划建筑小计',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'GHJZGMJZ',
		                value:'',
		                fieldLabel: '计划规划建筑居住',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'GHJZGMSF',
		                value:'',
		                fieldLabel: '计划规划建筑商服',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'GHJZGMQT',
		                value:'',
		                fieldLabel: '计划规划建筑其他',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'SXGYQBCD',
		                value:'',
		                fieldLabel: '实现供应确保程度',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'SXGYPX',
		                value:'',
		                fieldLabel: '实现供应肯能性排序',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'ZYWT',
		                value:'',
		                fieldLabel: '项目存在主要问题',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'SFXCFW',
		                value:'',
		                fieldLabel: '是否位于新城范围',
		                width:'100'
	            	}]
            	},{
	            	columnWidth:.33,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'GDJTX',
		                value:'',
		                fieldLabel: '轨道交通线',
		                width:'100'
	            	}]
            	}]
	        },{
	           	layout:'column',
	           	items:[{
	            	columnWidth:.5,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'XZLY',
		                value:'',
		                fieldLabel: '项目新增理由',
		                width:'250'
	            	}]
            	},{
	            	columnWidth:.5,
	        		layout:'form',
	           		items:[{
		                xtype: 'textfield',
		                id   : 'BZ',
		                value:'',
		                fieldLabel: '备注',
		                width:'250'
	            	}]
            	}]
	        }], 
	        buttons: [
	            {
	                text   : '保存',
	                handler: function() {
	            			paneloper.setRestUrl("cbjhzhb/modify");
							paneloper.save();
	                	}
	            	},   
	            	{
	                	text   : '取消',
	                	handler: function() {
	            			paneloper.cancel();
	                	}
	            	}
	        ]
	  });		
  		form.render("deal");
  		form.hide();
  		var elements = new Array("XMMC","XMLX","XMQX","DKMC","XMWZ","XMQW","XMLB","XMZT","SFDZ","DZBV","XMZTAI",
  		"ZMJ","NYDMJ","QZGDMJ","DCTDMJ","JSYDXJ","JSYDJZ","JSYDSF","JSYDQT","GHDZD","GHJZXJ","GHJZJZ","GHJZSF",
  		"GHJZQT","SXGHNF","SXSQSJ","SXGHTJ","SXYSPF","SXHZPF","SXZDPF","SXCQXK","ZDZMJ","YWCZDZMJ","QYZDMJ","YZDMJ",
  		"JHZDMJ","CQJZMJ","CQCQBL","CQJHMJ","TZJHTZ","TZYWC","YTZXJ","YTZSZX","YTZFZX","YTZQY","JHXJ","JHZCB",
  		"JHSZX","JHFZX","JHQY","ZJHLXJ","ZJHLSZX","ZJHLFZX","ZJHLQY","LJWCKF","XCYSMJ","SFJHWC","JHWCSJ","JHWCMJ",
  		"GHYDXJ","GHYDJZ","GHYDSF","GHYDQT","WCGHJZXJ","WCGHJZJZ","WCGHJZSF","WCGHJZQT","WCKFQBCD","WCKFPX",
  		"LJGYMJ","DNGYMJ","SFJMNGY","JHGYSJ","JHGYMJ","GHYDMJXJ","GHYDMJJZ","GHYDMJSF","GHYDMJQT","GHJZGMXJ",
  		"GHJZGMJZ","GHJZGMSF","GHJZGMQT","SXGYQBCD","SXGYPX","ZYWT","SFXCFW","GDJTX","XZLY","BZ");
  		paneloper.init(form,elements);
  		paneloper.hide();
  	}
  </script>
  <body>
  	<div id='show'>
  		<%=new CBDReportManager().getReport("CBJHZHB",its)%>
  	</div>
  	<div id="deal" style="position:absolute; left:5px; top:5px; "></div>
  	<form id="attachfile" action="<%=basePath%>service/rest/zrbHandle/update" method="post">
	</form> 
  </body>
</html>
