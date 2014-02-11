<%@page language="java" pageEncoding="utf-8"%>
<%@page import="com.klspta.web.xuzhouNW.dtxc.DtxcManager"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.base.util.bean.xzqhutil.XzqhBean"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	Object principalUser = SecurityContextHolder.getContext()
			.getAuthentication().getPrincipal();
	User userBean = ((User)principalUser);//得到用户bean
	
	XzqhBean xzqhBean = null;
	String strXcdw = "";//巡查单位
	String strXcdwjc = "";//政区简称
	String writerId = userBean.getUserID();//填表人userid
	String writerXzqh = userBean.getXzqh();//填表人行政区划
	String writerName = userBean.getFullName();//填表人全名
	if(!writerXzqh.equals("")){
		xzqhBean = UtilFactory.getXzqhUtil().getBeanById(writerXzqh);
		strXcdw = xzqhBean.getLandname();//巡查单位
		strXcdwjc = xzqhBean.getCatonsimpleName();//政区简称
	}
	String strDate = UtilFactory.getDateUtil().getCurrentChineseDate();//中国式的时间####年##月##日
	
	String yw_guid = request.getParameter("yw_guid");
	DtxcManager dm = new DtxcManager();
	String[] stateCgd = dm.stateCgd(yw_guid);
	String num = "0";
	String keyWord = "";
	String returnPath = "";
	String user = userBean.getUserID();
	//
	String isView = request.getParameter("isView");
	if("false".equals(isView)){
		num = request.getParameter("num");
		keyWord = request.getParameter("choseWord");
		if(keyWord!=null){
			keyWord=UtilFactory.getStrUtil().unescape(keyWord);
		}
		returnPath = request.getParameter("returnPath");
	
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=basePath%>" />
			<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
		<TITLE>巡查日志</TITLE>
		<link rel="stylesheet" href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
		<%@ include file="/base/include/formbase.jspf"%>
		<script>
		//抄告单编号
		var cgdbh = "";
		//用来计数抄告单,0表示抄告单隐藏，1表示抄告单显示
		var count = new Array(0,0,0,0,0);
		var countFlag = 0;
		
		//全部tr标签元素
		var arr = document.getElementsByTagName("tr");
		
		//初始化xcrz表单
		function initxcrz(){
			init();
			show();
			//判断此日志是否有巡查成果
			isHaveCG();
		}
		
		function isHaveCG(){
			putClientCommond("dtxcManager","isHaveCG");
			putRestParameter("yw_guid","<%=yw_guid%>");
      		var res = restRequest();
			if(res=='0'){
				document.getElementById('viewCgButton').style.display="none";
			}
		}
		
		//用于控制初始化时页面显示控制
		function show(){
			var checkCgd1 = document.getElementById("jsxm1").value + document.getElementById("jsdw1").value + document.getElementById("dgsj1").value +
							document.getElementById("jsqk1").value + document.getElementById("zdmj1").value + document.getElementById("zdwz1").value + 
							document.getElementById("townname1").value + document.getElementById("countyname1").value;
			var checkCgd2 = document.getElementById("jsxm2").value + document.getElementById("jsdw2").value + document.getElementById("dgsj2").value +
							document.getElementById("jsqk2").value + document.getElementById("zdmj2").value + document.getElementById("zdwz2").value + 
							document.getElementById("townname2").value + document.getElementById("countyname2").value;;
			var checkCgd3 = document.getElementById("jsxm3").value + document.getElementById("jsdw3").value + document.getElementById("dgsj3").value +
							document.getElementById("jsqk3").value + document.getElementById("zdmj3").value + document.getElementById("zdwz3").value + 
							document.getElementById("townname3").value + document.getElementById("countyname3").value;;
			var checkCgd4 = document.getElementById("jsxm4").value + document.getElementById("jsdw4").value + document.getElementById("dgsj4").value +
							document.getElementById("jsqk4").value + document.getElementById("zdmj4").value + document.getElementById("zdwz4").value + 
							document.getElementById("townname4").value + document.getElementById("countyname4").value;;
			var checkCgd5 = document.getElementById("jsxm5").value + document.getElementById("jsdw5").value + document.getElementById("dgsj5").value +
							document.getElementById("jsqk5").value + document.getElementById("zdmj5").value + document.getElementById("zdwz5").value + 
							document.getElementById("townname5").value + document.getElementById("countyname5").value;;
			if(checkCgd1 != ""){
				for(var i = 0; i < arr.length ; i++){
					if(arr[i].name == "check1"){
						arr[i].style.display = "block";
					}
				}
				count[0] = 1;//维护count
				countFlag++;
			}
			if(checkCgd2 != ""){
				for(var i = 0; i < arr.length ; i++){
					if(arr[i].name == "check2"){
						arr[i].style.display = "block";
					}
				}
				count[1] = 1;//维护count
				countFlag++;
			}
			if(checkCgd3 != ""){
				for(var i = 0; i < arr.length ; i++){
					if(arr[i].name == "check3"){
						arr[i].style.display = "block";
					}
				}
				count[2] = 1;//维护count
				countFlag++;
			}
			if(checkCgd4 != ""){
				for(var i = 0; i < arr.length ; i++){
					if(arr[i].name == "check4"){
						arr[i].style.display = "block";
					}
				}
				count[3] = 1;//维护count
				countFlag++;
			}
			if(checkCgd5 != ""){
				for(var i = 0; i < arr.length ; i++){
					if(arr[i].name == "check5"){
						arr[i].style.display = "block";
					}
				}
				count[4] = 1;//维护count
				countFlag++;
			}
		}
		
		//是否违法按钮的选择
		function selectwf(sele){
			var add = document.getElementById("add");
			var del = document.getElementById("del");
			if(sele.value == '是'){
				add.style.display = "";
				del.style.display = "";
			}
			if(sele.value == '否'){
				add.style.display = "none";
				del.style.display = "none";
			}
		}
		
		//添加抄告单
		function addcgd(){
			if(countFlag == 5){
				alert("一个巡查日志最多添加5个抄告单！");
				return;
			}
			//第一个抄告单
			if(count[0] == 0){
				for(var i = 0; i < arr.length ; i++){
					if(arr[i].name == "check1"){
						arr[i].style.display = "block";
					}
				}
				count[0] = 1;//维护count
				countFlag++;
				return;
			}
			//第二个抄告单
			if(count[1] == 0){
				for(var i = 0; i < arr.length ; i++){
					if(arr[i].name == "check2"){
						arr[i].style.display = "block";
					}
				}
				count[1] = 1;//维护count
				countFlag++;
				return;
			}
			//第三个抄告单
			if(count[2] == 0){
				for(var i = 0; i < arr.length ; i++){
					if(arr[i].name == "check3"){
						arr[i].style.display = "block";
					}
				}
				count[2] = 1;//维护count
				countFlag++;
				return;
			}
			//第四个抄告单
			if(count[3] == 0){
				for(var i = 0; i < arr.length ; i++){
					if(arr[i].name == "check4"){
						arr[i].style.display = "block";
					}
				}
				count[3] = 1;//维护count
				countFlag++;
				return;
			}
			//第五个抄告单
			if(count[4] == 0){
				for(var i = 0; i < arr.length ; i++){
					if(arr[i].name == "check5"){
						arr[i].style.display = "block";
					}
				}
				count[4] = 1;//维护count
				countFlag++;
				return;
			}
		}
		
		//删除抄告单(控制标签的隐藏)
		var k = 0;
		function deletecgd(){
			var checkbox = document.getElementsByName("checkbox");
			for(var i = 0; i < checkbox.length ; i++){
				if(checkbox[i].checked == true){
					var temp = checkbox[i].id;
					for(var j = 0; j < arr.length ; j++){
						if(arr[j].name == temp){
							arr[j].style.display = "none";
							if(k == 4){ //这里对应5个tr标签 
								//截取到表示抄告单位置的数字
								var tempNum = new Number(temp.charAt(5));
								//将相应位置修改状态
								count[tempNum-1] = 0;
								countFlag--;
								deletedata(tempNum);
								k = 0;
							}
							k ++;
						}
					}
				}
			}
		}
		
		//删除表单数据(删除页面、数据库中相对应得数据，修改状态)
		function deletedata(tenum){
			for(var i = 0; i < 5; i++){
				if(tenum == i){
					document.getElementById("jsxm" + i).value = "";
					document.getElementById("jsdw" + i).value = "";
					document.getElementById("dgsj" + i).value = "";
					document.getElementById("jsqk" + i).value = "";
					document.getElementById("zdmj" + i).value = "";
					document.getElementById("zdwz" + i).value = "";
					document.getElementById("townname" + i).value = "";
					document.getElementById("countyname" + i).value = "";
				}
			}
			putClientCommond("dtxcManager","deleteCgd");
			putRestParameter("yw_guid","<%=yw_guid%>");
      		putRestParameter("strFlag",tenum);
      		restRequest();
      		//页面中显示的相关操作
      		document.getElementById("divcgd" + tenum).innerHTML = "<span style='color:red'>抄告单未生成</span>&nbsp;&nbsp;&nbsp;&nbsp;"+
      																"<a href='javascript:void(0);' id='cgd"+tenum+"' "+
      																"onclick='createCgd(this.id)' style='text-decoration:none'>生成抄告单</a>";
      		document.getElementById("check" + tenum).checked = "";
		}
		
		//保存表单方法
		function save(){
			document.forms[0].submit();
		}
		
		//抄告单在wbeoffice中生成
		function createCgd(createId){
			isshowSave=false;
			var tempNum = createId.charAt(3); 
			var jsxm = document.getElementById("jsxm" + tempNum).value;
			var jsdw = document.getElementById("jsdw" + tempNum).value;
			var dgsj = document.getElementById("dgsj" + tempNum).value;
			var jsqk = document.getElementById("jsqk" + tempNum).value;
			var zdmj = document.getElementById("zdmj" + tempNum).value;
			var zdwz = document.getElementById("zdwz" + tempNum).value;
			var townname = document.getElementById("townname" + tempNum).value;
			var countyname = document.getElementById("countyname" + tempNum).value;
			if(jsxm == "" || jsdw == "" || dgsj =="" || jsqk== "" || zdmj == "" ||zdwz == ""|| townname == "" ||countyname == ""){
				alert("信息不完整，不能生成抄告单。请将信息填写完整！！");
				return;
			}
			putClientCommond("dtxcManager","saveCgd");
			putRestParameter("yw_guid","<%=yw_guid%>");
      		putRestParameter("strFlag",createId);
      		putRestParameter("jsxm",escape(escape(jsxm)));
      		putRestParameter("jsdw",escape(escape(jsdw)));
      		putRestParameter("dgsj",escape(escape(dgsj)));
      		putRestParameter("jsqk",escape(escape(jsqk)));
      		putRestParameter("zdmj",escape(escape(zdmj)));
      		putRestParameter("zdwz",escape(escape(zdwz)));
      		putRestParameter("townname",escape(escape(townname)));
      		putRestParameter("countyname",escape(escape(countyname)));
      		var cgdState = restRequest();
      		if(cgdState == "1"){
      			if(confirm('原抄告单将被替换，是否重新生成抄告单！！')){
					
				}else{
					return;
				}
      		}
      		
			//巡查单位
			var xcdw = document.getElementById("xcdw").value;
			var yw_guid = "<%=yw_guid%>";
			var flag = true;
			//获得抄告单编号
			putClientCommond("dtxcManager","buildCgdbh");
			putRestParameter("yw_guid","<%=yw_guid%>");
			putRestParameter("cgdid",createId);
			cgdbh = restRequest();
			//12个需要在抄告单.doc上面使用的参数
			var subofficename = "subofficename=" + encodeURI(encodeURI("<%=strXcdwjc%>"));
			var number = "&number="+cgdbh;
			var districtname = "&districtname=" + encodeURI(encodeURI("<%=strXcdwjc%>"));
			var vartownname = "&townname="+encodeURI(encodeURI(townname));
			var varcountyname = "&countyname="+encodeURI(encodeURI(countyname));
			var projectname = "&projectname="+encodeURI(encodeURI(jsxm));
			var location = "&location="+encodeURI(encodeURI(zdwz));
			var area = "&area="+encodeURI(encodeURI(zdmj));
			var buildYear = "&buildYear="+dgsj.substring(0,4);
			var buildMonth  = "&buildMonth="+dgsj.substring(5,7);
			var Date = "&Date=" + encodeURI(encodeURI("<%=strDate%>"));
			var district = "&district=" + encodeURI(encodeURI("<%=strXcdwjc%>"));
			//yw_guid等参数
			var strId = "&yw_guid="+yw_guid+"&file_id="+createId+"&flag="+flag;
			//拼接参数
			var strData = subofficename + number + districtname + 
							vartownname + varcountyname + projectname + 
							location + area + buildYear + 
							buildMonth + Date +  district;
			var strUrl = strData + strId;
			//打开抄告单
			window.open("../webOffice/webOfficeMain.jsp?"+strUrl);
			
			document.getElementById("div" + createId).innerHTML = "<a href='javascript:void(0);' id='span"+createId+"' onclick='lookCgd(this.id)' style='text-decoration:none'>查看抄告单</a>&nbsp;&nbsp;&nbsp;&nbsp;"+
																	"<a href='javascript:void(0);' id='"+createId+"' onclick='createCgd(this.id)' style='text-decoration:none'>重新生成抄告单</a>";
			//保存抄告单编号
			putClientCommond("dtxcManager","saveCgdbh");
			putRestParameter("yw_guid","<%=yw_guid%>");
			putRestParameter("cgdid",createId);
      		putRestParameter("cgdbh",escape(escape(cgdbh)));
      		putRestParameter("userid","<%=writerId %>");
			restRequest();
		}
		
		//查看已经生成过的抄告单
		function lookCgd(lookId){
			isshowSave=false;
			var strLookId = lookId.substring(4);
			var yw_guid = "<%=yw_guid%>";
			var flag = false;
			var strUrl = "yw_guid="+yw_guid+"&file_id="+strLookId+"&flag="+flag;
			window.open("../webOffice/webOfficeMain.jsp?"+strUrl);
		}
		
		function toreturn(){
			document.location.href="<%=basePath%><%=returnPath%>";
		}
		
		function toNext(){
			putClientCommond("dtxcManager","getNextXcrz");
			putRestParameter("num","<%=num%>");
			putRestParameter("userId","<%=user%>");
      		putRestParameter("keyWord",escape(escape("<%=keyWord%>")));
			var result = restRequest();
			if(result == "error"){
				alert("当前页已是最后一条");
				return ; 
			}
			document.location.href="<%=basePath%>/web/xuzhouNW/dtxc/xcrz/xcrz.jsp?jdbcname=YWTemplate&yw_guid=" + result + "&isView=false&num=<%=(Integer.parseInt(num)+1)%>&keyWord="+escape(escape("<%=keyWord%>"))+"&returnPath=web/xuzhouNW/dtxc/xcrz/xcrzList.jsp"; 
		
		}
		function toPre(){
			if("<%=num%>" == "0"){
				alert("当前页是第一条，无法获取前一条");
				return;
			}
			putClientCommond("dtxcManager","getPreXcrz");
			putRestParameter("num","<%=num%>");
			putRestParameter("userId","<%=user%>");
      		putRestParameter("keyWord",escape(escape("<%=keyWord%>")));
			var result = restRequest();
			document.location.href="<%=basePath%>/web/xuzhouNW/dtxc/xcrz/xcrz.jsp?jdbcname=YWTemplate&yw_guid=" + result + "&isView=false&num=<%=(Integer.parseInt(num)-1)%>&keyWord="+escape(escape("<%=keyWord%>"))+"&returnPath=web/xuzhouNW/dtxc/xcrz/xcrzList.jsp"; 
		}
		
		</script>
	</head>

	<body bgcolor="#FFFFFF">
		<!-- 用来放置保存、打印按钮图标(如果是市局人员将保存按钮隐藏) -->
		<%if(writerXzqh.substring(4).equals("00")){ %>
		<%}else{ %>
			<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
		<%} %>
		<%if("false".equals(isView)){ %>
		<div align="right" style="margin-top:15px;margin-right:20px;">
			<input type="button" value="返回"  onclick="toreturn();return false;"/>&nbsp;&nbsp;&nbsp;
			<%if(!"0".equals(num)){%>
				<input type="button" value="上一条" onclick="toPre();return false;"/>&nbsp;&nbsp;&nbsp;
			<%}%>
			<input type="button" value="下一条" onclick="toNext();return false;"/>
		</div>
		<% }%>
		<div style="margin: 20px" align="center">
			<div align="center">
				<h1>
					国土资源执法监察巡查日志
				</h1>
			</div>
			<form method="post">
				<div style="width: 100%;">

					<span style="margin-left: 330px;">巡查编号：<input type="text" name="xcbh" id="xcbh" readonly="readonly"
							style="width: 150px; background-color: transparent; border: 0px;"></input>
					</span>
				</div>
				<table id="xcrztable" class="lefttopborder1" cellspacing="0"
					cellpadding="0" border="1" bgcolor="#FFFFFF" bordercolor="#000000"
					width="600">
					<tr>
						<td height="16" colspan="2">
							<div align="center">
								巡查单位
							</div>
						</td>
						<td width="166">
							<input type="text" class="noborder" name="xcdw" id="xcdw" style="width: 97%" value="<%=strXcdw %>" readonly="readonly"/>
						</td>
						<td width="102">
							<div align="center">
								巡查日期
							</div>
						</td>
						<td width="211">
							<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="xcrq"
								id="xcrq" readonly="readonly" style="width: 97%" />
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div align="center">
								巡查区域
							</div>
						</td>
						<td colspan="3">
							<input type="text" class="noborder" name="xcqy" id="xcqy" style="width: 99%" />
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div align="center">
								巡查人员
							</div>
						</td>
						<td colspan="3">
							<input type="text" class="noborder" name="xcry" id="xcry" style="width: 99%" value="<%=writerName %>"/>
						</td>
					</tr>
					<tr>
						<td height="21" colspan="2">
							<div align="center">
								巡查路线
							</div>
						</td>
						<td colspan="3">
							<input type="text" class="noborder" name="xclx" id="xclx" style="width: 99%" />
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div align="center">
								是否有违法
							</div>
						</td>
						<td colspan="3">
							<div align="left">
								&nbsp;&nbsp;
								<input type="radio" name="sfywf" id="sfywf" value="是" onclick="selectwf(this)"/>
								是&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name="sfywf" id="sfywf" value="否" onclick="selectwf(this)"/>
								否&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" id="add" value="增加" onclick="addcgd()" style="display:none;"/>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" id="del" value="删除" onclick="deletecgd()" style="display:none;"/>
							</div>
						</td>
					</tr>
					
					<!-- 
						五个抄告单
					 -->
					<!-- 第一个 -->
					<tr name="check1" style="display:none;">
						<td rowspan="5">
							<div align="center">
								<input type="checkbox" id="check1" name="checkbox"/>
							</div>
						</td>
						<td>
							<div align="center">
								建设项目
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsxm1" id="jsxm1" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								建设单位
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsdw1" id="jsdw1" style="width: 97%" />
						</td>
					</tr>
					<tr name="check1" style="display:none;">
						<td>
							<div align="center">
								动工时间
							</div>
						</td>
						<td>
							<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="dgsj1"
								id="dgsj1" readonly="readonly" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								建设情况
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsqk1" id="jsqk1" style="width: 97%" />
						</td>
					</tr>
					<tr name="check1" style="display:none;">
						<td>
							<div align="center">
								占地面积
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="zdmj1" id="zdmj1" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								占地位置
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="zdwz1" id="zdwz1" style="width: 97%" />
						</td>
					</tr>
					<tr name="check1" style="display:none;">
						<td>
							<div align="center">
								镇(办事处)
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="townname1" id="townname1" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								村辖区
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="countyname1" id="countyname1" style="width: 97%" />
						</td>
					</tr>
					<tr name="check1" style="display:none;">
						<td>
							<div align="center">
								抄告单状态
							</div>
						</td>
						<td colspan="3">
							<div id="divcgd1">
								<%if(stateCgd[0].equals("0")){ %>
									<span style="color:red">抄告单未生成</span>&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="javascript:void(0);" id="cgd1" onclick="createCgd(this.id)" style="text-decoration:none">生成抄告单</a>
								<%}else{ %>
									<a href="javascript:void(0);" id="spancgd1" onclick="lookCgd(this.id)" style="text-decoration:none">查看抄告单</a>&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="javascript:void(0);" id="cgd1" onclick="createCgd(this.id)" style="text-decoration:none">重新生成抄告单</a>
								<%} %>
							</div>
						</td>
					</tr>
					
					<!-- 第二个 -->
					
					<tr name="check2" style="display:none;">
						<td rowspan="5">
							<div align="center">
								<input type="checkbox" id="check2" name="checkbox"/>
							</div>
						</td>
						<td>
							<div align="center">
								建设项目
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsxm2" id="jsxm2" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								建设单位
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsdw2" id="jsdw2" style="width: 97%" />
						</td>
					</tr>
					<tr name="check2" style="display:none;">
						<td>
							<div align="center">
								动工时间
							</div>
						</td>
						<td>
							<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="dgsj2"
								id="dgsj2" readonly="readonly" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								建设情况
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsqk2" id="jsqk2" style="width: 97%" />
						</td>
					</tr>
					<tr name="check2" style="display:none;">
						<td>
							<div align="center">
								占地面积
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="zdmj2" id="zdmj2" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								占地位置
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="zdwz2" id="zdwz2" style="width: 97%" />
						</td>
					</tr>
					<tr name="check2" style="display:none;">
						<td>
							<div align="center">
								镇(办事处)
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="townname2" id="townname2" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								村辖区
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="countyname2" id="countyname2" style="width: 97%" />
						</td>
					</tr>
					<tr name="check2" style="display:none;">
						<td>
							<div align="center">
								抄告单状态
							</div>
						</td>
						<td colspan="3">
							<div id="divcgd2">
								<%if(stateCgd[1].equals("0")){ %>
									<span style="color:red">抄告单未生成</span>&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="javascript:void(0);" id="cgd2" onclick="createCgd(this.id)" style="text-decoration:none">生成抄告单</a>
								<%}else{ %>
									<a href="javascript:void(0);" id="spancgd2" onclick="lookCgd(this.id)" style="text-decoration:none">查看抄告单</a>&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="javascript:void(0);" id="cgd2" onclick="createCgd(this.id)" style="text-decoration:none">重新生成抄告单</a>
								<%} %>
							</div>
						</td>
					</tr>
					
					<!-- 第三个 -->
					
					<tr name="check3" style="display:none;">
						<td rowspan="5">
							<div align="center">
								<input type="checkbox" id="check3" name="checkbox"/>
							</div>
						</td>
						<td>
							<div align="center">
								建设项目
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsxm3" id="jsxm3" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								建设单位
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsdw3" id="jsdw3" style="width: 97%" />
						</td>
					</tr>
					<tr name="check3" style="display:none;">
						<td>
							<div align="center">
								动工时间
							</div>
						</td>
						<td>
							<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="dgsj3"
								id="dgsj3" readonly="readonly" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								建设情况
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsqk3" id="jsqk3" style="width: 97%" />
						</td>
					</tr>
					<tr name="check3" style="display:none;">
						<td>
							<div align="center">
								占地面积
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="zdmj3" id="zdmj3" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								占地位置
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="zdwz3" id="zdwz3" style="width: 97%" />
						</td>
					</tr>
					<tr name="check3" style="display:none;">
						<td>
							<div align="center">
								镇(办事处)
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="townname3" id="townname3" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								村辖区
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="countyname3" id="countyname3" style="width: 97%" />
						</td>
					</tr>
					<tr name="check3" style="display:none;">
						<td>
							<div align="center">
								抄告单状态
							</div>
						</td>
						<td colspan="3">
							<div id="divcgd3">
								<%if(stateCgd[2].equals("0")){ %>
									<span style="color:red">抄告单未生成</span>&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="javascript:void(0);" id="cgd3" onclick="createCgd(this.id)" style="text-decoration:none">生成抄告单</a>
								<%}else{ %>
									<a href="javascript:void(0);" id="spancgd3" onclick="lookCgd(this.id)" style="text-decoration:none">查看抄告单</a>&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="javascript:void(0);" id="cgd3" onclick="createCgd(this.id)" style="text-decoration:none">重新生成抄告单</a>
								<%} %>
							</div>
						</td>
					</tr>
					
					<!-- 第四个 -->
					
					<tr name="check4" style="display:none;">
						<td rowspan="5">
							<div align="center">
								<input type="checkbox" id="check4" name="checkbox"/>
							</div>
						</td>
						<td>
							<div align="center">
								建设项目
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsxm4" id="jsxm4" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								建设单位
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsdw4" id="jsdw4" style="width: 97%" />
						</td>
					</tr>
					<tr name="check4" style="display:none;">
						<td>
							<div align="center">
								动工时间
							</div>
						</td>
						<td>
							<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="dgsj4"
								id="dgsj4" readonly="readonly" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								建设情况
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsqk4" id="jsqk4" style="width: 97%" />
						</td>
					</tr>
					<tr name="check4" style="display:none;">
						<td>
							<div align="center">
								占地面积
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="zdmj4" id="zdmj4" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								占地位置
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="zdwz4" id="zdwz4" style="width: 97%" />
						</td>
					</tr>
					<tr name="check4" style="display:none;">
						<td>
							<div align="center">
								镇(办事处)
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="townname4" id="townname4" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								村辖区
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="countyname4" id="countyname4" style="width: 97%" />
						</td>
					</tr>
					<tr name="check4" style="display:none;">
						<td>
							<div align="center">
								抄告单状态
							</div>
						</td>
						<td colspan="3">
							<div id="divcgd4">
								<%if(stateCgd[3].equals("0")){ %>
									<span style="color:red">抄告单未生成</span>&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="javascript:void(0);" id="cgd4" onclick="createCgd(this.id)" style="text-decoration:none">生成抄告单</a>
								<%}else{ %>
									<a href="javascript:void(0);" id="spancgd4" onclick="lookCgd(this.id)" style="text-decoration:none">查看抄告单</a>&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="javascript:void(0);" id="cgd4" onclick="createCgd(this.id)" style="text-decoration:none">重新生成抄告单</a>
								<%} %>
							</div>
						</td>
					</tr>
					
					<!-- 第五个 -->
					
					<tr name="check5" style="display:none;">
						<td rowspan="5">
							<div align="center">
								<input type="checkbox" id="check5" name="checkbox"/>
							</div>
						</td>
						<td>
							<div align="center">
								建设项目
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsxm5" id="jsxm5" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								建设单位
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsdw5" id="jsdw5" style="width: 97%" />
						</td>
					</tr>
					<tr name="check5" style="display:none;">
						<td>
							<div align="center">
								动工时间
							</div>
						</td>
						<td>
							<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="dgsj5"
								id="dgsj5" readonly="readonly" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								建设情况
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="jsqk5" id="jsqk5" style="width: 97%" />
						</td>
					</tr>
					<tr name="check5" style="display:none;">
						<td>
							<div align="center">
								占地面积
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="zdmj5" id="zdmj5" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								占地位置
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="zdwz5" id="zdwz5" style="width: 97%" />
						</td>
					</tr>
					<tr name="check5" style="display:none;">
						<td>
							<div align="center">
								镇(办事处)
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="townname5" id="townname5" style="width: 97%" />
						</td>
						<td>
							<div align="center">
								村辖区
							</div>
						</td>
						<td>
							<input type="text" class="noborder" name="countyname5" id="countyname5" style="width: 97%" />
						</td>
					</tr>
					<tr name="check5" style="display:none;">
						<td>
							<div align="center">
								抄告单状态
							</div>
						<br /></td>
						<td colspan="3">b
							<div id="divcgd5">
								<%if(stateCgd[4].equals("0")){ %>
									<span style="color:red">抄告单未生成</span>&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="javascript:void(0);" id="cgd5" onclick="createCgd(this.id)" style="text-decoration:none">生成抄告单</a>
								<%}else{ %>
									<a href="javascript:void(0);" id="spancgd5" onclick="lookCgd(this.id)" style="text-decoration:none">查看抄告单</a>&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="javascript:void(0);" id="cgd5" onclick="createCgd(this.id)" style="text-decoration:none">重新生成抄告单</a>
								<%} %>
							</div>
						</td>
					</tr>
					
					<!-- 抄告单部分结束 -->
					
					<tr>
						<td width="40" rowspan="2">
							<p align="center">
								巡
							</p>
							<p align="center">
								查
							</p>
							<p align="center">
								内
							</p>
							<p align="center">
								容
							</p>
						</td>
						<td width="82">
							<div align="center">
								项目
								<br />
								建设
								<br />
								及用
								<br />
								地手
								<br />
								续审
								<br />
								批情
								<br />
								况
							</div>
						</td>
						<td colspan="3">
							<textarea rows="15" name="spqk" id="spqk" style="width: 99%"></textarea>
						</td>
					</tr>

					<tr>
						<td>
							<div align="center">
								对所
								<br />
								建项
								<br />
								目的
								<br />
								处理
								<br />
								意见
								<br />
							</div>
						</td>
						<td colspan="3">
							<textarea rows="10" name="clyj" id="clyj" style="width: 99%"></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div align="center">
								备注
							</div>
						</td>
						<td colspan="3">
							<textarea rows="6" name="bz" id="bz" style="width: 99%"></textarea>
						</td>
					</tr>
				</table>
				<input type="text" value="<%=writerId %>" id="userid" name="userid" style="display: none" />
				<input type="text" value="<%=writerXzqh %>" id="writerxzqh" name="writerxzqh" style="display: none" />
			</form>
		</div>	
		<div id="viewCgButton" style="margin-top:20px;"><button style="cursor:hand;" onclick="viewCG()">点击查看巡查成果</button></div>
	</body>
	<script>
		function viewCG(){
			var yw_guid = "<%=yw_guid%>";
			var height=window.screen.availHeight;
			var width=window.screen.availWidth;
			window.showModalDialog("<%=basePath%>web/xuzhouNW/dtxc/wyxc/xjclyjframe.jsp?zfjcType=13&yw_guid="+yw_guid,obj,"dialogWidth="+width+";dialogHeight="+height);
		}
		
		document.body.onload = initxcrz;
		<%
		String msg = (String)request.getParameter("msg");
		%>
		if("<%=msg%>" == "success"){
			alert("表单保存成功");  
		}
	</script>
</html>