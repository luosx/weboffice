<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.base.util.UtilFactory" %>
<%@ include file="/base/include/formbase.jspf"%>
<%@page import="com.klspta.console.role.Role" %>
<%@page import="com.klspta.console.ManagerFactory"%>
<%@page import="java.util.Calendar" %> 
<%
	String way = request.getParameter("way");
	String path = request.getContextPath();
	String phoneNum = request.getParameter("phonenumber");
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
    String jdbcname=request.getParameter("jdbcname");
	String yw_guid=request.getParameter("yw_guid");
	String xsh=request.getParameter("xsh");
	//初始化时加载省级行政区划		
	//String topXzqh = UtilFactory.getXzqhUtil().generateOptionByList();
	Object user = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	User userBean1 = (User) user;
	String username=userBean1.getFullName();
	User userBean = null;
	//用户名
	String name="";
	//用户单位
	String department = "";
	// 用户行政级别
	String userXzqh = "";
	if(user instanceof User){
		userBean = (User)user;
		name = userBean.getUsername();
		List<Role> role = ManagerFactory.getRoleManager().getRoleWithUserID(userBean.getUserID());
		department = role.get(0).getRolename();
		userXzqh = userBean.getXzqh();
	}else{
		name = user.toString();
	}
	
	//获取当前人员级别,当人员为省一级时，获取name,县一级时，获取父级。
	String jbString = "";
	String departName = "";
	String parentcode = "";
	String parentLevel = "";
	if(userXzqh.equals("0")){
		jbString = "1";
	}else if(userXzqh.endsWith("0000")){
		jbString = "2";
		//departName = UtilFactory.getXzqhUtil().getNameById(userXzqh).get(0).getCatonname();	
	}else if(userXzqh.endsWith("00")){
		jbString = "3";
	}else{
		jbString = "4";
		//parentcode = UtilFactory.getXzqhUtil().getParentByChildId(userXzqh).get(0).getCatoncode();
		if(parentcode.endsWith("0000")){
			parentLevel = "2";
		}
	}
	
	//获取人员角色
	List<Role> roleList = ManagerFactory.getRoleManager().getRoleWithUserID(userBean.getUserID());
	String role = roleList.get(0).getRolename();
	
	//获取要求反馈日期
	Date beforeDate = new Date();
	Calendar needDate = Calendar.getInstance();
	needDate.setTime(beforeDate);
	needDate.set(Calendar.DATE, needDate.get(Calendar.DATE) + 50);
	String backDate = needDate.getTime().toLocaleString();
	//获取当前日期
	String date = beforeDate.toLocaleString() ;
	
%>

<html>
	<head>

		<base href="<%=basePath%>">

		<title >违法违规登记</title>
	
		<link rel="stylesheet" type="text/css" href="<%=basePath%>base/form/css/formStyleDefault.css">
		<style type="text/css">
			td{border-right:1px solid  #2C2B29; border-bottom:1px solid  #2C2B29; padding-right:10px}
		</style>
		<script type="text/javascript">
		
		//处理点击backspace时刷新问题：
		function document.onkeydown()   
		{   
   			if ((event.keyCode==8)){ 
       			
      		 }   
		}   
		
		function Addopt(wflx, value){
			var opt = document.createElement('option');
			opt.text = value;
			opt.value = value;
			wflx.options.add(opt);
		}
			
		function initSelect(){
			//添加提交保存功能
			init();
			changeName("JBRDZ1");
			changeName("WTFSD1");
			//获取省级政区规划
			//判断办结
			getTopXzqh("JBRDZ1");
			getTopXzqh("WTFSD1");
			// 显示办理区域
			//showManageArea();
			
			// 填写举报方式
			//如果是电话直接打过来，填写电话号码
			var phoneNum = "<%=phoneNum%>";
			if(phoneNum.indexOf("null") == -1){
				var phoneNumber = document.getElementById("dianhua");
				phoneNumber.value = phoneNum.split("?", 15)[0];
				getLocation(phoneNum.split("?", 15)[0]);
			}
			window.onscroll=function()
			{
				document.getElementById("savess").style.top = (document.body.scrollTop + 5)
				+ "px";

			}
		}
		
		// 电话举报时，获取号码的归属地
		function getLocation(number){
			//var objXMLReq = new ActiveXObject("Microsoft.XMLHTTP");
			//var URL = "http://www.youdao.com/smartresult-xml/search.s?type=mobile&q=18626185421";         
    		//objXMLReq.open("get", URL , false);
    		//objXMLReq.send();
   			//var result = objXMLReq.responseText; 
			//alert(result);
			var path = "<%=basePath%>";
			var actionName = "mobileLocation";
			var actionMethod = "getMobileLocation";
			var parameter = "number=" + number;
			var myData = ajaxRequest(path, actionName, actionMethod, parameter);
			var obj = eval('(' + myData + ')');
			var name = "JBRDZ";
			var province = document.getElementById("JBRDZ1");
			var city = document.getElementById("JBRDZ2");
			for(var i = 0; i < obj[0].length; i++){
				var location = document.getElementById(name + (i + 1));
				var opt = document.createElement('option');
				opt.text = obj[0][i].name;
				opt.value = obj[0][i].code;
				opt.selected = "selected";
				location.options.add(opt, 0);
				jbrdzChange(location);
			}
		}
		
		
		function showManageArea(){
			// 获取部级办理状态
			var department = document.getElementById("department");
			// 获取省级办理状态
			var province = document.getElementById("province");
			// 获取市级办理状态
			var city = document.getElementById("city");
			// 获取县级办理状态
			var county = document.getElementById("county");
			// 登记人员级别
			var user = document.getElementById("XSH");
			var xsh = user.value;
			var userRank = xsh.substring(0, 1);
			//目前处理人员级别
			var userLevel = <%=jbString%>;
			
			var departmentBLQ = document.getElementById("BLQ1");
			var provinceBLQ = document.getElementById("BLQ2");
			var cityBLQ = document.getElementById("BLQ3");
			
			//显示对应级别的办理区
			if(department.value != ""){
				departmentBLQ.style.display = "block";
			}
			if(province.value != ""){
				provinceBLQ.style.display = "block";
			}
			if(city.value != ""){
				cityBLQ.style.display = "block";
			}
			
			if(userLevel == "1"){
				departmentBLQ.style.display = "block";
			}else if(userLevel == "2"){
				provinceBLQ.style.display = "block";
			}else if(userLevel == "3"){
				cityBLQ.style.display = "block"; 
			}
			
			//判断是否是暂存数据
			var isRecord = document.getElementById("flag");
			var zancun = document.getElementById("Tstorage");
			if(department.value != "" || province.value != "" || city.value != "" || county.value != ""){
				zancun.style.display = "none";
			}
			
			//判断办结
			var isbj = document.getElementById("BJ");
			
			
			//判断是否显示退回按钮
			var backButton = document.getElementById("tuihui");
			if(userLevel == "1" && department.value == "3"){
				backButton.style.display = "";
			}else if(userLevel == "2" && (getCondition("3") == "4")){
				backButton.style.display = "";
			}else if(userLevel == "3" && (getCondition("4") == "4")){
				backButton.style.display = ""; 
			}
			
			//匿名时，只有登记级别的人员才能看到举报人
			var isnm = document.getElementById("NM");
			var jbr = document.getElementById("JBR");
			if(isnm.checked && (userLevel != userRank)){
				jbr.innerText = "";
			}
			
			
			//判断条件将不可用的设置为灰色
			
			//判断登记页面
			var clueSignArea = new Array();
			clueSignArea.push("JBR","NM","xsh","JBRDZ1","JBRDZ2","JBRDZ3","JBRDZ4","JBRDZ","YZBM","dianhua","bh","DZYJ","email","ZYLD","XJDW","ZYMT","QTFS","PZH","BZ","WTFSD1","WTFSD2","WTFSD3","WTFSD4","WTFSD5","WTFSD6","WTFSD","WTFSSJ","BJBDW","BJBDWJB","XSZY","WXXSLB");
			if(isRecord.value != "0"){
				setreadOnly(clueSignArea);
			}
			
			//判断受理区
			var lawType = new Array();
			var departmentarea = new Array();
			var provincearea = new Array();
			var cityarea = new Array();
			var endarea = new Array();
			var disponseend = new Array();
			
			lawType.push("TDWF","KCWF","WFLXXX");
			departmentarea.push("ZJZB1","ZDWFAJ1","SPYJ1");			
			provincearea.push("ZJZB2","ZDWFAJ2","SPYJ2");
			cityarea.push("ZJZB3","ZDWFAJ3","SPYJ3");
			endarea.push("JBSS","BFSS","JBBSS","YES","NO","BJBZ");
			disponseend.push("BJ","BJRQ");
			
			
			//如果是办结的话，都不可编辑
			var BJ = document.getElementById("BJ");
			if(BJ.checked){
				setreadOnly(lawType);
				setreadOnly(departmentarea);
				setreadOnly(provincearea);
				setreadOnly(cityarea);
				setreadOnly(endarea);
				setreadOnly(disponseend);
				return ;
			}
			
			//根据各个级别的状态设定可编辑区域
			switch(parseInt(userLevel)){
				case 1:
					setreadOnly(provincearea);
					setreadOnly(cityarea);
					if(department.value != "2" && department.value != "1"){
						setreadOnly(departmentarea);
					}else if(department.value != "2" || department.value != "1" || department.value != "3"){
						setreadOnly(disponseend);
					}
					
				break;
				
				case 2:
					setreadOnly(departmentarea);
					setreadOnly(cityarea);
					if(province.value != "2" && province.value != "1"){
						setreadOnly(provincearea);
					}else if(province.value != "2" || province.value != "1" || province.value != "3"){
						setreadOnly(disponseend);
					}
				break;
				
				case 3:
					setreadOnly(departmentarea);
					setreadOnly(provincearea);
					if(city.value != "2" && city.value != "1"){
						setreadOnly(cityarea);
					}else if(city.value != "2" && city.value != "1" && city.value != "3"){
						setreadOnly(disponseend);
					}
				break;
				
				case 4:
					setreadOnly(departmentarea);
					setreadOnly(provincearea);
					setreadOnly(cityarea);
					if(county.value != "2" && county.value != "1"){
						setreadOnly(disponseend);
					}
					
				break;
			
			}
			
			//设定办结区和违法类型区是否可填
			if(userLevel != userRank){
				setreadOnly(disponseend);
				setreadOnly(lawType);
			}
			
		}
		
		
		//将设定的不可用的设置灰色
		function setreadOnly(checkarea){
			for(var i = 0; i < checkarea.length; i++){
				var signarea = document.getElementById(checkarea[i]);
				signarea.style.color="#787878";
				if(signarea.type == "radio" || signarea.type == "checkbox"){
					signarea.onclick = function(){return false;};
					//signarea.disabled=true
				}else if(signarea.type == "select-one"){
					//signarea.disabled=true
					signarea.onChange = function(){return false;};
				}else{
					signarea.readOnly = true;
				}
			}
		}
		
		//function changTrHeight(){
		//	var trs=document.getElementsByTagName("tr");
		//	for(var i=0;i<trs.length;i++){
		//		trs[i].style.height="25px";
		//	}
			
		//}
		// 计算备注所用字符数	
		function countNum(check){
			var name = check.id;
			var nameNum = name + "NUM";
			var num = document.getElementById(nameNum);
			var textArea = document.getElementById(name);
		
			var count = textArea.value.length;
			// num.value = count; 
			num.innerText = count;
		}	
	
		// 添加领导批示
		function InsertLeadPost(){
			var leadTable = document.getElementById("LeadPostilTable");
			var newRow = leadTable.insertRow(leadTable.rows.length);
			var row1 = newRow.insertCell(0);
			row1.innerHTML = "<input type='text' />";
			var row2 = newRow.insertCell(1);
			row2.innerHTML = "<input type='text' />";
			var row3 = newRow.insertCell(2);
			row3.innerHTML = "<input type='text' />";
			var row4 = newRow.insertCell(2);
			row4.innerHTML = "<input type='text' />";
		}
		
		// 选择信件类型
		function mailType(radioType){
			var ybxj = document.getElementById("YBXJ");
			var ghx = document.getElementById("GHX");
			var tbghx = document.getElementById("TBGHX");
			var pznumber = document.getElementById("pznumber");
			ybxj.checked = false;
			ghx.checked = false;
			tbghx.checked = false;
			pznumber.style.display = "none";
			if(radioType.id == "YBXJ"){
				ybxj.checked = true;
			}else if(radioType.id == "GHX"){
				ghx.checked = true;
				pznumber.style.display = "block";
			
			}else{
				tbghx.checked = true;
				pznumber.style.display = "block";
			}
		}
		
		//查询时，将政区编号改为政区名称	
		function changeName(name){
			var currentNum = name.charAt(name.length - 1);
			var currentname = name.substring(0, name.length - 1);
			
			//var selectLabel = document.getElementById(currentname + 7);
			var newString = "";
			//selectLabel.innerText = newString;
			
			for(i = 1; i < 6; i++){
			 	var nextNum = parseInt(currentNum) + i - 1;
			 	var nowName = currentname + nextNum;
				var select = document.getElementById(nowName);
				
				if(select != undefined){
					if(select.options == undefined)
						continue;	
					var number = select.options.value;
					if(number != "请选择" && number != ""){
						var path = "<%=basePath%>";
						var actionName = "xzqh";
						var actionMethod = "getNameById";
						var parameter = "id=" + number;
						var myData = ajaxRequest(path, actionName, actionMethod, parameter);
						var obj = eval('(' + myData + ')');
						//select.options.innerText = obj[0][0].name;
						// select.options.innerText = "";
						var opt = document.createElement('option');
						opt.text = obj[0][0].name;
						opt.value = obj[0][0].code;
						opt.selected = "selected";
						newString = newString + obj[0][0].name;
						select.options.innerText = "";
						select.options.add(opt, 0);
					}else{
						if(number != "请选择"){
							var value = "请选择";
							Addopt(select, value);
						}
					}
						//selectLabel.innerText = newString;
				}
			}
		}
		//获取省级行政区划
		function getTopXzqh(name){
			var obj = eval('430400');
			select = document.getElementById(name);
			if(obj != ""){ 
				for(var i = 0; i < obj.length; i++){
					var opt = document.createElement('option');
					opt.text = obj[i].name;
					opt.value = obj[i].code;
					select.options.add(opt);
				}
			}
		}
		
		// 实现地区选择
		function jbrdzChange(level){
			var path = "<%=basePath%>";
			var actionName = "xzqh";
			var actionMethod = "getNextPlace";
			var parameter = "code=" + level.value;
			var myData = ajaxRequest(path, actionName, actionMethod, parameter);
			var obj = eval('(' + myData + ')');
			
			var currentLevel = level.id;
			var currentNum = currentLevel.charAt(currentLevel.length - 1);
			var name = currentLevel.substring(0, currentLevel.length - 1);
			var nextNum = parseInt(currentNum) + 1;
			
			//当选择的是举报人地址时添加邮政编码,且默认举报人地址和问题发生地相等。
			if(name == "JBRDZ"){
				var actionPost = "getPostalCodeById";
				var postData = ajaxRequest(path, actionName, actionPost, parameter);
				var postobj = eval('(' + postData + ')');
				var postInput = document.getElementById("YZBM");
				if(postobj[0] != null){
					//添加邮政编码
					postInput.innerText = postobj[0];
				}
				var wtfsd = document.getElementById("WTFSD" + currentNum);
				if(wtfsd.options[wtfsd.selectedIndex].text != level.options[level.selectedIndex].text){
					var wtfsdopt = document.createElement('option');
					wtfsdopt.text = level.options[level.selectedIndex].text;
					wtfsdopt.value = level.value;
					wtfsdopt.selected = true;
					wtfsd.options.add(wtfsdopt, 0);
					jbrdzChange(wtfsd);
				}
			}
			
			//添加选择过后的区域
			var selectLabel = document.getElementById(name);
			var labelString = selectLabel.innerText;
			var newString = "";
			for(var i = 1; i <= currentNum; i++){
				var newname = name + i;
				var newselect = document.getElementById(newname);
				//alert(newselect.options[newselect.selectedIndex].text);
				newString = newString + newselect.options[newselect.selectedIndex].text;
			}
			selectLabel.innerText = newString;
			if(name == "JBRDZ"){
				var selectwtfsd = document.getElementById("WTFSD");
				selectwtfsd.innerText = newString;
			}
		
			var nextLevel = name + nextNum;
			if(nextNum == "6" ){
				return ;
			}
			var selectPlace = document.getElementById(nextLevel);
			if(selectPlace.options == undefined){
			
			}else{
				selectPlace.options.innerText = "";
			}
			if(selectPlace == undefined)
				return ; 
			//重选时，去除选择过得选项
			for(var i = nextNum; i < 6; i++){
				var deleteLevel = name + i;
				deleteOptions = document.getElementById(deleteLevel);
				if(deleteOptions != undefined){
					if(deleteOptions.options !== undefined){
						deleteOptions.options.innerText = "";
						var value = "请选择";
						Addopt(deleteOptions, value);
					}
				}
			}
			
		
			
			if(obj == "")
				return ;
				
			if(selectPlace.type != "select-one"){
				return ;
			}

			for(var i = 0; i < obj[0].length; i++){
				var opt = document.createElement('option');
				opt.text = obj[0][i].name;
				opt.value = obj[0][i].code;
				selectPlace.options.add(opt, 0);
			}
		
		}
		
		//填写问题发生地时将内容添加到labal中(仅方向)
		function direction(){
			//changeName("WTFSD1");
			var setDir = document.getElementById("WTFSD6");
			var label = document.getElementById("WTFSD");
			var newString = label.value;
			var dirString = setDir.options[setDir.selectedIndex].text;
			if(dirString != "请选择"){
				newString = newString + dirString;
			}
			label.innerText = newString;
		
		}
		
		// 检查邮件地址是否正确/是否是重复线索
		function checkLocation(check){
			var email = check.value;
			if (email != "") {
				var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
				isok= reg.test(email );
			    if (!isok){
			    	alert("邮箱地址有错，请确认");
	            	// check.focus();
	            }
			}
			
			var path = "<%=basePath%>";
			var actionName = "createxs";
			var actionMethod = "checkRepeat";
			var parameter = "&way=email&value=" + email;
			var myData = ajaxRequest(path, actionName, actionMethod, parameter);
			var obj = eval('(' + myData + ')');
			
			var email = document.getElementById("email");
			var dzyj = document.getElementById("DZYJ");
			var yjvalue = dzyj.value;
			
			email.innerHTML = "<input type='text' style='border:0px' >";
			if(obj[0][0]== undefined){
				return;
			}
			
			if(obj[0][0].yw_guid != ""){
				email.innerHTML = "<label>查看之前举报记录:</label>"
				// email.innerHTML = "<input id="DZYJ" style=" font-size:12px" name="dzyj" onblur='checkLocation(this)' value="+ yjvalue +"></input><br>" + "<label>查看之前举报记录</label>";
			}
				
			for(var i = 0; i < obj[0].length; i++){
				email.innerHTML = email.innerHTML + "<label onclick='readRepeat(this); return false' value=" + obj[0][i].yw_guid + "><SPAN style='COLOR: red'>线索" + (i+1) + "</SPAN></label>&nbsp;&nbsp";
			}
			
		}
	
		function readRepeat(check){
			var ywguid = check.value;
			window.open("<%=basePath%>web/hotline/recordclue/wfxsdjbl.jsp?jdbcname=YWTemplate&way=email&phonenumber=null&yw_guid=" + ywguid );
		}
	
		// 转到下一页
		function ButtonClick(){
		
		}
		
		// 附件上传
		function AttachUpload(){
			var name = "yw_guid";
			var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)","i");
			var r = window.location.search.substr(1).match(reg); 
			var yw_guid = unescape(r[2]); 
			window.showModalDialog("<%=basePath%>/model/accessory/upload/upload.jsp?yw_guid="+yw_guid,window,"dialogWidth=580px;dialogHeight=300px;status=no;scroll=no");
		}
		
		// 打印登记表
		function ExportLawlessClueBasicInfoBillData(){
		
		}
		
		function upTable(){
			var formtitle = document.getElementById("formtitle");
			var table1 = document.getElementById("table");
			var table2 = document.getElementById("table2");
			table1.style.display = "block";
			table2.style.display = "none";
			formtitle.innerText = "违 法 线 索 登 记";
			var xiaButton = document.getElementById("xiayibu");
			// var shangButton = document.getElementById("shangbao");
			var tuiButton = document.getElementById("shangyibu");
			xiaButton.style.display = "";
			// shangButton.style.display = "none";
			tuiButton.style.display = "none";
		}
		
		
		//当不适用页面跳转时，采用以下方法实现提交
		function save(chose, type){
			var myForm = document.forms[0];
			myForm.submit();
		}
		
		//处理退回时间，
		function goback(){
			var message = "当前线索将作退回处理，确认？";
			var userconfirm = confirm(message);
			if(userconfirm == false){
				return;
			}		
			var myForm = document.forms[0];
			//获取填写人当前级别
			var userLevel = <%=jbString%>;
			var nextLevel = String(parseInt(userLevel) + 1);
			changeCondition(userLevel, "2");
			changeCondition(nextLevel, "5");
			addLog("退回下级处理");
			myForm.submit();
		}
		
		//添加处理日志
		function addLog(messageLog, userxzqh){
			var path = "<%=basePath%>";
			var actionName = "disposelog";
			var actionMethod = "setLog";
			var userlevel = "<%=jbString%>";
			var bljb = "<%=role%>";
			// if(userlevel == "1"){
			//	bljb = "国土资源部";
			//}else{
				
			//	bljb =  userxzqh + "国土资源厅";
			//}
			
			var parameter = "yw_guid=<%=yw_guid%>&blr=<%=name%>&blms=" + messageLog + "&bljb=" + bljb;
			ajaxRequest(path, actionName, actionMethod, parameter);
		}
		
		//更改级别办理状态
		function changeCondition(level, condition){
			// 获取部级办理状态
			var department = document.getElementById("department");
			// 获取省级办理状态
			var province = document.getElementById("province");
			// 获取市级办理状态
			var city = document.getElementById("city");
			// 获取县级办理状态
			var county = document.getElementById("county");
			
			if(level == "1"){
				department.innerText = condition;
			}else if(level == "2"){
				province.innerText = condition;
			}else if(level == "3"){
				city.innerText = condition;
			}else if(level == "4"){
				county.innerText = condition;
			}
			
		}
		
		//获取级别办理状态
		function getCondition(level){
			var conditionValue = "";
			// 获取部级办理状态
			var department = document.getElementById("department");
			// 获取省级办理状态
			var province = document.getElementById("province");
			// 获取市级办理状态
			var city = document.getElementById("city");
			// 获取县级办理状态
			var county = document.getElementById("county");
			
			if(level == "1"){
				conditionValue = department.value;
			}else if(level == "2"){
				conditionValue = province.value;
			}else if(level == "3"){
				conditionValue = city.value;
			}else if(level == "4"){
				conditionValue = county.value;
			}
			return conditionValue;
		}
		
	</script>
	</head>
	<body onLoad="initSelect();">

		<FORM id="mainform" name="mainform" action="" method="post">
			<DIV  align=center  style="HEIGHT: 30px;FONT-WEIGHT: bold; FONT-SIZE: 18pt; FONT-FAMILY: 宋体">
				<label id="formtitle">违 法 线 索 登 记</label>
			</DIV>
			<div id="savess" class="Noprn"
	style="position: absolute; top: 5px; left: 10px">
			<img src="web/xuzhouWW/xsjb/images/save.png" alt="保存" onclick="save(this,'1')" /><br/>
			<img src="web/xuzhouWW/xsjb/images/issued.png" alt="下发" onclick="showReport()"  width=24 height=24/>
			</div>
			<TABLE  align="center" cellPadding="0" cellSpacing="0" class="tableBorder" id="table" style="WIDTH: 700; font-size:12px">
				<TBODY>
					<TR style="BACKGROUND-COLOR: white;height:25px;">
						<TD width="136"  align="right" bgcolor="#f6f8f9">
							<SPAN style="COLOR: red">*</SPAN>举报人（单位）</TD>
						<TD colSpan="1"  width="45%">
							<INPUT id="JBRDW" style="width:70%" name="jbrdw">
							<span style="position: relative;top: -3px;">
							<INPUT id="NM" name="nm" value="1" type="checkbox">
					  		<LABEL for="NM">匿名</LABEL></span>					  
					  	</TD>
						<TD width="230px"  align="right" bgcolor="#f6f8f9">
							线索号						
						</td>
						<td>
					  		<INPUT id="xsh" style="width:150px; border:0px"  type="text" name="xsh">		
					  	</TD>
					</TR>
					<TR style="BACKGROUND-COLOR: white;height:25px;">
						<TD align=right bgcolor="#f6f8f9">
							<SPAN style="COLOR: red">*</SPAN>举报方式						</TD>
						<TD colSpan="3">
						  <input type="text" id="JBFS" style=" border:0px; width:15%" name="jbfs" >
						</TD>
					</TR>
					<TR style="BACKGROUND-COLOR: white">
						<TD align=right bgcolor="#f6f8f9"> 
							举报人联系方式&nbsp;</TD>
						<TD colSpan="3" style="padding-right:0px">
							<TABLE width="100%" align="center" cellPadding="0" cellSpacing="0" style="WIDTH: 100%; border:0px;">
								<TBODY>
									<tr>
										<TD rowspan="2" align=right style="font-size:12px; width:80px" bgcolor="#f6f8f9">
											<SPAN style="COLOR: red">*</SPAN>联系地址									
										</TD>
										<TD  colspan="3" style="border-top:0px; border-right:0px;font-size:12px; border-bottom:0px">
											<SELECT id="JBRDZ1" onChange="jbrdzChange(this)" name="jbrdz1">
											</SELECT>
											<SELECT id="JBRDZ2" onChange="jbrdzChange(this)" name="jbrdz2">
											</SELECT>
											<SELECT id="JBRDZ3" onChange="jbrdzChange(this)" name="jbrdz3">
											</SELECT>
																					</TD>
									</tr>
									<TR>
										<TD  colspan="3" style="border-right:0px; font-size:12px; border-top:0px">&nbsp;
											<INPUT id="JBRDZ" name="jbrdz" style="width:290" type="text">										</TD>
									</TR>
										
							
									<TR style="border-top:1px;height:25px;" >
										<TD align=right style="border-bottom:0px; font-size:12px; width:80px" bgcolor="#f6f8f9">
											邮政编码										
										</TD>
										<TD width="24%"  style="border-bottom:0px; font-size:12px;border-right:1px;" >
									  		<INPUT id="JBRYZBM" width="100px" name="jbryzbm" >			
									  	</TD>
										<TD align=right  bgcolor="#f6f8f9" style="border-bottom:0px;border-left:1px solid #2C2B29; font-size:12px;width:18%">
											联系电话										
										</TD>
										<TD  style="border-bottom:0px; font-size:12px;border-right:0px">
									  		<INPUT id="dianhua" style="WIDTH:100%; font-size:12px" name="jbrlxdh" >									 
									  	</TD>
									</TR>
								</TBODY>
						  </TABLE>						</TD>
					</TR>

					<TR style=" BACKGROUND-COLOR: white;height:25px;">
						<TD  align=right bgcolor="#f6f8f9"> 
							登记部门						</TD>
						<TD style=" border-top:0px">
							<input id="DJBM" name="djbm" style="border: 0px" >						</TD>
						<TD style=" border-top:0px" align="right" bgcolor="#f6f8f9"> 
							登记人						</TD>
						<TD style=" border-top:0px" colspan="4" >
							<input type="text" align="right" style="width:75%; border:0px" id="DJR" name="djr" value=<%=username %> >						</TD>
					</TR>
					<TR style=" BACKGROUND-COLOR: white;height:25px;">
						<TD align=right bgcolor="#f6f8f9"> 
							登记日期						</TD>
						<TD colspan="3">
							<input id="DJRQ" name="djrq" style="border:0px" >						</TD>
					</TR>
					<TR style="BACKGROUND-COLOR: white">
						<TD  align=right bgcolor="#f6f8f9">
							备注</TD>
						<TD vAlign=top align=left colSpan=3>
							<TABLE style="TABLE-LAYOUT: fixed; WORD-WRAP: break-word;border:0px;width:100%" cellSpacing=0 cellPadding=0 >
									<TR >
										<TD style="border:0px">
											<TEXTAREA id="BZ" onKeyUp="countNum(this); return false;"
												style="WIDTH: 100%; HEIGHT: 48px;" name="bz"></TEXTAREA>										</TD>
									</TR>
							</TABLE>
					   </TD>
					</TR>
					<TR style="BACKGROUND-COLOR: white">
						<TD align=right bgcolor="#f6f8f9">
							<SPAN style="COLOR: red">*</SPAN>问题发生地						</TD>
						<TD colSpan="3">
							<SELECT id="WTFSD1" onChange="jbrdzChange(this)" name="wtfsd1"></SELECT>
							<SELECT id="WTFSD2" onChange="jbrdzChange(this)" name="wtfsd2"></SELECT>
							<SELECT id="WTFSD3" onChange="jbrdzChange(this)" name="wtfsd3"></SELECT>
							<SELECT id="WTFSD4" name="wtfsd4" onChange="jbrdzChange(this)"></SELECT>
							<SELECT id="WTFSD6" name="wtfsd6" onclick="direction()">
								<option>请选择</option>
								<option value="东">
									东								</option>
								<option value="西">
									西								</option>
								<option value="南">
									南								</option>
								<option value="北">
									北								</option>
							</SELECT>
							方位
							<INPUT id="WTFSD" style="width:290" type="text" name="wtfsd"><br>
					</TR>
					<TR style=" BACKGROUND-COLOR: white;height:25px;">
						<TD align=right bgcolor="#f6f8f9"> 
							问题发生时间						</TD>
						<TD colSpan=3>
							<input id="WTFSSJ" name="wtfssj" type="text" class="Wdate"
								onClick="WdatePicker()" />
					</TR>
					<TR style="BACKGROUND-COLOR: white;height:25px;">
						<TD id=jubaotd1 align=right bgcolor="#f6f8f9">
							<SPAN style="COLOR: red">*</SPAN>被举报单位						</TD>
						<TD colSpan=3>
							<INPUT   dataFld=reflectobject id="BJBDW" style="WIDTH:100%"
								name="bjbdw">						</TD>
					</TR>
					<TR style=" BACKGROUND-COLOR: white;height:25px;">
						<TD align=right bgcolor="#f6f8f9">
							<SPAN style="COLOR: red">*</SPAN>被举报单位级别						</TD>
						<TD colSpan=3>
							<SELECT id="BJBDWJB" style="WIDTH: 238px" name="bjbdwjb">
								<option value="">请选择</option>
								<OPTION value="省级">省级	</OPTION>
								<OPTION value="地级">地级</OPTION>
								<OPTION value="县级">县级	</OPTION>
								<OPTION value="乡（镇）">乡（镇）</OPTION>
								<OPTION value="村（组）集体">村（组）集体</OPTION>
								<OPTION value="企事业单位">企事业单位</OPTION>
								<OPTION value="个人">个人	</OPTION>
							</SELECT>
						</TD>
					</TR>

					<TR style="BACKGROUND-COLOR: white">
						<TD vAlign=middle align=right bgcolor="#f6f8f9">
							<SPAN style="COLOR: red">*</SPAN>线索摘要<br> 
					  （请写清基本违法事实）						</TD>
						<TD vAlign=top align=left colSpan=3>
							<TABLE style="TABLE-LAYOUT: fixed; WORD-WRAP: break-word;border:0px" cellSpacing=0 cellPadding=0 width="100%" >
								<TBODY>
									<TR>
										<TD style="border:0px">
											<TEXTAREA id="XSZY" 
												style="WIDTH: 100%; HEIGHT: 48px;" name="xszy" cols=42></TEXTAREA>										</TD>
									</TR>
								</TBODY>
							</TABLE>						</TD>
					</TR>
					<TR style="BACKGROUND-COLOR: white;height:25px">
						<TD vAlign=middle align=right bgcolor="#f6f8f9">
							<SPAN style="COLOR: red">*</SPAN>无效线索类别						</TD>
						<TD vAlign=top align=left colSpan=3 >
							<SELECT id="WXXSLB" style="WIDTH:238px" name="wxxslb" >
								<option value="">请选择</option>
								<OPTION value="查询结果">
									查询结果								</OPTION>
								<OPTION value="不属于受理范围">
									不属于受理范围								</OPTION>
								<OPTION value="--咨询建议">
									--咨询建议								</OPTION>
								<OPTION value="--权属争议">
									--权属争议								</OPTION>
								<OPTION value="--征地纠纷（拒绝征用、安置补偿）">
									--征地纠纷（拒绝征用、安置补偿）								</OPTION>
								<OPTION value="--城市拆迁">
									--城市拆迁								</OPTION>
								<OPTION value="--探采纠纷">
									--探采纠纷								</OPTION>
								<OPTION value="--揭发批评">
									--揭发批评								</OPTION>
								<OPTION value="--涉法涉诉（信访终结、进入司法）">
									--涉法涉诉（信访终结、进入司法）								</OPTION>
								<OPTION value="--其他">
									--其他								</OPTION>
								<OPTION value="内容不详">
									内容不详								</OPTION>
								<OPTION value="重复线索">
									重复线索								</OPTION>
							</SELECT>						</TD>
					</TR>
				</TBODY>
			</TABLE>
			<TABLE id=ZhiFaJuTR2 style="DISPLAY: block; WIDTH: 100%" border=0>
				<!--信息办理到时候使用-->
				<TBODY>
					<TR>
						<TD align="center" style="border-width:0">
							&nbsp;&nbsp;
							<!-- <input type="button" value="下发" onclick="showReport()"/> -->
							&nbsp;&nbsp;
							
						</TD>
					</TR>
				</TBODY>
			</TABLE>
	
			
	</body>
	<script type="text/javascript">
	function showReport()
	{	
		
		var obj=document.getElementById("WTFSD2");
		var index=obj.selectedIndex;
		if(index!=0)
		{	
			  var dqName=obj.options[index].text;	
				
			  var result=window.showModalDialog("<%=basePath%>web/xuzhouWW/xfxs_12336/xfrw.jsp",dqName,"dialogWidth=300px;dialogHeight=200px;status=no;scroll=no"); 
				if(result=="true")
					alert("下发任务成功！");
		}
		else
		{
			alert("请选择问题发生地！");
			return;
		}
		
	}
	function issued()
	{		
		loadAlert("下发成功!");
	}
	<%
		String msg = request.getParameter("msg");
	%>
	if("<%=msg%>" == "success"){
		alert("表单保存成功");
	}

	</script>
</html>
