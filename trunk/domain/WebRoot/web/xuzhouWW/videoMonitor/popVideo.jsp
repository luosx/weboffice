<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";
String carid=new String(request.getParameter("carid").getBytes("ISO-8859-1"), "utf-8");
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
    <title>车载视频</title>
    <style type="text/css">
	body{ background:#000;}
	.con{position:absolute; width:848px; height:524px; left:0px; top:0px;}
	.con *{position:absolute;}
	.con .in{left:23px; top:120px;width:393px; height:299px; overflow:hidden;border:1px solid #000;}
	.con .out{right:20px; top:120px;width:393px; height:299px; overflow:hidden;border:1px solid #000;}
	.con .title{color:#FFF;}
	</style>
    <script type="text/javascript" src="carvideojs/prototype.js"></script>
    <script type="text/javascript" src="carvideojs/nrcap2sdk.js" ></script>    
        <%@ include file="/base/include/restRequest.jspf" %>
    <%@ include file="/base/include/ext.jspf" %>
    <script type="text/javascript">
    var Debug = null;
    //var carid='<%=carid%>';
    //var path = "<%=basePath%>";
    //var actionName = "hander";
    //var actionMethod = "getCarInfo";
    //var parmeter="carids="+carid;
    //var res = ajaxRequest(path,actionName,actionMethod,parmeter); 
    //res=eval(res);
	//var _puid=res[0].CAR_FLAG;
	var _puid='151000003074961500';
	//alert(_puid);
    var MVClient ={
    		   type:"client", //'client'..'demo' 
    		   version:"v2011.10.05.1",
    		   debug:true,
    		   autoplay:true,
    		   Debug:null,
    		   connectId:null,
    		   time:new Date(),
    		   resource: new Hash(),
    		   isPlay:false,
			   isPlay2:false,//add by guorunpei 2011-11-2
    		   playWindow:null,
			   playWindow2:null,//add by guorunpei 2011-11-2
    		   vedioindex:0,
    		   audio:false,    		 
    		   loginParams:
    		   {
    		       style:"",
    		       epId:"system",
    		       path:"58.218.50.172:8866",
    		       username:"admin",
    		       password:"",
    		       areaCode:"",
    			   clientType:"",
    			   userCustomData:"",
    			   bFixCUIAddress:"1",
    			   callbackFun:function(){} 
    		   },
    		   /*页面onload事件触发*/
    		   Load:function(debugObj){    			
    			 Nrcap2.Init(new Nrcap2.Struct.InitParamStruct(true,function(msg){if(typeof debugObj != "undefined" && typeof debugObj.Note == "function") debugObj.Note(msg);}));
    			 if(Nrcap2.Plug.inited == true){
    			 	return true;
    			 }else{
    				 return false;
    			 }
    		   },
    		   /*页面onunload事件触发*/
    		   UnLoad:function(){
				  //modity by guorunpei 2011-11-2 start
				  if(MVClient.isPlay){
				  Nrcap2.StopCallTalk(MVClient.playWindow);
				  Nrcap2.StopVideo(MVClient.playWindow);
				  }
				  if(MVClient.isPlay2){
				  Nrcap2.StopVideo(MVClient.playWindow2);
				  }
    			  Nrcap2.UnLoad();
				  //modify end
    		   },
    		   /*连接视频服务器*/
    		   Login:function(){
    			   $("title0").innerHTML ="正在连接视频服务器!";
    			   $("title1").innerHTML ="正在连接视频服务器!";
    			   MVClient.connectId = Nrcap2.CreateConnect(new Nrcap2.Struct.ConnParamStruct
    		               (
      		            		 MVClient.loginParams.path,
      		            		 MVClient.loginParams.epId,
      		            		 MVClient.loginParams.username,
      		            		 MVClient.loginParams.password,
      		            		 MVClient.loginParams.areaCode, 
      		       			     MVClient.loginParams.clientType,
      		       			     MVClient.loginParams.userCustomData,
      		       			     MVClient.loginParams.bFixCUIAddress,
      		                     function(rv,vconnectId){
      		          			   if (rv == Nrcap2.NrcapError.NRCAP_SUCCESS)
      		          		       {
      		          				   MVClient.connectId = vconnectId;
      		          				  $("title1").innerHTML ="连接视频服务器成功!";
      		          				  if(MVClient.autoplay){      		          					 
      		          					MVClient.InitWindowContainers();
      		          					MVClient.PlayVideo(_puid,0,'windowbox0');	
      		          					MVClient.PlayVideo(_puid,1,'windowbox1');      		          														
      		          				  }
      		          		       }else{    		          		    	  
      		          		    	  $("title0").innerHTML ="连接视频服务器失败!";
      		          		    	  $("title1").innerHTML ="连接视频服务器失败!";
      		          		       }}
      		        		),true);      		          			      			  
    		   },   
    		   /*连接视频服务器后，回调函数*/
    		   callBackLogin:function(rv,vconnectId){
    			   if (rv == Nrcap2.NrcapError.NRCAP_SUCCESS)
    		       {
    				   MVClient.connectId = vconnectId;
    				   
    		       }else{
    		    	   alert("登录服务器失败!");
    		       }
    		   },
    		   /*退出视频服务器*/
    		   Exit:function(){
    			   Nrcap2.DisConnect(MVClient.connectId);
    			   MVClient.connectId=null;
    		   },
    		   Init:function(){
    			   if(MVClient.Load()){
    				   MVClient.Login(); 
    			   }else{
    				   alert("初始化服务器失败!");
    			   }
    			   
    		   },
    		   /*得到服务器资源,*/
    		   FetchALLResource:function(){   
    			   var puInfos =Nrcap2.FetchResource(MVClient.connectId,Nrcap2.Enum.FetchResourceLevel.Nrcap2_GetPUInfo,0,4294967295,"");    			   
    			   MVClient.InitWindowContainers();
    		   },
    		   parserResource:function(){//解释服务器资源，得到可播放的视频的ivGuid
    			   resource.each(
    		   		function(item){
    		               var node = item.value;
    		               if (node.type == Nrcap2.Enum.ResourceType.InputVideo){
    		               	ivGuid =  node.guid;
    		               	return;
    		               } 
    		           }
    		       )
    		   },
    		   FetchChildResource:function(puid){    			   
    			   var puResourcesInfos =  Nrcap2.FetchResource(MVClient.connectId,Nrcap2.Enum.FetchResourceLevel.Nrcap2_GetPUResourceInfo,0,4294967295,"",{PUID:puid});
    			  
    		   },
    		InitWindowContainers:function (){
    			var rv = Nrcap2.InitWindows();
   	        	if(rv != Nrcap2.NrcapError.NRCAP_SUCCESS)
   	        	{
                  	        
   	            	return;
   	        	}
   	        	var wndBoxs = $("windowPad").getElementsByTagName("DIV");    	        
   	        	for(var i = 0;i < wndBoxs.length;i++)
   	        	{
	   	            var wndBox = wndBoxs[i];
	   	            if(wndBox && wndBox.id.search("windowbox") != -1)
	   	            {	             
	   	                wndBox.onclick = function(){
	   	                	
						};
	   	                Nrcap2.WindowContainers.set(wndBox.id, {container : wndBox,active : false,windwow : null,description : null});	   	               
					}
			    }
   	       	},
		    PlayVideo : function(puid, ivIndex,vwindow) {
		    	MVClient.vedioindex = ivIndex;
				
					var windowEvent = new Nrcap2.Struct.WindowEventStruct();
					windowEvent.onStop.status = true;
					windowEvent.onStop.callback = function() {};
					windowEvent.onClick.status = true;
					windowEvent.onClick.callback = function() {};
					windowEvent.onStartRecord.status = true;
					windowEvent.onStartRecord.callback = function() {};
					windowEvent.onStopRecord.status = true;
					windowEvent.onStopRecord.callback = function() {};

					windowEvent.onSnapshot.status = true;
					windowEvent.onSnapshot.callback = function() {};

					windowEvent.onPTZControl.status = true;
					windowEvent.onRestore.status = true;
					windowEvent.onFullScreen.status = true;
					
					var vvwindow= Nrcap2.CreateWindow(MVClient.connectId, vwindow,windowEvent);
					
					vvwindow.SetStyle({
						enableFullScreen : true,
						enableMainPopMenu : true
					});
					vvwindow.wnd.style.visibility = "visible"; //使窗体可见  
				
				Nrcap2.PlayVideo(MVClient.connectId, vvwindow,puid, ivIndex);
				if(ivIndex=='0'){
					MVClient.playWindow = vvwindow;
					MVClient.isPlay = true;		
				}else if(ivIndex=='1'){// add by guorunpei 2011-11-2
				MVClient.playWindow2 = vvwindow;
				MVClient.isPlay2 = true;	
				}
						
			},
			PlayAudio:function(){
				Nrcap2.PlayAudio(MVClient.playWindow);				
				if(!audio){				
					Nrcap2.StartTalk(MVClient.connectId,MVClient.playWindow,0);
					audio = true;
				}else{
					Nrcap2.StopCallTalk(MVClient.connectId,MVClient.playWindow,0);
					audio = false;
				}
			},
		end : true
};
    function playCarVideo(vindex){
    	MVClient.PlayVideo(_puid,vindex);
    }
    
    function playCarAudio(){
        MVClient.PlayAudio();
        return MVClient.audio;
    	
    }
    function closeCarVideo(){
       MVClient.UnLoad();
    }
</script>   
</head>
<body onunload="MVClient.UnLoad();" onload="MVClient.Init();">
<div id="windowPad" class="con">
	<div id="windowbox1" class="in">
		<div id="window1"></div>
		<div id="title1" class="title">无视频</div>
	</div>	
	<div id="windowbox0" class="out">
		<div id="window0"></div>
		<div id="title0" class="title">无视频</div>
	</div>
</div>
  </body>
</html>