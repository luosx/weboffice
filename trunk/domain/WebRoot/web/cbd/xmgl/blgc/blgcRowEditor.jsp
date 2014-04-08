<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.model.CBDReport.CBDReportManager"%>
<%@page import="com.klspta.model.CBDReport.tablestyle.ITableStyle"%>
<%@page import="com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow"%>
<%@page import="com.klspta.web.cbd.yzt.kgzb.Control"%>
<%@page import="com.klspta.web.cbd.jtfx.scjc.ScjcManager"%>
<%@page import="com.klspta.web.cbd.xmgl.Xmmanager"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="com.klspta.console.role.Role"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String type=request.getParameter("type");
String reportID = "oldTable";
String keyIndex = "1";
String xmid = request.getParameter("yw_guid");
String xmmc = request.getParameter("xmmc");
Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
String userId = ((User)principal).getUserID();
User user = ManagerFactory.getUserManager().getUserWithId(userId);
List<Role>  role = ManagerFactory.getRoleManager().getRoleWithUserID(userId);
String username = user.getFullName();
String rolename = role.get(0).getRolename();


if (xmmc != null) {
    xmmc = new String(xmmc.getBytes("iso-8859-1"), "utf-8");
} else {
    xmmc = "";
}
List<Map<String, Object>> list = null;
if (!xmid.equals("") && !xmid.equals("null")) {
    Xmmanager hxzm = Xmmanager.getXmmanager();
    list = hxzm.getBLGC(xmid);
}
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
	<script src="base/include/jquery-1.10.2.js"></script>
	<%@ include file="/web/cbd/xmgl/blgc/js/reportEdit.jspf"%>
	<%@ include file="/base/include/restRequest.jspf"%>
	<script src="web/cbd/xmgl/blgc/js/table.js"></script>
	<script src="web/cbd/xmgl/blgc/js/panel.js"></script>
	<script src="web/cbd/xmgl/blgc/js/blgcRowEditor.js"></script>
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
		    line-height: 30px;
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
    var rolename="<%=rolename%>";
    var username="<%=username%>";
    var xmid="<%=xmid%>";
  	var form;
  	var paneloper = new Paneloper();
  	$(document).ready(function () { 
		var width = document.body.clientWidth;
		var height = document.body.clientHeight * 0.95;
       //	FixTable("esftable", 0,1, width, height-30);
       	buildPanel();
    });
  //	Ext.onReady(function(){
  		//Ext.QuickTips.init();
  	function buildPanel(){
  		form = new Ext.form.FormPanel({
	        autoHeight: true,
	        frame:true,
	        bodyStyle:'padding:5px 0px 0',
	        width: 400,
	  		labelWidth :115,   
	  		labelAlign : "right",
	        url:"",
	        title:"二手房详细信息",
	        defaults: {
	            anchor: '0'
	        },
	        items   : [
	        	{
		            xtype : 'datefield',   
				    fieldLabel : '时间',
				    emptyText:'请选择日期',			    
				    id : 'rq',   
				    invalidText :"日期格式错误,请参照yyyy-mm-dd的格式重新输入",
                    format:'Y-m-d',
                    anchor:'100%'
            	},
	        	{
	                xtype: 'textarea',
	                id      : 'sj',
	                value:'',
	                fieldLabel: '事件',
	                width :60
            	},{
		            xtype : 'textfield',   
				    fieldLabel : '部门/经办人',   
				    id : 'jbr',   
				    width:100,   
				    value:'',   
				    readOnly:true,
				    allowBlank:false
            	},{
 					xtype: 'textfield',
	                id      : 'bz',
	                value:'',
	                fieldLabel: '备注',
	                width :60
            	},{
 					xtype: 'hidden',
	                id      : 'yw_guid',
	                value:'',
	                width :60
            	}
	        ],
	        buttons: [
	            {
	                text   : '保存',
	                handler: function() {
	            			paneloper.setRestUrl("xmmanager/saveBLGC");
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
  		var elements = new Array("rq","sj","jbr","bz","yw_guid");
  		paneloper.init(form,elements);
  		paneloper.hide();
  	}
  // })
  </script>
  <body>
  	<div id="show" align="center"  style="overflow-x:hidden;overflow-y:hidden">
			<table width="800" cellpadding="1" cellspacing="0" id='esftable' border='1'>
				<tr class="title" onclick="showMap(this); return false;" ondblclick='editMap(this); return false;'>
					<td align="center" width="80px" height="50px" >
						<h3>
							序号
						</h3>
					</td>
					<td align="center" width="90px">
						<h3>
							时间
						</h3>
					</td>
					<td align="center" width="500px">
						<h3>
							事件
						</h3>
					</td>
					<td align="center" width="120px">
						<h3>
							部门/经办人
						</h3>
					</td>
					<td align="center" width="200px">
						<h3>
							备注
						</h3>
					</td>
					<td align="center" width="200px" style="display: none;">
						<h3>
							yw_guid
						</h3>
					</td>
				</tr>
				<%
				    if (list != null) {
				        for (int i = 0; i < list.size(); i++) {
				%>
				<tr align="center" id='row<%=i%>' class="trsingle" onclick='showMap(this); return false;' ondblclick='editMap(this); return false;'>
					<td align="center" width="80px" ><%=i+1%></td>
					<td align="center" width="80px"><%=list.get(i).get("blsj")==null?"":list.get(i).get("blsj")%></td>
					<td align="center" width="500px"><%=list.get(i).get("sjbl")==null?"":list.get(i).get("sjbl")%></td>
					<td align="center" width="80px"><%=list.get(i).get("bmjbr")==null?"":list.get(i).get("bmjbr")%></td>
					<td align="center" width="200px"><%=list.get(i).get("bz")==null?"":list.get(i).get("bz")%></td>
					<td align="center" width="200px" style="display: none;"><%=list.get(i).get("yw_guid")%></td>
				</tr>
				<%
				    }
				    }
				%>
			</table>
		</div>
  	<div id="deal" style="position:absolute; left:100px; top:80px; "></div>
  	<form id="attachfile" action="<%=basePath%>service/rest/zrbHandle/update" method="post">
	</form> 
  </body>
</html>
