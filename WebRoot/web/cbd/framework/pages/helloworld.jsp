<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.klspta.console.user.User"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
String userId = ((User) principal).getUserID(); 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>在首页中加载提示图层</title>
    <%@ include file="/base/include/ext.jspf" %>
 	<%@ include file="/base/include/restRequest.jspf" %>
<style >
    #tip
    {
        position: absolute;
        right: 0px;
        bottom: 0px;
        height: 0px;
        width: 180px;
        border: 1px solid #CCCCCC;
        background-color: #eeeeee;
        padding: 1px;
        overflow: hidden;
        display: none;
        font-size: 12px;
        z-index: 1001;
    }
    #tip p
    {
        padding: 6px;
    }
    #tip h1, #detail h1
    {
        font-size: 14px;
        height: 25px;
        line-height: 25px;
        background-color: #0066CC;
        color: #FFFFFF;
        padding: 0px 3px 0px 3px;
        filter: Alpha(Opacity=100);
    }
    #tip h1 a, #detail h1 a
    {
        float: right;
        text-decoration: none;
        color: #FFFFFF;
    }
.winTitle{background:#9DACBF; height:20px; line-height:20px} 
.winTitle .title_left{font-weight:bold; color:#FFF; padding-left:5px; float:left} 
.winTitle .title_right{float:right} 
.winTitle .title_right a{color:#000; text-decoration:none} 
.winTitle .title_right a:hover{text-decoration:underline; color:#FF0000} 
</style>
</head>

  <script type="text/javascript">
	
	
	//展现左侧的菜单页面
	var t;
	function chooseMenu2(menu23)
	{	
		var childMenus= top.content.left.document.getElementById("menuLeftDiv").children;
	
		if(childMenus.length==0)
		{	//直到右边页面加载完成	
			t=setTimeout("chooseMenu2('"+menu23+"')",200);
		}
		else
		{
			//alert(top.content.left.document.getElementById("menuLeftDiv").children[0].children[1].children[0].id);
			//alert(top.content.left.document.getElementById("menuLeftDiv").children[0].innerHTML);
			//alert(top.content.left.document.getElementById("img_"+menu23).parentNode.outerHTML);
			//直接显示待办案件页面
			top.content.right.location.href = '<%=basePath%>' + 'web/xuzhouNW/lacc/lb/dbaj.jsp';
			
			var obj=top.content.left.document.getElementById("img_"+menu23).parentNode;
			if(obj.parentNode.parentNode.id!="menuLeftDiv")
			{			
				var menuParent=obj.parentNode;		
				menuParent.style.display="block";			
			}
			
			/*
			//非IE浏览器
			if( document.createEvent )
			{
				var evObj = document.createEvent('MouseEvents');
				evObj.initEvent( 'onclick', true, true );
				obj.dispatchEvent(evObj);
			}
			//IE浏览器
			else if( document.createEventObject )
			{
				obj.fireEvent('onclick');
			}	
			*/
			
			clearTimeout(t);
		}
	}
	
	//展现一级菜单（菜单栏）
	function chooseMenu(menu1,menu23)
	{
		//得到所有的菜单栏中的菜单
		var menus= top.menu.document.getElementById("menu0_cm").children;
		for(var i=0;i<menus.length;i++)
		{
			if(menus[i].innerHTML==menu1)
			{
				var obj=menus[i];
				if( document.createEvent )
				{
					var evObj = document.createEvent('MouseEvents');
					evObj.initEvent( 'onclick', true, true );
					obj.dispatchEvent(evObj);
				}
				else if( document.createEventObject )
				{
					obj.fireEvent('onclick');
				}			
				chooseMenu2(menu23);
				break;
			}
		}
	}
	
	function show(){
		if (parseInt(divTip.style.height)==0) 
		{   
		    divTip.style.display="block"; 
			handle = setInterval("changeH('up')",1); 
		}else 
		{ 
			handle = setInterval("changeH('down')",1) 
		} 
	}

	//改变提示框高度
	function changeH(str){
		//var obj=this.document.all?this.document.all["tip"] : this.document.getElementById("tip"); 
		if(str=="up") 
		{ 
			if (parseInt(divTip.style.height)>200) 
				clearInterval(handle); 
			else 
			divTip.style.height=(parseInt(divTip.style.height)+8).toString()+"px"; 
		} 
		if(str=="down") 
		{ 
			if (parseInt(divTip.style.height)<8) 
			{ 
				clearInterval(handle); 
				divTip.style.height="18px"; 
			} else {
				divTip.style.height=(parseInt(divTip.style.height)-8).toString()+"px"; 
			}
		} 
	}
	
	//关闭、展开窗口
	function closeWindow(){ 
		var tt=document.getElementById("closeButton").innerText;
		if(divTip.style.height=="18px"){
	  		document.getElementById("closeButton").innerText="关闭";
	  		handle = setInterval("changeH('up')",5); 
	  	}else{
	  		document.getElementById("closeButton").innerText="展开";
	 		handle = setInterval("changeH('down')",5) ;
		}
	} 

Ext.onReady(function(){
	border = new Ext.Viewport({
	layout:"border",
	items:[
		   center = new Ext.Panel({ 
	           region: 'center', // a center region is ALWAYS required for border layout
	           contentEl: 'center',
	           collapsible: false,
	           margins:'0 0 0 0'
           })
           ]
	});
	

	
	var width = 280;
	var height = 184;
	
	
});

</script>
	<body>
		<iframe id="center" name="center"  style="width: 100%; height:100%;overflow: auto;border: 0px" src="firstPageFrame.jsp"></iframe>
	</body>
</html>
