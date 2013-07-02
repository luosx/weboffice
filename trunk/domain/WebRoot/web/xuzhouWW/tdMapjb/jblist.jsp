

<html>
<head>
<base href="http://www.xzmap.gov.cn/landXZ/">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台管理</title>
 
<link rel="stylesheet" href="http://www.xzmap.gov.cn/landXZ/map/list_images/listcss.css" type="text/css" media="screen" />
<link rel="stylesheet" type="text/css" href="http://www.xzmap.gov.cn/landXZ/lib/jquery.fancybox-1.3.4/fancybox/jquery.fancybox-1.3.4.css" media="screen"></link>
<script type="text/javascript" src="http://www.xzmap.gov.cn/landXZ/lib/jQuery/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="http://www.xzmap.gov.cn/landXZ/lib/jquery.fancybox-1.3.4/fancybox/jquery.mousewheel-3.0.4.pack.js"></script>
<script type="text/javascript" src="http://www.xzmap.gov.cn/landXZ/lib/jquery.fancybox-1.3.4/fancybox/jquery.fancybox-1.3.4.pack.js"></script>


<script type="text/javascript">
	$(document).ready(function(){
		$.post("http://www.xzmap.gov.cn/landXZ/map/cmsnewsgetALL.action",null,function(result){
					var data=$.parseJSON(result);
					//var data=json_decode(result)
						data=data.data;
						var str='';
						for(var i = 0 ; i < data.length ; i ++){
							str+='<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0"><tr>';
							if(data[i].imageUrl==""){
								str+='<td width="80" height="80" class="list_wz_c">'+i+'</td>';
								str+='<td width="160" class="center"><a href="http://www.xzmap.gov.cn/landXZ/'+getvalue(data[i].imageUrl)+'" id="popupImage"><img src="http://www.xzmap.gov.cn/landXZ/'+getvalue(data[i].imageUrl)+'" width="109" height="66" /></a></td>';
								str+='<td width="200" class="list_wz_l">'+getvalue(data[i].brief)+'</td>';
								str+='<td width="180" class="list_wz_l">经度:'+data[i].x+'<br /><br />纬度:'+data[i].y+'</td>';
								str+='<td width="240" class="list_wz_l">举报人:'+getvalue(data[i].name)+'<br />电话:'+getvalue(data[i].phone)+'<br />邮箱:'+getvalue(data[i].email)+'</td>';
								str+='<td width="86" class="center"><a href="javascript:void(0)" id='+getvalue(data[i].id)+' onclick="deleteObj(this);"><img src="list_images/close-2.png" width="24" height="24" /></a></td>';
							}else{								
								str+='<td width="80" height="80" class="list_wz_c">'+i+'</td>';
								str+='<td width="160" class="center"><div><a href="..'+getvalue(data[i].imageUrl)+'" id="popupImage"><img src="..'+getvalue(data[i].imageUrl)+'" width="109" height="66" /></a></div></td>';
								str+='<td width="200" class="list_wz_l">'+getvalue(data[i].brief)+'</td>';
								str+='<td width="180" class="list_wz_l">经度:'+data[i].x+'<br /><br />纬度:'+data[i].y+'</td>';
								str+='<td width="240" class="list_wz_l">举报人:'+getvalue(data[i].name)+'<br />电话:'+getvalue(data[i].phone)+'<br />邮箱:'+getvalue(data[i].email)+'</td>';
								str+='<td width="86" class="center"><a href="javascript:void(0)" id='+getvalue(data[i].id)+' onclick="deleteObj(this);"><img src="http://www.xzmap.gov.cn/landXZ/map/list_images/close-2.png" width="24" height="24" /></a></td>';
							}
							str+='</tr><tr><td colspan="6" class="list_line"></td></tr></table>';
						}
						$("#data").html(str);
						$("a#popupImage").fancybox({
							'padding'			: 0,
							'autoScale'			: true,
							'transitionIn'		: 'elastic',
							'transitionOut'		: 'none',
							'type'    : 'image'
						});
				});
	})
	
	function getvalue(s){
		return unescape(s)
	}
	
	function deleteObj(obj){
		var id=obj.id;
		form2.action="cmsnewsdelMessage.action?massageId="+id;
		form2.submit();
	}
 
	</script>
	<script type="text/javascript">  
		function callback(msg){
  			alert(msg);
		}  
	</script>
</head>

<body>
   
   <div class="container"><table width="948" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="80" class="list_title_c">序号</td>
    <td width="160" class="list_title_c">图片</td>
    <td width="200" class="list_title_l">详细信息</td>
    <td width="180" class="list_title_l">经纬度</td>
    <td width="240" class="list_title_l">举报人信息</td>
    <td width="86" class="list_title_c">删除</td>
  </tr>
</table></td>
  </tr>
  <tr>
    <td>
    	<div id="data">
    	<!-- 
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
           <tr>
            <td width="80" height="80" class="list_wz_c">1</td>
            <td width="160" class="center"><a href="#"><img src="list_images/upload1.jpg" width="109" height="66" /></a></td>
            <td width="200" class="list_wz_l">1111111111111111111</td>
            <td width="180" class="list_wz_l">经度117.24016267251761<br /><br />纬度34.256701607313836</td>
            <td width="240" class="list_wz_l">姓名GG<br />电话13409870987<br />邮箱mikeking508@gmail.com</td>
            <td width="86" class="center"><a href="#"><img src="list_images/close-2.png" width="24" height="24" /></a></td>
          </tr>
          <tr>
            <td colspan="6" class="list_line"></td>
          </tr>
       </table>
        -->
       </div>
     </td>
  </tr>
</table>

</div>  
   <div class="clearfloat"></div>
   <div class="bottomcontainer"></div>
   
   <script type="text/javascript">  
		
	</script>
</body>


</html>
