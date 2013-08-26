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
    
    <title>开发体量登记表</title>
    
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
		
		//拆迁货币投资
		cqhbtz = baseInformation[0].ZZHBTZCB;
		
		for(var i = 2012; i < 2022; i++){
			Addopt("nd_1", i);
			Addopt("nd_2", i);
			Addopt("nd_3", i);
			Addopt("nd_4", i);
		}
		
		init();
		
		//添加楼面价、成交价的值
		for(var i = 1; i < 5; i++){
			var loumName = document.getElementById("lm_" + i);
			var cjName = document.getElementById("cj_" + i);
			loumName.value = format(lmj);
			cjName.value = format(cjj);
		}
		
	}
	
	//添加选项
	function Addopt(selectname, value){
		var name = document.getElementById(selectname);
		var opt = document.createElement('option');
		opt.text = format(value);
		opt.value = format(value);
		name.options.add(opt);
	}
	
	//根据输入的百分比计算对应的值
	//计算户数对应的值
	function hushu(check){
		var value = check.value;
		var name = check.name;
		name = name.replace(/hs/,"hsz");
		value = parseFloat(zhs)*parseFloat(value)* 0.01;
		document.getElementById(name).value = format(value);
		countTotal();
	}
	
	//计算地量的值
	function diliang(check){
		var value = check.value;
		var name = check.name;
		name = name.replace(/dl/,"dlz");
		value = parseFloat(zdl)*parseFloat(value)* 0.01;
		document.getElementById(name).value = format(value);
		countTotal();
	}
	
	//计算规模的值
	function guimo(check){
		var value = check.value;
		var name = check.name;
		name = name.replace(/gm/,"gmz");
		value = parseFloat(zgm)*parseFloat(value)* 0.01;
		document.getElementById(name).value = format(value);
		countTotal();
	}
	
	//计算住的值
	function zhu(check){
		var value = check.value;
		var name = check.name;
		name = name.replace(/zhu/,"zhuz");
		value = parseFloat(zzf)*parseFloat(value)* 0.01;
		if(value == "" || isNaN(value)){
			value = 0;
		}
		document.getElementById(name).value = format(value);
		
		//计算投资值
		var tzzname = name.replace(/zhu/, "tz");
		var tzname = name.replace(/zhu/, "t"); 
		var qizname = name.replace(/zhu/,"qi");
		var qivalue = document.getElementById(qizname).value;
		if(qivalue == "" || isNaN(qivalue)){
			qivalue = 0;
		}
		if(value == "" || isNaN(value)){
			value = 0;
		}
		var tzzvalue = parseFloat(qivalue)+parseFloat(value);
		document.getElementById(tzzname).value = format(tzzvalue);
		
		var tzvalue = (parseFloat(tzzvalue)*100)/parseFloat(cqhbtz);
		tzvalue = tzvalue + '%';
		
		document.getElementById(tzname).value = format(tzvalue);
		countTotal();	
	}
	
	function qi(check){
		var value = check.value;
		var name = check.name;
		name = name.replace(/qi/,"qiz");
		value = parseFloat(zqf)*parseFloat(value)* 0.01;
		if(value == "" || isNaN(value)){
			value = 0;
		}
		document.getElementById(name).value = format(value);
		
				//计算投资值
		var tzzname = name.replace(/qi/, "tz");
		var tzname = name.replace(/qi/, "t"); 
		var zhuzname = name.replace(/qi/,"zhu");
		var qivalue = document.getElementById(zhuzname).value;
		if(qivalue == "" || qivalue == 'NaN'){
			qivalue = 0;
		}

		var tzzvalue = parseFloat(qivalue)+parseFloat(value);
		document.getElementById(tzzname).value = format(tzzvalue);
		
		var tzvalue = (parseFloat(tzzvalue)* 100)/parseFloat(cqhbtz);
		tzvalue = tzvalue;
		
		document.getElementById(tzname).value = format(tzvalue);	
		countTotal();
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
		putClientCommond("kftlHandle", "getKftlByQuarter");
		putRestParameter("year", yearValue);
		putRestParameter("quarter", value);
		putRestParameter("xmmc","<%=xmmc%>");
		baseInformation = restRequest();
		baseInformation = eval(baseInformation);
		
		if(baseInformation.length > 0){
			document.getElementById(name.replace(/jd/, "hs")).value = format(baseInformation[0].HS);
			document.getElementById(name.replace(/jd/, "dl")).value = format(baseInformation[0].DL);
			document.getElementById(name.replace(/jd/, "gm")).value = format(baseInformation[0].GM);
			document.getElementById(name.replace(/jd/, "tz")).value = format(baseInformation[0].TZ);
			document.getElementById(name.replace(/jd/, "zhu")).value = format(baseInformation[0].ZHU);
			document.getElementById(name.replace(/jd/, "qi")).value = format(baseInformation[0].QI);
			document.getElementById(name.replace(/jd/, "hsz")).value = format(baseInformation[0].HSZ);
			document.getElementById(name.replace(/jd/, "dlz")).value = format(baseInformation[0].DLZ);
			document.getElementById(name.replace(/jd/, "gmz")).value = format(baseInformation[0].GMZ);
			document.getElementById(name.replace(/jd/, "tzz")).value = format(baseInformation[0].TZZ);
			document.getElementById(name.replace(/jd/, "zhuz")).value = format(baseInformation[0].ZHUZ);
			document.getElementById(name.replace(/jd/, "qiz")).value = format(baseInformation[0].QIZ);
		}
		countTotal();		
	}
	
		//数据格式化
	function format(value){
		if(value == null || value == "" || value == undefined || isNaN(value)){
			return "";
		}else{
			return value;
		}
	}
	//计算合计百分比
	function countTotal(){
		var countname = new Array("hs", "dl", "gm", "zhu", "qi", "tz");
		for(var i = 0; i < countname.length; i++){
			var value = 0;
			for(var j = 0; j < document.getElementById("num").value; j++){
				 var chosevalue = format(document.getElementById(countname[i] + "_" + (j + 1)).value);
				 if(chosevalue == ""){
				 }else{
				 	value = parseFloat(value) + parseFloat(chosevalue);
				}
			}
			document.getElementById(countname[i]).value = format(value);
		}
	}
  </script>
  <body onLoad="onInit();">
  	<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
  	<form method="post">
		
  	    <table align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td><label>项目名称</label>            </td>
            <td id="xmmctd" colspan="5"><input type="text" id="xmmc" name="xmmc" value="<%=xmmc%>" style="width:100px">
              &nbsp;&nbsp;
              <button style="display:none">增加</button>
  				<input type="text" id="num" value="4" style="display:none" />
      <button style="display:none">删除</button></td>
          </tr>
          <tr>
            <td><label>属性名\年度</label>            </td>
            <td><select name="nd_1">
                <option ></option>
                 </select>
              &nbsp;
              <select name="jd_1" onChange="changeQuarter(this);return false;">
              	<option checked></option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
              </select>            </td>
            <td><select name="nd_2">
                <option checked></option>
              </select>
              &nbsp;
              <select name="jd_2" onChange="changeQuarter(this);return false;">
              	<option checked></option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
              </select>            </td>
            <td><select name="nd_3" >
                <option checked></option>
              </select>
              &nbsp;
              <select name="jd_3" onChange="changeQuarter(this);return false;" >
              	<option checked></option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
              </select>            </td>
            <td><select name="nd_4">
                <option checked></option>
              </select>
              &nbsp;
              <select name="jd_4" onChange="changeQuarter(this);return false;">
              	<option checked></option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
              </select>            </td>
			  
			 <td align="center">
			 	<label>合计</label>
			 </td>
          </tr>
          <tr>
            <td><label>户数(百分比)</label>            </td>
            <td>
			<input type="text" id="hsz_1" name="hsz_1" readonly="true" style="width:60px" />
			<input type="text" id="hs_1" name="hs_1" onBlur="hushu(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                </td>
            <td>
				<input type="text" id="hsz_2" name="hsz_2" readonly="true" style="width:60px" />
				<input type="text" id="hs_2" name="hs_2" onBlur="hushu(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                </td>
            <td>
				<input type="text" id="hsz_3" name="hsz_3" readonly="true" style="width:60px" />
				<input type="text" id="hs_3" name="hs_3" onBlur="hushu(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                </td>
            <td>
				<input type="text" id="hsz_4" name="hsz_42" readonly="true" style="width:60px" />
				<input type="text" id="hs_4" name="hs_4" onBlur="hushu(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                </td>
			<td>
				<input type="text" id="hs" name="hs" style="width:50px; text-align:right; padding-right:5px" />
				%
			</td>
          </tr>
          <tr>
            <td><label>地量(百分比)</label>            </td>
            <td>
				<input type="text" id="dlz_1" name="dlz_1" readonly="true" style="width:60px" />
				<input type="text" id="dl_1" name="dl_1" onBlur="diliang(this)" style="width:50px; text-align:right; padding-right:5px" />  
				<label>%</label> 
			           </td>
            <td>
				<input type="text" id="dlz_2" name="dlz_2" readonly="true" style="width:60px" />
				<input type="text" id="dl_2" name="dl_2" onBlur="diliang(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                
            <td>
				<input type="text" id="dlz_3" name="dlz_3" readonly="true" style="width:60px" />
				<input type="text" id="dl_3" name="dl_3" onBlur="diliang(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                </td>
            <td>
				<input type="text" id="dlz_4" name="dlz_4" readonly="true" style="width:60px" />
				<input type="text" id="dl_4" name="dl_4" onBlur="diliang(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                </td>
			<td>
				<input type="text" id="dl" name="dl" style="width:50px; text-align:right; padding-right:5px" />
				%
			</td>
          </tr>
          <tr>
            <td><label>规模(百分比)</label>            </td>
            <td>
				<input type="text" id="gmz_1" name="gmz_1" readonly="true" style="width:60px" />
				<input type="text" id="gm_1" name="gm_1" onBlur="guimo(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
            </td>
            <td>
				<input type="text" id="gmz_2" name="gmz_2" readonly="true" style="width:60px" />
				<input type="text" id="gm_2" name="gm_2" onBlur="guimo(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                            </td>
            <td>
				<input type="text" id="gmz_3" name="gmz_3" readonly="true" style="width:60px" />
				<input type="text" id="gm_3" name="gm_3" onBlur="guimo(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
             </td>
            <td>
				<input type="text" id="gmz_4" name="gmz_4" readonly="true" style="width:60px" />            
				<input type="text" id="gm_4" name="gm_4" onBlur="guimo(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
             </td>
			<td>
				<input type="text" id="gm" name="gm" style="width:50px; text-align:right; padding-right:5px" />
				%
			</td>
          </tr>
          <tr>
            <td><label>住(百分比)</label>            </td>
            <td>
				<input type="text" name="zhuz_1" readonly="true" style="width:60px" />
				<input type="text" name="zhu_1" onBlur="zhu(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
            </td>
            <td>
				<input type="text" name="zhuz_2" readonly="true" style="width:60px" />
				<input type="text" name="zhu_2" onBlur="zhu(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
            </td>
            <td>
				<input type="text" name="zhuz_3" readonly="true" style="width:60px" />
				<input type="text" name="zhu_3" onBlur="zhu(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
            </td>
            <td>
				<input type="text" name="zhuz_4" readonly="true" style="width:60px" />
				<input type="text" name="zhu_4" onBlur="zhu(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
            </td>
			<td>
				<input type="text" name="zhu" style="width:50px; text-align:right; padding-right:5px" />
				%
			</td>
          </tr>
          <tr>
            <td><label>企(百分比)</label>            </td>
            <td>
				<input type="text" id="qiz_1" name="qiz_1" readonly="true" style="width:60px" />
				<input type="text" id="qi_1" name="qi_1" onBlur="qi(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
              </td>
            <td>
				<input type="text" id="qiz_2" name="qiz_2" readonly="true" style="width:60px" />
				<input type="text" id="qi_2" name="qi_2" onBlur="qi(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
            </td>
            <td>
				<input type="text" id="qiz_3" name="qiz_3" readonly="true" style="width:60px" />
				<input type="text" id="qi_3" name="qi_3" onBlur="qi(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
            </td>
            <td>
				<input type="text" id="qiz_4" name="qiz_4" readonly="true" style="width:60px" />
				<input type="text" id="qi_4" name="qi_4" onBlur="qi(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
            </td>
			<td>
				<input type="text" id="qi" name="qi" style="width:50px; text-align:right; padding-right:5px" />
				%
			</td>
          </tr>
		  <tr>
            <td><label>投资</label>            </td>
            <td>
				<input type="text" id="tzz_1" name="tzz_1" readonly="true" style="width:60px" />
				<input type="text" id="tz_1" name="tz_1" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
            </td>
            <td>
			<input type="text" id="tzz_2" name="tzz_2" readonly="true" style="width:60px" />
			<input type="text" id="tz_2" name="tz_2" style="width:50px; text-align:right; padding-right:5px" />
			<label>%</label>
              </td>
            <td>
			<input type="text" id="tzz_3" name="tzz_3" readonly="true" style="width:60px" />
			<input type="text" id="tz_3" name="tz_3" style="width:50px; text-align:right; padding-right:5px" />
			<label>%</label>
              </td>
            <td>
				<input type="text" id="tzz_4" name="tzz_4" readonly="true" style="width:60px" />
				<input type="text" id="tz_4" name="tz_4" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
              </td>
			<td>
				<input type="text" id="tz" name="tz" style="width:50px; text-align:right; padding-right:5px" />
				%
			</td>
          </tr>
		  
		  <tr>
            <td><label>楼面价</label>            </td>
            <td><input type="text" id="lm_1" name="lm_1" readonly="true" style="width:60px" />
             </td>
            <td><input type="text" id="lm_2" name="lm_2" readonly="true" style="width:60px" />
              </td>
            <td><input type="text" id="lm_3" name="lm_3" readonly="true" style="width:60px" />
              </td>
            <td><input type="text" id="lm_4" name="lm_4" readonly="true" style="width:60px" />
				
              </td>
			 <td>
			 	<input type="text" style="display:none" />
			</td>
          </tr>
		  		  <tr>
            <td><label>成交价</label>            </td>
            <td><input type="text" id="cj_1" name="cj_1" readonly="true" style="width:60px" />
             </td>
            <td><input type="text" id="cj_2" name="cj_2" readonly="true" style="width:60px" />
              </td>
            <td><input type="text" id="cj_3" name="cj_3" readonly="true" style="width:60px" />
              </td>
            <td><input type="text" id="cj_4" name="cj_4" readonly="true" style="width:60px" />
              </td>
			 <td>
			 	<input type="text" style="display:none" />
			 </td>
          </tr>
        </table>
  	</form>
  </body>
</html>
