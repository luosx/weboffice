<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.klspta.base.workflow.foundations.IWorkflowOp"%>
<%@page import="com.klspta.base.workflow.foundations.WorkflowOp"%>
<%@page import="com.klspta.base.workflow.bean.DoNextBean"%>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="com.klspta.base.workflow.foundations.JBPMServices"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	String yw_guid = request.getParameter("yw_guid");
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String fullName = ((User) principal).getFullName();
	String wfInsId = request.getParameter("wfInsId");
	String wfInsTaskId = request.getParameter("wfInsTaskId");
	String wfId = request.getParameter("wfId");
	String activityName = new String(request.getParameter("activityName").getBytes("ISO-8859-1"), "utf-8");
	IWorkflowOp workflowOp = WorkflowOp.getInstance();
	DoNextBean ac = workflowOp.getNextInfo(wfId,wfInsId,wfInsTaskId);
	Set<String> set = ac.getNextNames();
	Iterator<String> it = set.iterator();
	String currentNode = null;
	String currentRole = null;

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>任务移交窗口</title>
		<script src="<%=basePath%>/base/include/ajax.js"></script>
		<%@ include file="/base/include/restRequest.jspf" %>
		<style type="text/css">
body {
	background-image: url(images/main_bk.gif);
	margin: 0px;
	padding: 0px;
}

.btn {
	background: url(images/btn_bk.gif);
	CURSOR: hand;
	FONT-SIZE: 12px;
	color: white;
	BORDER-RIGHT: #002D96 0px solid;
	BORDER-TOP: #002D96 0px solid;
	BORDER-LEFT: #002D96 0px solid;
	BORDER-BOTTOM: #002D96 0px solid
}
</style>
		<script>
   var selectedValue="";
   var myData;
   var assignee="false";
    var path="";
   function changeRole(){
       var role=document.getElementById("roles");
       var user=document.getElementById("users");
       //reset old option
       if(role!=null){
         role.options.length = 0;
       }
       //get roles 
       var roles=getRoles();
       if(roles!="null"){
         var roleArray=roles.split(",");
         for(var i=0;i<roleArray.length/2;i++){
            role.options.add(new Option(roleArray[i*2+1],roleArray[i*2])); 
         }
         var users=getUsers(roleArray[0]);
         var userArray=users.split(",");
         user.options.length = 0; 
         //user.options.add(new Option("所有人","all"));
         for(var i=0;i<userArray.length;i++){
            user.options.add(new Option(userArray[i],userArray[i])); 
         }
       }else{
         users=getUsers(null);
         user.options.length = 0;
         user.options.add(new Option(users,users));
       }
   }
  
   function changeUser(){
        var role=document.getElementById("roles").value;
        var user=document.getElementById("users");
        var users=getUsers(role);
        var userArray=users.split(",");
        user.options.length = 0; 
        for(var i=0;i<userArray.length/2;i++){
          user.options.add(new Option(userArray[i*2+1],userArray[i*2])); 
        }
   }
   
   function getRoles(){ 
        var temp = document.getElementsByName("nextName");
        var nextName;
        for(var i=0;i<temp.length;i++){
             if(temp[i].checked) nextName = temp[i].value;
        }
        nextName=encodeURI(encodeURI(nextName));
        var parameter="wfId=<%=wfId%>&activityName="+nextName;
        var result = ajaxRequest("<%=basePath%>","startWorkflow","getRoleByActivityName",parameter);
        return result;
   }
   
    function getUsers(roleid){
        var parameter;
        if(roleid!=null){  
          parameter="roleId="+roleid;
        }else{
          parameter="wfInsId=<%=wfInsId%>";
        }
        var result = ajaxRequest("<%=basePath%>","startWorkflow","getUsersByRoleId",parameter);
        return result;
   }
      
   function closeWin(){
       window.close();
   }
   
   function bindCheck(){
        document.getElementsByName("nextName")[0].checked=true;
   }
    
   function transfer(){
        var fullName=document.getElementById("users");
        if(fullName!=null){
          var fullName=encodeURI(encodeURI(fullName.value));
        }  
        var temp = document.getElementsByName("nextName");
        var nextName=null;
        for(var i=0;i<temp.length;i++){
          if(temp[i].checked) nextName = temp[i].value;
        }
        nextName=encodeURI(encodeURI(nextName));   
        var parameter="op=donext&assignee="+assignee+"&wfInsTaskId=<%=wfInsTaskId%>&nextNodeName="+nextName
                       +"&nextFullName="+fullName+"&wfInsId=<%=wfInsId%>&yw_guid=<%=yw_guid%>";
        var result = ajaxRequest("<%=basePath%>","startWorkflow","transferTask",parameter);
        if(result=="true"){
               alert("操作成功！");
                path=eval(path);
               var MyArgs = new Array("3",path);
               window.returnValue = MyArgs; 
                cancel();
        }else{      
              alert("移交异常！");
        }
   }
   //确定

function confirm(){
   //lian  
  var qq="";
  var radio=document.getElementsByName("laccORfgb");
  for(var i=0;i<radio.length;i++){
	if(radio[i].checked==true)
	{
	  selectedValue=radio[i].value;
	  
	  if(selectedValue=="立案查处"){
	  	 //立案操作 
	  	 putClientCommond("xfaj","setXFStatus");
         putRestParameter("status",'1');
         putRestParameter("yw_guid","<%=yw_guid%>");
         restRequest();
		 putClientCommond("startWorkflow","startWorkflow");
         putRestParameter("zfjcType","7");
         putRestParameter("yw_guid","<%=yw_guid%>");
         putRestParameter("flag","1");
         putRestParameter("lyType","XF");
         putRestParameter("fullName",escape(escape("<%=fullName%>")));
          path=restRequest();
        // path=eval(path);
          qq="wain";
       //  var MyArgs = new Array("3",path);
       //  window.returnValue = MyArgs; 
        // cancel();
	}
	  
	  if(selectedValue=="法规办")
	  {
	     putClientCommond("xfaj","setXFStatus");
         putRestParameter("status",'2');
         putRestParameter("yw_guid","<%=yw_guid%>");
		 myData = restRequest();
		   qq="wain";
		if(myData=="true")
		{
		    var MyArgs = new Array("1","2");
        //   window.returnValue = MyArgs; 
			//cancel();
		}
	 }
	}
  }
   if(qq=="wain"){
        transfer();
   }else{
        cancel();
   }
}

function cancel(){
	window.close();
}
</script>
	</head>

	<body onload="bindCheck()">
		<div
			style="width: 250px; height: 100px; margin: auto; margin-top: 50px">
			<form>
				<font color="#804000"><b>下一办理环节：</b> </font>
				<br />
				<br />
				<%
					int count = 0;
					while (it.hasNext()) {
						String str = (String) it.next();
						if (!str.endsWith(activityName)) {
							count++;
							if (count == 1) {
								currentNode = str;
							}
				%>
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<input type="radio" name="nextName"   checked="checked" onclick="changeRole()"
					value='<%=str%>' /><%=str%><br />
				<br />
				<%
					}
					}
				%>


				<%
					if (!currentNode.equals("办结")) {
						List<Map<String, Object>> Roles = workflowOp.getAllRoles(currentNode, wfId);
						if (Roles != null) {
				%>
				<font color="#804000"><b>移交机构：</b> </font>
				<select id="roles" onchange="changeUser()" style="width: 130px">
					<%
						for (int i = 0; i < Roles.size(); i++) {
									Map<String, Object> roleMap = (Map<String, Object>) Roles.get(i);
									if (i == 0) {
										currentRole = (String) roleMap.get("roleid");
									}
					%>
					<option value='<%=(String) roleMap.get("roleid")%>'><%=(String) roleMap.get("rolename")%></option>
					<%
						}
					%>
				</select>
				<br />
				<br />
				<font color="#804000"><b>移&nbsp&nbsp交&nbsp&nbsp给：</b> </font>
				<select id="users" style="width: 130px">
					<%
						List<Object> initUsers = ManagerFactory.getUserManager().getAllUser(currentRole);
								for (int i = 0; i < initUsers.size(); i++) {
									Map<String, Object> userMap = (Map<String, Object>) initUsers.get(i);
					%>
					<option value='<%=(String) userMap.get("fullname")%>'><%=(String) userMap.get("fullname")%></option>
					<%
						}
					%>
				</select>
				<%
					} else {
							String owner = JBPMServices.getInstance().getExecutionService().getVariable(wfInsId, "owner")
									.toString();
				%>
				<br />
				<br />
				<font color="#804000"><b>移&nbsp&nbsp交&nbsp&nbsp给：</b> </font>
				<select id="users" style="width: 130px">
					<option value='<%=owner%>'><%=owner%></option>
				</select>
				<script type="text/javascript">
				assignee="true";
	           </script>
				<%
					}
					}
				%>



				<br />
				<br />
				<%
					if (currentNode.equals("办结")) {
				%>
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<input type="button" class='btn' onclick="transfer()" value="结束"
					style="width: 61px; height: 22px" />
				&nbsp;&nbsp;&nbsp;
				<%
					} 
				%>
		</div>
		  <div style="width: 250px; height: 150px; margin: auto; margin-top: 50px">
			  <font color="#804000"><b>请选择处理方式</b></font><br/><br/>
			  <input type="radio" name='laccORfgb' id='laccO' checked="checked" value="立案查处"/>立案查处&nbsp;&nbsp;
			  <input type="radio" name='laccORfgb' id='fgb' value="法规办"/>法规办
			  <br/><br/>
				<input type="button" value="确定" onclick="confirm();"
					style="width: 61px; height: 22px; FONT-SIZE: 12px; CURSOR: hand;" />
				&nbsp;&nbsp;&nbsp;&nbsp;
			  <input type="button"  value="取消" onclick="cancel();" style="width: 61px; height: 22px;FONT-SIZE: 12px;CURSOR: hand;" />
			
	      </div>
	</body>
</html>