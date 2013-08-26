<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//String xmmc = new String(request.getParameter("xmmc").getBytes("iso-8859-1"), "UTF-8");
String xmmc = "联合大学商学院";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>供地体量登记表</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/newformbase.jspf"%>
	<link rel="stylesheet" href="/base/form/css/commonForm.css" type="text/css" />
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
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
			font-size:16px;
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
			}
		select{
			background:#FFFFFF;
			border:none;
			}
		input{
			background:#FFFFFF;
			border:none;
			}
  </style>
  <script type="text/javascript">
  	function save(){
		  		//保存之前，删除数据库中已经存在的数据
  		for(var i = 0; i < document.getElementById("num").value; i++){
  			putClientCommond("kftlHandle", "deleteExist");
			putRestParameter("year", document.getElementById("nd_" + i));
			putRestParameter("quarter", document.getElementById("jd_" + i));
			putRestParameter("xmmc","<%=xmmc%>");
			baseInformation = restRequest();
  		}
		document.forms[0].submit();
	}
	
	//获取相同年份和季节数据
	function getSameData(check){
	
	
	}
	
	//初始化,获取相同项目名称的基本数据
	function onInit(){
		putClientCommond("jcsjHandler", "getProjectList");
		putRestParameter("xmmc", "<%=xmmc%>");
		baseInformation = restRequest();
		baseInformation = eval(baseInformation);
		//总户数
		zhs = baseInformation[0].HS;
		//总地量
		zdl = baseInformation[0].ZD;
		//总规模
		zgm = baseInformation[0].GM;
		//住
		zzf = baseInformation[0].ZZCQFY;
		//企
		zqf = baseInformation[0].QYCQFY;
		//楼面价
		lmj = baseInformation[0].LMCB;
		//成交价
		cjj = baseInformation[0].LMCJJ;
		//房屋售价
		fwsj = baseInformation[0].FWSJ;
		//租金
		zj = baseInformation[0].ZJ;
		
		//拆迁货币投资
		cqhbtz = baseInformation[0].ZZHBTZCB;
		
		for(var i = 2012; i < 2022; i++){
			Addopt("nd_1", i);
			Addopt("nd_2", i);
			Addopt("nd_3", i);
			Addopt("nd_4", i);
		}
		
		init();
		
		//计算总价值和租金值
		var zjName = "zjz_";
		var zujName = "zuj_";
		for(var i = 1; i < 5; i++){
			var zjz = zjName + i;
			var zuj = zujName + i;
			document.getElementById(zjz).value = format(fwsj);
			document.getElementById(zuj).value = format(zj); 	
		}			
	}
	
	//添加选项
	function Addopt(selectname, value){
		var name = document.getElementById(selectname);
		var opt = document.createElement('option');
		opt.text = value;
		opt.value = value;
		name.options.add(opt);
	}
	
	//计算地量的值
	function diliang(check){
		var value = check.value;
		var name = check.name;
		name = name.replace(/dl/,"dlz");
		value = parseFloat(zdl)*parseFloat(value)* 0.01;
		document.getElementById(name).value = format(value);
	}
	
	  	//选择年度和季度时，查询是否有历史数据
	function changeQuarter(check){
		var value = check.value;
		var name = check.name;
		var yearname = name.replace(/jd/,"nd");
		var yearValue = document.getElementById(yearname).value;
		//当年度和季度不确定时，不做处理
		if(yearValue == "" || value == ""){
			return;
		}
		putClientCommond("gdtlHandle", "getGdtlByQuarter");
		putRestParameter("year", yearValue);
		putRestParameter("quarter", value);
		putRestParameter("xmmc","<%=xmmc%>");
		baseInformation = restRequest();
		baseInformation = eval(baseInformation);
		
		if(baseInformation.length > 0){
			document.getElementById(name.replace(/jd/, "dl")).value = format(baseInformation[0].DL);
			document.getElementById(name.replace(/jd/, "dlz")).value = format(baseInformation[0].DLZ);
			document.getElementById(name.replace(/jd/, "gm")).value = format(baseInformation[0].GM);
			document.getElementById(name.replace(/jd/, "gmz")).value = format(baseInformation[0].GMZ);
			document.getElementById(name.replace(/jd/, "cb")).value = format(baseInformation[0].CB);
			document.getElementById(name.replace(/jd/, "cbz")).value = format(baseInformation[0].CBZ);
			document.getElementById(name.replace(/jd/, "sy")).value = format(baseInformation[0].SY);
			document.getElementById(name.replace(/jd/, "syz")).value = format(baseInformation[0].SYZ);
			document.getElementById(name.replace(/jd/, "zj")).value = format(baseInformation[0].ZJ);
			document.getElementById(name.replace(/jd/, "zjz")).value = format(baseInformation[0].ZJZ);
			document.getElementById(name.replace(/jd/, "zuj")).value = format(baseInformation[0].ZUJ);
		}		
	}
	
	//计算规模的值
	function guimo(check){
		var value = check.value;
		var name = check.name;
		name = name.replace(/gm/,"gmz");
		value = parseFloat(zgm)*parseFloat(value)* 0.01;
		document.getElementById(name).value = format(value);
		
		//计算成本的值
		var cbValue = parseFloat(value) * parseFloat(lmj);
		var cbName = name.replace(/gmz/, "cbz");
		document.getElementById(cbName).value = format(cbValue);
		
		//计算收益的值
		var syValue = parseFloat(value) * (parseFloat(cjj) - parseFloat(lmj));
		var syName = name.replace(/gmz/, "syz");
		document.getElementById(syName).value = format(syValue);
		
	}
			//数据格式化
	function format(value){
		if(value == null || value == "" || value == undefined || isNaN(value)){
			return "";
		}else{
			return value;
		}
	}
	  
  </script>
  <body onLoad="onInit();">
  	<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
  	<form method="post">
		
  	    <table align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td><label>项目名称</label>            </td>
            <td id="xmmctd" colspan="4"><input type="text" id="xmmc" name="xmmc" value="<%=xmmc%>" style="width:100px">
              &nbsp;&nbsp;
              <button>增加</button>
  				<input type="text" id="num" value="4" style="display:none" />
      <button>删除</button></td>
          </tr>
          <tr>
            <td><label>属性名\年度</label>            </td>
            <td><select id="nd_1" name="nd_1">
                <option ></option>
                 </select>
              &nbsp;
              <select id="jd_1" name="jd_1" onChange="changeQuarter(this);return false;">
              	<option checked></option>
                <option value="1" >1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
              </select>            </td>
            <td><select id="nd_2" name="nd_2">
                <option checked></option>
              </select>
              &nbsp;
              <select id="jd_2" name="jd_2" onChange="changeQuarter(this);return false;">
              	<option checked></option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
              </select>            </td>
            <td><select id="nd_3" name="nd_3" >
                <option checked></option>
              </select>
              &nbsp;
              <select id="jd_3" name="jd_3" onChange="changeQuarter(this);return false;" >
              	<option checked></option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
              </select>            </td>
            <td><select id="nd_4" name="nd_4">
                <option checked></option>
              </select>
              &nbsp;
              <select id="jd_4" name="jd_4" onChange="changeQuarter(this);return false;">
              	<option checked></option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
              </select>            </td>
          </tr>
          <tr>
            <td><label>地量(百分比)</label></td>
            <td><input type="text" id="dl_1" name="dl_1" onBlur="diliang(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                <input type="text" id="dlz_1" name="dlz_1" style="width:80px" /></td>
            <td><input type="text" id="dl_2" name="dl_2" onBlur="diliang(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                <input type="text" id="dlz_2" name="dlz_2" style="width:80px" /></td>
            <td><input type="text" id="dl_3" name="dl_3" onBlur="diliang(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                <input type="text" id="dlz_3" name="dlz_3" style="width:80px" /></td>
            <td><input type="text" id="dl_4" name="dl_4" onBlur="diliang(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                <input type="text" id="dlz_4" name="dlz_4" style="width:80px" /></td>
          </tr>
          <tr>
            <td><label>规模(百分比)</label>            </td>
            <td><input type="text" id="gm_1" name="gm_1" onBlur="guimo(this)" style="width:50px; text-align:right; padding-right:5px" /> 
				<label>%</label>  
			    <input type="text" id="gmz_1" name="gmz_1" style="width:80px" />       </td>
            <td><input type="text" id="gm_2" name="gm_2" onBlur="guimo(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                <input type="text" id="gmz_2" name="gmz_2" style="width:80px" /></td>
            <td><input type="text" id="gm_3" name="gm_3" onBlur="guimo(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                <input type="text" id="gmz_3" name="gmz_3" style="width:80px" /></td>
            <td><input type="text" id="gm_4" name="gm_4" onBlur="guimo(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                <input type="text" id="gmz_4" name="gmz_4" style="width:80px" /></td>
          </tr>
          <tr>
            <td><label>成本(百分比)</label>            </td>
            <td><input type="text" id="cb_1" name="cb_1" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                <input type="text" id="cbz_1" name="cbz_1" style="width:80px" />            </td>
            <td><input type="text" id="cb_2" name="cb_2" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                <input type="text" id="cbz_2" name="cbz_2" style="width:80px" />            </td>
            <td><input type="text" id="cb_3" name="cb_3" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                <input type="text" id="cbz_3" name="cbz_3" style="width:80px" />            </td>
            <td><input type="text" id="cb_4" name="cb_4" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                <input type="text" id="cbz_4" name="cbz_4" style="width:80px" />            </td>
          </tr>
          <tr>
            <td><label> 收益(百分比)</label>            </td>
            <td><input type="text" id="sy_1" name="sy_1"  style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                <input type="text" id="syz_1" name="syz_1" style="width:80px" /></td>
            <td><input type="text" id="sy_2" name="sy_2" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                <input type="text" id="syz_2" name="syz_2" style="width:80px" /></td>
            <td><input type="text" id="sy_3" name="sy_3" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                <input type="text" id="syz_3" name="syz_3" style="width:80px" /></td>
            <td><input type="text" id="sy_4" name="sy_4" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                <input type="text" id="syz_4" name="syz_4" style="width:80px" /></td>
          </tr>
          <tr>
            <td><label>总价(百分比)</label>            </td>
            <td><input type="text" id="zj_1" name="zj_1" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
              <input type="text" id="zjz_1" name="zjz_1" style="width:80px" /></td>
            <td><input type="text" id="zj_2" name="zj_2" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
              <input type="text" id="zjz_2" name="zjz_2" style="width:80px" /></td>
            <td><input type="text" id="zj_3" name="zj_3" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
              <input type="text" id="zjz_3" name="zjz_3" style="width:80px" /></td>
            <td><input type="text" id="zj_4" name="zj_4" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
              <input type="text" id="zjz_4" name="zjz_4" style="width:80px" /></td>
          </tr>
		  <tr>
            <td><label>租金</label>            </td>
            <td><input type="text" id="zuj_1" name="zuj_1" style="width:80px" /></td>
            <td><input type="text" id="zuj_2" name="zuj_2" style="width:80px" /></td>
            <td><input type="text" id="zuj_3" name="zuj_3" style="width:80px" /></td>
            <td><input type="text" id="zuj_4" name="zuj_4" style="width:80px" /></td>
          </tr>
        </table>
  	</form>
  </body>
</html>
