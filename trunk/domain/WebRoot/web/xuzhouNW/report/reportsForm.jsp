<%@page import="com.klspta.web.jinan.report.ReportManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/base/include/formbase.jspf"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String tzId=request.getParameter("tzId");
Map<String,String> map=null;
if(tzId!=null)
	map=ReportManager.getInstance().getReportBeanById(tzId).getValues();

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>台账</title>

<script type="text/javascript" src="web/jinan/report/js/DatePicker.js"></script>
<script language="javascript">

var keys=<%=map==null?"[]":map.get("key")%>;
var values=<%=map==null?"[]":map.get("value")%>;
function doAction(method)
{
	var location=window.location;
	if(document.getElementById("TZID").value=="")
	{
		alert("请输入序号");
		return;
	}
	var action=document.forms[0].action;
	if(action.indexOf("service/rest")==-1)
		document.forms[0].action=action+"service/rest/reportAction/"+method;
	document.forms[0].submit();
	if(keys.length==0)
		location+="?tzId="+document.getElementById("TZID").value;
	window.location=location;
}
function save()
{
	 doAction('save');
}

function setValue()
{
	var ele;
	var index=0
	for(var i=0;i<keys.length;i++)
	{
		ele=document.getElementById(keys[i]);
		if(ele.options==undefined)
		{
			
			if(ele.value!=undefined)
				ele.value=values[i];
			else
				ele.innerHTML=values[i];
		}
		else
		{
			for(var j=0;j<ele.options.length;j++)
			{
				
				if(values[i]==ele.options[j].value)
				{	
					ele.selectedIndex=j;
					break;
				}
			}
		}
	}
}
function saveFix()
{
	
	document.getElementById("fixed").style.top=(document.body.scrollTop+5)+"px";
}

function isNumberT(obj)
{
	
	if(obj.value!="")
	{
		var reg=/^\d+((\.\d+)|(\d{0,}))$/;
		if(!reg.test(obj.value))
		{
			alert("请输入正确的数字");
			obj.focus();
		}
		
	}
}
window.onload=function()
{
	init();
	setValue();
	window.onscroll=saveFix;
	
	
}


</script>
<style type="text/css">
<!--

table
{
	border-top:1px solid #2C2B29;
	border-left:1px solid #2C2B29;
	background-color:#ffffff;
	margin-bottom:10px;

}
table tr td
{
	border-right:1px solid #2C2B29;
	border-bottom:1px solid #2C2B29;
	padding:5px 10px 5px 5px;
}
.title
{
	text-align:right;
}


-->
</style>

</head>
<div id="fixed" class="Noprn"
			style="position:absolute; top: 5px; left: 10px"></div>
<div class="container">


 <form action="<%=basePath%>" method="post">
	<span style="font-weight:bold;font-size:26px;display:block;margin-bottom:10px;">违法用地台账</span>
	<span style="display:block;width:762px;font-size:14px;text-align:right;margin-bottom:3px;">上报情况：<span id="SB">未上报</span></span>
	<table cellpadding="0" cellspacing="0" border="0" width="762" style= "word-break:break-all;   word-wrap:   break-word; ">		
		<tr>
			<td class="title" colspan="2" width="200" >序号  <span style="color:red;">*</span></td>
			<td colspan="4" width="560"><input type="text" id="TZID" name="TZID" /></td>

		</tr>
		<tr>
			<td  class="title"  colspan="2" width="200">违法用地项目名称</td>
			<td colspan="4" width="560"><input type="text" name="WFYDXMMC" id="WFYDXMMC" /></td>
		</tr>
		<tr>
			<td  class="title"  width="200" colspan="2">违法用地主体</td>
			<td width="180"><input type="text" name="WFYDZT" id="WFYDZT"/></td>
			<td  class="title"  width="200" colspan="2">主体分类</td>
			<td width="180">
				<select style="width:170px;"  name="ZTFL" id="ZTFL">
					<option value="">--请选择--</option>
					<option value="省级">省级</option>
					<option value="市级">市级</option>
					<option value="县级">县级</option>
					<option value="乡级">乡级</option>
					<option value="村组集体">村组集体</option>
					<option value="企事业单">企事业单</option>
					<option value="个人">个人</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="title"  colspan="2">违法用地位置</td>
			<td colspan="4"><input type="text" name="WFYDWZ" id="WFYDWZ"/></td>
		</tr>
		<tr>
			<td  class="title"  rowspan="2" colspan="2">涉及土地面积</td>
			<td rowspan="2"><input type="text" name="SJTDMJ" id="SJTDMJ" onblur="isNumberT(this)"/></td>
			<td  class="title"  colspan="2">耕地面积</td>
			<td><input type="text" name="GDMJ" id="GDMJ" onblur="isNumberT(this)"/></td>

		</tr>
		<tr>
			<td  class="title"  colspan="2">基本农田面积</td>
			<td><input type="text" name="JBNYMJ" id="JBNYMJ" onblur="isNumberT(this)"/></td>
		</tr>
		<tr>
			<td  class="title"  colspan="2">违法用地用途</td>
			<td>
				<select style=width:170px;" name="WFYDYT" id="WFYDYT">
					<option value="">--请选择--</option>
					<option value="批发零售">批发零售</option>
					<option value="住宿餐饮">住宿餐饮</option>
					<option value="商务金融">商务金融</option>
					<option value="其他商服">其他商服</option>
					<option value="工业">工业</option>
					<option value="矿业">矿业</option>
					<option value="仓储">仓储</option>
					<option value="城镇住宅">城镇住宅</option>
					<option value="农村宅基地">农村宅基地</option>
					<option value="小产权房">小产权房</option>
					<option value="机关团体">机关团体</option>
					<option value="新闻出版">新闻出版</option>
					<option value="科教">科教</option>
					<option value="医卫慈善">医卫慈善</option>
					<option value="文体娱乐">文体娱乐</option>
					<option value="公共设施">公共设施</option>
					<option value="公园与绿地">公园与绿地</option>
					<option value="风景名胜设施">风景名胜设施</option>
					<option value="军事设施">军事设施</option>
					<option value="使领馆">使领馆</option>
					<option value="监教场所">监教场所</option>
					<option value="宗教">宗教</option>
					<option value="殡葬">殡葬</option>
					<option value="铁路">铁路</option>
					<option value="公路">公路</option>
					<option value="街巷">街巷</option>
					<option value="农村道路">农村道路</option>
					<option value="机场">机场</option>
					<option value="港口码头">港口码头</option>
					<option value="管道运输">管道运输</option>
					<option value="水利及相关设施">水利及相关设施</option>
					<option value="设施农用地">设施农用地</option>														
				</select>
			</td>
			<td  class="title"  colspan="2">是否符合规划</td>
			<td>
				<select style="width:170px;" id="SFFHGH" name="SFFHGH">
					<option value="">--请选择--</option>
					<option value="符合规划">符合规划</option>
					<option value="分符合规划">部分符合规划</option>
					<option value="全部不符合规划">全部不符合规划</option>
				</select>
			</td>
		</tr>
		<tr>
			<td  class="title"  colspan="2">项目类型</td>
			<td>
				<select style="width:170px;" id="XMLX" name="XMLX">
					<option value="">--请选择--</option>
					<option value="国家重点工程">国家重点工程</option>
					<option value="省重点工程">省重点工程</option>
					<option value="其他项目">其他项目</option>
					
				</select>
			</td>
			<td  class="title"  colspan="2">违法类型</td>
			<td>
				<select style="width:170px;" id="WFLX" name="WFLX">
					<option value="">--请选择--</option>
					<option value="买卖或非法转让">买卖或非法转让</option>
					<option value="破坏耕地">破坏耕地</option>
					<option value="非法占地">非法占地</option>
					<option value="非法批地">非法批地</option>
					<option value="低价出让土地">低价出让土地</option>
					<option value="其他">其他</option>
				</select>
			</td>
		</tr>
		<tr>
			<td  class="title"  colspan="2">违法性质</td>
			<td colspan="5">
				<select style="width:170px;" id="WFXZ" name="WFXZ">
					<option value="">--请选择--</option>
					<option value="未报即用">未报即用</option>
					<option value="边报边用">边报边用</option>
					<option value="未供即用">未供即用</option>			
				</select>
			</td>		
		</tr>
		<tr>
			<td  class="title"  colspan="2">违法发生时间</td>
			<td><input type="text" name="WFFSSJ" id="WFFSSJ" class="Wdate" style="width:173px;border:0;" readonly="true" onClick="setmonth(this)"></td>
			<td  class="title"  colspan="2">发现违法时间</td>
			<td><input type="text" name="WFFXSJ" id="WFFXSJ" class="Wdate" style="width:173px;border:0;" readonly="true" onClick="setmonth(this)"></td>	
		</tr>
		<tr>
			<td  class="title"  colspan="2">发现违法渠道</td>
			<td>
				<select style="width:170px;" id="FXWFQD" name="FXWFQD">
					<option value="">--请选择--</option>
					<option value="巡查">巡查</option>
					<option value="卫片执法检查">卫片执法检查</option>
					<option value="群众举报">群众举报</option>
					<option value="领导批办">领导批办</option>
					<option value="上级交办">上级交办</option>
					<option value="下级上报">下级上报</option>
					<option value="媒体反映">媒体反映</option>
					<option value="其他">其他</option>
	
						
				</select>
			</td>
			<td  class="title"  colspan="2">制止情况</td>
			<td>
				<select style="width:170px;" id="ZZQK" name="ZZQK">
					<option value="">--请选择--</option>
					<option value="停工">停工</option>
					<option value="恢复土地原状">恢复土地原状</option>
					<option value="制止无效">制止无效</option>							
				</select>
			</td>
		</tr>
		<tr>
			<td  class="title"  rowspan="3" width="50" style="padding-left:5px;">查处情况</td>
			<td  class="title"  width="150" >立案时间</td>
			<td  width="180"><input type="text" name="LASJ" id="LASJ"  class="Wdate" style="width:173px;border:0;" readonly="true" onClick="setmonth(this)"></td>
			<td  class="title"  rowspan="3" width="50" >报告情况</td>
			<td  class="title"  width="150">报告时间</td>
			<td width="180"><input type="text" id="BGSJ" name="BGSJ"  class="Wdate" style="width:173px;border:0;" readonly="true" onClick="setmonth(this)"></td><!-- WdatePicker() -->
		</tr>
		<tr>
			<td class="title" >结案时间</td>
			<td><input type="text"name="JHSJ" id="JHSJ"  class="Wdate" style="width:173px;border:0;" readonly="true" onClick="setmonth(this)"></td>
			<td class="title" >向谁报告</td>
			<td>
				<select style="width:170px;" id="XSBG" name="XSBG">
					<option value="">--请选择--</option>
					<option value="上级国土资源主管部门">上级国土资源主管部门</option>
					<option value="同级地方政府">同级地方政府</option>	
					<option value="国家土地督察机构">国家土地督察机构</option>								
				</select>
				</td>
		</tr>
		<tr>
			<td  class="title" >非立案处理情况</td>
			<td>
				<select style="width:170px;" id="FLACLQK" name="FLACLQK">
					<option value="">--请选择--</option>
					<option value="处理到位">处理到位</option>
					<option value="处理不到位">处理不到位</option>								
				</select>
			</td>
			<td  class="title" >报告文号</td>
			<td><input type="text" name="BGWH" id="BGWH"></td>
		</tr>
		<tr>
			<td  class="title"  colspan="2">本年发生还是历年隐漏</td>
			<td colspan="4"><input type="text" name="BNFSHSLNYL" id="BNFSHSLNYL"></td>			
		</tr>

		<tr height="50">
			<td  colspan="6" style="text-align: center;">处罚决定情况及落实情况</td>			
		</tr>
		<tr>
			<td  class="title"  colspan="2">立案编号</td>
			<td colspan="4"><input type="text" name="LABH" id="LABH"></td>
		</tr>
		<tr>
			<td  class="title"  colspan="2">处罚决定编号</td>
			<td colspan="4"><input type="text" name="CFJDBH" id="CFJDBH"></td>
		</tr>	
	
		<tr>
			<td  class="title"  rowspan="6" >下达处罚决定情况</td>
			<td  class="title" >罚款金额</td>
			<td><input type="text" name="FKJE" id="FKJE" onblur="isNumberT(this)"></td>
			<td  class="title"  rowspan="6">实际落实处罚决定情况</td>
			<td  class="title" >罚款金额</td>
			<td><input type="text" name="LSFKJE" id="LSFKJE" onblur="isNumberT(this)"></td>
		</tr>
		<tr>
			<td  class="title" >没收非法所得金额</td>
			<td><input type="text" name="MSFFSDJE" id="MSFFSDJE" onblur="isNumberT(this)"></td>
			<td  class="title" >没收非法所得金额</td>
			<td><input type="text" name="LSMSFFSDJE" id="LSMSFFSDJE" onblur="isNumberT(this)"></td>
		</tr>
		<tr>
			<td  class="title" >拆除建筑物面积</td>
			<td><input type="text" name="CCJZWMJ" id="CCJZWMJ" onblur="isNumberT(this)"></td>
			<td  class="title" >拆除建筑物面积</td>
			<td><input type="text" name="LSCCJZWMJ" id="LSCCJZWMJ" onblur="isNumberT(this)"></td>
		</tr>
		<tr>
			<td  class="title" >没收建筑物面积</td>
			<td><input type="text" name="MSJZWMJ" id="MSJZWMJ" onblur="isNumberT(this)"></td>
			<td  class="title" >没收建筑物面积</td>
			<td><input type="text" name="LSMSJZWMJ" id="LSMSJZWMJ" onblur="isNumberT(this)"></td>
		</tr>
		<tr>
			<td  class="title" >交还土地面积</td>
			<td><input type="text" name="JHTDMJ" id="JHTDMJ" onblur="isNumberT(this)"></td>
			<td  class="title" >交还土地面积</td>
			<td><input type="text" name="LSJHTDMJ" id="LSJHTDMJ" onblur="isNumberT(this)"></td>
		</tr>
		<tr>
			<td  class="title" >退地面积</td>
			<td><input type="text" name="TDMJ" id="TDMJ" onblur="isNumberT(this)"></td>
			<td  class="title" >退地面积</td>
			<td><input type="text" name="LSTDMJ" id="LSTDMJ" onblur="isNumberT(this)"></td>
		</tr>
		<tr>
			<td  class="title"  rowspan="2" style="padding:0;text-align:center;" >追究党纪政纪责任情况</td>
			<td  class="title" >提出建议</td>
			<td><input type="text" name="DZZRTCJY" id="DZZRTCJY"></td>
			<td  class="title"  rowspan="2" style="padding:0;text-align:center;">追究刑事责任情况</td>
			<td  class="title" >提出建议</td>
			<td><input type="text" name="XSZRTCJY" id="XSZRTCJY"></td>
		</tr>
		<tr>
			<td  class="title" >实际移送</td>
			<td><input type="text" name="DZZRSJYS" id="DZZRSJYS"></td>
			<td  class="title" >实际移送</td>
			<td><input type="text" name="XSZRSJYS" id="XSZRSJYS"></td>
		</tr>
		<tr>
			<td class="title"  colspan="2">申请法院强制执行时间</td>
			<td colspan="4"><input type="text" name="QZZXSJ" id="QZZXSJ" class="Wdate" style="width:173px;border:0;" readonly="true" onClick="setmonth(this)"></td>			
		</tr>
		<tr>
			<td class="title"  colspan="2">地区</td>
			<td colspan="4">
					<select name="DQ"  style="width:170px;" id="DQ" >
					<%=ReportManager.getInstance().getAreaSelectCode(userId)%>
				</select>						
			</td>			
		</tr>
				
			
		<tr>
			<td class="title"  colspan="2">重点情况</td>
			<td colspan="4"><textarea id="ZDQK" name="ZDQK"></textarea></td>			
		</tr>	
		<tr>
			<td class="title"  colspan="2">备注</td>
			<td colspan="4"><textarea id="BZ" name="BZ"></textarea></td>			
		</tr>
	</table>
	
	<input type="button" value="保存" onclick="doAction('save')"/>
	
	<input type="button" value="上报" style="margin-left:30px;" onclick="doAction('reportToSuperior')"/>
	</form>
</div>
</body>
</html>