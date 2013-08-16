<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
    String yw_guid=request.getParameter("yw_guid");
    String permission = request.getParameter("permission");
	if (permission == null) {
		permission = "no";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>"/>
		<TITLE>属性字段维护界面</TITLE>
		<%if(permission.equals("yes")){ %> 
		<link rel="stylesheet" href="<%=basePath %>base/form/css/permissionForm.css"  type="text/css" />
		<%@ include file="/base/include/restRequest.jspf" %>
		<%@ include file="/base/form/PermissionControl.jspf"%>
		
		<%}else{ %>
		<link rel="stylesheet"
			href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
			<%@ include file="/base/include/restRequest.jspf" %>
		<%@ include file="/base/include/newformbase.jspf"%>
		<%} %>
	
		<script type="text/javascript">
			function addrow(table,allnum){
				var recordnum = document.getElementById(allnum);
				var num = recordnum.value;
				num = String(parseInt(num) + 1);
				fieldname = new Array();
				fieldname.push("<input type='checkbox' id='check" + num + "'  />");
				fieldname.push("<select id='shuxing_" +num+ "' name='shuxing_" +num+ "' style='width:95%'><option value='规划数据（公顷、万㎡）'>规划数据</option><option value='拆迁数据（万㎡、户）'>拆迁数据</option><option value='成本及收益情况(亿元、元/㎡)'>成本及收益情况</option><option value='其他（拆迁强度（万㎡/公顷）、成本覆盖率）'>其他（拆迁强度等）</option></select>");
				fieldname.push("<input type='text' id='ziduanming_" + num +"' name='ziduanming_" +num + "'  style='width:95%;' />");
				fieldname.push("<input type='text' id='bieming_" + num + "' name='bieming_" + num +  "' style='width:95%;' />");				
				fieldname.push("<select id='fangshi_" + num + "' name='fangshi_" + num + "' style='width:90%;'><option value='录入'>录入</option><option value='公式'>公式</option></select>");				
				fieldname.push("<select id='gongshi_" + num + "' name='gongshi_" + num + "' style='width:95%;' ><option value='0'>无</option></select>");
				fieldname.push("<select id='sort_" + num + "' name='sort_" + num + "' style='width:90%;' ></select>");
				adddata(allnum, table, "2", fieldname);
			}
			
			function adddata(allnum, tablename, number, newfield){
				var recordnum = document.getElementById(allnum);
				var num = recordnum.value;
				var addtable = document.getElementById(tablename);
				var newRow = addtable.insertRow(parseInt(num) + parseInt(number));
				newRow.align = "center";
				recordnum.value = parseInt(num) + 1;
				addnewRow(newRow, newfield);
				//初始化下拉框
				initSelect(allnum);
			}
			
			function addnewRow(newRow, newfield){
				for(var i = 0; i < newfield.length; i++){
					newRow.insertCell(i).innerHTML = newfield[i];	
				}			
			}
			
			function deleterow(table,allnum){
				var name = new Array("check","shuxing_","ziduanming_","bieming_","fangshi_", "gongshi_", "sort_");
				deletedata(allnum, table, "1", name);
			}
		

			function deletedata(allnum, tablename, number, name){
				var recordnum = document.getElementById(allnum);
				var num = recordnum.value;
				var deletetable = document.getElementById(tablename);
				for(var i = 1; i <= num; i++){
					var isdelete = document.getElementById(name[0] + String(i));
					if(isdelete.checked){
						for(var j = i; j < num; j++){
							replacevalue(j+1 , j, name);
						}
						deletetable.deleteRow(parseInt(num) + parseInt(number));
						recordnum.value = parseInt(num) - 1;
						num = recordnum.value;
						i--;
					}
				}
			}
			
			
			function replacevalue(newnum , oldnum, name){
				var oldfieldcheck = document.getElementById(name[0] + String(oldnum));
				var newfieldcheck = document.getElementById(name[0] + String(newnum));
				oldfieldcheck.checked = newfieldcheck.checked;
				for(i = 1 ; i < name.length; i++){
					var fieldname = name[i];
					var oldfieldname = document.getElementById(fieldname + oldnum);
					var newfieldname = document.getElementById(fieldname + newnum);
					oldfieldname.value = newfieldname.value;
				}
			}	
					
			function initEdit(){							
				//初始化动态
				initComponent();			
				init();							
			}
			
			//初始化控件
			function initComponent(){
				var yw_guid="<%=yw_guid%>";
				putClientCommond("prohandle","bindData");
				putRestParameter("yw_guid",yw_guid);
				var res=restRequest();
				if(res){			
					for(var i=2;i<=res.length;i++){
						addrow('table1','allnum1');					
					}									
				}	
				initSelect('allnum1');
				
				//绑定数据
				bindData(res);
			}
			
			function initSelect(allnum){
				var array = new Array();
				for(var i=1;i<=100;i++){
					array.push(i);
				}
				var num = document.getElementById(allnum).value;
				for(var j=1;j<=num;j++){
					var select = document.getElementById('sort_'+j);
					select.options.length = 0;
					for(var k=1;k<=array.length;k++){
						select.options.add(new Option(k,k));
					}
					
				}	
			}
			
			function bindData(res){
				if(res){
					for(var i=1;i<=res.length;i++){
						document.getElementById('shuxing_'+i).value=res[i-1].SHUXING;
						document.getElementById('ziduanming_'+i).value=res[i-1].ZIDUANMING;
						document.getElementById('bieming_'+i).value=res[i-1].BIEMING;
						document.getElementById('fangshi_'+i).value=res[i-1].FANGSHI;
						document.getElementById('gongshi_'+i).value=res[i-1].GONGSHI;
						document.getElementById('sort_'+i).value=res[i-1].SORT;
					}	
				}			
			}
			
			function save(){
				 document.forms[0].submit(); 			  
			}	
</script>
<style>
	td{
		border-top-width:0px; 
		border-bottom:1px solid #C2D6F0; 
		border-left-width:0; 
		border-right:1px solid #C2D6F0;
	}
	.tdbgColor{
		background-color: #E6F0FD;
	}

</style>
		
	</head>


	<body bgcolor="#FFFFFF" align="center">
		<div class="container" >
		<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
		<div class="container "> 
		<div style="margin:20px" class="tablestyle1" align="center" >  
			<form id="form" method="post">		
			  <table id="table1" class="lefttopborder1"  cellspacing="0" cellpadding="0" border="1"  bgcolor="#FFFFFF" bordercolor="#C2D6F0" width="800" align="center"> 	
			  	<thead>
			  		<td colspan="7" class="tdbgColor">
			  			<label style="font-size:16px;">属性字段维护</label>
			  		</td>
			 	</thead>	
				<tr align="center">
					<td class="tdbgColor">
						&nbsp;
					</td>
					<td class="tdbgColor" style="width:150px">
						<label>属性名</label>
					</td>
					<td class="tdbgColor" style="width:150px">
						<label>字段名</label></td>
					<td class="tdbgColor" style="width:100px">
						<label>别名</label></td>
					<td class="tdbgColor" style="width:100px">
						<label>生成方式</label></td>
					<td class="tdbgColor" style="width:200px">
						<label>公式</label></td>
					<td class="tdbgColor" style="width:60px">
						<label>顺序</label></td>
				</tr>
				
				<tr align="center">
					<td align="center">
						<input type="checkbox" id="check1"  /></td>
					<td style="width:150px">
						<select name="shuxing_1" id="shuxing_1" style="width:95%;border-color:#7F9DB9;">
							<option value="规划数据">规划数据</option>
							<option value="拆迁数据">拆迁数据</option>
							<option value="成本及收益情况">成本及收益情况</option>
							<option value="其他（拆迁强度等）">其他（拆迁强度等）</option>
						</select>
					</td>	
					<td style="width:150px">
						<input type="text" name="ziduanming_1" id="ziduanming_1"  style="width:95%;height:18px;border:1px solid #7F9DB9;" />
					</td>
					<td style="width:100px">
						<input type="text" name="bieming_1" id="bieming_1" style="width:95%;height:18px;border:1px solid #7F9DB9;" />
					</td>
					<td style="width:100px">
						<select id="fangshi_1" name="fangshi_1"  style="width:90%;border-color:#7F9DB9;">
							<option value="录入">录入</option>
							<option value="公式">公式</option>
						</select>	
					</td>
					<td style="width:200px">
						<select id="gongshi_1"  name="gongshi_1"  style="width:95%;border-color:#7F9DB9;">
							<option value="0">无</option>
						</select>
					</td>
					<td style="width:60px">
						<select id="sort_1" name="sort_1"  style="width:90%;border-color:#7F9DB9;" >
						</select>
					</td>
				</tr>
				<tr>
				  <td colspan="11" align="left"  >
						&nbsp;&nbsp;<input type="button" onclick="addrow('table1','allnum1')" value="增加"  />
						&nbsp;&nbsp;<input type="button" onclick="deleterow('table1','allnum1')" value="删除"  />
						&nbsp;&nbsp;<input type="text" id="allnum1" name="allnum1" style="width:50%" value="1"/>
				  </td>
				 </tr>
			  </table>	
			  		
		  </form>
		<br />
		</div>
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

if("<%=msg%>" == "success"){
	alert("表单保存成功");
}else if("<%=msg%>" == "failure"){
	alert("表单保存失败，请重新保存");
}
</script>
</body>

</html>
