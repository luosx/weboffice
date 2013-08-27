<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
   
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>CBD区域成本及收益测算一览表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<style>
input,img {
	vertical-align: middle;
}

html,body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font: normal 13px verdana;
}

table {
	border-collapse: collapse;
	border: none;
}

td {
	border: solid #000 1px;
}
#leftright, #topdown{
position:absolute;
left:0;
top:0;
width:1px;
height:1px;
layer-background-color:#FF6905;
background-color:#FF6905;
z-index:0;
font-size:0px;
}
</style>
</head>
<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">
<h2 align="center">CBD区域成本及收益测算一览表</h2>
	<table id='planTable' border=1  style="text-align: center; font: normal 13px verdana;" width='100%'>
		<tr style='background: #C0C0C0; text-align: center; font: normal 18px verdana;'>
		<td rowspan="2">基本地块<br>编号</td>
		<td colspan="8">规划数据（公顷、万㎡）</td>
		<td colspan="6">拆迁数据（万㎡、户）</td>
		<td colspan="5">成本及收益情况(亿元、元/㎡)</td>
		<td rowspan="2">拆迁强度<br>（万㎡/公顷）</td>
		<td rowspan="2">成本<br>覆盖率</td>
		</tr>
		<tr style='background: #C0C0C0; text-align: center; font: normal 18px verdana;'>
		<td>占地</td>
		<td>建设用地</td>
		<td>容积率</td>
		<td>建筑规模</td>
		<td>规划用途</td>
		<td>公建建筑规模</td>
		<td>居住建筑规模</td>
		<td>市政建筑规模</td>
		<td>总征收规模</td>
		<td>住宅征收规模</td>
		<td>住宅征收户数</td>
		<td>户均面积</td>
		<td>非住宅征收规模</td>
		<td>非住宅家数</td>
		<td>开发成本</td>
		<td>楼面成本</td>
		<td>地面成本</td>
		<td>预计政府土地收益</td>
		<td>存蓄比</td>
		</tr>
		<tr style='background: #C0C0C0; text-align: center; font: normal 18px verdana;'>
		<td>合计</td>
		<td>34</td>
		<td>41</td>
		<td>1.1</td>
		<td>41</td>
		<td>---</td>
		<td>38</td>
		<td>18</td>
		<td>0</td>
		<td>53</td>
		<td>66</td>
		<td>1237</td>
		<td>512</td>
		<td>16</td>
		<td>64</td>
		<td>320</td>
		<td>78524</td>
		<td>82674</td>
		<td>-124</td>
		<td>-16%</td>
		<td>1.5</td>
		<td>31%</td>
		</tr>
			<tr style='background: #C0C0C0; text-align: center; font: normal 18px verdana;'>
		<td>CBD中心区小计</td>
		<td>6</td>
		<td>8</td>
		<td>1.1</td>
		<td>8</td>
		<td>----</td>
		<td>8</td>
		<td>6</td>
		<td>0</td>
		<td>14</td>
		<td>18</td>
		<td>1456</td>
		<td>128</td>
		<td>4</td>
		<td>16</td>
		<td>80</td>
		<td>78564</td>
		<td>56781</td>
		<td>-123</td>
		<td>-123%</td>
		<td>1.5</td>
		<td>40%</td>
		</tr>
			<tr >
		<td>SE10-1</td>
		<td>1</td>
		<td>2</td>
		<td>1.1</td>
		<td>2</td>
		<td>----</td>
		<td>2</td>
		<td>1</td>
		<td>0</td>
		<td>3</td>
		<td>4</td>
		<td>1456</td>
		<td>32</td>
		<td>1</td>
		<td>4</td>
		<td>20</td>
		<td>34521</td>
		<td>23432</td>
		<td>-12</td>
		<td>-103%</td>
		<td>1.5</td>
		<td>44%</td>
		</tr>
		<tr >
		<td>SE10-2</td>
		<td>2</td>
		<td>2</td>
		<td>1.1</td>
		<td>2</td>
		<td>混合</td>
		<td>2</td>
		<td>2</td>
		<td>0</td>
		<td>4</td>
		<td>5</td>
		<td>1006</td>
		<td>32</td>
		<td>1</td>
		<td>4</td>
		<td>20</td>
		<td>56114</td>
		<td>56881</td>
		<td>-120</td>
		<td>-129%</td>
		<td>1.5</td>
		<td>39%</td>
		</tr>
			<tr >
		<td>SE10-3</td>
		<td>3</td>
		<td>4</td>
		<td>1.1</td>
		<td>4</td>
		<td>混合</td>
		<td>4</td>
		<td>3</td>
		<td>0</td>
		<td>7</td>
		<td>9</td>
		<td>1006</td>
		<td>64</td>
		<td>2</td>
		<td>8</td>
		<td>40</td>
		<td>12313</td>
		<td>34324</td>
		<td>-17</td>
		<td>-145%</td>
		<td>1.5</td>
		<td>29%</td>
		</tr>
		
		<tr style='background: #C0C0C0; text-align: center; font: normal 18px verdana;'>
		<td>遗留边角地</td>
		<td>10</td>
		<td>20</td>
		<td>1.1</td>
		<td>20</td>
		<td>----</td>
		<td>20</td>
		<td>10</td>
		<td>0</td>
		<td>30</td>
		<td>40</td>
		<td>1406</td>
		<td>320</td>
		<td>10</td>
		<td>40</td>
		<td>200</td>
		<td>78004</td>
		<td>59810</td>
		<td>-123</td>
		<td>-123%</td>
		<td>1.5</td>
		<td>40%</td>
		</tr>
			<tr >
		<td>NE10</td>
		<td>7</td>
		<td>10</td>
		<td>1.1</td>
		<td>10</td>
		<td>----</td>
		<td>8</td>
		<td>1</td>
		<td>0</td>
		<td>6</td>
		<td>4</td>
		<td>1056</td>
		<td>32</td>
		<td>1</td>
		<td>4</td>
		<td>20</td>
		<td>70064</td>
		<td>45681</td>
		<td>-123</td>
		<td>-123%</td>
		<td>1.5</td>
		<td>40%</td>
		</tr>
			<tr >
		<td>NE05</td>
		<td>1</td>
		<td>2</td>
		<td>1.1</td>
		<td>2</td>
		<td>混合</td>
		<td>1</td>
		<td>3</td>
		<td>0</td>
		<td>5</td>
		<td>2</td>
		<td>1336</td>
		<td>12</td>
		<td>2</td>
		<td>5</td>
		<td>12</td>
		<td>57884</td>
		<td>64281</td>
		<td>-89</td>
		<td>-93%</td>
		<td>1.5</td>
		<td>35%</td>
		</tr>
			<tr >
		<td>NW04</td>
		<td>12</td>
		<td>13</td>
		<td>1.1</td>
		<td>13</td>
		<td>----</td>
		<td>3</td>
		<td>5</td>
		<td>0</td>
		<td>1</td>
		<td>2</td>
		<td>2100</td>
		<td>35</td>
		<td>5</td>
		<td>3</td>
		<td>20</td>
		<td>33344</td>
		<td>44431</td>
		<td>-79</td>
		<td>-78%</td>
		<td>1.5</td>
		<td>21%</td>
		</tr>
			<tr >
		<td>NE31</td>
		<td>1</td>
		<td>2</td>
		<td>1.1</td>
		<td>2</td>
		<td>混合</td>
		<td>2</td>
		<td>1</td>
		<td>0</td>
		<td>3</td>
		<td>4</td>
		<td>1456</td>
		<td>32</td>
		<td>1</td>
		<td>4</td>
		<td>20</td>
		<td>78564</td>
		<td>56781</td>
		<td>-123</td>
		<td>-123%</td>
		<td>1.5</td>
		<td>40%</td>
		</tr>
			<tr >
		<td>NW07 </td>
		<td>1</td>
		<td>2</td>
		<td>1.1</td>
		<td>2</td>
		<td>----</td>
		<td>4</td>
		<td>3</td>
		<td>0</td>
		<td>1</td>
		<td>4</td>
		<td>2326</td>
		<td>45</td>
		<td>1</td>
		<td>4</td>
		<td>23</td>
		<td>34534</td>
		<td>50081</td>
		<td>-12</td>
		<td>-99%</td>
		<td>1.5</td>
		<td>18%</td>
		</tr>
			<tr style='background: #C0C0C0; text-align: center; font: normal 18px verdana;'>
		<td>A街区小计</td>
		<td>7</td>
		<td>10</td>
		<td>1.1</td>
		<td>10</td>
		<td>----</td>
		<td>8</td>
		<td>1</td>
		<td>0</td>
		<td>6</td>
		<td>4</td>
		<td>1456</td>
		<td>32</td>
		<td>1</td>
		<td>4</td>
		<td>20</td>
		<td>78564</td>
		<td>56781</td>
		<td>-123</td>
		<td>-123%</td>
		<td>1.5</td>
		<td>40%</td>
		</tr>
			<tr >
		<td>A1区</td>
		<td>2</td>
		<td>3</td>
		<td>1.1</td>
		<td>3</td>
		<td>----</td>
		<td>1</td>
		<td>1</td>
		<td>0</td>
		<td>1</td>
		<td>2</td>
		<td>2111</td>
		<td>12</td>
		<td>0</td>
		<td>3</td>
		<td>12</td>
		<td>43324</td>
		<td>43222</td>
		<td>-13</td>
		<td>-73%</td>
		<td>1.5</td>
		<td>24%</td>
		</tr>
			<tr >
		<td>A2区</td>
		<td>3</td>
		<td>4</td>
		<td>1.1</td>
		<td>4</td>
		<td>----</td>
		<td>4</td>
		<td>0</td>
		<td>0</td>
		<td>2</td>
		<td>1</td>
		<td>1236</td>
		<td>45</td>
		<td>1</td>
		<td>6</td>
		<td>17</td>
		<td>78564</td>
		<td>56781</td>
		<td>-93</td>
		<td>-83%</td>
		<td>1.5</td>
		<td>24%</td>
		</tr>
			<tr>
		<td>A3区</td>
		<td>2</td>
		<td>3</td>
		<td>1.1</td>
		<td>3</td>
		<td>----</td>
		<td>3</td>
		<td>1</td>
		<td>0</td>
		<td>3</td>
		<td>1</td>
		<td>1456</td>
		<td>32</td>
		<td>1</td>
		<td>4</td>
		<td>20</td>
		<td>78564</td>
		<td>56781</td>
		<td>-123</td>
		<td>-123%</td>
		<td>1.5</td>
		<td>40%</td>
		</tr>
			<tr style='background: #C0C0C0; text-align: center; font: normal 18px verdana;'>
		<td>B街区小计</td>
		<td>12</td>
		<td>13</td>
		<td>1.1</td>
		<td>13</td>
		<td>----</td>
		<td>2</td>
		<td>1</td>
		<td>0</td>
		<td>3</td>
		<td>4</td>
		<td>1456</td>
		<td>32</td>
		<td>1</td>
		<td>4</td>
		<td>20</td>
		<td>78564</td>
		<td>56781</td>
		<td>-123</td>
		<td>-113%</td>
		<td>1.5</td>
		<td>40%</td>
		</tr>
			<tr >
		<td>B1区</td>
		<td>4</td>
		<td>5</td>
		<td>1.1</td>
		<td>5</td>
		<td>----</td>
		<td>2</td>
		<td>1</td>
		<td>0</td>
		<td>1</td>
		<td>1</td>
		<td>856</td>
		<td>18</td>
		<td>1</td>
		<td>2</td>
		<td>7</td>
		<td>74544</td>
		<td>23244</td>
		<td>-33</td>
		<td>-143%</td>
		<td>1.5</td>
		<td>23%</td>
		</tr>
			<tr >
		<td>B2区</td>
		<td>3</td>
		<td>5</td>
		<td>1.1</td>
		<td>5</td>
		<td>----</td>
		<td>0</td>
		<td>1</td>
		<td>0</td>
		<td>1</td>
		<td>1</td>
		<td>256</td>
		<td>13</td>
		<td>0</td>
		<td>0</td>
		<td>8</td>
		<td>23234</td>
		<td>24235</td>
		<td>-120</td>
		<td>-103%</td>
		<td>1.5</td>
		<td>47%</td>
		</tr>
			<tr>
		<td>B3区</td>
		<td>5</td>
		<td>3</td>
		<td>1.1</td>
		<td>3</td>
		<td>----</td>
		<td>0</td>
		<td>1</td>
		<td>0</td>
		<td>1</td>
		<td>2</td>
		<td>456</td>
		<td>17</td>
		<td>0</td>
		<td>2</td>
		<td>5</td>
		<td>78564</td>
		<td>56781</td>
		<td>-123</td>
		<td>-123%</td>
		<td>1.5</td>
		<td>49%</td>
		</tr>
			<tr>
		<td>B4区</td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		</tr>
	</table>
</body>
</html>
