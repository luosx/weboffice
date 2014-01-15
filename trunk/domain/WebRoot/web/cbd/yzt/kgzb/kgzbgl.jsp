<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>控规指标管理</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf" %>
		<%@ include file="/base/include/restRequest.jspf" %>

<style type="text/css">
table {
	border: 1px solid #000000;
	padding: 0;
	margin: 0 auto;
	border-collapse: collapse;
    table-layout:fixed;
}

td {
	border: 1px solid #000000;
	background: #fff;
	font-size: 12px;
	padding: 3px 3px 3px 8px;
	color: #000000;
	text-align: center;
}
input{
border:none;
height: 25px;
}

td1 {
	border: 1px solid #000000;
	background: #adadad;
	font-size: 13px;
	padding: 3px 3px 3px 8px;
	color: #fdfdfd;
}

.tr01 {
	background-color:#BCD2EF;
	font-weight: bold;
	line-height: 30px;
	text-align: center;
}
.tr02 {
	background-color:#FFCC99;
	font-weight: bold;
	line-height: 30px;
	text-align: center;
}
.tr03 {
	background-color:#FFCC99;
	line-height: 20px;
	text-align: center;
}
.tr04 {
	background-color:#CCFFFF;
	line-height: 30px;
	text-align: center;
}
.tr05 {
	background-color:#FFF69A;
	background-color:#FFCC99;
	line-height: 20px;
	text-align: center;
}
</style>
<script type="text/javascript">

</script>
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0" style="overflow: scroll;">
	<div align="center"><h3>控规指标管理</h3></div>
	<li>区域划分</li>
	<table width="500px">
	<tr>
	<td class="tr01">编号</td>
	<td class="tr01">区域名称 </td>
	<td class="tr01">操作 </td>
	</tr>
	<tr>
	<td class="tr01">1</td>
	<td class="tr01">中心区 </td>
	<td class="tr01"><a>修改</a><a>删除</a> </td>
	</tr>
	<tr>
	<td class="tr01">2</td>
	<td class="tr01">东扩区 </td>
	<td class="tr01"><a>修改</a><a>删除</a></td>
	</tr>
	</table>
	<li>区域细分</li>
	<table width='1000px' align='center'>
	<tr>
	<td class='tr01'>序号</td>
	<td class='tr01'>地块名称 </td>
	<td class='tr01' colspan='2'>用地性质 </td>
	<td class='tr01'>建设用地面积（公顷）</td>
	<td class='tr01'>容积率 </td>
	<td class='tr01'>规划建筑规模（万㎡） </td>
	<td class='tr01'>建筑控制高度（米） </td>
	<td class='tr01'>建筑密度</td>
	<td class='tr01'>绿化率 </td>
	<td class='tr01'>南北纵深（米） </td>
	<td class='tr01'>东西面宽（米） </td>
	<td class='tr01'>规划数据来源 </td>
	<td class='tr01' width='80px'>备注 </td>
	</tr>
	</table>
	<table>
	<tr id='5E36CC88F8344273B419AAC73937CA5D'><td>1</td><td>A-1</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='FF3F700EDD7047ADA6DED235FCA21DCE'><td>2</td><td>A-2</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='9E9B457B3BD84A628DB71DD0D46B50D1'><td>4</td><td>A-3</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='FB36EC52AFDD49478540B26193C30541'><td>7</td><td>A-4</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='2685719AC82C48EE8DF98A4726F1DEB9'><td>11</td><td>A-5</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='D6E63C910FEC42B9BADEA621A096AF03'><td>16</td><td>A-6</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr><td colspan='2' class='tr01'>合计</td><td class='tr01'>----</td><td class='tr01'>----</td><td class='tr01'></td><td class='tr01' >0.0</td><td class='tr01'></td><td class='tr01'>----</td><td class='tr01'>----</td><td class='tr01'>----</td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'>----</td></tr><tr id='FC085AE3E40443119FA827EC0EF65B90'><td>16</td><td>C-1</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='897A0881AC974589AD0000204561BDC0'><td>17</td><td>C-2</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='B54A810E7F2143E08ECC9C024F0086A5'><td>19</td><td>C-3</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='223C0CE533664961AD06603B5D4D5417'><td>22</td><td>C-4</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='70C05776D86C4AE7AAF16A38C8812E1E'><td>26</td><td>C-5</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr><td colspan='2' class='tr01'>合计</td><td class='tr01'>----</td><td class='tr01'>----</td><td class='tr01'></td><td class='tr01' >0.0</td><td class='tr01'></td><td class='tr01'>----</td><td class='tr01'>----</td><td class='tr01'>----</td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'>----</td></tr><tr id='E751F5CDBC444F86BDEB9535DDD8E4BD'><td>26</td><td>E-2</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='927E51109D9941C38C3EF6C5349C221C'><td>27</td><td>E-3</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='A428BD41124045CA91767BB6393E4A81'><td>29</td><td>E-4</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='76A4B3FE457645B9BBF74D3BECC5962F'><td>32</td><td>E-5</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='D3BDCC21BC67419BB5E52222D547854F'><td>36</td><td>E-6</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr><td colspan='2' class='tr01'>合计</td><td class='tr01'>----</td><td class='tr01'>----</td><td class='tr01'></td><td class='tr01' >0.0</td><td class='tr01'></td><td class='tr01'>----</td><td class='tr01'>----</td><td class='tr01'>----</td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'>----</td></tr><tr id='09831B3DFD854F809080D52977126722'><td>36</td><td>D-1</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='4F798446CC694D2EAA1BC75E93DF92F2'><td>37</td><td>D-2</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='77C3161B80204312BE1520618551EE2F'><td>39</td><td>D-3</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='9A8CED7553EC4664B6C0A5D73D8BC677'><td>42</td><td>D-4</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='B8F24BC8286E4D528C087CF9BB514DF5'><td>46</td><td>D-5</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='5EFDD66E129245E6B50982B2CFC26434'><td>51</td><td>D-6</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr><td colspan='2' class='tr01'>合计</td><td class='tr01'>----</td><td class='tr01'>----</td><td class='tr01'></td><td class='tr01' >0.0</td><td class='tr01'></td><td class='tr01'>----</td><td class='tr01'>----</td><td class='tr01'>----</td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'>----</td></tr><tr id='2CF381745DF947F3BBB91CAF2A1440AD'><td>51</td><td>B-1</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='402D880F8F444D1987D0BBB0FC1F6C68'><td>52</td><td>B-2</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='8B7E2AD10C7B462DB87A1C70E394E777'><td>54</td><td>B-3</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='C10ADD46085F45C7BD24E800D4890DF9'><td>57</td><td>B-4</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='9E6726E5CE35434FB688828C3DB79365'><td>61</td><td>B-5</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='D145EECE160F418C813C6579E4B2FA5A'><td>66</td><td>B-6</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='F211372D76534576B269F40A5697D88C'><td>72</td><td>B-7</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr id='1DC33C7F66D7478E9B120184E1AEFFE3'><td>79</td><td>B-24</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a>修改</a><a>删除</a><td></tr><tr><td colspan='2' class='tr01'>合计</td><td class='tr01'>----</td><td class='tr01'>----</td><td class='tr01'></td><td class='tr01' >0.0</td><td class='tr01'></td><td class='tr01'>----</td><td class='tr01'>----</td><td class='tr01'>----</td><td class='tr01'></td><td class='tr01'></td><td class='tr01'>'</td><td class='tr01'>----</td></tr>
	<input id='' value=''></input>
	</table>
	</body>

</html>
