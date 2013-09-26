<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.base.util.bean.xzqhutil.XzqhBean"%>
<%@page import="com.klspta.base.util.UtilFactory"%>
<%@page import="com.klspta.web.jizeNW.dtxc.DtxcManager"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Object principalUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
User userBean = ((User)principalUser);//得到用户bean
XzqhBean xzqhBean = null;
String strXcdwjc = "";//政区简称
String writerId = userBean.getUserID();//填表人userid
String writerXzqh = userBean.getXzqh();//填表人行政区划
if(!writerXzqh.equals("")){
	xzqhBean = UtilFactory.getXzqhUtil().getBeanById(writerXzqh);
	strXcdwjc = xzqhBean.getCatonsimpleName();//政区简称
}
String strDate = UtilFactory.getDateUtil().getCurrentChineseDate();//中国式的时间####年##月##日
Date date = new Date();
String writeDate = UtilFactory.getDateUtil().getSimpleDate(date);
String simInfo = request.getParameter("simInfo");
DtxcManager dtxc = new DtxcManager();
String xcbh = dtxc.buildXcbh();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>巡查日志</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/newformbase.jspf"%>
	<script type="text/javascript" src="<%=basePath%>web/jizeNW/dtxc/xcrz/js/xcrz.js"></script>
	<link rel="stylesheet" href="/base/form/css/commonForm.css" type="text/css" />
  </head>
  <style type="text/css">
  		table{
			border-left-color:#000000;
			border-left-style:solid;
			border-left-width:1px;
			border-top-color:#000000;
			border-top-style:solid;
			border-top-width:1px;
			background-color:#FFFFFF;
			font-family:"宋体";
			font-size:14px;
			}
		td{
			border-bottom-color:#000000;
			border-bottom-style:solid;
			border-bottom-width:1px;
			border-right-color:#000000;
			border-right-style:solid;
			border-right-width:1px;
			margin-bottom:5px;
			margin-top:5px;
			height:25px;
			}
		select{
			background:#FFFFFF;
			border:none;
			font-family:"宋体";
			font-size:14px;
			}
		input{
			background:#FFFFFF;
			border:none;
			font-family:"宋体";
			font-size:14px;
			}
		.class{
			font-family:"宋体";
			font-size:14px;
		}
  </style>
  <script type="text/javascript">
  	var isInput = true;
  	var yw_guid;
  	var simInfo;
  	function save(){		
		document.forms[0].submit();
	}
	
	//页面加载初始化
	function onInit(){	
		init();
		yw_guid = document.getElementById('yw_guid').value;	
		simInfo = '<%=simInfo%>';
		
		initRadio();
		
		var allnum = document.getElementById("allnum");
		var num = parseInt(allnum.value)/5;
		allnum.value = "5";
		if(simInfo!='null'){
			num = num-1;
			drxccg();
		}	
		for(var i = 1; i < num; i++){
			addcgd();
		}		
		
		insertData(json);
		
	    bingCgdState();
	    
	    //判断此日志是否有巡查成果
	    isHaveCG();
	}
	
	function initRadio(){
		if(document.getElementById('sfywf1').checked){
			showtbody();
		}else if(document.getElementById('sfywf2').checked){
			hidetbody();
		}
	}
	
	function bingCgdState(){
		putClientCommond("dtxcManager", "getCgdState");
		putRestParameter("yw_guid", yw_guid);
		var result = restRequest();		
		if(result){
			for(var i=0;i<result.length;i++){
			 if(result[i].CGDQK=='1'){
				document.getElementById("divcgd_" +(i+1)).innerHTML = "<a href='javascript:void(0);' id='spancgd_"+(i+1)+"' onclick='lookCgd(this.id)' style='text-decoration:none'>查看抄告单</a>&nbsp;&nbsp;&nbsp;&nbsp;"+																
																			"<a href='javascript:void(0);' id='cgd_"+(i+1)+"' onclick='createCgd(this.id,1)' style='text-decoration:none'>重新生成抄告单</a>"+
																			"<input type='hidden' name='cgdqk_"+(i+1)+"' id='cgdqk_"+(i+1)+"' value='1'>";
				}else{
				document.getElementById("divcgd_" +(i+1)).innerHTML = '<span style="color:red">抄告单未生成</span>&nbsp;&nbsp;&nbsp;&nbsp;'+
																		'<a href="javascript:void(0);" id="cgd_'+(i+1)+'" onclick="createCgd(this.id,0)" style="text-decoration:none">生成抄告单</a>'+
																		'<input type="hidden" name="cgdqk_'+(i+1)+'" id="cgdqk_'+(i+1)+'" value="0">';
				}
			}
		}
	}
	
	function isHaveCG(){
			putClientCommond("dtxcManager","isHaveCG");
			putRestParameter("yw_guid",yw_guid);
      		var res = restRequest();
			if(res=='0'){
				document.getElementById('viewCgButton').style.display="none";
			}
	}
	
	//添加选项
	function Addopt(selectname, value, name){
		var selectname = document.getElementById(selectname);
		var opt = document.createElement('option');
		opt.text = name;
		opt.value = name;
		selectname.options.add(opt);
	}
	
	//导入巡查成果
	function drxccg(){
		putClientCommond("cgdrManager", "getSimInfo");
		putRestParameter("simInfo", "<%=simInfo%>");
		baseInformation = restRequest();
		if(baseInformation){
			for(var i = 0; i < baseInformation.length-1; i++){
				addcgd();
				document.getElementById('xcrq').value=baseInformation[0].HCRQ;
			}
			
			//将导入的巡查成果写入违法项目当中
			for(var i = 0; i < baseInformation.length; i++){
					document.getElementById("jsdw_" + (i + 1)).value = baseInformation[i].YDDW;
					document.getElementById("dgsj_" + (i + 1)).value = baseInformation[i].YDSJ;
					document.getElementById("jsqk_" + (i + 1)).value = baseInformation[i].JSQK;
					document.getElementById("zdmj_" + (i + 1)).value = baseInformation[i].MJ;
					document.getElementById("ywguid_" + (i + 1)).value = baseInformation[i].YW_GUID;						
			}				
		}
	}

	function impxccg(){
		var feature="dialogWidth:650px;dialogHeight:300px;status:no;help:no;scroll:no;location=no"; 
		//显示成果导入模态对话框，并将导入的成果的yw_guid返回 
		var simInfo =  window.showModalDialog("<%=basePath%>web/jizeNW/dtxc/wyxc/dtxccg.jsp",null,feature); 
		//将导入的巡查成果的基本违法信息写到巡查日志当中
		putClientCommond("cgdrManager", "getSimInfo");
		putRestParameter("simInfo", simInfo);
		baseInformation = restRequest();
		if(baseInformation){
			for(var i = 0; i < baseInformation.length-1; i++){
				addcgd();
				document.getElementById('xcrq').value=baseInformation[0].HCRQ;
			}
			
			//将导入的巡查成果写入违法项目当中
			for(var i = 0; i < baseInformation.length; i++){
					document.getElementById("jsdw_" + (i + 1)).value = baseInformation[i].YDDW;
					document.getElementById("dgsj_" + (i + 1)).value = baseInformation[i].YDSJ;
					document.getElementById("jsqk_" + (i + 1)).value = baseInformation[i].JSQK;
					document.getElementById("zdmj_" + (i + 1)).value = baseInformation[i].MJ;
					document.getElementById("ywguid_" + (i + 1)).value = baseInformation[i].YW_GUID;						
			}				
		}
	}

		//抄告单在wbeoffice中生成
		function createCgd(createId,flag){
			isshowSave=false;
			var tempNum = createId.charAt(4); 
			var jsxm = document.getElementById("jsxm_" + tempNum).value;
			var jsdw = document.getElementById("jsdw_" + tempNum).value;
			var dgsj = document.getElementById("dgsj_" + tempNum).value;
			var jsqk = document.getElementById("jsqk_" + tempNum).value;
			var zdmj = document.getElementById("zdmj_" + tempNum).value;
			var zdwz = document.getElementById("zdwz_" + tempNum).value;
			var townname = document.getElementById("townname_" + tempNum).value;
			var countyname = document.getElementById("countyname_" + tempNum).value;
			if(jsxm == "" || jsdw == "" || dgsj =="" || jsqk== "" || zdmj == "" ||zdwz == ""|| townname == "" ||countyname == ""){
				alert("信息不完整，不能生成抄告单。请将信息填写完整！！");
				return;
			}
			
			if(flag==1){
			   if(confirm('原抄告单将被替换，是否重新生成抄告单！！')){
			   		
			   }else{
			   		return;
			   }
			}
      		
			//巡查单位
			var xcdw = document.getElementById("xcdw").value;
			//var yw_guid = "";
			var flag = true;
			//获得抄告单编号
			putClientCommond("dtxcManager","buildCgdbh");
			putRestParameter("yw_guid",yw_guid);
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
																	"<a href='javascript:void(0);' id='"+createId+"' onclick='createCgd(this.id,1)' style='text-decoration:none'>重新生成抄告单</a>"+
																	"<input type='hidden' name='cgdqk_"+tempNum+"' id='cgdqk_"+tempNum+"' value='1'>";
			//保存抄告单编号
			putClientCommond("dtxcManager","saveCgdbh");
			putRestParameter("yw_guid",yw_guid);
			putRestParameter("cgdid",createId);
      		putRestParameter("cgdbh",escape(escape(cgdbh)));
      		putRestParameter("userid","<%=writerId %>");
			restRequest();
		}
		
		//查看已经生成过的抄告单
		function lookCgd(lookId){
			isshowSave=false;
			var strLookId = lookId.substring(4);
			//var yw_guid = "";
			var flag = false;
			var strUrl = "yw_guid="+yw_guid+"&file_id="+strLookId+"&flag="+flag;
			window.open("../webOffice/webOfficeMain.jsp?"+strUrl);
		}
		
		function showtbody(){
			document.getElementById('add').style.display='';
			document.getElementById('delete').style.display='';		
			document.getElementById('info').style.display='block';
		}
		function hidetbody(){
			document.getElementById('add').style.display='none';
			document.getElementById('delete').style.display='none';
			document.getElementById('info').style.display='none';
		}
  </script>
  <body onLoad="onInit(); return false;">
  	<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
  	<div align="center" style="margin-bottom:20px"><h1 style="font-size: 25">国土资源执法监察巡查日志</h1></div>
  	<form method="post">
  		<div style="width: 100%;">
			<span style="margin-left: 270px;font-size:14px;">巡查编号：<input type="text" name="xcbh" id="xcbh" readonly="readonly" value="<%=xcbh%>"
					style="width: 150px; background-color: transparent; border: 0px;"></input>
			</span>
		</div>
  		<input type="hidden" name="yw_guid" id="yw_guid">
  	    <table align="center" cellpadding="0" cellspacing="0" width="600px" id="xcrztable">
			<tr>
    			<td height="16" colspan="2"><div align="center">巡查单位</div></td>
    			<td width="166"><input type="text" class="noborder" name="xcdw" id="xcdw" style="width: 97%"/></td>
    			<td width="102"><div align="center">巡查日期</div></td>
    			<td width="211"><input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="xcrq" id="xcrq" readonly style="width: 97%"/></td>
  			</tr>
			<tr>
    			<td colspan="2"><div align="center">巡查区域</div></td>
    			<td colspan="3"><input type="text" class="noborder" name="xcqy" id="xcqy" style="width: 99%"/></td>
  			</tr>
			<tr>
    			<td colspan="2"><div align="center">巡查人员</div></td>
    			<td colspan="3"><input type="text" class="noborder" name="xcry" id="xcry" style="width: 99%"/></td>
  			</tr>
			<tr>
    			<td height="21" colspan="2"><div align="center">巡查路线</div></td>
    			<td colspan="3"><input type="text" class="noborder" name="xclx" id="xclx" style="width: 99%"/></td>
  			</tr>
			<tr>
				<td colspan="2"><div align="center">是否有违法</div></td>
				<td colspan="3">
					<input type="radio" name="sfywf" id="sfywf1" value="是" onclick="showtbody()"/>是
					<input type="radio" name="sfywf" id="sfywf2" value="否" onclick="hidetbody()"/>
					否
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" class="button" id="add" value="增加" onClick="addcgd(); return false;" />
					<input type="button" class="button" id="delete" value="删除" onClick="deletecgd();return false;" />				
					&nbsp;&nbsp;&nbsp;
					<input type="button" class="button" id="imp" value="导入巡查成果" onClick="impxccg();return false;" />
				
					<input type="text" id="allnum" name="allnum" value="5" style="display:none" />				</td>
			</tr>
			<tbody id="info">
			<tr>
				<td rowspan="5"><div align="center"><input type="checkbox" id="check_1" /> </td>
				<td><div align="center">建设项目</div></td>
				<td>
					<input type="text" class="noborder" name="jsxm_1" id="jsxm_1" style="width:97%" />				</td>
				<td>
					<div align="center">建设单位</div>				</td>
				<td>
					<input type="text" class="noborder" name="jsdw_1" id="jsdw_1" style="width:97%" />				</td>
			</tr>
			<tr>
				<td><div align="center">动工时间</div></td>
				<td>
					<input type="text" class="underline" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="dgsj_1" id="dgsj_1" readonly style="width: 97%"/>				
				</td>
				<td>
					<div align="center">建设情况</div>	
				</td>
				<td>
				  <input type="text" class="noborder" name="jsqk_1" id="jsqk_1" style="width: 97%"/>
				</td>
			</tr>
			<tr>
				<td><div align="center">占地面积</div></td>
				<td>
					<input type="text" class="noborder" name="zdmj_1" id="zdmj_1" style="width:97%" />
				</td>
				<td>
					<div align="center">占地位置</div>
				</td>
				<td>
					<input type="text" class="noborder" name="zdwz_1" id="zdwz_1" style="width:97%" />
					<input type="text" style="display:none" id="ywguid_1" name="ywguid_1" />
				</td>				
			</tr>
			<tr>
				<td>
					<div align="center">镇(办事处)</div>
				</td>
				<td>
					<input type="text" class="noborder" name="townname_1" id="townname_1" style="width:97%" />
				</td>	
				<td>
					<div align="center">村辖区</div>
				</td>
				<td>
					<input type="text" class="noborder" name="countyname_1" id="countyname_1" style="width:97%" />
				</td>						
			</tr>
			<tr>
						<td>
							<div align="center">
								抄告单状态
							</div>
						</td>
						<td colspan="3">
							<div id="divcgd_1" align="center">
								<span style="color:red">抄告单未生成</span>&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="javascript:void(0);" id="cgd_1" onclick="createCgd(this.id,0)" style="text-decoration:none">生成抄告单</a>
								<input type="hidden" name="cgdqk_1" id="cgdqk_1" value="0">
							</div>
						</td>
			</tr>
			</tbody>			
			<tr>
				<td width="40" rowspan="2">
					<p align="center">巡</p>
					<p align="center">查</p>
					<p align="center">内</p>
					<p align="center">容</p>
				</td>
				<td width="82">
					<div align="center">项目<br/>
					建设<br/>
					及用<br/>
					地审<br/>
					批手<br/>
					续审<br/>
					批情<br/>
					况</div>
				</td>
				<td colspan="3">
					<textarea rows="12" name="spqk" id="spqk" style="width:99%"></textarea>
				</td>
			</tr>
			<tr>
				<td>
					<div align="center">
						对所<br/>
						建项<br/>
						目的<br/>
						处理<br/>
						意见
					</div>
				</td>
				<td colspan="3">
					<textarea rows="8" name="clyj" id="clyj" style="width:99%"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div align="center">备注</div>
				</td>
				<td colspan="3">
					<textarea rows="4" name="bz" id="bz" style="width:99%"></textarea>
				</td>
			</tr>
        </table>
        <input type="text" value="<%=writerId %>" id="userid" name="userid" style="display: none" />
		<input type="text" value="<%=writerXzqh %>" id="writerxzqh" name="writerxzqh" style="display: none" />
		<input type="text" value="<%=writeDate %>" id="writerdate" name="writerdate" style="display: none" />
  	</form>
  	<div id="viewCgButton" style="margin-top:10px;text-align: center"><button style="cursor:hand;" onclick="viewCG()">点击查看巡查成果</button></div>
  </body>
  <script type="text/javascript">
 	function viewCG(){
		var height=window.screen.availHeight;
		var width=window.screen.availWidth;
		window.showModalDialog("<%=basePath%>web/jizeNW/dtxc/wyxc/xjclyjframe.jsp?zfjcType=13&yw_guid="+yw_guid,obj,"dialogWidth="+width+";dialogHeight="+height);
	}
  	<%
		String msg = (String)request.getParameter("msg");
	%>
	if("<%=msg%>" == "success"){
		alert("表单保存成功");  
	}
  </script>
</html>
