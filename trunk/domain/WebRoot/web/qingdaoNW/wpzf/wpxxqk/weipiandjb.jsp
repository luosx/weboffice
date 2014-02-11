<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>土地疑似违法图斑核查情况登记卡</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/newformbase.jspf"%>
    <link href="style.css" type="text/css" rel="stylesheet" />
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
		.TDRightBottom {font-size: 12px;border-right: 1px solid #000000; border-bottom: 1px solid #000000;text-align:Center;line-height:150% }
       .TDRight {font-size: 12px;border-right: 1px solid #000000; text-align:Center;line-height:150% }
       .TDBottom {font-size: 12px;border-bottom: 1px solid #000000; text-align:Center;line-height:150% }
       .TDBottom2 {font-size: 12px;border-bottom: 1px solid #000000;line-height:150% }
       .TDLeft  {font-size: 12px;border-left: 1px solid #000000; text-align:Center;line-height:150% }
       .TDLeftRight  {font-size: 12px;border-left: 1px solid #000000; border-right: 1px solid #000000;text-align:Center;line-height:150% }
       .TDLeftTOP  {font-size: 12px;border-left: 1px solid #000000; border-top: 1px solid #000000;text-align:Center;line-height:150% }
       .TDNoRight  {font-size: 12px;border-left: 1px solid #000000; border-bottom: 1px solid #000000; border-top: 1px solid #000000;text-align:Center;line-height:150% }
       .TDNoBottom {font-size: 12px;border-left: 1px solid #000000; border-right: 1px solid #000000; border-top: 1px solid #000000;text-align:Center;line-height:150% }
       .TDNoTop {font-size: 12px;border-left: 1px solid #000000; border-right: 1px solid #000000; border-Bottom: 1px solid #000000;text-align:Center;line-height:150%}
       .TDNoTopAndRight {font-size: 12px;border-left: 1px solid #000000; border-bottom: 1px solid #000000;text-align:Center;Width:35px;line-height:150%} 
       .TDAll {font-size: 12px;border: 1px solid #000000;text-align:Center;line-height:150%}
       .NewButton {Height:20px;BACKGROUND-COLOR: #ffffff;COLOR: #000000;LINE-HEIGHT: 9pt;PADDING-LEFT: 0px;PADDING-RIGHT: 0px;PADDING-TOP: 2px;PADDING-BOTTOM: 2px;CURSOR: hand;border-width:1px;border-style:solid;FONT-FAMILY: 宋体;FONT-SIZE: 9pt;}
  </style>
  <script type="text/javascript">
  	function save(){
		document.forms[0].submit();
	}
	
	//页面加载初始化
	function onInit(){
		init();
	}
  </script>
  <body onLoad="onInit(); return false;">
  	<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
  	<form method="post">
       <div align='center' style="height:60px">
           <span ID="Label1" style="font-family:宋体;Font-size:14pt;font-weight:bold; text-decoration: underline;" datasrc="#XmlDoc" datafld="reportyear"></span><span style="font-family:宋体;Font-size:14pt;font-weight:bold">土地疑似违法图斑核查情况登记卡</span><br />
		   <br/>
		   <br/>
	  </div>
        <table id="table1" style="background-color: #000000; width: 800px" cellspacing="0" cellpadding="0" border="0" align='center'>
			<tr style="background-color: #99ccff; height: 25px">
                <td align="center" colspan='5'>
                    <span style='font-size: 12.0pt; font-family: 黑体'>基 本 情 况</span>
				</td>
            </tr>
			<tr style="background-color: white; height: 25px">
                <td align='right' style="width: 150px; background-color: #EEEEEE">
                    <span style="color: red">*</span>图斑号:</td>
                <td>
                    <input type='text' id="tbh" name="tbh" style="width: 98%" maxlength="30" title="只能由数字、“-”组成" onpaste="return false"  />
                </td>
                <td align='right' style="width: 150px; background-color: #EEEEEE">
                    地块号:</td>
                <td>
                    <input type='text' id="dkh" name="dkh" style="width: 98%"   maxlength="6" title="只能由数字组成" ondragenter="return false"  />
                </td>                    
            </tr>
			<tr style="background-color: white; height: 25px">
               	<td align='right' style="width: 150px; background-color: #EEEEEE">
                    <span style="color: red">*</span>原行政区划代码:</td>
                <td colspan=3>
					<input type='text' id="yxzqdm" name="yxzqdm" style="width: 98%"  maxlength="6" title="只能由数字组成"  />
				</td>
            </tr>
			<tr style="background-color: white; height: 25px">
                <td align='right' style="width: 150px;background-color: #EEEEEE">
                    <span style="color: red">*<span style="color: #000000">地块面积</span></span>：</td>
                <td style="width: 250px;color: #000000">
                    <input type='text' id="dkmj" name="dkmj" style="width: 90%"  maxlength="20" />亩                    
                </td>
                <td align='right' style="width: 150px;background-color: #EEEEEE">
                    <span style="color: red">*</span>地块类型：</td>
                <td style="width: 250px;">
					<select name="dklx" id="dklx" style="width:98%;">
						<option value="1">合法用地</option>
						<option selected="selected" value="2">违法用地</option>
					</select>
				</td>
            </tr>
			<tr style="background-color: white; height: 25px">
                <td align='right' style="background-color: #EEEEEE">
                    项目名称：</td>
                <td colspan='3'>
                    <input type='text' id="xmmc" name="xmmc" style="width: 98%" maxlength="200" /></td>
            </tr>
			<tr style="background-color: white; height: 25px; border-bottom:0px;">
                <td align='right' style="background-color: #EEEEEE; ">
                    <span style="color: red">*</span>土地坐落：</td>
                <td colspan='3' >
                    <input type='text' id="tdzl" name="tdzl" style="width: 98%" maxlength="120" />
				</td>
            </tr>
			<tr style="background-color: white; height: 25px; border-bottom:0px;">
                <td align='right' style="background-color: #EEEEEE; border-bottom:0px;">
                    <span style="color: red">*</span>核查情况：</td>
                <td colspan='3' style="border-bottom:0px">
					<input type="radio" id="hcqk" name="hcqk" value="0">伪变化&nbsp;
					<input type="radio" id="hcqk" name="hcqk" value="1">合法&nbsp;
					<input type="radio" id="hcqk" name="hcqk" value="2">违法&nbsp;
					<input type="radio" id="hcqk" name="hcqk" value="3">涉施农用地
				
				
				</td>
            </tr>
		</table>
		<table id="table2" style="background-color: #000000; width: 800px" cellspacing="0" cellpadding="0" border="0" align='center'>
			<tr style="background-color: #99ccff; height: 25px">
                <td align="center" colspan='5'>
                    <span style='font-size: 12.0pt; font-family: 黑体'>用 地 情 况</span>
				</td>
            </tr>
			<tr style="background-color: white; height: 25px">
                <td align='center' rowspan='10' style="width: 20px; background-color: #EEEEEE;">
                    <strong>权<br />
                        属<br />
                        及<br />
                        地<br />
                        类<br />
                        情<br />
                        况</strong>
                </td>
                <td style="width: 130px; background-color: #EEEEEE; height: 26px;" align='right'>
                    <span style="color: red">*</span>用地单位(个人):</td>
                <td style="width: 262px; height: 26px;">
                    <input type='text' id="yddw" name="yddw" maxlength="120" style="width: 95%"  /></td>
                <td align='right' style="width: 130px; background-color: #EEEEEE; height: 26px;">
                    <span style="color: #ff0000">*</span>用地时间：</td>
                <td style="height: 26px">
                    <input type='text' id="ydsj" name="ydsj" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 95%" maxlength="7" />
				</td>
            </tr>
			<tr style="background-color: white; height: 25px">
                <td style="width: 130px; background-color: #EEEEEE; height: 25px;" align='right'>
                    <span style="color: red">*</span>实际用途：</td>
                <td style="width: 262px; height: 25px;">
                    <select id="sjyt" name="sjyt" style="width:95%;">
						<option value=""></option>
						<option value="05">商服用地</option>
						<option value="051">　批发零售用地</option>
						<option value="052">　住宿餐饮用地</option>
						<option value="053">　商务金融用地</option>
						<option value="054">　其它商服用地</option>
						<option value="06">工矿仓储用地</option>
						<option value="061">　工业用地</option>
						<option value="062">　采矿用地</option>
						<option value="063">　仓储用地</option>
						<option value="07">住宅用地</option>
						<option value="071">　城镇住宅用地</option>
						<option value="072">　农村宅基地</option>
						<option value="074">　保障性住房</option>
						<option value="08">公共管理与公共服务用地</option>
						<option value="081">　机关团体用地</option>
						<option value="082">　新闻出版用地</option>
						<option value="083">　科教用地</option>
						<option value="084">　医卫慈善用地</option>
						<option value="085">　文体娱乐用地</option>
						<option value="086">　公共设施用地</option>
						<option value="087">　公园与绿地</option>
						<option value="088">　风景名胜设施用地</option>
						<option value="09">特殊用地</option>
						<option value="092">　使领馆用地</option>
						<option value="093">　监教场所用地</option>
						<option value="094">　宗教用地</option>
						<option value="095">　殡葬用地</option>
						<option value="10">交通运输用地</option>
						<option value="101">　铁路用地</option>
						<option value="102">　公路用地</option>
						<option value="103">　街巷用地</option>
						<option value="105">　机场用地</option>
						<option value="106">　港口码头用地</option>
						<option value="107">　管道运输用地</option>
						<option value="11">水域及水利设施用地</option>
						<option value="113">　水库水面</option>
						<option value="118">　水工建筑用地</option>
						<option value="12">其它土地</option>
						<option value="121">　空闲地</option>
					</select>
				</td>
				<td align='right' style="width: 130px; background-color: #EEEEEE; height: 25px;">
						<span style="color: red">*</span>地类代码：</td>
					<td style="width: 260px; height: 25px;">
						<input type='text' id="dldm" name="dldm" maxlength="120" style="width: 95%" />
				</td>
  			</tr>
			<tr style="background-color: white; height: 25px">
                <td style="width: 130px; background-color: #EEEEEE; height: 25px;" align='right'>矿权许可证号：</td>
                <td style="width: 262px; height: 25px;">
                   <input type='text' id="kqxkzh" name="kqxkzh" maxlength="50" style="width: 95%" />
                </td>
                <td style="width: 130px; background-color: #EEEEEE; height: 25px;" align='right'>批准机关：</td>
                <td style="width: 262px; height: 25px;">
                   <input type='text' id="pzjg" name="pzjg" maxlength="50" style="width: 95%"  />
                </td>
            </tr>
			<tr style="background-color: white; height: 25px">
               <td colspan=4 align="left"><input type="checkbox" id='yhyz' value='1' /><label for="yhyz" style="color:Red">是否符合一户一宅等条件</label></td>
            </tr>
			 <tr style="background-color: white; height: 25px">
				<td align='center' valign='middle' style="background-color: #EEEEEE; border-right:0px;">
                    原<br />
                    地<br />
                    类<br />
                    性<br />
                    质<br />
                    <span style="color: red">*</span>
                </td>	 
				<td colspan="3">
					<table style="background-color: #000000; width: 100%; height: 100%; border-left:0px; border-top:0px;" cellspacing="0" cellpadding="0" border="0" align='center'>
                        <tr style="background-color: white; height: 20%; border:0px;">
                            <td align='center' colspan='3' class='TDNoRight' style="background-color: #EEEEEE; border-top:0px">
                                地类名称</td>
                            <td align='center' class='TDAll' style="background-color: #EEEEEE; border-top:0px; border-left:0px; border-right:0px;">
                                面积（亩）</td>
                        </tr>
                        <tr style="background-color: white; height: 20%">
                            <td class="TDLeft" style="border-right:0px;">&nbsp;
                          </td>
                            <td align="left" colspan='2' class="TDBottom2">
                                农用地</td>
                            <td style="width: 260px; border-left:0px; border-right:0px">
                                <input type='text' id="nydmj" name="nydmj" style="width: 95%" maxlength="20" title="农用地面积必须大于或等于其中耕地"   /></td>
                        </tr>
                        <tr style="background-color: white; height: 20%">
                            <td class="TDLeftRight" >&nbsp;
                          </td>
                            <td align="center" colspan='2'>
                                其中耕地</td>
                            <td style="border-left:0px; border-right:0px">
                                <input type='text' id="qzgdmj" name="qzgdmj" style="width: 95%" maxlength="20" title="其中耕地面积必须小于或等于农用地面积"  /></td>
                        </tr>
                        <tr style="background-color: white; height: 20%">
                            <td class="TDLeftRight" style="border-right:0px;">&nbsp;
                          </td>
                            <td style="width: 110px; border-right:0px;">&nbsp;
                          </td>
                            <td style="width: 110px;  border-top:0px;" align="center" class='TDLeftTOP'>
                                其中基本农田</td>
                            <td class='TDNoTop' style="border-left:0px; border-right:0px">
                                <input type='text' id="qzjbntmj" name="qzjbntmj" style="width: 95%"  maxlength="20" />
							</td>
                        </tr>
                        <tr style="background-color: white; height: 20%">
                            <td class='TDNoRight' align="center" colspan='3' style="height: 20%; border-bottom:0px; border-top:0px;">
                                建设用地</td>
                            <td class='TDNoTop' style="height: 20%; border-left:0px; border-right:0px">
                                <input type='text' id="jsydmj" name="jsydmj" style="width: 95%"  maxlength="20" />
							</td>
                        </tr>
                        <tr style="background-color: white; height: 20%">
                            <td class='TDNoRight' align="center" colspan='3' style="height: 20%; border-bottom:0px;">
                                未利用地</td>
                            <td class='TDNoTop' style="height: 20%; border-left:0px; border-right:0px; border-bottom:0px;">
                                <input type='text' id="wlydmj" name="wlydmj" style="width: 95%"  maxlength="20" title="农用地面积与未利用地之和必须等于地块面积" />
							</td>
                        </tr>
                    </table>
				</td> 
			 </tr>
		</table>
		<table id="table4" style="background-color: #000000; width: 800px; border-top:0px;" cellspacing="0" cellpadding="0" border="0" align='center'>
			<tr style="background-color: white; height: 25px">
                <td align='center' rowspan='5' style="width: 20px; background-color: #EEEEEE;">
                    <strong>规<br />
                        划<br />
                        情<br />
                        况 </strong>
                </td>
                <td style="width: 131px; background-color: #EEEEEE; border-right:0px;" align='right'>
                    <span style="color: red">*</span>符合规划面积：</td>
                <td style="width: 260px; border-top:0px; border-left:#000000 solid 1px;" >
                    <input type='text' id="fhghmj" name="fhghmj" style="width: 95%" maxlength="20" title="符合规划面积与不符合规划面积两者必须填写一项，并且：符合规划面积+不符合规划面积=地块面积" /></td>
                <td style="width: 127px; background-color: #EEEEEE" align='right'>
                    <span style="color: red">*</span>不符合规划面积：</td>
                <td style="width: 263px">
                    <input type='text' id="bfhghmj" name="bfhghmj" style="width: 98%" maxlength="20"  title="符合规划面积与不符合规划面积两者必须填写一项，并且：符合规划面积+不符合规划面积=地块面积"  /></td>
        	</tr>
			<tr style="background-color: white; height: 25px">
                <td align='right' colspan='3' style="background-color: #EEEEEE">
                    其中基本农田面积：</td>
                <td>
                    <input type='text' id="qzjbnt" name="qzjbnt" style="width: 98%" maxlength="20" title="占用基本农田面积必须小于或等于不符合规划面积" /></td>
            </tr>
			<tr style="background-color: white; height: 25px">
                <td align='right' style="background-color: #EEEEEE" rowspan="3">
                    <span style="color: red">*</span>项目类型：</td>
                <td>
                    是否国家重点工程（<input type="radio" id='gjzdgc' name="gjzdgc" value='0'  />是
                    &nbsp;<input type='radio' id='gjzdgc' name="gjzdgc" value='1'  />否）
                </td>
                <td align='right' style="background-color: #EEEEEE"><span id="span2">立项批准机关：</span></td>
                <td>
                    <input type='text' id="lxpzjg" style="width: 98%" maxlength="200" /></td>
                
            </tr>
            <tr style="background-color: white; height: 25px">
                <td>
                    是否省级重点工程（<input type="radio" id='sjzdgc' name="sjzdgc" value='0'  />是
                    &nbsp;<input type='radio' id='sjzdgc' name="sjzdgc" value='1'  />否）
                </td>
                <td align='right' style="background-color: #EEEEEE"><span id="span3">立项机关级别：</span></td>
                <td>
                    <select style='width:95%' id="lxjgjb" name="lxjgjb"><option value='0'></option><option value='1'>国家级</option><option value='2'>省级</option></select>
                </td>                
            </tr>
			<tr style="background-color: white; height: 25px">
                <td>
                    其他项目（<input type="radio" id='qtxm' name="qtxm" value='0'  />是
                    &nbsp;<input type='radio' id='qtxm' name="qtxm" value='1' >否）
                </td>
                <td align='right' style="background-color: #EEEEEE"><span id="span130">国家重点工程</span>&nbsp;&nbsp;&nbsp;&nbsp;<br/>
                    立项批准文号：</td>
                <td>
                    <input type='text' id="gjpzwh" name="gjpzwh" style="width: 98%" maxlength="50" /></td>                
            </tr>
		</table>
		<table id="table4" style="background-color: #000000; width: 800px; border-top:0px;" cellspacing="0" cellpadding="0" border="0" align='center'>
            <tr style="background-color: #99ccff; height: 25px">
                <td align="center">
                    <span style='font-size: 12.0pt; font-family: 黑体'>用地手续办理情况</span></td>
            </tr>
      	</table>
		<table id="table4" style="background-color: #FFFFFF; width: 800px; border-top:0px;" cellspacing="0" cellpadding="0" border="0" align='center'>
	       <tr style="background-color:#99ccff;height:25px">
		      <td colspan='7'><strong>用地手续办理情况（已取得的用地手续情况）</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   </tr>
	       <tr style="background-color:white;height:20px">
		       <td style="width:120px;" align='center'>审批类型</td>
               <td style="width:180px" align='center'>批准机关</td>
               <td style="width:250px" align='center'>批准文号</td>
               <td style="width:60px" align='center'>批准时间</td>
               <td style="width:70px" align='center'>批准面积</td>
               <td style="width:90px" align='center'>其中耕地面积</td>
           </tr> 
		   <tr>
		   		<td>
					<input type="text" id="splx" name="splx" style="width:99%;" />
				</td>
		   		<td>
					<input type="text" id="ydsxpzjg" name="ydsxpzjg" style="width:99%" />
				</td>
				<td>
					<input type="text" id="pzwh" name="pzwh" style="width:99%" />
				</td>
				<td>
					<input type="text" id="pzsj" name="pzsj" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:99%" />
				</td>
				<td>
					<input type="text" id="pzmj" name="pzmj" style="width:99%" />
				</td>
				<td>
					<input type="text" id="ydsxqzgdmj" name="ydsxqzgdmj" style="width:99%" />
				</td>
		   </tr> 
		   <tr style="background-color:#99ccff;height:25px">
		      <td colspan='6'><strong>用地手续办理情况（未取得用地手续情况）</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   </tr>
        </table>
		<table id="table4" style="background-color: #FFFFFF; width: 800px; border-top:0px;" cellspacing="0" cellpadding="0" border="0" align='center'>
			<tr style="background-color: white; height: 20px">
                <td style="background-color: #EEEEEE" align='center' rowspan="4" width="30%">
                    上<br />
                    报<br />
                    情<br />
                    况<br />                    </td>
                <td style="background-color: #EEEEEE" align='center' rowspan="2" width="15%">
                    有权批准机关</td>
                <td align='center' rowspan="2" width="25%">
                    <select style='width:95%' id="yqpzjg" name="yqpzjg"><option value='0'></option><option value='1'>国务院</option><option value='2'>省级人民政府</option><option value='3'>地市级人民政府</option></select>    			</td>
                <td style="background-color: #EEEEEE" align='center' rowspan="2" width="10%">
                    部受理时间及受理文号</td>
                <td align='center' width="28%"><input type='text' id="bslsj" name="bslsj" style="width: 95%" maxlength="7" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" /></td>               
            </tr>
			<tr style="background-color: white; height: 20px">
                <td align='center'>
                   <input type='text' id="blywh" name="blywh"  maxlength="200" style="width: 95%"/>                </td>
            </tr>
			<tr style="background-color: white; height: 20px">
                <td style="background-color: #EEEEEE" align='center' rowspan="2">
                    省级受理时间及受理文号</td>
              <td align='center' ><input type='text' id="sslsj" name="sslsj" style="width: 95%" maxlength="10"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" title="省级受理时间”应早于“部级受理时间”"  /></td>
                
                <td style="background-color: #EEEEEE" align='center' rowspan="2">
                    市级受理时间及受理文号</td>
                <td align='center' ><input type='text' id="sslsj" name="shislsj" style="width: 95%" maxlength="10"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" title="市级受理时间”应早于“省级受理时间”"  /></td>
            </tr>
			 <tr style="background-color: white; height: 20px">
                <td align='center'><input type='text' id="sslwh" name="sslwh" style="width: 95%"  /></td>
                <td align='center'>
                   <input type='text' id="shislwh" name="shislwh"  maxlength="200"  style="width: 95%" />                </td>
            </tr>
                        
            <tr style="background-color: white; height: 20px">
                <td style="background-color: #EEEEEE" align='center'>
                    未上报                </td>
                <td style="background-color: #EEEEEE" align='center'>
                    耕地占补平衡<br />
                    是否落实</td>
                <td align='left' >
                    <input type="radio" id='gdzbph' name="gdzbph" value='0'  />是
                     &nbsp;<input type='radio' id='gdzbph' name="gdzbph" value='1'  />否</td>
                <td style="background-color: #EEEEEE" align='center'>
                    征地补偿是否到位</td>
                <td align='left' >
                    <input type="radio" id='zdbcdw' name="zdbcdw" value='0'  />是
                    &nbsp;
                    <input type='radio' id='zdbcdw' name="zdbcdw" value='1'  />否</td>
            </tr>
			<tr style="background-color: white; height: 20px">
                <td align='center' style="background-color: #EEEEEE" colspan="2" >
                    是否符合国家产业政策（<input type="radio" id='fhgjcyzc' name="fhgjcyzc" value='0'  />是
                    &nbsp;<input type='radio' id='fhgjcyzc' value='1' name="fhgjcyzc" />否）</td>
                <td align='center'  style="background-color: #EEEEEE" colspan="2" >
                    产业类型名称</td>
                <td align="left" >
                <select name="cylxmc" id="cylxmc" style="width:95%;">
					<option value=""></option>
					<option value="1">农林业</option>
					<option value="2">水利</option>
					<option value="3">煤炭</option>
					<option value="4">电力</option>
					<option value="5">核能</option>
					<option value="6">石油、天然气</option>
					<option value="7">钢铁</option>
					<option value="8">有色金属</option>
					<option value="9">化工</option>
					<option value="10">建材</option>
					<option value="11">医药</option>
					<option value="12">机械</option>
					<option value="13">汽车</option>
					<option value="14">船舶</option>
					<option value="15">航空航天</option>
					<option value="16">轻工</option>
					<option value="17">纺织</option>
					<option value="18">建筑</option>
					<option value="19">城市基础设施及房地产</option>
					<option value="20">铁路</option>
					<option value="21">公路</option>
					<option value="22">水运</option>
					<option value="23">航空运输</option>
					<option value="24">信息产业</option>
					<option value="25">其他服务业</option>
					<option value="26">环境保护与资源节约综合利用</option>
				</select></td>
            </tr>
			<tr style="background-color:#99ccff;height:25px">
		      <td colspan='5'><strong>其他用地手续情况</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   </tr>
		   <tr style="background-color: white; height: 20px">
               <td style="background-color: #EEEEEE" align='left' valign=middle>
                    是否部批准城乡建设用地增减挂钩试点(<input type="radio" id='bpzcxjsydsd' name="bpzcxjsydsd" value='0'  />是
                    &nbsp;<input type='radio' id='bpzcxjsydsd' name="bpzcxjsydsd" value='1'  />否)               </td>
               <td style="background-color: #EEEEEE" align='center'>增减挂钩项目区<br>批准文件</td>
                <td align='center'><input type='text' id="zjggxmqpzwj" name="zjggxmqpzwj" style="width: 95%" maxlength="200" /></td>
                <td style="background-color: #EEEEEE" align='center'>批准文号</td>
                <td align='left'><input type='text' id="zjggpzwh" name="zjggpzwh" style="width: 95%" maxlength="200"  />
          		</td>
            </tr>
			<tr style="background-color: white; height: 20px">
               <td style="background-color: #EEEEEE" align='left' valign=middle>
                    是否部批准采矿用地方式改革试点（<input type="radio" id='bpzckyd' name="bpzckyd" value='0'  />是
                    &nbsp;<input type='radio' id='bpzckyd' name="bpzckyd" value='1'  />否）               </td>
               <td style="background-color: #EEEEEE" align='center'>部批准<br>试点文件</td>
                <td align='center'><input type='text' id="bpzsdwj" name="bpzsdwj" style="width: 95%" maxlength="200" /></td>
                <td style="background-color: #EEEEEE" align='center'>批准文号</td>
                <td align='left'>
                   <input type='text' id="bpzckwh" name="bpzckwh" style="width: 95%" maxlength="200"  />
          		</td>
            </tr>
			<tr style="background-color: white; height: 20px">
               <td style="background-color: #EEEEEE" align='left' valign=middle>
                    是否部批准低丘缓坡土地综合开发利用试点(<input type="radio" id='dqhpdzhly' name="dqhpdzhly" value='0' onclick='checkbox815Click(this)' />是
                    &nbsp;<input type='radio' id='dqhpdzhly' name="dqhpdzhly" value='1' checked onclick='checkbox815Click(this)' />否)               </td>
               <td style="background-color: #EEEEEE" align='center'>部批准<br>试点文件</td>
                <td align='center'><input type='text' id="dqhpbpzsdwj" name="dqhppzsdwj" style="width: 95%" maxlength="200"  /></td>
                <td style="background-color: #EEEEEE" align='center'>批准文号</td>
                <td align='left'>
                   <input type='text' id="dqhppzwh" name="dqhppzwh" style="width: 95%" maxlength="200"  />
              	</td>
            </tr>
			<tr style="background-color: white; height: 20px">
                <td align='center' colspan="2" style="background-color: #EEEEEE">
                    是否保障性安居工程违法建设用地<br/>（<input type="radio" id='bzxajgcwfjsyd' name="bzxajgcwfjsyd" value='0'  />是
                    &nbsp;<input type='radio' id='bzxajgcwfjsyd' name="bzxajgcwfjsyd" value='1'  />否）</td>
                <td style="background-color: #EEEEEE" align='center' colspan="1">有关证明文件</td>
                <td align='center' colspan="2"><input type='text' id="bzxzfygzmwj" name="bzxzfygzmwj" style="width: 95%" maxlength="200"  /></td>
                    
                <!--<td align='left' colspan="3">
                   情况说明：【<span id='Span2' style="color: Red">0/1000</span>】<br />
                    <textarea id="Textarea4" cols="68" datafld="anjudesc" datasrc="#XmlDoc" onblur="TextAreaOnKeypress(this)"
                        onkeyup="TextAreaOnKeypress(this)" rows="4"></textarea>
                </td>-->
            </tr>
			            <tr style="background-color: white; height: 20px">
               <td align='center' colspan="2" style="background-color: #EEEEEE">
                    是否灾后重建项目用地<br/>（<input type="radio" id='zhcjyd' name="zhcjyd" value='0'  />是
                    &nbsp;<input type='radio' id='zhcjyd' name="zhcjyd" value='1'  />否）               </td>
                <td style="background-color: #EEEEEE" align='center' colspan="1">批准文件</td>
                <td align='center' colspan="2"><input type='text' id="chcjydpzwj" name="chcjydpzwj" style="width: 95%" maxlength="200" /></td>
            </tr>
			            <tr style="background-color: white; height: 20px">
                <td align='center' colspan="2" style="background-color: #EEEEEE">
                    是否法律法规规定的紧急用地<br/>（<input type="radio" id='flfgjjyd' name="flfgjjyd" value='0' />是
                    &nbsp;<input type='radio' id='flfgjjyd' name="flfgjjyd" value='1' />否）</td>
                <td align='left' colspan="3">
                   紧急用地情况说明：<br />
                    <textarea id="jjydqksm" name="jjydqksm" cols="68"   rows="4"></textarea></td>
            </tr>
		</table>
		<table id="table4" style="background-color: #FFFFFF; width: 800px; border-top:0px;" cellspacing="0" cellpadding="0" border="0" align='center'>
			            <tr style="background-color: white; height: 25px">
                <td align='center' rowspan='10' style="width: 20px; background-color: #EEEEEE" id="td0005">
                    <strong>违<br />
                        法<br />
                        情<br />
                        况 </strong>                </td>
                <td style="background-color: #EEEEEE" align='right'>
                    <span style="color:red">*</span>违法主体：				</td>
                <td colspan="5" style="width:60px;"  >
                    <input type='text' id="wfzt" name="wfzt" style="width: 98%"   />				</td>      
            </tr>
			<tr>
				<td align="right" style="background-color: #eeeeee;">
                    <span style="color: red">*</span>建设现状：</td> 
				<td colspan="5">
                    <select name="jsxz" id="jsxz" style="width:30%;">
						<option value=""></option>
						<option value="1">平整土地</option>
						<option value="2">部分建成</option>
						<option value="3">全部建成</option>
					</select>				</td>   
			</tr>
			<tr style="background-color: white; height: 25px">
               <td style="width: 173px; background-color: #EEEEEE" align='right'>
                    <span style="color: red">*</span>违法主体性质：</td>
                <td colspan='5'>
                    <select name="wfztxz" id="wfztxz" >
						<option value=""></option>
						<option value="1">省、市县乡级性质主体</option>
						<option value="2">企事业单位</option>
						<option value="3">村组集体</option>
						<option value="4">个人</option>
					</select>                </td>
            </tr>
			<tr style="background-color: white; height: 25px">
                <td align='right' style="background-color: #EEEEEE">
                    <span style="color: red">*</span>违法类型：</td>
                <td colspan='5'>
                    <input type='radio' id="wflx" name="wflx" value="1" /><label
                        for="checkbox7">违法批地</label>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type='radio' id="wflx" name="wflx" value="2" /><label
                        for="checkbox8">违法占地</label>
                    <span>&nbsp;→&nbsp;</span><select name="DropDownList3" id="DropDownList3" style="width:110px;">
</select>&nbsp;&nbsp; <br>              </td>
            </tr>
			<tr style="background-color: white; height: 25px">
                <td style="width: 150px; background-color: #EEEEEE" align='right'>
                    <span style="color: red">*</span>查处情况：</td>
                <td colspan="5">                    
                    <input type='radio' id='ccqk' name="ccqk" value='0'/>立案<&nbsp;&nbsp;
                    <input type='radio' id='ccqk' name="ccqk" value='1'/>非立案处理&nbsp;&nbsp;
                    <input type='radio' id='ccqk' name="ccqk" value='2' />未处理</td>   
            </tr>
			<tr id="wf5" style="height: 25px; background-color: white">
				<td align="right" valign="middle" style="width: 150px; background-color: #EEEEEE" ><span id="span765">非立案处理说明:</span></td>
				<td height="60" colspan="5" >
					<textarea cols="86" id="flaclsm" name="flaclsm" style="width: 98%; height: 60px" ></textarea>				</td>
          </tr>
		  <tr id="wf5" style="height: 25px; background-color: white">
				<td align="right" valign="middle" style="width: 150px; background-color: #EEEEEE" ><span id="span765">复耕到位耕地面积:</span></td>
				<td colspan="5">
					<input type="text" id="fgdwmj" name="fgdwmj"  style="width:99%" />				</td>
          </tr>
		  <tr style="background-color: white; height: 25px">
                <td style="width: 150px; background-color: #EEEEEE" align='right'>
                    是否巡查发现：</td>
                <td style="width: 260px">
                    <input type='radio' id='sfxcfx' name="sfxcfx" value='0' /><label
                        >是</label>&nbsp;&nbsp;<input type='radio' id='sfxcfx' name="sfxcfx" value='1' /><label >否</label></td>
                <td style="width: 130px; background-color: #EEEEEE" align="right">
                    发现时间：</td>
                <td style="width: 260px" colspan="3">
                    <input type='text' id="xcfxsj" style="width: 95%" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" maxlength="7" /></td>
          </tr>
		   <tr style="background-color: white; height: 25px">
                <td style="width: 150px; background-color: #EEEEEE" align='right'>
                    是否下达停工通知书：</td>
                <td style="width: 260px">
                    <input type='radio' id='xdtgtzs' name="xdtgtzs" value='0' /><label>是</label>&nbsp;&nbsp;
                    <input type='radio' id='xdtgtzs' name="xdtgtzs" value='1' /><label>否</label></td>
                <td style="width: 130px; background-color: #EEEEEE" align="right">
                    下达时间：</td>
                <td style="width: 260px" colspan="3"><input type='text' id="xdtgtzssj" name="xdtgtzssj" style="width: 95%" maxlength="7" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" /></td>
           </tr>
		   <tr style="background-color: white; height: 25px">
                <td style="width: 150px; background-color: #EEEEEE" align='right'>
                    是否报告：</td>
                <td style="width: 260px">
                    <input type='radio' id='bg' name="bg" value='0' /><label>是</label>&nbsp;&nbsp;<input type='radio' id='bg' name="bg" value='1'
                             /><label>否</label></td>
                <td style="width: 130px; background-color: #EEEEEE" align="right">
                    报告时间：</td>
                <td style="width: 260px"><input type='text' id="bgsj" name="bgsj" style="width: 95%" maxlength="7" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" /></td>
                <td style="width: 130px; background-color: #EEEEEE" align="right">
                    文&nbsp; 号：</td>
                <td style="width: 260px"><input type='text' id="bgwh" name="bgwh" style="width: 98%" maxlength="100"  /></td>
           </tr>
		   <tr>
		   		<td colspan="2" align="right" style="background-color:#eeeeee"">
					<label>
						备注:					</label>				</td>
		   		<td colspan="5">
					<textarea id="bz" name="bz" style="width:99%;" ></textarea>				</td>
		   </tr>
		</table>
  	</form>
  </body>
  <script type="text/javascript">
  	<%
		String msg = (String)request.getParameter("msg");
	%>

	if("<%=msg%>" == "success"){
		// Ext.MessageBox.alert("", "表单保存成功"); 
		alert("表单保存成功"); 
	}
  </script>
</html>
