<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="com.klspta.console.user.User"%>
<%@page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="java.text.DateFormatSymbols"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String permission = request.getParameter("permission");
    String yw_guid = request.getParameter("yw_guid");
    String userid1 = request.getParameter("userid1");
    String fixed=request.getParameter("fixed");//显示打印按钮的标识符
    String wfInsId1 = "";
    IWorkflowOp workflow1 = null;
    String activityName1 ="";
    if(!yw_guid.equals("")){
    }
    if(permission==null){
        permission = "no";
        wfInsId1 = request.getParameter("wfInsId");
		workflow1 = WorkflowOp.getInstance();
	    activityName1 = workflow1.getActivityNameByWfInsID(wfInsId1);
    }
    Object userprincipal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    String userid = ((User)userprincipal).getUserID();
    String edit = request.getParameter("edit");
    //String xzqh = ManagerFactory.getUserManager().getUserWithId(userid).getXzqh();
    //String name = UtilFactory.getXzqhUtil().getBeanById(xzqh).getCatonname();
       SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd", new DateFormatSymbols());
 		String dateString = df.format(Calendar.getInstance().getTime());
 		
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=basePath%>"/>

		<title>信访举报</title>
		<link rel="stylesheet"
			href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
		<%@ include file="/base/include/formbase.jspf"%>
		<style> 
		div{ display:inline}
		input {  BORDER-RIGHT: #ffffff 1px solid;
		         BORDER-TOP: #ffffff 1px solid;
		         FONT-SIZE: 14px;
		         BORDER-LEFT: #ffffff 1px solid;
		         COLOR: #ffffff ;
		         BORDER-BOTTOM: #ffffff 1px solid;
		         FONT-FAMILY:"宋体","Verdana"}
		 </style>
		<script>
		function initEdit(){
			init();
			butt();
			var edit="<%=edit%>";
			if(edit=='false'){
				 var formlist = document.getElementById('form');
        		 for(var i=0;i<formlist.length;i++)
         		 {
             			if(formlist[i].type=='text'||formlist[i].type=='textarea'||formlist[i].type=='select-one')
             				formlist[i].disabled=true;
         		 }		
			}
			var userid1 = "<%=userid1%>";
			var userid = "<%=userid%>";
		<%	if(!userid1.equals("") && !userid1.equals("null")){
				if((userid1).equals(userid)){
				
				}else{
				 %>
					var butt1 = document.getElementById("butt");
			
		    		butt1.innerHTML = '<img src="base/form/images/print.png" onclick="print()" style="cursor:hand" title="打印"/>';
	        <%
				}
			}
			%>
		}
				
			function save(){
				if(checkdata()){
					document.forms[0].submit();
				}
			}
			function refresh(){
				document.location.refresh();
			}
			function checkdata(){
			
				var reg = /^(\d{3,4}?[-]\d{7,8}?)|(\d{11})$/;//电话正则表达式
				
				var var_jbr=document.getElementById("jbr").value; //举报人
				var var_lxdz=document.getElementById("lxdz").value; //联系地址
				var var_jbsj=document.getElementById("jbsj").value; //举报时间
				var var_lxdh=document.getElementById("lxdh").value; //联系电话
				var var_ldcs=document.getElementById("ldcs").value; //来电次数
				var var_jbzywt=document.getElementById("jbzywt").value;//举报主要问题 
				var var_zbyblqk=document.getElementById("zbyblqk").value;//值班员办理情况 
				var var_jsr=document.getElementById("jsr").value; //接收人
				var var_jlr=document.getElementById("jlr").value; //记录人
				if(var_jbr==""){
					alert("请填写举报人！");
					return false;
				}else if(var_lxdz==""){
					alert("请填写联系地址！");
					return false;
				}else if(var_jbsj==""){
					alert("请填写举报时间！");
					return false;
				}else if(var_lxdh==""){
					alert("请填写联系电话！");
					return false;
				}else if(var_ldcs==""){
					alert("请填写来电次数！");
					return false;
				}else if(var_jbzywt==""){
					alert("请填写举报主要问题！");
					return false;
				}else if(var_zbyblqk==""){
					alert("请填写值班员办理情况！");
					return false;
				}else if(var_jsr==""){
					alert("请填写接收人！");
					return false;
				}else if(var_jlr==""){
					alert("请填写记录人！");
					return false;
				}else{
					if(!reg.test(var_lxdh)){
						alert("联系电话格式不正确。（例如010-12345678或者13812345678）");
						var_lxdh='';
						return false;
					}else{
						return true;
					}
				}
			}
		</script>
		
	</head>
	
<body bgcolor="#FFFFFF">
<div id="butt" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
 <%if(fixed!=null){%>
<div id="fixed class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
<%}%>
<div style="margin:20px" class="tablestyle1" align="center" /><br />
<div align="center"><font style="font: bold 16px '黑体','微软雅黑' ">厦门市国土资源与房产管理局12336违法举报登记处理表</font></div><br/><br />
<form method="post">
<div style="width: 600px">
<div align="left">登记号：厦国土房值班举<input class="noborder" name="bh" id="bh" style="width: 60px"/>号</div>&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<div align="right">日期：<input  type="text" class="noborder" id="rq" name="rq" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly style="width: 100px"/></div>
</div>
<table class="lefttopborder1"  cellspacing="0" cellpadding="0" border="1"  bgcolor="#FFFFFF" bordercolor="#000000" width="600">
<tr><td width="70px">举报人</td>
<td width="140"><input class="noborder" name="jbr" id="jbr" style="width: 95%"/></td>
<td width="70px">性别</td>
<td width="120px"><input  type="radio" name="xb" value="男"  checked="checked"/>男<input  type="radio" name="xb" value="女"/>女</td>
<td width="70px">举报形式</td>
<td ><input  type="radio" name="jbxs" value="电话"  checked="checked"/>电话<input  type="radio" name="jbxs" value="传真"/>传真</td>
</tr>
<tr>
<td>联系地址</td>
<td colspan="3"><input class="noborder" name="lxdz" id="lxdz" style="width: 95%"/></td>
<td>处理机关</td>
<td>
	<select name="xzq" id="xzq" style="width:60">
		<option selected="selected" value="局机关">局机关</option>
		<option value="直属分局">直属分局</option>
		<option value="集美分局">集美分局</option>
		<option value="海沧分局">海沧分局</option>
		<option value="同安分局">同安分局</option>
		<option value="翔安分局">翔安分局</option>
	</select></td>
</tr>

<!--
<tr>
<td>所在政区</td>
<td colspan="2" align="left">
            <select name="xzq" id="xzq" style="width: 60" onchange="change()">
                            <option selected="selected" value="市局" >市局</option>
							<option value="直属区">直属区</option>
							<option value="集美区">集美区</option>
							<option value="海沧区">海沧区</option>
							<option value="同安区">同安区</option>
							<option value="翔安区" >翔安区</option>
			</select></td>
<td>所属国土局管制</td>
<td colspan="2" align="left">
          <select name="gts" id="gts"  >
                        <option selected="selected" value="思明国土所" >思明国土所</option>
						<option value="湖里国土所">湖里国土所</option>
         </select></td>

</tr>
-->
 
<tr>
<td>举报时间</td>
<td><input  type="text" class="noborder" id="jbsj" name="jbsj" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly style="width: 90%"/></td>
<td>联系电话</td>
<td><input class="noborder" name="lxdh" id="lxdh" style="width: 95%"/></td>
<td>来电次数</td>
<td><input class="noborder" name="ldcs" id="ldcs" value="1" style="width: 95%"/></td>
</tr>
<tr>
<td align="center">举<br />报<br />主<br />要<br />问<br />题</td>
<td colspan="5"><textarea rows="8" name="jbzywt" id="jbzywt" style="width: 99%"></textarea></td>
</tr>
<tr>
<td align="center">值班员<br />办理情<br />况</td>
<td colspan="5"><textarea rows="5" name="zbyblqk" id="zbyblqk" style="width: 99%"></textarea> </td>
</tr>
<tr>
<td>接收人</td>
<td colspan="2"><input class="noborder"  type="text"   name="jsr" id="jsr" style="width: 95%;"/></td>
<td>记录人</td>
<td colspan="2"><input class="noborder"  type="text"   name="jlr" id="jlr" style="width:95%;"/></td>
</tr>
<tr>
<td colspan="2" style="display:none"><textarea rows="2" name="userid" id=""userid"" style="display:none"><%=userid %></textarea></td>
</tr>
</table>
</form>
</body>
<script>
<%
if(!permission.equals("yes")){%>
	document.body.onload = initEdit;
<%}else if(permission.equals("yes")){%>
	addBorders();
<%}%>
<%
	String msg = (String)request.getParameter("msg");
%>
if("<%=msg%>" == "success"&&"<%=permission%>"=="yes"){
	alert("表单权限保存成功");
}else if("<%=msg%>" == "success"){
	alert("表单保存成功");  
}

function butt(){
	var butt = document.getElementById("butt");
		if(<%=fixed %>!= null){
	    	butt.innerHTML = '<img src="base/form/images/save.png" onclick="formSave()" style="cursor:hand" title="保存"/><br /><img src="base/form/images/print.png" onclick="print()" style="cursor:hand" title="打印"/>';
	    }else{
	    	butt.innerHTML = '<img src="base/form/images/print.png" onclick="print()" style="cursor:hand" title="打印"/>';
        }
}

function change(){
 var xzq=document.getElementById("xzq");
 var index=xzq.selectedIndex;
 var xzqname=xzq.options[index].value
 var gts=document.getElementById("gts");
  if(xzqname=='市局'||xzqname=='直属区'){
    delOption(gts);
    addOption(gts, '思明国土所','思明国土所');
    addOption(gts,'湖里国土所','湖里国土所');
  }if(xzqname=='集美区'){
    delOption(gts);
    addOption(gts, '后溪国土所','后溪国土所');
    addOption(gts,'灌口国土所','灌口国土所');
    addOption(gts, '杏林国土所','杏林国土所');
    addOption(gts,'集美国土所','集美国土所');
  }
  if(xzqname=='海沧区'){
   delOption(gts);
    addOption(gts, '海沧国土所','海沧国土所');
    addOption(gts,'东孚国土所','东孚国土所');
  }
  if(xzqname=='同安区'){
     delOption(gts);
     addOption(gts, '西柯国土所','西柯国土所');
     addOption(gts,'莲花国土所','莲花国土所');
     addOption(gts, '汀溪国土所','汀溪国土所');
     addOption(gts,'五显国土所','五显国土所');
     addOption(gts, '洪塘国土所','洪塘国土所');
     addOption(gts,'新民国土所','新民国土所');
     addOption(gts, '城区国土所','城区国土所');
   }
  if(xzqname=='翔安区'){
    delOption(gts);
     addOption(gts, '马巷国土所','马巷国土所');
     addOption(gts,'新圩国土所','新圩国土所');
     addOption(gts, '内厝国土所','内厝国土所');
     addOption(gts,'大嶝国土所','大嶝国土所');
     addOption(gts, '新店国土所','新店国土所');
   }

}
//增加option
function addOption(objSelect, txt, val){   
	var objOption = document.createElement("OPTION");        
	objOption.text = txt;                                                  
	objOption.value = val;                                                 
	objSelect.options.add(objOption);                       
} 
//删除option
function delOption(objSelect){
	for(var k=objSelect.length-1; k>=0; k--){    
		objSelect.options.removeChild(objSelect.options[k]);//这里一定要进行倒序删除
	}
}
</script>
</html>