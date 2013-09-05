var scripts=document.getElementsByTagName("script");
var curJS=scripts[scripts.length-1]; //curJS就是我们当前的js文件

var getArgs=(function(){
	var sc=document.getElementsByTagName('script');
	var paramsArr=sc[sc.length-1].src.split('?')[1].split('&');
	var args={},argsStr=[],param,t,name,value;
	for(var i=0,len=paramsArr.length;i<len;i++){
		param=paramsArr[i].split('=');
		name=param[0];
		value=param[1];
		if(typeof args[name]=="undefined"){ //参数尚不存在
			args[name]=value;
		}else if(typeof args[name]=="string"){ //参数已经存在则保存为数组
			args[name]=[args[name]]
			args[name].push(value);
		}else{ //已经是数组的
			args[name].push(value);
		}
	}

	//组装成json格式
	args.toString=function(){
		for(var i in args) argsStr.push(i+':'+showArg(args[i]));
		return '{'+argsStr.join(',')+'}';
	}
	return function(){	//以json格式返回获取的所有参数
		return args;
	} 
})();

//alert("GpsID:"+getArgs()["gpsId"]);




var WebClient = {
    type:"client", //'client'..'demo' 
	version:"v2011.02.16.1",
	debug:false, //是否打开调试状态 
	agt:navigator.userAgent.toLowerCase(), 
	Debug:null,
	connectId:null,
	time:new Date(),
	noLogin:false, //内部使用true
	updateOnline:false, //是否定时刷新资源在线状态 
	frameBody:"",  
	
	loginDefaultParams:{ 
		style:"auto", //是否自动登录 auto..normal
		path:"192.168.11.29:8866",
		//path:"192.168.0.75:8866",
		//path:"192.168.1.50:8966", 
		epId:"system",
		username:"admin",
		password:"",
		areaCode:"",
		clientType:"",
		userCustomData:"",
		bFixCUIAddress:"1",
		callbackFun:function(){} 
	},
	
	loginParams:null,
	
	/*
	* 函数名		：Load
	* 函数功能	：加载WebClient
	* 备注		：无
	* 作者		：huzw
	* 时间		：2011.02.16
	*/
	Load:function(){ 
		
		/* 开启自定义时钟事件 */
		Utility.Clock.Start();
		
		//开始侦测时间更新  
		Utility.Clock.EventCallback.Set(
			new Utility.Struct.ClockEventStruct(
				"updateCurrentTime",
				1000,
				function(t){ 
					WebClient.time = t;
				}
			)
		);
								
		/* 清除页面所有元素 */
        WebClient.ClearBody();   
		
		/* 设置默认皮肤风格 */
		Global.SetStartSkin();
		
		/* 创建调试窗口信息对象 */
		WebClient.Debug = new Utility.Debug(new Utility.Struct.DebugParamStruct(WebClient.debug,"watch",{top:400,left:200}));
		
		/* 初始化Nrcap2对象 */
		Nrcap2.Init(new Nrcap2.Struct.InitParamStruct(true,function(msg){WebClient.Debug.Note(msg);}));
		 
		/* 初始化Nrcap2成功 */
		if(Nrcap2.Plug.inited == true)
		{ 
			if(typeof WebClient.loginParams == "undefined" || WebClient.loginParams instanceof Nrcap2.Struct.ConnParamStruct != true)
			{
				WebClient.loginParams = new Nrcap2.Struct.ConnParamStruct();
			} 
			
			WebClient.loginParams.style = WebClient.loginDefaultParams.style; 
			WebClient.loginParams.path = WebClient.loginDefaultParams.path; 
			WebClient.loginParams.epId = WebClient.loginDefaultParams.epId;
			WebClient.loginParams.username = WebClient.loginDefaultParams.username;
			WebClient.loginParams.password = WebClient.loginDefaultParams.password;
			WebClient.loginParams.areaCode = WebClient.loginDefaultParams.areaCode; 
			WebClient.loginParams.clientType = WebClient.loginDefaultParams.clientType;
			WebClient.loginParams.userCustomData = WebClient.loginDefaultParams.userCustomData;
			WebClient.loginParams.bFixCUIAddress = WebClient.loginDefaultParams.bFixCUIAddress;
			WebClient.loginParams.callbackFun = WebClient.Login.Connect_callback; //回调函数
		}
		else
		{
			return;	
		}
		
		/* 初始化WebClient框架 */
		WebClient.Init();
	},
	
	/*
	* 函数名		：Unload
	* 函数功能	：退出WebClient,断开与服务器连接
	* 备注		：无
	* 作者		：huzw
	* 时间		：2011.02.16
	*/
	UnLoad:function(){
		Utility.Clock.Stop();
		//WebClient.Query.StopAllPlayVod();
		Nrcap2.UnLoad(); 
	},
	
	/*
	* 函数名		：Close
	* 函数功能	：关闭页面 
	* 备注		：无
	* 作者		：huzw
	* 时间		：2011.02.16
	*/
	Close:function(){
		window.close();
		window.opener = null;
	},
	
	/*
	* 函数名		：Exit
	* 函数功能	：退出系统 
	* 备注		：无
	* 作者		：huzw
	* 时间		：2011.02.16
	*/
	Exit:function(){ 
		//WebClient.Query.StopAllPlayVod();
		WebClient.UnLoad();
		WebClient.connectId = null;
		WebClient.Login.status = false;
		WebClient.loginDefaultParams.style = "normal";
		WebClient.Load();
	},
	
	/*
	* 函数名		：ClearBody
	* 函数功能	：删除整个页面所有元素 
	* 备注		：无
	* 作者		：huzw
	* 时间		：2011.02.16
	*/
	ClearBody:function(){
		/* 先删除原body里所有元素 */	
		var childsBody = $$("DIV");
		for(var i = 0;i < childsBody.length;i++)
		{
			if(childsBody[i]) childsBody[i].remove();
		}
	},
	
	/*
	*	函数名		：Init
	*	函数功能		：初始化WebClient框架
	*	备注			：无
	*	作者			：huzw
	*	时间			：2011.02.16 
	*/
	Init:function(frameBody){
		if($("loginbox")) $("loginbox").remove();
		if($("WebClientFrame")) $("WebClientFrame").remove();
		
		if(WebClient.type)
		{
			if(WebClient.type.search("client") != -1)
			{
				document.title = "CreMedia7.0#WebClient";
			}
			else 
			{
				document.title = "CreMedia7.0#Demo";
			} 
		}
		if(typeof frameBody != "undefined")
		{
			WebClient.frameBody = frameBody;
		}
		if(WebClient.Login.status == true || WebClient.noLogin == true)
		{
			WebClient.Frame.Init(); //加载主框架元素 
			
			//WebClient.CardPad.Init(); //加载主选项卡元素 
			
			//WebClient.NavMenu.Init(); //加载主导航元素 
			
			WebClient.Content.Init(); //加载主内容元素 
			
			//var curCard = WebClient.CardPad.currentCardKey;
			//WebClient.CardPad.SwitchCard(curCard); //激活选项卡，默认为videoScan
			//WebClient.CardPad.SwitchCard("queryDownload"); //激活queryDownload为了测试
			
			window.setTimeout(
				function(){
					//WebClient.Resource.FetchResource(); //获取资源
				},200
			);
			 
		}
		else
		{
			WebClient.Login.Init();
		}
	},
	
	/*
	*	函数名		：Login
	*	函数功能		：页面框架对象，创建登录页面元素
	*	备注			：无
	*	作者			：huzw
	*	时间			：2011.02.16 
	*/
	Login:{ 
		status:false, //登录状态，是否已经登录到服务器
		cmbPath:null, //模拟combobox控件
		loginInfo:new Array(),
		
		/*
		*	函数名		：Init
		*	函数功能		：初始化登陆框架元素
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.02.16 
		*/
		Init:function(){  
			if(WebClient.loginParams && WebClient.loginParams.style == "auto")
			{
				var connParams = WebClient.loginParams; //alert(Object.toJSON(connParams)); 
				
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Login.Init",msg:Object.toJSON(connParams)});
				
				WebClient.connectId = Nrcap2.CreateConnect(connParams,true); 
				 
				return; //若为自动登录则返回 
			}
			
			var idLoginBox = "loginbox";
			/* 没有登录框对象 */
			if(!$(idLoginBox))
			{
				var objLoginBox = document.createElement("DIV");
				objLoginBox.setAttribute("id",idLoginBox);
				document.getElementsByTagName("body").item(0).appendChild(objLoginBox);
			}
			var htmlstr = "";
			
			htmlstr += "<div class=\"loginboxtitle\"><div style=\"float:right;\"><div style=\"text-align:right;margin:2px 5px 0px 0px;font-size:12px;\"><a href=\"CreMedia7Nrcap2ATL.cab\" target=_self style=\"text-decoration:none;color:#ff0000;\" title=\"插件下载\" >插件下载</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div><div class=\"logo\"></div></div></div>";
            htmlstr += "<div class=\"loginbox\"><form onsubmit=\"WebClient.Login.Login();return false;\" >";
            
            htmlstr += "<div style=\"\" ><span class=\"text\">路径&nbsp;&nbsp;</span><span class=\"input\" ><span id=\"cmbPath\" name=\"cmbPath\" ></span></span><span class=\"note\" id=\"t_path_note\">路径格式为＂IP（域名）：端口＂</span></div>";
            
            htmlstr += "<div><span class=\"text\">用户&nbsp;&nbsp;</span><span class=\"input\"><input type=\"text\" name=\"t_username\" id=\"t_username\" value=\"admin\" maxlength=\"32\" />@<input type=\"text\" id=\"t_epId\" name=\"t_epId\" value=\"system\" /></span><span class=\"note\" id=\"t_username_note\">用户登录帐号@企业ID</span></div>";
            htmlstr += "<div><span class=\"text\">密码&nbsp;&nbsp;</span><span class=\"input\"><input type=\"password\" name=\"t_password\" id=\"t_password\" value=\"\" maxlength=\"32\" /></span><span class=\"note\" id=\"t_password_note\"><input type=\"checkbox\" name=\"t_savepwd\" id=\"t_savepwd\" onfocus=\"\" /><label for=\"t_savepwd\">记住密码</label></span></div>";
            
            htmlstr += "<div class=\"submitbox\"><span class=\"input\" style=\"width:100%;text-align:center;\"><input type=\"submit\" value=\"登录\" onfocus=\"this.blur()\" style=\"cursor:pointer;\" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=\"button\" value=\"退出\" onclick=\"WebClient.Close();\" onfocus=\"this.blur()\" style=\"cursor:pointer;\" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></div>";
            htmlstr += "</form></div>";
			
			//alert(htmlstr);
			$(idLoginBox).innerHTML = htmlstr;
			
			WebClient.Login.cmbPath = new ComBoBox("cmbPath",155,WebClient.Login.OnChange_ServerPath);
			
			WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Login.Init",msg:"创建登录页面框架元素"});
			
			$("t_username").focus();
			
			WebClient.Login.GetHistoryInfo(); 
		},
		 
		Connect_callback:function(rv){  
			// 登录成功,初始化资源列表 
			if(rv == Nrcap2.NrcapError.NRCAP_SUCCESS)
			{ 
				if(WebClient.connectId && Nrcap2.Connections.get(WebClient.connectId))
				{
					//alert(WebClient.connectId);					
					WebClient.Login.SetLoginInfo();
					WebClient.Login.status = true;
					WebClient.Init(); //再次调用
				}			
			}	
			
		},
		
		/*
		*	函数名		：OnChange_ServerPath
		*	函数功能   	：登录服务器Combobox选择响应事件
		*	备注			：无
		*	作者			：Lingsen
		*	时间			：2010年08月10日 
		*/
		OnChange_ServerPath:function(){ 
			if(WebClient.Login.cmbPath)
			{
				var selectedIndex =  WebClient.Login.cmbPath.getSelectedIndex();  
				if(WebClient.Login.loginInfo[selectedIndex])
				{
					if(WebClient.Login.loginInfo[selectedIndex].username)
					{
						$("t_username").value = WebClient.Login.loginInfo[selectedIndex].username;
					}
					if(WebClient.Login.loginInfo[selectedIndex].epId)
					{
						$("t_epId").value = WebClient.Login.loginInfo[selectedIndex].epId;
					}
					if(WebClient.Login.loginInfo[selectedIndex].savepwd)
					{
						$("t_savepwd").checked = true;
						$("t_password").value = WebClient.Login.loginInfo[selectedIndex].password;
					}
					else
					{
						$("t_savepwd").checked = false;
						$("t_password").value = "";						
					}
				}
			}
		},
		
		/*
		*	函数名		：Login
		*	函数功能   	：登录服务器
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.02.17 
		*/
		Login:function(){
			try
			{
				var path = "";	
				if(!WebClient.Login.cmbPath.oTextBox.value.split(":")[1])
				{
					WebClient.Login.cmbPath.oTextBox.value = WebClient.Login.cmbPath.oTextBox.value.split(":")[0] + ":8866";
				}
				
				var strRegex = "^((https|http|ftp|rtsp|mms)?://)" 
								+ "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" /* ftp的user@ */
								+ "(([0-9]{1,3}\.){3}[0-9]{1,3}" /* IP形式的URL- 199.194.52.184 */
								+ "|" /* 允许IP和DOMAIN（域名）*/
								+ "([0-9a-z_!~*'()-]+\.)*" /* 域名- www. */
								+ "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." /* 二级域名 */
								+ "[a-z]{2,6})" /* first level domain- .com or .museum */
								+ "(:[0-9]{1,4})?" /* 端口- :80 */
								+ "((/?)|" /* a slash isn't required if there is no file name */
								+ "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$"; 
				var re = new RegExp(strRegex);
				if(!WebClient.Login.cmbPath.oTextBox.value || !re.test(WebClient.Login.cmbPath.oTextBox.value))
				{
					alert("请输入正确的路径！");
					WebClient.Login.cmbPath.oTextBox.focus();
					return;
				}
				path = WebClient.Login.cmbPath.oTextBox.value;
				
				if($F("t_username").toString().strip() == "")
				{
					alert("请输入您的登录帐号");
                    $("t_username").focus();
                    return;
				}
				if($F("t_epId").toString().strip() == "")
				{
					alert("请输入您的企业ID");
                    $("t_epid").focus();
                    return;
				} 
				 
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Login.Login",msg:"path="+path+",username="+$F("t_username")+",epid="+ $F("t_epid")+",password="+$F("t_password")+",savepwd="+($("t_savepwd").checked? true:false)});
				
				var connParams = new Nrcap2.Struct.ConnParamStruct();
				connParams.path = path; 
				connParams.username = $F("t_username").toString().strip();
				connParams.epId = $F("t_epId").toString().strip();
				connParams.savepwd = $("t_savepwd").checked ? true: false;
				connParams.password = $F("t_password").toString().strip();
				connParams.callbackFun = WebClient.Login.Connect_callback; 
				
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Login.Login",msg:Object.toJSON(connParams)});
				
				WebClient.connectId = Nrcap2.CreateConnect(connParams,true); // 连接服务器 
			}
			catch(e)
			{
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Login.Login",msg:e.message + "::" + e.name});
				return false;
			}
			return false;
		},
		   
		/*
		*	函数名		：SetLoginInfo
		*	函数功能   	：设置登录信息,把登录的信息保存到cookie里		
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.02.17		
		*/
		SetLoginInfo:function(){
			 /* 保存成功登录信息 */
			 var addNewConnParam = true;
			 var loginInfos = new Array();
			 if(!Cookie || !Cookie.CookieEnable())
			 {
				 WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Login.SetLoginInfo",msg:"Cookie功能不可用，无法保存登录信息！"});
			 }
			 
			 if(Cookie.GetCookie("loginInfo"))
			 {
				 loginInfos = eval(Cookie.GetCookie("loginInfo")); 
				 if(Object.isArray(loginInfos))
				 {
					 for(var i = 0;i < loginInfos.length;i++)
					 {
						 var loginInfo = loginInfos[i];
						 loginInfo.selected = false;
						 if(Nrcap2.Connections.get(WebClient.connectId) && loginInfo.path == Nrcap2.Connections.get(WebClient.connectId).connParam.path)
						 {
							 addNewConnParam = false;
							 loginInfo.selected = true;
							 loginInfo.savepwd = Nrcap2.Connections.get(WebClient.connectId).connParam.savepwd;
							 loginInfo.username = Nrcap2.Connections.get(WebClient.connectId).connParam.username;
							 loginInfo.epId = Nrcap2.Connections.get(WebClient.connectId).connParam.epId;
							 loginInfo.password = Nrcap2.Connections.get(WebClient.connectId).connParam.password;
						 }
					 }
				 }
			 }
			 
			 if(addNewConnParam && Nrcap2.Connections.get(WebClient.connectId))
			 {
				 loginInfos.push({path:Nrcap2.Connections.get(WebClient.connectId).connParam.path,username:Nrcap2.Connections.get(WebClient.connectId).connParam.username,epId:Nrcap2.Connections.get(WebClient.connectId).connParam.epId,savepwd:Nrcap2.Connections.get(WebClient.connectId).connParam.savepwd,password:Nrcap2.Connections.get(WebClient.connectId).connParam.password,selected:true});
			 }
			 
			 WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd hh:mm:ss"),fn:"WebClient.Login.SetLoginInfo",msg:Object.toJSON(loginInfos)});
			 //alert(Object.toJSON(loginInfos));
			 Cookie.SetCookie("loginInfo",Object.toJSON(loginInfos));
			 
		},
		
		/*
		*	函数名		：GetHistotyInfo
		*	函数功能   	：获取用户历史登录记录		
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.02.17		
		*/
		GetHistoryInfo:function(){
			try
			{ 
				if(Cookie.CookieEnable())
				{
					var paths = new Array();
					var values = new Array();
					var selectedIndex = 0;
					
					WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd hh:mm:ss"),fn:"WebClient.Login.GetHistotyInfo",msg:Cookie.GetCookie("loginInfo")});
					WebClient.Login.loginInfo = eval(Cookie.GetCookie("loginInfo"));
					//alert(WebClient.Login.loginInfo);
					if(Object.isArray(WebClient.Login.loginInfo))
					{ 			
						for(var i = 0;i < WebClient.Login.loginInfo.length;i++)
						{
							paths.push(WebClient.Login.loginInfo[i].path);
							values.push(i);
								
							if(WebClient.Login.loginInfo[i].selected)
							{
								selectedIndex = i;
							}
						}
						
						if(WebClient.Login.cmbPath)
						{
							WebClient.Login.cmbPath.comBobox_initOptions(paths,values);
							WebClient.Login.cmbPath.setSelectedIndex(selectedIndex);
						}
						
						if(WebClient.Login.loginInfo[selectedIndex])
						{
							if(WebClient.Login.loginInfo[selectedIndex].username)
							{
								$("t_username").value = WebClient.Login.loginInfo[selectedIndex].username;
							}
							if(WebClient.Login.loginInfo[selectedIndex].epId)
							{
								$("t_epId").value = WebClient.Login.loginInfo[selectedIndex].epId;
							}
							if(WebClient.Login.loginInfo[selectedIndex].savepwd)
							{
								$("t_savepwd").checked = true;
								$("t_password").value = WebClient.Login.loginInfo[selectedIndex].password;
							} 
						}
						
					}
					
				}
			}
			catch(e)
			{
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Login.GetHistotyInfo",msg:e.message + "::" + e.name});
				return false;
			}
			return false;
		},
		
		end:true
	},
	
	/*
	*	函数名		：Frame
	*	函数功能   	：页面框架对象，创建初始化页面元素		
	*	备注			：无
	*	作者			：huzw
	*	时间			：2011.02.17		
	*/
	Frame:{
		/*
		*	函数名		：Init
		*	函数功能   	：创建页面元素框架 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.02.17 
		*/
		Init:function(){
			/* 创建页面框架 */
			var WebClientFrame = document.createElement("DIV");
			WebClientFrame.setAttribute("id","WebClientFrame");
			WebClientFrame.className = "WebClientFrame";
			//WebClientFrame.style.width = document.body.clientWidth + "px"; 
			document.getElementsByTagName("body").item(0).appendChild(WebClientFrame);
			
			var htmlstr = WebClient.Frame.Html(); //html	
			$("WebClientFrame") ? $("WebClientFrame").innerHTML = htmlstr : ""; 
			 
		},
		
		Html:function(){
			var htmlstr = "";
			
			htmlstr += "<div id=\"mainFrame\" class=\"mainFrame\">";
				htmlstr += "<div id=\"mainRegion\" class=\"mainRegion\"></div>";			 	
			htmlstr += "</div>";
			
			return htmlstr;
		},
		
		end:true
	},

	
	/*
	*	函数名		：Content
	*	函数功能   	：页面主体内容框架对象		
	*	备注			：无
	*	作者			：huzw
	*	时间			：2011.02.18		
	*/
	Content:{
		
		/*
		*	函数名		：Init
		*	函数功能   	：初始化页面主体内容框架		
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.02.18		
		*/
		Init:function(){
			if($("mainRegion"))
			{
				var htmlstr = "";
				htmlstr = WebClient.Content.Html();
				$("mainRegion").innerHTML = htmlstr; 
				
				WebClient.Content.VideoPad(); //加载videoScan主内容框架元素部分 

				//WebClient.Content.QueryPad(); //加载queryDownload主内容框架元素部分 
				
				WebClient.Resource.Init(); //初始化资源对象 
			}
			else
			{
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Content.Init",msg:"初始化页面主体内容框架失败！"});
			}
		},
		
		VideoPad:function(){
			WebClient.Control.Init();
			WebClient.Video.Init();  
		},
		

		
		Html:function(){
			var htmlstr = "";
				//video pad
				htmlstr += "<div id=\"videoPad\" class=\"contentPad\">";
					
					//video right
					htmlstr += "<div id=\"videoPadRight\" class=\"videoPadRight\">";
					    /* 实时播放窗口容器区 */
                        htmlstr += "<div id=\"windowPad\" >";
                        htmlstr += "</div>";
                        
                        /* 切换窗口数量控制区*/
                        htmlstr += "<div id=\"changeWindowPad1\" class=\"changenumber\" >";
                        htmlstr += "</div>";
					htmlstr += "</div>";
					
				htmlstr += "</div>";
				
				
				htmlstr += "</div>"; 
				
			return htmlstr;
		}, 
		
		end:true		
	},
	
	/*
	*	函数名		：Control
	*	函数功能   	：页面控制框架对象		
	*	备注			：无
	*	作者			：huzw
	*	时间			：2011.02.21	
	*/
	Control:{
		SliderBars:new Hash(), // 控制拖动条信息

	    Init:function(){

	    
	    },

		
	    end:true
	},
	
	Video:{
		curChangeWndFlag:false,
	    curWindowNumber:0,
	    curActiveWindowKey:"", 
		
	    Init:function(){
			WebClient.Video.curWindowNumber = 0;
			
	        if($("windowPad") && $("changeWindowPad1"))
	        {
	            var htmlstr = "";
	            htmlstr = WebClient.Video.Html();
	            $("changeWindowPad1").innerHTML = htmlstr; 
				
	            WebClient.Video.ChangeWindow(1);//初始化1数量窗口
	            
	            WebClient.Video.AttachChangeNumberEvent(); //绑定窗口切换事件

	        }
	    },
	    
	    Html:function(){
	        var htmlstr = "";

	        return htmlstr;
	    },
	    
	    AttachChangeNumberEvent:function(){
			var route = Global.route; 
	    
			var changeNumberBtns = $("changeWindowPad1").getElementsByTagName("INPUT");

	    },
	    
	    InitWindowContainers:function(){
	        var rv = Nrcap2.InitWindows();
	        if(rv != Nrcap2.NrcapError.NRCAP_SUCCESS)
	        {
                WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Video.InitWindowContainers",msg:"初始化Nrcap2.WindowContainers对象失败！"});	        
	            return;
	        }
	        
	        var wndBoxs = $("windowPad").getElementsByTagName("DIV");  
	        for(var i = 0;i < wndBoxs.length;i++)
	        {
	            var wndBox = wndBoxs[i];
	            if(wndBox && wndBox.id.search("windowbox") != -1)
	            {	             
	                wndBox.onclick = function(){        
	                    WebClient.Video.ActiveWindow(this.id);//激活窗口  
	                }  
	                
	                Nrcap2.WindowContainers.set(wndBox.id,{container:wndBox,active:false,windwow:null,description:null});
	            } 
	        }
	         
	    },
	    
	    ActiveWindow:function(windowKey){
	        try
	        {
				var defaultcolor = Global.defaultTitleBgColor;
				var activecolor = Global.activeTitleBgColor; 
				
	            Nrcap2.WindowContainers.each(
	                function(item){
	                    var node = item.value;
	                    if(node.container.id == windowKey)
	                    {
	                        node.active = true;
                            $(windowKey).style.backgroundColor = activecolor; //"#ac59ff"
                            WebClient.Video.curActiveWindowKey = item.key;
							 
							if(!WebClient.Video.curChangeWndFlag)
							{
								 WebClient.Video.SetStatus(item.key); //调用设置状态 
							}  
	                    }
	                    else
	                    {
	                        node.active = false;
                            $(node.container.id).style.backgroundColor = defaultcolor; //"#9bcaf3"
	                    }
	                }	            
	            );
	        }
	        catch(e)
	        {
	            WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Video.ActiveWindow",msg:e.message +"::"+ e.name});
	        }    
	    },
	    
	    ChangeWindow:function(wndnumber){ 
	        
	        var htmlstr = "";
	        wndnumber = parseInt(wndnumber); 
	        var oldwndnumber = WebClient.Video.curWindowNumber;
			
	        if(oldwndnumber == wndnumber) return; 
			
			var oldPlayInfo = new Hash();
			var oldPlayCount = 0;
			var confirmFlag = false;
			var stopChange = false; 
				        
            switch(wndnumber) 
            {         
                case 1:
                case 4:
                case 9:
                case 16:
                    for(var i= 0 ;i < wndnumber;i++)
                    {
                        htmlstr += "<div id=\"windowbox"+i+"\" class=\"window"+wndnumber+"box\">";
                            htmlstr += "<div id=\"window"+i+"\" class=\"window\">";                                
                            htmlstr += "</div>";
                            htmlstr += "<div id=\"windowtitle"+i+"\" class=\"windowtitle\"><div class=\"title1\" >无视频</div><div class=\"title2\"></div></div>";
                        htmlstr += "</div>"; 
                    }
            	    break;
                default:
                    for(var i= 0 ;i < 4;i++)
                    {
                        htmlstr += "<div id=\"windowbox"+i+"\" class=\"window4box\">";
                            htmlstr += "<div id=\"window"+i+"\" class=\"window\"></div>";
                            htmlstr += "<div id=\"windowtitle"+i+"\" class=\"windowtitle\"><div class=\"title1\" >无视频</div><div class=\"title2\"></div></div>";
                        htmlstr += "</div>"; 
                    }
                break;
            }
            
			$("windowPad").innerHTML = htmlstr;
	
			WebClient.Video.curWindowNumber = wndnumber;

			WebClient.Video.InitWindowContainers(); 
		   
		   	WebClient.Video.curChangeWndFlag = true;
			WebClient.Video.ActiveWindow(Nrcap2.WindowContainers.keys()[0]); //激活首个窗口  
            
	    },
	    
	    /*
		*	函数名		：PlayVideo
		*	函数功能   	：播放实时视频 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.02.22	
		*/
		PlayVideo:function(puid,ivIndex){ 
			var resource = WebClient.Resource.resource; //alert(Object.toJSON(rescource));  
			if(!resource.get(puid)) return false;
			if(!resource.get(puid).childResource) return false;
          
			var pu = resource.get(puid);
			var childResource = pu.childResource;
			
			if(!Object.isArray(childResource))
			{
				return;
			}
			
			for(var i = 0; i < childResource.length;i++)
			{
				var puResourcesInfos = childResource[i];
				// alert(Object.toJSON(puResourcesInfos));
				if(puResourcesInfos.idx == ivIndex && puResourcesInfos.type == Nrcap2.Enum.PuResourceType.VideoIn)
				{
					if(pu.online != "1")
					{
						alert("设备不在线");
						WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Video.PlayVideo",msg:"设备"+puid+"不在线!"});
						return false;
					}
					if(pu.enable != "1")
					{
						alert("设备没有使能");
						WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Video.PlayVideo",msg:"设备"+puid+"没有使能!"});
						return false;
					}
					if(puResourcesInfos.enable != "1")
					{
						alert("摄像机没有使能");
						WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Video.PlayVideo",msg:"摄像机"+puResourcesInfos.idx+"没有使能!"});
						return false;
					} 
					 
					Nrcap2.WindowContainers.each(
						function(item){
							var node = item.value;
							if(node.active)
							{
								var create = true;
								if(node.window != null)
								{
									create = false;
									if(node.window.status.playvideoing)
									{
										WebClient.Video.StopVideo(item.key);
									}
								}
								
								node.description = puResourcesInfos; 
								
								if(create)
								{
									var windowEvent = new Nrcap2.Struct.WindowEventStruct();
									windowEvent.onStop.status = true;
									windowEvent.onStop.callback = function(){WebClient.Video.StopVideo(item.key);};
									windowEvent.onClick.status = true;
									windowEvent.onClick.callback = function(){WebClient.Video.ActiveWindow(item.key);};
									windowEvent.onStartRecord.status = true;
									windowEvent.onStartRecord.callback = function(){WebClient.Video.Record(item.key);};
									windowEvent.onStopRecord.status = true;
									windowEvent.onStopRecord.callback = function(){WebClient.Video.Record(item.key);};
									
									windowEvent.onSnapshot.status = true; 	
									windowEvent.onPTZControl.status = true;
									windowEvent.onRestore.status = true;							
									windowEvent.onFullScreen.status = true;	
									
									//添加自定义窗口右击菜单 
									var curWndNumber = WebClient.Video.curWindowNumber; //当前窗口数量
									alert(curWndNumber);
									var wndIndex = item.key.replace("windowbox","");//当前播放窗口序号
									switch(curWndNumber)
									{
										case 1:
										case 4:
										case 9:
										case 16:
											break;
										default: 
											if((curWndNumber !=13 && wndIndex != 1) || (curWndNumber==13 && wndIndex != 7)) 
											{
												windowEvent.onCustomMenuCommand.status = true; 
												windowEvent.onCustomMenuCommand.menu = [
													{key:"separator",text:""},	
													{key:"toBigWnd",text:"大窗口播放"}
												]; 
												windowEvent.onCustomMenuCommand.callback = function(){
													WebClient.Video.CustomMenuCommand(item.key,arguments);													
												} 	
											} 
											
											break;
									} 
									//alert(item.key);
									// 初始化一个窗口 
									node.window = Nrcap2.CreateWindow(WebClient.connectId,item.key.replace("windowbox","window"),windowEvent);
								}
								
								// 设置窗口样式
								node.window.SetStyle({enableFullScreen:true,enableMainPopMenu:true});
								node.window.wnd.style.visibility = "visible"; //使窗体可见  
								
								// 开始播放 
								var rv = Nrcap2.PlayVideo(WebClient.connectId,node.window,puid,ivIndex);  //摄像头索引idx<=3
								//alert(rv);
								//if(rv.split(#)[0] != 0x0000) return;
								
								// 开始侦测播放视频状态 
								Utility.Clock.EventCallback.Set(
									new Utility.Struct.ClockEventStruct(
										"sense_"+item.key,
										200,
										function(t){ 
											WebClient.Video.SetWindowTitle(item.key);
										}
									)
								);
								//设置播放窗口信息条 
								WebClient.Video.SetWindowTitle(item.key);
								if(!WebClient.Video.curChangeWndFlag)
								{
									WebClient.Video.SetStatus(item.key); //设置相应状态 
								}
							}
						}
					);
					
				}//end if
			}//end for 
			
		},
		
		//自定义窗口右击菜单事件 
		CustomMenuCommand:function(windowKey,t_arguments){ 
			switch(t_arguments[0])
			{
				case "toBigWnd":
					WebClient.Video.SwapToBigWindow(windowKey);
					break;
				default:
					break;
			}			
		},
		
		SwapToBigWindow:function(windowKey){
			try
			{
				var curWndNumber = WebClient.Video.curWindowNumber; //当前窗口数量
				var wndIndex = windowKey.replace("windowbox","");//当前播放窗口序号
				
				if((curWndNumber !=13 && wndIndex != 1) || (curWndNumber==13 && wndIndex != 7)) 
				{ 
					var bigWndKey = "windowbox" + (curWndNumber == 13 ? 7 : 1).toString();
					
					var node = Nrcap2.WindowContainers.get(bigWndKey);
					if(!node) return;
					//alert(Object.toJSON(node.window));
					
					//记录在切换之前相对的大窗口puid，idx
					var bpuid = "", bidx = 0;
					
					if(node.window) 
					{ 
						bpuid = node.window.puid;
						bidx = node.window.idx; 
					}  
					 
					var smallWnd = Nrcap2.WindowContainers.get(windowKey).window;
					if(!smallWnd || typeof smallWnd != "object") return false;
					//记录当前小窗口puid，idx
					var spuid = smallWnd.puid, sidx = smallWnd.idx;
					
					WebClient.Video.curChangeWndFlag = true;
					
					//激活bigWndKey窗体
					WebClient.Video.ActiveWindow(bigWndKey);
					//播放小窗口切换过来的视频
					WebClient.Video.PlayVideo(spuid,sidx);
					  //return;alert(spuid + "_" + sidx); 
					  
					if(!bpuid)
					{
						WebClient.Video.curChangeWndFlag = false;
						WebClient.Video.StopVideo(windowKey);  
					}
					else
					{						
						// 如果在切换之前所记录的大窗口puid不为空，则就在小窗口播 
						// 激活windowKey窗体
						WebClient.Video.ActiveWindow(windowKey);
						WebClient.Video.PlayVideo(bpuid,bidx);
					}
					
					WebClient.Video.curChangeWndFlag = false;
					
					// 最终激活大窗口，呈现相关状态 
					WebClient.Video.ActiveWindow(bigWndKey); 
					return;
				}
			}
			catch(e)
			{
				alert("exception:" + e.message + ":" + e.name);
				return false;	
			}			
		},
		
		SetWindowTitle:function(windowKey){
			var node = Nrcap2.WindowContainers.get(windowKey);
			if(!node) return;
			var objWnd = node.window;
			if(!objWnd) return;
			
			var puid = objWnd.puid, idx = objWnd.idx; 
			var pu = WebClient.Resource.resource.get(puid); 
			
			var description = node.description;//alert(Object.toJSON(description));
			if(!description) return;
			
			var ivName = description.name; 
			
			if(!ivName)
			{
				var childResource = pu.childResource; 
				for(var i = 0;i < childResource.length;i++)
				{
					if(idx == childResource[i].idx && childResource[i].type == Nrcap2.Enum.PuResourceType.VideoIn)
					{
						ivName = childResource[i].name;  
					}
				}
			}
			//alert(ivName); 
			
			var windowTitle = windowKey.replace("windowbox","windowtitle");
			
			if($(windowTitle))
			{
				var htmlstr = "";
				
				if(objWnd.status.playvideoing)
				{
					//alert($$("#"+windowTitle+" .title1").length);
					if($$("#"+windowTitle+" .title1").length > 0)
					{
						var videoStatus = Nrcap2.GetVideoStatus(objWnd); 
						
						htmlstr += ivName + "," + videoStatus;
						
						$$("#"+windowTitle+" .title1")[0].innerHTML = "&nbsp;" + htmlstr;
						$$("#"+windowTitle+" .title1")[0].title = htmlstr;
					}
					if($$("#"+windowTitle+" .title2").length > 0)
					{
						htmlstr = "";
						
						var title2 = windowTitle + "_title2";
						
						if($$("#"+windowTitle+" .title2")[0].innerHTML == "")
						{
							
							//loacle snapshot
							htmlstr += "<input id=\""+title2+"_snapshot\" type=\"button\" webclienttype=\"windowtitle\" onfocus=\"this.blur();\" class=\"snapshot_onmouseout\" onmouseover=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\" onmouseout=\"WebClient.Video.WindowTitleEvent(this.id,'mouseout','"+windowKey+"');\" onmousedown=\"WebClient.Video.WindowTitleEvent(this.id,'mousedown','"+windowKey+"');\" onmouseup=\"this.className='snapshot_onmouseover';\" onclick=\"WebClient.Video.SnapShot('"+windowKey+"');\" title=\"本地抓拍\" />";
							//loacle record
							if(objWnd.status.recording)
							{
								htmlstr += "<input id=\""+title2+"_record\" type=\"button\" webclienttype=\"windowtitle\" onfocus=\"this.blur();\" class=\"record_onmouseout\" onmouseover=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\" onmouseout=\"WebClient.Video.WindowTitleEvent(this.id,'mouseout','"+windowKey+"');\" onmousedown=\"WebClient.Video.WindowTitleEvent(this.id,'mousedown','"+windowKey+"');\" onmouseup=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\" onclick=\"WebClient.Video.Record('"+windowKey+"');\" title=\"停止录像\" />";
							}
							else
							{
								htmlstr += "<input id=\""+title2+"_record\" type=\"button\" webclienttype=\"windowtitle\" onfocus=\"this.blur();\" class=\"record_onmouseout\" onmouseover=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\" onmouseout=\"WebClient.Video.WindowTitleEvent(this.id,'mouseout','"+windowKey+"');\" onmousedown=\"WebClient.Video.WindowTitleEvent(this.id,'mousedown','"+windowKey+"');\" onmouseup=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\"  onclick=\"WebClient.Video.Record('"+windowKey+"');\" title=\"开始录像\" />";
							}				
							//audio
							if(objWnd.status.playaudioing)
							{
								htmlstr += "<input id=\""+title2+"_audio\" type=\"button\" webclienttype=\"windowtitle\" onfocus=\"this.blur();\" class=\"audio_onmouseout\" onmouseover=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\" onmouseout=\"WebClient.Video.WindowTitleEvent(this.id,'mouseout','"+windowKey+"');\" onmousedown=\"WebClient.Video.WindowTitleEvent(this.id,'mousedown','"+windowKey+"');\" onmouseup=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\"  onclick=\"WebClient.Video.PlayAudio('"+windowKey+"');\" title=\"停止音频\" />";
							}
							else
							{
								htmlstr += "<input id=\""+title2+"_audio\" type=\"button\" webclienttype=\"windowtitle\" onfocus=\"this.blur();\" class=\"audio_onmouseout\" onmouseover=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\" onmouseout=\"WebClient.Video.WindowTitleEvent(this.id,'mouseout','"+windowKey+"');\" onmousedown=\"WebClient.Video.WindowTitleEvent(this.id,'mousedown','"+windowKey+"');\" onmouseup=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\"  onclick=\"WebClient.Video.PlayAudio('"+windowKey+"');\" title=\"开始音频\" />";
							} 
							
							$$("#"+windowTitle+" .title2")[0].innerHTML = htmlstr;
						}
						else
						{
							//$(title2 + "_record") ? ( objWnd.status.recording ? $(title2 + "_record").className = "record_onmousedown",$(title2 + "_record").title = "停止录像" : $(title2 + "_record").className = "record_onmouseout",$(title2 + "_record").title = "停止录像"  ):"";
							  
							/*if($(title2 + "_record"))
							{
								mouseEvent = $(title2 + "_record").className.search("mouseover") != -1 ? "mouseover" : "mouseout";
								WebClient.Video.WindowTitleEvent(title2 + "_record",mouseEvent,windowKey);	
							}
							if($(title2 + "_audio"))
							{
								mouseEvent = $(title2 + "_audio").className.search("mouseover") != -1 ? "mouseover" : "mouseout";
								WebClient.Video.WindowTitleEvent(title2 + "_audio",mouseEvent,windowKey);	
							} */
						}
							
					} 
					
					if($$("#"+windowTitle+" .title1").length <= 0 || $$("#"+windowTitle+" .title2").length <= 0)
					{
						htmlstr += "<div class=\"title1\">无视频</div>";
						htmlstr += "<div class=\"title2\"></div>";
						$(windowTitle).innerHTML = htmlstr; 	
					}
					
				}
				else
				{
					htmlstr += "<div class=\"title1\">无视频</div>";
					htmlstr += "<div class=\"title2\"></div>";
					$(windowTitle).innerHTML = htmlstr;    
				} 
			}
		},		
		
		WindowTitleEvent:function(objId,titleEvent,windowKey){
			if($(objId) && $(windowKey))
			{
				var node = Nrcap2.WindowContainers.get(windowKey);
				if(!node) return;
				var objWnd = node.window;
				if(!objWnd) return; 
				
				var route = Global.route;
				var folder = Global.folder; 
				
				if(objId.search("_snapshot") != -1)
				{
					if(titleEvent == "mouseover")
					{
						$(objId).className = "snapshot_onmouseover";
					}
					else if(titleEvent == "mousedown")
					{
						$(objId).className = "snapshot_onmousedown";
					}
					else
					{
						$(objId).className = "snapshot_onmouseout";	
					}
				}
				
				if(objId.search("_record") != -1)
				{ 
					if(objWnd.status.recording)
					{
						if($("mm_video_record"))
						{
							$("mm_video_record").style.backgroundImage = "url(images/"+route+"/"+folder+"/top_menuicon_u1_4.png)";
						}
						$(objId).className = "record_onmousedown";
						$(objId).title = "停止录像";
					}
					else
					{
						if($("mm_video_record"))
						{
							$("mm_video_record").style.backgroundImage = "url(images/"+route+"/"+folder+"/top_menuicon_u1_1.png)";
						}
						$(objId).title = "开始录像";
						if(titleEvent == "mouseover")
						{
							$(objId).className = "record_onmouseover";
						}
						else
						{
							$(objId).className = "record_onmouseout";
						}
						
					} 
				}
				
				if(objId.search("_audio") != -1)
				{
					if(objWnd.status.playaudioing)
					{
						if($("mm_video_audio"))
						{
							$("mm_video_audio").style.backgroundImage = "url(images/"+route+"/"+folder+"/top_menuicon_u1_4.png)";
						}
						$(objId).className = "audio_onmousedown";
						$(objId).title = "停止音频";
					}
					else
					{
						if($("mm_video_audio"))
						{
							$("mm_video_audio").style.backgroundImage = "url(images/"+route+"/"+folder+"/top_menuicon_u1_1.png)";
						}
						$(objId).title = "播放音频";
						if(titleEvent == "mouseover")
						{
							$(objId).className = "audio_onmouseover";
						}
						else
						{
							$(objId).className = "audio_onmouseout";
						}
						
					} 
				}
			}			
		},				
	    end:true
	},
	

	
	/*
	*	函数名		：Resource
	*	函数功能   	：资源对象 
	*	备注			：无
	*	作者			：huzw
	*	时间			：2011.02.21	
	*/
	Resource:{
		csuPuid:null, //csu puid
		csuInfo:{}, //csu puid
		updateTimer:null, 
		resource:new Hash(), //all resource
		logicGroup:new Hash(), //logic resource
		
		Init:function(){
			
	    	//WebClient.Resource.VideoResource.Init(); //加载videoScan资源，初始化VideoResource对象
	    	//WebClient.Resource.QueryResource.Init(); //加载QueryDownload资源，初始化QueryResource对象
			 
	    },
	    end:true
		
	},

    
	end:true
};

/* some global vars */
var Global = {
	route:"blue_car", //main css path prefix
	folder:"ch", //path folder for language of 'Chinese'..'English'
	defaultTitleBgColor:"#9bcaf3",
	activeTitleBgColor:"#65a3e5",
	
	Init:function(skin){
		if(!skin || typeof skin != "string")
		{
			return false;
		}
		
		var route = Global.route;
		
		if(skin.search("blue_car") != -1) route = "blue_car";
		else if(skin.search("metalgrey") != -1) route = "metalgrey";
		else if(skin.search("newyear") != -1) route = "newyear";
		else route = "blue_car";
		
		Global.route = route;
		 
		Global.SetFolder(Nrcap2.language);
		Global.SetWndTitleBg(route);
		
		Global.WebClientStyleSheet.Set(route);
	},
	
	SetStartSkin:function(){ 
		var href = $("switchskin").getAttribute("href");								
		Global.Init(href);		  
	},
	
	SetFolder:function(language){
		if(!language || typeof language != "string")
		{
			return false;
		}
		
		var folder = "ch";
		switch(language.toLowerCase())
		{
			case "chinese":
				folder = "ch";
				break;
			case "english":
				folder = "en";
				break;
			default:
				folder = "ch";
				break;
		}
		
		Global.folder = folder;		
	},
	
	SetWndTitleBg:function(route){
		var defaultcolor = "", activecolor = "";
		
		switch(route)
		{
			case "blue":
				defaultcolor = "#9bcaf3";
				activecolor = "#65a3e5";
				break; 
			case "metalgrey":
				defaultcolor = "#b9b9b9";
				activecolor = "#8e8e8e";
				break; 
			case "newyear":
				defaultcolor = "#ff6133";
				activecolor = "#e51f15";
				break;
			default: 
				defaultcolor = "#9bcaf3";
				activecolor = "#65a3e5";
				break;
		} //end switch
		 
		Global.defaultTitleBgColor = defaultcolor;
		Global.activeTitleBgColor = activecolor; 
	},
	
	WebClientStyleSheet:{
		styleSheetList:new Array("blue_car","metalgrey","newyear"),
		defaultStyleSheet:"blue_car",
		
		Set:function(styleName){
			if(styleName)
			{
				var found = false;
				/*for(var i = 0, i < this.styleSheetList.length; i++)
				{
					if(styleName == this.styleSheetList[i])
					{
						found = true;
					}
				}*/
				if(this.styleSheetList.indexOf(styleName) != -1)
				{
					found = true;
				}
				if(!found)
				{
					styleName = this.defaultStyleSheet;
				}
				
				Cookie.SetCookie("webclientstylesheet",styleName);
			}
		},
		
		Get:function(){ 
			var css = Cookie.GetCookie("webclientstylesheet");
			if(!css)
			{
				css = this.defaultStyleSheet;
			}
			if(this.styleSheetList.indexOf(css) < 0)
			{
				css = this.defaultStyleSheet;
			}
			
			return css;			
		},
		
		end:true		
	},
	
	end:true	
};

/* 页面加载 */
if(window.attachEvent){
	window.attachEvent(
		"onload",
		function(){
			if(WebClient && typeof WebClient == "object" && typeof WebClient.Load == "function")
			{			
				WebClient.Load();
			}
		} 
	); 		   
	window.attachEvent(
		"onunload",
		function(){
			if(WebClient && typeof WebClient == "object" && typeof WebClient.UnLoad == "function")
			{
				WebClient.UnLoad();
			}			
		} 
	); 
}
else
{
	 window.addEventListener(
        "load",
        function(){
            if (WebClient && typeof WebClient == "object" && typeof WebClient.Load == "function")
            {
                WebClient.Load();
            } 
        },
        false
    );	
}