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
	//初始化时加载省级行政区划		
	String topXzqh = UtilFactory.getXzqhUtil().generateOptionByList();
	Object user = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String yw_guid = request.getParameter("yw_guid");
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
		departName = UtilFactory.getXzqhUtil().getNameById(userXzqh).get(0).getCatonname();	
	}else if(userXzqh.endsWith("00")){
		jbString = "3";
	}else{
		jbString = "4";
		parentcode = UtilFactory.getXzqhUtil().getParentByChildId(userXzqh).get(0).getCatoncode();
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

		<title id="title">违法违规登记</title>
	
		<link rel="stylesheet" type="text/css" href="<%=basePath%>base/form/css/formStyleDefault.css">
		<!-- <script type="text/javascript" src="<%=basePath%>base/form/formStyleInit.js"></script> -->
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
		
		// 点击”土地违法“时
		function LawlessClueClassChange(check){
			var kcwf = document.getElementById("KCWF");
			var tdwf = document.getElementById("TDWF");
			var wflx = document.getElementById("WFLXXX");
			var buildxsbh = document.getElementById("WFXSBH");
			var xsh = document.getElementById("XSH");
			// 确定前两位；
			buildxsbh.value = xsh.value;
			wflx.options.innerText = "";
			if(check.checked == true){
				if(check.id == "TDWF"){
					kcwf.checked = false;
					Addopt(wflx, "非法占地");
					Addopt(wflx, "非法转让");
					Addopt(wflx, "非法批地");
					Addopt(wflx, "破坏农田");
					Addopt(wflx, "其他");
					// 确定前两位；
					buildxsbh.value = "TD" + xsh.value;
				}else{
					tdwf.checked = false;
					Addopt(wflx, "非法勘察");
					Addopt(wflx, "非法开采");
					Addopt(wflx, "非法转让");
					Addopt(wflx, "非法批准");
					Addopt(wflx, "其他");
					// 确定前两位；
					buildxsbh.value = "KC" + xsh.value;
				}
			}else{
				wflx.options.innerText = "";
				buildxsbh.value = "";
			}
		}
			
		function dcqk(check){
			var select = check.id;
			var JBSS = document.getElementById("JBSS");
			var BFSS = document.getElementById("BFSS");
			var JBBSS = document.getElementById("JBBSS");

			if (select == "JBSS" && check.checked == true){
				BFSS.checked = false;
				JBBSS.checked = false;
			}else if(select == "BFSS" && check.checked == true){
				JBSS.checked = false;
				JBBSS.checked = false;
			}else{
				JBSS.checked = false;
				BFSS.checked = false;
			}
		}
			
		function BLclick(check){
			var checkName = check.id;
			var checkNum = checkName.charAt(checkName.length - 1);
			var namePart = checkName.substring(0, checkName.length - 1);
			var checknumNext = String(parseInt(checkNum) - 1);
			var wtfsd = document.getElementById("WTFSD" + checknumNext);
			var wtfsdnext = document.getElementById("WTFSD" + checkNum);
			var zbr = document.getElementById("ZBR" + checkNum);
			zbdw = document.getElementById("ZBDW" + checkNum);
			var zbsj = document.getElementById("ZBSJ" + checkNum);
			var yqfkrq = document.getElementById("YQFKRQ" + checkNum);
			
			if(checkNum != "<%=jbString%>"){
				alert("您不能在该办理区填写，请在正确的办理区中填写！");
				check.checked = !check.checked;
				return;
			}
			
			//未选择问题发生地时，不能办理：
			if(wtfsdnext.options[wtfsdnext.selectedIndex].text == "请选择"){
				alert("未选择问题发生地，该线索不能办理");
				check.checked = false;
				return ;
			}
			
			// jbway.value = "电子邮件";
			if(check.checked == true){
				zbr.value = "<%=name%>";
				//zbdw.value = "<%=department%>";
				//if(parseInt(checkNum) <= 1){
				//	zbdw.value = "国土资源部";
				//}else{
					// 行政区划里面有国土资源名称，等添加完后，更改
				//	zbdw.value = wtfsd.options[wtfsd.selectedIndex].text + "国土资源厅";
				//}
				if(parseInt(checkNum) <= 1 && namePart=="ZJZB"){
					zbdw.value = wtfsdnext.options[wtfsdnext.selectedIndex].text + "国土资源厅";
				}else if(namePart == "ZJZB"){
					zbdw.value = wtfsdnext.options[wtfsdnext.selectedIndex].text + "国土资源局";
				}else{
					zbdw.value = "";
				}
				zbsj.value = "<%=date%>";
				yqfkrq.value = "<%=backDate%>";
			}else{
				zbr.value = "";
				zbdw.value = "";
				zbsj.value = "";
				yqfkrq.value = "";
			}
			
			var ZJZB = document.getElementById("ZJZB" +  parseInt(checkNum));
			var ZDWFAJ = document.getElementById("ZDWFAJ" +  parseInt(checkNum));
				
			if(check.checked == true && namePart == "ZJZB"){
				ZDWFAJ.checked = false;
			}else{
				ZJZB.checked = false;
			}
			
			}

			
		function LiAnClick(check){
			var select = check.id;
			var yes = document.getElementById("YES");
			var no = document.getElementById("NO");
			if(select == "YES" && check.checked == true){
				no.checked = false;				
			}else if(select == "NO" && check.checked == true){
				yes.checked = false;
			}
		}
		
		function clickBJ(ckeck){
			var bjrq = document.getElementById("BJRQ");
			bjrq.value = "<%=date%>";
		}
		
		function juBaoFS(){
			var JBFS = document.getElementById("JBFS");
			var zyld = document.getElementById("zyleader");
			var xjdw = document.getElementById("xjpart");
			var zymt = document.getElementById("zymedium");
			var dzyj = document.getElementById("dzEmail");
			var xjbh = document.getElementById("XJBH");
			var xj = document.getElementById("XJLX");
			var qtfs = document.getElementById("qtway");
			var xsh = document.getElementById("pznumber");
			dzyj.style.display = "none";
			zyld.style.display = "none";
			xjdw.style.display = "none";
			zymt.style.display = "none";
			qtfs.style.display = "none";
			xjbh.style.display = "none";
			xj.style.display = "none";
			if(JBFS.value == "信件"){
				xj.style.display = "";
				xjbh.style.display = "block";
			}else if(JBFS.value == "电子邮件"){
				dzyj.style.display = "block";
			}else if(JBFS.value == "领导批办"){
				zyld.style.display = "block";
			}else if(JBFS.value == "下级上报"){
				xjdw.style.display = "block";
			}else if(JBFS.value == "媒体反映"){
				zymt.style.display = "block";
			}else if(JBFS.value == "其他"){
				qtfs.style.display = "block";
			}
		}
		
		
		function initSelect(){
			//添加提交保存功能
			init();
			//changTrHeight();
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
			//getLocation("18626185421");
			var jbway = document.getElementById("JBFS");
			var way = "<%=way%>";
			if(way == "phone"){
				jbway.value = "电话";			
			}else if(way == "letter"){
				jbway.value = "信件";
			}else if(way == "email"){
				jbway.value = "电子邮件";
			}else if(way == "leadercall"){
				jbway.value = "领导批办";
			}else if(way == "handon"){
				jbway.value = "下级上报";
			}else if(way == "mediatall"){
				jbway.value = "媒体反映";
			}else if(way == "other"){
				jbway.value = "其他";
			}else if(way == "fax"){
				jbway.value = "传真";
			}else if(way == "ministry"){
				jbway.value = "部委转换";
			}
			juBaoFS();
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
			var obj = eval('(<%=topXzqh%>)');
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
		
		// 保存
		/*
		function save(chose, type){
		
			var messageLog = "";
			var myForm = document.forms[0];
			
			// 设定标志位初始值
			var flag = document.getElementById("flag");
			flag.innerText = type;
			
			// 获取目前级别当前状态
			// 获取部级办理状态
			var department = document.getElementById("department");
			// 获取省级办理状态
			var province = document.getElementById("province");
			// 获取市级办理状态
			var city = document.getElementById("city");
			var nowStatus = "";
			
			//获取填写人当前级别(需要判断是否是直辖市)
			var userLevel = <%=jbString%>;
			var userxzqhname = "chose<%=departName%>";
			var nextLevel = "";
			if(userLevel == "2" && userxzqhname.charAt(userxzqhname.length - 1) == "市"){
				nextLevel = String(parseInt(userLevel) + 2);
			}else{
				nextLevel = String(parseInt(userLevel) + 1);
			}
			
			if(userLevel == "1"){
				nowStatus = department.value;
			}else if(userLevel == "2"){
				nowStatus = province.value;
			}else if(userLevel == "3"){
				nowStatus = city.value;
			}
			
			var upperLevel = "";
			var parentLevel = "<%=parentLevel%>";
			if(parseInt(userLevel) > 1 && parentLevel == "2"){
				upperLevel = String(parseInt(userLevel) - 2);
			}else if(parseInt(userLevel) > 1){
				upperLevel = String(parseInt(userLevel) - 1);
			}
					
			// 判断是否上级交办
			var currentXSH = document.getElementById("XSH");
			var xsh = currentXSH.value;
			var userRank = xsh.substring(0, 1);
			var isHandOver;
			if(userRank >= userLevel){
				isHandOver = false;						
			}else{
				isHandOver = true;
			}
			
			// 获取是否立案,如果选择已立案，且未办结，则本级已上报，上级已确认。
			var isLA;
			var yesla = document.getElementById("YES");
			var nola = document.getElementById("NO");
			if(yesla.checked || nola.checked){
				isLA = true;
			}else{
				isLA = false;
			}
	
			// 点击保存时，
			if(type == "1"){
				// 选择是否办结
				var BJ = document.getElementById("BJ");
				var isBJ;
				if(BJ.checked){
					isBJ = true;
					for(var i = 1; i < 5; i++){
						if(getCondition(i) != ""){
							changeCondition(i, "10");
						}
					}
					messageLog = "办结";
					var userconfirm = confirm("当前线索将"+messageLog + ",确定？");
					if(userconfirm == false){
						return;
					}
					addLog(messageLog, "<%=departName%>");
					myForm.submit();
					return ;
				}else{
					isBJ = false;
				}
				
				//下级处理完给上级时，如果上级没有完结，保存没有效果
				if(isLA && userRank == userLevel && nowStatus=="3" ){
					alert("没有办结，请办结后保存。");
					return;
				}
				//判断处理状态
				// 获取当前级别的办理区的建议办理方式
				if(parseInt(userLevel) < 4){
					var blfsa = document.getElementById("ZJZB" + userLevel);
					var blfsb = document.getElementById("ZDWFAJ" + userLevel);
					if(blfsa.checked){
						//防止重复登记
						if(getCondition(userLevel) == "2" && getCondition(nextLevel) == "1"){
						}else{
							// 当前级别(办理中)
							changeCondition(userLevel, "2");
							// 下一级别（待办理）
							changeCondition(nextLevel, "1");
							messageLog = "转办给" + zbdw.value;
						}
					}else if(blfsb.checked){
						// 建议作为重大线索，办理中
						if(getCondition(userLevel) != "2" && !isLA){
							messageLog = "由本级直查";
							changeCondition(userLevel, "2");		
						}
					}else{
						// 未选择办理方式，待办理
						if(getCondition(userLevel) != "1"){
							messageLog = "登记完成并转给处理人员";
							changeCondition(userLevel, "1");
						}
					}
				}else{
					var tdwf = document.getElementById("TDWF");
					var kcwf = document.getElementById("KCWF");
					if(tdwf.checked || kcwf.checked){
						messageLog = "登记完成并转给处理人员";
						changeCondition(userLevel, "2");
					}else{
						messageLog = "登记完成并转给处理人员";
						changeCondition(userLevel, "1");
					}
				}
			
				//上级交办线索处理完成后交给上级。
				if(isLA && (upperLevel != "") && isHandOver){
					
					if(getCondition(upperLevel) != "3" || getCondition(userLevel) != "4"){
						changeCondition(upperLevel, "3");
						changeCondition(userLevel, "4");
						changeCondition(nextLevel,"4");
						messageLog = "处理完成，并提交给上级";
					}
				}
				
			
			}else{
				//点击暂存时，所有状态置空
				messageLog = "暂存";
				changeCondition("1", "");
				changeCondition("2", "");
				changeCondition("3", "");
				changeCondition("4", "");
			}
			if(messageLog != ""){
				var userconfirm = confirm("当前线索将"+messageLog + ",确定？");
				if(userconfirm == false){
					return;
				}
				addLog(messageLog, "<%=departName%>");
			}
			myForm.submit();
		}
		*/
		
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
		
		
		//下一步
		function OpenLawlessClueRepeatedWindow(flag){
			formtitle.innerText = "违 法 线 索 登 记";
			var table1 = document.getElementById("table");
			var table2 = document.getElementById("table2");
			var xiaButton = document.getElementById("xiayibu");
			//var shangButton = document.getElementById("shangbao");
			var tuiButton = document.getElementById("shangyibu");
			xiaButton.style.display = "none";
			//shangButton.style.display = "";
			tuiButton.style.display = "";
			
			table1.style.display = "none";
			table2.style.display = "block";
			formtitle.innerText = "违 法 线 索 办 理";
		}
		
		// 检查电话举报线索是否是重复举报
		function checkisExist(){
		
		}
		//////////////////////////////////////////////////////////////
		  function show_hidden(boxname){
    	   if(boxname == 'mapbox'){
    		   opengispage();
    	   }else{
        	   var obj = document.getElementById(boxname);
           	   if( "none" == obj.style.display ){
           		   obj.style.display='';
           		   obj.style.display='';
           	   }else{
           		   obj.style.display='none';
           		   obj.style.display='none';
           	   }
    	   }
       }


 function opengispage(){
    	   var width = document.body.clientWidth - 100;
    	   var height = document.body.clientHeight - 100;
    	   var url = "<%=basePath%>/base/gis/pages/gisViewFrame.jsp?operation=20&yw_guid=321011202200&showtree=false";
    	   var result=window.showModalDialog(url, "","dialogWidth="+width+";dialogHeight="+height+";status=no;help=no;scroll=no"); 
    	   var s=result.replace(/<br>/g,'&nbsp,&nbsp').split('zuobiao:');
           document.getElementById("cbpd").innerHTML='<SPAN>'+s[0]+'</SPAN>';
           document.getElementById("zb").innerText+=':'+s[1];
       }
	
	</script>

	</head>

	<body onLoad="initSelect();">
		
		<FORM id="mainform" name="mainform" action="" method="post">
			<DIV  align=center  style="HEIGHT: 30px;FONT-WEIGHT: bold; FONT-SIZE: 18pt; FONT-FAMILY: 宋体">
				<label id="formtitle">违 法 线 索 登 记</label>
			</DIV>
			<TABLE  align="center" cellPadding="0" cellSpacing="0" class="tableBorder" id="table" style="WIDTH: 95%; font-size:12px">
				<TBODY>
					<TR style="BACKGROUND-COLOR: white;height:25px;">
						<TD width="136"  align="right" bgcolor="#f6f8f9">
							<SPAN style="COLOR: red">*</SPAN>举报人（单位）</TD>
						<TD colSpan="1"  width="45%">
							<INPUT id="JBR" style="width:70%" name="jbr">
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
											<SELECT id="JBRDZ4" onChange="jbrdzChange(this)" name="jbrdz4">
											</SELECT>										</TD>
									</tr>
									<TR>
										<TD  colspan="3" style="border-right:0px; font-size:12px; border-top:0px">&nbsp;
											<INPUT id="JBRDZ" name="jbrdz5" style="width:50%" type="text">										</TD>
									</TR>
										
							
									<TR style="border-top:1px;height:25px;" >
										<TD align=right style="border-bottom:0px; font-size:12px; width:80px" bgcolor="#f6f8f9">
											邮政编码										
										</TD>
										<TD width="24%"  style="border-bottom:0px; font-size:12px;border-right:1px;" >
									  		<INPUT id="YZBM" with="100px" name="yzbm" >			
									  	</TD>
										<TD align=right  bgcolor="#f6f8f9" style="border-bottom:0px;border-left:1px solid #2C2B29; font-size:12px;width:18%">
											联系电话										
										</TD>
										<TD  style="border-bottom:0px; font-size:12px;border-right:0px">
									  		<INPUT id="dianhua" style="WIDTH:100%; font-size:12px" name="lxdh" >									 
									  	</TD>
									</TR>
									
									<TR style="border-top:1px; display:none;height:25px;" id="XJLX" >
										
										<TD align=right style="border-bottom:0px;border-top:1px solid #2C2B29; font-size:12px;"  bgcolor="#f6f8f9">
											信件编号										</TD>
										<TD style="border-bottom:0px; border-top:1px solid #2C2B29; font-size:12px;border-right:1px;" >
											<INPUT id="bh" style=" font-size:12px" name="xjbh" >
										</TD>
										<TD colspan="3" style="border-bottom:0px;border-top:1px solid #2C2B29; font-size:12px;" >
											<span> <input type="checkbox" name="xjlx" id="YBXJ" value="1" onClick="mailType(this)">
							 					<label>一般信件</label> 
							 					<input type="checkbox" name="xjlx" id="GHX" value="2" onClick="mailType(this)"> 
							 					<label>挂号信</label> 
							 					<input type="checkbox" name="xjlx" id="TBGHX" value="3" onClick="mailType(this)"> 
							 					<label>特别挂号信</label> 
											</span>										</TD>
									</TR>

									<TR  id="dzEmail" style=" font-size:12px;" >
										<TD align=right style="border-bottom:0px;border-top:1px solid #2C2B29;" bgcolor="#f6f8f9">
											电子邮件										</TD>
										<TD colspan="2" style="border-top:1px solid #2C2B29;border-bottom:0px;border-right:0px">
											<INPUT id="DZYJ" style=" font-size:12px" name="dzyj"
												onblur="checkLocation(this)">
											<!-- <label id="yjrepeat" style="display:none">查看之前举报记录</label>  -->
										</TD>
										<TD id="email" style="border-top:1px solid #2C2B29;border-bottom:0px;border-right:0px">
												<INPUT type="text">
										</TD>
									</TR>
									 
								

									<TR style="DISPLAY: none" id="zyleader" colspan="3">
										<TD align=right style="border-bottom:0px;border-top:1px solid #2C2B29; font-size:12px" bgcolor="#f6f8f9">
											主要领导										</TD>
										<TD colspan="3" style="border-top:1px solid #2C2B29;border-bottom:0px; font-size:12px;border-right:0px">
											<INPUT id="ZYLD" style="WIDTH:100%; font-size:12px" name="zyld">										</TD>
									</TR>
									<TR style="DISPLAY: none" id="xjpart" colspan="3">
										<TD align=right style="border-bottom:0px; border-top:1px solid #2C2B29;font-size:12px" bgcolor="#f6f8f9">
											下级单位										</TD>
										<TD colspan="3" style="border-top:1px solid #2C2B29;border-bottom:0px; font-size:12px;border-right:0px">
											<INPUT id="XJDW" style="WIDTH:100%; font-size:12px" name="xjdw">										</TD>
									</TR>

									<TR style="DISPLAY: none" id="zymedium" colspan="3">
										<TD align=right style="border-bottom:0px;border-top:1px solid #2C2B29; font-size:12px" bgcolor="#f6f8f9">
											主要媒体										</TD>
										<TD colspan="3" style="border-top:1px solid #2C2B29;border-bottom:0px; font-size:12px;border-right:0px">
											<INPUT id="ZYMT" style="WIDTH:100%; font-size:12px" name="zymt">										</TD>
									</TR>

									<TR style="DISPLAY: none" id="qtway" colspan="3">
										<TD align=right style="border-bottom:0px; font-size:12px" bgcolor="#f6f8f9">
											其他方式										</TD>
										<TD colspan="3" style="border-top:1px solid #2C2B29;border-bottom:0px; font-size:12px;border-right:0px">
											<INPUT id="QTFS" style="WIDTH:100%; font-size:12px" name="qtfs">										</TD>
									</TR>
									<TR id="pznumber" style="DISPLAY: none" colspan="3">
										<TD id="pznumber" style="HEIGHT: 24px; border-bottom:0px; font-size:12px" align=right bgcolor="#f6f8f9">
											凭证号										</TD>
										<TD  colspan="3" style="HEIGHT: 24px;border-top:1px solid #2C2B29;border-bottom:0px; font-size:12px;border-right:0px">
											<INPUT id="PZH" style="WIDTH:100%;font-size:12px" name="pzh">										</TD>
									</TR>
								</TBODY>
						  </TABLE>						</TD>
					</TR>


					<TR style=" BACKGROUND-COLOR: white;height:25px;">
						<TD  align=right bgcolor="#f6f8f9"> 
							登记部门						</TD>
						<TD style=" border-top:0px">
							<!-- <SPAN dataFld=deptname id=Label1 dataSrc=#XmlDoc></SPAN>  -->
							<input id="DJBM" name="djbm" style="border: 0px" >						</TD>
						<TD style=" border-top:0px" align="right" bgcolor="#f6f8f9"> 
							登记人						</TD>
						<TD style=" border-top:0px" clospan="4">
							<!-- <SPAN dataFld=username id=Label2 dataSrc=#XmlDoc></SPAN> -->
							<input type="text" align="right" style="width:75%; border:0px" id="DJR" name="djr" >						</TD>
					</TR>
					<TR style=" BACKGROUND-COLOR: white;height:25px;">
						<TD align=right bgcolor="#f6f8f9"> 
							登记日期						</TD>
						<TD colspan="3">
							<!-- <input id="startTime" name="TBRQ" class="Wdate"  onClick="WdatePicker()"/> -->
							<input id="DJRQ" name="djrq" style="border:0px" >						</TD>
					</TR>
					<TR style="BACKGROUND-COLOR: white">
						<TD  align=right bgcolor="#f6f8f9">
							备注【<SPAN id="BZNUM" style="COLOR: red">0</SPAN>】</TD>
						<TD vAlign=top align=left colSpan=3>
							<TABLE style="TABLE-LAYOUT: fixed; WORD-WRAP: break-word;border:0px;width:100%" cellSpacing=0 cellPadding=0 >
								<TBODY>
									<TR >
										<!-- style="overflow:visible" -->
										<TD style="border:0px">
											<TEXTAREA id="BZ" onKeyUp="countNum(this); return false;"
												style="WIDTH: 100%; HEIGHT: 48px;" name="bz"></TEXTAREA>										</TD>
									</TR>
								</TBODY>
							</TABLE>						</TD>
					</TR>
					<TR style="BACKGROUND-COLOR: white">
						<TD align=right bgcolor="#f6f8f9">
							<SPAN style="COLOR: red">*</SPAN>问题发生地						</TD>
						<TD colSpan="3">
							<SELECT id="WTFSD1" onChange="jbrdzChange(this)" name="wtfsd1"></SELECT>
							<SELECT id="WTFSD2" onChange="jbrdzChange(this)" name="wtfsd2"></SELECT>
							<SELECT id="WTFSD3" onChange="jbrdzChange(this)" name="wtfsd3"></SELECT>
							<SELECT id="WTFSD4" name="wtfsd4" onChange="jbrdzChange(this)"></SELECT>
							<SELECT id="WTFSD5" name="wtfsd5" onChange="jbrdzChange(this)"></SELECT>
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
							<INPUT id="WTFSD" style="width:50%" type="text" name="wtfsd7"><br>
							<SPAN style="COLOR: red" onclick="show_hidden('mapbox');"><U>地图</U></SPAN>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<label style="width:30px">坐标:</label> <INPUT id="YZBM" style="width:20%" name="yzbm" >
								<label style="width:45px" align="right">阐述:</label> <INPUT id="chanshu" type="text" style="WIDTH:50 %; font-size:12px" name="lxdh" >
						
					</TR>
					<TR style=" BACKGROUND-COLOR: white;height:25px;">
						<TD align=right bgcolor="#f6f8f9"> 
							问题发生时间						</TD>
						<TD colSpan=3>
							<input id="WTFSSJ" name="wtfssj" type="text" class="Wdate"
								onClick="WdatePicker()" />
							<!-- <input type="text" name="start" id="start" class="Wdate" onClick="WdatePicker()" /> -->
							<!-- <SELECT id="occurTime" style="WIDTH: 80px" name="occurTime"></SELECT> -->						</TD>
					</TR>

					<TR style="BACKGROUND-COLOR: white;height:25px;">
						<TD id=jubaotd1 align=right bgcolor="#f6f8f9">
							<SPAN style="COLOR: red">*</SPAN>被举报单位						</TD>
						<TD colSpan=3>
							<INPUT dataFld=reflectobject id="BJBDW" style="WIDTH:100%"
								name="bjbdw">						</TD>
					</TR>
					<TR style=" BACKGROUND-COLOR: white;height:25px;">
						<TD align=right bgcolor="#f6f8f9">
							<SPAN style="COLOR: red">*</SPAN>被举报单位级别						</TD>
						<TD colSpan=3>
							<SELECT id="BJBDWJB" style="WIDTH: 238px" name="bjbdwjb">
								<option value=""></option>
								<OPTION value="省级">
									省级								</OPTION>
								<OPTION value="地级">
									地级								</OPTION>
								<OPTION value="县级">
									县级								</OPTION>
								<OPTION value="乡（镇）">
									乡（镇）								</OPTION>
								<OPTION value="村（组）集体">
									村（组）集体								</OPTION>
								<OPTION value="企事业单位">
									企事业单位								</OPTION>
								<OPTION value="个人">
									个人								</OPTION>
							</SELECT>						</TD>
					</TR>

					<TR style="BACKGROUND-COLOR: white">
						<TD vAlign=middle align=right bgcolor="#f6f8f9">
							<SPAN style="COLOR: red">*</SPAN>线索摘要【<SPAN id="XSZYNUM" style="COLOR: red">0</SPAN>】<br> 
					  （请写清基本违法事实）						</TD>
						<TD vAlign=top align=left colSpan=3>
							<TABLE style="TABLE-LAYOUT: fixed; WORD-WRAP: break-word;border:0px" cellSpacing=0 cellPadding=0 width="100%" >
								<TBODY>
									<TR>
										<!-- style="overflow:visible" -->
										<TD style="border:0px">
											<TEXTAREA id="XSZY" onKeyUp="countNum(this); return false;"
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
								<option value=""></option>
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


			<TABLE id=table2 class="tableBorder"
				style="font-size:12px;DISPLAY: none; WIDTH: 95%; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: #000000;"
				cellSpacing="0" cellPadding="0" align=center border=0>
				<tbody>
					<TR style="HEIGHT: 30px">
						<TD style="BACKGROUND-COLOR: #99ccff;font-size:12px" colSpan=4>
							<STRONG>办理情况</STRONG>
						<br><br></TD>
					</TR>

					<TR  style="HEIGHT: 30px; BACKGROUND-COLOR: white; font-size:12px">
						<TD colSpan="4">
							<FIELDSET id="SLarea" style="WIDTH: 100%">
								<LEGEND>
									受理区
								</LEGEND>

								<TABLE borderColor="black" cellSpacing="0" class="tableBorder"
									borderColorDark="silver" cellPadding="0" width="100%"
									align="center">
									<tbody>
										<TR style="DISPLAY: block; HEIGHT: 30px; BACKGROUND-COLOR: white; border-left:1px">
											<TD align=right bgcolor="#f6f8f9" style="WIDTH: 19%; HEIGHT: 25px; font-size:12px">
												<SPAN style="COLOR: red">*</SPAN>违法类型
											<br></TD>

											<TD style="font-size:12px"> 
												<INPUT id="TDWF" onClick="LawlessClueClassChange(this)"
													type=checkbox value="1" name="wflx">
												<LABEL for="TDWF">
													土地违法
												</LABEL>
												&nbsp;&nbsp;&nbsp;&nbsp;
												<INPUT id="KCWF" onClick="LawlessClueClassChange(this)"
													type=checkbox value="2" name="wflx">
												<LABEL for="KCWF">
													矿产违法
												</LABEL>
												<SPAN>&nbsp;→&nbsp;</SPAN>
												<SELECT id="WFLXXX" style="WIDTH: 238px" name="wflxxx"></SELECT>
											<br></TD>
										</TR>

										<TR id="WFXS"
											style="DISPLAY: block; HEIGHT: 30px; BACKGROUND-COLOR: white; font-size:12px">
											<TD bgcolor="#f6f8f9" align=right>
												违法线索编号
											<br></TD>
											<TD>
												<INPUT id="WFXSBH" name="wfxsbh"  style="WIDTH: 238px;border:0px; font-size:12px">
												&nbsp;&nbsp;
												<SPAN style="COLOR: red; font-size:12px">当线索为违法线索后，系统自动生成违法线索编号</SPAN>
											<br></TD>
										</TR>
									</tbody>
								</TABLE>
							</FIELDSET>
							<FIELDSET id="BLQ1"  style="DISPLAY: none; WIDTH: 100%">
								<LEGEND>
									部级办理区
								</LEGEND>
								<TABLE borderColor="black" cellSpacing="0" class="tableBorder"
									borderColorDark="silver" cellPadding="0" width="100%"
									align="center">
									<tbody>
										<TR style="font-size:12px;DISPLAY: block; HEIGHT: 25px; BACKGROUND-COLOR: white">
											<TD bgcolor="#f6f8f9" style="WIDTH: 19%;" align=right>
												<SPAN style="COLOR: red">*</SPAN>建议办理方式
											</TD>
											<TD colSpan=3>
												<INPUT id="ZJZB1" name="blfs1" onClick="BLclick(this)"
													type="checkbox" value="1">
												<LABEL for="ZJZB1">
													直接转办
												</LABEL>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<INPUT id="ZDWFAJ1" name="blfs1" onClick="BLclick(this)"
													type="checkbox" value="2">
												<LABEL for="ZDWFAJ1">
													建议作为重大违法案件线索
												</LABEL>
												&nbsp;&nbsp;
											</TD>
										</TR>

										<TR id="ZBpart1" style="DISPLAY: block; height:25px; BACKGROUND-COLOR: white; font-size:12px">
											<TD bgcolor="#f6f8f9" align=right>
												<SPAN style="COLOR: red">*</SPAN>转办单位
											</TD>
											<TD style="WIDTH: 33%;">
												<input id="ZBDW1" style="border:0px;"  name="zbdw1" type="text">
												
											</TD>

											<TD bgcolor="#f6f8f9" style="width:19%" align=right>
												<SPAN style="COLOR: red">*</SPAN>转办人
											</TD>

											<TD style="WIDTH: 33%;">
												<input id="ZBR1" style="border:0px;"  name="zbr1" type="text">
											
											</TD>
										</TR>

										<TR id="ZBtime1" style="DISPLAY: block; HEIGHT: 25px; BACKGROUND-COLOR: white; font-size:12px">
											<TD bgcolor="#f6f8f9" align=right>
												<SPAN style="COLOR: red">*</SPAN>转办时间
											</TD>
											<TD>
												<input style="border:0px;"  type="text" id="ZBSJ1" name="zbsj1">
									
											</TD>

											<TD bgcolor="#f6f8f9" align=right>
												<SPAN style="COLOR: red">*</SPAN>要求反馈日期
											</TD>

											<TD>
												<input style="border:0px;"  type="text" id="YQFKRQ1" name="yqfkrq1">
										
											</TD>
										</TR>

										<tr style=" BACKGROUND-COLOR: white; font-size:12px">
											<td bgcolor="#f6f8f9" align=right>
												<SPAN style="COLOR: red">*</SPAN>审批意见
											</td>

											<td colSpan="3">
												<TEXTAREA id="SPYJ1" style="WIDTH: 98%; HEIGHT: 48px"
													name="spyj1" cols=42></TEXTAREA>
											</td>
										</tr>
									</tbody>
								</TABLE>
							</FIELDSET>

							<FIELDSET id="BLQ2" style="DISPLAY: none; WIDTH: 100%">
								<LEGEND>
									省级办理区
								</LEGEND>
								<TABLE borderColor="black" cellSpacing="0" class="tableBorder"
									borderColorDark="silver" cellPadding="0" width="100%"
									align="center" >
									<tbody>
										<TR style="font-size:12px;DISPLAY: block; HEIGHT: 30px; BACKGROUND-COLOR: white">
											<TD bgcolor="#f6f8f9" style="WIDTH: 19%; HEIGHT: 25px" align=right>
												<SPAN style="COLOR: red">*</SPAN>建议办理方式
											</TD>
											<TD style="HEIGHT: 25px;font-size:12px" colSpan=3>
												<INPUT id="ZJZB2" name="blfs2"  onClick="BLclick(this)"
													type=checkbox value=1>
												<LABEL for="ZJZB2">
													直接转办
												</LABEL>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<INPUT id="ZDWFAJ2" name="blfs2" onClick="BLclick(this)"
													type=checkbox value=2>
												<LABEL for="ZDWFAJ2">
													建议作为重大违法案件线索
												</LABEL>
												&nbsp;&nbsp;
											</TD>
										</TR>

										<TR id="ZBpart1" style="DISPLAY: block; HEIGHT: 25px; BACKGROUND-COLOR: white;font-size:12px">
											<TD bgcolor="#f6f8f9" style="HEIGHT: 25px" align=right>
												<SPAN style="COLOR: red">*</SPAN>转办单位
											</TD>
											<TD style="WIDTH: 33%; HEIGHT: 25px">
												<input style="border:0px;"  id="ZBDW2" name="zbdw2">							
											</TD>

											<TD bgcolor="#f6f8f9" style="HEIGHT: 25px; width:19%" align=right>
												<SPAN style="COLOR: red">*</SPAN>转办人
											</TD>

											<TD style="WIDTH: 33%; HEIGHT: 25px">
												<input style="border:0px;"  id="ZBR2" name="zbr2">
											</TD>
										</TR>

										<TR id="ZBtime2"
											style="DISPLAY: block; HEIGHT: 25px; BACKGROUND-COLOR: white;font-size:12px">
											<TD bgcolor="#f6f8f9" style="HEIGHT: 25px" align=right>
												<SPAN style="COLOR: red">*</SPAN>转办时间
											</TD>
											<TD style="HEIGHT: 25px">
												<input style="border:0px;" id="ZBSJ2" name="zbsj2">
											</TD>

											<TD bgcolor="#f6f8f9" style="HEIGHT: 25px" align=right>
												<SPAN style="COLOR: red">*</SPAN>要求反馈日期
											</TD>

											<TD style="HEIGHT: 25px">
												<input style="border:0px;" id="YQFKRQ2" name="yqfkrq2">
											</TD>
										</TR>

										<tr style="HEIGHT: 25px; BACKGROUND-COLOR: white;font-size:12px">
											<td bgcolor="#f6f8f9" align=right>
												<SPAN style="COLOR: red">*</SPAN>审批意见
											</td>

											<td colSpan="3">
												<TEXTAREA id="SPYJ2" style="WIDTH: 98%; HEIGHT: 48px"
													name="spyj2" cols=42></TEXTAREA>
											</td>
										</tr>
									</tbody>
								</TABLE>
							</FIELDSET>

							<FIELDSET id="BLQ3" style="DISPLAY: none; WIDTH: 100%">
								<LEGEND>
									市级办理区
								</LEGEND>
								<TABLE borderColor="black" cellSpacing="0" class="tableBorder"
									borderColorDark="silver" cellPadding="0" width="100%"
									align="center" >
									<tbody>
										<TR style="font-size:12px;DISPLAY: block; HEIGHT: 30px; BACKGROUND-COLOR: white">
											<TD bgcolor="#f6f8f9" style="WIDTH: 19%; HEIGHT: 25px" align=right>
												<SPAN style="COLOR: red">*</SPAN>建议办理方式
											</TD>
											<TD style="HEIGHT: 25px;font-size:12px" colSpan=3>
												<INPUT id="ZJZB3" name="blfs3" onClick="BLclick(this)"
													type=checkbox value=1>
												<LABEL for="ZJZB3">
													直接转办
												</LABEL>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<INPUT id="ZDWFAJ3" name="blfs3" onClick="BLclick(this)"
													type=checkbox value=2>
												<LABEL for="ZDWFAJ3">
													建议作为重大违法案件线索
												</LABEL>
												&nbsp;&nbsp;
											</TD>
										</TR>

										<TR id="ZBpart1"
											style="DISPLAY: block; HEIGHT: 30px; BACKGROUND-COLOR: white;font-size:12px">
											<TD bgcolor="#f6f8f9" style="HEIGHT: 25px" align=right>
												<SPAN style="COLOR: red">*</SPAN>转办单位
											</TD>
											<TD style="WIDTH: 33%; HEIGHT: 25px">
												<input style="border:0px;" readOnly id="ZBDW3" name="zbdw3">
											</TD>

											<TD bgcolor="#f6f8f9" style="HEIGHT: 25px; width:19%" align=right>
												<SPAN style="COLOR: red">*</SPAN>转办人
											</TD>

											<TD style="WIDTH: 33%; HEIGHT: 25px">
												<input style="border:0px;" readOnly id="ZBR3" name="zbr3">
											</TD>
										</TR>

										<TR id="ZBtime2"
											style="DISPLAY: block; HEIGHT: 30px; BACKGROUND-COLOR: white;font-size:12px">
											<TD bgcolor="#f6f8f9" style="HEIGHT: 25px" align=right>
												<SPAN style="COLOR: red">*</SPAN>转办时间
											</TD>
											<TD style="HEIGHT: 25px">
												<input style="border:0px;" readOnly id="ZBSJ3" name="zbsj3">
											
											</TD>

											<TD bgcolor="#f6f8f9" style="HEIGHT: 25px" align=right>
												<SPAN style="COLOR: red">*</SPAN>要求反馈日期
											</TD>

											<TD style="HEIGHT: 25px">
												<input style="border:0px;" readOnly id="YQFKRQ3" name="yqfkrq3">
							
											</TD>
										</TR>

										<tr style="HEIGHT: 25px; BACKGROUND-COLOR: white;font-size:12px">
											<td bgcolor="#f6f8f9" align=right>
												<SPAN style="COLOR: red">*</SPAN>审批意见
											</td>

											<td colSpan="3">
												<TEXTAREA id="SPYJ3" style="WIDTH: 98%; HEIGHT: 48px;"
													name="spyj3" cols=42></TEXTAREA>
											</td>
										</tr>
									</tbody>
								</TABLE>
							</FIELDSET>

							<FIELDSET id="BJQ" style="DISPLAY: block; WIDTH: 100%">
								<LEGEND>
									办结区
								</LEGEND>

								<TABLE borderColor=black cellSpacing=0 borderColorDark=silver class="tableBorder"
									cellPadding=0 width="100%" align=center >
									<TR style="font-size:12px;HEIGHT: 30px; BACKGROUND-COLOR: white">
										<TD bgcolor="#f6f8f9" style="WIDTH: 17%" align=right>
											<SPAN style="COLOR: red">*</SPAN>反映情况调查
										</TD>

										<TD style="font-size:12px;width:33%">
											<DIV>
												<INPUT id="JBSS" onClick="dcqk(this)" type="checkbox"
													value="1" name="fyqkdc">
												<LABEL for="JBSS">
													基本属实
												</LABEL>
												&nbsp;&nbsp;
												<INPUT id="BFSS" onClick="dcqk(this)" type="checkbox"
													value="2" name="fyqkdc">
												<LABEL for="BFSS">
													部分属实
												</LABEL>
												&nbsp;&nbsp;
												<INPUT id="JBBSS" onClick="dcqk(this)" type="checkbox"
													value="3" name="fyqkdc">
												<LABEL for="JBBSS">
													基本不属实
												</LABEL>
											</DIV>
										</TD>
										<td align=right bgcolor="#f6f8f9" style="width:19%">
												是否立案
										</td>
										<TD style="font-size:12px">
											<DIV>
											
												<INPUT id="YES" onClick="LiAnClick(this)" name="sfla"
													type="checkbox" value="1">
												<LABEL for="YES">
													是
												</LABEL>
												&nbsp;&nbsp;
												<INPUT id="NO" onClick="LiAnClick(this)" name="sfla"
													type="checkbox" value="0">
												<LABEL for="NO">
													否
												</LABEL>
											</DIV>
										</TD>
									</TR>

									<TR id="EndCase" style="font-size:12px;HEIGHT: 30px; BACKGROUND-COLOR: white">
										<TD style="WIDTH: 19%" align=right>&nbsp;
											
										</TD>
										<TD style="WIDTH: 250px">
											<INPUT id="BJ" name="bj" value="1" type=checkbox onClick="clickBJ(this)">
											<LABEL for="BJ">
												办结
											</LABEL>
										</TD>

										<TD style="WIDTH: 19%;" align=right bgcolor="#f6f8f9">
											<SPAN style="COLOR: red">*</SPAN>办结日期
										</TD>
										<TD  vAlign=center colspan="2">
											<input id="BJRQ" name="bjrq" type="text" class="Wdate"
												onClick="WdatePicker()" />
										</TD>
									</TR>
									<TR id=EndCaseTR2 style="font-size:12px;HEIGHT: 30px; BACKGROUND-COLOR: white">
										<TD style="WIDTH: 19%"  align=right bgcolor="#f6f8f9">
											办结备注【
											<SPAN id="BJBZNUM" style="COLOR: red">0</SPAN>】
										</TD>

										<td colSpan="3">
											<TEXTAREA id="BJBZ" onKeyUp="countNum(this); return false;"
												style="WIDTH: 98%; HEIGHT: 48px;" name="bjbz" cols=42></TEXTAREA>
										</td>
									</TR>
								</TABLE>
							</FIELDSET>
						</TD>
					</TR>
				</tbody>
			</TABLE>

			<TABLE id=ZhiFaJuTR2 style="DISPLAY: block; WIDTH: 100%" border=0>
				<!--信息办理到时候使用-->
				<TBODY>
					<TR>
						<TD align=middle style="border-width:0">
							<INPUT class="button" id="Tstorage" onClick="save(this, '0')"
								type="button" value="暂存">
							&nbsp;&nbsp;
							<INPUT class=button id="AUpload" onClick="AttachUpload()"
								type=button value="附件管理">
							<!-- 不用实现12336四级联动时，不用以下按钮
							&nbsp;&nbsp;
							<INPUT class=button id="xiayibu" onClick="OpenLawlessClueRepeatedWindow('1');" type=button value="下一页">
							<INPUT class=button style="display:none" id="shangyibu" onClick="upTable();" type=button value="上一页">
							-->
							&nbsp;&nbsp;
							<INPUT class=button onClick="print();" type=button value="打印">
							&nbsp;&nbsp;
							<INPUT class=button onClick="save(this,'1')" type=button value="保存">
							<!-- 不用实现12336四级联动时，不用以下按钮
							&nbsp;&nbsp;
							<INPUT class=button style="DISPLAY: none;" name="tuihui" id="tuihui"
								onclick="goback(); " type=button value="退回">
							 -->
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			<input id="flag" name="isrecord" type="text" style="DISPLAY: none">
			<input id="department" name="department" type="text" style="DISPLAY: none">
			<input id="province" name="province" type="text" style="DISPLAY: none">
			<input id="city" name="city" type="text" style="DISPLAY: none">
			<input id="county" name="county" type="text" style="DISPLAY: none">
			<input id="zhuangtai" name="zhuangtai" type="text" style="DISPLAY: none">
			
	</body>
	<script type="text/javascript">
	<%
		String msg = request.getParameter("msg");
	%>
	if("<%=msg%>" == "success"){
		//alert("表单保存成功");
	}

	</script>
</html>
