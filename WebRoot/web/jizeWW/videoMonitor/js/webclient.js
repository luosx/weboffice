/**
* WebClient 中外合资创世科技版权所有.  
* FileName.......: webclient.js
* Project........: Nrcap2JavascriptSDK
* Create datetime: 2011/02/16 10:50:00 $
*/

var WebClient = {
    type: "client", //'client'..'demo' 
	version: "v2011.09.28.1",
	debug: false, // 是否打开调试状态 
	agt: navigator.userAgent.toLowerCase(), 
	Debug: null,
	connectId: null,
	time: new Date(),
	sortList: true, // 是否资源排序显示
 	updateOnline: false, // 是否定时刷新资源在线状态 
	frameBody: "",  
	
	/*
	* 对象		：loginDefaultParams
	* 函数功能	：WEB默认登陆参数设置
	* 备注		：无
	* 作者		：huzw
	* 时间		：2011.02.16
	*/
	loginDefaultParams:{ 
		style: "auto", // 登录模式 {"auto"(自动), "normal"(常规)}
		//path: "127.0.0.1:8866", 
		path: "58.218.50.172:8866", 
		epId: "system",
		username: "admin",
		password: "a.xuzhouzfjc",  
		areaCode: "",
		clientType: "",
		userCustomData: "",
		bFixCUIAddress: "1",
		end: true
	},
	
	loginParams: null,
	 
	webDebug: false, // 是否打开web页面调试
	pluginDebug: false, // 是否打开sdk插件调试
	
	noLogin: false, // 内部使用/true(不登陆)/
	
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
		WebClient.Debug = new Utility.Debug(
			new Utility.Struct.DebugParamStruct(
				( WebClient.debug || WebClient.webDebug ),
				"watch",
				{
					top:200,
					left:650
				}
			)
		);
		 
		/* 初始化Nrcap2对象 */
		Nrcap2.Init(
			new Nrcap2.Struct.InitParamStruct(
				( WebClient.debug || WebClient.pluginDebug ),
				function(msg){
					WebClient.Debug.Note(msg);
				}
			)
		);
		 
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
		WebClient.Event.UnLoad(); 
		Utility.Clock.Stop();
		WebClient.Query.StopAllPlayVod();
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
		WebClient.Query.StopAllPlayVod();
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
			
			WebClient.CardPad.Init(); //加载主选项卡元素 
			
			WebClient.NavMenu.Init(); //加载主导航元素 
			
			WebClient.Content.Init(); //加载主内容元素 
			
			var curCard = WebClient.CardPad.currentCardKey; 
			WebClient.CardPad.SwitchCard(curCard); //激活选项卡，默认为videoScan
			//WebClient.CardPad.SwitchCard("queryDownload"); //激活queryDownload为了测试 
			//WebClient.CardPad.SwitchCard("platformManagement"); //激活platformManagement为了测试 
			//WebClient.CardPad.SwitchCard("deviceManagement"); //激活deviceManagement为了测试  
			
			WebClient.DealManage.Init(); // 辅助管理 
			
			window.setTimeout(
				function(){
					WebClient.Resource.FetchResource(); //获取资源
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
					
					var path = Nrcap2.Connections.get(WebClient.connectId).connParam.path;
					var username = Nrcap2.Connections.get(WebClient.connectId).connParam.username;
					var epId = Nrcap2.Connections.get(WebClient.connectId).connParam.epId;
					
					var userInfoStr = "地址：" + path + "，用户：" + username + "@" +  epId;
					
					window.status = userInfoStr;					
				}			
			}	
			else
			{  
				if(rv != null && typeof rv != "undefined")
				{
					alert(Nrcap2.NrcapError.ShowMessage(rv));
				}
				return;
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
			
			htmlstr += "<div id=\"topFrame\" class=\"topFrame\">";
				htmlstr += "<div id=\"cardRegion\" class=\"cardRegion\" style=\"display:none;\"></div>";
				htmlstr += "<div id=\"navMenuRegion\" class=\"navMenuRegion\"></div>";
			htmlstr += "</div>";
			htmlstr += "<div id=\"mainFrame\" class=\"mainFrame\">";
				htmlstr += "<div id=\"mainRegion\" class=\"mainRegion\"></div>";			 	
			htmlstr += "</div>";
			htmlstr += "<div id=\"bottomFrame\" class=\"bottomFrame\">";
				// htmlstr += "<br />Copyright (C) 2002-"+(new Date().getFullYear())+" 中外合资创世科技版权所有 All Rights Reserved.";
			htmlstr += "</div>";
			
			return htmlstr;
		},
		
		end:true
	},
	
	/*
	*	函数名		：CardPad
	*	函数功能   	：页面选项卡对象		
	*	备注			：无
	*	作者			：huzw
	*	时间			：2011.02.17		
	*/
	CardPad:{
		navCardInfo: new Hash(), // 用于切换导航信息
		currentCardKey: "videoScan",
		
		/*
		*	函数名		：Init
		*	函数功能   	：创建页面选项卡框架 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.02.17 
		*/
		Init:function(){
			var htmlstr = WebClient.CardPad.Html(); //html		
			if($("cardRegion"))
			{
				$("cardRegion").innerHTML = htmlstr;  
				 
				var navCards = $("cardRegion").getElementsByTagName("DIV");
				for(var i = 0; i < navCards.length; i++)
				{
					var navCard = navCards[i], _contentpadkey = "";
					if(navCard && navCard.id && navCard.type && navCard.type == "card")
					{
						if(navCard.id.search("video") != -1) _contentpadkey = "videoPad";
						else if(navCard.id.search("query") != -1) _contentpadkey = "queryPad";
						else if(navCard.id.search("platform") != -1) _contentpadkey = "platformPad";
						else if(navCard.id.search("device") != -1) _contentpadkey = "devicePad";
						
						this.navCardInfo.set(navCard.id,{active:false, navcardkey:navCard.id, navpadkey:navCard.id + "NavPad", contentpadkey:_contentpadkey}); 
						navCard.onclick = function(){
							WebClient.CardPad.SwitchCard(this.id); //激活选项卡 
						}; 
					}
					
				} 
				 
				WebClient.CardPad.currentCardKey = "videoScan";
				
				WebClient.CardPad.AttachCardEvent(); //绑定事件  
				
				WebClient.Skin.Init(); 
			}
			else
			{
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.CardPad.Init",msg:"创建选项卡html元素失败,cardRegion对象不存在"});	
			}
		},
		
		Html:function(){
			var htmlstr = "";
			
			htmlstr += "<div id=\"cardBox\" class=\"cardBox\">";
				htmlstr += "<div id=\"videoScan\" class=\"cardPad\" type=\"card\" title=\"视频浏览\">视频浏览</div>";
				htmlstr += "<div id=\"queryDownload\" class=\"cardPad\" type=\"card\" title=\"查询下载\">查询下载</div>";
				htmlstr += "<div id=\"platformManagement\" class=\"cardPad\" type=\"card\" title=\"平台管理\">平台管理</div>";
				htmlstr += "<div id=\"deviceManagement\" class=\"cardPad\" type=\"card\" title=\"设备管理\">设备管理</div>";
			htmlstr += "</div>"; 
			htmlstr += "<div id=\"styleBox\" class=\"styleBox\" style=\"display:"+(WebClient.type == "demo" ? "none" : "block")+";\">";
			htmlstr += "</div>";
			
			return htmlstr;  
		},
		
		AttachCardEvent:function(){
			var cards = $("cardRegion").getElementsByTagName("DIV");
			for(var i = 0;i < cards.length;i++)
			{
				var card = cards[i];
				if(card.type == "card")
				{
					card.onmouseover = function(){
						this.style.backgroundColor = "#E3EDF9";				
					}
					card.onmouseout = function(){
						if(this.id == WebClient.CardPad.currentCardKey) return;
						else this.style.backgroundColor = "";					
					}
					card.onclick = function(){
						WebClient.CardPad.SwitchCard(this.id);				
					} 
				} 
			} 
			
		},
		
		SwitchCard:function(cardKey){  
			// alert(Object.toJSON(WebClient.CardPad.navCardInfo));
			if($(cardKey))
			{ 
				this.navCardInfo.each
				(
					function(item)
					{
						var node = item.value;
						
						if(item.key == cardKey)
						{
							node.active = true; 	 	
							WebClient.CardPad.currentCardKey = cardKey;
						}
						else { node.active = false; }
						
						if($(node.navcardkey))
						{
							$(node.navcardkey).setStyle({
								fontWeight: ( node.active ? "bold" : "normal" ),
								backgroundColor: ( node.active ? "#E3EDF9" : "" ) 
							});
							// $(node.navcardkey).style.fontWeight = node.active ? "bold" : "normal";	
							// $(node.navcardkey).style.backgroundColor = node.active ? "#E3EDF9" : "";	
						}
						 
						if($(node.navpadkey)) 
						{  
							eval("$(node.navpadkey)." + (node.active ? "show()" : "hide()"));
							// node.active ? $(node.navpadkey).show() : $(node.navpadkey).hide();
							// $(node.navpadkey).style.display = node.active ? "block" : "none";	
						} 	 
						if($(node.contentpadkey)) 
						{
							eval("$(node.contentpadkey)." + (node.active ? "show()" : "hide()"));
							// node.active ? $(node.contentpadkey).show() : $(node.contentpadkey).hide();
							// $(node.contentpadkey).style.display = node.active ? "block" : "none";	 	
						} 
					}
				); 
			}
			// alert(Object.toJSON(WebClient.CardPad.navCardInfo));
			
			//this.navCardInfo.set(navCard.id,{active:false, navcardkey:navCard.id, navpadkey:navCard.id + "NavPad", contentpadkey:_contentpadkey}); 
			 
		},
		
		end:true
	},
	
	Skin:{
	    currentSkinKey:"skin_blue",
	    skinBoxActive:false,
	    
	    Init:function(){
			WebClient.Skin.currentSkinKey = "skin_blue";
			
	        var htmlstr = WebClient.Skin.Html(); //html		
			if($("styleBox"))
			{
				$("styleBox").innerHTML = htmlstr; 
				
				WebClient.Skin.AttachSkinEvent(); //绑定事件 
			}
			else
			{
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Skin.Init",msg:"创建皮肤元素失败,styleBox对象不存在！"});	
			}
	    },
	    
	    Html:function(){
	        var htmlstr = "";	          
			    htmlstr += "<div id=\"systemAbout\" webclienttype=\"about\" >";
					htmlstr += "<span id=\"systemNote\" class=\"note\">关于</span>";
					htmlstr += "<span id=\"systemDown\" class=\"down\"></span>";
				htmlstr += "</div>";
				htmlstr += "<div id=\"skinPad\" webclienttype=\"skinbar\" >";
			    	htmlstr += "<span id=\"skinIco\" style=\"display:none;\"></span>";
					htmlstr += "<span id=\"skinNote\" class=\"note\">皮肤</span>";
					htmlstr += "<span id=\"skinDown\" class=\"down\"></span>";
				htmlstr += "</div>";
			return htmlstr; 
	    },
	    
	    AttachSkinEvent:function(){
	        var styleBoxs = $("styleBox").getElementsByTagName("DIV");
			for(var i = 0; i < styleBoxs.length; i++)
			{
				var styleBox = styleBoxs[i];
				
				if(styleBox.webclienttype == "about")
				{
					styleBox.onmouseover = function(){
						this.style.fontWeight = "bold";
						this.style.backgroundColor = "#E3EDF9";
					};
					styleBox.onmouseout = function(){
						this.style.fontWeight = "normal";
						this.style.backgroundColor = "Transparent";
					};
					styleBox.onclick = function(){
						alert("Corp:crearo, Author:huzw.");
					};
					
				}
				else if(styleBox.webclienttype == "skinbar")
				{
					styleBox.onmouseover = function(){ 	
					    WebClient.Skin.skinBoxActive = true;
						this.style.fontWeight = "bold";
						this.style.backgroundColor = "#E3EDF9";
						$("skinIco").style.display = "block";
					}
					styleBox.onmouseout = function(){  
				        WebClient.Skin.skinBoxActive = false;
				        window.setTimeout(
					        function(){ 
					            if(!WebClient.Skin.skinBoxActive)  
					            {
					                $("skinBox") ? $("skinBox").remove() : "";
									$("skinPad").style.fontWeight = "normal";
									$("skinPad").style.backgroundColor = "Transparent";
									$("skinIco").style.display = "none";
					            }
					        },500
					    ); 	  
						
					}
					 
					styleBox.onclick = function(){   
						$("skinBox") ? $("skinBox").remove() : "";
						if(!$("skinBox"))
				        { 
							//var culOffset = $("skinPad").positionedOffset(); //alert(culOffset);
				            var offset = WebClient.ClientOffset($("skinPad")); //alert(offset);
				            var skinBox = document.createElement("DIV");
				            skinBox.setAttribute("id","skinBox");
				            $$("body")[0].appendChild(skinBox);
				            skinBox.style.position = "absolute";
				            skinBox.style.width = "72px";
				            skinBox.style.height = "60px";
				            skinBox.style.left = offset[0] + "px"; 
				            skinBox.style.top  = offset[1]  + $("skinPad").getHeight() + "px";
				            skinBox.style.backgroundColor = "#EAF3FC";
				            skinBox.style.display = "block";
				        } 
						
						if($("skinBox"))
						{
							var flag = "", htmlstr = "";
							
							/*var skin_url = $("switchskin").getAttribute("href");
							if(skin_url.search("blue") != -1)
							{
								flag = "blue";
							}
							else if(skin_url.search("metalgrey") != -1)
							{
								flag = "metalgrey";
							}
							else
							{
								flag = "newyear";
							}*/
							
							flag = Global.route;  
							
							htmlstr += "<div id=\"skin_blue\" class=\"skinselect\" style=\"color:#15428B;\" webclienttype=\"skin\">";
								htmlstr += "蓝色经典";
							htmlstr += "</div>";
							htmlstr += "<div id=\"skin_metalgrey\" class=\"skinselect\" style=\"color:#6C6C6C;\" webclienttype=\"skin\">";
								htmlstr += "灰色炫酷";
							htmlstr += "</div>";
							htmlstr += "<div id=\"skin_newyear\" class=\"skinselect\" style=\"color:#FF0000;\" webclienttype=\"skin\">";
								htmlstr += "红色旋风";
							htmlstr += "</div>";
							
							$("skinBox").innerHTML = htmlstr;	
							
							var skins = $("skinBox").getElementsByTagName("DIV");
							for(var j = 0; j < skins.length; j++)
							{
								var skin = skins[j];
								if(skin.id && skin.webclienttype == "skin")
								{ 
									skin.style.backgroundImage = "url(images/"+skin.id.replace("skin_","")+".png)"; 
									
									skin.onmouseover = function(){
										this.style.fontWeight = "bold";
										this.style.border = "1px #FFFFFF solid";  
										this.style.backgroundColor = "#FFFFFF"; 
									};
									skin.onmouseout = function(){
										this.style.fontWeight = "normal";
										this.style.border = "0px #FFFFFF solid";
										this.style.borderBottom = "1px #FFFFFF dotted";
										this.style.backgroundColor = "Transparent"; 
									};
									skin.onclick = function(){
										WebClient.Skin.currentSkinKey = this.id;
										
										var preskincss = this.id.replace("skin_","");
										var href = "images/" + preskincss + ".css";
										$("switchskin").setAttribute("href",href);
										
										WebClient.Skin.skinBoxActive = false; 
										$("skinBox") ? $("skinBox").style.display = "none" : ""; 
										
										$("skinIco") ? $("skinIco").style.backgroundImage = "url(images/"+preskincss+".png)" : "";
										
										WebClient.Skin.SwitchSkinDisplay(); //切换页面活动显示效果
										
									};
								} //end if
								
							} //end for
							
						} 
						
				        $("skinBox").onmouseover = function(){
				            WebClient.Skin.skinBoxActive = true; 
				        }
				        $("skinBox").onmouseout = function(){
				            WebClient.Skin.skinBoxActive = false; 
				            window.setTimeout(
					            function(){ 
					                if(!WebClient.Skin.skinBoxActive)  
					                {
					                    $("skinBox") ? $("skinBox").remove() : "";
										$("skinPad").style.fontWeight = "normal";
										$("skinPad").style.backgroundColor = "Transparent";
										$("skinIco").style.display = "none";
					                }
					            },500
					        );
				        }
						 
						
					} // end onclick skinbox 
					
				} //end if style 
			} // end for i
	    },
	    
		/*
		*	函数名		：SwitchSkinDisplay
		*	函数功能   	：切换页面活动显示效果	
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.03.17	
		*/
		SwitchSkinDisplay:function(){  
			
			var curSkinKey = WebClient.Skin.currentSkinKey; 
			if(curSkinKey)
			{
				Global.Init(curSkinKey); /* 重置一些全局变量对象 */
			} 
			
			WebClient.NavMenu.AttachMenuEvent(); /* 改变导航头风格 */ 
			
			WebClient.Video.AttachChangeNumberEvent(); /* 改变切换窗口数量条风格 */ 
			
			var curActiveWnd = WebClient.Video.curActiveWindowKey;
			WebClient.Video.ActiveWindow(curActiveWnd); /* 激活窗体 */
			 
			if(WebClient.Event.eventDialogWindow) /* 事件浏览窗体 */
			{ 
				var dialog = WebClient.Event.eventDialogWindow;
				if(typeof dialog.EventExplore.SwitchLinkStyle != "undefined")
				{
					dialog.EventExplore.SwitchLinkStyle(); /* 切换样式 */
				}
				
			}
		},
		
	    end:true	
	},
	
	/*
	*	函数名		：NavMenu
	*	函数功能   	：页面导航控制对象		
	*	备注			：无
	*	作者			：huzw
	*	时间			：2011.02.18		
	*/
	NavMenu:{
		timer:null,
	    currentMenuPadKey:"videoScanNavPad",
		currentQueryMenuId:"mm_query_vod",
	    
		Week:["星期日","星期一","星期二","星期三","星期四","星期五","星期六"],
		
		/*
		*	函数名		：Init
		*	函数功能   	：初始化页面导航控制		
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.02.18		
		*/
	    Init:function(){
			WebClient.NavMenu.currentMenuPadKey = "videoScanNavPad";
			WebClient.NavMenu.currentQueryMenuId = "mm_query_vod";
			
	        var htmlstr = "";
	        htmlstr = WebClient.NavMenu.Html();
	        if($("navMenuRegion"))
	        {
                $("navMenuRegion").innerHTML = htmlstr; 	
				
				$(WebClient.NavMenu.currentMenuPadKey)
				{
					$(WebClient.NavMenu.currentMenuPadKey).style.display = "block";
					
				}
				
	            WebClient.NavMenu.AttachMenuEvent(); 
				
				Utility.Clock.EventCallback.Set(
					new Utility.Struct.ClockEventStruct(
						"webtime",
						1000,
						function(t){
							if($("web_time"))
							{  
								var htmlstr = "";
								
								var timestr = t.format("HH:mm:ss");
								var datestr = t.format("yyyy.MM.dd");
								var week = WebClient.NavMenu.Week[t.getDay()];
								
								htmlstr += "<font size=\"5\">" + timestr +"</font><br />" + datestr + " "+ week;
								$('web_time').innerHTML = htmlstr;
								
							}     
						}
					)
				);
	        }
			else
			{
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.NavMenu.Init",msg:"创建导航条html元素失败,navMenuRegion对象不存在"});	
			}
	    },
	  
	    Html:function(){
	        var htmlstr = "";
	        
	        htmlstr += "<div id=\"videoScanNavPad\">";
	        htmlstr +="</div>"; //video
	        return htmlstr;
	    },
	    
		AttachMenuEvent:function(){
			var route = Global.route;
			var folder = Global.folder; 
			
			if($("videoScanNavPad"))
			{
				var videoNavMenu = $("videoScanNavPad").getElementsByTagName("INPUT");
				for(var i = 0;i < videoNavMenu.length;i++)
				{
					var video_navmenu = videoNavMenu[i];
					if(video_navmenu.type == "button" && video_navmenu.id.search("mm_v")!= -1)
					{						
						if(video_navmenu.disabled)
						{
							video_navmenu.style.backgroundImage = "url(images/"+route+"/"+folder+"/top_menuicon_u1_3.png)";
						}
						else
						{
							video_navmenu.style.backgroundImage = "url(images/"+route+"/"+folder+"/top_menuicon_u1_1.png)";
						}	
						
						video_navmenu.onmouseover = function(){
							this.style.backgroundImage = this.style.backgroundImage.toString().substr(this.style.backgroundImage.toString().length - 6, 1) > 3-1 ? "url(images/"+route+"/"+folder+"/top_menuicon_u1_5.png)" : "url(images/"+route+"/"+folder+"/top_menuicon_u1_2.png)";

						}
						video_navmenu.onmouseout = function(){
							this.style.backgroundImage = this.style.backgroundImage.toString().substr(this.style.backgroundImage.toString().length - 6, 1) > 3 ? "url(images/"+route+"/"+folder+"/top_menuicon_u1_4.png)" : "url(images/"+route+"/"+folder+"/top_menuicon_u1_1.png)";
						}
						video_navmenu.onclick = function(){
							WebClient.NavMenu.OnClick(this.id);
						} 
					}
				}	
				
				if($("mm_v_event"))
				{
					/* $("mm_v_event").onmouseover = function(){
						// window.
						WebClient.pop = window.createPopup()
						var pbody=WebClient.pop.document.body
						pbody.style.backgroundColor="lime"
						pbody.style.border="solid black 1px"
						pbody.innerHTML="<div disabled><img src=\"images/blue/platform-mgt-submit.jpg\" /></div>"
						// pbody.onclick = function(){$("mm_v_event").onclick();}
						
						var dimensions = $(this.id).getDimensions(); 
						var top = this.offsetTop;
						var left = this.offsetLeft;
						var width = dimensions.width;
						var height = dimensions.height;  
						
						WebClient.pop.show(200,(top + height + 5),200,50,document.body); 
						
						window.setInterval
						(
							function(){ // alert(WebClient.pop);
							//	WebClient.pop.show(200, 300,200,50,document.body);
							}, 1000
						);
						

					};
					$("mm_v_event").onmouseout = function(){
						// WebClient.pop.hide();
					}; */
				}
				
			}
			  
			if($("queryDownloadNavPad"))
			{
				var queryNavMenu = $("queryDownloadNavPad").getElementsByTagName("INPUT");
				for(var i = 0;i < queryNavMenu.length;i++)
				{
					var query_navmenu = queryNavMenu[i];
					if(query_navmenu.type == "button" && query_navmenu.id.search("mm_q")!= -1)
					{						
						 
						query_navmenu.style.backgroundImage = "url(images/blue/top_menuicon_u1_1.png)";
						 
						query_navmenu.onmouseover = function(){
							//this.style.backgroundImage = this.style.backgroundImage.toString().substr(this.style.backgroundImage.toString().length - 6, 1) > 3-1 ? "url(images/blue/top_menuicon_u1_5.png)" : "url(images/blue/top_menuicon_u1_2.png)";
							if(this.style.backgroundImage == "url(images/blue/top_menuicon_u1_5.png)")
							{
								return;	
							}
							this.style.backgroundImage = "url(images/blue/top_menuicon_u1_2.png)";
						}
						query_navmenu.onmouseout = function(){
							//this.style.backgroundImage = this.style.backgroundImage.toString().substr(this.style.backgroundImage.toString().length - 6, 1) > 3 ? "url(images/blue/top_menuicon_u1_4.png)" : "url(images/blue/top_menuicon_u1_1.png)";
							
							if(this.style.backgroundImage == "url(images/blue/top_menuicon_u1_5.png)")
							{
								return;	
							}
							this.style.backgroundImage = "url(images/blue/top_menuicon_u1_1.png)";
						}
						query_navmenu.onclick = function(){
							WebClient.NavMenu.OnClick(this.id);
							
							if(this.id == "mm_q_event") return;
							
							$(WebClient.NavMenu.currentQueryMenuId).style.backgroundImage = "url(images/blue/top_menuicon_u1_1.png)";
							this.style.backgroundImage = "url(images/blue/top_menuicon_u1_5.png)";
							WebClient.NavMenu.currentQueryMenuId = this.id;
							
						} 
					
					} 
					
				}	
				//激活“录像查询” 
				$(WebClient.NavMenu.currentQueryMenuId).style.backgroundImage = "url(images/blue/top_menuicon_u1_5.png)";
				
			}
			
			if($("platformManagementNavPad"))
			{
				var platformNavMenu = $("platformManagementNavPad").getElementsByTagName("INPUT");
				for(var i = 0; i < platformNavMenu.length; i++)
				{
					var platform_navmenu = platformNavMenu[i];
					if(platform_navmenu && platform_navmenu.menutype == "button")
					{
						if(platform_navmenu.id.search("mm_p_") != -1)
						{
							platform_navmenu.style.backgroundImage = "url(images/blue/top_menuicon_u1_1.png)";
						}
						else
						{ 
						    platform_navmenu.style.backgroundImage = "url(images/blue/platformMgt.jpg)"; 
						}
						
						platform_navmenu.onmouseover = function(){
						 	if(this.id.search("mm_p_") != -1)
							{
								this.style.backgroundImage = "url(images/blue/top_menuicon_u1_2.png)";
							}
							else
							{
								this.style.backgroundImage = "url(images/blue/platformMgt.jpg)";
							}
							
						};
						platform_navmenu.onmouseout = function(){
						 	if(this.id.search("mm_p_") != -1)
							{
								this.style.backgroundImage = "url(images/blue/top_menuicon_u1_1.png)";
							}
							else
							{
								this.style.backgroundImage = "url(images/blue/platformMgt.jpg)";
							}
						};
						platform_navmenu.onclick = function(){
						 	WebClient.NavMenu.OnClick(this.id);
						};
					} // menutype='button'
					
					if(platform_navmenu && platform_navmenu.menutype == "button-tool")
					{
						platform_navmenu.disabled = true;
						platform_navmenu.onclick = function(){  
						 	WebClient.NavMenu.OnClick(this.id);
						};
					} // menutype='button-tool'
					
				}
			}
			 
			if($("deviceManagementNavPad"))
			{
				var deviceNavMenu = $("deviceManagementNavPad").getElementsByTagName("INPUT");
				for(var i = 0; i < deviceNavMenu.length; i++)
				{
					var device_navmenu = deviceNavMenu[i];
					if(device_navmenu && device_navmenu.menutype == "button")
					{
						if(device_navmenu.id.search("mm_d_") != -1)
						{
							device_navmenu.style.backgroundImage = "url(images/blue/top_menuicon_u1_1.png)";
						}
						else
						{ 
						    device_navmenu.style.backgroundImage = "url(images/blue/platformMgt.jpg)"; 
						}
						
						device_navmenu.onmouseover = function(){
						 	if(this.id.search("mm_d_") != -1)
							{
								this.style.backgroundImage = "url(images/blue/top_menuicon_u1_2.png)";
							}
							else
							{
								this.style.backgroundImage = "url(images/blue/platformMgt.jpg)";
							}
							
						};
						device_navmenu.onmouseout = function(){
						 	if(this.id.search("mm_d_") != -1)
							{
								this.style.backgroundImage = "url(images/blue/top_menuicon_u1_1.png)";
							}
							else
							{
								this.style.backgroundImage = "url(images/blue/platformMgt.jpg)";
							}
						};
						device_navmenu.onclick = function(){
						 	WebClient.NavMenu.OnClick(this.id);
						};
					} // menutype='button'
					
					if(device_navmenu && device_navmenu.menutype == "button-tool")
					{
						device_navmenu.disabled = true;
						device_navmenu.onclick = function(){  
						 	WebClient.NavMenu.OnClick(this.id);
						};
					} // menutype='button-tool'
				}
			}
			
		},
		
		Disabled:function(disabled){ 
			var route = Global.route;
			var folder = Global.folder; 
			
			if(WebClient.NavMenu.currentMenuPadKey == "videoScanNavPad")
			{
				var videoNavMenu = $("videoScanNavPad").getElementsByTagName("INPUT");
				for(var i = 0;i < videoNavMenu.length;i++)
				{
					var video_navmenu = videoNavMenu[i];
					if(video_navmenu.type == "button" && video_navmenu.id.search("mm_video_")!= -1)
					{	
						video_navmenu.disabled = disabled;
						
						video_navmenu.style.backgroundImage = disabled ? "url(images/"+route+"/"+folder+"/top_menuicon_u1_3.png)" : "url(images/"+route+"/"+folder+"/top_menuicon_u1_1.png)";
					} 
				}
			}
			else
			{
				
			}
		},
		
		/*
		*	函数名		：OnClick
		*	函数功能   	：主导航菜单点击响应处理
		*	备注		：无
		*	作者		：huzw
		*	时间		：2011.02.18		
		*/
	    OnClick:function(navMenuId)
	    {
	        switch(navMenuId)
			{
				case "mm_v_exit":
				case "mm_q_exit":
				case "mm_p_exit":
				case "mm_d_exit":
					WebClient.Exit();
					break;
				case "mm_video_fullscreen": 
					Nrcap2.WindowContainers.each(
						function(item){
							var node = item.value;
							if(node.window && node.active)
							{
								if(node.window.status.playvideoing)
								{ 
									node.window.wnd.fullScreen();
								}
							}
						}
					); 
					break;
				case "mm_video_audio": 
					Nrcap2.WindowContainers.each(
						function(item){
							var node = item.value;
							if(node.window && node.active)
							{
								if(node.window.status.playvideoing)
								{
									WebClient.Video.PlayAudio(item.key);
									return;
								}
							}
						}
					);
					break;
				case "mm_video_snapshot": 
					Nrcap2.WindowContainers.each(
						function(item){
							var node = item.value;
							if(node.window && node.active)
							{
								if(node.window.status.playvideoing)
								{
									WebClient.Video.SnapShot(item.key);
									return;
								}
							}
						}
					);
					break;
				case "mm_video_record": 
					Nrcap2.WindowContainers.each(
						function(item){
							var node = item.value;
							if(node.window && node.active)
							{
								if(node.window.status.playvideoing)
								{
									WebClient.Video.LocalRecord(item.key);
									return;
								}
							}
						}
					);
					break; 
				case "mm_query_vod":
					if($("queryToolbar1"))
					{
						$("queryToolbar1").innerHTML = "录像查询";	
					}
					if($("queryDisplayPad"))
					{
						if($("queryDetailDownloadPad"))
						{
							if($("detailTitle")) $("detailTitle").style.width = "482px";
							if($("detailTitleMiddle")) $("detailTitleMiddle").style.width = "388px"; 
							
							if($("detailContent")) $("detailContent").style.width = "485px";
							if($$("#detailContent .detailInfo")) 
							{
								for(var i = 0;i < $$("#detailContent .detailInfo").length;i++)
								{
									$$("#detailContent .detailInfo")[i].style.width = "478px";
								} 
							}
							
							if($("downloadTitle")) $("downloadTitle").style.width = "480px";
							if($("downloadContent")) $("downloadContent").style.width = "480px";
							
							$("queryDetailDownloadPad").style.width = "485px";
							
						}
						$("queryDisplayPad").style.display = "block";	
						
						var queryDCardId = "downloadVodCard";
						if($(queryDCardId))
						{
							//下载容器框切换vod
							WebClient.Query.SwitchDownloadCard(queryDCardId);
						}
						
					}
					break;
				case "mm_query_image":
					if($("queryToolbar1"))
					{
						$("queryToolbar1").innerHTML = "图片查询";	
					}
					if($("queryDisplayPad"))
					{
						$("queryDisplayPad").style.display = "none";
						
						if($("queryDetailDownloadPad"))
						{
							$("queryDetailDownloadPad").style.width = "806px";
							
							if($("detailTitle")) $("detailTitle").style.width = "804px";
							if($("detailTitleMiddle")) $("detailTitleMiddle").style.width = "718px"; 
							 	 
							if($("detailContent")) $("detailContent").style.width = "806px";
							if($$("#detailContent .detailInfo")) 
							{
								for(var i = 0;i < $$("#detailContent .detailInfo").length;i++)
								{
									$$("#detailContent .detailInfo")[i].style.width = "798px";
								} 
							}
							
							if($("downloadTitle")) $("downloadTitle").style.width = "801px";
							if($("downloadContent")) $("downloadContent").style.width = "801px";
							
							var queryDCardId = "downloadImageCard";
							if($(queryDCardId))
							{
								//下载容器框切换image
								WebClient.Query.SwitchDownloadCard(queryDCardId);
							}
							
						}
					}
					break;	
					
				case "mm_platform_storage":
					WebClient.Resource.PlatformResource.SwitchPRes(navMenuId);
					break;
				case "mm_platform_tool_scan":
					WebClient.Resource.PlatformResource.Control("scan"); 
					break;
				case "mm_platform_tool_add":					 
					WebClient.Resource.PlatformResource.Control("add");
					break;	
				case "mm_platform_tool_modify":
					WebClient.Resource.PlatformResource.Control("modify"); 
					break;
				case "mm_platform_tool_delete":
					WebClient.Resource.PlatformResource.Control("delete"); 
					break;	
				case "mm_platform_tool_submit":
					WebClient.Resource.PlatformResource.Control("submit");
					break;	
				
				case "mm_device_tool_submit":
					WebClient.Resource.DeviceResource.Submit();
					break;
					
				case "mm_v_event":
				case "mm_q_event":
					WebClient.Event.Show(); // 事件浏览
					break;
					
				case "mm_v_allfullscreen":
					WebClient.DealManage.AllFullScreen.Start();
					
					/* window.setTimeout(function(){
						WebClient.Video.ChangeWindow(6);
						if(WebClient.DealManage.AllFullScreen.flag == 'start'){
							WebClient.DealManage.AllFullScreen.Start(); 
						} 
					}, 3000); */
					
					break;
				case "mm_v_closeallfullscreen":
					WebClient.DealManage.AllFullScreen.Stop();
					break;
					
				default:
					break;
			}
	    },
	    
	    end:true  
	},
	 
	DealManage: {
	
		Init: function(){ 
			WebClient.Event.Init(); // 接收平台事件 
			
			if($("windowPad")){
				/* 快捷键设置 ESC[three methods]
				document.onkeydown = function(){
					// alert(event.keyCode);
					if (event.keyCode == 27){
						// 退出多窗口全屏显示【ESC】



						if(WebClient.DealManage.AllFullScreen.flag == 'start'){
							WebClient.DealManage.AllFullScreen.Stop(); 
						}  
					} else if (event.shiftKey && event.keyCode == 70){
						// 开启多窗口全屏显示【Shift + F】



						if(WebClient.DealManage.AllFullScreen.flag != 'start'){  
							WebClient.DealManage.AllFullScreen.Start(); 
						}   
					}
				};
				
				Event.observe(
					document.body, 
					"keydown", 
					function(event){
						// alert(event.keyCode);
						if (event.keyCode == 27){
							// 退出多窗口全屏显示【ESC】



							if(WebClient.DealManage.AllFullScreen.flag == 'start'){
								WebClient.DealManage.AllFullScreen.Stop(); 
							}  
						} else if (event.shiftKey && event.keyCode == 70){
							// 开启多窗口全屏显示【Shift + F】



							if(WebClient.DealManage.AllFullScreen.flag != 'start'){  
								WebClient.DealManage.AllFullScreen.Start(); 
							}   
						}
					}
				);*/
				document.observe( 
					"keydown", 
					function(event){
						// alert(event.keyCode);
						if (event.keyCode == 27){
							// 退出多窗口全屏显示【ESC】



							if(WebClient.DealManage.AllFullScreen.flag == 'start'){
								WebClient.DealManage.AllFullScreen.Stop(); 
							}  
						} else if (event.shiftKey && event.keyCode == 70){
							// 开启多窗口全屏显示【Shift + F】



							if(WebClient.DealManage.AllFullScreen.flag != 'start'){  
								WebClient.DealManage.AllFullScreen.Start(); 
							}   
						}
						
					}
				);  
			} 
		
		},
		
		AllFullScreen: {
			flag: 'stop', /* 多窗口全屏状态 */
			top: '25', /* 距离上部像素 */
			
			Bind: function(){ 
				if(this.flag == 'start'){
					var demensions = document.viewport.getDimensions();  
					var clientW = demensions.width;
					var clientH = demensions.height;
					
					if(!$("AllFullScreen_Top"))
					{ 
						if(!$("AllFullScreen_Bg")) 
						{
							var AllFullScreen_Bg = document.createElement("DIV");
							AllFullScreen_Bg.setAttribute("id", "AllFullScreen_Bg");
							$$("body")[0].appendChild(AllFullScreen_Bg);  
						}
						
						var AllFullScreen_Top = document.createElement("DIV");
						AllFullScreen_Top.setAttribute("id", "AllFullScreen_Top");
						$("AllFullScreen_Bg").appendChild(AllFullScreen_Top);
						$("AllFullScreen_Top").setStyle({
							position: "absolute",
							top: "0px",
							left: "0px",
							width: "100%",
							height: (this.top - 2) + "px",
							margin: "0px 0px 0px 0px", 
							textAlign: "center",
							backgroundColor: "#161513",
							color: "#FFFFFF"
						});
						var htmlstr = '<input type=button id="Close_AllFullScreen" onclick="WebClient.DealManage.AllFullScreen.Stop();" style="font-size:11px;" value="退出多窗口全屏显示【ESC】" />';
						$("AllFullScreen_Top").update(htmlstr);
						
					}  
					
					$("AllFullScreen_Bg").setStyle({
						zIndex: "999",
						position: "absolute",
						top: "0px",
						left: "0px",
						width: (clientW + document.body.scrollWidth) / 2,
						height: document.body.scrollHeight
					});
						
					$("AllFullScreen_Top").show();
					$("AllFullScreen_Bg").show();
				}
				else
				{  
					if($("AllFullScreen_Bg")) 
					$("AllFullScreen_Bg").hide();
					else
					$("AllFullScreen_Top").hide();
				} 
				
			}, 
			
			Start: function(){
				try
				{
					this.flag = 'start';
					this.Bind();
					
					var curwndno = WebClient.Video.curWindowNumber;
					 
					var demensions = document.viewport.getDimensions();  
					var clientW = demensions.width;
					var clientH = demensions.height;
					
					if($("windowPad"))
					{
						WebClient.Video.curChangeWndFlag = true;
						
						$("windowPad").setStyle({
							zIndex: "9999",
							position: "absolute",
							top: this.top + "px",
							left: "0px",
							width: clientW + "px",
							height: (clientH - this.top) + "px"//,
							// backgroundColor: "#C2E1FE"
						});
						
						switch(curwndno)
						{
							case 1: 
								if(curwndno == 1)
								{
									var bg_img = "images/playwindow0.png";
									var bg_color = "#161514";
								}
							case 4: 
								if(curwndno == 4)
								{
									var bg_img = "images/playwindow1.png";
									var bg_color = "";
								}
							case 9: 
								if(curwndno == 9)
								{
									var bg_img = "images/playwindow6.png";
									var bg_color = "";
								}									
							case 16:
								if(curwndno == 16)
								{
									var bg_img = "images/playwindow4.png";
									var bg_color = "";
								}
								
								var blocknum = Math.sqrt(curwndno);
								var blankW = (blocknum - 1) * 2;  
								var eachW = Math.floor((clientW - blankW)/blocknum) - 2; // alert(eachW); 
								var eachH = Math.floor((clientH - blankW - this.top)/blocknum); // alert(eachH);   
								
								Nrcap2.WindowContainers.each(
									function(item){
										var node = item.value;
										if(node.type != Nrcap2.Enum.NrcapStreamType['st_video']) return;								
										var objId = item.key;
										if($(objId))
										{
											$(objId).setStyle({ 
												width: eachW + "px",
												height: eachH + "px",
												backgroundColor: ""
											});
											
											if($(objId.gsub(/windowbox*/,"window"))){
												$(objId.gsub(/windowbox*/,"window")).setStyle({ 
													width: eachW + "px",
													height: (eachH - 15)+ "px", 
													backgroundImage: "url("+bg_img+")",
													backgroundColor: bg_color
												});
											}
											
											if(node.window && node.window.wnd){
												node.window.wnd.style.width = (eachW - 4) + "px";
												node.window.wnd.style.height = (eachH - 15 - 4) + "px"; 
											}
											
											if($(objId.gsub(/windowbox*/,"windowtitle"))){
												$(objId.gsub(/windowbox*/,"windowtitle")).setStyle({ 
													width: eachW + "px",
													height: "15px",
													backgroundColor: ""
												});
											}
											
											if($$("#" + objId.gsub(/windowbox*/,"windowtitle") + " .title1")[0]){
												$$("#" + objId.gsub(/windowbox*/,"windowtitle") + " .title1")[0].setStyle({ 
													width: (eachW - 115) + "px",
													height: "15px",
													backgroundColor: ""
												}); 
											}
											
										}
										
									}
								);
								
								break;
							case 13: 
								var bg_color = "#161514";
								var bg_img_bak = bg_img = "images/playwindow4.png";
								
								var blocknum = 4;
								var blankW = (blocknum - 1) * 2;  
								var eachW = Math.ceil((clientW - blankW)/blocknum) - 2; // alert(eachW); 
								var eachH = Math.ceil((clientH - blankW - this.top)/blocknum); // alert(eachH); 
								  
								var bEachW = eachW * Math.sqrt(blocknum);
								var bEachH = eachH * Math.sqrt(blocknum);
								 
								Nrcap2.WindowContainers.each(
									function(item){
										var node = item.value;
										if(node.type != Nrcap2.Enum.NrcapStreamType['st_video']) return;	
										var objId = item.key;
										if($(objId))
										{
											var eW = eachW, eH = eachH; 
											
											if(objId == "windowbox7")
											{
												eW = bEachW;
												eH = bEachH;
												
												bg_img = "images/playwindow0.png";
												
												$(objId).setStyle({"marginLeft": "2px"});
											}
											else
											{
												bg_img = bg_img_bak;
											}
											
											$(objId).setStyle({ 
												width: eW + "px",
												height: eH + "px",
												backgroundColor: ""
											});
											
											if($(objId.gsub(/windowbox*/,"window"))){
												$(objId.gsub(/windowbox*/,"window")).setStyle({ 
													width: eW + "px",
													height: (eH - 15)+ "px",  
													backgroundImage: "url("+bg_img+")",
													backgroundColor: bg_color
												});
											}
											
											if(node.window && node.window.wnd){
												node.window.wnd.style.width = (eW - 4) + "px";
												node.window.wnd.style.height = (eH - 15 - 4) + "px"; 
											}
											
											if($(objId.gsub(/windowbox*/,"windowtitle"))){
												$(objId.gsub(/windowbox*/,"windowtitle")).setStyle({ 
													width: eW + "px",
													height: "15px",
													backgroundColor: ""
												});
											}
											
											if($$("#" + objId.gsub(/windowbox*/,"windowtitle") + " .title1")[0]){
												$$("#" + objId.gsub(/windowbox*/,"windowtitle") + " .title1")[0].setStyle({ 
													width: (eW - 115) + "px",
													height: "15px",
													backgroundColor: ""
												}); 
											}
											
										}
										
									}
								);
								
								if($$("#windowPad .window13boxTitle"))
								{ 
									$$("#windowPad .window13boxTitle").each(
										function(item){ // alert(item);
											item.setStyle({
												width: (clientW - 1) + "px",
												height: eachH + "px",
												backgroundColor: ""  
											}); 
										}
									); 		
								} 
								
								if($$("#windowPad .window13boxMiddle"))
								{
									$$("#windowPad .window13boxMiddle").each(
										function(item){ // alert(item);
											item.setStyle({
												width: (eachW + 2) + "px",
												height: bEachH + "px",
												backgroundColor: ""  
											}); 
										}
									); 
									 
								}
								
								
								break;
								
							case 6:
								if(curwndno == 6)
								{
									var bg_img = "images/playwindow6.png";
									var bg_color = "#161514";
								}
							case 8:
								if(curwndno == 8)
								{
									var bg_img = "images/playwindow4.png";
									var bg_color = "#161514";
								}
							case 10:
								if(curwndno == 10)
								{
									var bg_img = "images/playwindow4.png";
									var bg_color = "#161514";
								}
							case 12:
								if(curwndno == 12)
								{
									var bg_img = "images/playwindow9.png";
									var bg_color = "#161514";
								}
								
								var bg_img_bak = bg_img;
							 
								var blocknum = Math.floor(curwndno / 2);
								var blankW = (blocknum - 1) * 2;  
								var eachW = Math.ceil((clientW - blankW)/blocknum) - 2; // alert(eachW); 
								var eachH = Math.ceil((clientH - blankW - this.top)/blocknum); // alert(eachH); 
								
								if(curwndno == 6) eachW -= 1;
								
								var bEachW = eachW * (blocknum - 1) + blocknum;
								var bEachH = eachH * (blocknum - 1);
								 
								Nrcap2.WindowContainers.each(
									function(item){
										var node = item.value;
										if(node.type != Nrcap2.Enum.NrcapStreamType['st_video']) return;	
										var objId = item.key;
										if($(objId))
										{
											var eW = eachW, eH = eachH; 
											
											if(objId == "windowbox1")
											{
												eW = bEachW;
												eH = bEachH;
												
												bg_img = "images/playwindow0.png";
											}
											else
											{
												bg_img = bg_img_bak;
											}
											
											$(objId).setStyle({ 
												width: eW + "px",
												height: eH + "px",
												backgroundColor: ""
											});
											
											if($(objId.gsub(/windowbox*/,"window"))){
												$(objId.gsub(/windowbox*/,"window")).setStyle({ 
													width: eW + "px",
													height: (eH - 15)+ "px",  
													backgroundImage: "url("+bg_img+")",
													backgroundColor: bg_color
												});
											}
											
											if(node.window && node.window.wnd){
												node.window.wnd.style.width = (eW - 4) + "px";
												node.window.wnd.style.height = (eH - 15 - 4) + "px"; 
											}
											
											if($(objId.gsub(/windowbox*/,"windowtitle"))){
												$(objId.gsub(/windowbox*/,"windowtitle")).setStyle({ 
													width: eW + "px",
													height: "15px",
													backgroundColor: ""
												});
											}
											
											if($$("#" + objId.gsub(/windowbox*/,"windowtitle") + " .title1")[0]){
												$$("#" + objId.gsub(/windowbox*/,"windowtitle") + " .title1")[0].setStyle({ 
													width: (eW - 115) + "px",
													height: "15px",
													backgroundColor: ""
												}); 
											}
											
										}
										
									}
								);
								
								break;
							default:
								break;
						}
						
						// document.scroll
						
						// 激活窗口 
						var curActiveWndKey = WebClient.Video.curActiveWindowKey || "windowbox1";
						WebClient.Video.ActiveWindow(curActiveWndKey);
						
						
					}
				}
				catch(e)
				{
					return false;
				} 
			},
			
			Stop: function(){
				try
				{ 
					if(this.flag == 'stop'){
						return false;
					}
					this.flag = 'stop';
					this.Bind();
					
					var curwndno = WebClient.Video.curWindowNumber;
					if($("windowPad"))
					{
						WebClient.Video.curChangeWndFlag = false; 
						
						$("windowPad").setStyle({
							position: "relative",
							top: "auto",
							left: "auto",
							width: "712px",
							height: "100%", 
							overflow: "hidden"//,
							// backgroundColor: ""
						});
						  
						var wpDens = $("windowPad").getDimensions(); 
						// alert(Object.toJSON(wpDens));
						var wpW = wpDens.width;
						var wpH = wpDens.height;
						
						switch(curwndno)
						{
							case 1: 
								if(curwndno == 1)
								{
									var bg_img = "images/playwindow1.png"; 
								}
							case 4: 
								if(curwndno == 4)
								{
									var bg_img = "images/playwindow4.png"; 
								}
							case 9: 
								if(curwndno == 9)
								{
									var bg_img = "images/playwindow9.png"; 
								}									
							case 16:
								if(curwndno == 16)
								{
									var bg_img = "images/playwindow16.png"; 
								}
								
								var blocknum = Math.sqrt(curwndno);
								var blankW = (blocknum - 1) * 2;  
								var eachW = Math.ceil((wpW - blankW)/blocknum) -2; // alert(eachW); 
								var eachH = Math.ceil((wpH)/blocknum); // alert(eachH);   
								 
								Nrcap2.WindowContainers.each(
									function(item){
										var node = item.value;
										if(node.type != Nrcap2.Enum.NrcapStreamType['st_video']) return;	
										var objId = item.key;
										if($(objId))
										{
											$(objId).setStyle({ 
												width: eachW + "px",
												height: eachH + "px",
												backgroundColor: ""
											});
											
											if($(objId.gsub(/windowbox*/,"window"))){
												$(objId.gsub(/windowbox*/,"window")).setStyle({ 
													width: eachW + "px",
													height: (eachH - 15)+ "px", 
													backgroundImage: "url("+bg_img+")",
													backgroundColor: ""
												});
											}
											
											if(node.window && node.window.wnd){
												node.window.wnd.style.width = (eachW - 4) + "px";
												node.window.wnd.style.height = (eachH - 15 - 4) + "px"; 
											}
											
											if($(objId.gsub(/windowbox*/,"windowtitle"))){
												$(objId.gsub(/windowbox*/,"windowtitle")).setStyle({ 
													width: eachW + "px",
													height: "15px",
													backgroundColor: ""
												});
											}
											
											if($$("#" + objId.gsub(/windowbox*/,"windowtitle") + " .title1")[0]){
												$$("#" + objId.gsub(/windowbox*/,"windowtitle") + " .title1")[0].setStyle({ 
													width: (eachW - 115) + "px",
													height: "15px",
													backgroundColor: ""
												}); 
											}
											
										}
										
									}
								);
								
								break;
							case 13:
								var bg_color = "#161514";
								var bg_img_bak = bg_img = "images/playwindow4.png"; 
								
								var blocknum = 4;
								var blankW = (blocknum - 1) * 2;  
								var eachW = Math.ceil((wpW - blankW)/blocknum) - 2; // alert(eachW); 
								var eachH = Math.floor((wpH)/blocknum); // alert(eachH); 
								  
								var bEachW = eachW * Math.sqrt(blocknum);
								var bEachH = eachH * Math.sqrt(blocknum);
								 
								Nrcap2.WindowContainers.each(
									function(item){
										var node = item.value;
										if(node.type != Nrcap2.Enum.NrcapStreamType['st_video']) return;	
										var objId = item.key;
										if($(objId))
										{
											var eW = eachW, eH = eachH; 
											
											if(objId == "windowbox7")
											{
												eW = bEachW;
												eH = bEachH; 
												
												bg_img = bg_img_bak; 
											} 
											else
											{
												bg_img = "images/playwindow16.png"; 
											}
											
											$(objId).setStyle({ 
												width: eW + "px",
												height: eH + "px",
												backgroundColor: ""
											});
											
											if($(objId.gsub(/windowbox*/,"window"))){
												$(objId.gsub(/windowbox*/,"window")).setStyle({ 
													width: eW + "px",
													height: (eH - 15)+ "px",  
													backgroundImage: "url("+bg_img+")",
													backgroundColor: bg_color
												});
											}
											
											if(node.window && node.window.wnd){
												node.window.wnd.style.width = (eW - 4) + "px";
												node.window.wnd.style.height = (eH - 15 - 4) + "px"; 
											}
											
											if($(objId.gsub(/windowbox*/,"windowtitle"))){
												$(objId.gsub(/windowbox*/,"windowtitle")).setStyle({ 
													width: eW + "px",
													height: "15px",
													backgroundColor: ""
												});
											}
											
											if($$("#" + objId.gsub(/windowbox*/,"windowtitle") + " .title1")[0]){
												$$("#" + objId.gsub(/windowbox*/,"windowtitle") + " .title1")[0].setStyle({ 
													width: (eW - 115) + "px",
													height: "15px",
													backgroundColor: ""
												}); 
											}
											
										}
										
									}
								);
								
								if($$("#windowPad .window13boxTitle"))
								{ 
									$$("#windowPad .window13boxTitle").each(
										function(item){ // alert(item);
											item.setStyle({
												width: (wpW - 2) + "px",
												height: eachH + "px",
												backgroundColor: ""  
											}); 
										}
									); 		
								} 
								
								if($$("#windowPad .window13boxMiddle"))
								{
									$$("#windowPad .window13boxMiddle").each(
										function(item){ // alert(item);
											item.setStyle({
												width: (eachW + 2) + "px",
												height: bEachH + "px",
												backgroundColor: ""  
											}); 
										}
									); 
									 
								}
								
								break;
								
							case 6:
								if(curwndno == 6)
								{
									var bg_img = "images/playwindow9.png";
									var bg_color = "#161514";
								}
							case 8:
								if(curwndno == 8)
								{
									var bg_img = "images/playwindow16.png";
									var bg_color = "#161514";
								}
							case 10:
								if(curwndno == 10)
								{
									var bg_img = "images/playwindow25.png";
									var bg_color = "#161514";
								}
							case 12:
								if(curwndno == 12)
								{
									var bg_img = "images/playwindow36.png";
									var bg_color = "#161514";
								}
								
								var bg_img_bak = bg_img;
							    
								var blocknum = Math.floor(curwndno / 2);
								var blankW = (blocknum - 1) * 2;  
								var eachW = Math.ceil((wpW - blankW)/blocknum) -2; // alert(eachW); 
								var eachH = Math.floor((wpH)/blocknum); // alert(eachH);   
								
								if(curwndno == 6) eachW -= 1;
								
								var bEachW = eachW * (blocknum - 1) + blocknum;
								var bEachH = eachH * (blocknum - 1);
								 
								Nrcap2.WindowContainers.each(
									function(item){
										var node = item.value;
										if(node.type != Nrcap2.Enum.NrcapStreamType['st_video']) return;	
										var objId = item.key;
										if($(objId))
										{
											var eW = eachW, eH = eachH; 
											
											if(objId == "windowbox1")
											{
												eW = bEachW;
												eH = bEachH;
												
												bg_img = "images/playwindow"+(curwndno)+".png";
											}
											else
											{
												bg_img = bg_img_bak;
											}
											
											$(objId).setStyle({ 
												width: eW + "px",
												height: eH + "px",
												backgroundColor: ""
											});
											 
											if($(objId.gsub(/windowbox*/,"window"))){
												$(objId.gsub(/windowbox*/,"window")).setStyle({ 
													width: eW + "px",
													height: (eH - 15)+ "px",  
													backgroundImage: "url("+bg_img+")",
													backgroundColor: ""
												});
											}
											
											if(node.window && node.window.wnd){
												node.window.wnd.style.width = (eW - 4) + "px";
												node.window.wnd.style.height = (eH - 15 - 4) + "px"; 
											}
											
											if($(objId.gsub(/windowbox*/,"windowtitle"))){
												$(objId.gsub(/windowbox*/,"windowtitle")).setStyle({ 
													width: eW + "px",
													height: "15px",
													backgroundColor: ""
												});
											}
											
											if($$("#" + objId.gsub(/windowbox*/,"windowtitle") + " .title1")[0]){
												$$("#" + objId.gsub(/windowbox*/,"windowtitle") + " .title1")[0].setStyle({ 
													width: (eW - 115) + "px",
													height: "15px",
													backgroundColor: ""
												}); 
											}
											
										}
										
									}
								);
							
								break;
							default:
								break;
						}
						
						// 激活窗口 
						var curActiveWndKey = WebClient.Video.curActiveWindowKey || "windowbox1";
						WebClient.Video.ActiveWindow(curActiveWndKey);
					}
				}
				catch(e)
				{
					
				} 
			},
			
			end: true 
		},
		
		end: true
	
	},
	
	/*
	*	函数名		：Event
	*	函数功能   	：接收事件对象		
	*	备注			：无
	*	作者			：huzw
	*	时间			：2011.09.19		
	*/
	Event: {
		lastEventMsg: new Object(),
		originalMessages: new Array(), // 原始的事件信息


		translateMessages: new Array(), // 转义出的事件信息
		eventMaxCount: 300, // 最大保存数 
		eventMessages: new Hash(), // 多连接下事件信息 
		eventConnectIDs: new Array(), 
		eventInterval: 1000,
		 
		eventDialogWindow: null, // 事件浏览对话框


		
		Init: function(connectId){  
			var connectId = connectId || WebClient.connectId;
			if(this.eventConnectIDs.indexOf(connectId) <= -1)
			this.eventConnectIDs.push(connectId);
			// alert(this.eventConnectIDs);
			
			this.Start(); // 启动获取事件 
		},
		
		UnLoad: function(){  
			if(this.eventDialogWindow)
			this.eventDialogWindow.close();
			
			this.lastEventMsg = new Object();
			this.originalMessages = new Array();
			this.translateMessages = new Array();
			this.eventMessages = new Hash();
			this.eventConnectIDs = new Array(); 
			
		},
		
		Start: function(evName){
			var evName = evName || "get"; // alert(evName);
			// 定时器



			Nrcap2.Timer.Set
			(
				"event",
				{
					name: evName,
					fu: function()
					{
						switch(evName)
						{
							case "get": // 获取事件
								WebClient.Event.Get();
								break;
							
							default:
								break; 
						} 
					},
					interval: this.eventInterval 
				}
			);
		},
		
		Stop: function(evName){
			var evName = evName || "get";
			Nrcap2.Timer.UnSet("event", evName); // SDK退出接收事件



		},
		
		// 获取事件
		Get: function(){
			this.eventConnectIDs = this.eventConnectIDs || [];
			this.eventConnectIDs.each
			(
				function(connID)
				{
					var eventMsg = Nrcap2.Event.Get(connID); // 获取事件
					WebClient.Event.lastEventMsg = eventMsg;
					
					try
					{
						if(eventMsg && eventMsg["name"] == "Event")
						{
							WebClient.Event.originalMessages.push(eventMsg);    
							var transEvtMsg = WebClient.Event.Translate(connID) || {}; // 转义事件信息 
							if(transEvtMsg && transEvtMsg["time"])
							WebClient.Event.translateMessages.push(transEvtMsg);
							// alert(Object.toJSON(transEvtMsg));
							if(WebClient.Event.translateMessages.length > (WebClient.Event.eventMaxCount || 500))
							{
								WebClient.Event.Clear(connID);  
							}  
							
							/* var evtMsg = WebClient.Event.eventMessages;
							if(evtMsg && !evtMsg.get(connID))
							{
								evtMsg.set(connID, {msg: new Array()})
							}
							evtMsg.get(connID).msg.push(eventMsg);  
							*/ 
						}
					}
					catch(e)
					{ 
					} 
					
				}
			);
			
			// alert(Object.toJSON(WebClient.Event.originalMessages));
			// alert(Object.toJSON(WebClient.Event.translateMessages));
							 
			// this.Show(); // 事件浏览
		}, 
		
		// 转义事件信息
		Translate: function(connectId, lastEvtMsg){ 
			if(connectId && typeof connectId != "undefined")
			{
				if(this.eventConnectIDs.indexOf(connectId) <= -1) return false;
			} 
			
			var lastEvtMsg = lastEvtMsg || WebClient.Event.lastEventMsg || {};
			
			if(!lastEvtMsg || lastEvtMsg["name"] != "Event") return false;
			
			var evtTime = "";
			var evtSrc = "";
			var evtModel = "";
			var evtDesc = "";
			var evtAlert = "否";
			
			var transEvtMsg = new Object();
			
			var attachEventFlag = false; 
			var _lg = Nrcap2.language;
			
			switch(lastEvtMsg["eventId"])
			{
				
				case "EVT_CU_Online": 
					evtModel = (_lg == "Chinese" ? "用户登陆" : "User Online");
					 
					evtDesc = "用户：" + lastEvtMsg.eventDes.UserID + ":" + lastEvtMsg.eventDes.ClientType + "；地址：" + lastEvtMsg.eventDes.Address + ":" + lastEvtMsg.eventDes.Port;
					break;
				case "EVT_CU_Offline":
					evtModel = (_lg == "Chinese" ? "用户退出" : "User Offline");
					
					evtDesc = "用户：" + lastEvtMsg.eventDes.UserID + ":" + lastEvtMsg.eventDes.ClientType + "；地址：" + lastEvtMsg.eventDes.Address + ":" + lastEvtMsg.eventDes.Port;
					break; 
				case "EVT_CU_PasswordError":
					evtModel = (_lg == "Chinese" ? "用户密码输入错误" : "User Password Error");
					
					evtDesc = "用户：" + lastEvtMsg.eventDes.UserID + ":" + lastEvtMsg.eventDes.ClientType + "；地址：" + lastEvtMsg.eventDes.Address + ":" + lastEvtMsg.eventDes.Port;
					break;	
					
				case "EVT_PU_Online": 
					evtModel = (_lg == "Chinese" ? "设备上线" : "Device Online");
					 
					var systemName = Nrcap2.Connections.get(connectId).systemName;
					evtDesc = "平台：" + systemName;
					
					attachEventFlag = true;
					break;
				case "EVT_PU_Offline": 
					evtModel = (_lg == "Chinese" ? "设备下线" : "Device Offline");
					
					var systemName = Nrcap2.Connections.get(connectId).systemName;
					evtDesc = "平台：" + systemName;
					
					attachEventFlag = true;
					break;
				case "EVT_PU_Added":
					evtModel = (_lg == "Chinese" ? "添加新设备" : "Device Added"); 
					break;
				case "EVT_PU_Deleted":
					evtModel = (_lg == "Chinese" ? "删除设备" : "Device Deleted"); 
					break;
					
				case "EVT_SC_AccountSpaceFull":
					evtModel = (_lg == "Chinese" ? "账户存储空间已满" : "Account Space Full"); 
					break;
				case "EVT_SC_AccountSpaceFullRelease":
					evtModel = (_lg == "Chinese" ? "账户存储空间已满恢复" : "Account Space Full Release"); 
					break;
				case "EVT_SC_AccountSpaceLack":
					evtModel = (_lg == "Chinese" ? "账户存储空间不足" : "Account Space Lack"); 
					break;
				case "EVT_SC_AccountSpaceLackRelease":
					evtModel = (_lg == "Chinese" ? "账户存储空间不足恢复" : "Account Space Lack Release"); 
					break;
				case "EVT_SC_DiskSpaceFull":
					evtModel = (_lg == "Chinese" ? "硬盘空间已满" : "Disk Space Full"); 
					break;
				case "EVT_SC_DiskSpaceFullRelease":
					evtModel = (_lg == "Chinese" ? "硬盘空间已满恢复" : "Disk Space Full Release"); 
					break;
				case "EVT_SC_DiskSpaceLack":
					evtModel = (_lg == "Chinese" ? "硬盘空间不足" : "Disk Space Lack"); 
					break;
				case "EVT_SC_DiskSpaceLackRelease":
					evtModel = (_lg == "Chinese" ? "硬盘空间不足恢复" : "Disk Space Lack Release"); 
					break;
					
				case "EVT_SG_DiskError": 
					evtModel = (_lg == "Chinese" ? "磁盘故障" : "Disk Error");
					
					evtDesc = "设备：" + lastEvtMsg.eventDes.PUName + "；描述：磁盘出现故障，请检查磁盘";
					break;
				case "EVT_SG_DiskSpaceFull":
					evtModel = (_lg == "Chinese" ? "磁盘空间已满" : "Disk Space Full");  
					
					evtDesc = "设备：" + lastEvtMsg.eventDes.PUName + "；描述：磁盘空间已满，请检查磁盘";
					break;
				case "EVT_SG_DiskSpaceFullRelease":
					evtModel = (_lg == "Chinese" ? "磁盘空间已满恢复" : "Disk Space Full Release"); 
					
					evtDesc = "设备：" + lastEvtMsg.eventDes.PUName + "；描述：磁盘空间已满恢复";
					break;
				case "EVT_SG_DiskSpaceLack":
					evtModel = (_lg == "Chinese" ? "磁盘空间不足" : "Disk Space Lack"); 
					
					evtDesc = "设备：" + lastEvtMsg.eventDes.PUName + "；描述：磁盘空间不足，请检查磁盘";
					break;
				case "EVT_SG_DiskSpaceLackRelease":
					evtModel = (_lg == "Chinese" ? "磁盘空间不足恢复" : "Disk Space Lack Release"); 
					
					evtDesc = "设备：" + lastEvtMsg.eventDes.PUName + "；描述：磁盘空间不足恢复";
					break;
				case "EVT_SG_StartFileSystemFailed":
					evtModel = (_lg == "Chinese" ? "启动文件系统失败" : "Start File System Failed");  
					break;
					
				case "EVT_ST_EmergentAlert": 
					evtModel = (_lg == "Chinese" ? "紧急报警" : "Emergent Alert");
					break;
				case "EVT_ST_UnusableTimeAlert": 
					evtModel = (_lg == "Chinese" ? "不可用时间报警" : "Unusable Time Alert");
					break;
				case "EVT_ST_OverSpeed":  
					evtModel = (_lg == "Chinese" ? "超速报警" : "Over Speed"); 
					
					evtDesc = "设备：" + lastEvtMsg.eventSrc.ResName + "；速度：当前" + lastEvtMsg.eventDes.CurrentSpeed + "km/h，最高" + lastEvtMsg.eventDes.UpperSpeed + "km/h；限速类型：" + lastEvtMsg.eventDes.LimitSpeedType + "；区域名称：" + lastEvtMsg.eventDes.RegionName;
					break;
				case "EVT_ST_ArriveStation": 
					evtModel = (_lg == "Chinese" ? "公交进站" : "Bus Arrive Station");
					
					evtDesc = "设备：" + lastEvtMsg.eventSrc.ResName + "；行进方向：" + lastEvtMsg.eventDes.UpOrDown + ";站点名称：" + lastEvtMsg.eventDes.StationName; 
					break;
				case "EVT_ST_DepartStation": 
					evtModel = (_lg == "Chinese" ? "公交出站" : "Bus Depart Station");
					
					evtDesc = "设备：" + lastEvtMsg.eventSrc.ResName + "；行进方向：" + lastEvtMsg.eventDes.UpOrDown + ";站点名称：" + lastEvtMsg.eventDes.StationName; 
					break;
				case "EVT_ST_StationLinger": 
					evtModel = (_lg == "Chinese" ? "公交赖站" : "Bus Station Linger");
					
					evtDesc = "设备：" + lastEvtMsg.eventSrc.PUName; 
					break;
				case "EVT_ST_CustomManualNotify": 
					evtModel = (_lg == "Chinese" ? "自定义手动通知" : "Custom Manual Notify");
					break;
					
				case "EVT_IV_ChannelChanged": 
					evtModel = (_lg == "Chinese" ? "视频通道改变" : "Video Channel Changed");
					break;
				case "EVT_IV_MotionDetected":
					evtModel = (_lg == "Chinese" ? "视频侦测到移动" : "Video Motion Detected"); 
					
					evtDesc = "设备：" + lastEvtMsg.eventDes.PUName;
					break;
				case "EVT_IV_SignalLost":
					evtModel = (_lg == "Chinese" ? "视频信号丢失" : "Video Signal Lost");  
					
					evtDesc = "设备：" + lastEvtMsg.eventDes.PUName;
					break;
				case "EVT_IV_SignalResumed":
					evtModel = (_lg == "Chinese" ? "视频信号恢复" : "Video Signal Resumed");  
					
					evtDesc = "设备：" + lastEvtMsg.eventDes.PUName;
					break;
					
				case "EVT_OV_VideoBindedOffline":
					evtModel = (_lg == "Chinese" ? "绑定的视频不在线" : "Video Binded Offline");
					break;
				case "EVT_OV_VideoBindedChanged": 
					evtModel = (_lg == "Chinese" ? "绑定的视频发生改变" : "Video Binded Changed");
					break; 
					
				case "EVT_IDL_AlertIn":
					evtModel = (_lg == "Chinese" ? "发生报警" : "AlertIn fire");
					break;
				case "EVT_IDL_CountChanged": 
					evtModel = (_lg == "Chinese" ? "报警输入数量改变" : "AlertIn Count Changed");
					
					evtDesc = "设备：" + lastEvtMsg.eventDes.PUName + "；描述：报警输入数量改变";
					break;
					
				case "EVT_ODL_StatusChanged": 
					evtModel = (_lg == "Chinese" ? "报警输出状态改变" : "AlertOut Status Changed"); 
					
					var cntDes = "";
					switch(lastEvtMsg.eventDes.Connect)
					{
						case "1": cntDes = "报警输出接通"; break;
						case "0": cntDes = "报警输出断开"; break;
						case "2": cntDes = "报警输出闪烁"; break;
						default: break;
					}
					
					evtDesc = "设备：" + lastEvtMsg.eventDes.PUName + "；描述：" + cntDes; 
					break;
					
				case "EVT_GPS_LowSpeed": 
					evtModel = (_lg == "Chinese" ? "低速报警" : "Low Speed");
					break;
				case "EVT_GPS_InERailAlarm":  
					evtModel = (_lg == "Chinese" ? "进入限定区域报警" : "In Limit Region Alarm"); 
					
					evtDesc = "设备：" + lastEvtMsg.eventDes.PUName + "；描述：目标进入了“" +  + "”限制区域"; 
					break;
				case "EVT_GPS_OutERailAlarm": 
					evtModel = (_lg == "Chinese" ? "离开限定区域报警" : "Out Limit Region Alarm");
					
					evtDesc = "设备：" + lastEvtMsg.eventDes.PUName + "；描述：目标离开了“" + lastEvtMsg.eventDes.RegionName + "”限制区域"; 
					break; 
				case "EVT_GPS_LineDepart": 
					evtModel = (_lg == "Chinese" ? "线路偏离报警" : "Line Depart Alarm"); 
					
					evtDesc = "设备：" + lastEvtMsg.eventDes.PUName + "；描述：目标偏离了“" + lastEvtMsg.eventDes.LineName + "”限制线路"; 
					break;
					
				default: 
					return false;
					break;
			}
			
			evtTime = Nrcap2.Utility.DateFormat("yyyy-MM-dd HH:mm:ss", new Date(parseInt(lastEvtMsg["time"]) * 1000));
			evtSrc = lastEvtMsg.eventSrc.ResName || "";
			evtAlert = lastEvtMsg["ignoreFlag"] == "0" ? "否" : "是";
			
			transEvtMsg = {time: evtTime, src: evtSrc, modelName:evtModel, desc: evtDesc, alarm: evtAlert};
			
			if(attachEventFlag == true)
			{
				var param = Object.clone(transEvtMsg);
				param.eventId = lastEvtMsg.eventId;  
				param.eventSrc = lastEvtMsg.eventSrc;  
				
				this.AttachEventOperation(param);
			}  
			
			return transEvtMsg; 
			
		},
		
		// 按条清除事件
		Clear: function(){
			if(this.translateMessages.length > (this.eventMaxCount || 500))
			{
				this.translateMessages.splice(0, 1);  
			} 
		
			if(this.originalMessages.length > (this.eventMaxCount || 500))
			{
				this.originalMessages.splice(0, 1);  
			}
			
			// alert(Object.toJSON(WebClient.Event.originalMessages));  
			// alert(Object.toJSON(WebClient.Event.translateMessages));
			
			/* this.eventMessages.each
			(
				function(item)
				{
					var node = item.value;
					var eMsg = node.msg;
					if(eMsg.length > (WebClient.Event.eventMaxCount || 200))
					{
						eMsg.splice(0, 1);  
					}
				}
			); */
			
		},
		 
		// 事件浏览
		Show: function(){
			// alert(Object.toJSON(WebClient.Event.originalMessages));  
			// alert(Object.toJSON(WebClient.Event.translateMessages));
			
			if(!WebClient.Event.eventDialogWindow){
			    WebClient.Event.eventDialogWindow = window.showModelessDialog("eventexplore.html", window,"dialogHeight=381px;dialogWidth=686px;resizable=no;center=yes;status=no;scroll=no;help=no;"); 
				// alert(WebClient.Event.eventDialogWindow.EventExplore.version);
			} 
			// alert(this.eventDialogWindow);
		}, 
		
		// 绑定事件操作
		AttachEventOperation: function(param){
			// alert(Object.toJSON(param));
			var param = param || {};
			switch(param.eventId)
			{
				case "EVT_PU_Online": 
					var puid = param.eventSrc.SrcID;
					var resType = param.eventSrc.ResType; 
					var resIdx = param.eventSrc.ResIdx; 
					var resName = param.eventSrc.ResName; 
					var resDesc = param.eventSrc.ResDesc; 
					
					if(resType != "SELF") return;
					
					var res = WebClient.Resource.resource;
					if(res.get(puid))
					{
						res.get(puid).name = resName;
						res.get(puid).description = resDesc;
						res.get(puid).online = "1";
						res.get(puid).enable = "1";
					}
					else
					{
						return;
					}
					
					var childRes = res.get(puid).childResource;
					
					(["video", "query", "device"]).each
					(
						function(style)
						{
							var DeviceDomID = style + "_" + puid; 
							if($(DeviceDomID))
							{
								$(DeviceDomID).update(resName);
								if($(DeviceDomID + "_img_ico")) 
								$(DeviceDomID + "_img_ico").className = $(DeviceDomID + "_img_ico").className.replace("_disabled", "");
								  
								if(childRes && Object.isArray(childRes))
								{
									childRes.each
									(
										function(child)
										{ 
											if($(DeviceDomID + "_" + child.type + "_" + child.idx + "_img_ico"))
											$(DeviceDomID + "_" + child.type + "_" + child.idx + "_img_ico").className = $(DeviceDomID + "_" + child.type + "_" + child.idx + "_img_ico").className.replace("_disabled", ""); 
										}
									); 
								}
								
							}
							
						}
					);
					
					
					break;
				case "EVT_PU_Offline": 
					var puid = param.eventSrc.SrcID;
					var resType = param.eventSrc.ResType; 
					var resIdx = param.eventSrc.ResIdx; 
					var resName = param.eventSrc.ResName; 
					var resDesc = param.eventSrc.ResDesc; 
					
					if(resType != "SELF") return;
					
					var res = WebClient.Resource.resource;
					if(res.get(puid) && puid)
					{
						res.get(puid).name = resName;
						res.get(puid).description = resDesc;
						res.get(puid).online = "0";
						res.get(puid).enable = "0";
					}
					else
					{
						return;
					}
					
					var childRes = res.get(puid).childResource;
					
					(["video", "query", "device"]).each
					(
						function(style)
						{
							var DeviceDomID = style + "_" + puid; 
							if($(DeviceDomID))
							{
								$(DeviceDomID).update(resName);
								if($(DeviceDomID + "_img_ico"))  
								{ 
									$(DeviceDomID + "_img_ico").className = $(DeviceDomID + "_img_ico").className.replace("_disabled", "");
									$(DeviceDomID + "_img_ico").className += "_disabled";
								}
								
								if(childRes && Object.isArray(childRes))
								{
									childRes.each
									(
										function(child)
										{
											if($(DeviceDomID + "_" + child.type + "_" + child.idx + "_img_ico"))
											{
												$(DeviceDomID + "_" + child.type + "_" + child.idx + "_img_ico").className = $(DeviceDomID + "_" + child.type + "_" + child.idx + "_img_ico").className.replace("_disabled", ""); 
												$(DeviceDomID + "_" + child.type + "_" + child.idx + "_img_ico").className += "_disabled"; 
											} 
										}
									); 
								}
								
							}
							
						}
					);
					
					// 停止视频
					/* Nrcap2.WindowContainers.each
					(
						function(item)
						{
							var node = item.value;
							if(node.window && node.window.status.playvideoing)
							{
								if(node.window.puid == puid)
								{ 
									WebClient.Video.StopVideo(item.key);
								}
								
							}
							
						}
					); */
					
					break;
			}			
			
		},		

		end: true  
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

				WebClient.Content.QueryPad(); //加载queryDownload主内容框架元素部分 
				
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
		
		QueryPad:function(){
			WebClient.Query.Init(); 
		},
		
		Html:function(){
			var htmlstr = "";
				//video pad
				htmlstr += "<div id=\"videoPad\" class=\"contentPad\">";
					
					//video left
					htmlstr += "<div id=\"videoPadLeft\" class=\"videoPadLeft\">";
					    /* 创建云台控制区html元素 */
                        htmlstr += "<div id=\"controlPad\" >";
                            htmlstr += "<div id=\"videoToolbar1\" class=\"toolbar\" >视频控制</div>";
                            htmlstr += "<div id=\"ptzPad\" ></div>";
                        htmlstr += "</div>";
                        
                        /* 创建视频列表控制区html元素 */
                        htmlstr += "<div id=\"videoResourcePad\" >";
                            htmlstr += "<div id=\"videoToolbar2\" class=\"toolbar\" >视频列表</div>";
                            htmlstr += "<div id=\"videoResourceBox\"></div>";
                        htmlstr += "</div>"; 
					htmlstr += "</div>";
					
					//video right
					htmlstr += "<div id=\"videoPadRight\" class=\"videoPadRight\">";
					    /* 实时播放窗口容器区 */
                        htmlstr += "<div id=\"windowPad\" >";
                        htmlstr += "</div>";
                        
                        /* 切换窗口数量控制区 */
                        htmlstr += "<div id=\"changeWindowPad\" class=\"changenumber\" >";
                        htmlstr += "</div>"; 
					htmlstr += "</div>";
					
				htmlstr += "</div>";
				
				//query pad
				htmlstr += "<div id=\"queryPad\" class=\"contentPad\" style=\" display:none;\">"; 
					//query left
					htmlstr += "<div id=\"queryPadLeft\" class=\"queryPadLeft\">";
					   
                        /* 创建视频列表控制区html元素 */
                        htmlstr += "<div id=\"queryResourcePad\" >";
                            htmlstr += "<div id=\"queryToolbar1\" class=\"toolbar\" >录像查询</div>";
                            htmlstr += "<div id=\"queryResourceBox\" ></div>";
                        htmlstr += "</div>"; 
					htmlstr += "</div>";
					
					//query right
					htmlstr += "<div id=\"queryPadRight\" class=\"queryPadRight\">";
						/* 查询详细信息、下载信息区 */
						htmlstr += "<div id=\"queryDetailDownloadPad\">";
							htmlstr += "<div id=\"DetailPad\">";
							htmlstr += "</div>";
							htmlstr += "<div id=\"DownloadPad\">";
							htmlstr += "</div>";
						htmlstr += "</div>";
					   
                        htmlstr += "<div id=\"queryDisplayPad\" >";
							/* 录像播放窗口容器区 */
							htmlstr += "<div id=\"vodWindowPad\" class=\"displayWindow\" >";
                        	htmlstr += "</div>";	
							htmlstr += "<div id=\"imageWindowPad\" class=\"displayWindow\" style=\"display:none;\">";
                        	htmlstr += "</div>";
                        htmlstr += "</div>";
					htmlstr += "</div>";
				
				htmlstr += "</div>"; 
				
				// platform pad
				htmlstr += "<div id=\"platformPad\" class=\"contentPad\" style=\"display:none;\">"; 
					// platform left
					htmlstr += "<div id=\"platformPadLeft\" class=\"platformPadLeft\">";
						htmlstr += "<div id=\"platformResourcePad\">";
							htmlstr += "<div id=\"platformToolbar1\" class=\"toolbar\" >平台信息</div>";
							htmlstr += "<div id=\"platformResourceBox\" ></div>";
						htmlstr += "</div>";
					htmlstr += "</div>";
					
					// platform right
					htmlstr += "<div id=\"platformPadRight\" class=\"platformPadRight\">";
						htmlstr += "<div id=\"platformMainRegion\">";
						 
							// top nav pad
							htmlstr += "<div class=\"platformMgt-title\" ></div>";
							  
							// main pad
							htmlstr += "<div class=\"platformMgt-body\" ></div>";   
						
						htmlstr += "</div>";
					htmlstr += "</div>";
					
				htmlstr += "</div>"; 
				
				// device pad 
				htmlstr += "<div id=\"devicePad\" class=\"contentPad\" style=\"display:none;\">"; 
					// device left
					htmlstr += "<div id=\"devicePadLeft\" class=\"devicePadLeft\">";
						htmlstr += "<div id=\"deviceResourcePad\">";
							htmlstr += "<div id=\"deviceToolbar1\" class=\"toolbar\" >平台信息</div>";
							htmlstr += "<div id=\"deviceResourceBox\" ></div>";
							htmlstr += "<div id=\"deviceToolbar2\" class=\"toolbar\" >资源信息</div>";
							htmlstr += "<div id=\"deviceResInfoBox\" ></div>"; 
						htmlstr += "</div>";
					htmlstr += "</div>";
					
					// device right
					htmlstr += "<div id=\"devicePadRight\" class=\"devicePadRight\">";
						htmlstr += "<div id=\"deviceMainRegion\">";
						
							htmlstr += "<div class=\"device-mgt-box\" >";
								// top nav pad
								htmlstr += "<div class=\"device-nav-pad\" ></div>";
								  
								// main pad
								htmlstr += "<div class=\"device-main-pad\" >";
									htmlstr += "<div class=\"main-body\" ></div>"; 
								htmlstr += "</div>"; 
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
		SliderBars:new Hash(), // 控制拖动条信息. 
		
	    Init:function(){
	        if($("ptzPad"))
	        {
	            var htmlstr = "";
	            htmlstr = WebClient.Control.Html();
	            $("ptzPad").innerHTML = htmlstr;
	            
	            WebClient.Control.AttachPTZEvent(); //绑定PTZ事件
				
				WebClient.Control.CreateVideoParamSliderBar("ptzspeed");
				WebClient.Control.CreateVideoParamSliderBar("brightness");
                WebClient.Control.CreateVideoParamSliderBar("contrast");
                WebClient.Control.CreateVideoParamSliderBar("hue");
                WebClient.Control.CreateVideoParamSliderBar("saturation");
	        }
	    
	    },
	    
	    Html:function(){
	        var htmlstr = "";
	        
	        //video ptz control
	        htmlstr += "<div id=\"ptzBox\" class=\"ptz\">";
	        
	            htmlstr += "<div style=\"float:left;width:112px;border-right:0px red dotted;\">";
	                //up
	                htmlstr += "<div><input type=\"button\" id=\"turnup\" name=\"turnup\" webclienttype=\"ptzcontrol\" disabled title=\"向上\" /></div>";
	                //left/center/right
	                htmlstr += "<div><input type=\"button\" id=\"turnleft\" name=\"turnleft\" webclienttype=\"ptzcontrol\" disabled title=\"向左\"/><input type=\"button\" id=\"turncenter\" name=\"turncenter\" webclienttype=\"ptzcontrol\" disabled /><input type=\"button\" id=\"turnright\" name=\"turnright\" webclienttype=\"ptzcontrol\" disabled title=\"向右\"/></div>";
	                //down
	                htmlstr += "<div><input type=\"button\" id=\"turndown\" name=\"turndown\" webclienttype=\"ptzcontrol\" disabled title=\"向下\" /></div>";
	             htmlstr += "</div>";   
	             
	             htmlstr += "<div style=\"float:left;width:76px;border-right:0px red dotted;\">";
	                //focusfar/focusnear
	                htmlstr += "<div><input type=\"button\" id=\"focusfar\" name=\"focusfar\" webclienttype=\"ptzcontrol\" disabled title=\"拉远焦点\" /><input type=\"button\" id=\"focusnear\" name=\"focusnear\" webclienttype=\"ptzcontrol\" disabled title=\"推近焦点\" /></div>";
	                //zoomin/zoomout  
	                htmlstr += "<div><input type=\"button\" id=\"zoomin\" name=\"zoomin\" webclienttype=\"ptzcontrol\" disabled title=\"放大\" /><input type=\"button\" id=\"zoomout\" name=\"zoomout\" webclienttype=\"ptzcontrol\" disabled title=\"缩小\" /></div>";
	                //aperturem/aperturea
	                htmlstr += "<div><input type=\"button\" id=\"aperturea\" name=\"aperturea\" webclienttype=\"ptzcontrol\" disabled title=\"放大光圈\" /><input type=\"button\" id=\"aperturem\" name=\"aperturem\" webclienttype=\"ptzcontrol\" disabled title=\"缩小光圈\" /></div>";
	            htmlstr += "</div>";
	            
	        htmlstr += "</div>"; 
				
	        //video params
	        htmlstr += "<div id=\"paramBox\" class=\"param\" style=\"display:block;\">";
			
				htmlstr += "<div >";
					htmlstr += "<table><tr>";
						htmlstr += "<td width=\"55px\" align=\"center\">";
							htmlstr +="<div class=\"slider-title\" id=\"ptzspeed-slider-title\">云台速度</div>"; 
						htmlstr += "</td>";
						htmlstr += "<td>";
							htmlstr += "<div class=\"slider\" id=\"ptzspeed-slider\" tabIndex=\"1\" style=\"background:Transparent;\"><div class=\"slider-input\" id=\"ptzspeed-slider-input\" ></div></div>";
							htmlstr += "</td>";
						htmlstr += "<td>";
							htmlstr += "<input id=\"ptzspeed-input\" maxlength=\"3\"  tabIndex=\"2\" style=\"width:24px;height:14px;background-color:#FFFFFF;border:1px #b0b0b0 solid;\" />"; 
						htmlstr += "</td>"; 
					htmlstr += "</tr></table>";
				htmlstr += "</div>"; 
			
				/* 视频参数控制 */ 
				htmlstr += "<div >";
					htmlstr += "<table><tr>";
						htmlstr += "<td width=\"55px\" align=\"center\">";
							htmlstr +="<div class=\"slider-title\" id=\"brightness-slider-title\">亮&nbsp;&nbsp;度</div>"; 
						htmlstr += "</td>";
						htmlstr += "<td>";
							htmlstr += "<div class=\"slider\" id=\"brightness-slider\" tabIndex=\"1\" style=\"background:Transparent;\"><div class=\"slider-input\" id=\"brightness-slider-input\" ></div></div>";
							htmlstr += "</td>";
						htmlstr += "<td>";
							htmlstr += "<input id=\"brightness-input\" maxlength=\"3\" tabIndex=\"2\" style=\"width:24px;height:14px;background-color:#FFFFFF;border:1px #b0b0b0 solid;\" />"; 
						htmlstr += "</td>"; 
					htmlstr += "</tr></table>";
				htmlstr += "</div>";
				
				htmlstr += "<div >";
					htmlstr += "<table><tr>";
						htmlstr += "<td width=\"55px\" align=\"center\">";
							htmlstr +="<div class=\"slider-title\" id=\"contrast-slider-title\">对比度</div>"; 
						htmlstr += "</td>";
						htmlstr += "<td>";
							htmlstr += "<div class=\"slider\" id=\"contrast-slider\" tabIndex=\"1\" style=\"background:Transparent;\"><div class=\"slider-input\" id=\"contrast-slider-input\" ></div></div>";
							htmlstr += "</td>";
						htmlstr += "<td>";
							htmlstr += "<input id=\"contrast-input\" maxlength=\"3\" tabIndex=\"2\" style=\"width:24px;height:14px;background-color:#FFFFFF;border:1px #b0b0b0 solid;\" />"; 
						htmlstr += "</td>"; 
					htmlstr += "</tr></table>";
				htmlstr += "</div>";
				
				htmlstr += "<div >";
					htmlstr += "<table><tr>";
						htmlstr += "<td width=\"55px\" align=\"center\">";
							htmlstr +="<div class=\"slider-title\" id=\"hue-slider-title\">色&nbsp;&nbsp;调</div>"; 
						htmlstr += "</td>";
						htmlstr += "<td>";
							htmlstr += "<div class=\"slider\" id=\"hue-slider\" tabIndex=\"1\" style=\"background:Transparent;\"><div class=\"slider-input\" id=\"hue-slider-input\" ></div></div>";
							htmlstr += "</td>";
						htmlstr += "<td>";
							htmlstr += "<input id=\"hue-input\" maxlength=\"3\" style=\"width:24px;height:14px;background-color:#FFFFFF;border:1px #b0b0b0 solid;\" />"; 
						htmlstr += "</td>"; 
					htmlstr += "</tr></table>";
				htmlstr += "</div>";
				
				htmlstr += "<div >";
					htmlstr += "<table><tr>";
						htmlstr += "<td width=\"55px\" align=\"center\">";
							htmlstr +="<div class=\"slider-title\" id=\"saturation-slider-title\">饱和度</div>"; 
						htmlstr += "</td>";
						htmlstr += "<td>";
							htmlstr += "<div class=\"slider\" id=\"saturation-slider\" tabIndex=\"1\" style=\"background:Transparent;\"><div class=\"slider-input\" id=\"saturation-slider-input\" ></div></div>";
							htmlstr += "</td>";
						htmlstr += "<td>";
							htmlstr += "<input id=\"saturation-input\" maxlength=\"3\" tabIndex=\"2\" style=\"width:24px;height:14px;background-color:#FFFFFF;border:1px #b0b0b0 solid;\" />"; 
						htmlstr += "</td>"; 
					htmlstr += "</tr></table>";
				htmlstr += "</div>";
	        
	        htmlstr += "</div>";
	        
	        return htmlstr;
	    },
	    
		/*
		*	函数名		：AttachPTZEvent
		*	函数功能   	：绑定云台控制事件 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.02.21	
		*/
	    AttachPTZEvent:function(){
	        if($("ptzBox"))
	        {
	            var ptzbtns = $("ptzBox").getElementsByTagName("INPUT");
	            for(var i = 0;i < ptzbtns.length;i++)
	            {
	                var ptzbtn = ptzbtns[i];
	                if(ptzbtn.type == "button" && ptzbtn.webclienttype == "ptzcontrol")
	                {
	                    if(ptzbtn.disabled)
	                    {
	                       	ptzbtn.style.backgroundImage = "url(images/blue/ptz_yellow_4.png)";                    
	                    }
	                    else
	                    {
	                        ptzbtn.style.backgroundImage = "url(images/blue/ptz_yellow_1.png)"; 
	                    }
						ptzbtn.onfocus = function(){
							this.blur();
						};
						ptzbtn.onmouseover = function(){
							this.style.backgroundImage = "url(images/blue/ptz_yellow_2.png)";
						};
						ptzbtn.onmouseout = function(){
							this.style.backgroundImage = "url(images/blue/ptz_yellow_1.png)";
							WebClient.Control.PTZControl(this.id,Nrcap2.Enum.PTZControl["stop"]);
						};
						ptzbtn.onmousedown = function(){
							this.style.backgroundImage = "url(images/blue/ptz_yellow_3.png)";
							WebClient.Control.PTZControl(this.id,Nrcap2.Enum.PTZControl["start"]);
						};
						ptzbtn.onmouseup = function(){
							this.style.backgroundImage = "url(images/blue/ptz_yellow_2.png)";
							WebClient.Control.PTZControl(this.id,Nrcap2.Enum.PTZControl["stop"]);
						};
						ptzbtn.onclick = function(){};  
						
					}
	            }	         
	        }
	    },
	    
		/*
		*	函数名		：PTZDisabled
		*	函数功能   	：设置云台控制页面元素状态  
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.02.21	
		*/
		PTZDisabled:function(disabled){
			var ptzbtns = $("ptzBox").getElementsByTagName("INPUT");
			for(var i = 0;i < ptzbtns.length;i++)
			{
				var ptzbtn = ptzbtns[i];
				if(ptzbtn.type == "button" && ptzbtn.webclienttype == "ptzcontrol")
				{
					ptzbtn.disabled = disabled;
					ptzbtn.style.backgroundImage = (disabled ? "url(images/blue/ptz_yellow_4.png)" : "url(images/blue/ptz_yellow_1.png)");
				} 
			} 
		},
		
		/*
		*	函数名		：PTZControl
		*	函数功能   	：云台控制 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.02.21	
		*/
	    PTZControl:function(direction,control)
	    {
	        if(typeof control == "undefined" || typeof direction == "undefined")
	        {
	            return;
	        }
	        
	        var objWnd = null;
	        Nrcap2.WindowContainers.each(
	            function(item){
	                if(item.value.active && item.value.type == Nrcap2.Enum.NrcapStreamType['st_video'])
	                {
	                    objWnd = item.value.window;
	                }	            
	            }	        
	        );
	        
	        if(!objWnd)
	        {
	            return;
	        }
	        
	        if(objWnd.status.playvideoing)
	        {
	            direction = direction.toLowerCase();
    	        
    	        if(control == Nrcap2.Enum.PTZControl["stop"])
    	        {
	                switch(direction)
	                {
        	            case "turnleft":
					    case "turnright":
					    case "turnup":
					    case "turndown":
					    case "stopturn":
						    direction = "stopturn";
				    	    break;
    						
					    case "aperturea":
					    case "aperturem":
				        case "stopaperture":
						    direction = "stopaperture";
				    	    break;
    					
					    case "focusfar":
					    case "focusnear": 
					    case "stopfocus":
						    direction = "stopfocus";
				    	    break;
    					
					    case "zoomin":
					    case "zoomout":
					    case "stopzoom":
					 	    direction = "stopzoom";
				    	    break;
					    default:
						    direction = "";
						    break; 
	                }  
	            }  
				 
				direction = Nrcap2.Enum.PTZDirection[direction]; //转化成实际命令字符串
				 
				if(!direction) return;
				 
				Nrcap2.PTZ.Control(WebClient.connectId,objWnd.params.puid,objWnd.params.idx,direction); //get control 
				
				var ptzctlstr = "发送"+control +",命令" + direction; 
				
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.PTZ.PTZControl",msg:ptzctlstr});
				
				window.status = ptzctlstr; //浏览器状态栏显示控制命令 
    	       
	        }  
	    },
		
		/*
		*	函数名		：VideoParamDisabled
		*	函数功能   	：设置视频参数控制条状态 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.03.28	
		*/
		VideoParamDisabled:function(disabled,objWnd){
			var status = disabled ? false : true;
			var puid = null, idx = 0;
			if(status)
			{
				if(!objWnd) return false;
				if(objWnd.status.playvideoing)
				{
					puid = objWnd.params.puid;  
					idx = objWnd.params.idx;
				}
				//alert(puid + ":" + idx);
			}
			
			//Nrcap2.Connections.get(WebClient.connectId).nc.EnableDebug(1);
			
			WebClient.Control.SliderBars.get("ptzspeed").SetStatus(status,puid,idx);
			WebClient.Control.SliderBars.get("brightness").SetStatus(status,puid,idx);
			WebClient.Control.SliderBars.get("contrast").SetStatus(status,puid,idx);
			WebClient.Control.SliderBars.get("hue").SetStatus(status,puid,idx);
			WebClient.Control.SliderBars.get("saturation").SetStatus(status,puid,idx); 			
		},
	    
		/*
		*	函数名		：CreateVideoParamSliderBar
		*	函数功能   	：创建视频参数控制条 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.03.28	
		*/
		CreateVideoParamSliderBar:function(sliderName){
			if(!sliderName || !$(sliderName + "-slider")) return false;
			
			var configId = "",type = "";
			switch(sliderName)
			{
				case "ptzspeed": configId = Nrcap2.Enum.ConfigID["CFG_PTZ_Speed"]; type = "ptz";  
					break;
				case "brightness": configId = Nrcap2.Enum.ConfigID["CFG_IV_Brightness"]; 
					break;
				case "contrast": configId = Nrcap2.Enum.ConfigID["CFG_IV_Contrast"];
					break;
				case "hue": configId = Nrcap2.Enum.ConfigID["CFG_IV_Hue"]; 
					break;
				case "saturation": configId = Nrcap2.Enum.ConfigID["CFG_IV_Saturation"]; 
					break;
				default:
					break;
			}
								
			WebClient.Control.SliderBars.set(
				sliderName,
				{
					title:null,
					bar:null,
					puid:null, 
					idx:0,
					input:null,
					originalValue:0,
					SetStatus:function(status,puid,idx){
						this.bar.setStatus(status);
						if(!status)
						{
							this.title.style.color = "#A0A0A0";
							this.input.disabled = true;
							this.originalValue = 0;
							this.bar.setValue(this.originalValue);
							this.input.value = this.originalValue;
							this.puid = null;
							this.idx = 0;
						}
						else
						{
							if(!puid || typeof idx == "undefined")
							{
								return false;	
							}
							this.puid = puid; 
							this.idx = idx; 
							this.title.style.color = "#000000";
							this.input.disabled = false;
							
							if(WebClient.connectId)
							{   
								if(configId && configId != "")
								{
									/* 获取值 */
									//alert(WebClient.connectId + ":" + this.puid + ":" + this.idx + ":" + configId);
									var rv = -1; 
									if(type == "ptz")
									{
										rv = Nrcap2.PTZ.GetSpeed(WebClient.connectId,this.puid,this.idx,configId);
										 
										//var rvstr = Nrcap2.Connections.get(WebClient.connectId).nc.GetConfig(151,"151000002869243996",Nrcap2.Enum.PuResourceType.PTZ,0,"",configId); 
									}
									else
									{
										rv = Nrcap2.CaptureParam.VideoInParamControl(WebClient.connectId,this.puid,this.idx,configId,"get");
									} 
									 
									if(parseInt(rv) >= 0 && parseInt(rv) <= 100)
									{
										this.originalValue = rv;  
									}
									else
									{
										this.originalValue = 0;  
									}
									// alert(this.originalValue);
									this.bar.setValue(this.originalValue); 
									this.input.value = this.originalValue;
									
								}
															
							}
							
						}
						
					}, // end SetStatus
					callbacks:{
						mouseup:function(){
							var SliderBar = WebClient.Control.SliderBars.get(sliderName);
							if(SliderBar.originalValue != SliderBar.bar.getValue())
							{ 
								if(configId && configId != "")
								{ 
									/* 设置值 */
									var rv = -1;   
									if(type == "ptz")
									{
										rv = Nrcap2.PTZ.SetSpeed(WebClient.connectId,SliderBar.puid,SliderBar.idx,configId,SliderBar.bar.getValue()); 
										//alert("ptz" + rv);
									}
									else
									{
										rv = Nrcap2.CaptureParam.VideoInParamControl(WebClient.connectId,SliderBar.puid,SliderBar.idx,configId,"set",SliderBar.bar.getValue()); 
									} 
									
									if(rv == Nrcap2.NrcapError.NRCAP_SUCCESS)
									{   
										SliderBar.originalValue = SliderBar.bar.getValue();   
										SliderBar.input.value = SliderBar.originalValue; 
									}
									else
									{
										SliderBar.bar.setValue(SliderBar.originalValue);
									}
									
								}
								
							}
						},
						
						blur:function(){
							var SliderBar = WebClient.Control.SliderBars.get(sliderName);
							if(SliderBar.originalValue != SliderBar.bar.getValue())
							{ 
								if(configId && configId != "")
								{ 
									/* 设置值 */
									var rv = -1;  
									if(type == "ptz")
									{
										rv = Nrcap2.PTZ.SetSpeed(WebClient.connectId,SliderBar.puid,SliderBar.idx,configId,SliderBar.bar.getValue()); 
									}
									else
									{
										rv = Nrcap2.CaptureParam.VideoInParamControl(WebClient.connectId,SliderBar.puid,SliderBar.idx,configId,"set",SliderBar.bar.getValue()); 
									} 
									
									if(rv == Nrcap2.NrcapError.NRCAP_SUCCESS)
									{ 
										SliderBar.originalValue = SliderBar.bar.getValue();   
										SliderBar.input.value = SliderBar.originalValue; 
									}
									else
									{
										SliderBar.bar.setValue(SliderBar.originalValue);
									}
									
								}
							
							}
							
						},
						
						end:true						
					},
					
					end:true
				}
			); // end SliderBars			
			
			var SliderBar = this.SliderBars.get(sliderName);
			
			SliderBar.bar = new Slider($(sliderName+"-slider"),$(sliderName+"-slider-input"),null,SliderBar.callbacks);
			
			SliderBar.bar.setMaximum(100);
			
			SliderBar.title = $(sliderName+"-slider-title");
			
			SliderBar.input = $(sliderName+"-input");
			
			SliderBar.input.onchange = function(){ 
				SliderBar.bar.setValue(parseInt(this.value));  
			   	SliderBar.callbacks.mouseup();
			}; 
			
			SliderBar.SetStatus(false);
		},
		
	    end:true
	},
	
	Video:{
		curChangeWndFlag:false,
	    curWindowNumber:0,
	    curActiveWindowKey:"", 
		
	    Init:function(){
			WebClient.Video.curWindowNumber = 0;
			
	        if($("windowPad") && $("changeWindowPad"))
	        {
	            var htmlstr = "";
	            htmlstr = WebClient.Video.Html();
	            $("changeWindowPad").innerHTML = htmlstr;  
		
	            WebClient.Video.ChangeWindow(4);//初始化4窗口
	            
	            WebClient.Video.AttachChangeNumberEvent(); //绑定窗口切换事件
	        }
	    },
	    
	    Html:function(){
	        var htmlstr = "";
	        
	        htmlstr += "<div class=\"windownumber\" style=\"height:12px;\"></div>";
	        
	        htmlstr += "<div class=\"windownumber\"><input type=\"button\" id=\"windownumber1\" name=\"windownumber1\" title=\"1\" webclienttype=\"changenumber\" /></div>";
            htmlstr += "<div class=\"windownumber\"><input type=\"button\" id=\"windownumber4\" name=\"windownumber4\" title=\"4\"  webclienttype=\"changenumber\" /></div>";
            htmlstr += "<div class=\"windownumber\"><input type=\"button\" id=\"windownumber9\" name=\"windownumber9\" title=\"9\"  webclienttype=\"changenumber\" /></div>";
            htmlstr += "<div class=\"windownumber\"><input type=\"button\" id=\"windownumber16\" name=\"windownumber16\" title=\"16\"  webclienttype=\"changenumber\" /></div>";
            htmlstr += "<div class=\"windownumber\"><input type=\"button\" id=\"windownumber13\" name=\"windownumber13\" title=\"13\"  webclienttype=\"changenumber\" /></div>";
            htmlstr += "<div class=\"windownumber\"><input type=\"button\" id=\"windownumber6\" name=\"windownumber6\" title=\"6\"  webclienttype=\"changenumber\" /></div>";
	        htmlstr += "<div class=\"windownumber\"><input type=\"button\" id=\"windownumber8\" name=\"windownumber8\" title=\"8\"  webclienttype=\"changenumber\" /></div>";
            htmlstr += "<div class=\"windownumber\"><input type=\"button\" id=\"windownumber10\" name=\"windownumber10\" title=\"10\"  webclienttype=\"changenumber\" /></div>";
            htmlstr += "<div class=\"windownumber\"><input type=\"button\" id=\"windownumber12\" name=\"windownumber12\" title=\"12\"  webclienttype=\"changenumber\" /></div>";
	        
	        return htmlstr;
	    },
	    
	    AttachChangeNumberEvent:function(){
			var route = Global.route; 
	    
			var changeNumberBtns = $("changeWindowPad").getElementsByTagName("INPUT");
	        for(var i = 0;i < changeNumberBtns.length;i++)
	        {
	            var changewnd = changeNumberBtns[i];
	            changewnd.style.backgroundImage = "url(images/"+route+"/wndnumber_1.bmp)";
				changewnd.onmouseover = function(){
					this.style.backgroundImage = "url(images/"+route+"/wndnumber_2.bmp)";	
				}
				changewnd.onmouseout = function(){
					this.style.backgroundImage = "url(images/"+route+"/wndnumber_1.bmp)";	
				}
				changewnd.onmousedown = function(){
					this.style.backgroundImage = "url(images/"+route+"/wndnumber_3.bmp)";	
				}
				changewnd.onmouseup = function(){
					this.style.backgroundImage = "url(images/"+route+"/wndnumber_2.bmp)";	
				}
	            changewnd.onclick = function(){       
	                //alert("the button id is:" +this.id);
	                WebClient.Video.ChangeWindow(this.id.replace("windownumber","")); 
	            }
	            changewnd.onfocus = function(){
	                this.blur();      
	            }
	        }
			
	    },
	    
		/* 初始化窗口 */
	    InitWindowContainers:function(){
			Nrcap2.WindowContainers.each
			(
				function(item)
				{
					if(item.value.type == Nrcap2.Enum.NrcapStreamType['st_video'])
					{
						Nrcap2.DiscardWindow(item.key);
					}
				}
			);
			 
	        var wndBoxs = $("windowPad").getElementsByTagName("DIV");
			for(var i = 0;i < wndBoxs.length;i++)
	        {
	            var wndBox = wndBoxs[i];
	            if(wndBox && wndBox.id.search("windowbox") != -1)
	            {	             
	                wndBox.onclick = function(){        
	                    WebClient.Video.ActiveWindow(this.id);//激活窗口  
	                }  
	                
	                Nrcap2.WindowContainers.set(wndBox.id, new Nrcap2.Struct.WindowContainerStruct(wndBox, Nrcap2.Enum.NrcapStreamType['st_video']));
	            } 
	        }
			
			// alert(Object.toJSON(Nrcap2.WindowContainers));
			return Nrcap2.NrcapError.NRCAP_SUCCESS;
			 
	    },
	    
		/* 激活窗口 */
	    ActiveWindow:function(windowKey){
	        try
	        {
				var defaultcolor = Global.defaultTitleBgColor;
				var activecolor = Global.activeTitleBgColor; 
				
	            Nrcap2.WindowContainers.each(
	                function(item){
	                    var node = item.value;
						if(node.type == Nrcap2.Enum.NrcapStreamType['st_video'])
						{ 
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
						} // end-type
	                   
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
			Nrcap2.WindowContainers.each(
				function(item){
					var node = item.value;
					if(node.type == Nrcap2.Enum.NrcapStreamType['st_video'])
					{
						if(node.window && node.window.status.playvideoing)
						{
							// 旧窗口视频播放数大于当前要切换的窗口数 
							if((oldPlayCount+1) > wndnumber)
							{
								if(!confirmFlag)
								{
									confirmFlag = true;
									if(!confirm("部分视频将会断开，是否继续切换?"))
									{
										stopChange = true;
										return;
									}  
								} 
								
								if(!stopChange)
								{
									WebClient.Video.curChangeWndFlag = true; 
									//关闭部分视频
									WebClient.Video.StopVideo(item.key);
								}
								 
							}
							else
							{ 	
								//count可作为窗口序列索引 
								//采用hash结构存储播放信息，key值用puid与count号结合区分，可保idx不重复 
								oldPlayInfo.set(node.window.puid + "_" + oldPlayCount,{count:oldPlayCount++,window:node.window, description: node.description}); 
							}
							
						}
					} // end-type
				}
			); 
	         
			if(stopChange)
			{
				return;
			}
			else
			{  
				WebClient.Video.curChangeWndFlag = true; 
				Nrcap2.WindowContainers.each(
					function(item){
						var node = item.value;
						if(node.type == Nrcap2.Enum.NrcapStreamType['st_video'])
						{
							WebClient.Video.DestoryWindow(item.key); 
						}												 
					}
				);
				
				//alert(Object.toJSON(oldPlayInfo));
			} 
			 
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
            	case 13:
            	    for(var i= 1 ;i <= 13;i++)
            	    {
            	        if(i == 1 || i == 10){
            	            htmlstr += "<div class=\"window13boxTitle\">";
            	            
            	                for(var j = i ;j <= (i == 1 ? 4 : 13);j++)
            	                {
            	                     htmlstr += "<div id=\"windowbox"+j+"\" class=\"window16box\">";
                                        htmlstr += "<div id=\"window"+j+"\" class=\"window\">";                                
                                        htmlstr += "</div>";
                                        htmlstr += "<div id=\"windowtitle"+j+"\" class=\"windowtitle\"><div class=\"title1\" >无视频</div><div class=\"title2\"></div></div>";
                                    htmlstr += "</div>"; 
            	                
            	                }            	               
                                
                            htmlstr += "</div>"; 
                            
                            i += 3;
                        }
                        else if(i == 5 || i == 8){
                            htmlstr += "<div class=\"window13boxMiddle\">";
                            
                                for(var j = i ;j <= (i == 5 ? 6 : 9);j++)
            	                {
                                    htmlstr += "<div id=\"windowbox"+j+"\" class=\"window16box\" >";
                                        htmlstr += "<div id=\"window"+j+"\" class=\"window\">";                                
                                        htmlstr += "</div>";
                                        htmlstr += "<div id=\"windowtitle"+j+"\" class=\"windowtitle\"><div class=\"title1\" >无视频</div><div class=\"title2\"></div></div>";
                                    htmlstr += "</div>";
                                } 
                                 
                             htmlstr += "</div>";    
                        }
                        else if(i == 7)
                        {
                            htmlstr += "<div id=\"windowbox"+i+"\" class=\"window4box\" style=\" margin:0px 0px 0px 3px !important; margin:0px 0px 0px 0px;\">";
                                htmlstr += "<div id=\"window"+i+"\" class=\"window\" >";                                
                                htmlstr += "</div>";
                                htmlstr += "<div id=\"windowtitle"+i+"\" class=\"windowtitle\" ><div class=\"title1\" >无视频</div><div class=\"title2\"></div></div>";
                            htmlstr += "</div>";
                        }
            	    }
            	    break;
            	case 6:
                    for(var i= 0,j = 1;i < 9;i++,j++)
                    {
                        if ((i+1) < 3 && ((i+1)%3) !=0) {
                            htmlstr += "<div id=\"windowbox"+j+"\" class=\"window6box\">";
                                htmlstr += "<div id=\"window"+j+"\" class=\"window\"></div>";
                                htmlstr += "<div id=\"windowtitle"+j+"\" class=\"windowtitle\"><div class=\"title1\" >无视频</div><div class=\"title2\"></div></div>";
                            htmlstr += "</div>";
                            i+= 3;
                        }
                        else
                        {
                            htmlstr += "<div id=\"windowbox"+j+"\" class=\"window9box\">";
                                htmlstr += "<div id=\"window"+j+"\" class=\"window\"></div>";
                                htmlstr += "<div id=\"windowtitle"+j+"\" class=\"windowtitle\"><div class=\"title1\" >无视频</div><div class=\"title2\"></div></div>";
                            htmlstr += "</div>";
                        }
                    }
            	    break;
            	case 8:
                    for(var i= 0,j= 1 ;i < 16;i++,j++)
                    {
                        if ((i+1) < 4 && ((i+1)%4) !=0) {
                            htmlstr += "<div id=\"windowbox"+j+"\" class=\"window8box\">";
                                htmlstr += "<div id=\"window"+j+"\" class=\"window\"></div>";
                                htmlstr += "<div id=\"windowtitle"+j+"\" class=\"windowtitle\"><div class=\"title1\" >无视频</div><div class=\"title2\"></div></div>";
                            htmlstr += "</div>";
                            i+= 8;
                        }
                        else
                        {
                            htmlstr += "<div id=\"windowbox"+j+"\" class=\"window16box\">";
                                htmlstr += "<div id=\"window"+j+"\" class=\"window\"></div>";
                                htmlstr += "<div id=\"windowtitle"+j+"\" class=\"windowtitle\"><div class=\"title1\" >无视频</div><div class=\"title2\"></div></div>";
                            htmlstr += "</div>";
                        }
                    }
            	    break;
            	case 10:                        
                    for(var i= 0,j = 1;i < 25;i++)
                    {
                        if ((i+1) < 5 && ((i+1)%5) !=0) {
                            htmlstr += "<div id=\"windowbox"+j+"\" class=\"window10box\">";
                                htmlstr += "<div id=\"window"+j+"\" class=\"window\"></div>";
                                htmlstr += "<div id=\"windowtitle"+j+"\" class=\"windowtitle\"><div class=\"title1\" >无视频</div><div class=\"title2\"></div></div>";
                            htmlstr += "</div>";
                            i+= 15;
                            j++;
                        }
                        else
                        {
                            htmlstr += "<div id=\"windowbox"+j+"\" class=\"window25box\">";
                                htmlstr += "<div id=\"window"+j+"\" class=\"window\"></div>";
                                htmlstr += "<div id=\"windowtitle"+j+"\" class=\"windowtitle\"><div class=\"title1\" >无视频</div><div class=\"title2\"></div></div>";
                            htmlstr += "</div>";
                            j++;
                        }
                    }                        
            	    break;
            	case 12:
                    for(var i= 0,j = 1 ;i < 36;i++)
                    {
                        if ((i+1) < 6 && ((i+1)%6) !=0) {
                            htmlstr += "<div id=\"windowbox"+j+"\" class=\"window12box\">";
                                htmlstr += "<div id=\"window"+j+"\" class=\"window\"></div>";
                                htmlstr += "<div id=\"windowtitle"+j+"\" class=\"windowtitle\"><div class=\"title1\" >无视频</div><div class=\"title2\"></div></div>";
                            htmlstr += "</div>";
                            i+= 24;
                            j++;
                        }
                        else
                        {
                            htmlstr += "<div id=\"windowbox"+j+"\" class=\"window36box\">";
                                htmlstr += "<div id=\"window"+j+"\" class=\"window\"></div>";
                                htmlstr += "<div id=\"windowtitle"+j+"\" class=\"windowtitle\"><div class=\"title1\" >无视频</div><div class=\"title2\"></div></div>";
                            htmlstr += "</div>";
                            j++;
                        }
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
			// window.setTimeout(function(){
			 
				var wndKeys = new Array();
				Nrcap2.WindowContainers.each(
					function(item){ 
						if(item.value.type == Nrcap2.Enum.NrcapStreamType['st_video'])
						{
							wndKeys.push(item.key); 
						} 
					}
				);
				 
				// 恢复以前在播放的视频 
				oldPlayInfo.each
				(
					function(olds)
					{
						var old = olds.value;
						 
						var curWndKey = wndKeys[old.count];
						var node = Nrcap2.WindowContainers.get(curWndKey);
						node.window = old.window;
						node.description = old.description; 
						// alert(Object.toJSON(node.window)); 
						
						var oldWndKey = old.window.containerId.replace("window", "windowbox"); 
						
						// 恢复播放
						WebClient.Video.RestorePlayVideo(curWndKey, node.window);
						// alert(Object.toJSON(node.window)); 
						
 						{
							// alert(oldWndKey + "_" + curWndKey);
 							// 更新喊话或对讲信息
							WebClient.Video.UpdateOAChannelWindowKey(node.window.params.puid, oldWndKey, curWndKey);
						}	
					}
				);
				// alert(Object.toJSON(Nrcap2.WindowContainers));
				
				WebClient.Video.curChangeWndFlag = false; 
				WebClient.Video.ActiveWindow(wndKeys[0]); //激活首个窗口 
			// }, 10);
				
				///多窗口全屏显示/ 
				if(WebClient.DealManage.AllFullScreen.flag == 'start')
				WebClient.DealManage.AllFullScreen.Start();
	    },
		
		// 注销窗口
		DestoryWindow: function(windowKey){
			try
			{
				// alert(windowKey);
				if(windowKey && $(windowKey));
			}
			catch(e)
			{
				return false;
			}
			
			Nrcap2.WindowContainers.each(
				function(item){
					//alert("4035**********item.key:"+item.key +"    item:"+item);
					var node = item.value;
					if(node.type == Nrcap2.Enum.NrcapStreamType['st_video'])
					{
						if(item.key == windowKey && node.window && node.window.wnd)
						{ 
							var flag = 1; // 1（保留），0、undefined等（停止）相关操作
							// 继续切换则要销毁窗口插件 
							Nrcap2.DestoryWindow(WebClient.connectId, node.window, flag); 
							
							WebClient.Video.SetWindowTitle(item.key); // 设置窗口状态条
							if(!WebClient.Video.curChangeWndFlag)
							{
								WebClient.Video.SetStatus(item.key); // 设置导航、云台等状态 
							} 
							Utility.Clock.EventCallback.UnSet("sense_" + item.key); 
							
						}
					}
						
				}
			);
			
		}, 
		// {###}		
		// 恢复新窗口并播放
	    RestorePlayVideo: function(windowKey, objWnd){
			try
			{
				if(windowKey && objWnd && objWnd.nm);
			}
			catch(e)
			{
				return false;
			}
			
			// 因为需要重新创建窗口插件实例，故应该再次绑定窗口事件

  			{
				var windowEvent = new Nrcap2.Struct.WindowEventStruct();
				windowEvent.onStop.status = true;
				windowEvent.onStop.callback = function(){WebClient.Video.StopVideo(windowKey);};
				windowEvent.onClick.status = true;
				windowEvent.onClick.callback = function(){WebClient.Video.ActiveWindow(windowKey);};
				windowEvent.onStartRecord.status = true;
				windowEvent.onStartRecord.callback = function(){WebClient.Video.LocalRecord(windowKey);};
				windowEvent.onStopRecord.status = true;
				windowEvent.onStopRecord.callback = function(){WebClient.Video.LocalRecord(windowKey);};
				
				windowEvent.onSnapshot.status = true; 	
				windowEvent.onSnapshot.callback = function(){WebClient.Video.SnapShot(windowKey);}; 	
				
				windowEvent.onPTZControl.status = true;
				windowEvent.onRestore.status = true;							
				windowEvent.onFullScreen.status = true;	
				
				//添加自定义窗口右击菜单 
				var curWndNumber = WebClient.Video.curWindowNumber; //当前窗口数量
				var wndIndex = windowKey.replace("windowbox","");//当前播放窗口序号
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
								WebClient.Video.CustomMenuCommand(windowKey,arguments);													
							} 	
						} 
						
						break;
				} 
			}
			
			// 恢复重建窗口插件
			var rv = Nrcap2.RestoreWindow(WebClient.connectId, windowKey.replace("windowbox", "window"), windowEvent, objWnd); 
			if(rv == Nrcap2.NrcapError.NRCAP_SUCCESS)
			{ 
				// 开始侦测播放视频状态 
				Utility.Clock.EventCallback.Set(
					new Utility.Struct.ClockEventStruct(
						"sense_"+item.key,
						200,
						function(t){ 
							WebClient.Video.SetWindowTitle(windowKey);
						}
					)
				);
				// 设置播放窗口信息条 
				WebClient.Video.SetWindowTitle(windowKey); 
				if(!WebClient.Video.curChangeWndFlag)
				{
					WebClient.Video.SetStatus(windowKey); //设置相应状态 
				}
			}
	   
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
							if(node.type != Nrcap2.Enum.NrcapStreamType['st_video']) return;
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
									windowEvent.onStartRecord.callback = function(){WebClient.Video.LocalRecord(item.key);};
									windowEvent.onStopRecord.status = true;
									windowEvent.onStopRecord.callback = function(){WebClient.Video.LocalRecord(item.key);};
									
									windowEvent.onSnapshot.status = true; 	
									windowEvent.onSnapshot.callback = function(){WebClient.Video.SnapShot(item.key);}; 	
									
									windowEvent.onPTZControl.status = true;
									windowEvent.onRestore.status = true;							
									windowEvent.onFullScreen.status = true;	
									
									//添加自定义窗口右击菜单 
									var curWndNumber = WebClient.Video.curWindowNumber; //当前窗口数量
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
					
					/* 是否多窗口全屏显示 */
					if(WebClient.DealManage.AllFullScreen.flag == 'start'){
						WebClient.DealManage.AllFullScreen.Start();
					}
					
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
					// alert(Object.toJSON(node.window));
					
					var smallWnd = Nrcap2.WindowContainers.get(windowKey).window;
					if(!smallWnd || typeof smallWnd != "object") return false;
					
					WebClient.Video.curChangeWndFlag = true;
					
					WebClient.Video.DestoryWindow(bigWndKey);
					WebClient.Video.DestoryWindow(windowKey);  
					 
					// swap window
					var tmpWindow = node.window; // 中间window变量   
					var tmpDescription = node.description;
					node.window = smallWnd;
					node.description = Nrcap2.WindowContainers.get(windowKey).description;
					Nrcap2.WindowContainers.get(windowKey).window = tmpWindow; 
					Nrcap2.WindowContainers.get(windowKey).description = tmpDescription; 
					
					/* 恢复原小窗口视频的播放 */
					WebClient.Video.RestorePlayVideo(bigWndKey, node.window);    
					// alert(windowKey + "_" + bigWndKey);
					// 更新喊话或对讲信息
					WebClient.Video.UpdateOAChannelWindowKey(node.window.params.puid, windowKey, bigWndKey);
					
					/* 判断原大窗口有无视频 */
					var smallW =  Nrcap2.WindowContainers.get(windowKey).window;  
					if(!smallW || !smallW.params.puid)
					{ 
						Nrcap2.WindowContainers.get(windowKey).window = null; 
						Nrcap2.WindowContainers.get(windowKey).description = null;
						// WebClient.Video.StopVideo(windowKey);  
					}
					else
					{
						/* 恢复原大窗口视频的播放 */ 
						WebClient.Video.RestorePlayVideo(windowKey, smallW);   
						
						// alert(bigWndKey + "_" + windowKey);
						// 更新喊话或对讲信息
						WebClient.Video.UpdateOAChannelWindowKey(smallW.params.puid, bigWndKey, windowKey);
					}
					
				    // alert(Object.toJSON(Nrcap2.WindowContainers));
					 
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
			// alert(Object.toJSON(Nrcap2.WindowContainers));
			var node = Nrcap2.WindowContainers.get(windowKey);
			if(!node) return;
			var objWnd = node.window;
			if(!objWnd) return;
			
			var puid = objWnd.params.puid, idx = objWnd.params.idx; 
			var pu = WebClient.Resource.resource.get(puid); 
			 
			var description = node.description; // alert(Object.toJSON(description));
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
								htmlstr += "<input id=\""+title2+"_record\" type=\"button\" webclienttype=\"windowtitle\" onfocus=\"this.blur();\" class=\"record_onmousedown\" onmouseover=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\" onmouseout=\"WebClient.Video.WindowTitleEvent(this.id,'mouseout','"+windowKey+"');\" onmousedown=\"WebClient.Video.WindowTitleEvent(this.id,'mousedown','"+windowKey+"');\" onmouseup=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\" onclick=\"WebClient.Video.LocalRecord('"+windowKey+"');\" title=\"停止录像\" />";
							}
							else
							{
								htmlstr += "<input id=\""+title2+"_record\" type=\"button\" webclienttype=\"windowtitle\" onfocus=\"this.blur();\" class=\"record_onmouseout\" onmouseover=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\" onmouseout=\"WebClient.Video.WindowTitleEvent(this.id,'mouseout','"+windowKey+"');\" onmousedown=\"WebClient.Video.WindowTitleEvent(this.id,'mousedown','"+windowKey+"');\" onmouseup=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\"  onclick=\"WebClient.Video.LocalRecord('"+windowKey+"');\" title=\"开始录像\" />";
							}				
							//audio
							if(objWnd.status.playaudioing)
							{
								htmlstr += "<input id=\""+title2+"_audio\" type=\"button\" webclienttype=\"windowtitle\" onfocus=\"this.blur();\" class=\"audio_onmousedown\" onmouseover=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\" onmouseout=\"WebClient.Video.WindowTitleEvent(this.id,'mouseout','"+windowKey+"');\" onmousedown=\"WebClient.Video.WindowTitleEvent(this.id,'mousedown','"+windowKey+"');\" onmouseup=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\"  onclick=\"WebClient.Video.PlayAudio('"+windowKey+"');\" title=\"停止音频\" />";
							}
							else
							{
								htmlstr += "<input id=\""+title2+"_audio\" type=\"button\" webclienttype=\"windowtitle\" onfocus=\"this.blur();\" class=\"audio_onmouseout\" onmouseover=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\" onmouseout=\"WebClient.Video.WindowTitleEvent(this.id,'mouseout','"+windowKey+"');\" onmousedown=\"WebClient.Video.WindowTitleEvent(this.id,'mousedown','"+windowKey+"');\" onmouseup=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\"  onclick=\"WebClient.Video.PlayAudio('"+windowKey+"');\" title=\"开始音频\" />";
							} 
							
							//talk
							if(objWnd.status.talking)
							{
								htmlstr += "<input id=\""+title2+"_talk\" type=\"button\" webclienttype=\"windowtitle\" onfocus=\"this.blur();\" class=\"talk_onmousedown\" onmouseover=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\" onmouseout=\"WebClient.Video.WindowTitleEvent(this.id,'mouseout','"+windowKey+"');\" onmousedown=\"WebClient.Video.WindowTitleEvent(this.id,'mousedown','"+windowKey+"');\" onmouseup=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\"  onclick=\"WebClient.Video.StopCallTalk('"+windowKey+"');\" title=\"停止对讲\" />";
							}
							else
							{
								htmlstr += "<input id=\""+title2+"_talk\" type=\"button\" webclienttype=\"windowtitle\" onfocus=\"this.blur();\" class=\"talk_onmouseout\" onmouseover=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\" onmouseout=\"WebClient.Video.WindowTitleEvent(this.id,'mouseout','"+windowKey+"');\" onmousedown=\"WebClient.Video.WindowTitleEvent(this.id,'mousedown','"+windowKey+"');\" onmouseup=\"WebClient.Video.WindowTitleEvent(this.id,'mouseover','"+windowKey+"');\"  onclick=\"WebClient.Video.StartTalk('"+windowKey+"');\" title=\"开始对讲\" />";
							} 
							
							$$("#"+windowTitle+" .title2")[0].innerHTML = htmlstr;
						}
						else
						{
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
				
				if(objId.search("_talk") != -1)
				{
					if(objWnd.status.talking)
					{
						$(objId).className = "talk_onmousedown";
						$(objId).title = "停止对讲";
						$(objId).onclick = function(){
							alert("4582****停止对讲***windowKey:"+windowKey);
							WebClient.Video.StopCallTalk(windowKey);
						};
					}
					else
					{
						$(objId).title = "开始对讲";
						$(objId).onclick = function(){
							alert("4591***开始对讲****windowKey:"+windowKey);
							WebClient.Video.StartTalk(windowKey);
						};
						if(titleEvent == "mouseover")
						{
							$(objId).className = "talk_onmouseover";
						}
						else
						{
							$(objId).className = "talk_onmouseout";
						}	
					}
				}
					 
			}			
		},		
		
		/*
		*	对象名		：SetStatus
		*	功能    	：设置导航菜单,视频参数控制的状态 
		*	备注		：无
		*	作者		：huzw
		*	时间		：2011.02.23 
		*/
		SetStatus:function(windowKey){
			try
			{   
				var node = Nrcap2.WindowContainers.get(windowKey);
				if(!node) return;
				var objWnd = node.window; 
				
				var route = Global.route;
				var folder = Global.folder; 
				
				if(objWnd && objWnd.params.puid)
				{  
					if(objWnd.status.playvideoing)
					{ 
						WebClient.NavMenu.Disabled(false);
						WebClient.Control.PTZDisabled(false); 
						WebClient.Control.VideoParamDisabled(false,objWnd);
						
						if($("mm_video_record"))
						{
							if(objWnd.status.recording)
							{
								$("mm_video_record").style.backgroundImage = "url(images/"+route+"/"+folder+"/top_menuicon_u1_4.png)";
							}
							else
							{
								$("mm_video_record").style.backgroundImage = "url(images/"+route+"/"+folder+"/top_menuicon_u1_1.png)";
							}
						}
						
						if($("mm_video_audio"))
						{
							if(objWnd.status.playaudioing)
							{
								$("mm_video_audio").style.backgroundImage = "url(images/"+route+"/"+folder+"/top_menuicon_u1_4.png)";
							}
							else
							{
								$("mm_video_audio").style.backgroundImage = "url(images/"+route+"/"+folder+"/top_menuicon_u1_1.png)";
							}
						}
					}
					else
					{
						WebClient.NavMenu.Disabled(true);
						WebClient.Control.PTZDisabled(true);	
						WebClient.Control.VideoParamDisabled(true);
					}
				}
				else
				{  
					WebClient.NavMenu.Disabled(true);
					WebClient.Control.PTZDisabled(true); 
					WebClient.Control.VideoParamDisabled(true);
				} 
				
			}
			catch(e)
			{
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Video.SetStatus",msg:"设置状态异常,error="+e.message+","+e.name}); 
				return false;
			}		
		},
		
		StopVideo:function(windowKey){
			try
			{
				if(windowKey)
				{
					var node = Nrcap2.WindowContainers.get(windowKey);
					if(node.type == Nrcap2.Enum.NrcapStreamType['st_video'])
					{
						if(node && node.window && node.window.status.playvideoing)
						{ 
							WebClient.Video.StopCallTalk(windowKey); // 关闭喊话或对讲
							
							Nrcap2.StopVideo(node.window);
							node.window.wnd.style.visibility = "hidden"; 
							
							WebClient.Video.SetWindowTitle(windowKey); // 设置窗口状态条
							if(!WebClient.Video.curChangeWndFlag)
							{
							  WebClient.Video.SetStatus(windowKey);//设置导航、云台等状态 
							} 
							Utility.Clock.EventCallback.UnSet("sense_" + windowKey);  
						}
					}
					
				}
			}
			catch(e)
			{
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Video.StopVideo",msg:"停止视频异常,error="+e.message+","+e.name});  	
			}
		},
		
		/*
		*	函数名		：PlayAudio
		*	函数功能		：播放音频 
		*	备注			： 
		*	作者			：huzw
		*	时间			：2011.02.23 
		*/
		PlayAudio:function(windowKey)
		{
			try
			{
				if(windowKey)
				{
					if (Nrcap2.WindowContainers.get(windowKey))
					{
						var playaudioed = false; 
						Nrcap2.WindowContainers.each
						(
							function(item)
							{
								if(item.value.type != Nrcap2.Enum.NrcapStreamType['st_video']) return;
								if(item.value.window != null)
								{
									if(item.value.window.status.playvideoing && item.value.window.status.playaudioing)
									{
										if (item.key == windowKey)	// 当前选择要播放的音频,已经在播放了
										{
											playaudioed = true;
										}
										else
										{ 
											Nrcap2.PlayAudio(item.value.window); // 关闭非当前需要的其它所有播放音频 
											
											WebClient.Video.WindowTitleEvent(item.key.replace("windowbox","windowtitle") + "_title2_audio","mouseout",item.key); // 改变窗体状态条
										}
										throw $break;
									}
								}
							}
						);
						 
						var node = Nrcap2.WindowContainers.get(windowKey);	
						var _continue = true;
						if(!node.window.status.playaudioing && node.window.status.talking)
						{ 
							if(!confirm("该视频正在进行对讲，音频播放需关闭对讲，是否继续？"))
							{
								_continue = false;
							}
							if(_continue == false) return false;
							WebClient.Video.StopCallTalk(windowKey); // 关闭喊话或对讲
						}
						
						// 播放音频
						var rv = Nrcap2.PlayAudio(node.window);
						 
						WebClient.Video.WindowTitleEvent(windowKey.replace("windowbox","windowtitle") + "_title2_audio","mouseup",windowKey); // 改变窗体状态条
						// alert(rv);
						return rv;
					}
				}            
			}
			catch(e)
			{
				//alert("WebClient.Video.PlayAudio:"+e.message+","+e.name);
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Video.PlayAudio",msg:"播放音频异常,error="+e.message+","+e.name}); 
				return false;
			}
		},
		
		SnapShot:function(windowKey){
			try
			{
				if(windowKey)
				{
					var node = Nrcap2.WindowContainers.get(windowKey);
					if (node)
					{
						Nrcap2.SnapShot(node.window);  
						WebClient.Video.WindowTitleEvent(windowKey.replace("windowbox","windowtitle") + "_title2_snapshot","mouseup",windowKey);//改变窗体状态条
					}
				}            
			}
			catch(e)
			{
				//alert("WebClient.Video.SnapShot:"+e.message+","+e.name);
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Video.SnapShot",msg:"本地抓拍异常,error="+e.message+","+e.name}); 
				return false;
			} 
		},
		
		LocalRecord:function(windowKey){
			try
			{
				if(windowKey)
				{
					var node = Nrcap2.WindowContainers.get(windowKey);
					if(node && node.window)
					{
						 Nrcap2.LocalRecord(node.window);  
						 WebClient.Video.WindowTitleEvent(windowKey.replace("windowbox","windowtitle") + "_title2_record","mouseup",windowKey);//改变窗体状态条
					}
				}
			}
			catch(e)
			{
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Video.Record",msg:"本地录像异常,error="+e.message+","+e.name});  
				return false;
			}
		},
		
		/*
		*	函数名		：StartTalk
		*	函数功能		：开始对讲 
		*	备注			： 
		*	作者			：huzw
		*	时间			：2011.10.19 
		*/
		StartTalk: function(windowKey){
			try
			{
				if(windowKey)
				{
					var node = Nrcap2.WindowContainers.get(windowKey);
					if(node && node.window)
					{
						if(node.window.status.playvideoing)
						{
							if(node.window.status.talking)
							{
								alert("已经开启对讲！");
								return false; 
							}
							var puid = node.window.params.puid;
							 
							var rv_arr = WebClient.Video.CheckTalkEnable(puid) || [-1, -1];
							switch(rv_arr[0])
							{
								case -1: 
									alert("设备不支持对讲！");
									return false; 
									break;
								case 0:
									alert("资源已被占用，无法开启对讲！");
									return false; 
									break;
								default: // =>1
									var _continue = true;
									if(node.window.status.playaudioing ||
										node.window.status.upaudioing )
									{
										if(!confirm("开启对讲前需关闭音频或喊话，是否继续开启？"))
										{
											_continue = false;
										}
										
										if(_continue == false) return false; 
										
										if(node.window.status.playaudioing)
										{
											WebClient.Video.PlayAudio(windowKey); // 停止音频
										}
										else
										{
											// 暂未实现
										}
									} 
									break;
							}
							 
							var resOAIdx = rv_arr[1];
							 
							var rv = Nrcap2.StartTalk(WebClient.connectId, node.window, resOAIdx); // 开始喊话						
							if(rv !== false && parseInt(rv) == 0)
							{
								WebClient.Video.SetTalkStatus(windowKey, puid, resOAIdx); // 状态控制
							}
						 
							WebClient.Video.WindowTitleEvent(windowKey.replace("windowbox","windowtitle") + "_title2_talk","mouseup",windowKey); // 改变窗体状态条
						}
						
					}
				}
			}
			catch(e)
			{
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Video.StartTalk",msg:"开始对讲异常,error="+e.message+","+e.name});  
				return false;
			}
		},
		 
		ResOAChannels: new Hash(), // OA资源通道信息
		
		// 切换窗口时更新 
		UpdateOAChannelWindowKey: function(puid, oldWndKey, newWndKey){
			// alert(puid +","+ oldWndKey +","+ newWndKey);
			// alert(Object.toJSON(WebClient.Video.ResOAChannels));
			Nrcap2.WindowContainers.each
			(
				function(item)
				{
					var node = item.value;
					if(item.key == newWndKey)
					{ 
						WebClient.Video.ResOAChannels.each
						(
							function(ee)
							{
								var e = ee.value;
								if(e.puid == puid && e.windowKey == oldWndKey )
								{
								
									e.windowKey = newWndKey; 
									if(node.window.status.talking)
									{
										e.flag = true; 
									}
									else
									{
										e.flag = false; 
										e.windowKey = "";
									}
								
								}
							}
						);
					}
				}
			);
			// alert(Object.toJSON(WebClient.Video.ResOAChannels));
			
		},
		
		SetTalkStatus: function(windowKey, puid, resOAIdx ){
			Nrcap2.WindowContainers.each
			(
				function(item)
				{
					var node = item.value;
					if(item.key == windowKey)
					{ 
						WebClient.Video.ResOAChannels.each
						(
							function(ee)
							{
								var e = ee.value; // alert(Object.toJSON(e));
			
								if(e.puid == puid && (e.index == resOAIdx || e.windowKey == windowKey))
								 {
									if(node.window.status.talking)
									{
										e.flag = true;
										e.windowKey = windowKey;
									}
									else
									{
										e.flag = false; 
										e.windowKey = "";
									}

								 }
							}
						);
					}
				}
			);
			 alert("*********4977*********"+Object.toJSON(WebClient.Video.ResOAChannels));
		},
		
		/*
		*	函数名		：CheckTalkEnable
		*	函数功能		：检测喊话是否可用或资源（OA）已被占用 
		*	备注			： 
		*	作者			：huzw
		*	时间			：2011.10.19 
		*	返回值		：
		*/
		CheckTalkEnable: function(puid){ 
			alert("*********4989*********");
			var resource = WebClient.Resource.resource;
			if(!resource || typeof resource != "object") return false;
			var device = resource.get(puid);
			if(!device || typeof device == "undefined") return false; 
			 
			if(WebClient.Video.ResOAChannels && Object.isHash(WebClient.Video.ResOAChannels))
			{
				var addflag = true;
				var rOACKeys = WebClient.Video.ResOAChannels.keys();
				for(var i = 0; i < rOACKeys.length; i++)
				{
					if(addflag == true && rOACKeys[i].search(puid) != -1)
					{
						addflag = false;
					}
				}
				if(addflag == true || rOACKeys.length <= 0)
				{
					if(device.childResource && typeof device.childResource == "object"){  
						var resOAIdx = 0;
						device.childResource.each
						(
							function(item)
							{  
						        // alert(Object.toJSON(item));
								if(item.type == Nrcap2.Enum.PuResourceType.AudioOut)
								{
									WebClient.Video.ResOAChannels.set(puid + "_" + parseInt(resOAIdx), {puid: puid, index: resOAIdx++, windowKey: "", flag: false});	
								}	
							}
						); 
					} 
				} 
				
				// alert(Object.toJSON(WebClient.Video.ResOAChannels)); 
				
				var found = false, activeResOAIdx = 0 , flag = -1;
				WebClient.Video.ResOAChannels.each
				(
					function(ee)
					{
						var e = ee.value;
						if(e.puid == puid)
						 {
							flag = 0; // 存在OA资源
							if(found == false && e.flag != true )
							{
								activeResOAIdx = e.index;
								found = true;
							}
						 }
					}
				);
				if(found == true) flag = 1;
 				return [flag, activeResOAIdx]; 
				// flag -1(不支持)， 0（被占用），1（可用）
			} 
		},
		
		/*
		*	函数名		：StopCallTalk
		*	函数功能		：停止喊话或对讲 
		*	备注			： 
		*	作者			：huzw
		*	时间			：2011.10.19 
		*/
		StopCallTalk: function(windowKey){
			try
			{
				if(windowKey)
				{
					var node = Nrcap2.WindowContainers.get(windowKey);
					if(node && node.window)
					{
						if(node.window.na && node.window.status.talking)
						{
							Nrcap2.StopCallTalk(node.window); 
						}
							 
						WebClient.Video.SetTalkStatus(windowKey, node.window.params.puid, -1); // 状态控制
						WebClient.Video.WindowTitleEvent(windowKey.replace("windowbox","windowtitle") + "_title2_talk","mouseup",windowKey); // 改变窗体状态条
						
					}
				}
			}
			catch(e)
			{
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Video.StopCallTalk",msg:"停止喊话或对讲异常,error="+e.message+","+e.name});  
				return false;
			}
		},
		
	    end:true
	},
	
	/*
	*	函数名		：Query
	*	函数功能   	：查询下载对象 
	*	备注			：无
	*	作者			：huzw
	*	时间			：2011.02.27	
	*/
	Query:{
		minPage:1, //query min window page counts 
		maxPage:5, //query max window page counts
		curVodWindowPage:1, //query vod window page number
		
		detailContainerKeys:["detailDates","detailDays","detailFiles"],	
		detailContainerIndexs:{"detailDates":1,"detailDays":2,"detailFiles":3},
		detailTitleNote:{ivName:"",ivDate:"",ivDay:""},
		
		curActiveVodWindowKey:"", //当前被激活的窗体容器
		curDownloadCardId:"downloadVodCard", //当前下载信息默认显示容器 
		
		DetailTitleButtons:new Hash(), //查询结果导航栏按钮信息 
		VodWindowContainers:new Hash(), //回放录像的窗体容器信息对象 
		VodSliderBars:new Hash(), //存放回放进度条信息 
		
		/*
		*	函数名		：Init
		*	函数功能   	：初始化查询下载对象页面元素 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.02.27	
		*/
		Init:function(){ 
			var objIds = ["DetailPad","DownloadPad","vodWindowPad"]; //
			for(var index = 0; index < objIds.length; index++)
			{
				if($(objIds[index]))
				{
					WebClient.Query.Html(objIds[index]);
				} 
			} 
			
			WebClient.Query.AttachDetailTitleEvent(); 
			WebClient.Query.InitVodWindowContainers(); //初始化回放视频窗口 
			WebClient.Query.AttachDownloadCardEvent();
			
			if($("vod_turnto"))
			{
				$("vod_turnto").selectedIndex = 0;//选择显示第一页 
				var value = $("vod_turnto").options[0].value;
				WebClient.Query.AttachPageOnChange();
				WebClient.Query.SwitchPage(value,"vod"); 
			} 
			
			WebClient.Download.Init(); //初始化下载对象 
		},
		
		AttachDetailTitleEvent:function(){
			if($("detailTitle"))
			{
				var btns = $("detailTitle").getElementsByTagName("INPUT");
				for(var i = 0,j = 1; i < btns.length; i++)
				{
					var btn = btns[i]; 
					if(btn.type == "button")
					{
						if(btn.webclienttype == "direction")
						{
							if(btn.disabled)
							{ 
								btn.style.backgroundImage = "url(images/back_u1_2.png)"; 
							}
							else
							{ 
								btn.style.backgroundImage = "url(images/back_u1_1.png)";
							}
							
							btn.onmouseover = function(){
								this.style.backgroundImage = "url(images/back_u1_3.png)";
								
							}
							btn.onmouseout = function(){
								this.style.backgroundImage = "url(images/back_u1_1.png)";
							}
							btn.onclick = function(){
								var containerIndexs = WebClient.Query.detailContainerIndexs;
								//{"detailDates":1, "detailDays":2, "detailFiles":3 }
								
								var index = 0;
								if(this.id.toLowerCase().search("back") != -1)
								{
									index = 1; //back
								}
								else
								{
									index = 2; //forward
								}
								 
								WebClient.Query.DetailTitleButtons.each(
									function(item){		
										var node = item.value;
										if(node.active && node.index == index)
										{
											var containerIndex = containerIndexs[node.turnTo];
											WebClient.Resource.DetailResultDisplay(containerIndex);
										}
									}
								); 
								
							}							
						}
						
						WebClient.Query.DetailTitleButtons.set(btn.id,{object:btn,index:j++,active:false,turnTo:"",description:null});
						  
					} //end inner if 
				} //end for
				
				//alert(Object.toJSON(WebClient.Query.DetailTitleButtons));
				
			} //end outer if
			
		},
		
		DisabledDetailTitleButtons:function(){
			WebClient.Query.DetailTitleButtons.each(
				function(item){
					var node = item.value;
					if(node.active)
					{
						node.object.disabled = false;
						node.object.style.backgroundImage = "url(images/back_u1_1.png)";
					}
					else
					{
						node.object.disabled = true;
						node.object.style.backgroundImage = "url(images/back_u1_2.png)";
					}
				}
			);
			
		},
		
		/*
		*	函数名		：AttachDownloadCardEvent
		*	函数功能   	：绑定下载信息选项卡切换事件 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.03.09	
		*/
		AttachDownloadCardEvent:function(){
			if($("queryDownloadCard"))
			{
				var queryDcards = $("queryDownloadCard").getElementsByTagName("DIV");
				for(var i = 0; i < queryDcards.length; i++)
				{
					var queryDcard = queryDcards[i];
					if(queryDcard.id && queryDcard.webclienttype == "card")
					{
						if(queryDcard.id.toLowerCase().search("vod") != -1)
						{
							queryDcard.title = "录像下载";
						}
						else
						{
							queryDcard.title = "图片下载";
						}
						
						queryDcard.onmouseover = function(){
							$(this.id).style.backgroundColor = "#E3EDF9"; 
						};
						queryDcard.onmouseout = function(){
							if(WebClient.Query.curDownloadCardId == this.id) return;
							$(this.id).style.backgroundColor = ""; 
						};
						queryDcard.onclick = function(){
							if($(this.id)){
								WebClient.Query.SwitchDownloadCard(this.id); 
							}
						};
						
					}//end inner if  
				} // end for
				
				var curDCardId = WebClient.Query.curDownloadCardId;
				WebClient.Query.SwitchDownloadCard(curDCardId); //首先显示vod download info
				
			}//end outer if
		},
		
		/*
		*	函数名		：SwitchDownloadCard
		*	函数功能   	：下载信息选项卡切换 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.03.09	
		*/
		SwitchDownloadCard:function(dCardId){
			//alert(dCardId);
			var curDCardId = WebClient.Query.curDownloadCardId;
			
			if(!$(curDCardId)) return false;
			
			$(curDCardId).style.fontWeight = "normal";
			$(curDCardId).style.backgroundColor = "";
			
			if($(curDCardId.replace("Card","s")) && $(dCardId.replace("Card","s")))
			{
				$(curDCardId.replace("Card","s")).style.display = "none";
				$(dCardId.replace("Card","s")).style.display = "block";
			}
			
			$(dCardId).style.fontWeight = "bold";
			$(dCardId).style.backgroundColor = "#E3EDF9"; 
			
			WebClient.Query.curDownloadCardId = dCardId;
		},
		
		/*
		*	函数名		：ActiveVodWindow
		*	函数功能   	：激活回放视频窗口容器 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.03.03
		*	修改			：2011.09.28
		*/
		ActiveVodWindow:function(vodWndKey){ 	  
			try
	        { 
	            Nrcap2.WindowContainers.each(
	                function(item){
	                    var node = item.value;
						if(node.type == Nrcap2.Enum.NrcapStreamType['st_vod'])
						{
							if(node.container.id == vodWndKey)
							{
								node.active = true;
								$(vodWndKey).style.backgroundColor = "#65A3E5"; //ac59ff
								WebClient.Query.curActiveVodWindowKey = item.key;  
							}
							else
							{
								node.active = false;
								$(node.container.id).style.backgroundColor = "#9bcaf3";
							}
						} 
	                }	            
	            );
	        }
	        catch(e)
	        {
	            WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Query.ActiveVodWindow",msg:e.message +"::"+ e.name});
	        } 
		},
		
		/*
		*	函数名		：InitVodWindowContainers
		*	函数功能   	：初始化回放视频窗口 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.03.03
		*	修改			：2011.09.28
		*/
		InitVodWindowContainers:function(){
			if($("vodWindowsBox"))
			{
				var vodwnds = $("vodWindowsBox").getElementsByTagName("DIV");
				var vodKeys = new Array();
				for(var i = 0; i < vodwnds.length; i++)
				{
					var vodwnd = vodwnds[i];
					if(vodwnd.id.search("windowbox") != -1)
					{ 
						vodwnd.onclick = function(){
							WebClient.Query.ActiveVodWindow(this.id);
						};
						
						vodKeys.push(vodwnd.id);
						Nrcap2.WindowContainers.set(vodwnd.id, new Nrcap2.Struct.WindowContainerStruct(vodwnd, Nrcap2.Enum.NrcapStreamType['st_vod'])); 
						
					}
				}
				
				WebClient.Query.ActiveVodWindow(vodKeys[0]);
				
				// alert(Object.toJSON(Nrcap2.WindowContainers));

				return; 
				 
			} 
			
		},
		
		/*
		*	函数名		：PlayVod
		*	函数功能   	：点播回放视频 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.03.04
		*	修改			：2011.09.28
		*/
		PlayVod: function(fileName, filePath, csuPuid, fileTimeLength){
			var fileFullPath = filePath + "/" + fileName;
			 Nrcap2.WindowContainers.each(
				function(item){
					var node = item.value;
					if(node.type == Nrcap2.Enum.NrcapStreamType['st_vod'])
					{
						if(node.active){
							var create = true;
							if(node.window){
								create = false;
								if(node.window.status.playvoding){
									WebClient.Query.StopVod(item.key); // 停止点播	
								} 
							}
							
							if(create){
								var windowEvent = new Nrcap2.Struct.WindowEventStruct();
								
								windowEvent.onStop.status = true;
								windowEvent.onStop.callback = function(){WebClient.Query.StopVod(item.key);};
								
								windowEvent.onClick.status = true;
								windowEvent.onClick.callback = function(){WebClient.Query.ActiveVodWindow(item.key);};
								
								windowEvent.onSnapshot.status = true;
								windowEvent.onSnapshot.callback = function(){WebClient.Video.SnapShot(item.key);};
								
								windowEvent.onStartRecord.status = true;
								windowEvent.onStartRecord.callback = function(){WebClient.Video.LocalRecord(item.key);};
								windowEvent.onStopRecord.status = true;
								windowEvent.onStopRecord.callback = function(){WebClient.Video.LocalRecord(item.key);};
								
								windowEvent.onPop.status = true;
								windowEvent.onRestore.status = true;							
								windowEvent.onFullScreen.status = true;	 
								windowEvent.onPTZControl.status = false;	
								
								node.window = Nrcap2.CreateWindow(WebClient.connectId, item.key.replace("windowbox", "window"), windowEvent, node.type);
							} 
							
							node.window.SetStyle({enableFullScreen: true, enableMainPopMenu:true});
							node.window.wnd.style.visibility = "visible";
							
							var params = {
								type: Nrcap2.Enum.StorageFileType['platform'],
								puid: csuPuid,
								fileFullPath: fileFullPath,
								fileTimeLength: fileTimeLength
							};
							var rv = Nrcap2.PlayVod(WebClient.connectId, node.window, params);
							WebClient.Query.PlayVodAudio(item.key);
							
							// 开始侦测回放视频状态 
							Utility.Clock.EventCallback.Set(
								new Utility.Struct.ClockEventStruct(
									"vod_" + item.key,
									200,
									function(t){
										//alert(item.key); 
										WebClient.Query.SetVodWindowTitle(item.key); //设置状态条
									}
								)
							); 
							
							WebClient.Query.SetVodWindowTitle(item.key); //设置状态条
						}
						
					}
				}
			);
			 
		},
		
		/*
		*	函数名		：PlayVodAudio
		*	函数功能   	：开启、停止点播录像音频 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.09.28	
		*/
		PlayVodAudio: function(vodWndKey){
			try
			{
				Nrcap2.WindowContainers.each
				(
					function(item)
					{
						var node = item.value;
						if(node.type == Nrcap2.Enum.NrcapStreamType['st_vod'])
						{
							if(item.key == vodWndKey && node.window && node.window.status.playvoding)
							{
								var rv = Nrcap2.PlayVodAudio(node.window);
								// alert(rv);
							} 
						} 
					}
				);
				
				// alert(Object.toJSON(Nrcap2.WindowContainers));
			}
			catch(e)
			{
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Query.PlayVodAudio",msg:"开启、停止点播录像音频异常,"+e.message+":"+e.name});
			}
			
		},
		
		/*
		*	函数名		：StopAllVod
		*	函数功能   	：停止所有回放视频 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.03.08	
		*/
		StopAllPlayVod:function(){
			Nrcap2.WindowContainers.each(
				function(item){
					var node = item.value;
					if(node.type == Nrcap2.Enum.NrcapStreamType['st_vod'])
					{
						if(node.window && node.window.status.playvoding)
						{
							Nrcap2.StopVod(node.window);	
							node.window.wnd.style.visibility = "hidden";//窗体设为隐藏
										
							Utility.Clock.EventCallback.UnSet("vod_" + item.key);
							WebClient.Query.SetVodWindowTitle(item.key); //格式化回放窗口条
						}
					} 
				}
			);
		},
		
		/*
		*	函数名		：StopVod
		*	函数功能   	：停止回放视频 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.03.04	
		*/
		StopVod:function(vodWndKey){
			try
			{
				Nrcap2.WindowContainers.each(
					function(item){
						var node = item.value;
						if(node.type == Nrcap2.Enum.NrcapStreamType['st_vod'])
						{
							var node = item.value;
							if(node.container.id == vodWndKey) 
							{ 
								if(node.window && node.window.status.playvoding)
								{
									if(node.window.status.playaudioing)
									{
										WebClient.Query.PlayVodAudio(vodWndKey);
									}
									
									Nrcap2.StopVod(node.window);
									node.window.wnd.style.visibility = "hidden";//窗体设为隐藏
									
									Utility.Clock.EventCallback.UnSet("vod_" + vodWndKey);
									
									WebClient.Query.SetVodWindowTitle(vodWndKey); //格式化回放窗口条
								}
							}
						}
					}
				);
			}
			catch(e)
			{
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Query.StopVod",msg:"停止回放视频异常,"+e.message+":"+e.name});	
			}
		},
		
		/*
		*	函数名		：SetVodWindowTitle
		*	函数功能   	：设置回放窗口状态条 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.03.04	
		*/
		SetVodWindowTitle:function(vodWndKey){
			var htmlstr = "";
			var node = Nrcap2.WindowContainers.get(vodWndKey);
			var timeToStr = function(_Time){
				if(!_Time || typeof _Time == "undefined")
				{
					return "00:00:00"; 
				}
				
				var _Hours = Math.floor(_Time/3600).toFixed(0).toString(); 
				var _Minutes = Math.floor((_Time - _Hours * 3600)/60).toFixed(0).toString(); 
				var _Seconds = Math.floor(_Time - _Hours * 3600 - _Minutes * 60).toFixed(0).toString(); 
				var AttachZero = function(_T)
				{
					if(!_T) return "00";
					else if(typeof _T != "string") return _T; 
					else return (_T.length == 1 ? "0" + _T : _T);	
				};
				
				_Hours = AttachZero(_Hours);
				_Minutes = AttachZero(_Minutes);
				_Seconds = AttachZero(_Seconds); 
				
				return _Hours + ":" + _Minutes + ":" + _Seconds; 
			};
			 
			if(node.window)
			{  
				var titleKey = vodWndKey.replace("windowbox", "windowtitle"); 
				
				if(node.window.status.playvoding)
				{
					var vodStatus = Nrcap2.GetVodStatus(node.window); //alert(Object.toJSON(vodStatus));	
					var currentTime = parseInt(vodStatus["currentTime"],16);					
					var flag = parseInt(vodStatus["flag"]);					
					var description = vodStatus["description"];
										
					var curTime = timeToStr(currentTime); //当前播放时间点 					
					var titleTime = "00:00:00/23:59:59", barValue = 0;
					var fileTimeLength = node.window.params.fileTimeLength; 
					if(fileTimeLength != "-1" && fileTimeLength != null && typeof fileTimeLength != "undefined")
					{
						fileTimeLength = parseInt(fileTimeLength); // 对时长微调 
						//alert(fileTimeLength);
						var allTime = timeToStr(fileTimeLength); // 播放总的时间点 

						//alert(allTime);
						currentTime >= fileTimeLength ? curTime = allTime : "";
						
						titleTime = curTime + "/" + allTime;
						
						barValue = ((currentTime/fileTimeLength) * 100).toFixed(0);  
						
						//alert( fileWndKey + ":" + barValue);
					}
					else
					{
						titleTime = curTime;  
					} 
				
					if($(titleKey) && (!$(titleKey + "up") || !$(titleKey + "down")))
					{
						var title = (Nrcap2.language == "Chinese" ? "无回放录像" : "no vod");
						htmlstr = "";
						htmlstr += "<div id=\""+titleKey+"up\" class=\"titleup\">"; 
						htmlstr += "</div>";
						htmlstr += "<div id=\""+titleKey+"down\"  class=\"titledown\">";
							htmlstr += "<div class=\"title1\">"+title+"</div>"; 
							htmlstr += "<div class=\"title2\"></div>"; 
						htmlstr += "</div>"; 	
						
						$(titleKey).innerHTML = htmlstr;
						
					}
					if(!$(titleKey + "up_slider"))
					{
						
						if($(titleKey + "up"))
						{		
							htmlstr = "";					
							htmlstr += "<div id=\""+titleKey+"up_speed\" style=\"width:55px;height:18px;float:left; vertical-align:middle;\">";	
								htmlstr += "正常 *1";
							htmlstr += "</div>";	
							htmlstr += "<div id=\""+titleKey+"up_slider\"  tabIndex=\"1\" style=\"width:150px; height:15px; float:left; vertical-align:middle; background-color:Transparent; border-left:0px #FFFFFF solid;\">";
								htmlstr += "<div id=\""+titleKey+"up_slider_input\" ></div>";
							htmlstr += "</div>";
							htmlstr += "<div id=\""+titleKey+"up_time\" style=\"width:106px;height:18px;float:left; text-align:right; vertical-align:middle; border-left:0px #FFFFFF solid;\">";	
							htmlstr += "</div>"; 
							
							$(titleKey + "up").innerHTML = htmlstr;  //alert($(titleKey + "up").innerHTML); 
							
							//初始化回放进度条
							WebClient.Query.VodSliderBars.set(
								titleKey+"up_slider",
								{
									active:true,
									bar:null,
									key:titleKey+"up_slider",
									puid:null,
									idx:0,
									originalValue:0,
									SetStatus:function(status,puid){
										this.bar.setStatus(status);
										if(!status)
										{
											this.originalValue = 0;
											this.bar.setValue(this.originalValue);
											this.puid = null;
										}
										else
										{
											this.bar.setValue(this.originalValue);	
										}
									},
									callbacks:{
										mouseup:function(){
											var vodSlider = WebClient.Query.VodSliderBars.get(titleKey+"up_slider");
											var value = vodSlider.bar.getValue(); //alert(value);
											
											var startTime = ((value/100)* fileTimeLength).toFixed(0);	
											var objWnd = node.window;  
											objWnd.params.startTime = startTime;
											 
											Nrcap2.PlayVodJump(WebClient.connectId, objWnd, Nrcap2.Enum.StorageFileType['platform']);
											
											vodSlider.bar.setValue(value); //设置状态条	
											vodSlider.active = true; 
										},
										mousedown:function(){
											WebClient.Query.VodSliderBars.get(titleKey+"up_slider").active = false;
										},
										onblur:function(){
											
										}, 
										
										end:true 
									},
									
									end:true
								}
							);
							
							var vodSlider = WebClient.Query.VodSliderBars.get(titleKey+"up_slider");
							vodSlider.bar = new Slider($(titleKey+"up_slider"),$(titleKey+"up_slider_input"),null,vodSlider.callbacks);
							vodSlider.bar.setMaximum(100);
							vodSlider.bar.setUnitIncrement(5);
							vodSlider.bar.setBlockIncrement(1);
							
							vodSlider.SetStatus(true); //remove 
						}  
						
						if($(titleKey + "down"))
						{	 
							if($$("#" + titleKey + "down .title1").length > 0)
							{
								var fileFullPath = node.window.params.fileFullPath;
								var fileName = fileFullPath.substr(fileFullPath.lastIndexOf("/") + 1);
								 
								htmlstr = "";						
								htmlstr += "<span style=\"float:left;width:18px;\">";
									htmlstr += "<input id=\""+titleKey+"down_title1_playflag\" type=\"button\" onfocus=\"this.blur();\"  style=\"width:16px;height:16px;background-color:Transparent; background-image:url(images/readying.png);background-position:3px 2px; background-repeat:no-repeat;border:0px #FFFFFF solid;\" />";
								htmlstr += "</span>";	
								htmlstr += "<span id=\""+titleKey+"down_title1_vodName\"  style=\"float:left;width:195px;white-space:no-wrap;overflow:hidden;text-overflow:ellipsis;\" title=\""+fileName+"\">";
									htmlstr += fileName;
								htmlstr += "</span>";	
								 
								$$("#" + titleKey + "down .title1")[0].innerHTML = htmlstr;
							}
							if($$("#" + titleKey + "down .title2").length > 0)
							{
								var stopflag = "停止";
								htmlstr = "";						
								htmlstr += "<span style=\"float:right;width:20px;\">";
									htmlstr += "<input id=\""+titleKey+"down_title2_stop\" type=\"button\" onfocus=\"this.blur();\"  onclick=\"WebClient.Query.StopVod('"+vodWndKey+"');\" onmouseover=\"this.style.backgroundPosition = '3px 3px';\" onmouseout=\"this.style.backgroundPosition='3px 2px';\" style=\"width:16px;height:16px;background-color:Transparent; background-image:url(images/stop.jpg);background-position:3px 2px; background-repeat:no-repeat;border:0px #FFFFFF solid;\" title=\""+stopflag+"\" />"; 
								htmlstr += "</span>";
								
								$$("#" + titleKey + "down .title2")[0].innerHTML = htmlstr;
							}
						} 
						
					} //end slider if 
					else
					{ 
						$(titleKey+"down_title1_playflag").style.backgroundImage = "url(images/" + (flag == 4 ? "playing" : (flag == 3 ? "buffering" : "readying" )) + ".png)";
						$(titleKey+"down_title1_playflag").title = description; //播放状态描述 
						
						var vodSlider = WebClient.Query.VodSliderBars.get(titleKey+"up_slider");
						//当处在播放状态时，才允许改变状态条的值  
						if(vodSlider.active && flag == 4)
						{
							vodSlider.bar.setValue(barValue); //设置状态条
							$(titleKey+"up_slider").title = curTime; 
						}
						$(titleKey+"up_time") ? $(titleKey+"up_time").innerHTML = titleTime : "";
					 
					} //other				 
					
				}//end playvideoing if
				else
				{
					//当有停止当前回放窗口时，格式化回放窗口条
					if($(titleKey))
					{
						var title = "无回放录像";
						htmlstr = "";
						htmlstr += "<div id=\""+titleKey+"up\" class=\"titleup\">"; 
						htmlstr += "</div>";
						htmlstr += "<div id=\""+titleKey+"down\"  class=\"titledown\">";
							htmlstr += "<div class=\"title1\">"+title+"</div>"; 
							htmlstr += "<div class=\"title2\"></div>"; 
						htmlstr += "</div>"; 	
						
						$(titleKey).innerHTML = htmlstr;
					}
					else
					{
						WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Query.SetVodWindowTitle",msg:"格式化回放窗口条失败！" + titleKey + "元素不存在！"});	
					}
					
				}//no playvideoing
				
			}//end window if
			
		},
		
		/* 绑定换页combox事件 */
		AttachPageOnChange:function(){ 
			if($("vod_turnto"))
			{
				$("vod_turnto").onchange = function(){ 
					if(typeof $("vod_turnto").selectedIndex != "undefined")
					{
						var value = $("vod_turnto").options[$("vod_turnto").selectedIndex].value;  
						if(value != null && typeof value != "undefined")
						{
							WebClient.Query.SwitchPage(value,"vod"); //换页
						}
					} 
				}
				
			} 
		},
		
		SwitchPage:function(pageFlag,type){
			if(!pageFlag) return false;
			if(!type || (type != "vod" && type != "image")) return false;
			
			var curPage = (type == "vod" ? WebClient.Query.curVodWindowPage : 0); //WebClient.Query.curImageWindowPage
			var maxPage = WebClient.Query.maxPage;
			var minPage = WebClient.Query.minPage;
			
			if(curPage == 0) return false;
			
			switch(pageFlag)
			{
				case "prepage":
					curPage--;
					if(curPage < minPage)
					{
						curPage = minPage;
					}
				 
					WebClient.Query.SwitchPage(curPage,type);
					break; 
				case "nextpage":
					curPage++;
					if(curPage > maxPage)
					{
						curPage = maxPage;
					}
					 
					WebClient.Query.SwitchPage(curPage,type);
					break;
				default:
					pageFlag = parseInt(pageFlag);
					if(!Object.isNumber(pageFlag))
					{
						return false;
					}
					else
					{ 
						var newPage	= pageFlag;
						if(newPage == curPage) return true;
						if(newPage >= minPage && newPage <= maxPage)
						{ 
							for(var i = (curPage * 2 - 1); i <= (curPage * 2); i++)
							{
								$(type + "windowbox" + i).style.display = "none";
							}
							for(var j = (newPage * 2 - 1); j <= (newPage * 2); j++)
							{
								$(type + "windowbox" + j).style.display = "block";
							}
							
							//激活当前页的第一个容器窗口 
							WebClient.Query.ActiveVodWindow(type + "windowbox" + (newPage * 2 - 1));
							 
							$("vod_turnto").value = newPage;
							
							WebClient.Query.curVodWindowPage = newPage;
						}
						return true;
					}
					//alert(WebClient.Query.curVodWindowPage);
					break;
			} 
			
		},
		
		Html:function(objId){
			if(!objId && !$(objId)) return; 
			
			var htmlstr = "";
			
			switch(objId)
			{
				case "DetailPad":
					htmlstr += "<div id=\"detailTitle\">";
					
						htmlstr += "<div id=\"detailTitleLeft\">";
							htmlstr += "<input type=\"button\" id=\"detailTitleBack\"  webclienttype=\"direction\" onfocus=\"this.blur();\" value=\"\" disabled />";
							htmlstr += "<input type=\"button\" id=\"detailTitleForward\" webclienttype=\"direction\" onfocus=\"this.blur();\" value=\"\"  disabled/>";
						htmlstr += "</div>";
						htmlstr += "<div id=\"detailTitleMiddle\">";
							htmlstr += "<input type=\"text\" id=\"detailTitleInfo\" value=\"\" readonly />";
						htmlstr += "</div>";	
						htmlstr += "<div id=\"detailTitleRight\">";	
							htmlstr += "<input type=\"button\" id=\"detailTitleRefresh\" webclienttype=\"\" onfocus=\"this.blur();\" value=\"\"  disabled />";
						htmlstr += "</div>";
						
					htmlstr += "</div>";
					htmlstr += "<div id=\"detailContent\">";
						htmlstr += "<div id=\"queryResultBox\" class=\"queryResultBox\">";
							htmlstr += "<div id=\"queryResult\">查询结果";
							htmlstr += "</div>";
						htmlstr += "</div>";
						//dates list
						htmlstr += "<div id=\"detailDates\" class=\"detailInfo\">";
						htmlstr += "</div>";
						//days list
						htmlstr += "<div id=\"detailDays\" class=\"detailInfo\" style=\"display:none;\">";
						htmlstr += "</div>";
						//files list
						htmlstr += "<div id=\"detailFiles\" class=\"detailInfo\" style=\"display:none;\">";
						htmlstr += "</div>";
					htmlstr += "</div>";
					break;
				case "DownloadPad":
					htmlstr += "<div id=\"downloadTitle\">";
						htmlstr += "<div id=\"queryDownloadBox\" class=\"queryDownloadBox\">";
							htmlstr += "<div id=\"downloadResult\">下载信息";
							htmlstr += "</div>";
						htmlstr += "</div>";
						htmlstr += "<div id=\"queryDownloadCard\" class=\"queryDownloadCard\">";
							htmlstr += "<div id=\"downloadImageCard\" class=\"downloadCard\" webclienttype=\"card\" >图片";
							htmlstr += "</div>";
							htmlstr += "<div id=\"downloadVodCard\" class=\"downloadCard\" webclienttype=\"card\" >录像";
							htmlstr += "</div>";
							
						htmlstr += "</div>";
					htmlstr += "</div>";
					htmlstr += "<div id=\"downloadContent\">";
						//download vods list
						htmlstr += "<div id=\"downloadVods\" class=\"downloadInfo\" >downloadVods";
						htmlstr += "</div>";
						//download list
						htmlstr += "<div id=\"downloadImages\" class=\"downloadInfo\" style=\"display:none;\">downloadImages";
					htmlstr += "</div>";
					break;
				case "vodWindowPad":
				case "imageWindowPad": 
					var prefix = "vod";
					var title = (Nrcap2.language == "Chinese" ? "无回放录像" : "no vod");
					if(objId.search(prefix) == -1)
					{
						prefix = "image";
						title1 = "";
					} 
					
					var maxPage = WebClient.Query.maxPage;
					if(maxPage < 1) maxPage = WebClient.Query.maxPage = 3;
					
					htmlstr += "<div id=\""+prefix+"WindowsBox\" class=\"windowBox\">";  
					
					for(var i = 1;i <= (maxPage * 2);i++)
					{
						var display = (i >= 3 ? "none" : "block");
						htmlstr += "<div id=\""+prefix+"windowbox"+i+"\" class=\"queryWindowBox\" style=\"display:"+display+";\" >";
							htmlstr += "<div id=\""+prefix+"window"+i+"\" class=\"queryWindow\" title=\""+i+"\">";
							htmlstr += "</div>";
							htmlstr += "<div id=\""+prefix+"windowtitle"+i+"\" class=\"queryWindowTitle\">";
								htmlstr += "<div id=\""+prefix+"windowtitle"+i+"up\" class=\"titleup\">"; ;
								htmlstr += "</div>";
								htmlstr += "<div id=\""+prefix+"windowtitle"+i+"down\"  class=\"titledown\">";
									htmlstr += "<div class=\"title1\">"+title+"</div>"; 
									htmlstr += "<div class=\"title2\"></div>"; 
								htmlstr += "</div>"; 
							htmlstr += "</div>";
						htmlstr += "</div>";
					}
						
					htmlstr += "</div>"; 
					htmlstr += "<div id=\""+prefix+"ControlBox\" class=\"controlBox\">";
					
						htmlstr += "<div>";
					for(var j = 1;j <= maxPage;j++)
					{	
						if(j == 1)
						{ 
							//htmlstr += "<span><a id=\""+prefix+"_firstpage\" href=\"#self\" onclick=\"WebClient.Query.SwitchPage(1,'"+prefix+"');\">第一页</a>&nbsp;</span>";
							//htmlstr += "<span><a id=\""+prefix+"_prepage\" href=\"#self\" onclick=\"WebClient.Query.SwitchPage('prepage','"+prefix+"');\">上一页</a>&nbsp;</span";
							
							htmlstr += "<span style=\"width:25px;\"><input id=\""+prefix+"_firstpage\" type=\"button\" class=\"first\" onfocus=\"this.blur();\" onclick=\"WebClient.Query.SwitchPage(1,'"+prefix+"');\" onmouseover=\"this.style.backgroundPosition='left 1px';\" onmouseout=\"this.style.backgroundPosition='left top';\" title=\"首页\" /></span>";
							htmlstr += "<span style=\"width:57px;\"><input id=\""+prefix+"_prepage\" type=\"button\" class=\"pre\" onfocus=\"this.blur();\" onclick=\"WebClient.Query.SwitchPage('prepage','"+prefix+"');\" onmouseover=\"this.style.backgroundPosition='left 1px';\" onmouseout=\"this.style.backgroundPosition='left top';\" title=\"上一页\" /></span>"; 
							htmlstr += "<span style=\"width:110px;\"> 第<select id=\""+prefix+"_turnto\" style=\"width:35px;height:18px;\">"; 
						}
						//htmlstr += "<span><a id=\""+prefix+"_page_"+j+"\" href=\"#self\" onclick=\"WebClient.Query.SwitchPage('"+j+"','"+prefix+"');\">"+( j==1 ? "[" + j + "]" : j )+"</a>&nbsp;</span>";
						
							htmlstr += "<option value=\""+j+"\">"+j+"</option>";
							
						if(j == maxPage)
						{
							htmlstr += "</select>页,共"+ maxPage +"页</span>";
							
							htmlstr += "<span style=\"width:25px;\"><input id=\""+prefix+"_nextpage\" type=\"button\" class=\"next\" onfocus=\"this.blur();\" onclick=\"WebClient.Query.SwitchPage('nextpage','"+prefix+"');\"  onmouseover=\"this.style.backgroundPosition='left 1px';\" onmouseout=\"this.style.backgroundPosition='left top';\"  title=\"下一页\" /></span>";
							htmlstr += "<span style=\"width:25px;\"><input id=\""+prefix+"_lastpage\" type=\"button\" class=\"last\" onfocus=\"this.blur();\" onclick=\"WebClient.Query.SwitchPage('"+maxPage+"','"+prefix+"');\"  onmouseover=\"this.style.backgroundPosition='left 1px';\" onmouseout=\"this.style.backgroundPosition='left top';\"  title=\"末页\" /></span>";
							
							//htmlstr += "<span><a id=\""+prefix+"_nextpage\" href=\"#self\" onclick=\"WebClient.Query.SwitchPage('nextpage','"+prefix+"');\">下一页</a>&nbsp;</span";
							//htmlstr += "<span><a id=\""+prefix+"_lastpage\" href=\"#self\" onclick=\"WebClient.Query.SwitchPage('"+maxPage+"','"+prefix+"');\">未页</a>&nbsp;</span>";
							
						}
					}	
						htmlstr += "</div>"
					
					htmlstr += "</div>"; 
					
					break;
				default:
					break;
			} 
			
			$(objId).innerHTML = htmlstr; //alert(htmlstr); 
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
		  	WebClient.Resource.VideoResource.Init(); // 加载videoScan，初始化VideoResource
	    	WebClient.Resource.QueryResource.Init(); // 加载QueryDownload，初始化QueryResource
			WebClient.Resource.PlatformResource.Init(); // 加载PlatformMgt，初始化PlatformResource
			WebClient.Resource.DeviceResource.Init(); // 加载DeviceMgt，初始化DeviceResource  
		},
	    
		/*
		*	函数名		：VideoResource
		*	函数功能   	：视频浏览资源对象 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.02.21	
		*/
		VideoResource:{
			currentVideoCardID:"videoList",
			
			Init:function(){
				WebClient.Resource.VideoResource.currentVideoCardID = "videoList";
				
				if($("videoResourceBox"))
				{
					var htmlstr = "";
					htmlstr += WebClient.Resource.VideoResource.Html();
					$("videoResourceBox").innerHTML = htmlstr; 
					//alert("init videoresource");
					WebClient.Resource.VideoResource.AttachVResEvent(); //绑定videoCard切换事件
				}
				else
				{
					WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.VideoResource.Init",msg:"初始化VideoResource对象失败！"});	
				}
			},
			
			AttachVResEvent:function(){
				var videoCards = $("videoCardPad").getElementsByTagName("DIV");
				for(var i = 0;i < videoCards.length;i++)
				{
					var videoCard = videoCards[i];
					if(videoCard.webclienttype == "videocard")
					{
						videoCard.style.backgroundColor = "";	
						
						videoCard.onmouseover = function(){
							this.style.backgroundColor = "#E8EAED";						
						}
						videoCard.onmouseout = function(){
							var curVCardID = WebClient.Resource.VideoResource.currentVideoCardID;
							if(curVCardID == this.id) return; 
							this.style.backgroundColor = "";						
						}
						videoCard.onclick = function(){
							WebClient.Resource.VideoResource.SwitchVCard(this.id);	
							if(this.id.search("video") != -1)
							{
								$("logicTree").style.display = "none";
								$("videoTree").style.display = "block"; 
							}
							else if(this.id.search("logic") != -1)
							{
								$("videoTree").style.display = "none";
								$("logicTree").style.display = "block";
							}
						}
					}					
				}	
				
				var curVCardID = WebClient.Resource.VideoResource.currentVideoCardID;
				WebClient.Resource.VideoResource.SwitchVCard(curVCardID); // 默认激活视频列表 
			},
			
			SwitchVCard:function(vCardID){
				var curVCardID = WebClient.Resource.VideoResource.currentVideoCardID; 
				
				$(curVCardID).style.fontWeight = "normal";
				$(curVCardID).style.backgroundColor = "";
				
				$(vCardID).style.fontWeight = "bold";
				$(vCardID).style.backgroundColor = "#E8EAED";  
				
				var titleBarNote = "";
				if(vCardID.toLowerCase().search("logic") != -1)
				{
					titleBarNote = "逻辑分组";
				}
				else
				{
					titleBarNote = "视频列表";
				}
				
				$("videoToolbar2") ? $("videoToolbar2").innerHTML = titleBarNote : "";
				
				WebClient.Resource.VideoResource.currentVideoCardID = vCardID; 
			},
			
			Html:function(){
				var htmlstr = "";
				//video resource tree pad
				htmlstr += "<div id=\"videoTreePad\" class=\"videoTreePad\">";
					//video tree	
					htmlstr += "<div id=\"videoTree\" class=\"resourceTree\">";
						htmlstr += "<img style=\"width:20px;height:20px;\" src=\"images/loading.gif\"/>";
						htmlstr += "<span style=\"white-space:nowrap;\">正在获取资源,请稍候...</span>";
					htmlstr += "</div>";
					//logic tree
					htmlstr += "<div id=\"logicTree\" class=\"resourceTree\" style=\"display:none;\">";
						htmlstr += "<img style=\"width:20px;height:20px;\" src=\"images/loading.gif\"/>";
						htmlstr += "<span>正在获取资源,请稍候...</span>";
					htmlstr += "</div>"; 
				htmlstr += "</div>";
				//video switch card pad
				htmlstr += "<div id=\"videoCardPad\" class=\"videoCardPad\">"; 
					//video list
					htmlstr += "<div id=\"videoList\" class=\"resourceCard\" webclienttype=\"videocard\">";
						htmlstr += "<span class=\"icoVideo\"></span><span title=\"视频列表\">视频列表</span>";
					htmlstr += "</div>";
					//logic group
					htmlstr += "<div id=\"logicGroup\" class=\"resourceCard\" webclienttype=\"videocard\">";
						htmlstr += "<span class=\"icoLogic\"></span><span title=\"逻辑分组\">逻辑分组</span>";
					htmlstr += "</div>"; 
				htmlstr += "</div>";
				
				return htmlstr;
			},
			
			end:true			
		},
		
		/*
		*	函数名		：QueryResource
		*	函数功能   	：查询下载资源对象 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.02.21	
		*/
		QueryResource:{
			queryStyle:"complex", //complex存储文件日期等信息同资源树分开
			currentQueryCardId:"queryPlatform",
			
			Init:function(){
				WebClient.Resource.QueryResource.currentQueryCardID = "queryPlatform";
				
				if($("queryResourceBox"))
				{
					var htmlstr = "";
					htmlstr += WebClient.Resource.QueryResource.Html();
					$("queryResourceBox").innerHTML = htmlstr; 
					//alert("init queryresource");
					WebClient.Resource.QueryResource.AttachQResEvent(); //绑定queryCard切换事件
				}
				else
				{
					WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.QueryResource.Init",msg:"初始化QueryResource对象失败！"});	
				}
			},
			
			
			AttachQResEvent:function(){
				var queryCards = $("queryCardPad").getElementsByTagName("DIV");
				for(var i = 0; i < queryCards.length;i++)
				{
					var queryCard = queryCards[i];
					if(queryCard && queryCard.webclienttype == "querycard")
					{
						queryCard.style.backgroundColor = "";	
						
						queryCard.onmouseover = function(){
							this.style.backgroundColor = "#E8EAED";						
						}
						queryCard.onmouseout = function(){
							var curQCardId = WebClient.Resource.QueryResource.currentQueryCardId; 
							if(curQCardId == this.id) return; 
							this.style.backgroundColor = "#BFDBFF";						
						}
						queryCard.onclick = function(){
							//WebClient.Resource.QueryResource.SwitchQCard(this.id); //暂未实现	 
						}
					}
					
				}//end for
				var curQCardId = WebClient.Resource.QueryResource.currentQueryCardId;
				WebClient.Resource.QueryResource.SwitchQCard(curQCardId); //默认激活平台存储 

			},
			
			SwitchQCard:function(qCardId){
				var curQCardId = WebClient.Resource.QueryResource.currentQueryCardId; 
				
				$(curQCardId).style.fontWeight = "normal";
				$(curQCardId).style.backgroundColor = "";
				
				$(qCardId).style.fontWeight = "bold";
				$(qCardId).style.backgroundColor = "#E8EAED";  
				
				
				WebClient.Resource.QueryResource.currentQueryCardId = qCardId; 
			},
			
			Html:function(){
				var htmlstr = "";
				
				//query tree	
				htmlstr += "<div id=\"queryTree\" class=\"resourceTree\">";
					htmlstr += "<img style=\"width:20px;height:20px;\" src=\"images/loading.gif\"/>";
					htmlstr += "<span>正在获取资源,请稍候...</span>";
				htmlstr += "</div>";
				
				htmlstr += "<div id=\"queryCardPad\" class=\"queryCardPad\">"; 
					htmlstr += "<div id=\"queryPlatform\" class=\"resourceCard\" webclienttype=\"querycard\">";
						htmlstr += "<span class=\"icoPlatform\"></span><span title=\"平台存储\">平台存储</span>";
					htmlstr += "</div>";
					htmlstr += "<div id=\"queryCEFS\" class=\"resourceCard\" webclienttype=\"querycard\">";
						htmlstr += "<span class=\"icoCEFS\"></span><span title=\"前端存储\">前端存储</span>";
					htmlstr += "</div>";
				htmlstr += "</div>";
				
				return htmlstr;
			},
			
			
			end:true 
		},
		
		/*
		*	函数名		：PlatformResource
		*	函数功能   	：平台管理资源对象 
		*	备注			：无 
		*	作者			：huzw
		*	时间			：2011.06.07	
		*/
		PlatformResource:{
			curCSUPuid:"",
			curStorageSelectedNavId:"storageParamSet",
			curStoragePlanList:"",
			curStorageParams: new Object(),
			curSubmitNavId:"",
			curSubmitActive:false, // 提交按钮是否激活











			curStoragePlanCommonInfo: new Hash(), // 查看、修改时存储计划与其资源信息 
			curStoragePlanParamInfo: new Object(), // 提交前临时存储计划部分信息











			curStoragePlanResInfo: new Array(), // 提交前临时存储计划资源信息











			curSroragePlanWeekDate: "sdr-sun", // 周日
			
			refreshFetchPlanFlag: false, // 是否实时刷新获取计划
			 
			Init:function(){
				if($("platformResourceBox"))
				{
					var htmlstr = "";
					htmlstr += WebClient.Resource.PlatformResource.Html();
					$("platformResourceBox").innerHTML = htmlstr; 
					//alert("init platformresource"); 
				}
				else
				{
					WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.PlatformResource.Init",msg:"初始化PlatformResource对象失败！"});	
				}
			},
			
			DisabledControlToolBtn:function(flag){
				flag = flag.toString(); 
				if($("mm_platform_control_pad"))
				{
					var ctltools = $("mm_platform_control_pad").getElementsByTagName("INPUT");
					for(var i = 0; i < ctltools.length; i++)
					{
						var ctlt = ctltools[i];
						if(ctlt && ctlt.menutype == "button-tool")
						{
							ctlt.disabled = true; 
							if(ctlt.id.search("_submit") != -1)
							{
								ctlt.style.backgroundImage = "url(images/blue/platform-mgt-submit-disabled.jpg)";
							}
							else
							{
								ctlt.style.backgroundImage = "url(images/blue/platform-mgt-toolbar-disabled.jpg)";
							}
							
						}
					}
					 
					switch(flag.toLowerCase())
					{
						case "1": // scan/add/modify/delete
							for(var j = 0; j < ctltools.length; j++)
							{
								var ctlt = ctltools[j];
								if(ctlt && ctlt.menutype == "button-tool")
								{ 
									if(ctlt.id.search("_submit") == -1)
									{
										ctlt.disabled = false; 
										ctlt.style.backgroundImage = "url(images/blue/platform-mgt-toolbar.jpg)";
									} 
								}
							} 
							break;
						case "2": // scan/submit 
							$("mm_platform_tool_scan").style.backgroundImage = "url(images/blue/platform-mgt-toolbar.jpg)";
							$("mm_platform_tool_scan").disabled = false;
							$("mm_platform_tool_submit").style.backgroundImage = "url(images/blue/platform-mgt-submit.jpg)";
							$("mm_platform_tool_submit").disabled = false; 
							break;
						case "3": // add  
							$("mm_platform_tool_add").style.backgroundImage = "url(images/blue/platform-mgt-toolbar.jpg)";
							$("mm_platform_tool_add").disabled = false; 
							break;
						case "4": // modify 
							$("mm_platform_tool_modify").style.backgroundImage = "url(images/blue/platform-mgt-toolbar.jpg)";
							$("mm_platform_tool_modify").disabled = false; 
							break;
						case "5": // submit 
							$("mm_platform_tool_submit").style.backgroundImage = "url(images/blue/platform-mgt-submit.jpg)";
							$("mm_platform_tool_submit").disabled = false;  
							break;
						default: 
							break; 
					}
					
				} 
				
			},
			
			Control:function(flag){
				if(!flag || typeof flag == "undefined")
				{
					return false;
				}
				
				switch(flag.toLowerCase())
				{
					case "scan": 
						this.Scan(); // 查看
						break;
					case "add": 
						this.Add(); // 添加
						break;
					case "modify": 
						this.Modify(); // 修改
						break;
					case "delete": 
						this.Delete(); // 删除
						break;
					case "submit": 
						this.Submit(); // 提交
						break;
					default: 
						break; 
				}
				
			},
			
			// 查看
			Scan:function()
			{
				var curSSNavId = WebClient.Resource.PlatformResource.curStorageSelectedNavId; // alert(curSSNavId);
				 
				switch(curSSNavId)
				{ 	 
					case "storagePlanSet": 
						var cursplist = WebClient.Resource.PlatformResource.curStoragePlanList; // alert(cursplist);
						
						var planName = "";
						if(cursplist && $(cursplist) && $(cursplist).planname)
						{
							planName = $(cursplist).planname; // alert(planName);
						}
						else
						{
							alert("存储计划名称未知！");
							return false;
						} 
						
						this.PlatformStorageMgt_Show("scan", planName); // 存储管理界面显示
						
						break;	
						 
					default: return false;
						break;
				}
				
				WebClient.Resource.PlatformResource.curSubmitActive = true;
				WebClient.Resource.PlatformResource.DisabledControlToolBtn(4); //control-tool	 
			},
			
			// 添加
			Add:function()
			{
				var curSSNavId = WebClient.Resource.PlatformResource.curStorageSelectedNavId; // alert(curSSNavId);
				 
				switch(curSSNavId)
				{ 	 
					case "storagePlanSet": 
						var cursplist = WebClient.Resource.PlatformResource.curStoragePlanList; // alert(cursplist);
						 	
						this.PlatformStorageMgt_Show("add"); // 存储管理界面显示
						
						break;	
						 
					default: return false;
						break;
				}
				
				WebClient.Resource.PlatformResource.curSubmitActive = true;
				WebClient.Resource.PlatformResource.DisabledControlToolBtn(5); //control-tool	 
			},
			
			// 修改
			Modify:function()
			{
				var curSSNavId = WebClient.Resource.PlatformResource.curStorageSelectedNavId; // alert(curSSNavId);
				 
				switch(curSSNavId)
				{ 	 
					case "storagePlanSet": 
						var cursplist = WebClient.Resource.PlatformResource.curStoragePlanList; // alert(cursplist);
						
						var planName = "";
						if(cursplist && $(cursplist) && $(cursplist).planname)
						{
							planName = $(cursplist).planname; // alert(planName);
						}
						else
						{
							alert("存储计划名称未知！");
							return false;
						} 
						
						this.PlatformStorageMgt_Show("scan", planName); // 存储管理界面显示
						this.PlatformStorageMgt_Show("modify", planName); // 存储管理界面显示
						break;	
						 
					default: return false;
						break;
				} 
				
				WebClient.Resource.PlatformResource.curSubmitActive = true;
				WebClient.Resource.PlatformResource.DisabledControlToolBtn(2); //control-tool	 
			}, 
			
			// 删除
			Delete:function(){
				var curSSNavId = WebClient.Resource.PlatformResource.curStorageSelectedNavId; // alert(curSSNavId);
				 
				switch(curSSNavId)
				{ 	 
					case "storagePlanSet": 
						var cursplist = WebClient.Resource.PlatformResource.curStoragePlanList; // alert(cursplist);
						
						var planName = "";
						if(cursplist && $(cursplist) && $(cursplist).planname)
						{
							planName = $(cursplist).planname; // alert(planName);
						}
						else
						{
							alert("存储计划名称未知！");
							return false;
						}
						  
						if(confirm("您确定要删除存储计划["+planName+"] 吗?"))
						{
							// 删除存储计划
							var rvDelPlan = Nrcap2.PlatformStorage.DelPlan(WebClient.connectId, WebClient.Resource.PlatformResource.curCSUPuid, planName);
							
							if(parseInt(rvDelPlan) == 0)
							{
								alert("删除存储计划["+planName+"] 成功！");
							}
							else
							{
								alert("删除存储计划["+planName+"] 失败！");
							} 
							
							window.setTimeout(
								function(){
									// 刷新存储计划列表
									WebClient.Resource.PlatformResource.RefreshPlatformStoragePlanList(); 
								},50			  
							); 
						}  
						
						break;	
						 
					default: return false;
						break;
				}
			},
			
			// 提交
			Submit:function(){  
				var curSNavId = WebClient.Resource.PlatformResource.curSubmitNavId;  //  alert(curSNavId);
				
				switch(curSNavId)
				{
					case "storageParamSet":
						// alert(Object.toJSON(WebClient.Resource.PlatformResource.curStorageParams));
						var cursparams = WebClient.Resource.PlatformResource.curStorageParams;
						var total_count = 0, succ_count = 0, err_count = 0, flag = 0, details = [], rvstr = "";
						if($("diskfull-overwrite"))
						{
						    // 磁盘满时是否覆盖旧文件.
							if($("diskfull-overwrite").checked != cursparams["diskfull-overwrite"]) 	
							{
								total_count++; 
								
								rvstr = Nrcap2.Config.SetSimple(WebClient.connectId, WebClient.Resource.PlatformResource.curCSUPuid, Nrcap2.Enum.PuResourceType.SC, 0, "CFG_SC_CoverOldRecordFile", "", $("diskfull-overwrite").checked ? 1 : 0);
								if(parseInt(rvstr) == 0) 
								{
									succ_count++; flag = 0;	
									cursparams["diskfull-overwrite"] = $("diskfull-overwrite").checked;
								}
								else {err_count++; flag = -1;}
								
								details.push({flag:flag, detail:"设置磁盘满时是否覆盖旧文件"});
							}
						}
						
						if($("recordfile-savedays"))
						{
							// 录像文件保留天数 
							if($("recordfile-savedays").value.toString().strip() != cursparams["recordfile-savedays"]) 	
							{
								total_count++; 
								
								rvstr = Nrcap2.Config.SetSimple(WebClient.connectId, WebClient.Resource.PlatformResource.curCSUPuid, Nrcap2.Enum.PuResourceType.SC, 0, "CFG_SC_RecordFileReserveDays", "",$("recordfile-savedays").value.toString().strip()); 
								if(parseInt(rvstr) == 0) 
								{
									succ_count++; flag = 0;	
									cursparams["recordfile-savedays"] = $("recordfile-savedays").value.toString().strip();
								}
								else {err_count++; flag = -1;}
								
								details.push({flag:flag, detail:"设置录像文件保留天数"});
							}
						}
						
						if($("recordfile-time"))
						{
							// 录像时间 
							if($("recordfile-time").value.toString().strip() != cursparams["recordfile-time"]) 	
							{
								total_count++; 
								
								var value = parseInt($("recordfile-time").value.toString().strip()) * 60;
								if(value <= 60 || value >= 1800) value = 15 * 60;
								rvstr = Nrcap2.Config.SetSimple(WebClient.connectId, WebClient.Resource.PlatformResource.curCSUPuid, Nrcap2.Enum.PuResourceType.SC, 0, "CFG_SC_RecordTimeSpan", "", value); 	
								if(parseInt(rvstr) == 0) 
								{
									succ_count++; flag = 0;	
									cursparams["recordfile-time"] = Math.round(value / 60);
								}
								else {err_count++; flag = -1;}
								
								details.push({flag:flag, detail:"设置录像时间"});				 
							}
						}
						
						if($("snapshotimage-savedays"))
						{
							// 抓拍图片保留天数 
							if($("snapshotimage-savedays").value.toString().strip() != cursparams["snapshotimage-savedays"]) 	
							{
								total_count++;
								
								rvstr = Nrcap2.Config.SetSimple(WebClient.connectId, WebClient.Resource.PlatformResource.curCSUPuid, Nrcap2.Enum.PuResourceType.SC, 0, "CFG_SC_SnapshotReserveDays", "", $("snapshotimage-savedays").value.toString().strip()); 	
								if(parseInt(rvstr) == 0) 
								{
									succ_count++; flag = 0;	
									cursparams["snapshotimage-savedays"] = $("snapshotimage-savedays").value.toString().strip();
								}
								else {err_count++; flag = -1;}
								
								details.push({flag:flag, detail:"设置抓拍图片保留天数"});				 
							}
						}
						
						if($("save-gpsdata"))
						{
							// 使能GPS数据存储
							if($("save-gpsdata").checked != cursparams["save-gpsdata"]) 	
							{
								total_count++; 
								
								rvstr = Nrcap2.Config.SetSimple(WebClient.connectId, WebClient.Resource.PlatformResource.curCSUPuid, Nrcap2.Enum.PuResourceType.SC, 0, "CFG_SC_EnableGPSDataStorage", "", $("save-gpsdata").checked ? 1 : 0); 	
								if(parseInt(rvstr) == 0) 
								{
									succ_count++; flag = 0;	
									cursparams["save-gpsdata"] = $("save-gpsdata").checked;
								}
								else {err_count++; flag = -1;}
								
								details.push({flag:flag, detail:"设置使能GPS数据存储"});				 
							}
						}
						
						if($("gpsdata-savedays"))
						{
							// GPS数据保留天数 
							if($("gpsdata-savedays").value.toString().strip() != cursparams["gpsdata-savedays"]) 	
							{
								total_count++; 
								
								rvstr = Nrcap2.Config.SetSimple(WebClient.connectId, WebClient.Resource.PlatformResource.curCSUPuid, Nrcap2.Enum.PuResourceType.SC, 0, "CFG_SC_GPSReserveDays", "", $("gpsdata-savedays").value.toString().strip()); 	
								if(parseInt(rvstr) == 0) 
								{
									succ_count++; flag = 0;	
									cursparams["gpsdata-savedays"] = $("gpsdata-savedays").value.toString().strip();
								}
								else {err_count++; flag = -1;}
								
								details.push({flag:flag, detail:"设置GPS数据保留天数"});				 
							}
						}
						
						if(total_count != 0)
						{
							var alertstr = "修改存储属性配置完成，成功"+succ_count+"项，失败"+err_count+"项";
							details.each
							(
								function(item)
								{
									alertstr += "\r\n" + item.detail + " " + (item.flag == 0 ? "成功" : "失败");
								}
							);
							
							alert(alertstr); 
						}
					 
						WebClient.Resource.PlatformResource.curSubmitActive = false;
						WebClient.Resource.PlatformResource.DisabledControlToolBtn(0); //control-tool	 
						
						break;
						
					case "storagePlanSet":
						
						break;	
					
					case "storageMgtBox": // alert(1);
						if($("storageMgt-planName") && $F("storageMgt-planName").strip())
						{
							var planName = $F("storageMgt-planName");
						}
						else
						{
							alert("存储计划名称不能为空！"); return false;
						} //alert(2);
						
						if($("storageMgt-guard"))
						{
							guard = $("storageMgt-guard").checked ? "1" : "0";
						}
						else
						{
							guard = "1";	
						}
									
						if($("storageMgt-planModel"))
						{
							var planModel = $("storageMgt-planModel").options[$("storageMgt-planModel").selectedIndex].value; 
							
							var curspinfo = WebClient.Resource.PlatformResource.curStoragePlanParamInfo;  // 资源信息
							
							switch(planModel.toLowerCase())
							{
								case "pm-everyday": 
									var cycle = "Everyday", cycleParam = "";
									curspinfo["param"] = {flag:0,map:""};  
									
									var hex_curspwdate_map = WebClient.GuardTimeMap.GetHexMapStr("storageMgt-guardtimemap-box", "min"); // alert(hex_curspwdate_map);
									// if(hex_curspwdate_map == false) return false; 
									
									var guardTimeMap = hex_curspwdate_map;
									 
								 	curspinfo["param"] = {flag:(parseInt(hex_curspwdate_map, 16) != 0 ? 1 : 0),map:guardTimeMap}; 
									
									break; 
								case "pm-week":   
									var cycle = "Weekly"; 
									
									var curspwdate = WebClient.Resource.PlatformResource.curSroragePlanWeekDate; // 当前每周的星期











									if(curspwdate && $(curspwdate)) $(curspwdate).onclick(); // 响应一次周map
									 
									var params = curspinfo["param"]; // alert(Object.toJSON(params));
									
									var weeks = ['sdr-sun', 'sdr-mon', 'sdr-tue', 'sdr-wed', 'sdr-thu', 'sdr-fri', 'sdr-sat'];
									var tmp = "", cycleParam = "", guardTimeMap = "";
									
									weeks.each
									(
									 	function(item)
										{
											var node = params.get(item);
											if(node && parseInt(node.flag) == 1)
											{
												tmp += "1";
												guardTimeMap += node.map; // 布防时间字符串











											}
											else
											{
												tmp += "0";
											} 
										}
									);
									
									for(var i = tmp.length - 1; i >= 0; i--)
									{
										var splitstr = tmp.charAt(i);
										cycleParam += splitstr; // 反转字符串











									}
									
									cycleParam = parseInt(cycleParam, 2); // 转换成十进制
									
									// alert("storage-plan>>>" + cycleParam + ":::::" + guardTimeMap);
									break;
								case "pm-once": 
									var cycle = "Once", cycleParam = ""; 
									curspinfo["param"] = {flag:0,map:"",time:""};  
									
									if($("storageMgt-once-date") && $F("storageMgt-once-date").strip() != "")
									{
									    var pm_once_date = $F("storageMgt-once-date").strip();	
										// toUTCTimeStr
										cycleParam = new Date(pm_once_date.replace(/-/g,"/")).getTime()/1000;
									} 
									else
									{
										alert("一次性存储计划的日期不能为空!");
									}
									
									var hex_curspwdate_map = WebClient.GuardTimeMap.GetHexMapStr("storageMgt-guardtimemap-box", "min"); // alert(hex_curspwdate_map);
									// if(hex_curspwdate_map == false) return false; 
									
									var guardTimeMap = hex_curspwdate_map;
									 
								 	curspinfo["param"] = {flag:(parseInt(hex_curspwdate_map, 16) != 0 ? 1 : 0),map:guardTimeMap,time:cycleParam}; 
									 
									break;
								default: break;  
							}
						}
						// alert(3);
						var username = WebClient.loginDefaultParams.username;
						var password = WebClient.loginDefaultParams.password;
						
						var storagePlanStruct = new Nrcap2.Struct.PlatformStoragePlanStruct(planName, guard, cycle, cycleParam, guardTimeMap, username, password); // 要符合平台存储计划结构 
						
						// alert(Object.toJSON(storagePlanStruct));
						
						var rvSetPlan = Nrcap2.PlatformStorage.SetPlan(WebClient.connectId, WebClient.Resource.PlatformResource.curCSUPuid, storagePlanStruct);
						if(parseInt(rvSetPlan) == 0)
						{
							// 添加资源到此存储计划中 

							// WebClient.Resource.PlatformResource.refreshFetchPlanFlag = true;
							var curspcinfo = WebClient.Resource.PlatformResource.curStoragePlanCommonInfo; // storage plan & res info 
							if(curspcinfo.get(storagePlanStruct.name))
							{
								curspcinfo.get(storagePlanStruct.name).planParam = storagePlanStruct; // info
								// curspcinfo.get(storagePlanStruct.name).planResource = storagePlanResStruct; // res
							}
							// alert(Object.toJSON(curspcinfo));
							
							alert("存储计划设置成功！");
							window.setTimeout
							(
							 	function()
								{
									if($("storageMgt")) $("storageMgt").style.display = "none";
									if($("storageMgtBox")) $("storageMgtBox").style.display = "none";
									
									if($("storageParamSet")) $("storageParamSet").style.display = "block";  
									if($("storagePlanSet")) $("storagePlanSet").style.display = "block"; 
								
									WebClient.Resource.PlatformResource.PlatformStorageChangeNav("storageParamSet");
									WebClient.Resource.PlatformResource.PlatformStorageChangeNav("storagePlanSet");
									WebClient.Resource.PlatformResource.RefreshPlatformStoragePlanList(); // 刷新存储计划列表	
								},50
							);
							
						}
						else
						{
							alert("存储计划设置失败！");	
						}
						
						break;
					default: alert("存储计划类型不能为空！"); return false;
						break;
				}
				
			},
			
			SwitchPRes:function(platformMenuId){
				var resource = WebClient.Resource.resource;
				// alert(Object.toJSON(resource));
				
				var htmlstr = "";
				
				switch(platformMenuId.toLowerCase())
				{
					case "mm_platform_storage":
						resource.each
						(
						 	function(item)
							{
								var node = item.value;
								if(node.modelType == Nrcap2.Enum.PuModelType.CSU)
								{
									var prefix = "storageUnit", suffix = "_disabled";
									if(node.online == "1" && node.enable == "1")
									{
										suffix = "";
									}
									
									var icocls = prefix + "" + suffix;
									
									htmlstr += "<input type=\"button\" id=\"platformCSU_img_title\" class=\"plus\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.PlatformResource.FetchPChildRes('puid','"+node.puid+"');\" /><input type=\"button\" id=\"platformCSU_img_ico\" class=\""+icocls+"\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.PlatformResource.FetchPChildRes('puid','"+node.puid+"');\" /><a href=\"#self\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.PlatformResource.FetchPChildRes('puid','"+node.puid+"');\" >"+node.name+"</a>";  
									htmlstr += "<div id=\"platformCSU_childresourcebox\" class=\"childresourcebox_blankline\" style=\"display:none;padding-left:15px;border:0px solid red;\">";
					
								}
							}
						);
						if(htmlstr == "") htmlstr = "<span style=\"font-style:italic;\" >[该用户无权进行存储管理]</span>";
						break;
					default:
						break;
				}
				
				if($("platform_cesSystemManagement_childresourcebox"))
				{
					$("platform_cesSystemManagement_childresourcebox").innerHTML = htmlstr;
					$("platform_cesSystemManagement_childresourcebox").style.display = "block";
				}
				
				if($("platform_cesSystemManagement_img_title_container"))
				{ 
					$("platform_cesSystemManagement_img_title_container").innerHTML = "<span type=\"button\" id=\"platform_cesSystemManagement_img_title\" class=\"minus\" style=\"float:left;width:16px;height:16px;display:block;\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.Expandsion($('platform_cesSystemManagement_childresourcebox'),$('platform_cesSystemManagement_img_title'));\" ></span>"; 
				}
				
			},
			
			FetchPChildRes:function(type,flag){
				if(!type || typeof type == "undefined") return false;
				
				var htmlstr = "";
				
				switch(type)
				{
					case 'puid':
						if(!flag || typeof flag == "undefined") return false;
						
						var puResourcesInfos = Nrcap2.FetchResource(WebClient.connectId,Nrcap2.Enum.FetchResourceLevel.Nrcap2_GetPUResourceInfo,0,4294967295,"",{PUID:flag});
						
						var lastnode = "";
						
						if(puResourcesInfos.length > 0)
						{
							WebClient.Resource.resource.get(flag).childResource = puResourcesInfos; //保存pu子资源 
							//  alert(Object.toJSON(puResourcesInfos));
							puResourcesInfos.each
							(
							 	function(item)
								{
									var node = item; 
									if(node.type == Nrcap2.Enum.PuResourceType.SC)
									{ 
										var prefix = "storager", suffix = "_disabled";
										var res = WebClient.Resource.resource.get(flag);
										if(res.online == "1" && res.enable == "1" && node.enable == "1")
										{
											suffix = "";
										}
										
										var icocls = prefix + "" + suffix;
									
										htmlstr += "<input type=\"button\" id=\"platformCSU_"+flag+"_"+node.idx+"_img_title\" class=\"outline\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.PlatformResource.MainRegionInit('platform-storage','"+flag+"');\" /><input type=\"button\" id=\"platformCSU_"+flag+"_"+node.idx+"_img_ico\" class=\""+icocls+"\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.PlatformResource.MainRegionInit('platform-storage','"+flag+"');\" /><a href=\"#self\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.PlatformResource.MainRegionInit('platform-storage','"+flag+"');\" >"+node.name+"</a>";  
										htmlstr += "<div id=\"platformCSU_"+flag+"_"+node.idx+"_childresourcebox\" class=\"childresourcebox_blankline\" style=\"display:block;padding-left:15px;border:0px solid red;\">";
										
										lastnode = "platformCSU_"+flag+"_"+node.idx+"_img_title";
									}
									
								}
							); 
						} 
						
						htmlstr = htmlstr.replace("id=\""+lastnode+"\" class=\"outline\"","id=\""+lastnode+"\" class=\"endline\"");
						
						if(htmlstr == "") htmlstr = "<span style=\"font-style:italic;\" >[中心存储单元下无存储器]</span>";
						 
						if($("platformCSU_childresourcebox"))
						{
							$("platformCSU_childresourcebox").innerHTML = htmlstr;
						}
						
						WebClient.Resource.Expandsion($('platformCSU_childresourcebox'),$('platformCSU_img_title'));
						
						break;
					default:
						break;
				}
			},
			
			MainRegionInit:function(platformMenuId, csuPuid){ 
				WebClient.Resource.PlatformResource.curSubmitActive = false;
				WebClient.Resource.PlatformResource.DisabledControlToolBtn(0); //control-tool
				
				var htmlstr = "";
				switch(platformMenuId.toLowerCase())
				{
					case 'platform-storage':
						// 当前使用的存储中心PUID
						WebClient.Resource.PlatformResource.curCSUPuid = csuPuid;   
					 
						WebClient.Resource.PlatformResource.curStorageParams = {
							"diskfull-overwrite" 		: 	false,
							"recordfile-savedays" 		: 	"30",
							"recordfile-time" 			: 	"15",
							"snapshotimage-savedays"	:	"30",
							"save-gpsdata"				:	false,
							"gpsdata-savedays" 			:	"30" 
						};
						
						WebClient.Resource.PlatformResource.curStoragePlanParamInfo = {
							"planModel"	: "",
							"param": new Object() 
						}; 
						
						htmlstr += "<div id=\"storagePlanTitle\" class=\"platformMgt-title\">";  
							htmlstr += "<div id=\"storageParamSet\" type=\"storage-nav\" class=\"nav-mousedown\">存储参数设置</div>"; 							htmlstr += "<div id=\"storagePlanSet\" type=\"storage-nav\" class=\"nav-mouseout\">存储计划管理</div>";  							htmlstr += "<div id=\"storageMgt\" type=\"storage-nav-other\" class=\"nav-mousedown\" style=\"display:none;\" >存储管理</div>";   
							
						htmlstr += "</div>"; 
						htmlstr += "<div id=\"storagePlanPad\" class=\"platformMgt-body\">"; 
							/* 存储参数设置 */
							htmlstr += "<div id=\"storageParamSetBox\" class=\"box\" style=\"display:block;\">"; 
								htmlstr += "<div>";
									htmlstr += "<div style=\"margin-top:10px !important;color:#15428B;\"><fieldset style=\"width:310px;height:110px;\">";
										htmlstr += "<legend >录像设置</legend>";
										htmlstr += "<div><table style=\"width:290px;height:95px;margin-left:16px;\" cellspacing=\"0\" cellpadding=\"0\">";
											htmlstr += "<tr><td><input id=\"diskfull-overwrite\" type=\"checkbox\" checked/><label for=\"diskfull-overwrite\" style=\"color:#000000;\">磁盘满时覆盖旧文件</label></td><td ></td></tr>";
										
											htmlstr += "<tr><td style=\"padding-left:3px;\"><label>录像文件保存天数：</label></td><td align=\"left\" ><input id=\"recordfile-savedays\" type=\"text\" value=\"30\" style=\"width:135px;height:16px;\" /></td></tr>";
											
											htmlstr += "<tr><td style=\"padding-left:3px;\"><label>录像文件时间：</label></td><td align=\"left\" ><input id=\"recordfile-time\" type=\"text\" value=\"15\" style=\"width:135px;height:16px;\" />&nbsp;分</td></tr>";
										htmlstr += "</table></div>";
									htmlstr += "</fieldset></div>";
									
									htmlstr += "<div style=\"margin-top:10px !important;color:#15428B;\"><fieldset style=\"width:310px;height:55px;\">";
										htmlstr += "<legend >抓图设置</legend>";
										htmlstr += "<div><table style=\"width:290px;height:45px;margin-left:16px;\" cellspacing=\"0\" cellpadding=\"0\">";
											htmlstr += "<tr><td style=\"padding-left:3px;border:0px solid red;\"><label>抓拍图片保存天数：</label></td><td align=\"left\" ><input id=\"snapshotimage-savedays\" type=\"text\" value=\"30\" style=\"width:135px;height:16px;\" /></td></tr>";
										 
										htmlstr += "</table></div>";
									htmlstr += "</fieldset></div>";
									
									htmlstr += "<div style=\"margin-top:10px !important;color:#15428B;\"><fieldset style=\"width:310px;height:70px;\">";
										htmlstr += "<legend >GPS设置</legend>";
										htmlstr += "<div><table style=\"width:290px;height:45px;margin-left:16px;\" cellspacing=\"0\" cellpadding=\"0\">";
											htmlstr += "<tr><td><input id=\"save-gpsdata\" type=\"checkbox\" checked/><label for=\"save-gpsdata\" style=\"color:#000000;\">存储GPS数据</label></td><td></td></tr>";
										
											htmlstr += "<tr><td style=\"padding-left:3px;border:0px solid red;\"><label>GPS数据保存天数：</label></td><td align=\"left\" >&nbsp;<input id=\"gpsdata-savedays\" type=\"text\" value=\"30\" style=\"width:135px;height:16px;\" /></td></tr>";
										 
										htmlstr += "</table></div>";
									htmlstr += "</fieldset></div>";
									
								htmlstr += "</div>";
							htmlstr += "</div>"; 
							/* 存储计划管理 */ 
							htmlstr += "<div id=\"storagePlanSetBox\" class=\"box\" style=\"display:none;\">"; 
							  htmlstr += "<div style=\"margin-top:10px !important;color:#15428B;\"><fieldset style=\"width:450px;height:520px;\">";
									htmlstr += "<div id=\"\" class=\"list\">";
										//header
										htmlstr += "<div id=\"storagePlanListBox_title\" class=\"divth\" style=\"width:449px;border-left:0px gray solid;border-right:0px gray solid;\">";
											htmlstr += "<div class=\"divthtd\" style=\"width:130px;\">存储计划名称</div>"; 
											htmlstr += "<div class=\"divthtd\" style=\"width:110px;\">报警状态</div>"; 
											htmlstr += "<div class=\"divthtd\" style=\"width:110px;\">存储计划类型</div>";   
										htmlstr += "</div>";
										//list
										htmlstr += "<div id=\"storagePlanListBox\" class=\"list-box\">";
											htmlstr += "<div id=\"\" class=\"divtr\" style=\"width:449px;border-left:0px gray solid;border-right:0px gray solid; border-bottom:1px #ffffff solid;\">";
												htmlstr += "<div class=\"divtrtd\" style=\"width:16px;border-right:1px #ffffff solid;\"></div>"; 
												htmlstr += "<div class=\"divtrtd\" style=\"width:113px;border-right:1px #ffffff solid;\"></div>"; 
												htmlstr += "<div class=\"divtrtd\" style=\"width:110px;border-right:1px #ffffff solid;\"></div>"; 
												htmlstr += "<div class=\"divtrtd\" style=\"width:110px;border-right:1px #ffffff solid;\"></div>";   
											htmlstr += "</div>";
										htmlstr += "</div>";
										
									htmlstr += "</div>";	
								htmlstr += "</fieldset></div>";
							htmlstr += "</div>"; 
							// 存储管理
							htmlstr += "<div id=\"storageMgtBox\" class=\"box\" style=\"display:none;\">";
								// 基本信息
								htmlstr += "<div id=\"storageMgtLeftPad\" class=\"pad-left\" >";
									htmlstr += "<div><fieldset style=\"width:260px;height:350px;\">";
										htmlstr += "<legend>基本信息</legend>";	
										
										htmlstr += "<div><table class=\"pad-left-table\" cellspacing=\"0\" cellpadding=\"0\" >";
											htmlstr += "<tr>";
												htmlstr += "<td><label>存储计划名称：</label></td>";
												htmlstr += "<td><input id=\"storageMgt-planName\" type=\"text\" style=\"width:120px;height:16px;\" /></td>"; 
											htmlstr += "</tr>";
											htmlstr += "<tr>";
												htmlstr += "<td><label>存储计划类型：</label></td>";
												htmlstr += "<td>";
													htmlstr += "<select id=\"storageMgt-planModel\" style=\"width:126px;height:22px;\" >";
														htmlstr += "<option value=\"pm-everyday\" selected>每天</option>";
														htmlstr += "<option value=\"pm-week\">每周</option>";
														htmlstr += "<option value=\"pm-once\">一次性</option>";
													htmlstr += "</select>";
												htmlstr += "</td>"; 
											htmlstr += "</tr>";
											htmlstr += "<tr>";
												htmlstr += "<td><input type=\"checkbox\" name=\"storageMgt-guard\" id=\"storageMgt-guard\" checked /><label for=\"storageMgt-guard\">布防</label></td><td>&nbsp;</td>";  
											htmlstr += "</tr>";
											
										htmlstr += "</table></div>";
									htmlstr += "</fieldset></div>";
								htmlstr += "</div>";
								// 时间信息
								htmlstr += "<div id=\"storageMgtRightPad\" class=\"pad-right\" >";
									htmlstr += "<div><fieldset style=\"width:438px;height:350px;\">";
										htmlstr += "<legend>时间信息</legend>";		
										
										htmlstr += "<div><table class=\"pad-right-table\" cellspacing=\"0\" cellpadding=\"0\" >";
											htmlstr += "<tr>";
												htmlstr += "<td>";
												
													htmlstr += "<label>一次性存储计划的日期：</label>";
													htmlstr += "&nbsp;&nbsp;&nbsp;<input id=\"storageMgt-once-date\" disabled type=\"text\" style=\"width:120px;height:16px;\" value=\""+new Date().format("yyyy-MM-dd")+"\" onfocus=\" WdatePicker({el:'storageMgt-once-date', dateFmt:'yyyy-MM-dd', onpicked:function(){}});\"/>&nbsp;<img id=\"storageMgt-once-date-img\" disabled src=\"images/calender.png\" onClick=\"WdatePicker({el:'storageMgt-once-date',dateFmt:'yyyy-MM-dd', onpicked:function(){}})\" align=\"absmiddle\" style=\"width:20px;height:18px;cursor:pointer;\" /></span>";
												htmlstr += "</td>"; 
											htmlstr += "</tr>";
											htmlstr += "<tr>";
												htmlstr += "<td id=\"storageMgt-week-box\" disabled>";
													htmlstr += "<input type=\"radio\" name=\"storage-date-radio\" id=\"sdr-sun\" checked /><label for=\"sdr-sun\">周日</label>&nbsp;"; 
													htmlstr += "<input type=\"radio\" name=\"storage-date-radio\" id=\"sdr-mon\" /><label for=\"sdr-mon\">周一</label>&nbsp;"; 
													htmlstr += "<input type=\"radio\" name=\"storage-date-radio\" id=\"sdr-tue\" /><label for=\"sdr-tue\">周二</label>&nbsp;"; 
													htmlstr += "<input type=\"radio\" name=\"storage-date-radio\" id=\"sdr-wed\" /><label for=\"sdr-wed\">周三</label>&nbsp;"; 
													htmlstr += "<input type=\"radio\" name=\"storage-date-radio\" id=\"sdr-thu\" /><label for=\"sdr-thu\">周四</label>&nbsp;"; 
													htmlstr += "<input type=\"radio\" name=\"storage-date-radio\" id=\"sdr-fri\" /><label for=\"sdr-fri\">周五</label>&nbsp;"; 
													htmlstr += "<input type=\"radio\" name=\"storage-date-radio\" id=\"sdr-sat\" /><label for=\"sdr-sat\">周六</label>&nbsp;";  
												htmlstr += "</td><td></td>"; 
											htmlstr += "</tr>";
											htmlstr += "<tr>";	
												htmlstr += "<td ><div id=\"storageMgt-guardtimemap-box\" class=\"gt-map\"></div><div>(绿色表示选中的时间段，白色表示没有选中的时间)</div></td><td></td>";  
											htmlstr += "</tr>";  
										htmlstr += "</table></div>"; 
									htmlstr += "</fieldset></div>";
								htmlstr += "</div>";
								// 录像抓拍
								htmlstr += "<div id=\"storageMgtBottomPad\" class=\"pad-bottom\" >";
									htmlstr += "<div><fieldset style=\"width:715px;height:205px;\">";
										htmlstr += "<legend><input type=\"radio\" name=\"storage-radio\" id=\"record-storage-radio\" checked /><label for=\"record-storage-radio\">录像</label><input type=\"radio\" name=\"storage-radio\" id=\"snapshot-storage-radio\" /><label for=\"snapshot-storage-radio\">抓拍</label></legend>";			
										
										//header
										htmlstr += "<div id=\"storageMgt-resource-title\" class=\"divth\" style=\"width:700px; margin-left:8px;border-left:0px gray solid;border-right:0px gray solid;\">";
											htmlstr += "<div class=\"divthtd\" style=\"width:80px;\">&nbsp;</div>";
											htmlstr += "<div class=\"divthtd\" style=\"width:200px;\">资源名称</div>"; 
											htmlstr += "<div class=\"divthtd\" style=\"width:100px;\">流类型</div>"; 
											htmlstr += "<div class=\"divthtd\" style=\"width:110px;\">流传输模式</div>";   
											htmlstr += "<div class=\"divthtd\" style=\"width:110px;\">预置位编号</div>";   
										htmlstr += "</div>";
										//list
										htmlstr += "<div id=\"storageMgt-resource-box\" class=\"list-box\" style=\"\">";
											 htmlstr += "<div id=\"\" class=\"divtr\" style=\"width:700px; margin-left:8px;border-left:0px gray solid;border-right:0px gray solid; border-bottom:1px #ffffff solid;\">";
												htmlstr += "<div class=\"divtrtd\" style=\"width:16px;border-right:1px #ffffff solid;\"></div>"; 
												htmlstr += "<div class=\"divtrtd\" style=\"width:63px;border-right:1px #ffffff solid;\"></div>"; 								
												htmlstr += "<div class=\"divtrtd\" style=\"width:200px;border-right:1px #ffffff solid;\"></div>"; 												
												htmlstr += "<div class=\"divtrtd\" style=\"width:100px;border-right:1px #ffffff solid;\"></div>"; 
												htmlstr += "<div class=\"divtrtd\" style=\"width:110px;border-right:1px #ffffff solid;\"></div>"; 
												htmlstr += "<div class=\"divtrtd\" style=\"width:110px;border-right:1px #ffffff solid;\"></div>";   
											htmlstr += "</div>";
										htmlstr += "</div>"; 
										
									htmlstr += "</fieldset></div>";
								htmlstr += "</div>";
								
							htmlstr += "</div>";
							
						htmlstr += "</div>"; 
						
						WebClient.Resource.PlatformResource.curStorageSelectedNavId = "storageParamSet";
						WebClient.Resource.PlatformResource.curStoragePlanList = "";
						WebClient.Resource.PlatformResource.curSubmitNavId = "storageParamSet";
						
						break;
					default:
						break;
				}
				
				if($("platformMainRegion")) $("platformMainRegion").innerHTML = htmlstr; 
				
				WebClient.GuardTimeMap.Create("storageMgt-guardtimemap-box", "min"); // 创建布防图 
				
				window.setTimeout
				(
					function()
					{
						WebClient.Resource.PlatformResource.AttachPlatformMgtEvent(); 
						
						WebClient.Resource.PlatformResource.FetchPlatformPlanInfo();
					},50					
				); 
				
			},
			
			FetchPlatformPlanInfo:function(){
				if($("platformMainRegion"))
				{ 
				 	// 存储参数获取
					if($("storageParamSetBox"))
					{
						var cursparams = WebClient.Resource.PlatformResource.curStorageParams;
						
						if($("diskfull-overwrite"))
						{
							// 磁盘满时是否覆盖旧文件











							var isOverWrite = Nrcap2.Config.GetSimple(WebClient.connectId, WebClient.Resource.PlatformResource.curCSUPuid, Nrcap2.Enum.PuResourceType.SC, 0, "CFG_SC_CoverOldRecordFile", ""); 
							cursparams["diskfull-overwrite"] = $("diskfull-overwrite").checked = parseInt(isOverWrite) == 1 ? true : false; 
							
							$("diskfull-overwrite").onclick = function()
							{
								if(this.checked == cursparams["diskfull-overwrite"]) 
								{
									WebClient.Resource.PlatformResource.curSubmitActive = false;
									WebClient.Resource.PlatformResource.DisabledControlToolBtn(0); //control-tool	 
								} 
								else
								{
									WebClient.Resource.PlatformResource.curSubmitActive = true;
									WebClient.Resource.PlatformResource.DisabledControlToolBtn(5); //control-tool	 
								}
							};
						}
						if($("recordfile-savedays"))
						{
							// 录像文件保存天数
							var recordfile_savedays = Nrcap2.Config.GetSimple(WebClient.connectId, WebClient.Resource.PlatformResource.curCSUPuid, Nrcap2.Enum.PuResourceType.SC, 0, "CFG_SC_RecordFileReserveDays", ""); 
							cursparams["recordfile-savedays"] = $("recordfile-savedays").value = 1 <= parseInt(recordfile_savedays) && parseInt(recordfile_savedays) <=  365 ? parseInt(recordfile_savedays) : 30;
							
							$("recordfile-savedays").onchange = function()
							{
								if(this.value.toString().strip() == cursparams["recordfile-savedays"]) 
								{
									WebClient.Resource.PlatformResource.curSubmitActive = false;
									WebClient.Resource.PlatformResource.DisabledControlToolBtn(0); //control-tool	 
								} 
								else
								{
									WebClient.Resource.PlatformResource.curSubmitActive = true;
									WebClient.Resource.PlatformResource.DisabledControlToolBtn(5); //control-tool	 
								}
							};
							
						}
						if($("recordfile-time"))
						{
							// 录像文件时间
							var recordfile_time = Nrcap2.Config.GetSimple(WebClient.connectId, WebClient.Resource.PlatformResource.curCSUPuid, Nrcap2.Enum.PuResourceType.SC, 0, "CFG_SC_RecordTimeSpan", ""); 
							cursparams["recordfile-time"] = $("recordfile-time").value = (60 <= parseInt(recordfile_time) && parseInt(recordfile_time) <=  1800 ? Math.round(parseInt(recordfile_time) / 60) : 15 );
							
							$("recordfile-time").onchange = function()
							{
								if(this.value.toString().strip() == cursparams["recordfile-time"]) 
								{
									WebClient.Resource.PlatformResource.curSubmitActive = false;
									WebClient.Resource.PlatformResource.DisabledControlToolBtn(0); //control-tool	 
								} 
								else
								{
									WebClient.Resource.PlatformResource.curSubmitActive = true;
									WebClient.Resource.PlatformResource.DisabledControlToolBtn(5); //control-tool	 
								}
							};
						}
						if($("snapshotimage-savedays"))
						{
							// 抓拍图片保存天数
							var snapshotimage_savedays = Nrcap2.Config.GetSimple(WebClient.connectId, WebClient.Resource.PlatformResource.curCSUPuid, Nrcap2.Enum.PuResourceType.SC, 0, "CFG_SC_SnapshotReserveDays", ""); 
							cursparams["snapshotimage-savedays"] = $("snapshotimage-savedays").value = 1 <= parseInt(snapshotimage_savedays) && parseInt(snapshotimage_savedays) <=  365 ? parseInt(snapshotimage_savedays) : 30;
							
							$("snapshotimage-savedays").onchange = function()
							{
								if(this.value.toString().strip() == cursparams["snapshotimage-savedays"]) 
								{
									WebClient.Resource.PlatformResource.curSubmitActive = false;
									WebClient.Resource.PlatformResource.DisabledControlToolBtn(0); //control-tool	 
								} 
								else
								{
									WebClient.Resource.PlatformResource.curSubmitActive = true;
									WebClient.Resource.PlatformResource.DisabledControlToolBtn(5); //control-tool	 
								}	
							};
						}
						if($("save-gpsdata"))
						{
							// 是否使能存储GPS数据
							var isSaveGpsData = Nrcap2.Config.GetSimple(WebClient.connectId, WebClient.Resource.PlatformResource.curCSUPuid, Nrcap2.Enum.PuResourceType.SC, 0, "CFG_SC_EnableGPSDataStorage", ""); 
							cursparams["save-gpsdata"] = $("save-gpsdata").checked = parseInt(isSaveGpsData) == 1 ? true : false;
							
							$("save-gpsdata").onclick = function()
							{
								if(this.checked == cursparams["save-gpsdata"])  
								{
									WebClient.Resource.PlatformResource.curSubmitActive = false;
									WebClient.Resource.PlatformResource.DisabledControlToolBtn(0); //control-tool	 
								} 
								else
								{
									WebClient.Resource.PlatformResource.curSubmitActive = true;
									WebClient.Resource.PlatformResource.DisabledControlToolBtn(5); //control-tool	 
								}
							};
						}
						if($("gpsdata-savedays"))
						{
							// GPS数据保留天数
							var gpsdata_savedays = Nrcap2.Config.GetSimple(WebClient.connectId, WebClient.Resource.PlatformResource.curCSUPuid, Nrcap2.Enum.PuResourceType.SC, 0, "CFG_SC_GPSReserveDays", ""); 
							cursparams["gpsdata-savedays"] = $("gpsdata-savedays").value = 1 <= parseInt(gpsdata_savedays) && parseInt(gpsdata_savedays) <=  365 ? parseInt(gpsdata_savedays) : 30;
							
							$("gpsdata-savedays").onclick = function()
							{
								if(this.value.toString().strip() == cursparams["gpsdata-savedays"]) 
								{
									WebClient.Resource.PlatformResource.curSubmitActive = false;
									WebClient.Resource.PlatformResource.DisabledControlToolBtn(0); //control-tool	 
								} 
								else
								{
									WebClient.Resource.PlatformResource.curSubmitActive = true;
									WebClient.Resource.PlatformResource.DisabledControlToolBtn(5); //control-tool	 
								}
								
							};
						}  
						
					} // end
					
					// 存储计划信息
					this.RefreshPlatformStoragePlanList();
					
					// 联动计划信息
					if($("linkActionPlanListBox"))
					{
						
					}					
					
				}
			},
			
			// 刷新存储计划列表
			RefreshPlatformStoragePlanList:function(){
				if($("storagePlanListBox"))
				{ 
					var allPlanNames = new Array(), htmlstr = "";
				
					allPlanNames = Nrcap2.PlatformStorage.GetAllPlanNames(WebClient.connectId, WebClient.Resource.PlatformResource.curCSUPuid);
					if(allPlanNames && typeof allPlanNames == "object" && allPlanNames.constructor == Array)
					{ 
						var html = "", classname = "divtr", cycleDetail = {"Everyday":"每天", "Weekly":"每周", "Once":"一次性"};
						for(var i = 0; i < allPlanNames.length; i++)
						{
							classname = (i % 2 == 0 ? "divtr" : "divtrother") 
							
							var planName = allPlanNames[i];
							
							var planInfo = Nrcap2.PlatformStorage.GetPlan(WebClient.connectId, WebClient.Resource.PlatformResource.curCSUPuid, planName); 
							//alert(Object.toJSON(planInfo));
							if(planInfo && typeof planInfo == "object" && planInfo instanceof Nrcap2.Struct.PlatformStoragePlanStruct)
							{
								var guard = planInfo.guard;  
								var cycle = cycleDetail[planInfo.cycle] ? cycleDetail[planInfo.cycle] : cycleDetail["Once"];
								  
								html += "<div id=\"storage-"+planName+"-info-"+i+"\" class=\""+classname+"\"  webclienttype=\"storage-list\" planname=\""+planName+"\" style=\"width:449px;border-left:0px gray solid;border-right:0px gray solid; border-bottom:1px #ffffff solid;\">";
							
									html += "<div class=\"divtrtd\" style=\"width:16px;border-right:1px #ffffff solid;\"><div id=\"storage-info-"+i+"\" style=\"width:16px;height:100%;display:none;background:url(images/platform-list-item.jpg) repeat-y center;\"></div></div>"; 
									html += "<div class=\"divtrtd\" style=\"width:113px;border-right:1px #ffffff solid;\">"+planName+"</div>"; 
									html += "<div class=\"divtrtd\" style=\"width:110px;border-right:1px #ffffff solid;\">"+(guard.toString() == "1" ? "布防" : "撤防")+"</div>"; 
									html += "<div class=\"divtrtd\" style=\"width:110px;border-right:1px #ffffff solid;\">"+cycle+"</div>";  
								html += "</div>"; 
							}  
						}
						
						htmlstr += html;	 
						
						if(htmlstr == "")
						{
							htmlstr += "<div id=\"\" class=\"divtr\" style=\"width:449px;border-left:0px gray solid;border-right:0px gray solid; border-bottom:1px #ffffff solid;\">";
								htmlstr += "<div class=\"divtrtd\" style=\"width:16px;border-right:1px #ffffff solid;\"></div>"; 
								htmlstr += "<div class=\"divtrtd\" style=\"width:113px;border-right:1px #ffffff solid;\"></div>"; 
								htmlstr += "<div class=\"divtrtd\" style=\"width:110px;border-right:1px #ffffff solid;\"></div>"; 
								htmlstr += "<div class=\"divtrtd\" style=\"width:110px;border-right:1px #ffffff solid;\"></div>";   
							htmlstr += "</div>";
						}
						
						if(htmlstr != "")
						{ 
							$("storagePlanListBox").innerHTML = htmlstr;
							
							var plandivs = $("storagePlanListBox").getElementsByTagName("DIV");
							for(var s = 0; s < plandivs.length; s++)
							{
								var pdiv = plandivs[s]; 
								if(pdiv && pdiv.webclienttype && pdiv.webclienttype == "storage-list" )
								{
									pdiv.onmouseover = function(){ 
										if(WebClient.Resource.PlatformResource.curStoragePlanList == this.id) return; 
										
										this.style.color = "#ffffff";
										this.className = this.className + "over"; 
										var index = this.id.substr(this.id.lastIndexOf("-") + 1);  
										if($("storage-info-" + index)) $("storage-info-" + index).style.display = "block";
									};
									pdiv.onmouseout = function(){
										if(WebClient.Resource.PlatformResource.curStoragePlanList == this.id) return; 
										
										this.style.color = "";
										this.className = this.className.replace("over", ""); 
										var index = this.id.substr(this.id.lastIndexOf("-") + 1); 
										if($("storage-info-" + index)) $("storage-info-" + index).style.display = "none";
									};
									pdiv.onclick = function(){
										var cursplist = WebClient.Resource.PlatformResource.curStoragePlanList;
										if(cursplist == this.id) return;
										
										this.style.color = "#ffffff"; 
										var index = this.id.substr(this.id.lastIndexOf("-") + 1);  
										if($("storage-info-" + index)) $("storage-info-" + index).style.display = "block";
										
										if(cursplist && $(cursplist))
										{
											$(cursplist).style.color = "";
											$(cursplist).className = $(cursplist).className.replace("over", ""); 
											var index = $(cursplist).id.substr($(cursplist).id.lastIndexOf("-") + 1); 
											if($("storage-info-" + index)) $("storage-info-" + index).style.display = "none";
										} 
										 
										WebClient.Resource.PlatformResource.curStoragePlanList = this.id;
										
										WebClient.Resource.PlatformResource.DisabledControlToolBtn(1); //control-tool
									};										
									pdiv.ondblclick = function(){ 
										// alert(this.planname);
										WebClient.Resource.PlatformResource.PlatformStorageMgt_Show("scan", this.planname); // 存储管理界面显示
										WebClient.Resource.PlatformResource.curSubmitActive = true;
										WebClient.Resource.PlatformResource.DisabledControlToolBtn(4); //control-tool	
										 
									};
									
								}
							} 
						} 
						 
						WebClient.Resource.PlatformResource.curStoragePlanList = ""; // 当前的存储计划列表未选中
						if($("storageParamSetBox") && $("storageParamSetBox").style.display == "none")
						{
							WebClient.Resource.PlatformResource.DisabledControlToolBtn(3); //control-tool	
						} 
					}  
				} // 
			},
			
			// 存储管理界面显示
			PlatformStorageMgt_Show:function(flag, planName){
				if(!flag || typeof flag == "undefined")
				{
					flag = "add";
				}
				
				if(flag != "add")
				{
					if(!planName || typeof planName == "undefined")
					{
						alert("存储计划名称未知！");
						return false;
					}
				} // alert(flag);
				
				var curSNavId = WebClient.Resource.PlatformResource.curSubmitNavId = "storageMgtBox";  //  alert(curSNavId); 
				var refreshfpflag = WebClient.Resource.PlatformResource.refreshFetchPlanFlag;
				
				var _StorageMgt_Show = function(){
					// 隐藏存储参数、计划管理及其主体功能区
					if($("storageParamSet")) $("storageParamSet").style.display = "none";
					if($("storageParamSetBox")) $("storageParamSetBox").style.display = "none";
					
					if($("storagePlanSet")) $("storagePlanSet").style.display = "none";
					if($("storagePlanSetBox")) $("storagePlanSetBox").style.display = "none";
					
					if($("storageMgt")) $("storageMgt").style.display = "block";
					if($("storageMgtBox")) $("storageMgtBox").style.display = "block";	 
				};
				
				switch(flag)
				{
					case "add": // 添加 
					    _StorageMgt_Show(); // 隐藏存储参数、计划管理及其主体功能区
						
						if($("storageMgt-planName")) $("storageMgt-planName").value = "";  
						if($("storageMgt-planName")) $("storageMgt-planName").disabled = false;  
						if($("storageMgt-planModel")) $("storageMgt-planModel").value = "pm-everyday";  
						if($("storageMgt-guard")) $("storageMgt-guard").checked = true; 
						
						if($("storageMgt-planModel")) $("storageMgt-planModel").onchange();     
						break;
						
					case "scan": // 查看
					case "modify": // 修改 = new Hash()
						var curspcinfo = WebClient.Resource.PlatformResource.curStoragePlanCommonInfo; // storage plan & res info 
						if(!curspcinfo.get(planName) || refreshfpflag)
						{
							var planInfo = Nrcap2.PlatformStorage.GetPlan(WebClient.connectId, WebClient.Resource.PlatformResource.curCSUPuid, planName);  // alert(Object.toJSON(planInfo));
							if(!planInfo || typeof planInfo != "object" || planInfo.name != planName)
							{
								alert("获取存储计划信息失败！");
								this.RefreshPlatformStoragePlanList(); // 刷新存储计划列表
								return false;
							}
							
							var planRes = Nrcap2.PlatformStorage.GetPlanResource(WebClient.connectId, WebClient.Resource.PlatformResource.curCSUPuid, planName); // alert(Object.toJSON(planRes));
							if(!planRes || typeof planRes != "object" || planRes.constructor != Array)
							{ 
								planRes = new Array(); 
							} 
							
							curspcinfo.set(planName, {planParam: planInfo, planResource: planRes});  
						} 
						else
						{
							var planInfo = curspcinfo.get(planName).planParam;
							var planRes =  curspcinfo.get(planName).planResource;
						} 
						
						_StorageMgt_Show(); // 隐藏存储参数、计划管理及其主体功能区
						
						//  alert(Object.toJSON(curspcinfo));
						if($("storageMgt-planName")) 
						{
							$("storageMgt-planName").value = planName; 
							$("storageMgt-planName").disabled = true;
						}
						
						var pm_week_cycleParam = "", pm_week_param = new Hash(); 
						
						if($("storageMgt-planModel")) 
						{
							var pm = "pm-everyday";
							switch(planInfo.cycle)
							{
								case "Everyday":
									pm = "pm-everyday";
									break;
								case "Weekly":
									pm = "pm-week";
									// 解析cycleParam、guardTimeMap
									var bina = parseInt(planInfo.cycleParam).toString(2); //alert(bina);
									
									for(var i = bina.length - 1; i >= 0; i--)
									{
										pm_week_cycleParam += bina.charAt(i);
									}
									while(pm_week_cycleParam.length < 7) 
									{
										pm_week_cycleParam += "0";	
									}
									// alert(pm_week_cycleParam);
									var maps = planInfo.guardTimeMap;
									
									var mapzero = "";
									while(mapzero.length < 72)
									{
										mapzero += "0";	
									}
									
									var j = 0, s = 0, weeks = ['sdr-sun', 'sdr-mon', 'sdr-tue', 'sdr-wed', 'sdr-thu', 'sdr-fri', 'sdr-sat']; 
									while(j < 7)
									{
										var splitpm = pm_week_cycleParam.charAt(j);
										if(splitpm == "1")
										{
											var map = maps.substr(72 * s,72); 
											s++;
										}
										pm_week_param.set(weeks[j],{flag:splitpm,map:(splitpm == "1" ? map : mapzero)});
										
										j++;
									} 
									
									break;
								case "Once":
									pm = "pm-once";
									break;
								default: break;
							}
							
							if(flag != "modify") 
							{
								if($("storageMgt-planModel")) $("storageMgt-planModel").value = pm;  
								if($("storageMgt-planModel")) $("storageMgt-planModel").onchange();  
								if($("storageMgt-planModel")) $("storageMgt-planModel").disabled = true;  
								
								if($("storageMgt-guard")) $("storageMgt-guard").disabled = true;   
								if($("storageMgt-guard")) $("storageMgt-guard").checked = planInfo.guard == "1" ? true : false; 
								
								if($("storageMgt-once-date")) $("storageMgt-once-date").disabled = true;  
								if($("storageMgt-once-date-img")) $("storageMgt-once-date-img").disabled = true;  
						 	}
							else
							{
								if($("storageMgt-planModel")) $("storageMgt-planModel").disabled = false; 
								if($("storageMgt-guard")) $("storageMgt-guard").disabled = false;  
							}
							 
							if(planInfo.cycle == "Weekly")
							{ 
								WebClient.Resource.PlatformResource.curStoragePlanParamInfo["param"] = pm_week_param;
								// alert(Object.toJSON(WebClient.Resource.PlatformResource.curStoragePlanParamInfo["param"]));
								$(weeks[0]).checked = true;
								var rv = WebClient.GuardTimeMap.ColorMapByHexBinaryStr("storageMgt-guardtimemap-box", "min", 16, pm_week_param.get(weeks[0]).map);
								
								var pm_value = $("storageMgt-planModel").options[$("storageMgt-planModel").selectedIndex].value;
								if(pm_value && pm_value == "pm-week")
								{ 
							  	    if($("storageMgt-week-box")) $("storageMgt-week-box").disabled = $("storageMgt-planModel").disabled;  								
								}
							}
							else
							{
								var pm_param_info = new Object();
								var pm_param_map = planInfo.guardTimeMap;
								var pm_param_flag = 0;
								if(parseInt(pm_param_map, 16) != 0)
								{
									pm_param_flag = 1;
								}
								
								if(planInfo.cycle == "Everyday")
								{
									pm_param_info = {flag:pm_param_flag, map:pm_param_map};
								}
								else
								{  
									var pm_param_date = new Date(parseInt(planInfo.cycleParam) * 1000).format("yyyy-MM-dd");
									if($("storageMgt-once-date")) $("storageMgt-once-date").value = pm_param_date;  
									 
									pm_param_info = {flag:pm_param_flag, map:pm_param_map, time:pm_param_date}; 
									
									var pm_value = $("storageMgt-planModel").options[$("storageMgt-planModel").selectedIndex].value;
									if(pm_value && pm_value == "pm-once")
									{ 
										if($("storageMgt-once-date")) $("storageMgt-once-date").disabled = $("storageMgt-planModel").disabled;                                        if($("storageMgt-once-date-img")) $("storageMgt-once-date-img").disabled = $("storageMgt-planModel").disabled;   								
									}
								}
								
								WebClient.Resource.PlatformResource.curStoragePlanParamInfo["param"] = pm_param_info;
								
								var rv = WebClient.GuardTimeMap.ColorMapByHexBinaryStr("storageMgt-guardtimemap-box", "min", 16, pm_param_map);
								
							}
							
						}
						
						break;
						
					default:
						break;
				}
				
			},
			
			AttachPlatformMgtEvent:function(){
				if($("platformMainRegion")) 
				{
					var navs = $("platformMainRegion").getElementsByTagName("DIV");	
					for(var i = 0; i < navs.length; i++)
					{
						var nav = navs[i];
						if(nav && nav.id && nav.type)
						{   
							switch(nav.type)
							{
								case "storage-nav":
									nav.onmouseover = function(){
										if(WebClient.Resource.PlatformResource.curStorageSelectedNavId == this.id) return;
										this.className = "nav-mouseover";
									};
									nav.onmouseout = function(){
										if(WebClient.Resource.PlatformResource.curStorageSelectedNavId == this.id) return;
										this.className = "nav-mouseout";
									};
									nav.onmousedown = function(){ 
										WebClient.Resource.PlatformResource.PlatformStorageChangeNav(this.id);
									};
									
									break;
								default:
									break;
							}
						}
					} 
				} // end
				
				if($("storageMgt-planName"))
				{
					$("storageMgt-planName").onchange = function()
					{ 
						WebClient.Resource.PlatformResource.curSubmitNavId = "storageMgtBox";	
						WebClient.Resource.PlatformResource.curSubmitActive = true;
						WebClient.Resource.PlatformResource.DisabledControlToolBtn(5); //control-tool	 
					}
				}
				
				// storageMgt-planModel
				if($("storageMgt-planModel"))
				{
					$("storageMgt-planModel").onchange = function(){
						 
						var value = this.options[this.selectedIndex].value; // alert(value.toLowerCase());	
						
						var curspinfo = WebClient.Resource.PlatformResource.curStoragePlanParamInfo;  // 资源信息
						
						/*= {
							"planModel"	: "",
							"param": new Object() 
						};*/
						
						switch(value.toLowerCase())
						{
							case "pm-everyday":
								curspinfo["planModel"] = "pm-everyday";
								curspinfo["param"] = {flag:0,map:""}; 
								
								if($("storageMgt-once-date")) $("storageMgt-once-date").disabled = true; 
								if($("storageMgt-once-date-img")) $("storageMgt-once-date-img").disabled = true; 
								if($("storageMgt-week-box")) $("storageMgt-week-box").disabled = true; 
								
								break; 
							case "pm-week":  
								curspinfo["planModel"] = "pm-week";
								curspinfo["param"] = new Hash(); // =>{"sdr-mon",{flag:0,map:""}} 
								
								WebClient.Resource.PlatformResource.curSroragePlanWeekDate = "sdr-sun"; 
								
								if($("storageMgt-week-box")) $("storageMgt-week-box").disabled = false; 
								if($("storageMgt-once-date")) $("storageMgt-once-date").disabled = true; 
								if($("storageMgt-once-date-img")) $("storageMgt-once-date-img").disabled = true;    
 						
								break;
							case "pm-once":
								curspinfo["planModel"] = "pm-once";
								curspinfo["param"] = {flag:0,map:"",time:""}; 
								
								if($("storageMgt-once-date")) $("storageMgt-once-date").disabled = false; 
								if($("storageMgt-once-date-img")) $("storageMgt-once-date-img").disabled = false; 
								if($("storageMgt-week-box")) $("storageMgt-week-box").disabled = true;  
								break;
							default: break; 
						} 
						
						if($("storageMgt-planName").disabled)
						{  
							WebClient.Resource.PlatformResource.PlatformStorageMgt_Show("modify",$F("storageMgt-planName").strip());	
						}
						
					}; // end
					
					// platformMgt-week-box
					if($("storageMgt-week-box"))
					{
						var weekbtns = $("storageMgt-week-box").getElementsByTagName("INPUT");
						for(var i = 0; i < weekbtns.length; i++)
						{
							var wbtn = weekbtns[i];  
							wbtn.onclick = function(){
								var curspinfoRes = WebClient.Resource.PlatformResource.curStoragePlanParamInfo["param"]; // 资源信息
								var curspwdate = WebClient.Resource.PlatformResource.curSroragePlanWeekDate; // 当前每周的星期











								var newspwdate = this.id; // alert(this.id); // 新的每周的星期











								 
								var hex_curspwdate_map = WebClient.GuardTimeMap.GetHexMapStr("storageMgt-guardtimemap-box", "min"); // alert(hex_curspwdate_map);
								 
								if(parseInt(hex_curspwdate_map, 16) != 0)
								{
									curspinfoRes.set(curspwdate, {flag:1,map:hex_curspwdate_map});
								}
								else
								{
									curspinfoRes.set(curspwdate, {flag:0,map:hex_curspwdate_map});
								}	
								 
								// 呈现已选过的map
								if(curspinfoRes.get(newspwdate))
								{
									var map = curspinfoRes.get(newspwdate).map; 
									var rv = WebClient.GuardTimeMap.ColorMapByHexBinaryStr("storageMgt-guardtimemap-box", "min", 16, map);
									//alert(rv);
								}  
								else
								{
									WebClient.GuardTimeMap.SetStatus("storageMgt-guardtimemap-box", "min", "all");
								}
								
							    WebClient.Resource.PlatformResource.curSroragePlanWeekDate = newspwdate;
								// alert(Object.toJSON(WebClient.Resource.PlatformResource.curStoragePlanParamInfo));
							};
							
							wbtn.onblur = function(){
								// alert(Object.toJSON(WebClient.Resource.PlatformResource.curStoragePlanParamInfo));
								var curspinfoRes = WebClient.Resource.PlatformResource.curStoragePlanParamInfo["param"]; // 资源信息
								var curspwdate = WebClient.Resource.PlatformResource.curSroragePlanWeekDate; // 当前每周的星期











								var newspwdate = this.id; // alert(this.id); // 新的每周的星期











								
								var hex_curspwdate_map = WebClient.GuardTimeMap.GetHexMapStr("storageMgt-guardtimemap-box", "min"); // alert(hex_curspwdate_map); 
								 
								if(parseInt(hex_curspwdate_map, 16) != 0)
								{
									curspinfoRes.set(curspwdate, {flag:1,map:hex_curspwdate_map});
								}
								else
								{
									curspinfoRes.set(curspwdate, {flag:0,map:hex_curspwdate_map});
								}	 
								
								WebClient.Resource.PlatformResource.curSroragePlanWeekDate = newspwdate;
							};
							
						} 
					} // end
					
				}
				
			},
			
			PlatformStorageChangeNav:function(newNavId){
				if(newNavId && $(newNavId))
				{
					var curNavId = WebClient.Resource.PlatformResource.curStorageSelectedNavId;
					
					WebClient.Resource.PlatformResource.curSubmitNavId = curNavId;
					
					if(newNavId == curNavId) return;
					 
					$(newNavId).className = "nav-mousedown";
					
					$(curNavId).className = "nav-mouseout"; 
					
					switch(newNavId)
					{
						case "storageParamSet": 
							$("storageParamSetBox").style.display = "block";
							$("storagePlanSetBox").style.display = "none";
							
							var flag = WebClient.Resource.PlatformResource.curSubmitActive != true ? 0 : 5;  
							WebClient.Resource.PlatformResource.DisabledControlToolBtn(flag); //control-tool
							break;
						case "storagePlanSet":
							$("storageParamSetBox").style.display = "none";
							$("storagePlanSetBox").style.display = "block";
							
							var cursplist = WebClient.Resource.PlatformResource.curStoragePlanList;
							var flag = cursplist && cursplist != "" ? 1 : 3;
							WebClient.Resource.PlatformResource.DisabledControlToolBtn(flag); //control-tool
							break;
						default:return;break;
					} 
					
					WebClient.Resource.PlatformResource.curStorageSelectedNavId = newNavId;
					
					WebClient.Resource.PlatformResource.curSubmitNavId = newNavId; // 提交标记 
					
				}
			}, 
			
			Html:function(){
				var htmlstr = "";
				
					htmlstr += "<div id=\"platformTree\" class=\"resourceTree\">";
						htmlstr += "<img style=\"width:20px;height:20px;\" src=\"images/loading.gif\" />";
						htmlstr += "<span>正在获取资源,请稍候...</span>";
					htmlstr += "</div>";
					
				return htmlstr;
			},
			
			end:true
		},	
		
		/*
		*	函数名		：DeviceResource
		*	函数功能   	：设备管理资源对象 
		*	备注			：无 
		*	作者			：huzw
		*	时间			：2011.06.24	
		*/
		DeviceResource:{
			curDeviceContainerId: "",
			curDeviceNavId:"",
			
			SliderBars: new Hash(), // 音量 etc.
			
			totalCommonInfo: new Hash(), // 当前值信息







			
			curDeviceNavInfos: new Hash(), // 存放nav信息，用以切换







			
			timeZoneConfig: new Array(
				["GMT-12:00","日界线西"],
				["GMT-11:00","西十一区"],
				["GMT-10:00","西十区"],
				["GMT-09:00","西九区"],
				["GMT-08:00","西八区"],
				["GMT-07:00","西七区"],
				["GMT-06:00","西六区"],
				["GMT-05:00","西五区"],
				["GMT-04:00","西四区"],
				["GMT-03:00","西三区"],
				["GMT-02:00","西二区"],
				["GMT-01:00","西一区"],
				["GMT","协调世界时"],
				["GMT+01:00","东一区"],
				["GMT+02:00","东二区"],
				["GMT+03:00","东三区"],
				["GMT+04:00","东四区"],
				["GMT+05:00","东五区"],
				["GMT+06:00","东六区"],
				["GMT+07:00","东七区"],
				["GMT+08:00","东八区"],
				["GMT+09:00","东九区"],
				["GMT+10:00","东十区"],
				["GMT+11:00","东十一区"],
				["GMT+12:00","东十二区"],
				["GMT+13:00","努库阿洛法"]
			),
			
			Init:function(){
				try
				{
					WebClient.Resource.DeviceResource.Html();
				}
				catch(e)
				{
					WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.DeviceResource.Init",msg:"初始化DeviceResource对象失败！"});
					return false;
				}
			},
			
			// 提交
			Submit:function(){
				var curdcId = this.curDeviceContainerId; // alert(curdcId);   
				var curdnId = this.curDeviceNavId; // alert(curdnId); 
				
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"..Submit",msg:"curDeviceContainerId:" + curdcId + ", curDeviceNavId:" + curdnId});
				 
				var totalCommonInfo = this.totalCommonInfo.get(curdcId); // alert(Object.toJSON(totalCommonInfo));   
				var common = totalCommonInfo.childResource.get(curdnId); // alert(Object.toJSON(common)); 
				var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
				
				var puid = totalCommonInfo.puid, resType = totalCommonInfo.resType, resIdx = totalCommonInfo.resIdx;
				
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"..Submit",msg:"puid:" + puid + ", resType:" + resType + ", resIdx:" + resIdx});
				
				switch(curdcId)
				{
					case "device-mgt-self":
						
						switch(curdnId)
						{
							case "dm-self-nav-info":
								// alert(Object.toJSON(common));  
								if(common.count != null && typeof common.count != "undefined" && parseInt(common.count) !=  0)
								{
									var err_num = 0;
									var total_num = 0, succ_num = 0 , flag = 0, details = [];
									var resFlag = false, resName = "", resDesc = "", enable = "";
									childResource.each(
										function(item){
											var node = item.value;
											if(node.key == "deviceMgt-res-name" )
											{ 
												if(node.original != node.newValue)
												{
													resFlag = true;
													resName = node.newValue; 
													
													common.count--;   
												}else {resName = node.original;}
												
											}
											else if(node.key == "deviceMgt-res-desc")
											{
												if(node.original != node.newValue)
												{
													resFlag = true;
													resDesc = node.newValue;
													common.count--;   
												}
												else {resDesc = node.original;}
												if(resFlag)
												{
													total_num++;
													var enable = $("deviceMgt-res-enable") && $("deviceMgt-res-enable").checked ? 1 : 0; 
													// 更新数据
													var param = new Nrcap2.Struct.CommonResDescriptionStruct(puid, resType, resIdx, resName, resDesc, enable);
 												    var rv = Nrcap2.CommonResource.DescriptionControl(WebClient.connectId, puid, resIdx, resType, "set",param); // alert(rv);
													if(parseInt(rv) == 0)
													{
														succ_num++;
														childResource.get("deviceMgt-res-name").original = resName;
														node.original = node.newValue;
														 
														var res = WebClient.Resource.resource.get(puid);
														if(res && typeof res == "object")
														{
															res.name = resName; res.description = resDesc;
															if($("video_" + puid )) $("video_" + puid ).innerHTML = resName;
															if($("query_" + puid )) $("query_" + puid ).innerHTML = resName;
															if($("device_" + puid )) $("device_" + puid ).innerHTML = resName;
															
														} 
													} else { err_num++; }
													
													details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置设备资源信息"});
													
												}
												
											}
											else if(node.key == "deviceMgt-info-timeZone")
											{
												if(node.original != node.newValue)
												{ 	   
													var value = node.newValue.search("-") != -1 ?  node.newValue.replace("-","+") : node.newValue.replace("+","-"); // '+'/'-'对换
													var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_ST_TZ", "", value);  // alert("tmz:" + rv);
													total_num++;
													common.count--;   
													if(parseInt(rv) == 0)
													{
														succ_num++;
														node.original = node.newValue;
													} else { err_num++; }
													
													details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置时区"});
												}
												
											}
											else if(node.key == "deviceMgt-info-timeSyncInterval")
											{
												if(node.original != node.newValue && (0 <= node.newValue && node.newValue <= 1440))
												{
													
													var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_ST_TimeSyncInterval", "", node.newValue);  // alert("tsi:" + rv);
													total_num++;
													common.count--;   
													if(parseInt(rv) == 0)
													{
														succ_num++;
														node.original = node.newValue;
													} else { err_num++; }
													
													details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置平台同步时间间隔"});
												}
											}
											else if(node.key == "deviceMgt-info-enableNTP")
											{
												if(node.original != node.newValue)
												{ 
													var value = node.newValue && node.newValue == true ? "1" : "0";  
													var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_ST_EnableNTP", "", value); // alert("entp:" + rv);
													total_num++;
													common.count--;   
													if(parseInt(rv) == 0)
													{
														succ_num++;
														node.original = node.newValue;
													} else { err_num++; }
													
													details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置自动与Internet时间服务器同步"});
												}
											}
											else if(node.key == "deviceMgt-info-NTPServerAddr")
											{
												if($("deviceMgt-info-enableNTP") && !$("deviceMgt-info-enableNTP").checked) return false;
												
												if(node.original != node.newValue)
												{  
													var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_ST_NTPServerAddr", "", node.newValue); // alert("ntpsa:" + rv);
													total_num++;
													common.count--;   
													if(parseInt(rv) == 0)
													{
														succ_num++;
														node.original = node.newValue;
													} else { err_num++; }
													
													details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置服务器地址"});
												}
											}
											else if(node.key == "deviceMgt-info-NTPSSyncInterval")
											{
												if($("deviceMgt-info-enableNTP") && !$("deviceMgt-info-enableNTP").checked) return false; 
												
												if(node.original != node.newValue)
												{ 
													var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_ST_NTPSSyncInterval", "", node.newValue); // alert("ntpssi:" + rv);
													total_num++;
													common.count--;   
													if(parseInt(rv) == 0)
													{
														succ_num++;
														node.original = node.newValue;
													} else { err_num++; }
													
													details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置时间同步间隔"});
												}
											}
											 
										}
									);
									
									var alertstr = "修改设备完成，成功"+succ_num+"项，失败"+err_num+"项";
									details.each
									(
										function(item)
										{
											alertstr += "\r\n" + (item.flag == 0 ? "[成功]" : "[失败]") + " " + item.detail;
										}
									);
									
									alert(alertstr);
									// alert(Object.toJSON(common)); 
								}
								else
								{
									WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.DeviceResource.Submit",msg:"'"+curdnId+"'下的数据信息没有任何改变，无需提交！"});
									return false;
								}
								break;
								
							default:
							WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.DeviceResource.Submit",msg:"curDeviceNavId(" + curdnId + ") unknown error!"});
							return false;
							break;
						}
						
						break;
					
					case "device-mgt-gps":
						// alert(Object.toJSON(common));  
						if(common.count != null && typeof common.count != "undefined" && parseInt(common.count) !=  0)
						{
							var err_num = 0;
							var total_num = 0, succ_num = 0 , flag = 0, details = [];
							var resFlag = false, resName = "", resDesc = "", enable = "";
							childResource.each(
								function(item){
									var node = item.value;
									
									if(node.key == "deviceMgt-res-name" )
									{ 
										if(node.original != node.newValue)
										{
											resFlag = true;
											resName = node.newValue;
											
											common.count--;   
										}else {resName = node.original;}
										
									} 
									else if(node.key == "deviceMgt-res-desc")
									{
										if(node.original != node.newValue)
										{
											resFlag = true;
											resDesc = node.newValue;
											 
											common.count--; 
										}else {resDesc = node.original;}
									}
									else if(node.key == "deviceMgt-res-enable")
									{
										if(node.original != node.newValue)
										{
											resFlag = true;
											enable = node.newValue == true ? "1" : "0";
											
											common.count--; 
										}
										else {enable = node.original == true ? "1" : "0";}
										
 										if(resFlag)
										{ 
											// 更新数据
											var param = new Nrcap2.Struct.CommonResDescriptionStruct(puid, resType, resIdx, resName, resDesc, enable); // alert(Object.toJSON(param));
											var rv = Nrcap2.CommonResource.DescriptionControl(WebClient.connectId, puid, resIdx, resType, "set",param); // alert(rv);
											total_num++;
											
											if(parseInt(rv) == 0)
											{ 
												succ_num++;
												details.push({flag:0, detail:"设置GPS资源信息"});
											
												childResource.get("deviceMgt-res-name").original = resName;
												childResource.get("deviceMgt-res-desc").original = resDesc;
												node.original = node.newValue;
												 
												var res = WebClient.Resource.resource.get(puid);
												if(res && typeof res == "object")
												{
													if(res.childResource && typeof res.childResource == "object" && res.childResource.constructor == Array)
													{
														for(var i = 0; i < res.childResource.length; i++)
														{
															var childRes = res.childResource[i]; 
															if(resType == childRes.type && resIdx == childRes.idx)
															{ 
																childRes.name = resName; 
																childRes.description = resDesc; 
																childRes.enable = enable;
															}
														}
													} 
													
													var suffix = "_" + puid + "_" + resType + "_" + resIdx;
													if($("device" + suffix)) 
														$("device" + suffix).innerHTML = resName;
													if($("device" + suffix + "_img_ico")) 
														$("device" + suffix + "_img_ico").className = "gps" + ( enable.toString() == "1" ? "" : "_disabled" );  
													
												} 
											} else { err_num++; details.push({flag:-1, detail:"设置GPS资源信息"});}
										} 
										
									}  
									else if(node.key == "deviceMgt-paramCfg-GPSSendCycle")
									{ 
										if(node.original != node.newValue)
										{
											common.count--;
											total_num++;
											
											var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_GPS_SendCycle", "", node.newValue);  // alert( rv);
											if(parseInt(rv) == 0)
											{
												succ_num++;  
												node.original = node.newValue;
											}
											else { err_num++; };
											
											details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置GPS数据发送间隔"});
										} 
									}
									else if(node.key == "deviceMgt-paramCfg-GPSParseInerval")
									{
										if(node.original != node.newValue)
										{
											common.count--;
											total_num++;
											
											var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_GPS_ParseInerval", "", node.newValue);   // alert( rv);
											if(parseInt(rv) == 0)
											{
												succ_num++;  
												node.original = node.newValue;
											}
											else { err_num++; };
											
											details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置GPS数据提取间隔"});
										} 
									}
									else if(node.key == "deviceMgt-paramCfg-enableGPSData")
									{
										if(node.original != node.newValue)
										{
											var value = node.newValue && node.newValue == true ? "1" : "0";
											common.count--;
											total_num++;
											
											var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_GPS_EnableStorage", "", value);   // alert( rv);
											if(parseInt(rv) == 0)
											{
												succ_num++; 
												node.original = node.newValue;
											}
											else { err_num++; };
											
											details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置是否存储GPS数据"});
										} 
									}
									else if(node.key == "deviceMgt-paramCfg-enableGPSBuffer")
									{
										if(node.original != node.newValue)
										{
											var value = node.newValue && node.newValue == true ? "1" : "0";
											common.count--;
											total_num++;
											
											var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_GPS_EnableBuffer", "", value);  // alert( rv);
											if(parseInt(rv) == 0)
											{
												succ_num++;  
												node.original = node.newValue;
											}
											else { err_num++; };
											
											details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置是否使能GPS数据上线补传"});
										} 
									}
									else if(node.key == "deviceMgt-paramCfg-GPSBufferCycle")
									{
										if(node.original != node.newValue)
										{
											common.count--;
											total_num++;
											
											var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_GPS_BufferCycle", "", node.newValue);  // alert( rv);
											if(parseInt(rv) == 0)
											{
												succ_num++;  
												node.original = node.newValue;
											}
											else { err_num++; };
											
											details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置离线GPS数据保存间隔"});
										} 
									}
									else if(node.key == "deviceMgt-paramCfg-LowSpeedAlarmInterval")
									{
										if(node.original != node.newValue)
										{
											common.count--;
											total_num++;
											
											var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_GPS_LowSpeedAlarmInterval", "", node.newValue);   // alert( rv);
											if(parseInt(rv) == 0)
											{
												succ_num++;  
												node.original = node.newValue;
											}
											else { err_num++; };
											
											details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置低速报警间隔"});
										} 
									}
									else if(node.key == "deviceMgt-paramCfg-ERailAlarmInterval")
									{
										if(node.original != node.newValue)
										{
											common.count--;
											total_num++;
											
											var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_GPS_ERailAlarmInterval", "", node.newValue);  // alert( rv);
											if(parseInt(rv) == 0)
											{
												succ_num++; 
												node.original = node.newValue;
											}
											else { err_num++; };
											
											details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置电子围栏报警间隔"});
										} 
									}
									else if(node.key == "deviceMgt-paramCfg-LineDepartAlarmInterval")
									{
										if(node.original != node.newValue)
										{
											common.count--;
											total_num++;
											
											var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_GPS_LineDepartAlarmInterval", "", node.newValue);  // alert( rv);
											if(parseInt(rv) == 0)
											{
												succ_num++;  
												node.original = node.newValue;
											}
											else { err_num++; };
											
											details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置线路偏离报警间隔"});
										} 
									}
								
								}
							);
							
							var alertstr = "修改参数设置完成，成功"+succ_num+"项，失败"+err_num+"项";
							details.each
							(
								function(item)
								{
									alertstr += "\r\n" + (item.flag == 0 ? "[成功]" : "[失败]") + " " + item.detail;
								}
							);
							
							alert(alertstr);
							// alert(Object.toJSON(common)); 
						}
						else
						{
							WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.DeviceResource.Submit",msg:"'"+curdnId+"'下的数据信息没有任何改变，无需提交！"});
							return false;
						}
						break;
					
					case "device-mgt-audioin":
						// alert(Object.toJSON(common));  
						if(common.count != null && typeof common.count != "undefined" && parseInt(common.count) !=  0)
						{
							var err_num = 0;
							var total_num = 0, succ_num = 0 , flag = 0, details = [];
							var resFlag = false, resName = "", resDesc = "", enable = "";
							childResource.each(
								function(item){
									var node = item.value;
									
									if(node.key == "deviceMgt-res-name" )
									{ 
										if(node.original != node.newValue)
										{
											resFlag = true;
											resName = node.newValue;
											
											common.count--;   
										}else {resName = node.original;}
										
									} 
									else if(node.key == "deviceMgt-res-desc")
									{
										if(node.original != node.newValue)
										{
											resFlag = true;
											resDesc = node.newValue;
											 
											common.count--; 
										}else {resDesc = node.original;}
									}
									else if(node.key == "deviceMgt-res-enable")
									{
										if(node.original != node.newValue)
										{
											resFlag = true;
											enable = node.newValue == true ? "1" : "0";
											
											common.count--; 
										}
										else {enable = node.original == true ? "1" : "0";}
									 
 										if(resFlag)
										{ 
											// 更新数据
											var param = new Nrcap2.Struct.CommonResDescriptionStruct(puid, resType, resIdx, resName, resDesc, enable); // alert(Object.toJSON(param));
											var rv = Nrcap2.CommonResource.DescriptionControl(WebClient.connectId, puid, resIdx, resType, "set",param); // alert(rv);
											total_num++;
											
											if(parseInt(rv) == 0)
											{ 
												succ_num++;
												details.push({flag:0, detail:"设置输入音频资源信息"});
											
												childResource.get("deviceMgt-res-name").original = resName;
												childResource.get("deviceMgt-res-desc").original = resDesc;
												node.original = node.newValue;
												 
												var res = WebClient.Resource.resource.get(puid);
												if(res && typeof res == "object")
												{
													if(res.childResource && typeof res.childResource == "object" && res.childResource.constructor == Array)
													{
														for(var i = 0; i < res.childResource.length; i++)
														{
															var childRes = res.childResource[i]; 
															if(resType == childRes.type && resIdx == childRes.idx)
															{ 
																childRes.name = resName; 
																childRes.description = resDesc; 
																childRes.enable = enable;
															}
														}
													} 
													
													var suffix = "_" + puid + "_" + resType + "_" + resIdx;
													if($("device" + suffix)) 
														$("device" + suffix).innerHTML = resName;
													if($("device" + suffix + "_img_ico")) 
														$("device" + suffix + "_img_ico").className = "inputaudio" + ( enable.toString() == "1" ? "" : "_disabled" );   
												} 
											} else { err_num++; details.push({flag:-1, detail:"设置输入音频资源信息"});}
										} 
										
									}  
									else if(node.key == "deviceMgt-paramCfg-encodeMode")
									{ 
										if(node.original != node.newValue)
										{
											common.count--;
											total_num++;
											
											var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IA_Encoder", "", node.newValue);  // alert( rv);
											if(parseInt(rv) == 0)
											{
												succ_num++;  
												node.original = node.newValue;
											}
											else { err_num++; };
											
											details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置编码方式"});
										} 
									}
									else if(node.key == "deviceMgt-paramCfg-inputMode")
									{
										if(node.original != node.newValue)
										{
											common.count--;
											total_num++;
											
											var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IA_InputMode", "", node.newValue);   // alert( rv);
											if(parseInt(rv) == 0)
											{
												succ_num++;  
												node.original = node.newValue;
											}
											else { err_num++; };
											
											details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置输入模式"});
										} 
									}
									else if(node.key == "deviceMgt-paramCfg-sampleRate")
									{
										if(node.original != node.newValue)
										{
											var value = node.newValue;
											common.count--;
											total_num++;
											
											var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IA_SampleRate", "", value);   // alert( rv);
											if(parseInt(rv) == 0)
											{
												succ_num++; 
												node.original = node.newValue;
											}
											else { err_num++; };
											
											details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置采样率"});
										} 
									}
									else if(node.key == "deviceMgt-paramCfg-volume")
									{
										if(node.original != node.newValue)
										{
											var value = node.newValue;
											common.count--;
											total_num++;
											
											var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IA_Volume", "", value);  // alert( rv);
											if(parseInt(rv) == 0)
											{
												succ_num++;  
												node.original = node.newValue;
											}
											else { err_num++; };
											
											details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置音量"});
										} 
									} // end
								
								}
							);
							
							var alertstr = "修改参数设置完成，成功"+succ_num+"项，失败"+err_num+"项";
							details.each
							(
								function(item)
								{
									alertstr += "\r\n" + (item.flag == 0 ? "[成功]" : "[失败]") + " " + item.detail;
								}
							);
							
							alert(alertstr);
							// alert(Object.toJSON(common));  
						}
						else
						{
							WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.DeviceResource.Submit",msg:"'"+curdnId+"'下的数据信息没有任何改变，无需提交！"});
							return false;
						}
						break;
					
					case "device-mgt-videoin":
					
						switch(curdnId)
						{
							case "dm-videoin-nav-baseParam":
								// alert(Object.toJSON(common));
								if(common.count != null && typeof common.count != "undefined" && parseInt(common.count) !=  0)
								{
									var err_num = 0;
									var total_num = 0, succ_num = 0 , flag = 0, details = [];
									var resFlag = false, resName = "", resDesc = "", enable = "";
									var timeFlag = false, changeFlag = false, N2Dhour = "", N2Dminute = "", D2Nhour = "", D2Nminute = "";
									childResource.each(
										function(item){
											var node = item.value;
											
											if(node.key == "deviceMgt-res-name" )
											{ 
												if(node.original != node.newValue)
												{
													resFlag = true;
													resName = node.newValue;
													
													common.count--;   
												}else {resName = node.original;}
												
											} 
											else if(node.key == "deviceMgt-res-desc")
											{
												if(node.original != node.newValue)
												{
													resFlag = true;
													resDesc = node.newValue;
													 
													common.count--; 
												}else {resDesc = node.original;}
											}
											else if(node.key == "deviceMgt-res-enable")
											{
												if(node.original != node.newValue)
												{
													resFlag = true;
													enable = node.newValue == true ? "1" : "0";
													
													common.count--; 
												}
												else {enable = node.original == true ? "1" : "0";}
											 
												if(resFlag)
												{ 
													// 更新数据
													var param = new Nrcap2.Struct.CommonResDescriptionStruct(puid, resType, resIdx, resName, resDesc, enable); // alert(Object.toJSON(param));
													var rv = Nrcap2.CommonResource.DescriptionControl(WebClient.connectId, puid, resIdx, resType, "set",param); // alert(rv);
													total_num++;
													
													if(parseInt(rv) == 0)
													{ 
														succ_num++;
														details.push({flag:0, detail:"设置输入视频资源信息"});
													
														childResource.get("deviceMgt-res-name").original = resName;
														childResource.get("deviceMgt-res-desc").original = resDesc;
														node.original = node.newValue;
														 
														var res = WebClient.Resource.resource.get(puid);
														if(res && typeof res == "object")
														{
															if(res.childResource && typeof res.childResource == "object" && res.childResource.constructor == Array)
															{
																for(var i = 0; i < res.childResource.length; i++)
																{
																	var childRes = res.childResource[i]; 
																	if(resType == childRes.type && resIdx == childRes.idx)
																	{ 
																		childRes.name = resName; 
																		childRes.description = resDesc; 
																		childRes.enable = enable;
																	}
																}
															} 
															
															var suffix = "_" + puid + "_" + resType + "_" + resIdx;
															if($("device" + suffix)) 
																$("device" + suffix).innerHTML = resName;
															if($("device" + suffix + "_img_ico")) 
																$("device" + suffix + "_img_ico").className = "inputvideo" + ( enable.toString() == "1" ? "" : "_disabled" );    
															if($("video" + suffix)) 
																$("video" + suffix).innerHTML = resName;
															if($("video" + suffix + "_img_ico")) 
																$("video" + suffix + "_img_ico").className = "inputvideo" + ( enable.toString() == "1" ? "" : "_disabled" );   	 
															if($("query" + suffix))
																$("query" + suffix).innerHTML = resName;
															if($("query" + suffix + "_img_ico")) 
																$("query" + suffix + "_img_ico").className = "inputvideo" + ( enable.toString() == "1" ? "" : "_disabled" );   	
														 
														} 
													} else { err_num++; details.push({flag:-1, detail:"设置输入视频资源信息"});}
												}  
											} 
											else if(node.key == "deviceMgt-baseParam-encodeMode")
											{
												if(node.original != node.newValue)
												{
													var value = node.newValue;
													common.count--;
													total_num++;
													
													var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_Encoder", "", value);   // alert( rv);
													if(parseInt(rv) == 0)
													{
														succ_num++; 
														node.original = node.newValue;
													}
													else { err_num++; };
													
													details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置压缩方式"});
												} 
											} 
											else if(node.key == "deviceMgt-baseParam-EnableNightParam")
											{
												timeFlag = false;
												if(node.original != node.newValue)
												{
													var value = node.newValue == true ? 1 : 0;
													common.count--;
													total_num++;
													
													var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_EnableNightParam", "", value);   // alert( rv);
													if(parseInt(rv) == 0)
													{
														succ_num++; 
														node.original = node.newValue;
													}
													else { err_num++; };
													
													details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置使能夜间参数"});
												}  
												if($(node.key).checked)
												{
													timeFlag = true;
												}
											}
											else if(node.key == "deviceMgt-baseParam-nightToDayTime")
											{ 
												if(node.original != node.newValue)
												{
													N2Dhour = node.newValue.split(":")[0];
													N2Dminute = node.newValue.split(":")[1]; 
													
													common.count--;
													changeFlag = true;
												}
												else
												{
													N2Dhour = node.original.split(":")[0];
													N2Dminute = node.original.split(":")[1]; 
												} 
											}
											else if(node.key == "deviceMgt-baseParam-dayToNightTime")
											{ 
												if(node.original != node.newValue)
												{
													D2Nhour = node.newValue.split(":")[0];
													D2Nminute = node.newValue.split(":")[1]; 
													
													common.count--; 
													changeFlag = true;
												}  
												else
												{
													D2Nhour = node.original.split(":")[0];
													D2Nminute = node.original.split(":")[1]; 
												}  
												// alert(N2Dhour + ":" + N2Dminute + ":" + D2Nhour + ":" + D2Nminute);
												if(timeFlag && changeFlag)
												{ 
													total_num++;
													var param = {N2Dhour:N2Dhour, N2Dminute:N2Dminute, D2Nhour:D2Nhour, D2Nminute:D2Nminute};
													var rv = Nrcap2.Config.SetComplex(WebClient.connectId, puid, resType, resIdx, "CFG_IV_DayNightTime", "", param); // alert( rv);
													if(parseInt(rv) == 0)
													{
														succ_num++; 
														childResource.get("deviceMgt-baseParam-nightToDayTime").original = childResource.get("deviceMgt-baseParam-nightToDayTime").newValue; 
														node.original = node.newValue;
													}
													else { err_num++; };
													
													details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置昼夜切换时间点"});
												} 
												
											}
											else if(node.key == "deviceMgt-baseParam-EnableCoverAlarm")
											{
												if(node.original != node.newValue)
												{
													var value = node.newValue == true ? 1 : 0;
													common.count--;
													total_num++;
													
													var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_EnableNightParam", "", value);   // alert( rv);
													if(parseInt(rv) == 0)
													{
														succ_num++; 
														node.original = node.newValue;
													}
													else { err_num++; };
													
													details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置启用遮挡报警"});
												} 
											}
											else if(node.key == "deviceMgt-baseParam-CoverAlarmSensitivity")
											{
												if(node.original != node.newValue)
												{
													var value = node.newValue;
													common.count--;
													total_num++;
													
													var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_CoverAlarmSensitivity", "", value);   // alert( rv);
													if(parseInt(rv) == 0)
													{
														succ_num++; 
														node.original = node.newValue;
													}
													else { err_num++; };
													
													details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置遮挡报警灵敏度"});
												} 
											} 
										}
									);
									
									var alertstr = "修改基本参数完成，成功"+succ_num+"项，失败"+err_num+"项";
									details.each
									(
										function(item)
										{
											alertstr += "\r\n" + (item.flag == 0 ? "[成功]" : "[失败]") + " " + item.detail;
										}
									);
									
									alert(alertstr);
									// alert(Object.toJSON(common));    
								} 
								else
								{
									WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.DeviceResource.Submit",msg:"'"+curdnId+"'下的数据信息没有任何改变，无需提交！"});
									return false;
								}
								break;
								
							case "dm-videoin-nav-captureParam":
								// alert(Object.toJSON(common));
								if(common.count != null && typeof common.count != "undefined" && parseInt(common.count) !=  0)
								{
									var err_num = 0;
									var total_num = 0, succ_num = 0 , flag = 0, details = [];
									var resFlag = false, timeAdd_XPos = "", textAdd_XPos = "", logoAdd_XPos = ""; 
									childResource.each(
										function(item){
											var node = item.value;
											 
											if(node.key == "deviceMgt-captureParam-timeRound")
											{
												if(node.original != node.newValue)
												{
													var value = node.newValue == "Day" ? 1 : 2;
													resFlag = value == 1 ? true : false;
													common.count--; 
												} 
											} 
											else if(node.key == "deviceMgt-captureParam-brightness")
											{ 
												if(node.original != node.newValue)
												{
													var value = node.newValue;
													common.count--;
													total_num++;
												 
													var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_Brightness" + (resFlag ? "" : "N"), "", value);   // alert( rv);
													if(parseInt(rv) == 0)
													{
														succ_num++; 
														node.original = node.newValue;
													}
													else { err_num++; };
													
													details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置亮度"});
												} 
											}
											else if(node.key == "deviceMgt-captureParam-contrast")
											{ 
												if(node.original != node.newValue)
												{
													var value = node.newValue;
													common.count--;
													total_num++;
													
													var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_Contrast" + (resFlag ? "" : "N"), "", value);   // alert( rv);
													if(parseInt(rv) == 0)
													{
														succ_num++; 
														node.original = node.newValue;
													}
													else { err_num++; };
													
													details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置对比度"});
												} 
											}
											else if(node.key == "deviceMgt-captureParam-hue")
											{ 
												if(node.original != node.newValue)
												{
													var value = node.newValue;
													common.count--;
													total_num++;
													
													var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_Hue" + (resFlag ? "" : "N"), "", value);   // alert( rv);
													if(parseInt(rv) == 0)
													{
														succ_num++; 
														node.original = node.newValue;
													}
													else { err_num++; };
													
													details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置色调"});
												} 
											}
											else if(node.key == "deviceMgt-captureParam-saturation")
											{ 
												if(node.original != node.newValue)
												{
													var value = node.newValue;
													common.count--;
													total_num++;
													
													var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_Saturation" + (resFlag ? "" : "N"), "", value);   // alert( rv);
													if(parseInt(rv) == 0)
													{
														succ_num++; 
														node.original = node.newValue;
													}
													else { err_num++; };
													
													details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置饱和度"});
												} 
											} 
											else if(node.key == "deviceMgt-captureParam-Preprocessor")
											{ 
												if(node.original != node.newValue)
												{
													var value = node.newValue;
													common.count--;
													total_num++;
													
													var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_Preprocessor", "", value);   // alert( rv);
													if(parseInt(rv) == 0)
													{
														succ_num++; 
														node.original = node.newValue;
													}
													else { err_num++; };
													
													details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置预处理方式"});
												} 
											} 
											else if(node.key == "deviceMgt-captureParam-TimeAddPosition-X")
											{
												resFlag = false;
												if(node.original != node.newValue)
												{
													resFlag = true;
													timeAdd_XPos = node.newValue;
													common.count--;
													total_num++;  
												} else { timeAdd_XPos = node.original; }
											} 
											else if(node.key == "deviceMgt-captureParam-TimeAddPosition-Y")
											{
												if(node.original != node.newValue)
												{
													resFlag = true;
													var timeAdd_YPos = node.newValue;
													common.count--;
													total_num++;    
												} else { var timeAdd_YPos = node.original; }
												
												if(resFlag == true)
												{
													var param = {XPos:timeAdd_XPos, YPos:timeAdd_YPos};
													var rv = Nrcap2.Config.SetComplex(WebClient.connectId, puid, resType, resIdx, "CFG_IV_TimeAddPosition", "", param);   // alert( rv);
													if(parseInt(rv) == 0)
													{
														succ_num++; 
														childResource.get("deviceMgt-captureParam-TimeAddPosition-X").original = timeAdd_XPos;
														node.original = timeAdd_YPos;
													}
													else { err_num++; };
													
													details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置时间位置"});
												} 
											} 
											else if(node.key == "deviceMgt-captureParam-TextAdd")
											{
												if(node.original != node.newValue)
												{
													var value = node.newValue;
													common.count--;
													total_num++;
													
													var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_TextAdd", "", value);   // alert( rv);
													if(parseInt(rv) == 0)
													{
														succ_num++; 
														node.original = node.newValue;
													}
													else { err_num++; };
													
													details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置文字内容"});
												} 
											} 
											else if(node.key == "deviceMgt-captureParam-TextAddPosition-X")
											{
												resFlag = false;
												if(node.original != node.newValue)
												{
													resFlag = true;
													textAdd_XPos = node.newValue;
													common.count--;
													total_num++;  
												} else { textAdd_XPos = node.original; }
											} 
											else if(node.key == "deviceMgt-captureParam-TextAddPosition-Y")
											{
												if(node.original != node.newValue)
												{
													resFlag = true;
													var textAdd_YPos = node.newValue;
													common.count--;
													total_num++;    
												} else { var textAdd_YPos = node.original; }
												
												if(resFlag == true)
												{
													var param = {XPos:textAdd_XPos, YPos:textAdd_YPos};
													var rv = Nrcap2.Config.SetComplex(WebClient.connectId, puid, resType, resIdx, "CFG_IV_TextAddPosition", "", param);   // alert( rv);
													if(parseInt(rv) == 0)
													{
														succ_num++; 
														childResource.get("deviceMgt-captureParam-TextAddPosition-X").original = textAdd_XPos;
														node.original = textAdd_YPos;
													}
													else { err_num++; };
													
													details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置文字位置"});
												} 
											}
											else if(node.key == "deviceMgt-captureParam-AddGPSAlarm")
											{
												if(node.original != node.newValue)
												{
													var value = node.newValue == true ? 1 : 0;
													common.count--;
													total_num++;
													
													var rv = Nrcap2.Config.SetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_AddGPSAlarm", "", value);   // alert( rv);
													if(parseInt(rv) == 0)
													{
														succ_num++; 
														node.original = node.newValue;
													}
													else { err_num++; };
													
													details.push({flag:parseInt(rv) == 0 ? 0 : -1, detail:"设置速度报警时警告色叠加GPS"});
												} 
											} 
											
										}
									);
									
									var alertstr = "修改基本参数完成，成功"+succ_num+"项，失败"+err_num+"项";
									details.each
									(
										function(item)
										{
											alertstr += "\r\n" + (item.flag == 0 ? "[成功]" : "[失败]") + " " + item.detail;
										}
									);
									
									alert(alertstr);
									// alert(Object.toJSON(common));    
								} 
								else
								{
									WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.DeviceResource.Submit",msg:"'"+curdnId+"'下的数据信息没有任何改变，无需提交！"});
									return false;
								}
								
								break;
							
							default:
								break;
						}
						
						// alert(Object.toJSON(common));  
						
						
						break;
					
					default:
						WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.DeviceResource.Submit",msg:"curDeviceContainerId(" + curdcId + ") unknown error!"});
						return false;
						break;
				}
				
				if(!isNaN(err_num) && err_num != 0) this.MainRegionInit(puid, resType, resIdx); // 提交后刷新 
			
			},
			
			MainRegionInit:function(puid, resType, resIdx){
				if(!puid || typeof puid == "undefined")
				{
					WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.DeviceResource.MainRegionInit",msg:"puid error!"});
					return false;
				}
				if(!resType || typeof resType == "undefined")
				{
					WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.DeviceResource.MainRegionInit",msg:"resType error!"});
					return false;
				} 
				if(resIdx == null || typeof resIdx == "undefined")
				{
					WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.DeviceResource.MainRegionInit",msg:"resIdx error!"});
					return false;
				}
				
				var htmlstr = "";
				var devInfo = WebClient.Resource.resource.get(puid);
				var display = "none";	
				if(devInfo.online == "1" && devInfo.enable == "1")
				{
					display = "block";
				} 
				
				switch(resType)
				{
					case Nrcap2.Enum.PuResourceType.SELF:
						this.curDeviceContainerId = "device-mgt-self";
						this.curDeviceNavId = "dm-self-nav-info";
						
						htmlstr += "<div id=\"device-mgt-self\" class=\"device-mgt-box\" >";
							// top nav pad
							htmlstr += "<div id=\"dm-self-nav-pad\" class=\"device-nav-pad\" >";
								htmlstr += "<div id=\"dm-self-nav-info\" class=\"nav-mousedown\" style=\"width:35px;\" >信息</div>";
								htmlstr += "<div id=\"dm-self-nav-network\" class=\"nav-mouseout\" style=\"width:35px;display:"+display+"\"  >网络</div>";
								htmlstr += "<div id=\"dm-self-nav-platformAccess\" class=\"nav-mouseout\" style=\"width:55px;display:"+display+"\"  >平台接入</div>";
								 
								htmlstr += "";
							htmlstr += "</div>";
							
							// main pad
							htmlstr += "<div id=\"dm-self-main-pad\" class=\"device-main-pad\" >";
								// 1. info
								htmlstr += "<div id=\"dm-self-main-info\" class=\"main-body\" >";
									
									htmlstr += "<div style=\"width:400px; height:500px; float:left;\" >";
										// 设备信息
										htmlstr += "<div style=\"width:400px; height:255px; float:left; margin-top:5px; border:0px red solid;\"><fieldset style=\"width:385px; height:248px;\">";
											htmlstr += "<legend>设备信息</legend>";
											
											htmlstr += "<table width=\"380\" height=\"235\" align=\"center\" cellspacing=\"0\" cellpadding=\"0\">";	
												htmlstr += "<tr>";
													htmlstr += "<td width=\"90\" ><label>设备型号：</label></td>";
													htmlstr += "<td colspan=\"2\"><input type=\"text\" id=\"deviceMgt-info-modelName\" style=\"width:280px; \" value=\"\" class=\"input-readonly\"  readonly /></td>";
												htmlstr += "</tr>";
												
												htmlstr += "<tr>";
													htmlstr += "<td width=\"90\" ><label>设备类型：</label></td>";
													htmlstr += "<td colspan=\"2\"><input type=\"text\" id=\"deviceMgt-info-modelType\" style=\"width:280px; \" class=\"input-readonly\" readonly /></td>";
												htmlstr += "</tr>";
												
												htmlstr += "<tr>";
													htmlstr += "<td width=\"90\" ><label>软件版本号：</label></td>";
													htmlstr += "<td colspan=\"2\"><input type=\"text\" id=\"deviceMgt-info-softwareVersion\" style=\"width:280px; \" class=\"input-readonly\" readonly /></td>";
												htmlstr += "</tr>";
												
												htmlstr += "<tr>";
													htmlstr += "<td width=\"90\" ><label>硬件版本号：</label></td>";
													htmlstr += "<td colspan=\"2\"><input type=\"text\" id=\"deviceMgt-info-hardwareVersion\" style=\"width:280px; \" class=\"input-readonly\" readonly /></td>";
												htmlstr += "</tr>";
												
												htmlstr += "<tr>";
													htmlstr += "<td width=\"90\" ><label>厂商ID：</label></td>";
													htmlstr += "<td colspan=\"2\"><input type=\"text\" id=\"deviceMgt-info-manufactrueID\" style=\"width:280px; \" class=\"input-readonly\" readonly /></td>";
												htmlstr += "</tr>";
												
												htmlstr += "<tr>";
													htmlstr += "<td width=\"90\" ><label>设备ID：</label></td>";
													htmlstr += "<td colspan=\"2\"><input type=\"text\" id=\"deviceMgt-info-deviceID\" style=\"width:280px; \" class=\"input-readonly\" readonly /></td>";
												htmlstr += "</tr>";
												
												htmlstr += "<tr>";
													htmlstr += "<td width=\"90\" ><label>CPU使用率：</label></td>";
													htmlstr += "<td>";
														htmlstr += "<div class=\"progress-container\"><div id=\"deviceMgt-info-cpupercent\" class=\"progress-bar\" ></div></div>";
														htmlstr += "<span id=\"deviceMgt-info-cpupercent-flag\" style=\"float:left;margin-left:7px;line-height:18px;vertical-align:center;\"></span>";
													htmlstr += "</td>";
													htmlstr += "<td><input type=\"button\" id=\"deviceMgt-info-cpupercent-refresh\" value=\"刷新\" /></td>";
												htmlstr += "</tr>";
												
												htmlstr += "<tr>";
													htmlstr += "<td><label>内存使用率：</label></td>";
													htmlstr += "<td>";
														htmlstr += "<div class=\"progress-container\"><div id=\"deviceMgt-info-memory\" class=\"progress-bar\" ></div></div>";
														htmlstr += "<span id=\"deviceMgt-info-memory-flag\" style=\"float:left;margin-left:7px;line-height:18px;vertical-align:center;\"></span>";
													htmlstr += "</td>";
													htmlstr += "<td><input type=\"button\" id=\"deviceMgt-info-memory-refresh\" value=\"刷新\" /></td>";
												htmlstr += "</tr>";
												
											htmlstr += "</table>";
											
										htmlstr += "</fieldset></div>";
										
										// 系统时间
										htmlstr += "<div style=\"width:400px; height:205px; float:left; margin-top:5px; border:0px red solid;\"><fieldset style=\"width:385px; height:200px;\">";
											htmlstr += "<legend>系统时间</legend>";
											
											htmlstr += "<table width=\"380\" height=\"200\" align=\"center\" cellspacing=\"0\" cellpadding=\"0\">";	
												htmlstr += "<tr>";
													htmlstr += "<td width=\"90\" ><label>时区：</label></td>";
													htmlstr += "<td ><select id=\"deviceMgt-info-timeZone\" style=\"width:285px; \" value=\"CR6004M\" >";
													for(var i = 0; i < this.timeZoneConfig.length; i++)
													{
														var timeZone = this.timeZoneConfig[i];
														htmlstr += "<option value=\""+timeZone[0]+"\" "+(i == 20 ? "selected" : "")+">("+timeZone[0]+")&nbsp;"+timeZone[1]+"</option>";
													}
													
													htmlstr += "</select></td>";
												htmlstr += "</tr>";
												
												htmlstr += "<tr>";
													htmlstr += "<td width=\"90\" ><label>时间：</label></td>";
													htmlstr += "<td ><input type=\"text\" id=\"deviceMgt-info-time\" style=\"width:160px; \" value=\""+new Date().format("yyyy-MM-dd HH:mm:ss")+"\" onfocus=\"WdatePicker({el:'deviceMgt-info-time', dateFmt:'yyyy-MM-dd HH:mm:ss', onpicked:function(){}});\" />&nbsp;<img id=\"deviceMgt-info-time-img\" src=\"images/calender.png\" onClick=\"WdatePicker({el:'deviceMgt-info-time', dateFmt:'yyyy-MM-dd HH:mm:ss', onpicked:function(){}})\" align=\"absmiddle\" style=\"width:20px;height:18px;cursor:pointer;\" />&nbsp;<input type=\"button\" id=\"deviceMgt-info-time-refresh\" value=\"刷新\" />&nbsp;<input type=\"button\" id=\"deviceMgt-info-time-set\" value=\"设置\" />";  
													htmlstr += "</td>";
												htmlstr += "</tr>";
												
												htmlstr += "<tr>";
													htmlstr += "<td colspan=\"2\" ><label>平台同步时间间隔：</label><input type=\"text\" id=\"deviceMgt-info-timeSyncInterval\" style=\"width:260px; \" /></td>";  
												htmlstr += "</tr>";
												
												htmlstr += "<tr>";
													htmlstr += "<td colspan=\"2\" >";
														htmlstr += "<fieldset>";
															htmlstr += "<legend><input type=\"checkbox\" id=\"deviceMgt-info-enableNTP\"><label for=\"deviceMgt-info-enableNTP\">自动与Internet时间服务器同步</label></legend>";
															
															htmlstr += "<table width=\"360\" height=\"60\" align=\"center\" cellspacing=\"0\" cellpadding=\"0\">";	
																htmlstr += "<tr>";
																	htmlstr += "<td width=\"90\"><label>服务器地址：</label></td>";
																	htmlstr += "<td ><input type=\"text\" id=\"deviceMgt-info-NTPServerAddr\" style=\"width:260px; \" value=\"ntp.sjtu.edu.cn\" disabled/></td>"; 
																htmlstr += "</tr>";
															
																htmlstr += "<tr>";
																	htmlstr += "<td width=\"90\"><label>时间同步间隔：</label></td>";
																	htmlstr += "<td ><input type=\"text\" id=\"deviceMgt-info-NTPSSyncInterval\" style=\"width:230px; \" value=\"1440\" disabled/>&nbsp;分钟</td>"; 
																htmlstr += "</tr>";
															
															htmlstr += "</table>";
															
														htmlstr += "</fieldset>";
													htmlstr += "</td>";  
												htmlstr += "</tr>";
												
												
											htmlstr += "</table>";
											
										htmlstr += "</fieldset></div>";
									htmlstr += "</div>"; 
									
									htmlstr += "<div style=\"margin-top:5px;\"><input type=\"button\" id=\"deviceMgt-info-restart\" value=\"重启设备\" />";
									
								htmlstr += "</div>";
								
								// 2. network

							htmlstr += "</div>";
							
						htmlstr += "</div>";
						
						break;
					
					case Nrcap2.Enum.PuResourceType.GPS:
						this.curDeviceContainerId = "device-mgt-gps";
						this.curDeviceNavId = "dm-gps-nav-paramCfg";
						
						htmlstr += "<div id=\"device-mgt-gps\" class=\"device-mgt-box\" >";
							// top nav pad
							htmlstr += "<div id=\"dm-gps-nav-pad\" class=\"device-nav-pad\" >";
								htmlstr += "<div id=\"dm-gps-nav-paramCfg\" class=\"nav-mousedown\" style=\"width:55px;display:"+display+";\" >参数设置</div>";
								htmlstr += "<div id=\"dm-gps-nav-seniorCfg\" class=\"nav-mouseout\" style=\"width:55px;display:none;\" >高级配置</div>"; 
								htmlstr += "";
							htmlstr += "</div>";
							
							// main pad
							htmlstr += "<div id=\"dm-gps-main-pad\" class=\"device-main-pad\" >";
								// 1. paramCfg
								htmlstr += "<div id=\"dm-gps-main-paramCfg\" class=\"main-body\"> ";
									htmlstr += "<div style=\"width:400px; height:300px; float:left;display:"+display+";\" >";
										// 参数设置
										htmlstr += "<div style=\"width:400px; height:280px; float:left; margin-top:5px; border:0px red solid;\"><fieldset style=\"width:385px; height:270px;\">";
											htmlstr += "<legend>参数设置</legend>";
											
											htmlstr += "<table width=\"380\" height=\"255\" align=\"center\" cellspacing=\"0\" cellpadding=\"0\">";	
												htmlstr += "<tr>";
													htmlstr += "<td width=\"135\" ><label>GPS模块状态：</label></td>";
													htmlstr += "<td ><input type=\"text\" id=\"deviceMgt-paramCfg-GPSStatus\" style=\"width:132px; \" value=\"\" class=\"input-readonly\" readonly /><span>&nbsp;</span></td>";
												htmlstr += "</tr>";
												
												htmlstr += "<tr>";
													htmlstr += "<td width=\"135\" ><label>GPS数据发送间隔：</label></td>";
													htmlstr += "<td ><input type=\"text\" id=\"deviceMgt-paramCfg-GPSSendCycle\" style=\"width:130px; \" class=\"\" /><span>&nbsp;秒（0表示不发送）</span></td>";
												htmlstr += "</tr>";
												
												htmlstr += "<tr>";
													htmlstr += "<td width=\"135\" ><label>GPS数据提取间隔：</label></td>";
													htmlstr += "<td ><input type=\"text\" id=\"deviceMgt-paramCfg-GPSParseInerval\" style=\"width:130px; \" class=\" \" /><span>&nbsp;秒（0表示不发送）</span></td>";
												htmlstr += "</tr>";
												
												htmlstr += "<tr>";
													htmlstr += "<td colspan=\"2\">";
														htmlstr += "<span id=\"deviceMgt-paramCfg-enableGPSData-box\" ><input type=\"checkbox\" id=\"deviceMgt-paramCfg-enableGPSData\"><label for=\"deviceMgt-paramCfg-enableGPSData\">存储GPS数据</label></span>";  
													htmlstr += "</td>";
												htmlstr += "</tr>";
												
												htmlstr += "<tr>";
													htmlstr += "<td colspan=\"2\">";
														htmlstr += "<span id=\"deviceMgt-paramCfg-enableGPSBuffer-box\" ><input type=\"checkbox\" id=\"deviceMgt-paramCfg-enableGPSBuffer\"><label for=\"deviceMgt-paramCfg-enableGPSBuffer\">使能GPS数据上线补传</label></span>";
													htmlstr += "</td>";
												htmlstr += "</tr>";
												
												htmlstr += "<tr>";
													htmlstr += "<td width=\"135\" ><label>离线GPS数据保存间隔：</label></td>";
													htmlstr += "<td ><input type=\"text\" id=\"deviceMgt-paramCfg-GPSBufferCycle\" style=\"width:130px; \" class=\" \" /><span>&nbsp;秒</span></td>";
												htmlstr += "</tr>";
												
												htmlstr += "<tr>";
													htmlstr += "<td width=\"135\" ><label>低速报警间隔：</label></td>";
													htmlstr += "<td ><input type=\"text\" id=\"deviceMgt-paramCfg-LowSpeedAlarmInterval\" style=\"width:130px; \" class=\" \" /><span>&nbsp;秒</span></td>";
												htmlstr += "</tr>";
												
												htmlstr += "<tr>";
													htmlstr += "<td width=\"135\" ><label>电子围栏报警间隔：</label></td>";
													htmlstr += "<td ><input type=\"text\" id=\"deviceMgt-paramCfg-ERailAlarmInterval\" style=\"width:130px; \" class=\" \" /><span>&nbsp;秒</span></td>";
												htmlstr += "</tr>";
												
												htmlstr += "<tr>";
													htmlstr += "<td width=\"135\" ><label>线路偏离报警间隔：</label></td>";
													htmlstr += "<td ><input type=\"text\" id=\"deviceMgt-paramCfg-LineDepartAlarmInterval\" style=\"width:130px; \" class=\" \" /><span>&nbsp;秒</span></td>";
												htmlstr += "</tr>"; 
												
											htmlstr += "</table>";
											
										htmlstr += "</fieldset></div>";
									htmlstr += "</div>";	
										
								htmlstr += "</div>";
								
							htmlstr += "</div>";
							
						htmlstr += "</div>";
						break;
					
					case Nrcap2.Enum.PuResourceType.AudioIn:
						this.curDeviceContainerId = "device-mgt-audioin";
						this.curDeviceNavId = "dm-audioin-nav-paramCfg";
						 
						htmlstr += "<div id=\"device-mgt-audioin\" class=\"device-mgt-box\" >";
							// top nav pad
							htmlstr += "<div id=\"dm-audioin-nav-pad\" class=\"device-nav-pad\" >";
								htmlstr += "<div id=\"dm-audioin-nav-paramCfg\" class=\"nav-mousedown\" style=\"width:55px;display:"+display+";\" >参数设置</div>"; 
							htmlstr += "</div>";
							
							// main pad
							htmlstr += "<div id=\"dm-audioin-main-pad\" class=\"device-main-pad\" >";
								// 1. paramCfg
								htmlstr += "<div id=\"dm-audioin-main-paramCfg\" class=\"main-body\"> ";
									htmlstr += "<div style=\"width:400px; height:300px; float:left;display:"+display+";\" >";
										// 编码参数
										htmlstr += "<div style=\"width:400px; height:50px; float:left; margin-top:5px; border:0px red solid;\"><fieldset style=\"width:385px; height:40px;\">";
											htmlstr += "<legend>编码参数</legend>";
											
											htmlstr += "<table width=\"380\" height=\"30\" align=\"center\" cellspacing=\"0\" cellpadding=\"0\">";	
												htmlstr += "<tr>";
													htmlstr += "<td width=\"125\" ><label>编码方式：</label></td>";
													htmlstr += "<td ><select id=\"deviceMgt-paramCfg-encodeMode\" style=\"width:250px; \" ></select> </td>";
												htmlstr += "</tr>"; 
											htmlstr += "</table>";
											
										htmlstr += "</fieldset></div>";
										
										// 采集参数
										htmlstr += "<div style=\"width:400px; height:160px; float:left; margin-top:5px; border:0px red solid;\"><fieldset style=\"width:385px; height:155px;\">";
											htmlstr += "<legend>采集参数</legend>" 
											
											htmlstr += "<table width=\"380\" height=\"145\" align=\"center\" cellspacing=\"0\" cellpadding=\"0\">";	
												htmlstr += "<tr>";
													htmlstr += "<td width=\"125\" ><label>输入模式：</label></td>";
													htmlstr += "<td ><select id=\"deviceMgt-paramCfg-inputMode\" style=\"width:250px; \" ></select></td>";
												htmlstr += "</tr>"; 
												
												htmlstr += "<tr>";
													htmlstr += "<td width=\"125\" ><label>声道数：</label></td>";
													htmlstr += "<td ><input id=\"deviceMgt-paramCfg-channelNum\" style=\"width:245px; \" /></td>";
												htmlstr += "</tr>"; 
												
												htmlstr += "<tr>";
													htmlstr += "<td width=\"125\" ><label>采样率：</label></td>";
													htmlstr += "<td ><select id=\"deviceMgt-paramCfg-sampleRate\" style=\"width:250px; \" ></select></td>";
												htmlstr += "</tr>"; 
												
												htmlstr += "<tr>";
													htmlstr += "<td width=\"125\" ><label>音量(0&rarr;100)：</label></td>";
													htmlstr += "<td >";
														htmlstr += "<div style=\"width:40px;float:left;\"><input id=\"deviceMgt-paramCfg-volume\" style=\"width:30px;\" maxlength=\"3\" /></div>";
														htmlstr += "<div id=\"deviceMgt-paramCfg-volume-slider\" tabIndex=\"1\" style=\"width:210px;height:18px;line-height:18px;vertical-align:center;margin-top:2px;float:left;background:Transparent;border:0px #ffffff solid;\" ><div id=\"deviceMgt-paramCfg-volume-slider-input\"></div></div>";
													htmlstr += "</td>";
												htmlstr += "</tr>"; 
												
											htmlstr += "</table>";
											
										htmlstr += "</fieldset></div>";
										
										htmlstr += "<div style=\"width:400px; height:50px; float:left; margin-top:10px; border:0px red solid;\">"
											htmlstr += "<input type=\"button\" id=\"deviceMgt-paramCfg-tryListening\" value=\"试听\" style=\"width:80;height:35px;\" />";
										
										htmlstr += "</div>";
										
									htmlstr += "</div>";	
										
								htmlstr += "</div>";
								
							htmlstr += "</div>";
						htmlstr += "</div>";
						
						break;
					
					case Nrcap2.Enum.PuResourceType.AudioOut:
						this.curDeviceContainerId = "device-mgt-audioout";
						this.curDeviceNavId = "dm-audioout-nav-info";
						
						htmlstr += "";
						break;
					
					case Nrcap2.Enum.PuResourceType.AlertIn:
						this.curDeviceContainerId = "device-mgt-alertin";
						this.curDeviceNavId = "dm-alertin-nav-info";
						
						htmlstr += "";
						break;
					
					case Nrcap2.Enum.PuResourceType.AlertOut:
						this.curDeviceContainerId = "device-mgt-alertout";
						this.curDeviceNavId = "dm-alertout-nav-info";
						
						htmlstr += "";
						break;
					
					case Nrcap2.Enum.PuResourceType.VideoIn:  
						this.curDeviceContainerId = "device-mgt-videoin";
						this.curDeviceNavId = "dm-videoin-nav-baseParam";
						 
						htmlstr += "<div id=\"device-mgt-videoin\" class=\"device-mgt-box\" >";
							// top nav pad
							htmlstr += "<div id=\"dm-videoin-nav-pad\" class=\"device-nav-pad\" >";
								htmlstr += "<div id=\"dm-videoin-nav-baseParam\" class=\"nav-mousedown\" webclienttype=\"dm-nav\" style=\"width:55px;display:"+display+";\" >基本参数</div>"; 
								htmlstr += "<div id=\"dm-videoin-nav-captureParam\" class=\"nav-mouseout\" webclienttype=\"dm-nav\" style=\"width:55px;display:"+display+";\" >采集参数</div>"; 
								htmlstr += "<div id=\"dm-videoin-nav-encodeParam\" class=\"nav-mouseout\" webclienttype=\"dm-nav\" style=\"width:55px;display:"+display+";\" >编码参数</div>"; 
								htmlstr += "<div id=\"dm-videoin-nav-motionDetetion\" class=\"nav-mouseout\" webclienttype=\"dm-nav\" style=\"width:55px;display:"+display+";\" >移动侦测</div>"; 
								htmlstr += "<div id=\"dm-videoin-nav-coverRegions\" class=\"nav-mouseout\" webclienttype=\"dm-nav\" style=\"width:55px;display:"+display+";\" >区域屏蔽</div>"; 
								htmlstr += "<div id=\"dm-videoin-nav-snapshot\" class=\"nav-mouseout\" webclienttype=\"dm-nav\" style=\"width:35px;display:"+display+";\" >抓拍</div>"; 
								htmlstr += "<div id=\"dm-videoin-nav-frontStorage\" class=\"nav-mouseout\" webclienttype=\"dm-nav\" style=\"width:55px;display:"+display+";\" >前端存储</div>"; 
							htmlstr += "</div>";
							
							// main pad
							htmlstr += "<div id=\"dm-videoin-main-pad\" class=\"device-main-pad\" >";
								// 1. baseParam
								htmlstr += "<div id=\"dm-videoin-main-baseParam\" class=\"main-body\" style=\"display:"+display+"\";> ";
								//htmlstr += "<div id=\"dm-videoin-main-baseParam\" class=\"main-body\" style=\"display:block;\";> ";
								
									htmlstr += "<div style=\"width:380px; height:300px; margin-top:5px; border:0px #ffffff solid; float:left;\" >"; 
										htmlstr += "<fieldset><table width=\"370\" height=\"240\" align=\"center\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";					
											htmlstr += "<tr>";
												htmlstr += "<td width=\"135\" ><label>摄像头状态：</label></td>";
												htmlstr += "<td ><input id=\"deviceMgt-baseParam-cameraStatus\" type=\"text\" style=\"width:195px; \" class=\"input-readonly\" readOnly /></td>";
											htmlstr += "</tr>"; 
											
											htmlstr += "<tr>";
												htmlstr += "<td width=\"135\" ><label>压缩方式：</label></td>";
												htmlstr += "<td ><select id=\"deviceMgt-baseParam-encodeMode\" style=\"width:200px; \" ></select></td>";
											htmlstr += "</tr>"; 
											
											htmlstr += "<tr>";
												htmlstr += "<td colspan=\"2\">";
													htmlstr += "<fieldset style=\" height:100px;\">";
														htmlstr += "<legend>昼夜转换</legend>" 
														
														htmlstr += "<table width=\"335\" height=\"90\" align=\"center\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
															htmlstr += "<tr>";
																htmlstr += "<td width=\"135\">";
																	htmlstr += "<input type=\"checkbox\" id=\"deviceMgt-baseParam-EnableNightParam\" />";  													htmlstr += "<label for=\"deviceMgt-baseParam-EnableNightParam\">支持夜间参数</label>"; 
																htmlstr += "</td><td></td>";
															htmlstr += "</tr>";  
															
															htmlstr += "<tr>";
																htmlstr += "<td width=\"135\" ><label>夜间到白天转换时刻：</label></td>";
																htmlstr += "<td ><input id=\"deviceMgt-baseParam-nightToDayTime\" type=\"text\" style=\"width:50px; \" value=\"06:00\" onClick=\"WdatePicker({el:this.id, dateFmt:'HH:mm', isShowToday:false });\" />&nbsp;<img id=\"deviceMgt-baseParam-nightToDayTime-img\" src=\"images/calender.png\" onClick=\"WdatePicker({el:'deviceMgt-baseParam-nightToDayTime', dateFmt:'HH:mm', isShowToday:false });\" align=\"absmiddle\" style=\"width:20px;height:18px;cursor:pointer;\" /></td>";
															htmlstr += "</tr>";  
															
															htmlstr += "<tr>";
																htmlstr += "<td width=\"135\" ><label>白天到夜间转换时刻：</label></td>";
																htmlstr += "<td ><input id=\"deviceMgt-baseParam-dayToNightTime\" type=\"text\" style=\"width:50px; \" value=\"18:00\" onClick=\"WdatePicker({el:this.id, dateFmt:'HH:mm', isShowToday:false });\" />&nbsp;<img id=\"deviceMgt-baseParam-dayToNightTime-img\" src=\"images/calender.png\" onClick=\"WdatePicker({el:'deviceMgt-baseParam-dayToNightTime', dateFmt:'HH:mm', isShowToday:false });\" align=\"absmiddle\" style=\"width:20px;height:18px;cursor:pointer;\" /></td>";
															htmlstr += "</tr>"; 
															
														htmlstr += "</table>";
														
													htmlstr += "</fieldset>"; 
													
												htmlstr += "</td>";
											htmlstr += "</tr>"; 
											
											htmlstr += "<tr>";
												htmlstr += "<td width=\"135\">";
													htmlstr += "<input type=\"checkbox\" id=\"deviceMgt-baseParam-EnableCoverAlarm\" />";  													htmlstr += "<label for=\"deviceMgt-baseParam-EnableCoverAlarm\">启用遮挡报警</label>"; 
												htmlstr += "</td><td></td>";
											htmlstr += "</tr>"; 
											
											htmlstr += "<tr>";
												htmlstr += "<td width=\"135\" ><label>遮挡报警灵敏度：</label></td>";
												htmlstr += "<td ><input id=\"deviceMgt-baseParam-CoverAlarmSensitivity\" type=\"text\" style=\"width:195px; \" /></td>";
											htmlstr += "</tr>"; 
											
											
										htmlstr += "</table></fieldset>";
										
									htmlstr += "</div>";	
										
								htmlstr += "</div>"; // e
								
								// 2. captureParam 
								//htmlstr += "<div id=\"dm-videoin-main-captureParam\" class=\"main-body\" style=\"display:"+display+"\";> ";
								htmlstr += "<div id=\"dm-videoin-main-captureParam\" class=\"main-body\" style=\"display:none;\";> ";
									htmlstr += "<div style=\"width:380px; height:480px; margin-top:5px; border:0px #ffffff solid; float:left;\" >";
										htmlstr += "<table width=\"375\" height=\"470\" align=\"center\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
											htmlstr += "<tr>";
												htmlstr += "<td width=\"80\" ><label>视频制式：</label></td>";
												htmlstr += "<td width=\"295\"><select id=\"deviceMgt-captureParam-CurrentAnalogFormat\"  style=\"width:135px; \" ></select></td>";
											htmlstr += "</tr>"; 
											
											htmlstr += "<tr>";
												htmlstr += "<td colspan=\"2\">";
												
													htmlstr += "<fieldset style=\"width:355px;height:210px;\">";
														htmlstr += "<legend>";
															htmlstr += "<label>采集参数</label>";
															htmlstr += "<select id=\"deviceMgt-captureParam-timeRound\">";
																htmlstr += "<option value=\"Day\" selected>白天</option>";
																htmlstr += "<option value=\"Night\">夜晚</option>";
															htmlstr += "</select>";
														htmlstr += "</legend>";
														
														htmlstr += "<table width=\"345\" height=\"190\" align=\"center\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";	
															htmlstr += "<tr>";
																htmlstr += "<td width=\"125\" ><label>亮度(0&rarr;100)：</label></td>";
																htmlstr += "<td width=\"220\">"
																	htmlstr += "<div style=\"width:45px;float:left;\"><input id=\"deviceMgt-captureParam-brightness\" style=\"width:30px;\" maxlength=\"3\" /></div>";
																	htmlstr += "<div id=\"deviceMgt-captureParam-brightness-slider\" tabIndex=\"1\" style=\"width:175px;height:18px;line-height:18px;vertical-align:center;margin-top:2px;float:left;background:Transparent;border:0px #ffffff solid;\" ><div id=\"deviceMgt-captureParam-brightness-slider-input\"></div></div>";
																htmlstr += "</td>";
															htmlstr += "</tr>"; 
															
															htmlstr += "<tr>";
																htmlstr += "<td width=\"125\" ><label>对比度(0&rarr;100)：</label></td>";
																htmlstr += "<td width=\"220\">"
																	htmlstr += "<div style=\"width:45px;float:left;\"><input id=\"deviceMgt-captureParam-contrast\" style=\"width:30px;\" maxlength=\"3\" /></div>";
																	htmlstr += "<div id=\"deviceMgt-captureParam-contrast-slider\" tabIndex=\"1\" style=\"width:175px;height:18px;line-height:18px;vertical-align:center;margin-top:2px;float:left;background:Transparent;border:0px #ffffff solid;\" ><div id=\"deviceMgt-captureParam-contrast-slider-input\"></div></div>";
																htmlstr += "</td>";
															htmlstr += "</tr>";
															
															htmlstr += "<tr>";
																htmlstr += "<td width=\"125\" ><label>色调(0&rarr;100)：</label></td>";
																htmlstr += "<td width=\"220\">"
																	htmlstr += "<div style=\"width:45px;float:left;\"><input id=\"deviceMgt-captureParam-hue\" style=\"width:30px;\" maxlength=\"3\" /></div>";
																	htmlstr += "<div id=\"deviceMgt-captureParam-hue-slider\" tabIndex=\"1\" style=\"width:175px;height:18px;line-height:18px;vertical-align:center;margin-top:2px;float:left;background:Transparent;border:0px #ffffff solid;\" ><div id=\"deviceMgt-captureParam-hue-slider-input\"></div></div>";
																htmlstr += "</td>";
															htmlstr += "</tr>";
															
															htmlstr += "<tr>";
																htmlstr += "<td width=\"125\" ><label>饱和度(0&rarr;100)：</label></td>";
																htmlstr += "<td width=\"220\">"
																	htmlstr += "<div style=\"width:45px;float:left;\"><input id=\"deviceMgt-captureParam-saturation\" style=\"width:30px;\" maxlength=\"3\" /></div>";
																	htmlstr += "<div id=\"deviceMgt-captureParam-saturation-slider\" tabIndex=\"1\" style=\"width:175px;height:18px;line-height:18px;vertical-align:center;margin-top:2px;float:left;background:Transparent;border:0px #ffffff solid;\" ><div id=\"deviceMgt-captureParam-saturation-slider-input\"></div></div>";
																htmlstr += "</td>";
															htmlstr += "</tr>";
															
															htmlstr += "<tr>";
																htmlstr += "<td width=\"125\" ><label>预处理方式：</label></td>";
																htmlstr += "<td width=\"220\"><select id=\"deviceMgt-captureParam-Preprocessor\" style=\"width:215px; \" ></select></td>";
															htmlstr += "</tr>"; 
															
														htmlstr += "</table>"; 
														
													htmlstr += "</fieldset>";
													
												htmlstr += "</td>";
											htmlstr += "</tr>"; 
											
											htmlstr += "<tr>";
												htmlstr += "<td colspan=\"2\">";
													
													htmlstr += "<fieldset style=\"width:355px;height:210px;\">";
														htmlstr += "<legend>叠加参数</legend>";  
														
														htmlstr += "<table width=\"345\" height=\"190\" align=\"center\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
															htmlstr += "<tr>";
																htmlstr += "<td width=\"80\" ><label>时间位置：</label></td>";
																htmlstr += "<td width=\"130\" align=\"right\"><span>";
																	htmlstr += "<label>X(0&rarr;351)：</label>";
																	htmlstr += "<input type=\"text\" id=\"deviceMgt-captureParam-TimeAddPosition-X\" style=\"width:50px;\" maxlength=\"3\" />";
																htmlstr += "</span></td>";
																htmlstr += "<td width=\"130\" align=\"right\"><span>";
																	htmlstr += "<label>Y(0&rarr;351)：</label>";
																	htmlstr += "<input type=\"text\" id=\"deviceMgt-captureParam-TimeAddPosition-Y\" style=\"width:50px;\" maxlength=\"3\" />";
																htmlstr += "</span></td>";
															htmlstr += "</tr>"; 
															
															htmlstr += "<tr>";
																htmlstr += "<td width=\"80\" ><label>文字内容：</label></td>";
																htmlstr += "<td width=\"260\" colspan=\"2\" align=\"right\">";
																    htmlstr += "&nbsp;<input type=\"text\" id=\"deviceMgt-captureParam-TextAdd\" style=\"width:230px;\" />";
																htmlstr += "</td>";
															htmlstr += "</tr>"; 
															
															htmlstr += "<tr>";
																htmlstr += "<td width=\"80\" ><label>文字位置：</label></td>";
																htmlstr += "<td width=\"130\" align=\"right\"><span>";
																	htmlstr += "<label>X(0&rarr;351)：</label>";
																	htmlstr += "<input type=\"text\" id=\"deviceMgt-captureParam-TextAddPosition-X\" style=\"width:50px;\" maxlength=\"3\" />";
																htmlstr += "</span></td>";
																htmlstr += "<td width=\"130\" align=\"right\"><span>";
																	htmlstr += "<label>Y(0&rarr;351)：</label>";
																	htmlstr += "<input type=\"text\" id=\"deviceMgt-captureParam-TextAddPosition-Y\" style=\"width:50px;\" maxlength=\"3\" />";
																htmlstr += "</span></td>";
															htmlstr += "</tr>"; 
															
															htmlstr += "<tr>";
																htmlstr += "<td width=\"80\" ><label>图片路径：</label></td>";
																htmlstr += "<td width=\"260\" colspan=\"2\" align=\"right\">";
																    htmlstr += "&nbsp;<input type=\"text\" id=\"deviceMgt-captureParam-LogoAdd\" style=\"width:175px;\" />&nbsp;&nbsp;<input type=\"button\" id=\"deviceMgt-captureParam-LogoAdd-scan\" style=\"width:45px;\" value=\"浏览\" />";
																htmlstr += "</td>";
															htmlstr += "</tr>"; 
															
															htmlstr += "<tr>";
																htmlstr += "<td width=\"80\" ><label>图片位置：</label></td>";
																htmlstr += "<td width=\"130\" align=\"right\"><span>";
																	htmlstr += "<label>X(0&rarr;351)：</label>";
																	htmlstr += "<input type=\"text\" id=\"deviceMgt-captureParam-LogoAddPosition-X\" style=\"width:50px;\" maxlength=\"3\" />";
																htmlstr += "</span></td>";
																htmlstr += "<td width=\"130\" align=\"right\"><span>";
																	htmlstr += "<label>Y(0&rarr;351)：</label>";
																	htmlstr += "<input type=\"text\" id=\"deviceMgt-captureParam-LogoAddPosition-Y\" style=\"width:50px;\" maxlength=\"3\" />";
																htmlstr += "</span></td>";
															htmlstr += "</tr>"; 
															
															htmlstr += "<tr>";
																htmlstr += "<td colspan=\"3\">";
																	htmlstr += "<input type=\"checkbox\" id=\"deviceMgt-captureParam-AddGPSAlarm\" />";  													htmlstr += "<label for=\"deviceMgt-captureParam-AddGPSAlarm\">速度报警时警告色叠加GPS</label>"; 
																htmlstr += "</td>";
															htmlstr += "</tr>"; 
															
														htmlstr += "</table>"; 
														
													htmlstr += "</fieldset>";
													
												htmlstr += "</td>";
											htmlstr += "</tr>"; 
											
										htmlstr += "</table>";
									
									htmlstr += "</div>";	
										
								htmlstr += "</div>"; // e	
								
								// 3. encodeParam  
								htmlstr += "<div id=\"dm-videoin-main-encodeParam\" class=\"main-body\" style=\"display:none;\";> ";
									htmlstr += "<div style=\"width:380px; height:470px; margin-top:5px; border:0px #ffffff solid; float:left;\" >";
										htmlstr += "[编码参数]暂未添加";
									htmlstr += "</div>";	
										
								htmlstr += "</div>"; // e	
								
								// 4. motionDetetion  
								htmlstr += "<div id=\"dm-videoin-main-motionDetetion\" class=\"main-body\" style=\"display:none;\";> ";
									htmlstr += "<div style=\"width:380px; height:470px; margin-top:5px; border:0px #ffffff solid; float:left;\" >";
										htmlstr += "[移动侦测]暂未添加";
									htmlstr += "</div>";	
										
								htmlstr += "</div>"; // e
								
								// 5. coverRegions  
								htmlstr += "<div id=\"dm-videoin-main-coverRegions\" class=\"main-body\" style=\"display:none;\";> ";
									htmlstr += "<div style=\"width:380px; height:470px; margin-top:5px; border:0px #ffffff solid; float:left;\" >";
										htmlstr += "[区域屏蔽]暂未添加";
									htmlstr += "</div>";	
										
								htmlstr += "</div>"; // e
								
								// 6. snapshot  
								htmlstr += "<div id=\"dm-videoin-main-snapshot\" class=\"main-body\" style=\"display:none;\";> ";
									htmlstr += "<div style=\"width:380px; height:470px; margin-top:5px; border:0px #ffffff solid; float:left;\" >";
										htmlstr += "[抓拍]暂未添加";
									htmlstr += "</div>";	
										
								htmlstr += "</div>"; // e
								
								// 7. frontStorage  
								htmlstr += "<div id=\"dm-videoin-main-frontStorage\" class=\"main-body\" style=\"display:none;\";> ";
									htmlstr += "<div style=\"width:380px; height:470px; margin-top:5px; border:0px #ffffff solid; float:left;\" >";
										htmlstr += "[前端存储]暂未添加";
									htmlstr += "</div>";	
										
								htmlstr += "</div>"; // e
								
							htmlstr += "</div>";
						htmlstr += "</div>";
						
						break;
					
					case Nrcap2.Enum.PuResourceType.VideoOut:
						this.curDeviceContainerId = "device-mgt-videoout";
						this.curDeviceNavId = "dm-videoout-nav-info";
						
						htmlstr += "";
						break;
					
					case Nrcap2.Enum.PuResourceType.PTZ:
						this.curDeviceContainerId = "device-mgt-ptz";
						this.curDeviceNavId = "dm-ptz-nav-info";
						
						htmlstr += "";
						break;
					
					case Nrcap2.Enum.PuResourceType.Storager:
						this.curDeviceContainerId = "device-mgt-storager";
						this.curDeviceNavId = "dm-storager-nav-info";
						
						htmlstr += "";
						break;
					
					case Nrcap2.Enum.PuResourceType.SC:
						this.curDeviceContainerId = "device-mgt-sc";
						this.curDeviceNavId = "dm-sc-nav-info";
						
						htmlstr += "";
						break;
					
					case Nrcap2.Enum.PuResourceType.SerialPort:
						this.curDeviceContainerId = "device-mgt-serialport";
						this.curDeviceNavId = "dm-serialport-nav-info";
						
						htmlstr += "";
						break;
					
					case Nrcap2.Enum.PuResourceType.Wireless:
						this.curDeviceContainerId = "device-mgt-wireless";
						this.curDeviceNavId = "dm-wireless-nav-info";
						
						htmlstr += "";
						break;
					
					default:
						WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.DeviceResource.MainRegionInit",msg:"resType(" + resType + ") unknown error!"});
						return false;
						break;
					
				} 
				
				if($("deviceMainRegion")) $("deviceMainRegion").innerHTML = htmlstr;
				
				if(resType && resType == Nrcap2.Enum.PuResourceType.AudioIn)
				{
					// 创建volume-slider-bar -> dm-ia-volume
					this.SliderBars.set(
						"dm-ia-volume",
						{ 
							title:null,
							bar:null,
							puid:null,
							idx:0,
							input:null,
							originalValue:0,
							SetStatus:function(status, puid, idx){
								this.bar.setStatus(status);
								if(!status)
								{
									//this.title.style.color = "#A0A0A0";
									this.input.disabled = true;
									this.originalValue = 0;
									this.bar.setValue(this.originalValue);
									this.input.value = this.originalValue;
									this.puid = null;
									this.idx = 0;
								}
								else
								{
									if(!puid || typeof idx == "undefined")
									{
										return false;	
									}
									this.puid = puid; 
									this.idx = idx; 
									//this.title.style.color = "#000000";
									this.input.disabled = false;
									 
									if(WebClient.connectId)
									{
										var rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, Nrcap2.Enum.PuResourceType.AudioIn, idx, "CFG_IA_Volume", ""); // alert(rv);
										if(parseInt(rv) >= 0 && parseInt(rv) <= 100)
										{
											this.originalValue = rv; 
										}
										else
										{
											this.originalValue = 0; 
										}
										this.input.value = this.originalValue;
										this.bar.setValue(this.originalValue);
										
										var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-audioin-nav-paramCfg"; // alert(curdnId); 
										var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get("device-mgt-audioin");  //  alert(Object.toJSON(totalCommonInfo));   
										var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
										var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
										
										childResource.get("deviceMgt-paramCfg-volume").original = this.originalValue;
										childResource.get("deviceMgt-paramCfg-volume").newValue = this.originalValue;
										
									}
									
								}
							}, // end SetStatus
							callbacks:{
								mouseup:function(){
									var SliderBar = WebClient.Resource.DeviceResource.SliderBars.get("dm-ia-volume");
									
									if(SliderBar.originalValue != SliderBar.bar.getValue())
									{
										SliderBar.input.value = SliderBar.bar.getValue();
										SliderBar.input.onchange();
									}
								},
								
								blur:function(){
									var SliderBar = WebClient.Resource.DeviceResource.SliderBars.get("dm-ia-volume");
									
									if(SliderBar.originalValue != SliderBar.bar.getValue())
									{ 
										SliderBar.input.value = SliderBar.bar.getValue();
										SliderBar.input.onchange();
									}
								},
								
								end:true
							},
							
							end:true  
						}
					);
					
					var SliderBar = this.SliderBars.get("dm-ia-volume");
					
					SliderBar.bar = new Slider($("deviceMgt-paramCfg-volume-slider"),$("deviceMgt-paramCfg-volume-slider-input"),null,SliderBar.callbacks);
					
					SliderBar.bar.setMaximum(100);
					
					SliderBar.input = $("deviceMgt-paramCfg-volume");
					
					SliderBar.input.onchange = function(){   
						var value = this.value;
						if(!/^\d+$/.test(value) || parseInt(value) < 0 || parseInt(value) > 100)
						{ 
							this.value = value = SliderBar.originalValue; 
						}
						SliderBar.bar.setValue(parseInt(value));   
						 
						if(value == null || typeof value == "undefined") return false;
						
						var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-audioin-nav-paramCfg"; // alert(curdnId); 
						var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(WebClient.Resource.DeviceResource.curDeviceContainerId);  //  alert(Object.toJSON(totalCommonInfo));   
						var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
						var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
						
						if(childResource.get(this.id))
						{
							if(childResource.get(this.id).original != childResource.get(this.id).newValue)
							{
								if(common.count > 0) common.count--;
							}
							
							childResource.get(this.id).newValue = value; 
							
							if(childResource.get(this.id).original != value)
							{  
								common.count++;
							}
						} 
						 
					}; 
					
				}
				else if(resType && resType == Nrcap2.Enum.PuResourceType.VideoIn)
				{
					WebClient.Resource.DeviceResource.SliderBars = new Hash(); // 重新初始slider信息
				}
		 
			 	this.AttachDResEvent(puid, resType, resIdx); // 绑定相关事件
				 
				this.SwitchFetchDRes(puid, resType, resIdx); // 切换获取设备相关信息
			},
			
			CreateDeviceMgtSliderBar:function(sliderName, puid, resType, resIdx){
				if(!sliderName || typeof sliderName == "undefined")
				{
					return false;
				}
			 
				if(this.SliderBars.get(sliderName))
				{
					return false;
				} 
				
				var configId = ""; 
				
				this.SliderBars.set(
					sliderName,
					{ 
						title:null,
						bar:null,
						puid:null,
						idx:0,
						input:null,
						originalValue:0,
						SetStatus:function(status, puid, idx, type){
							this.bar.setStatus(status);
							if(!status)
							{
								//this.title.style.color = "#A0A0A0";
								this.input.disabled = true;
								this.originalValue = 0;
								this.bar.setValue(this.originalValue);
								this.input.value = this.originalValue;
								this.puid = null;
								this.idx = 0;
							}
							else
							{
								if(!puid || typeof idx == "undefined")
								{
									return false;	
								}
								this.puid = puid; 
								this.idx = idx; 
								//this.title.style.color = "#000000";
								this.input.disabled = false;
 												
								switch(sliderName)
								{
									case "brightness": configId = "CFG_IV_Brightness";
										break;
									case "contrast": configId = "CFG_IV_Contrast";
										break;
									case "hue": configId = "CFG_IV_Hue";
										break;
									case "saturation": configId = "CFG_IV_Saturation";
										break;
									default: return;
										break; 
								} 
								
								if(type && type == "Night")
								{
									configId += "N";
								}
								 
								if(WebClient.connectId)
								{
									var rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, Nrcap2.Enum.PuResourceType.VideoIn, idx, configId, "");  // alert(rv);
									if(parseInt(rv) >= 0 && parseInt(rv) <= 100)
									{
										this.originalValue = rv; 
									}
									else
									{
										this.originalValue = 0; 
									}
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-videoin-nav-captureParam"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get("device-mgt-videoin");  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									
									if(childResource.get("deviceMgt-captureParam-" + sliderName))
									{
										if(childResource.get("deviceMgt-captureParam-" + sliderName).original != childResource.get("deviceMgt-captureParam-" + sliderName).newValue)
										{
											if(common.count > 0) common.count--;
										}
										childResource.get("deviceMgt-captureParam-" + sliderName).original = this.originalValue;
										childResource.get("deviceMgt-captureParam-" + sliderName).newValue = this.originalValue;
									} 
									
									this.input.value = this.originalValue;
									this.bar.setValue(this.originalValue);    
								}
								
							}
						}, // end SetStatus
						callbacks:{
							mouseup:function(){
								var SliderBar = WebClient.Resource.DeviceResource.SliderBars.get(sliderName);
								
								if(SliderBar.originalValue != SliderBar.bar.getValue())
								{
									SliderBar.input.value = SliderBar.bar.getValue();
									SliderBar.input.onchange();
								}
							},
							
							blur:function(){
								var SliderBar = WebClient.Resource.DeviceResource.SliderBars.get(sliderName);
								
								if(SliderBar.originalValue != SliderBar.bar.getValue())
								{ 
									SliderBar.input.value = SliderBar.bar.getValue();
									SliderBar.input.onchange();
								}
							},
							
							end:true
						},
						
						end:true  
					}
				);
				
				var SliderBar = this.SliderBars.get(sliderName);
					
				SliderBar.bar = new Slider($("deviceMgt-captureParam-" + sliderName +"-slider"),$("deviceMgt-captureParam-" + sliderName +"-slider-input"),null,SliderBar.callbacks);
				
				SliderBar.bar.setMaximum(100);
				
				SliderBar.input = $("deviceMgt-captureParam-" + sliderName);
				
				SliderBar.input.onchange = function(){   
					var value = this.value;
					if(!/^\d+$/.test(value) || parseInt(value) < 0 || parseInt(value) > 100)
					{ 
						this.value = value = SliderBar.originalValue; 
					}
					SliderBar.bar.setValue(parseInt(value));   
					 
					if(value == null || typeof value == "undefined") return false;
					
					var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-videoin-nav-captureParam"; // alert(curdnId); 
					var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(WebClient.Resource.DeviceResource.curDeviceContainerId);  //  alert(Object.toJSON(totalCommonInfo));   
					var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
					var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
					
					if(childResource.get(this.id))
					{
						if(childResource.get(this.id).original != childResource.get(this.id).newValue)
						{
							if(common.count > 0) common.count--;
						}
						
						childResource.get(this.id).newValue = value; 
						
						if(childResource.get(this.id).original != value)
						{  
							common.count++;
						}
					}  
				};
				
				SliderBar.SetStatus(true);
			},
			
			/* 刷新相关参数的sliderbar */
			RefreshFetchCaptureParam:function(puid, resType, resIdx, type){
				var SliderBar = this.SliderBars.get("brightness");
				SliderBar.SetStatus(true, puid, resIdx, type);
				SliderBar = this.SliderBars.get("contrast");
				SliderBar.SetStatus(true, puid, resIdx, type);
				SliderBar = this.SliderBars.get("hue");
				SliderBar.SetStatus(true, puid, resIdx, type);
				SliderBar = this.SliderBars.get("saturation");
				SliderBar.SetStatus(true, puid, resIdx, type);  
			},
			
			CommonInfoControl:function(type, resType, puid, resIdx, objId, value){
				var curdcId = this.curDeviceContainerId; // alert(curdcId); 
				
				WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"..CommonInfoControl",msg:"curDeviceContainerId:" + curdcId });
				
				switch(type)
				{
					case "init":
						totalCommonInfo = this.totalCommonInfo = new Hash(); 
						totalCommonInfo.set(curdcId,{key:curdcId, puid: puid, resType: resType, resIdx:resIdx, childResource: new Hash()});  
						this.CommonInfoControl("set", resType, puid, resIdx, objId, value);
						break;
					case "set":
						var totalCommonInfo = this.totalCommonInfo.get(curdcId).childResource;
						if(!totalCommonInfo || typeof totalCommonInfo != "object") return false;
						
						switch(resType)
						{
							case Nrcap2.Enum.PuResourceType.SELF: 	
								// 信息
								totalCommonInfo.set("dm-self-nav-info",{key:"dm-self-nav-info", count:0, childResource:new Hash()});
								var childRes = totalCommonInfo.get("dm-self-nav-info").childResource;
								childRes.set("deviceMgt-res-name",{key:"deviceMgt-res-name", original:"", newValue:""});
								childRes.set("deviceMgt-res-desc",{key:"deviceMgt-res-desc", original:"", newValue:""});
								
								childRes.set("deviceMgt-info-timeZone",{key:"deviceMgt-info-timeZone", original:"", newValue:""});
								childRes.set("deviceMgt-info-timeSyncInterval",{key:"deviceMgt-info-timeSyncInterval", original:"", newValue:""});
								childRes.set("deviceMgt-info-enableNTP",{key:"deviceMgt-info-enableNTP", original:"", newValue:""});
								childRes.set("deviceMgt-info-NTPServerAddr",{key:"deviceMgt-info-NTPServerAddr", original:"", newValue:""});
								childRes.set("deviceMgt-info-NTPSSyncInterval",{key:"deviceMgt-info-NTPSSyncInterval", original:"", newValue:""});
								
								// 网络
								totalCommonInfo.set("dm-self-nav-network",{key:"dm-self-nav-network", count:0, childResource:new Hash()});
								 
								break;
								
							case Nrcap2.Enum.PuResourceType.GPS:
						 		// 参数设置
								totalCommonInfo.set("dm-gps-nav-paramCfg",{key:"dm-gps-nav-paramCfg", count:0, childResource:new Hash()});
								var childRes = totalCommonInfo.get("dm-gps-nav-paramCfg").childResource;
								childRes.set("deviceMgt-res-name",{key:"deviceMgt-res-name", original:"", newValue:""});
								childRes.set("deviceMgt-res-desc",{key:"deviceMgt-res-desc", original:"", newValue:""});
								childRes.set("deviceMgt-res-enable",{key:"deviceMgt-res-enable", original:"", newValue:""}); 
								
								childRes.set("deviceMgt-paramCfg-GPSSendCycle",{key:"deviceMgt-paramCfg-GPSSendCycle", original:"", newValue:""});
								childRes.set("deviceMgt-paramCfg-GPSParseInerval",{key:"deviceMgt-paramCfg-GPSParseInerval", original:"", newValue:""}); 
								childRes.set("deviceMgt-paramCfg-enableGPSData",{key:"deviceMgt-paramCfg-enableGPSData", original:"", newValue:""});
								childRes.set("deviceMgt-paramCfg-enableGPSBuffer",{key:"deviceMgt-paramCfg-enableGPSBuffer", original:"", newValue:""});
								childRes.set("deviceMgt-paramCfg-GPSBufferCycle",{key:"deviceMgt-paramCfg-GPSBufferCycle", original:"", newValue:""});
								childRes.set("deviceMgt-paramCfg-LowSpeedAlarmInterval",{key:"deviceMgt-paramCfg-LowSpeedAlarmInterval", original:"", newValue:""});
								childRes.set("deviceMgt-paramCfg-ERailAlarmInterval",{key:"deviceMgt-paramCfg-ERailAlarmInterval", original:"", newValue:""});
								childRes.set("deviceMgt-paramCfg-LineDepartAlarmInterval",{key:"deviceMgt-paramCfg-LineDepartAlarmInterval", original:"", newValue:""});
								break;
							
							case Nrcap2.Enum.PuResourceType.AudioIn:
								// 参数设置
								totalCommonInfo.set("dm-audioin-nav-paramCfg",{key:"dm-audioin-nav-paramCfg", count:0, childResource:new Hash()});
								var childRes = totalCommonInfo.get("dm-audioin-nav-paramCfg").childResource;
								childRes.set("deviceMgt-res-name",{key:"deviceMgt-res-name", original:"", newValue:""});
								childRes.set("deviceMgt-res-desc",{key:"deviceMgt-res-desc", original:"", newValue:""});
								childRes.set("deviceMgt-res-enable",{key:"deviceMgt-res-enable", original:"", newValue:""}); 
								
								childRes.set("deviceMgt-paramCfg-encodeMode",{key:"deviceMgt-paramCfg-encodeMode", original:"", newValue:""});
								childRes.set("deviceMgt-paramCfg-inputMode",{key:"deviceMgt-paramCfg-inputMode", original:"", newValue:""}); 
								childRes.set("deviceMgt-paramCfg-channelNum",{key:"deviceMgt-paramCfg-channelNum", original:"", newValue:""});
								childRes.set("deviceMgt-paramCfg-sampleRate",{key:"deviceMgt-paramCfg-sampleRate", original:"", newValue:""});
								childRes.set("deviceMgt-paramCfg-volume",{key:"deviceMgt-paramCfg-volume", original:"", newValue:""});
								 
								break;
							
							case Nrcap2.Enum.PuResourceType.AudioOut:
								 
								break;
							
							case Nrcap2.Enum.PuResourceType.AlertIn:
								 
								break;
							
							case Nrcap2.Enum.PuResourceType.AlertOut:
								 
								break;
							
							case Nrcap2.Enum.PuResourceType.VideoIn:
								// 基本参数 
								totalCommonInfo.set("dm-videoin-nav-baseParam",{key:"dm-videoin-nav-baseParam", count:0, childResource:new Hash()});
								var childRes = totalCommonInfo.get("dm-videoin-nav-baseParam").childResource;
								childRes.set("deviceMgt-res-name",{key:"deviceMgt-res-name", original:"", newValue:""});
								childRes.set("deviceMgt-res-desc",{key:"deviceMgt-res-desc", original:"", newValue:""});
								childRes.set("deviceMgt-res-enable",{key:"deviceMgt-res-enable", original:"", newValue:""});
								
								childRes.set("deviceMgt-baseParam-encodeMode",{key:"deviceMgt-baseParam-encodeMode", original:"", newValue:""});
								childRes.set("deviceMgt-baseParam-EnableNightParam",{key:"deviceMgt-baseParam-EnableNightParam", original:"", newValue:""});
								childRes.set("deviceMgt-baseParam-nightToDayTime",{key:"deviceMgt-baseParam-nightToDayTime", original:"", newValue:""});
								childRes.set("deviceMgt-baseParam-dayToNightTime",{key:"deviceMgt-baseParam-dayToNightTime", original:"", newValue:""});
								childRes.set("deviceMgt-baseParam-EnableCoverAlarm",{key:"deviceMgt-baseParam-EnableCoverAlarm", original:"", newValue:""});
								childRes.set("deviceMgt-baseParam-CoverAlarmSensitivity",{key:"deviceMgt-baseParam-CoverAlarmSensitivity", original:"", newValue:""});
								
								// 采集参数
								totalCommonInfo.set("dm-videoin-nav-captureParam",{key:"dm-videoin-nav-captureParam", count:0, childResource:new Hash()});
								var childRes = totalCommonInfo.get("dm-videoin-nav-captureParam").childResource;
								
								childRes.set("deviceMgt-captureParam-CurrentAnalogFormat",{key:"deviceMgt-captureParam-CurrentAnalogFormat", original:"", newValue:""});
								childRes.set("deviceMgt-captureParam-timeRound",{key:"deviceMgt-captureParam-timeRound", original:"", newValue:""});
								childRes.set("deviceMgt-captureParam-brightness",{key:"deviceMgt-captureParam-brightness", original:"", newValue:""});
								childRes.set("deviceMgt-captureParam-contrast",{key:"deviceMgt-captureParam-contrast", original:"", newValue:""});
								childRes.set("deviceMgt-captureParam-hue",{key:"deviceMgt-captureParam-hue", original:"", newValue:""});
								
								childRes.set("deviceMgt-captureParam-saturation",{key:"deviceMgt-captureParam-saturation", original:"", newValue:""});
								childRes.set("deviceMgt-captureParam-Preprocessor",{key:"deviceMgt-captureParam-Preprocessor", original:"", newValue:""});
								childRes.set("deviceMgt-captureParam-TimeAddPosition-X",{key:"deviceMgt-captureParam-TimeAddPosition-X", original:"", newValue:""});
								
								childRes.set("deviceMgt-captureParam-TimeAddPosition-Y",{key:"deviceMgt-captureParam-TimeAddPosition-Y", original:"", newValue:""});
								childRes.set("deviceMgt-captureParam-TextAdd",{key:"deviceMgt-captureParam-TextAdd", original:"", newValue:""});
								childRes.set("deviceMgt-captureParam-TextAddPosition-X",{key:"deviceMgt-captureParam-TextAddPosition-X", original:"", newValue:""});
								
								childRes.set("deviceMgt-captureParam-TextAddPosition-Y",{key:"deviceMgt-captureParam-TextAddPosition-Y", original:"", newValue:""});
								childRes.set("deviceMgt-captureParam-LogoAdd",{key:"deviceMgt-captureParam-LogoAdd", original:"", newValue:""});
								childRes.set("deviceMgt-captureParam-LogoAddPosition-X",{key:"deviceMgt-captureParam-LogoAddPosition-X", original:"", newValue:""});
								
								childRes.set("deviceMgt-captureParam-LogoAddPosition-Y",{key:"deviceMgt-captureParam-LogoAddPosition-Y", original:"", newValue:""});
								childRes.set("deviceMgt-captureParam-AddGPSAlarm",{key:"deviceMgt-captureParam-AddGPSAlarm", original:"", newValue:""});
								
								// 编码参数
								
								break;
							
							case Nrcap2.Enum.PuResourceType.VideoOut:
								 
								break;
							
							case Nrcap2.Enum.PuResourceType.PTZ:
								 
								break;
							
							case Nrcap2.Enum.PuResourceType.Storager:
								 
								break;
							
							case Nrcap2.Enum.PuResourceType.SC:
								 
								break;
							
							case Nrcap2.Enum.PuResourceType.SerialPort:
								 
								break;
							
							case Nrcap2.Enum.PuResourceType.Wireless:
								 
								break;
							
							default:
								WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"..CommonInfoControl",msg:"resType(" + resType + ") unknown error!"});
								return false;
								break;
						}
						
						// alert(Object.toJSON(this.totalCommonInfo));
						
						break;
					default:
						break;
				} 
				
				
			},
			
			AttachDResEvent:function(puid, resType, resIdx){
				//alert(puid + "," + resType + "," + resIdx);
				if(!puid || typeof puid == "undefined")
				{
					WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.DeviceResource.AttachDResEvent",msg:"puid error!"});
					return false;
				}
				if(!resType || typeof resType == "undefined")
				{
					WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.DeviceResource.AttachDResEvent",msg:"resType error!"});
					return false;
				} 
				if(resIdx == null || typeof resIdx == "undefined")
				{
					WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.DeviceResource.AttachDResEvent",msg:"resIdx error!"});
					return false;
				}
				
				$("mm_device_tool_submit").disabled = false;
				$("mm_device_tool_submit").style.backgroundImage = "url(images/blue/platform-mgt-submit.jpg)";
				
				// =>-s-------------------------------------------------------------------------------------- 
				var curdcId = this.curDeviceContainerId; // alert(curdcId);
				
				this.CommonInfoControl("init",resType, puid, resIdx ); /* 记录值 */ 
				 
				var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId; // alert(curdcId); 
				
				this.curDeviceNavInfos = new Hash(); // 每次都需重新声明
				// <=-e--------------------------------------------------------------------------------------	 
				
				switch(resType)
				{
					case Nrcap2.Enum.PuResourceType.SELF: 
						if($("deviceResInfoBox"))
						{
							if($("deviceMgt-res-name"))
							{
								$("deviceMgt-res-name").onchange = function(){
									var value = this.value.toString().strip(); // alert(tsi_value);
									if( value == null || typeof value == "undefined") return false; 
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-self-nav-info"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									}  
								};
							}
							if($("deviceMgt-res-desc"))
							{
								$("deviceMgt-res-desc").onchange = function(){
									var value = this.value.toString().strip(); // alert(tsi_value);
									if( value == null || typeof value == "undefined") return false; 
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-self-nav-info"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									}  
								};
							}
						}
						
						if($(curdcId) && curdcId == "device-mgt-self")
						{ 
							// =>--s-info-------------------------------------------------------------------------- 
							
							// 获取性能参数
							if($("deviceMgt-info-cpupercent-refresh") && $("deviceMgt-info-memory-refresh"))
							{
								$("deviceMgt-info-cpupercent-refresh").onclick = function(){
									var rv = Nrcap2.Control.CommonGet(WebClient.connectId, puid, resType, resIdx,"CTL_ST_GetPerformance","<param />",""); // alert(Object.toJSON(rv));
									if(rv && typeof rv == "object")
									{
										if(rv.CPUUsage != null && typeof rv.CPUUsage != "undefined") 
										{
											var offsetW = $$(".progress-container")[0].offsetWidth; // alert(offsetW);
											var width = Math.round(parseInt(rv.CPUUsage) * parseInt(offsetW) / 100);
											$("deviceMgt-info-cpupercent").style.width = width;
											$("deviceMgt-info-cpupercent-flag").innerHTML = rv.CPUUsage;
										}
										else
										{
											$("deviceMgt-info-cpupercent").style.width = "0";
											$("deviceMgt-info-cpupercent-flag").innerHTML = "";	
										}
									} 
								};
								
								$("deviceMgt-info-memory-refresh").onclick = function(){
									var rv = Nrcap2.Control.CommonGet(WebClient.connectId, puid, resType, resIdx,"CTL_ST_GetPerformance","<param />",""); // alert(Object.toJSON(rv));
									if(rv && typeof rv == "object")
									{
										if(rv.MemUsage != null && typeof rv.MemUsage != "undefined") 
										{
											var offsetW = $$(".progress-container")[1].offsetWidth; // alert(offsetW);
											var width = Math.round(parseInt(rv.MemUsage) * parseInt(offsetW) / 100);
											$("deviceMgt-info-memory").style.width = width;
											$("deviceMgt-info-memory-flag").innerHTML = rv.MemUsage;
										}	
										else
										{
											$("deviceMgt-info-memory").style.width = "0";
											$("deviceMgt-info-memory-flag").innerHTML = "";		
										}
									} 
								}; 
							}
							
							if($("deviceMgt-info-timeZone"))
							{
								$("deviceMgt-info-timeZone").onchange = function(){
									var tz_value = this.options[this.selectedIndex].value; // alert(tz_value);
									if(tz_value == null || typeof tz_value == "undefined") return false; 
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-self-nav-info"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = tz_value; 
										
										if(childResource.get(this.id).original != tz_value)
										{  
											common.count++;
										}
									}  
									
								};   
							}
							
							if($("deviceMgt-info-time-refresh"))
							{  
								$("deviceMgt-info-time-refresh").onclick = function(){
									var rv = Nrcap2.Control.CommonGet(WebClient.connectId, puid, resType, resIdx,"CTL_ST_GetTime","<Param />",""); // alert(Object.toJSON(rv));
								
									if(rv && typeof rv == "object")
									{
										var time = new Date().format("yyyy-MM-dd HH:mm:ss");
										
										if(rv.Time != null && typeof rv.Time != "undefined")
										{
											 time = new Date(parseInt(rv.Time) * 1000).format("yyyy-MM-dd HH:mm:ss");
										}
										else if(rv.Year != null && typeof rv.Year != "undefined")
										{
											 // alert(new Date(rv.Year, parseInt(rv.Month) - 1, rv.Date, rv.Hour, rv.Minute, rv.Second).format("yyyy-MM-dd HH:mm:ss"));
											 time = new Date(rv.Year, parseInt(rv.Month) - 1, rv.Date, rv.Hour, rv.Minute, rv.Second).format("yyyy-MM-dd HH:mm:ss");
										}
										// alert(time);
										$("deviceMgt-info-time").value = time;
									} 
								};  
							}
							
							if($("deviceMgt-info-time-set"))
							{
								$("deviceMgt-info-time-set").onclick = function(){
									var time = $F("deviceMgt-info-time").strip();
									
									if(time && typeof time != "undefined")
									{
										time = new Date(Date.parse(time.replace(/-/g,"/"))).getTime()/1000;
										var rv = Nrcap2.Control.CommonSet(WebClient.connectId, puid, resType, resIdx,"CTL_ST_SetTime","<Param Time=\""+time+"\"/>",""); // alert(rv);
										if(parseInt(rv) == 0)
										{
											alert("时间设置成功！");	
										}
										
									} 
								};
							} 
							
							if($("deviceMgt-info-timeSyncInterval"))
							{
								$("deviceMgt-info-timeSyncInterval").onchange = function(){
									var tsi_value = this.value.toString().strip(); // alert(tsi_value);
									if(tsi_value == null || typeof tsi_value == "undefined") return false;
									
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-self-nav-info"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = tsi_value; 
										
										if(childResource.get(this.id).original != tsi_value)
										{  
											common.count++;
										}
									}  
								};							
							}
							
							if($("deviceMgt-info-enableNTP"))
							{  
								$("deviceMgt-info-enableNTP").onclick = function(){
									if($("deviceMgt-info-NTPServerAddr")) $("deviceMgt-info-NTPServerAddr").disabled = !this.checked;
									if($("deviceMgt-info-NTPSSyncInterval")) $("deviceMgt-info-NTPSSyncInterval").disabled = !this.checked; 
									var bool = this.checked; // alert(tsi_value);
									if(bool == null || typeof bool == "undefined") return false;
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-self-nav-info"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = bool; 
										
										if(childResource.get(this.id).original != bool)
										{  
											common.count++;
										}
									} 
								};
								$("deviceMgt-info-NTPServerAddr").onchange = function(){
									var value = this.value.toString().strip(); // alert(value);
									if(value == null || typeof value == "undefined") return false;
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-self-nav-info"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									}
								};
								$("deviceMgt-info-NTPSSyncInterval").onchange = function(){
									var value = this.value.toString().strip(); // alert(value);
									if(value == null || typeof value == "undefined") return false;
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-self-nav-info"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									}
								};
							} 
							
							if($("deviceMgt-info-restart"))
							{
							
								$("deviceMgt-info-restart").onclick = function(){  
								
								 	/*var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-self-nav-info"; // alert(curdnId);  
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									alert(Object.toJSON(common)); return;*/
									
									if(confirm("确实需要重启设备吗？"))
									{
										var rv = Nrcap2.Control.CommonSet(WebClient.connectId, puid, resType, resIdx,"CTL_ST_Reboot","<Param />",""); // alert(rv);
									} 
									
								};
							}
							
							// <=--e-info--------------------------------------------------------------------------
							
							// =>--s-network--------------------------------------------------------------------------
							var curdnId = this.curDeviceNavId = "dm-self-nav-network"; // alert(curdnId); 
							var totalCommonInfo = this.totalCommonInfo.get(curdcId).childResource; // alert(Object.toJSON(totalCommonInfo));   
							var common = totalCommonInfo.get(curdnId); // alert(Object.toJSON(common)); 
							var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
							
							// <=--e-network--------------------------------------------------------------------------
							
						}
						break;
					
					case Nrcap2.Enum.PuResourceType.GPS:
						if($("deviceResInfoBox"))
						{
							if("deviceMgt-res-enable")
							{ 
								$("deviceMgt-res-enable").onclick = function(){
									var value = this.checked;
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-gps-nav-paramCfg"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									}  // alert(Object.toJSON(childResource)); 
								};
							}
							
							if($("deviceMgt-res-name"))
							{
								$("deviceMgt-res-name").onchange = function(){
									var value = this.value.toString().strip(); // alert(tsi_value);
									if( value == null || typeof value == "undefined") return false; 
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-gps-nav-paramCfg"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									} 
								};
							}
							if($("deviceMgt-res-desc"))
							{
								$("deviceMgt-res-desc").onchange = function(){
									var value = this.value.toString().strip(); // alert(tsi_value);
									if( value == null || typeof value == "undefined") return false; 
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-gps-nav-paramCfg"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									}
								};
							}
						}
						
						if($(curdcId) && curdcId == "device-mgt-gps")
						{ 
							// =>--s-paramCfg-------------------------------------------------------------------------- 
							// GPS数据发送间隔







							if($("deviceMgt-paramCfg-GPSSendCycle"))
							{	
								$("deviceMgt-paramCfg-GPSSendCycle").onchange = function(){
									var value = this.value.toString().strip(); // alert(value);
									if(value == null || typeof value == "undefined") return false;
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-gps-nav-paramCfg"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									
									//if(value == "") value = "0"; 
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									}
									// alert(Object.toJSON(common)); 
								};
							}
							// GPS数据提取间隔
							if($("deviceMgt-paramCfg-GPSParseInerval"))
							{	
								$("deviceMgt-paramCfg-GPSParseInerval").onchange = function(){
									var value = this.value.toString().strip(); // alert(value);
									if(value == null || typeof value == "undefined") return false;
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-gps-nav-paramCfg"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									
									//if(value == "") value = "0";
									
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									}
									
									// alert(Object.toJSON(common)); 
								};
							}
							
							// 存储GPS数据
							if($("deviceMgt-paramCfg-enableGPSData"))
							{	
								$("deviceMgt-paramCfg-enableGPSData").onclick = function(){
									var value = this.checked; // alert(value);
									if(value == null || typeof value == "undefined") return false;
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-gps-nav-paramCfg"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									 
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									}
									
									// alert(Object.toJSON(common)); 
								};
							}
							
							// 使能GPS数据上传补传
							if($("deviceMgt-paramCfg-enableGPSBuffer"))
							{	
								$("deviceMgt-paramCfg-enableGPSBuffer").onclick = function(){
									var value = this.checked; // alert(value);
									if(value == null || typeof value == "undefined") return false;
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-gps-nav-paramCfg"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									 
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									}
									
									// alert(Object.toJSON(common)); 
								};
							}
							
							// 离线GPS数据保存间隔
							if($("deviceMgt-paramCfg-GPSBufferCycle"))
							{	
								$("deviceMgt-paramCfg-GPSBufferCycle").onchange = function(){
									var value = this.value.toString().strip(); // alert(value);
									if(value == null || typeof value == "undefined") return false;
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-gps-nav-paramCfg"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									
									//if(value == "") value = "0";
									
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									}
									
									// alert(Object.toJSON(common)); 
								};
							}
							
							// 低速报警间隔







							if($("deviceMgt-paramCfg-LowSpeedAlarmInterval"))
							{	
								$("deviceMgt-paramCfg-LowSpeedAlarmInterval").onchange = function(){
									var value = this.value.toString().strip(); // alert(value);
									if(value == null || typeof value == "undefined") return false;
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-gps-nav-paramCfg"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									
									//if(value == "") value = "0";
									
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									}
									
									// alert(Object.toJSON(common)); 
								};
							}
							
							// 电子围栏报警间隔
							if($("deviceMgt-paramCfg-ERailAlarmInterval"))
							{	
								$("deviceMgt-paramCfg-ERailAlarmInterval").onchange = function(){
									var value = this.value.toString().strip(); // alert(value);
									if(value == null || typeof value == "undefined") return false;
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-gps-nav-paramCfg"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									
									//if(value == "") value = "0";
									
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									}
									
									// alert(Object.toJSON(common)); 
								};
							}
							
							// 线路偏离报警间隔
							if($("deviceMgt-paramCfg-LineDepartAlarmInterval"))
							{	
								$("deviceMgt-paramCfg-LineDepartAlarmInterval").onchange = function(){
									var value = this.value.toString().strip(); // alert(value);
									if(value == null || typeof value == "undefined") return false;
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-gps-nav-paramCfg"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									
									//if(value == "") value = "0";
									
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									}
									
									// alert(Object.toJSON(common)); 
								};
							}
							// <=--e-paramCfg-------------------------------------------------------------------------- 
						}
						break;
					
					case Nrcap2.Enum.PuResourceType.AudioIn:
						
						if($("deviceResInfoBox"))
						{
							if("deviceMgt-res-enable")
							{ 
								$("deviceMgt-res-enable").onclick = function(){
									var value = this.checked;
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-audioin-nav-paramCfg"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									}  // alert(Object.toJSON(childResource)); 
								};
							}
							
							if($("deviceMgt-res-name"))
							{
								$("deviceMgt-res-name").onchange = function(){
									var value = this.value.toString().strip(); // alert(tsi_value);
									if( value == null || typeof value == "undefined") return false; 
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-audioin-nav-paramCfg"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									} 
								};
							}
							if($("deviceMgt-res-desc"))
							{
								$("deviceMgt-res-desc").onchange = function(){
									var value = this.value.toString().strip(); // alert(tsi_value);
									if( value == null || typeof value == "undefined") return false; 
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-audioin-nav-paramCfg"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									}
								};
							}
						}
						
						if($(curdcId) && curdcId == "device-mgt-audioin")
						{ 
							// =>--s-paramCfg-------------------------------------------------------------------------- 
							// 编码方式
							if($("deviceMgt-paramCfg-encodeMode"))
							{	
								$("deviceMgt-paramCfg-encodeMode").onchange = function(){ 
									var value = this.options[this.selectedIndex].value.strip(); // alert(value);
									if(value == null || typeof value == "undefined") return false;
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-audioin-nav-paramCfg"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									  
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									} 
									
									// alert(Object.toJSON(common)); 
								};
							}
							// 输入模式
							if($("deviceMgt-paramCfg-inputMode"))
							{	
								$("deviceMgt-paramCfg-inputMode").onchange = function(){
									var value = this.options[this.selectedIndex].value.strip(); // alert(value);
									if(value == null || typeof value == "undefined") return false;
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-audioin-nav-paramCfg"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									  
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									} 
									
									// alert(Object.toJSON(common)); 
								};
							}
							// 声道数







							if($("deviceMgt-paramCfg-channelNum"))
							{	
								$("deviceMgt-paramCfg-channelNum").onchange = function(){
									var value = this.value.toString().strip(); // alert(value);
									if(value == null || typeof value == "undefined") return false;
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-audioin-nav-paramCfg"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									  
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									} 
									
									// alert(Object.toJSON(common)); 
								};
							}
							// 采样率







							if($("deviceMgt-paramCfg-sampleRate"))
							{	
								$("deviceMgt-paramCfg-sampleRate").onchange = function(){
									var value = this.options[this.selectedIndex].value.strip(); // alert(value);
									if(value == null || typeof value == "undefined") return false;
									
									var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = "dm-audioin-nav-paramCfg"; // alert(curdnId); 
									var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
									var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
									var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
									  
									if(childResource.get(this.id))
									{
										if(childResource.get(this.id).original != childResource.get(this.id).newValue)
										{
											if(common.count > 0) common.count--;
										}
										
										childResource.get(this.id).newValue = value; 
										
										if(childResource.get(this.id).original != value)
										{  
											common.count++;
										}
									} 
									
									// alert(Object.toJSON(common)); 
								};
							} 
							
							// <=--e-paramCfg-------------------------------------------------------------------------- 
						}
						
						break;
					
					case Nrcap2.Enum.PuResourceType.AudioOut:
						 
						break;
					
					case Nrcap2.Enum.PuResourceType.AlertIn:
						 
						break;
					
					case Nrcap2.Enum.PuResourceType.AlertOut:
						 
						break;
					
					case Nrcap2.Enum.PuResourceType.VideoIn:
						if($(curdcId) && curdcId == "device-mgt-videoin")
						{ 
							// <!-s-
							var navs = $(curdcId).getElementsByTagName("DIV");
							for(var i = 0; i < navs.length; i++)
							{
								var nav = navs[i];
								if(nav.id && nav.id.search("-nav-") != -1 && nav.webclienttype && nav.webclienttype == "dm-nav" )
								{
									var mainId = nav.id.replace("-nav-","-main-");
									this.curDeviceNavInfos.set(nav.id, {active:false, navId:nav.id, mainId:mainId});
									
									nav.title = nav.innerHTML;
									nav.onmouseover= function(){ 
										if(WebClient.Resource.DeviceResource.curDeviceNavId == this.id)
										{
											return false; 
										}
										else
										{
											this.className = "nav-mouseover";
										} 
									};
									nav.onmouseout = function(){ 
										if(WebClient.Resource.DeviceResource.curDeviceNavId == this.id)
										{
											return false; 
										}
										else
										{
											this.className = "nav-mouseout";
										}  
									};
									nav.onclick = function(){
										var newNavId = this.id;
										 
										WebClient.Resource.DeviceResource.curDeviceNavInfos.each(
											function(item){
												var node = item.value;
												if(node.navId == newNavId)
												{
													node.active = true;
													if($(node.navId)) $(node.navId).className = "nav-mousedown"; 
													if($(node.mainId)) $(node.mainId).style.display = "block";
													
													WebClient.Resource.DeviceResource.curDeviceNavId = newNavId;
													
													if(newNavId == "dm-videoin-nav-captureParam")
													{  
														WebClient.Resource.DeviceResource.CreateDeviceMgtSliderBar("brightness");
														WebClient.Resource.DeviceResource.CreateDeviceMgtSliderBar("contrast");
														WebClient.Resource.DeviceResource.CreateDeviceMgtSliderBar("hue");
														WebClient.Resource.DeviceResource.CreateDeviceMgtSliderBar("saturation"); 
														window.setTimeout(
															function()
															{ 
																var type = "Day";
																if($("deviceMgt-captureParam-timeRound"))
																{
																	if($("deviceMgt-captureParam-timeRound").options[$("deviceMgt-captureParam-timeRound").selectedIndex].value == "Night")
																	{  
																		type = "Night";
																	} 
																}
																
																// 获取相关视频参数
																WebClient.Resource.DeviceResource.RefreshFetchCaptureParam(puid, resType, resIdx, type); 	  	
															},10 
														); 
													}
												}
												else
												{
													node.active = false;
													if($(node.navId)) $(node.navId).className = "nav-mouseout"; 
													if($(node.mainId)) $(node.mainId).style.display = "none";
												}
											}
										);
										
									};
									
								}
							} 
							// $(curdnId).onclick(); // 响应一次 
							 
							// -e->
							
							var _totalCI = function(curnewdnId, objId, type){
								if(!$(curnewdnId) || !$(objId))
								{
									return false;
								}
								var curdnId = WebClient.Resource.DeviceResource.curDeviceNavId = curnewdnId; // alert(curdnId); 
								var totalCommonInfo = WebClient.Resource.DeviceResource.totalCommonInfo.get(curdcId);  //  alert(Object.toJSON(totalCommonInfo));   
								var common = totalCommonInfo.childResource.get(curdnId);  // alert(Object.toJSON(common)); 
								var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
								 
								if(type == "text")
								{
									var value = $F(objId).toString().strip();
								}
								else if(type == "select")
								{
									var value = $(objId).options[$(objId).selectedIndex].value.strip();
								}
								else if(type == "check")
								{
									var value = $(objId).checked;	
								} // alert(value);
								
								if(value == null || typeof value == "undefined") return false;
			
								if(childResource.get(objId))
								{
									if(childResource.get(objId).original != childResource.get(objId).newValue)
									{
										if(common.count > 0) common.count--;
									}
									 
									childResource.get(objId).newValue = value; 
									
									if(childResource.get(objId).original != value)
									{  
										common.count++;
									}
								} 	// alert(Object.toJSON(common)); 
							};
							
							// =>--s-baseParam-------------------------------------------------------------------------- 
							if($("deviceMgt-baseParam-encodeMode"))
							{
								// 压缩方式
								$("deviceMgt-baseParam-encodeMode").onchange = function(){ 
									_totalCI("dm-videoin-nav-baseParam", "deviceMgt-baseParam-encodeMode", "select");
								}; 
							}
							
							if($("deviceMgt-baseParam-EnableNightParam"))
							{
								// 支持夜间参数
								$("deviceMgt-baseParam-EnableNightParam").onclick = function(){
									_totalCI("dm-videoin-nav-baseParam", "deviceMgt-baseParam-EnableNightParam", "check");
								
									if($("deviceMgt-baseParam-nightToDayTime"))
									{
										$("deviceMgt-baseParam-nightToDayTime").disabled = !this.checked;
									}
									if($("deviceMgt-baseParam-dayToNightTime"))
									{ 
										$("deviceMgt-baseParam-dayToNightTime").disabled  = !this.checked;
									} 
								};  
								
								if($("deviceMgt-baseParam-nightToDayTime"))
								{ 
									$("deviceMgt-baseParam-nightToDayTime").onchange = function(){  
										_totalCI("dm-videoin-nav-baseParam", "deviceMgt-baseParam-nightToDayTime", "text");
									};
								}
								if($("deviceMgt-baseParam-dayToNightTime"))
								{
									$("deviceMgt-baseParam-dayToNightTime").onchange = function(){
										_totalCI("dm-videoin-nav-baseParam", "deviceMgt-baseParam-dayToNightTime", "text");
									};
								}
								
							}
							
							if($("deviceMgt-baseParam-EnableCoverAlarm"))
							{
								// 启用遮挡报警
								$("deviceMgt-baseParam-EnableCoverAlarm").onclick = function(){
									_totalCI("dm-videoin-nav-baseParam", "deviceMgt-baseParam-EnableCoverAlarm", "check");
								}; 
							}
							
							if($("deviceMgt-baseParam-CoverAlarmSensitivity"))
							{
								// 遮挡报警灵敏度






								$("deviceMgt-baseParam-CoverAlarmSensitivity").onchange = function(){
									_totalCI("dm-videoin-nav-baseParam", "deviceMgt-baseParam-CoverAlarmSensitivity", "text");
								}; 
							}  
							
							// <=--e-baseParam-------------------------------------------------------------------------- 
							// =>--s-captureParam----------------------------------------------------------------------- 
							
							if($("deviceMgt-captureParam-CurrentAnalogFormat"))
							{
								// 视频制式
								/*$("deviceMgt-captureParam-CurrentAnalogFormat").onchange = function(){
									_totalCI("dm-videoin-nav-captureParam", "deviceMgt-captureParam-CurrentAnalogFormat", "select");
								};*/ 
							}  
							
							if($("deviceMgt-captureParam-timeRound"))
							{
								// 白天/夜晚
								$("deviceMgt-captureParam-timeRound").onchange = function(){
									
									var type = "Day";
									if(this.options[this.selectedIndex].value == "Night")
									{  
										type = "Night";
									} 
									
									_totalCI("dm-videoin-nav-captureParam", "deviceMgt-captureParam-timeRound", "select"); 
									
									window.setTimeout(
										function(){
											// 获取相关视频参数
											WebClient.Resource.DeviceResource.RefreshFetchCaptureParam(puid, resType, resIdx, type);  
										},10
									);
								}; 
							}
							
							if($("deviceMgt-captureParam-Preprocessor"))
							{
								// 预处理方式






								$("deviceMgt-captureParam-Preprocessor").onchange = function(){
									_totalCI("dm-videoin-nav-captureParam", "deviceMgt-captureParam-Preprocessor", "select");
								}; 
							}
							
							if($("deviceMgt-captureParam-TimeAddPosition-X"))
							{
								// 时间位置-X
								$("deviceMgt-captureParam-TimeAddPosition-X").onchange = function(){
									_totalCI("dm-videoin-nav-captureParam", "deviceMgt-captureParam-TimeAddPosition-X", "text");
								}; 
							} 
							
							if($("deviceMgt-captureParam-TimeAddPosition-Y"))
							{
								// 时间位置-Y
								$("deviceMgt-captureParam-TimeAddPosition-Y").onchange = function(){
									_totalCI("dm-videoin-nav-captureParam", "deviceMgt-captureParam-TimeAddPosition-Y", "text");
								}; 
							} 
							
							if($("deviceMgt-captureParam-TextAdd"))
							{
								// 文字内容
								$("deviceMgt-captureParam-TextAdd").onchange = function(){
									_totalCI("dm-videoin-nav-captureParam", "deviceMgt-captureParam-TextAdd", "text");
								}; 
							} 
							
							if($("deviceMgt-captureParam-TextAddPosition-X"))
							{
								// 文字位置-X
								$("deviceMgt-captureParam-TextAddPosition-X").onchange = function(){
									_totalCI("dm-videoin-nav-captureParam", "deviceMgt-captureParam-TextAddPosition-X", "text");
								}; 
							} 
							
							if($("deviceMgt-captureParam-TextAddPosition-Y"))
							{
								// 文字位置-Y
								$("deviceMgt-captureParam-TextAddPosition-Y").onchange = function(){
									_totalCI("dm-videoin-nav-captureParam", "deviceMgt-captureParam-TextAddPosition-Y", "text");
								}; 
							} 
							
							if($("deviceMgt-captureParam-LogoAdd"))
							{
								// 图片路径
								$("deviceMgt-captureParam-LogoAdd").onchange = function(){
									_totalCI("dm-videoin-nav-captureParam", "deviceMgt-captureParam-LogoAdd", "text");
								}; 
							} 
							
							if($("deviceMgt-captureParam-LogoAddPosition-X"))
							{
								// 图片位置-X
								$("deviceMgt-captureParam-LogoAddPosition-X").onchange = function(){
									_totalCI("dm-videoin-nav-captureParam", "deviceMgt-captureParam-LogoAddPosition-X", "text");
								}; 
							} 
							
							if($("deviceMgt-captureParam-LogoAddPosition-Y"))
							{
								// 图片位置-Y
								$("deviceMgt-captureParam-LogoAddPosition-Y").onchange = function(){
									_totalCI("dm-videoin-nav-captureParam", "deviceMgt-captureParam-LogoAddPosition-Y", "text");
								}; 
							}
							
							if($("deviceMgt-captureParam-AddGPSAlarm"))
							{
								// 速度报警时警告色叠加GPS
								$("deviceMgt-captureParam-AddGPSAlarm").onclick = function(){
									_totalCI("dm-videoin-nav-captureParam", "deviceMgt-captureParam-AddGPSAlarm", "check");
								}; 
							}
							
							// <=--e-captureParam----------------------------------------------------------------------- 
							
							
						} 
						 
						if($("deviceResInfoBox"))
						{
							if("deviceMgt-res-enable")
							{ 
								$("deviceMgt-res-enable").onclick = function(){
									_totalCI("dm-videoin-nav-baseParam", "deviceMgt-res-enable", "check"); 
								};
							}
							
							if($("deviceMgt-res-name"))
							{
								$("deviceMgt-res-name").onchange = function(){
									_totalCI("dm-videoin-nav-baseParam", "deviceMgt-res-name", "text"); 
								};
							}
							if($("deviceMgt-res-desc"))
							{
								$("deviceMgt-res-desc").onchange = function(){
									_totalCI("dm-videoin-nav-baseParam", "deviceMgt-res-desc", "text"); 
								};
							}
						}
						
						
						break;
					
					case Nrcap2.Enum.PuResourceType.VideoOut:
						 
						break;
					
					case Nrcap2.Enum.PuResourceType.PTZ:
						 
						break;
					
					case Nrcap2.Enum.PuResourceType.Storager:
						 
						break;
					
					case Nrcap2.Enum.PuResourceType.SC:
						 
						break;
					
					case Nrcap2.Enum.PuResourceType.SerialPort:
						 
						break;
					
					case Nrcap2.Enum.PuResourceType.Wireless:
						 
						break;
					
					default:
						WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.DeviceResource.AttachDResEvent",msg:"resType(" + resType + ") unknown error!"});
						return false;
						break;
					
				} 
				
			},
			
			SwitchFetchDRes:function(puid, resType, resIdx){ 
				//alert(puid + "," + resType + "," + resIdx);
				
				if(!puid || typeof puid == "undefined")
				{
					WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.DeviceResource.SwitchFetchDRes",msg:"puid error!"});
					return false;
				}
				if(!resType || typeof resType == "undefined")
				{
					WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.DeviceResource.SwitchFetchDRes",msg:"resType error!"});
					return false;
				} 
				if(resIdx == null || typeof resIdx == "undefined")
				{
					WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.DeviceResource.SwitchFetchDRes",msg:"resIdx error!"});
					return false;
				}
				
				var htmlstr = "", typeName = "站点", enable = "1", name = "", desc = ""; 
				var curdcId = this.curDeviceContainerId; // alert(curdcId);   
				var devInfo = WebClient.Resource.resource.get(puid); 
				
				var display = "none";	
				if(devInfo.online == "1" && devInfo.enable == "1")
				{
					display = "block";
				} 
				 
				var _resInfo = function(resType, resIdx){
					var flag = false;  
					if(!devInfo.childResource || typeof devInfo.childResource != "object" || devInfo.childResource.constructor != Array)
					{
						return false;		
					}
				 
					devInfo.childResource.each
					(
						function(childRes)
						{
							// alert(Object.toJSON(childRes));
							if(flag == false)
							{ 
								if(childRes.type == resType && childRes.idx == resIdx)
								{
									enable = childRes.enable && childRes.enable == "1" ? true : false;
									name = childRes.name ? childRes.name : "";
									desc = childRes.description ? childRes.description : "";	
									flag = true;
								}   
							} 
						}
					);
					flag = false; 
				}
 								
				_resInfo(resType, resIdx); // 获取描述信息等









				switch(resType)
				{
					case Nrcap2.Enum.PuResourceType.SELF: 
						typeName = "站点"; 
						enable = devInfo.enable && devInfo.enable == "1" ? true : false;
						name = devInfo.name ? devInfo.name : "";
						desc = devInfo.description ? devInfo.description : "";
					
						if($(curdcId) && curdcId == "device-mgt-self")
						{  
							// =>--s-info--------------------------------------------------------------------------
							var curdnId = this.curDeviceNavId = "dm-self-nav-info"; // alert(curdnId); 
							var totalCommonInfo = this.totalCommonInfo.get(curdcId); // alert(Object.toJSON(totalCommonInfo));   
							var common = totalCommonInfo.childResource.get(curdnId); // alert(Object.toJSON(common)); 
							var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
							
							// 资源信息
							if($("deviceResInfoBox"))
							{
								if($("deviceMgt-res-name"))
								{
									childResource.get("deviceMgt-res-name").original = name;
									childResource.get("deviceMgt-res-name").newValue = name;		 
								}
								if($("deviceMgt-res-desc"))
								{
									childResource.get("deviceMgt-res-desc").original = desc;
									childResource.get("deviceMgt-res-desc").newValue = desc;		
 								}
							}
							
							// 设备信息
							if(devInfo && typeof devInfo != "undefined")
							{
								if($("deviceMgt-info-modelName")) $("deviceMgt-info-modelName").value = devInfo.modelName ? devInfo.modelName : "";
								if($("deviceMgt-info-modelType")) 
								{
									var modelType = "";
									switch(devInfo.modelType)
									{
										case Nrcap2.Enum.PuModelType.CSU: modelType = "中心存储单元"; break;
										case Nrcap2.Enum.PuModelType.ENC: modelType = "有线编码器"; break;
										case Nrcap2.Enum.PuModelType.DEC: modelType = "有线解码器"; break;
										case Nrcap2.Enum.PuModelType.WENC: modelType = "无线编码器"; break;
										case Nrcap2.Enum.PuModelType.WDEC: modelType = "无线解码器"; break;
										case Nrcap2.Enum.PuModelType.ESU: modelType = "企业自建存储单元"; break;
										default: break;
									}									
									$("deviceMgt-info-modelType").value = modelType;
								}
								if($("deviceMgt-info-softwareVersion")) $("deviceMgt-info-softwareVersion").value = devInfo.softwareVersion ? devInfo.softwareVersion : "";
								if($("deviceMgt-info-hardwareVersion")) $("deviceMgt-info-hardwareVersion").value = devInfo.hardwareVersion ? devInfo.hardwareVersion : "";
								if($("deviceMgt-info-manufactrueID")) $("deviceMgt-info-manufactrueID").value = devInfo.manufactrueID ? devInfo.manufactrueID : "";
								if($("deviceMgt-info-deviceID")) $("deviceMgt-info-deviceID").value = devInfo.deviceID ? devInfo.deviceID : "";
								 
							}
							
							// 获取性能参数
							if($("deviceMgt-info-cpupercent") && $("deviceMgt-info-memory"))
							{
								var rv = Nrcap2.Control.CommonGet(WebClient.connectId, puid, resType, resIdx,"CTL_ST_GetPerformance","<Param />",""); // alert(Object.toJSON(rv));
								
								if(rv && typeof rv == "object")
								{
									if(rv.CPUUsage != null && typeof rv.CPUUsage != "undefined") 
									{
										var offsetW = $$(".progress-container")[0].offsetWidth; // alert(offsetW);
										var width = Math.round(parseInt(rv.CPUUsage) * parseInt(offsetW) / 100);
										$("deviceMgt-info-cpupercent").style.width = width;
										$("deviceMgt-info-cpupercent-flag").innerHTML = rv.CPUUsage;
									}
									else
									{
										$("deviceMgt-info-cpupercent").style.width = "0";
										$("deviceMgt-info-cpupercent-flag").innerHTML = "";		
									}
									if(rv.MemUsage != null && typeof rv.MemUsage != "undefined") 
									{
										var offsetW = $$(".progress-container")[1].offsetWidth; // alert(offsetW);
										var width = Math.round(parseInt(rv.MemUsage) * parseInt(offsetW) / 100);
										$("deviceMgt-info-memory").style.width = width;
										$("deviceMgt-info-memory-flag").innerHTML = rv.MemUsage;
									} 
									else
									{
										$("deviceMgt-info-memory").style.width = "0";
										$("deviceMgt-info-memory-flag").innerHTML = "";		
									}
								}
							}  
							
							// 系统时间
							if($("deviceMgt-info-timeZone"))
							{ 
								var rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx,"CFG_ST_TZ",""); // alert(rv);
								if(rv.toString().search("GMT") != -1)
								{
									rv = rv.search("-") != -1 ?  rv.replace("-","+") : rv.replace("+","-"); // '+'/'-'对换
								} 
								else
								{
									rv = "GMT+08:00";
								}
								
							 	$("deviceMgt-info-timeZone").value = rv; 
								childResource.get("deviceMgt-info-timeZone").original = rv;
								childResource.get("deviceMgt-info-timeZone").newValue = rv;				  
							}
						 
							if($("deviceMgt-info-time"))
							{ 
								var rv = Nrcap2.Control.CommonGet(WebClient.connectId, puid, resType, resIdx,"CTL_ST_GetTime","<Param />",""); // alert(Object.toJSON(rv));
								
								if(rv && typeof rv == "object")
								{
									var time = new Date().format("yyyy-MM-dd HH:mm:ss");
									
									if(rv.Time != null && typeof rv.Time != "undefined")
									{
										 time = new Date(parseInt(rv.Time) * 1000).format("yyyy-MM-dd HH:mm:ss");
									}
									else if(rv.Year != null && typeof rv.Year != "undefined")
									{
										 // alert(new Date(rv.Year, parseInt(rv.Month) - 1, rv.Date, rv.Hour, rv.Minute, rv.Second).format("yyyy-MM-dd HH:mm:ss"));
										 time = new Date(rv.Year, parseInt(rv.Month) - 1, rv.Date, rv.Hour, rv.Minute, rv.Second).format("yyyy-MM-dd HH:mm:ss");
									}
									
									$("deviceMgt-info-time").value = time;
								}
							}							
							
							if($("deviceMgt-info-timeSyncInterval"))
							{   
							    // 平台同步时间间隔
								var rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx,"CFG_ST_TimeSyncInterval",""); // alert(rv);
								if(parseInt(rv) < 0 || parseInt(rv) > 1440)
								{
									rv = 0;
								}   
								
							 	$("deviceMgt-info-timeSyncInterval").value = rv; 
								childResource.get("deviceMgt-info-timeSyncInterval").original = rv;
								childResource.get("deviceMgt-info-timeSyncInterval").newValue = rv;	
							}
							
							if($("deviceMgt-info-enableNTP"))
							{  
								// 自动与Internet时间服务器同步服务器地址
								var rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx,"CFG_ST_EnableNTP",""); // alert(rv);
								if(parseInt(rv) != 0 && parseInt(rv) != 1)
								{
									rv = 0;
								}
								
								$("deviceMgt-info-enableNTP").checked = parseInt(rv) == 1 ? true : false; 
								childResource.get("deviceMgt-info-enableNTP").original = $("deviceMgt-info-enableNTP").checked;
								childResource.get("deviceMgt-info-enableNTP").newValue = $("deviceMgt-info-enableNTP").checked;	
								 
								if($("deviceMgt-info-NTPServerAddr"))
								{
									// 服务器地址
									rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx,"CFG_ST_NTPServerAddr","");// alert(rv);  
									if(rv.toString().indexOf(".") == -1)
									{
										break;	
									}
									
									$("deviceMgt-info-NTPServerAddr").value = rv;
									$("deviceMgt-info-NTPServerAddr").disabled = !$("deviceMgt-info-enableNTP").checked;
									childResource.get("deviceMgt-info-NTPServerAddr").original = rv;
									childResource.get("deviceMgt-info-NTPServerAddr").newValue = rv;	
								}
								
								if($("deviceMgt-info-NTPSSyncInterval"))
								{
									// 时间同步间隔 
									rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx,"CFG_ST_NTPSSyncInterval",""); // alert(rv);
									if(parseInt(rv) < 0 || parseInt(rv) > 1440)
									{
										rv = 0;
									}    
									
									$("deviceMgt-info-NTPSSyncInterval").value = rv;
									$("deviceMgt-info-NTPSSyncInterval").disabled = !$("deviceMgt-info-enableNTP").checked;
									childResource.get("deviceMgt-info-NTPSSyncInterval").original = rv;
									childResource.get("deviceMgt-info-NTPSSyncInterval").newValue = rv;	
								} 
								 
								// <=--e-info--------------------------------------------------------------------------
								
								// =>--s-network--------------------------------------------------------------------------
								var curdnId = this.curDeviceNavId = "dm-self-nav-network"; // alert(curdnId); 
								var totalCommonInfo = this.totalCommonInfo.get(curdcId).childResource; // alert(Object.toJSON(totalCommonInfo));   
								var common = totalCommonInfo.get(curdnId); // alert(Object.toJSON(common)); 
								var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
								
								// <=--e-network--------------------------------------------------------------------------
								
							} 
						}
						
						// 恢复
						var curdnId = this.curDeviceNavId = "dm-self-nav-info"; // alert(curdnId); 
						
						break;
					
					case Nrcap2.Enum.PuResourceType.GPS: typeName = "GPS模块"; 
						if($(curdcId) && curdcId == "device-mgt-gps")
						{  
							// =>--s-info--------------------------------------------------------------------------
							var curdnId = this.curDeviceNavId = "dm-gps-nav-paramCfg"; // alert(curdnId); 
							var totalCommonInfo = this.totalCommonInfo.get(curdcId); // alert(Object.toJSON(totalCommonInfo));   
							var common = totalCommonInfo.childResource.get(curdnId); // alert(Object.toJSON(common)); 
							var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
							
							// 资源信息
							if($("deviceResInfoBox"))
							{
								if($("deviceMgt-res-enable") && childResource.get("deviceMgt-res-enable"))
								{
									childResource.get("deviceMgt-res-enable").original = enable;
									childResource.get("deviceMgt-res-enable").newValue = enable;		 
								}
								if($("deviceMgt-res-name") && childResource.get("deviceMgt-res-name"))
								{
									childResource.get("deviceMgt-res-name").original = name;
									childResource.get("deviceMgt-res-name").newValue = name;		 
								}
								if($("deviceMgt-res-desc") && childResource.get("deviceMgt-res-desc"))
								{
									childResource.get("deviceMgt-res-desc").original = desc;
									childResource.get("deviceMgt-res-desc").newValue = desc;		
 								}
							}
							
							// GPS状态







							if($("deviceMgt-paramCfg-GPSStatus"))
							{
								var rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx,"CFG_GPS_Status",""); // alert(rv);
								
								var status = "";
								switch(rv)
								{
									case "No Module": status = "无模块"; break;
									case "No Signal": status = "无信号"; break;
									case "OK": status = "有信号"; break;
									default: break;	
								}
								$("deviceMgt-paramCfg-GPSStatus").value = status;
							} 
							
							// GPS数据发送间隔







							if($("deviceMgt-paramCfg-GPSSendCycle"))
							{
								var rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx,"CFG_GPS_SendCycle",""); // alert(rv);
								if(rv == false || rv == null || parseInt(rv) == 28932) rv = ""; 
								$("deviceMgt-paramCfg-GPSSendCycle").value = rv;
								if(rv == "") 
								{
									$("deviceMgt-paramCfg-GPSSendCycle").disabled = true;
									$("deviceMgt-paramCfg-GPSSendCycle").className = "input-readonly"; 								
								}
								else
								{
									$("deviceMgt-paramCfg-GPSSendCycle").disabled = false;
									$("deviceMgt-paramCfg-GPSSendCycle").className = ""; 
								}
								
								if(childResource.get("deviceMgt-paramCfg-GPSSendCycle"))
								{
									childResource.get("deviceMgt-paramCfg-GPSSendCycle").original = rv;
									childResource.get("deviceMgt-paramCfg-GPSSendCycle").newValue = rv; 	
								} 
							}
							
							// GPS数据提取间隔
							if($("deviceMgt-paramCfg-GPSParseInerval"))
							{
								var rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx,"CFG_GPS_ParseInerval",""); // alert(rv);
								if(rv == false || rv == null || parseInt(rv) == 28932) rv = ""; 
								$("deviceMgt-paramCfg-GPSParseInerval").value = rv;
								if(rv == "") 
								{
									$("deviceMgt-paramCfg-GPSParseInerval").disabled = true;
									$("deviceMgt-paramCfg-GPSParseInerval").className = "input-readonly"; 								
								}
								else
								{
									$("deviceMgt-paramCfg-GPSParseInerval").disabled = false;
									$("deviceMgt-paramCfg-GPSParseInerval").className = ""; 
								}
								
								if(childResource.get("deviceMgt-paramCfg-GPSParseInerval"))
								{
									childResource.get("deviceMgt-paramCfg-GPSParseInerval").original = rv;
									childResource.get("deviceMgt-paramCfg-GPSParseInerval").newValue = rv; 	
								} 
							}
							
							// 存储GPS数据
							if($("deviceMgt-paramCfg-enableGPSData"))
							{
								var rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx,"CFG_GPS_EnableStorage",""); // alert(rv);
								if(parseInt(rv) != 0 && parseInt(rv) != 1) rv = ""; 
								
								if(rv == "") 
								{
									$("deviceMgt-paramCfg-enableGPSData-box").disabled = true; 								
								}
								else
								{
									$("deviceMgt-paramCfg-enableGPSData-box").disabled = false; 
									$("deviceMgt-paramCfg-enableGPSData").checked = parseInt(rv) == 1 ? true : false;
								} 
								
								if(childResource.get("deviceMgt-paramCfg-enableGPSData"))
								{
									childResource.get("deviceMgt-paramCfg-enableGPSData").original = $("deviceMgt-paramCfg-enableGPSData").checked;
									childResource.get("deviceMgt-paramCfg-enableGPSData").newValue = $("deviceMgt-paramCfg-enableGPSData").checked; 	
								} 
							}
							
							// 使能GPS数据上传补传
							if($("deviceMgt-paramCfg-enableGPSBuffer"))
							{
								var rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx,"CFG_GPS_EnableBuffer",""); // alert(rv);
								if(parseInt(rv) != 0 && parseInt(rv) != 1) rv = ""; 
								
								if(rv == "") 
								{
									$("deviceMgt-paramCfg-enableGPSBuffer-box").disabled = true; 								
								}
								else
								{
									$("deviceMgt-paramCfg-enableGPSBuffer-box").disabled = false; 
									$("deviceMgt-paramCfg-enableGPSBuffer").checked = parseInt(rv) == 1 ? true : false;
								} 
								
								if(childResource.get("deviceMgt-paramCfg-enableGPSBuffer"))
								{
									childResource.get("deviceMgt-paramCfg-enableGPSBuffer").original = $("deviceMgt-paramCfg-enableGPSBuffer").checked;
									childResource.get("deviceMgt-paramCfg-enableGPSBuffer").newValue = $("deviceMgt-paramCfg-enableGPSBuffer").checked; 
								} 
							} 
							
							// 离线GPS数据保存间隔
							if($("deviceMgt-paramCfg-GPSBufferCycle"))
							{ 
								var rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx,"CFG_GPS_BufferCycle",""); // alert(rv);
								if(rv == false || rv == null || parseInt(rv) == 28932) rv = ""; 
								$("deviceMgt-paramCfg-GPSBufferCycle").value = rv;
								if(rv == "") 
								{
									$("deviceMgt-paramCfg-GPSBufferCycle").disabled = true;
									$("deviceMgt-paramCfg-GPSBufferCycle").className = "input-readonly"; 								
								}
								else
								{
									$("deviceMgt-paramCfg-GPSBufferCycle").disabled = false;
									$("deviceMgt-paramCfg-GPSBufferCycle").className = ""; 
								}
								
								if(childResource.get("deviceMgt-paramCfg-GPSBufferCycle"))
								{
									childResource.get("deviceMgt-paramCfg-GPSBufferCycle").original = rv;
									childResource.get("deviceMgt-paramCfg-GPSBufferCycle").newValue = rv; 	
								} 
							}
							
							// 低速报警间隔







							if($("deviceMgt-paramCfg-LowSpeedAlarmInterval"))
							{ 
								var rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx,"CFG_GPS_LowSpeedAlarmInterval",""); // alert(rv);
								if(rv == false || rv == null || parseInt(rv) == 28932) rv = ""; 
								$("deviceMgt-paramCfg-LowSpeedAlarmInterval").value = rv;
								if(rv == "") 
								{
									$("deviceMgt-paramCfg-LowSpeedAlarmInterval").disabled = true;
									$("deviceMgt-paramCfg-LowSpeedAlarmInterval").className = "input-readonly"; 								
								}
								else
								{
									$("deviceMgt-paramCfg-LowSpeedAlarmInterval").disabled = false;
									$("deviceMgt-paramCfg-LowSpeedAlarmInterval").className = ""; 
								}
								
								if(childResource.get("deviceMgt-paramCfg-LowSpeedAlarmInterval"))
								{
									childResource.get("deviceMgt-paramCfg-LowSpeedAlarmInterval").original = rv;
									childResource.get("deviceMgt-paramCfg-LowSpeedAlarmInterval").newValue = rv; 	
								} 
							}
							
							// 电子围栏报警间隔
							if($("deviceMgt-paramCfg-ERailAlarmInterval"))
							{ 
								var rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx,"CFG_GPS_ERailAlarmInterval",""); // alert(rv);
								if(rv == false || rv == null || parseInt(rv) == 28932) rv = ""; 
								$("deviceMgt-paramCfg-ERailAlarmInterval").value = rv;
								if(rv == "") 
								{
									$("deviceMgt-paramCfg-ERailAlarmInterval").disabled = true;
									$("deviceMgt-paramCfg-ERailAlarmInterval").className = "input-readonly"; 								
								}
								else
								{
									$("deviceMgt-paramCfg-ERailAlarmInterval").disabled = false;
									$("deviceMgt-paramCfg-ERailAlarmInterval").className = ""; 
								}
								
								if(childResource.get("deviceMgt-paramCfg-ERailAlarmInterval"))
								{
									childResource.get("deviceMgt-paramCfg-ERailAlarmInterval").original = rv;
									childResource.get("deviceMgt-paramCfg-ERailAlarmInterval").newValue = rv; 	
								} 
							}
							
							
							// 线路偏离报警间隔
							if($("deviceMgt-paramCfg-LineDepartAlarmInterval"))
							{ 
								var rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx,"CFG_GPS_LineDepartAlarmInterval",""); // alert(rv);
								if(rv == false || rv == null || parseInt(rv) == 28932) rv = ""; 
								$("deviceMgt-paramCfg-LineDepartAlarmInterval").value = rv;
								if(rv == "") 
								{
									$("deviceMgt-paramCfg-LineDepartAlarmInterval").disabled = true;
									$("deviceMgt-paramCfg-LineDepartAlarmInterval").className = "input-readonly"; 								
								}
								else
								{
									$("deviceMgt-paramCfg-LineDepartAlarmInterval").disabled = false;
									$("deviceMgt-paramCfg-LineDepartAlarmInterval").className = ""; 
								}
								
								if(childResource.get("deviceMgt-paramCfg-LineDepartAlarmInterval"))
								{
									childResource.get("deviceMgt-paramCfg-LineDepartAlarmInterval").original = rv;
									childResource.get("deviceMgt-paramCfg-LineDepartAlarmInterval").newValue = rv; 	
								} 
							} 
							
							// alert(Object.toJSON(childResource)); 
							// <=--e-info--------------------------------------------------------------------------
						}
						break;
					
					case Nrcap2.Enum.PuResourceType.AudioIn: typeName = "输入音频"; 
						if($(curdcId) && curdcId == "device-mgt-audioin")
						{   
							// =>--s-paramCfg--------------------------------------------------------------------------
							var curdnId = this.curDeviceNavId = "dm-audioin-nav-paramCfg"; // alert(curdnId); 
							var totalCommonInfo = this.totalCommonInfo.get(curdcId); // alert(Object.toJSON(totalCommonInfo));   
							var common = totalCommonInfo.childResource.get(curdnId); // alert(Object.toJSON(common)); 
							var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
							
							// 资源信息
							if($("deviceResInfoBox"))
							{
								if($("deviceMgt-res-enable") && childResource.get("deviceMgt-res-enable"))
								{
									childResource.get("deviceMgt-res-enable").original = enable;
									childResource.get("deviceMgt-res-enable").newValue = enable;		 
								}
								if($("deviceMgt-res-name") && childResource.get("deviceMgt-res-name"))
								{
									childResource.get("deviceMgt-res-name").original = name;
									childResource.get("deviceMgt-res-name").newValue = name;		 
								}
								if($("deviceMgt-res-desc") && childResource.get("deviceMgt-res-desc"))
								{
									childResource.get("deviceMgt-res-desc").original = desc;
									childResource.get("deviceMgt-res-desc").newValue = desc;		
 								}
							}
							
							var SliderBar = this.SliderBars.get("dm-ia-volume");
							SliderBar.SetStatus(true, puid, resIdx); // 初始化音量值  
							
							// 编码方式
							if($("deviceMgt-paramCfg-encodeMode"))
							{
								// 设备支持的编码方式







								var rv = Nrcap2.Config.GetComplex(WebClient.connectId, puid, resType, resIdx,"CFG_IA_SupportedEncoderSets","");  // alert(rv.constructor); break;
								if(rv == false || rv == null || parseInt(rv) == 28932) rv = ""; 
							 
								if(typeof rv == "object" && rv.constructor == Array)
								{
									var emstr = ""; 
									rv.each(
										function(item){
											$("deviceMgt-paramCfg-encodeMode").add(new Option(item, item)); 
										}
									);
								}  
								
								// 设备当前的编码方式







								rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IA_Encoder",""); 
								
								if(rv == false || rv == null || parseInt(rv) == 28932) rv = ""; 
								
								$("deviceMgt-paramCfg-encodeMode").value = rv; 
								if(rv == "") 
								{
									$("deviceMgt-paramCfg-encodeMode").disabled = true;
									$("deviceMgt-paramCfg-encodeMode").className = "input-readonly"; 								
								}
								else
								{
									$("deviceMgt-paramCfg-encodeMode").disabled = false;
									$("deviceMgt-paramCfg-encodeMode").className = ""; 
								}
								 
								if(childResource.get("deviceMgt-paramCfg-encodeMode"))
								{
									childResource.get("deviceMgt-paramCfg-encodeMode").original = rv;
									childResource.get("deviceMgt-paramCfg-encodeMode").newValue = rv; 	
								}  
							}
							// 输入模式
							if($("deviceMgt-paramCfg-inputMode"))
							{
								// 设备支持的输入模式







								var rv = Nrcap2.Config.GetComplex(WebClient.connectId, puid, resType, resIdx,"CFG_IA_SupportedInputModeSets","");  // alert(rv.constructor); break;
								if(rv == false || rv == null || parseInt(rv) == 28932) rv = ""; 
							 
								if(typeof rv == "object" && rv.constructor == Array)
								{
									var emstr = ""; 
									rv.each(
										function(item){
											$("deviceMgt-paramCfg-inputMode").add(new Option(item, item)); 
										}
									);
								}  
								
								// 设备当前的输入模式







								rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IA_InputMode",""); 
								
								if(rv == false || rv == null || parseInt(rv) == 28932) rv = ""; 
								
								$("deviceMgt-paramCfg-inputMode").value = rv; 
								if(rv == "") 
								{
									$("deviceMgt-paramCfg-inputMode").disabled = true;
									$("deviceMgt-paramCfg-inputMode").className = "input-readonly"; 								
								}
								else
								{
									$("deviceMgt-paramCfg-inputMode").disabled = false;
									$("deviceMgt-paramCfg-inputMode").className = ""; 
								}
								 
								if(childResource.get("deviceMgt-paramCfg-inputMode"))
								{
									childResource.get("deviceMgt-paramCfg-inputMode").original = rv;
									childResource.get("deviceMgt-paramCfg-inputMode").newValue = rv; 	
								}  
							} 
							// 声道数







							if($("deviceMgt-paramCfg-channelNum"))
							{  
								// 声道数







								rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IA_ChanNum",""); 
								 
								switch(rv)
								{
									case "1": rv = "Single Channel"; break;
									case "2": rv = "Double Channel"; break;
									default: rv = ""; break; 
								} 
								
								$("deviceMgt-paramCfg-channelNum").value = rv; 
								//if(rv == "") 
								//{
									$("deviceMgt-paramCfg-channelNum").readOnly = true; 
									$("deviceMgt-paramCfg-channelNum").className = "input-readonly"; 								
								//}
								//else
								//{
								//	$("deviceMgt-paramCfg-channelNum").readOnly = false;
								//	$("deviceMgt-paramCfg-channelNum").className = ""; 
								//}
								 
								if(childResource.get("deviceMgt-paramCfg-channelNum"))
								{
									childResource.get("deviceMgt-paramCfg-channelNum").original = rv;
									childResource.get("deviceMgt-paramCfg-channelNum").newValue = rv; 	
								}  
							}
							// 采样率







							if($("deviceMgt-paramCfg-sampleRate"))
							{  
								// 设备支持的采样率
								var rv = Nrcap2.Config.GetComplex(WebClient.connectId, puid, resType, resIdx,"CFG_IA_SupportedSampleRateSets","");  // alert(rv.constructor); break;
								if(rv == false || rv == null || parseInt(rv) == 28932) rv = ""; 
							 
								if(typeof rv == "object" && rv.constructor == Array)
								{
									var emstr = ""; 
									rv.each(
										function(item){
											$("deviceMgt-paramCfg-sampleRate").add(new Option(item, item)); 
										}
									);
								}  
								
								// 设备当前的采样率 
								rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IA_SampleRate",""); 
								
								if(rv == false || rv == null || parseInt(rv) == 28932 ) rv = ""; 
								
								$("deviceMgt-paramCfg-sampleRate").value = rv; 
								if(rv == "") 
								{
									$("deviceMgt-paramCfg-sampleRate").disabled = true;
									$("deviceMgt-paramCfg-sampleRate").className = "input-readonly"; 								
								}
								else
								{
									$("deviceMgt-paramCfg-sampleRate").disabled = false;
									$("deviceMgt-paramCfg-sampleRate").className = ""; 
								}
								 
								if(childResource.get("deviceMgt-paramCfg-sampleRate"))
								{
									childResource.get("deviceMgt-paramCfg-sampleRate").original = rv;
									childResource.get("deviceMgt-paramCfg-sampleRate").newValue = rv; 	
								}  
							}
							
							// <=--e-paramCfg--------------------------------------------------------------------------
						}
						
						// alert(Object.toJSON(childResource)); 
						
						break;
					
					case Nrcap2.Enum.PuResourceType.AudioOut: typeName = "输出音频"; 
						 
						break;
					
					case Nrcap2.Enum.PuResourceType.AlertIn: typeName = "输入数字线"; 
						 
						break;
					
					case Nrcap2.Enum.PuResourceType.AlertOut: typeName = "输出数字线"; 
						 
						break;
					
					case Nrcap2.Enum.PuResourceType.VideoIn:  typeName = "输入视频";   
						if($(curdcId) && curdcId == "device-mgt-videoin")
						{  
							// =>--s-baseParam--------------------------------------------------------------------------
							var curdnId = this.curDeviceNavId = "dm-videoin-nav-baseParam"; // alert(curdnId); 
							var totalCommonInfo = this.totalCommonInfo.get(curdcId); // alert(Object.toJSON(totalCommonInfo));   
							var common = totalCommonInfo.childResource.get(curdnId); // alert(Object.toJSON(common)); 
							var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
							
							// 资源信息
							if($("deviceResInfoBox"))
							{
								if($("deviceMgt-res-enable") && childResource.get("deviceMgt-res-enable"))
								{
									childResource.get("deviceMgt-res-enable").original = enable;
									childResource.get("deviceMgt-res-enable").newValue = enable;		 
								}
								if($("deviceMgt-res-name") && childResource.get("deviceMgt-res-name"))
								{
									childResource.get("deviceMgt-res-name").original = name;
									childResource.get("deviceMgt-res-name").newValue = name;		 
								}
								if($("deviceMgt-res-desc") && childResource.get("deviceMgt-res-desc"))
								{
									childResource.get("deviceMgt-res-desc").original = desc;
									childResource.get("deviceMgt-res-desc").newValue = desc;		
 								}
							} 
							
							// 摄像头状态






							if($("deviceMgt-baseParam-cameraStatus"))
							{
								
								rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_CameraStatus",""); 
								 
								switch(rv)
								{
									case "0": rv = "无摄像头"; break;
									case "1": rv = "有摄像头"; break;
									default: rv = ""; break; 
								} 
								
								$("deviceMgt-baseParam-cameraStatus").value = rv; 
							    $("deviceMgt-baseParam-cameraStatus").readOnly = true; 
								$("deviceMgt-baseParam-cameraStatus").className = "input-readonly"; 	 
							}
							
							// 压缩方式
							if($("deviceMgt-baseParam-encodeMode"))
							{  
								// 设备支持的压缩方式






								var rv = Nrcap2.Config.GetComplex(WebClient.connectId, puid, resType, resIdx,"CFG_IV_SupportedEncoderSets","");  // alert(rv.constructor); break;
								if(rv == false || rv == null || parseInt(rv) == 28932) rv = ""; 
							 
								if(typeof rv == "object" && rv.constructor == Array)
								{
									var emstr = ""; 
									rv.each(
										function(item){
											$("deviceMgt-baseParam-encodeMode").add(new Option(item, item)); 
										}
									);
								}  
								
								// 设备当前的压缩方式






								rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_Encoder",""); 
								
								if(rv == false || rv == null || parseInt(rv) == 28932 ) rv = ""; 
								
								$("deviceMgt-baseParam-encodeMode").value = rv; 
								if(rv == "") 
								{
									$("deviceMgt-baseParam-encodeMode").disabled = true;
									$("deviceMgt-baseParam-encodeMode").className = "input-readonly"; 								
								}
								else
								{
									$("deviceMgt-baseParam-encodeMode").disabled = false;
									$("deviceMgt-baseParam-encodeMode").className = ""; 
								}
								 
								if(childResource.get("deviceMgt-baseParam-encodeMode"))
								{
									childResource.get("deviceMgt-baseParam-encodeMode").original = rv;
									childResource.get("deviceMgt-baseParam-encodeMode").newValue = rv; 	
								} 
							}
							
							// 是否使能夜间参数
							if($("deviceMgt-baseParam-EnableNightParam"))
							{
								
								rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_EnableNightParam",""); 
								 
								switch(parseInt(rv))
								{
									case 0: rv = false; break;
									case 1: rv = true; break;
									default: rv = null; break; 
								} 
								
							    if(rv == null) 
								{ 
									$("deviceMgt-baseParam-EnableNightParam").disabled = true; 								
								}
								else
								{
									$("deviceMgt-baseParam-EnableNightParam").disabled = false; 
									
									$("deviceMgt-baseParam-EnableNightParam").checked = rv; 
									
									if(childResource.get("deviceMgt-baseParam-EnableNightParam"))
									{
										childResource.get("deviceMgt-baseParam-EnableNightParam").original = rv;
										childResource.get("deviceMgt-baseParam-EnableNightParam").newValue = rv; 	
									}
								}  
								
								if($("deviceMgt-baseParam-nightToDayTime") && $("deviceMgt-baseParam-dayToNightTime"))
								{
									// 昼夜切换时间点






									rv = Nrcap2.Config.GetComplex(WebClient.connectId, puid, resType, resIdx, "CFG_IV_DayNightTime","");  
									// alert(Object.toJSON(rv));
									
									if(rv && typeof rv == "object" && rv.constructor == Array)
									{
										var time = rv[0];
										var _zero = function(ts){
											return ts.length == 1 ? "0" + ts : ts;
										};
										var n2dstr = _zero(time.N2Dhour) + ":" + _zero(time.N2Dminute);
										var d2nstr = _zero(time.D2Nhour) + ":" + _zero(time.D2Nminute);
										
										$("deviceMgt-baseParam-nightToDayTime").value = n2dstr;
										
										if(childResource.get("deviceMgt-baseParam-nightToDayTime"))
										{
											childResource.get("deviceMgt-baseParam-nightToDayTime").original = n2dstr;
											childResource.get("deviceMgt-baseParam-nightToDayTime").newValue = n2dstr; 	
										}
										  
										$("deviceMgt-baseParam-dayToNightTime").value = d2nstr;
										
										if(childResource.get("deviceMgt-baseParam-dayToNightTime"))
										{
											childResource.get("deviceMgt-baseParam-dayToNightTime").original = d2nstr;
											childResource.get("deviceMgt-baseParam-dayToNightTime").newValue = d2nstr; 	
										} 
										 
									}
									
									$("deviceMgt-baseParam-nightToDayTime").disabled = !$("deviceMgt-baseParam-EnableNightParam").checked;
									$("deviceMgt-baseParam-dayToNightTime").disabled = !$("deviceMgt-baseParam-EnableNightParam").checked; 
								} 
								
							}
							
							// 启用遮挡报警
							if($("deviceMgt-baseParam-EnableCoverAlarm"))
							{
								rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_EnableCoverAlarm",""); 
								 
								switch(parseInt(rv))
								{
									case 0: rv = false; break;
									case 1: rv = true; break;
									default: rv = null; break; 
								} 
								
								$("deviceMgt-baseParam-EnableCoverAlarm").checked = rv; 
							    if(rv == null) 
								{ 
									$("deviceMgt-baseParam-EnableCoverAlarm").disabled = true; 								
								}
								else
								{
									$("deviceMgt-baseParam-EnableCoverAlarm").disabled = false; 
								}
								
								if(childResource.get("deviceMgt-baseParam-EnableCoverAlarm"))
								{
									childResource.get("deviceMgt-baseParam-EnableCoverAlarm").original = rv;
									childResource.get("deviceMgt-baseParam-EnableCoverAlarm").newValue = rv; 	
								} 
							}
							
							// 遮挡报警灵敏度






							if($("deviceMgt-baseParam-CoverAlarmSensitivity"))
							{
								rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_CoverAlarmSensitivity",""); 
								 
								if(rv == false || rv == null || parseInt(rv) < 0 || parseInt(rv) > 100) rv = ""; 
								
								$("deviceMgt-baseParam-CoverAlarmSensitivity").value = rv; 
							    if(rv == "") 
								{ 
									$("deviceMgt-baseParam-CoverAlarmSensitivity").disabled = true;
									$("deviceMgt-baseParam-CoverAlarmSensitivity").className = "input-readonly"; 								
								}
								else
								{
									$("deviceMgt-baseParam-CoverAlarmSensitivity").disabled = false;
									$("deviceMgt-baseParam-CoverAlarmSensitivity").className = ""; 
								}
								
								if(childResource.get("deviceMgt-baseParam-CoverAlarmSensitivity"))
								{
									childResource.get("deviceMgt-baseParam-CoverAlarmSensitivity").original = rv;
									childResource.get("deviceMgt-baseParam-CoverAlarmSensitivity").newValue = rv; 	
								} 
							}
							// <=--e-baseParam----------------------------------------------------------------------------- 
						
							// 采集参数
							var curdnId = this.curDeviceNavId = "dm-videoin-nav-captureParam"; // alert(curdnId); 
							var totalCommonInfo = this.totalCommonInfo.get(curdcId); // alert(Object.toJSON(totalCommonInfo));   
							var common = totalCommonInfo.childResource.get(curdnId); // alert(Object.toJSON(common)); 
							var childResource = common.childResource; // alert(Object.toJSON(childResource)); 
							
							// =>--s-captureParam--------------------------------------------------------------------------
							
							if($("deviceMgt-captureParam-CurrentAnalogFormat"))
							{
								// 设备支持的视频制式






								var rv = Nrcap2.Config.GetComplex(WebClient.connectId, puid, resType, resIdx,"CFG_IV_SupportedAnalogFormatSets","");  // alert(rv.constructor); break;
								if(rv == false || rv == null || parseInt(rv) == 28932) rv = ""; 
							 
								if(typeof rv == "object" && rv.constructor == Array)
								{
									var emstr = ""; 
									rv.each(
										function(item){
											$("deviceMgt-captureParam-CurrentAnalogFormat").add(new Option(item, item)); 
										}
									);
								}  
								
								// 设备当前的视频制式






								rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_CurrentAnalogFormat",""); 
								
								if(rv == false || rv == null || parseInt(rv) == 28932 ) rv = ""; 
								
								$("deviceMgt-captureParam-CurrentAnalogFormat").value = rv; 
								//if(rv == "") 
								{
									$("deviceMgt-captureParam-CurrentAnalogFormat").disabled = true;
									$("deviceMgt-captureParam-CurrentAnalogFormat").className = "input-readonly"; 								
								}
								/*else
								{
									$("deviceMgt-captureParam-CurrentAnalogFormat").disabled = false;
									$("deviceMgt-captureParam-CurrentAnalogFormat").className = ""; 
								}*/
								 
								if(childResource.get("deviceMgt-captureParam-CurrentAnalogFormat"))
								{
									childResource.get("deviceMgt-captureParam-CurrentAnalogFormat").original = rv;
									childResource.get("deviceMgt-captureParam-CurrentAnalogFormat").newValue = rv; 	
								} 
							}
							
							// 白天夜间切换状态






							if($("deviceMgt-captureParam-timeRound"))
							{
								// 使用的是白天还是夜间参数
								rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_DayOrNightParam",""); 
								// alert(rv);
								switch(parseInt(rv))
								{
									case 1: rv = "Day"; break;
									case 2: rv = "Night"; break;
									default: rv = null; break; 
								} 
								
								$("deviceMgt-captureParam-timeRound").value = rv; 
								if(rv == null) 
								{
									$("deviceMgt-captureParam-timeRound").disabled = true;
									$("deviceMgt-captureParam-timeRound").className = "input-readonly"; 								
								}
								else
								{
									$("deviceMgt-captureParam-timeRound").disabled = false;
									$("deviceMgt-captureParam-timeRound").className = ""; 
								}
								 
								if(childResource.get("deviceMgt-captureParam-timeRound"))
								{
									childResource.get("deviceMgt-captureParam-timeRound").original = rv;
									childResource.get("deviceMgt-captureParam-timeRound").newValue = rv; 	
								} 
							}
							
							// 预处理方式






							if($("deviceMgt-captureParam-Preprocessor"))
							{
								// 设备支持的预处理方式
								var rv = Nrcap2.Config.GetComplex(WebClient.connectId, puid, resType, resIdx,"CFG_IV_SupportedPreprocessorSets","");  // alert(rv.constructor); break;
								if(rv == false || rv == null || parseInt(rv) == 28932) rv = ""; 
							 
								if(typeof rv == "object" && rv.constructor == Array)
								{
									var emstr = ""; 
									rv.each(
										function(item){
											var text = "";
											switch(item)
											{
												case "nonpreprocess": text = "无预处理"; break;
												case "noiseFilter": text = "噪音滤波"; break;
												default: break;
											} 
											$("deviceMgt-captureParam-Preprocessor").add(new Option(text, item)); 
										}
									);
								}  
								
								// 设备当前的预处理方式
								rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_Preprocessor",""); 
								
								if(rv == false || rv == null || parseInt(rv) == 28932 ) rv = ""; 
								
								$("deviceMgt-captureParam-Preprocessor").value = rv; 
								if(rv == "") 
								{
									$("deviceMgt-captureParam-Preprocessor").disabled = true;
									$("deviceMgt-captureParam-Preprocessor").className = "input-readonly"; 								
								}
								else
								{
									$("deviceMgt-captureParam-Preprocessor").disabled = false;
									$("deviceMgt-captureParam-Preprocessor").className = ""; 
								}
								 
								if(childResource.get("deviceMgt-captureParam-Preprocessor"))
								{
									childResource.get("deviceMgt-captureParam-Preprocessor").original = rv;
									childResource.get("deviceMgt-captureParam-Preprocessor").newValue = rv; 	
								} 
							}
							
							// 叠加时间位置
							if($("deviceMgt-captureParam-TimeAddPosition-X") && $("deviceMgt-captureParam-TimeAddPosition-Y"))
							{
								var rv = Nrcap2.Config.GetComplex(WebClient.connectId, puid, resType, resIdx, "CFG_IV_TimeAddPosition",""); 
							
								// rv = Nrcap2.VideoOverlay.TimeAddPositionControl(WebClient.connectId, puid, resIdx, "get");
								// alert(Object.toJSON(rv));
								if(rv && typeof rv == "object" && rv.XPos != null && typeof rv.XPos != "undefined")
								{
									if(rv.XPos != null && typeof rv.XPos != "undefined")
									{
										$("deviceMgt-captureParam-TimeAddPosition-X").value = rv.XPos;	
										$("deviceMgt-captureParam-TimeAddPosition-X").disabled = false;
										$("deviceMgt-captureParam-TimeAddPosition-X").className = "";
										
										if(childResource.get("deviceMgt-captureParam-TimeAddPosition-X"))
										{
											childResource.get("deviceMgt-captureParam-TimeAddPosition-X").original = rv.XPos;
											childResource.get("deviceMgt-captureParam-TimeAddPosition-X").newValue = rv.XPos; 	
										}
									}
									else
									{
										$("deviceMgt-captureParam-TimeAddPosition-X").disabled = true;
										$("deviceMgt-captureParam-TimeAddPosition-X").className = "input-readonly";
									}
									
									if(rv.YPos != null && typeof rv.YPos != "undefined")
									{
										$("deviceMgt-captureParam-TimeAddPosition-Y").value = rv.YPos;	
										$("deviceMgt-captureParam-TimeAddPosition-Y").disabled = false;
										$("deviceMgt-captureParam-TimeAddPosition-Y").className = "";
										
										
										if(childResource.get("deviceMgt-captureParam-TimeAddPosition-Y"))
										{
											childResource.get("deviceMgt-captureParam-TimeAddPosition-Y").original = rv.YPos;
											childResource.get("deviceMgt-captureParam-TimeAddPosition-Y").newValue = rv.YPos; 	
										}
									}
									else
									{
										$("deviceMgt-captureParam-TimeAddPosition-Y").disabled = true;
										$("deviceMgt-captureParam-TimeAddPosition-Y").className = "input-readonly";
									}  
								} 
								else
								{
									$("deviceMgt-captureParam-TimeAddPosition-X").disabled = true;
									$("deviceMgt-captureParam-TimeAddPosition-X").className = "input-readonly";
									$("deviceMgt-captureParam-TimeAddPosition-Y").disabled = true;
									$("deviceMgt-captureParam-TimeAddPosition-Y").className = "input-readonly";
								}
								
							}
							
							// 文字内容
							if($("deviceMgt-captureParam-TextAdd"))
							{
								var rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_TextAdd",""); 
								// alert(rv);
								if(rv == false || rv == null || parseInt(rv) == 28932) rv = ""; 
								
								$("deviceMgt-captureParam-TextAdd").value = rv; 
								if(rv == "") 
								{
									$("deviceMgt-captureParam-TextAdd").disabled = true;
									$("deviceMgt-captureParam-TextAdd").className = "input-readonly"; 								
								}
								else
								{
									$("deviceMgt-captureParam-TextAdd").disabled = false;
									$("deviceMgt-captureParam-TextAdd").className = ""; 
								}
								 
								if(childResource.get("deviceMgt-captureParam-TextAdd"))
								{
									childResource.get("deviceMgt-captureParam-TextAdd").original = rv;
									childResource.get("deviceMgt-captureParam-TextAdd").newValue = rv; 	
								}  
							}
							
							if($("deviceMgt-captureParam-LogoAdd") && $("deviceMgt-captureParam-LogoAdd-scan"))
							{
								$("deviceMgt-captureParam-LogoAdd").disabled = true;
								$("deviceMgt-captureParam-LogoAdd").className = "input-readonly";
								$("deviceMgt-captureParam-LogoAdd-scan").disabled = true;
							}
							
							// 叠加文字位置
							if($("deviceMgt-captureParam-TextAddPosition-X") && $("deviceMgt-captureParam-TextAddPosition-Y"))
							{
								var rv = Nrcap2.Config.GetComplex(WebClient.connectId, puid, resType, resIdx, "CFG_IV_TextAddPosition",""); 
							
								// rv = Nrcap2.VideoOverlay.TextAddPositionControl(WebClient.connectId, puid, resIdx, "get");
								// alert(Object.toJSON(rv));
								if(rv && typeof rv == "object" && rv.XPos != null && typeof rv.XPos != "undefined")
								{
									if(rv.XPos != null && typeof rv.XPos != "undefined")
									{
										$("deviceMgt-captureParam-TextAddPosition-X").value = rv.XPos;	
										$("deviceMgt-captureParam-TextAddPosition-X").disabled = false;
										$("deviceMgt-captureParam-TextAddPosition-X").className = "";
										
										if(childResource.get("deviceMgt-captureParam-TextAddPosition-X"))
										{
											childResource.get("deviceMgt-captureParam-TextAddPosition-X").original = rv.XPos;
											childResource.get("deviceMgt-captureParam-TextAddPosition-X").newValue = rv.XPos; 	
										}
									}
									else
									{
										$("deviceMgt-captureParam-TextAddPosition-X").disabled = true;
										$("deviceMgt-captureParam-TextAddPosition-X").className = "input-readonly";
									}
									
									if(rv.YPos != null && typeof rv.YPos != "undefined")
									{
										$("deviceMgt-captureParam-TextAddPosition-Y").value = rv.YPos;	
										$("deviceMgt-captureParam-TextAddPosition-Y").disabled = false;
										$("deviceMgt-captureParam-TextAddPosition-Y").className = "";
										
										
										if(childResource.get("deviceMgt-captureParam-TextAddPosition-Y"))
										{
											childResource.get("deviceMgt-captureParam-TextAddPosition-Y").original = rv.YPos;
											childResource.get("deviceMgt-captureParam-TextAddPosition-Y").newValue = rv.YPos; 	
										}
									}
									else
									{
										$("deviceMgt-captureParam-TextAddPosition-Y").disabled = true;
										$("deviceMgt-captureParam-TextAddPosition-Y").className = "input-readonly";
									}  
								}
								else
								{
									$("deviceMgt-captureParam-TextAddPosition-X").disabled = true;
									$("deviceMgt-captureParam-TextAddPosition-X").className = "input-readonly";
									$("deviceMgt-captureParam-TextAddPosition-Y").disabled = true;
									$("deviceMgt-captureParam-TextAddPosition-Y").className = "input-readonly";
								}  
							}
							
							// 叠加图片位置
							if($("deviceMgt-captureParam-LogoAddPosition-X") && $("deviceMgt-captureParam-LogoAddPosition-Y"))
							{
								var rv = Nrcap2.Config.GetComplex(WebClient.connectId, puid, resType, resIdx, "CFG_IV_TextAddPosition",""); 
							
								// rv = Nrcap2.VideoOverlay.TextAddPositionControl(WebClient.connectId, puid, resIdx, "get");
								// alert(Object.toJSON(rv));
								if(rv && typeof rv == "object" && rv.XPos != null && typeof rv.XPos != "undefined")
								{
									if(rv.XPos != null && typeof rv.XPos != "undefined")
									{
										$("deviceMgt-captureParam-LogoAddPosition-X").value = rv.XPos;	
										$("deviceMgt-captureParam-LogoAddPosition-X").disabled = false;
										$("deviceMgt-captureParam-LogoAddPosition-X").className = "";
										
										if(childResource.get("deviceMgt-captureParam-LogoAddPosition-X"))
										{
											childResource.get("deviceMgt-captureParam-LogoAddPosition-X").original = rv.XPos;
											childResource.get("deviceMgt-captureParam-LogoAddPosition-X").newValue = rv.XPos; 	
										}
									}
									else
									{
										$("deviceMgt-captureParam-LogoAddPosition-X").disabled = true;
										$("deviceMgt-captureParam-LogoAddPosition-X").className = "input-readonly";
									}
									
									if(rv.YPos != null && typeof rv.YPos != "undefined")
									{
										$("deviceMgt-captureParam-LogoAddPosition-Y").value = rv.YPos;	
										$("deviceMgt-captureParam-LogoAddPosition-Y").disabled = false;
										$("deviceMgt-captureParam-LogoAddPosition-Y").className = "";
										
										
										if(childResource.get("deviceMgt-captureParam-LogoAddPosition-Y"))
										{
											childResource.get("deviceMgt-captureParam-LogoAddPosition-Y").original = rv.YPos;
											childResource.get("deviceMgt-captureParam-LogoAddPosition-Y").newValue = rv.YPos; 	
										}
									}
									else
									{
										$("deviceMgt-captureParam-LogoAddPosition-Y").disabled = true;
										$("deviceMgt-captureParam-LogoAddPosition-Y").className = "input-readonly";
									}  
								}
								else
								{
									$("deviceMgt-captureParam-LogoAddPosition-X").disabled = true;
									$("deviceMgt-captureParam-LogoAddPosition-X").className = "input-readonly";
									$("deviceMgt-captureParam-LogoAddPosition-Y").disabled = true;
									$("deviceMgt-captureParam-LogoAddPosition-Y").className = "input-readonly";
								}   
							}
							
							// 是否叠加报警GPS
							if($("deviceMgt-captureParam-AddGPSAlarm"))
							{
								// 速度报警时警告色叠加GPS
								rv = Nrcap2.Config.GetSimple(WebClient.connectId, puid, resType, resIdx, "CFG_IV_AddGPSAlarm",""); 
								// alert(rv);
								switch(parseInt(rv))
								{
									case 0: rv = false; break;
									case 1: rv = true; break;
									default: rv = null; break; 
								} 
								
								$("deviceMgt-captureParam-AddGPSAlarm").checked = rv; 
								if(rv == null) 
								{
									$("deviceMgt-captureParam-AddGPSAlarm").disabled = true; 						
								}
								else
								{
									$("deviceMgt-captureParam-AddGPSAlarm").disabled = false; 
								}
								 
								if(childResource.get("deviceMgt-captureParam-AddGPSAlarm"))
								{
									childResource.get("deviceMgt-captureParam-AddGPSAlarm").original = $("deviceMgt-captureParam-AddGPSAlarm").checked;
									childResource.get("deviceMgt-captureParam-AddGPSAlarm").newValue = $("deviceMgt-captureParam-AddGPSAlarm").checked; 	
								} 
							}
							
							
							
							// <=--e-captureParam--------------------------------------------------------------------------  
						
						
						}
						break;
					
					case Nrcap2.Enum.PuResourceType.VideoOut: typeName = "输出视频"; 
						 
						break;
					
					case Nrcap2.Enum.PuResourceType.PTZ: typeName = "云台"; 
						 
						break;
					
					case Nrcap2.Enum.PuResourceType.Storager: typeName = "存储器（前端存储）"; 
						 
						break;
					
					case Nrcap2.Enum.PuResourceType.SC: typeName = "存储器（中心存储）"; 
						 
						break;
					
					case Nrcap2.Enum.PuResourceType.SerialPort: typeName = "串口"; 
						 
						break;
					
					case Nrcap2.Enum.PuResourceType.Wireless: typeName = "无线模块"; 
						 
						break;
					
					default:
						WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.DeviceResource.SwitchFetchDRes",msg:"resType(" + resType + ") unknown error!"});
						return false;
						break;
					
				} 
				 
				// --s-------------------------------------------------------------------------------
				if($("deviceMgt-res-typeName")) $("deviceMgt-res-typeName").value = typeName;
				if($("deviceMgt-res-idx")) $("deviceMgt-res-idx").value = resIdx; 
				 
				if($("deviceMgt-res-enable")) 
				{
					$("deviceMgt-res-enable").checked = enable;
					$("deviceMgt-res-enable-pad").disabled = resType == Nrcap2.Enum.PuResourceType.SELF || display == "none" ? true : false;  	 
				}
				if($("deviceMgt-res-name"))
				{
					$("deviceMgt-res-name").value = name;
					$("deviceMgt-res-name").readOnly = display == "none" ? true : false; 
					$("deviceMgt-res-name").className = display == "none" ? "input-readonly" : "";
				}
				if($("deviceMgt-res-desc"))
				{
					$("deviceMgt-res-desc").value = desc; 
					$("deviceMgt-res-desc").readOnly = display == "none" ? true : false; 
					$("deviceMgt-res-desc").className = display == "none" ? "input-readonly" : "";
				} 
				
				// --e-------------------------------------------------------------------------------
			}, 
			
			Html:function(){
				var htmlstr = "";
				
				htmlstr += "<div id=\"deviceTree\" class=\"resourceTree\">";
					htmlstr += "<img style=\"width:20px;height:20px;\" src=\"images/loading.gif\" />";
					htmlstr += "<span>正在获取资源,请稍候...</span>";
				htmlstr += "</div>"; 
				
				if($("deviceResourceBox")) $("deviceResourceBox").innerHTML = htmlstr; 
				//alert("init deviceresource");  
					
				htmlstr = "<table width=\"190\" height=\"120\" align=\"0\" cellspacing=\"0\" cellpadding=\"0\" >";
					htmlstr += "<tr>"; 
						htmlstr += "<td><label>&nbsp;类型:</label></td>";
						htmlstr += "<td><input type=\"text\" id=\"deviceMgt-res-typeName\" style=\"width:135px;\" class=\"input-readonly\" readonly /></td>"; 
					htmlstr += "</tr>";
				
					htmlstr += "<tr>"; 
						htmlstr += "<td><label>&nbsp;索引:</label></td>";
						htmlstr += "<td>";
							htmlstr += "<input type=\"text\" id=\"deviceMgt-res-idx\" style=\"width:60px;\"  class=\"input-readonly\" readonly />";
							htmlstr += "&nbsp;<span id=\"deviceMgt-res-enable-pad\" ><input type=\"checkbox\" id=\"deviceMgt-res-enable\" />";
							htmlstr += "<label for=\"deviceMgt-res-enable\" >使能资源</label></span>"; 
						htmlstr += "</td>"; 
					htmlstr += "</tr>";
					
					htmlstr += "<tr>"; 
						htmlstr += "<td><label>&nbsp;名称:</label></td>";
						htmlstr += "<td><input type=\"text\" id=\"deviceMgt-res-name\" style=\"width:135px;\"/></td>"; 
					htmlstr += "</tr>";
					
					htmlstr += "<tr>"; 
						htmlstr += "<td><label>&nbsp;描述:</label></td>";
						htmlstr += "<td><input type=\"text\" id=\"deviceMgt-res-desc\" style=\"width:135px;\" /></td>"; 
					htmlstr += "</tr>";
				htmlstr += "</table>";
				
				if($("deviceResInfoBox")) $("deviceResInfoBox").innerHTML = htmlstr;  
			},
			
			end:true			
		},
		
		/*
		*	函数名		：FetchResource
		*	函数功能   	：获取资源 
		*	备注			：无 
		*	作者			：huzw
		*	时间			：2011.02.21	
		*/
		FetchResource:function(){
			WebClient.Resource.FetchAllResource();  
			var resource = WebClient.Resource.resource;
			WebClient.Resource.CreateResourceTree(resource,"video"); // 创建video tree
			WebClient.Resource.CreateResourceTree(resource,"query"); // 创建query tree
			WebClient.Resource.CreateResourceTree(resource,"platform"); // 创建platform tree
			WebClient.Resource.CreateResourceTree(resource,"device"); // 创建device tree
			
			//延迟加载logic group tree
			window.setTimeout(
				function(){
					WebClient.Resource.FetchLogicResource();
					var logicGroup = WebClient.Resource.logicGroup;
					WebClient.Resource.CreateResourceTree(logicGroup,"logic"); //创建logic tree
				},
				450
			);
		//	window.setTimeout(
//				function(){ 
//					/* 浏览器全屏显示 */
//					var WshShell = new ActiveXObject('WScript.Shell')
//					WshShell.SendKeys('{F11}'); 
//				},5000
//			);
			
			/* if(WebClient.updateOnline)
			{
				//循环侦测在线状态 
				WebClient.Resource.updateTimer = window.setInterval(
					function(){  
						WebClient.Resource.UpdateOnlineStatus();  
					}												
					,30000 //per 30s												
				);	
			}
			else
			{
				if(WebClient.Resource.updateTimer)
				{
					window.clearInterval(WebClient.Resource.updateTimer);
				}
				WebClient.Resource.updateTimer = null;
			} */
				 
			
		},
		
		/*
		*	函数名		：FetchAllResource
		*	函数功能   	：获取所有资源 
		*	备注			：原来没有同时获取子资源，但是后来为了好处理逻辑分组资源的 
		*			    ：播放，使之先获取所有的资源，而在列非逻辑分组三级视频头资
		*			    ：源树时，将会再次获取一次对应所有子资源信息
		*	作者			：huzw
		*	时间			：2011.02.21	
		*/
		FetchAllResource:function(){
			WebClient.Resource.resource = new Hash();
			 
			// ---分页循环获取存储文件
			var flag = true, offset = 0, count = 200;
			var puResTotalInfos = new Array(); // 设备资源总信息 
			while(flag)
			{  
				var puInfos = Nrcap2.FetchResource(WebClient.connectId,Nrcap2.Enum.FetchResourceLevel.Nrcap2_GetPUInfo, offset, count, ""); // alert(Object.toJSON(puInfos));  //new Array();  
			
				if(puInfos && typeof puInfos == "object" && Object.isArray(puInfos))
				{	 
					if(puInfos.length > 0)
					{
						puResTotalInfos = puResTotalInfos.concat(puInfos); // alert(puInfos.length);
						offset = parseInt(offset + count);
						if(puInfos.length < count)
						{ 
							flag = false;
						} 
					}
					else
					{
						flag = false;
					}	
				} 
				else
				{
					flag = false;
				}
			} // end while ---
			 
			if(typeof puResTotalInfos == "object" && puResTotalInfos.constructor == Array)
			{
				if(typeof WebClient.sortList == "undefined" || WebClient.sortList == true)
				{
					var resource = WebClient.Resource.resource;
					if(puResTotalInfos && typeof puResTotalInfos == "object")
					{ 
						var online_enc = new Hash(), online_wenc = new Hash();
						var offline_enc = new Hash(), offline_wenc = new Hash();
						var online_other = new Hash(), offline_other = new Hash();
						
						puResTotalInfos.each(
							function(node){ 
								if(node.online != "1" || node.enable != "1") return; 
								switch(node.modelType)
								{
									case Nrcap2.Enum.PuModelType.WENC:	
										online_wenc.set(node.puid, node); // WENC在线使能
										break;
									case Nrcap2.Enum.PuModelType.ENC:	
										online_enc.set(node.puid, node); // ENC在线使能
										break;
									default:
										online_other.set(node.puid, node); // 其他在线使能
										break;
								} 
							}
						); 
						
						puResTotalInfos.each(
							function(node){ 
								if(node.online == "1" && node.enable == "1") return; 
								switch(node.modelType)
								{
									case Nrcap2.Enum.PuModelType.WENC:	
										offline_wenc.set(node.puid, node); // WENC不在线或未使能





										break;
									case Nrcap2.Enum.PuModelType.ENC:	
										offline_enc.set(node.puid, node); // ENC不在线或未使能





										break;
									default:
										offline_other.set(node.puid, node); // 其他不在线或未使能





										break;
								} 
							}
						);   
						// 在线使能
						resource = resource.merge(online_other); 
						resource = resource.merge(online_wenc); 
						resource = resource.merge(online_enc); 
						// 不在线或未使能 
						resource = resource.merge(offline_wenc); 
						resource = resource.merge(offline_enc);  
						resource = resource.merge(offline_other); 
					}  
					
					WebClient.Resource.resource = resource; 
					// alert(Object.toJSON(WebClient.Resource.resource)); 
				}
				else
				{
					puResTotalInfos.each(
						function(node,i){ 
							// if(node.modelType == "ENC" ) return;
							WebClient.Resource.resource.set(node.puid,node);						
						}
					); 
				} 
			}
			
			// var puInfos = Nrcap2.FetchResource(WebClient.connectId,Nrcap2.Enum.FetchResourceLevel.Nrcap2_GetPUInfo,0,250,"");
			// alert(Object.toJSON(puResTotalInfos));  //new Array();  
			
		/*	if(typeof puResTotalInfos == "object" && puResTotalInfos.constructor == Array)
			{
				puResTotalInfos.each(
					function(node,i){ 
						// if(node.modelType == "ENC" ) return;
						WebClient.Resource.resource.set(node.puid,node);						
					}
				);
			} 
		*/
		
		
			//for(var i = 0;i < puResTotalInfos.length;i++)
//			{
//				var puInfo = puResTotalInfos[i];
//				var puid = puInfo["#text"];
//				
//				WebClient.Resource.resource.set(puid,new Nrcap2.Struct.PUNodeStruct(puid,puInfo.Name,puInfo.Description,puInfo.ModelName,puInfo.ModelType,puInfo.ManufactrueID,puInfo.ResType,puInfo.Enable,puInfo.Online));
//				
//				/*var puResourcesInfos = Nrcap2.FetchResource(WebClient.connectId,Nrcap2.Enum.FetchResourceLevel.Nrcap2_GetPUResourceInfo,0,4294967295,"",{PUID:puid});
//				
//				if(puResourcesInfos.length > 0)
//				{
//					WebClient.Resource.resource.get(puid).childResource = puResourcesInfos; //保存pu子资源 
//				}*/ 
//				
//			} 
			//alert(Object.toJSON(WebClient.Resource.resource));  
		},
		
		/*
		*	函数名		：FetchLogicResource
		*	函数功能   	：获取逻辑分组资源
		*	备注			：无 
		*	作者			：huzw
		*	时间			：2011.02.21	
		*/
		FetchLogicResource:function(){
			WebClient.Resource.logicGroup = new Hash();
			
			var lg = Nrcap2.GetLogicGroups(WebClient.connectId); //alert(Object.toJSON(lg));
			for(var i = 0; i < lg.length; i++)
			{
				//if(i == 0)
				{
					//WebClient.Resource.logicGroup.set(lg[i].Name,{"Index":lg[i].Index,"Name":lg[i].Name,"LastRefreshTime":lg[i].LastRefreshTime,"RefreshInterval":lg[i].RefreshInterval,"childResource":new Array()});
					
					WebClient.Resource.logicGroup.set(lg[i].name,lg[i]);
					
					/*var lgn = Nrcap2.GetLogicGroupNodes(WebClient.connectId,lg[i].index);  alert(Object.toJSON(lgn));
					if(typeof lgn == "object" && lgn.constructor == Array)
					{
						for(var j = 0; j < lgn.length; j++)
						{
							// 获取逻辑分组节点下的资源
							var lgr = Nrcap2.GetLogicGroupResource(WebClient.connectId,lg[i].index,lgn[j].index); // alert(Object.toJSON(lgr));
							
						}
						
					}*/
					
					/*// 获取逻辑分组下的节点
					var lgn = Nrcap2.GetLogicGroupNodes(WebClient.connectId,lg[i].Index); // alert(Object.toJSON(lgn));
					if(typeof lgn == "object" && lgn.constructor == Array)
					{
						for(var j = 0; j < lgn.length; j++)
						{
							// 获取逻辑分组节点下的资源
							var lgr = Nrcap2.GetLogicGroupResource(WebClient.connectId,lg[i].Index,lgn[j].Index);  // alert(Object.toJSON(lgr));
							if(lgn.length > 0)  
							{
								WebClient.Resource.logicGroup.get(lg[i].Name).childResource.push({"Index":lgn[j].Index,"Name":lgn[j].Name,"ParentNode_Index":lgn[j].ParentNode_Index,"childResource":lgr});
							}
							
						}//end j for
					} */
				} 
			}//end i for
			
			//alert(Object.toJSON(WebClient.Resource.logicGroup)); 
		},
		
		CreateResourceTree:function(resource,style){ 
		    if(typeof style == "undefined" || !style)
		    {
		        return false;
		    }
	        
			if(!resource && typeof resource != "object")
			{
				return false;
			}
			
			var systemName = Nrcap2.Connections.get(WebClient.connectId).systemName;
			if(!systemName) systemName = "网络视频监控系统";
			
	        var htmlstr = "";
		    switch(style)
		    {
		         case "video":
		         case "query":
		            htmlstr += "<div id=\""+style+"_cesSystemManagement\" style=\"white-space:nowrap; margin-top:2px !important; margin-top:2px;\">"; 
		                htmlstr += "<input type=\"button\" id=\""+style+"_cesSystemManagement_img_title\" class=\"minus\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.Expandsion($('"+style+"_cesSystemManagement_childresourcebox'),$('"+style+"_cesSystemManagement_img_title'));\" /><input type=\"button\" id=\""+style+"_cesSystemManagement_img_ico\" class=\"root\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.Expandsion($('"+style+"_cesSystemManagement_childresourcebox'),$('"+style+"_cesSystemManagement_img_title'));\" /><a href=\"#self\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.Expandsion($('"+style+"_cesSystemManagement_childresourcebox'),$('"+style+"_cesSystemManagement_img_title'));\" >"+systemName+"</a>";  
		                
		            htmlstr += "</div>";  
		            htmlstr += "<div id=\""+style+"_cesSystemManagement_childresourcebox\" class=\"childresourcebox_blankline\" style=\"display:block;padding-left:15px;border:0px solid red;\">";
					
					//pu resource
					var lastpuid = "";
					resource.each(
						function(item){
							var node = item.value;  
							
							var modelType = node.modelType; 
							
							if(modelType != Nrcap2.Enum.PuModelType.ENC && modelType != Nrcap2.Enum.PuModelType.WENC)
							{ 
								if(modelType == Nrcap2.Enum.PuModelType.CSU)
								{
									WebClient.Resource.csuPuid = node.puid;//获取中心存储单元PUID
									//alert(WebClient.Resource.csuPuid); 
									WebClient.Resource.csuInfo = node;//获取中心存储单元相关信息
								}
								return;
							}
							 
							var prefix = "";
							switch(modelType)
							{
								case Nrcap2.Enum.PuModelType.ENC:
									prefix = "station";
									break;
								//case Nrcap2.Enum.PuModelType.DEC:
									//break;
								case Nrcap2.Enum.PuModelType.WENC:
									prefix = "gateway";
									break;
								//case Nrcap2.Enum.PuModelType.WDEC:
									//break;
								default:
									break;
							}							   
							 
							var suffix = "_disabled";
							if(node.enable == "1" && node.online == "1")
							{
								suffix = "";
							}
							
							var icoclass = prefix + "" + suffix; 
							
							lastpuid = node.puid; 
							
							htmlstr += "<div style=\"white-space:nowrap;border:0px solid red;\">";
								htmlstr += "<input type=\"button\" id=\""+style+"_"+lastpuid+"_img_title\" class=\"plus\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.FetchChildResource('"+lastpuid+"','"+style+"');\" /><input type=\"button\" id=\""+style+"_"+lastpuid+"_img_ico\" class=\""+icoclass+"\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.FetchChildResource('"+lastpuid+"','"+style+"');\" /><a id=\""+style+"_"+lastpuid+"\" href=\"#self\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.FetchChildResource('"+lastpuid+"','"+style+"');\" >"+node.name+"</a>"; 
							htmlstr += "</div>";
							htmlstr += "<div id=\""+style+"_"+lastpuid+"_childresourcebox\" class=\"childresourcebox_directline\" style=\"display:none;padding-left:15px;border:0px solid red;width:auto;height:auto;\">";
							htmlstr += "</div>";
						}
					);
					
					if(lastpuid == "")
					{
						htmlstr += "<span style=\"font-size:12px; font-style:italic; white-space:nowrap;\">(获得视频资源为空)</span>";
					}
					else
					{ 
						htmlstr =  htmlstr.replace(new RegExp("id=\""+style+"_"+lastpuid+"_childresourcebox\" class=\"childresourcebox_directline\"","gm"),"id=\""+style+"_"+lastpuid+"_childresourcebox\" class=\"childresourcebox_blankline\"");  
					}
					
					htmlstr += "</div>";  
		            
		            break;
		         case "logic":
		            htmlstr += "<div id=\""+style+"_cesSystemManagement\" style=\"white-space:nowrap; margin-top:2px !important; margin-top:2px;\">"; 
		                htmlstr += "<input type=\"button\" id=\""+style+"_cesSystemManagement_img_title\" class=\"minus\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.Expandsion($('"+style+"_cesSystemManagement_childresourcebox'),$('"+style+"_cesSystemManagement_img_title'));\" /><input type=\"button\" id=\""+style+"_cesSystemManagement_img_ico\" class=\"root\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.Expandsion($('"+style+"_cesSystemManagement_childresourcebox'),$('"+style+"_cesSystemManagement_img_title'));\" /><a href=\"#self\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.Expandsion($('"+style+"_cesSystemManagement_childresourcebox'),$('"+style+"_cesSystemManagement_img_title'));\" >"+systemName+"</a>"; 
		                
		            htmlstr += "</div>"; 
		            htmlstr += "<div id=\""+style+"_cesSystemManagement_childresourcebox\" style=\"display:block;padding-left:15px;\">"; 
					
					//htmlstr += WebClient.Resource.CreateLogicTree(resource); // 逻辑分组主资源树
					
					//logic resource
					var logicGroup = resource;
					if(logicGroup && typeof logicGroup == "object")
					{
						var lastLogicNode = "";  
						var display = "none"; // (logicGroup.keys().length <= 1 ? "block" : "none"); 
						
						logicGroup.each(
							function(item){
								var node = item.value; //alert(Object.toJSON(node));
								//var suffixFirst = node.index + "_" + node.name; 
								var suffixFirst = node.index; 
								
								/*htmlstr += "<div id=\"logic_root_"+suffixFirst+"\" style=\"white-space:nowrap;\">";
									htmlstr += "<input type=\"button\" id=\"logic_root_"+suffixFirst+"_img_title\" class=\""+(display == "block"?"minus":"plus")+"\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.FetchChildLogicGroupNode('"+node.Index+"');\" /><input type=\"button\" id=\"logic_root_"+suffixFirst+"_img_ico\" class=\""+(display == "block" ? "stationmodel_expand" : "stationmodel_collapse")+"\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.FetchChildLogicGroupNode('"+node.Index+"');\" /><a href=\"#self\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.FetchChildLogicGroupNode('"+node.Index+"');\" >"+node.Name+"</a>";  
									
								htmlstr += "</div>"; 	  
		            			htmlstr += "<div id=\"logic_root_"+suffixFirst+"_childresourcebox\" class=\"childresourcebox_directline\" style=\"display:"+display+";padding-left:15px;border:0px solid red;\">"; 
								htmlstr += "</div>";*/
								
								htmlstr += "<div id=\"logic_root_"+suffixFirst+"\" style=\"white-space:nowrap;\">";
									htmlstr += "<input type=\"button\" id=\"logic_root_"+suffixFirst+"_img_title\" class=\""+(display == "block"?"minus":"plus")+"\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.SwitchFetchLogicGroupResource('"+node.index+"',1,'"+node.index+"','"+node.index+"');\" /><input type=\"button\" id=\"logic_root_"+suffixFirst+"_img_ico\" class=\""+(display == "block" ? "stationmodel_expand" : "stationmodel_collapse")+"\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.SwitchFetchLogicGroupResource('"+node.index+"',1,'"+node.index+"','"+node.index+"');\" /><a href=\"#self\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.SwitchFetchLogicGroupResource('"+node.index+"',1,'"+node.index+"','"+node.index+"');\" >"+node.name+"</a>";  
									
								htmlstr += "</div>"; 	  
		            			htmlstr += "<div id=\"logic_root_"+suffixFirst+"_childresourcebox\" class=\"childresourcebox_directline\" style=\"display:"+display+";padding-left:15px;border:0px solid red;\">"; 
								htmlstr += "</div>";
								
								lastLogicNode = suffixFirst;
							}
						);
					} 
					
					if(htmlstr != "")
					{
						htmlstr = htmlstr.replace(new RegExp("id=\"logic_root_"+lastLogicNode+"_childresourcebox\" class=\"childresourcebox_directline\"","gm"),"id=\"logic_root_"+lastLogicNode+"_childresourcebox\" class=\"childresourcebox_blankline\""); 
					}
					else
					{
						htmlstr += "<span style=\"font-style:Italic;\">(获得逻辑分组资源为空)</span>";
					}
					
		            htmlstr += "</div>"; //alert(htmlstr);
		            break;
				case 'platform':
					 htmlstr += "<div id=\""+style+"_cesSystemManagement\" style=\"white-space:nowrap; margin-top:2px !important; margin-top:2px;\">"; 
		                htmlstr += "<div type=\"button\" id=\""+style+"_cesSystemManagement_img_title_container\" class=\"\" style=\"float:left;width:16px; height:16px;\" onfocus=\"this.blur();\" >&nbsp;--</div><input type=\"button\" id=\""+style+"_cesSystemManagement_img_ico\" class=\"root\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.Expandsion($('"+style+"_cesSystemManagement_childresourcebox'),$('"+style+"_cesSystemManagement_img_title'));\" /><a href=\"#self\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.Expandsion($('"+style+"_cesSystemManagement_childresourcebox'),$('"+style+"_cesSystemManagement_img_title'));\" >"+systemName+"</a>"; 
		                
		            htmlstr += "</div>"; 
		            htmlstr += "<div id=\""+style+"_cesSystemManagement_childresourcebox\" style=\"display:block;padding-left:16px;\">";  
					
					break; 
				
				 case "device": 
				 	htmlstr += "<div id=\""+style+"_cesSystemManagement\" style=\"white-space:nowrap; margin-top:2px !important; margin-top:2px;\">"; 
		                htmlstr += "<input type=\"button\" id=\""+style+"_cesSystemManagement_img_title\" class=\"minus\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.Expandsion($('"+style+"_cesSystemManagement_childresourcebox'),$('"+style+"_cesSystemManagement_img_title'));\" /><input type=\"button\" id=\""+style+"_cesSystemManagement_img_ico\" class=\"root\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.Expandsion($('"+style+"_cesSystemManagement_childresourcebox'),$('"+style+"_cesSystemManagement_img_title'));\" /><a href=\"#self\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.Expandsion($('"+style+"_cesSystemManagement_childresourcebox'),$('"+style+"_cesSystemManagement_img_title'));\" >"+systemName+"</a>";  
		                
		            htmlstr += "</div>";  
		            htmlstr += "<div id=\""+style+"_cesSystemManagement_childresourcebox\" class=\"childresourcebox_blankline\" style=\"display:block;padding-left:15px;border:0px solid red;\">";
					
					//pu resource
					var lastpuid = "";
					resource.each(
						function(item){
							var node = item.value;  
							
							var modelType = node.modelType;  
							 
							var prefix = ""; 
							switch(modelType)
							{
								case Nrcap2.Enum.PuModelType.CSU: prefix = "storageUnit"; break;
								case Nrcap2.Enum.PuModelType.ENC: prefix = "station"; break;
								case Nrcap2.Enum.PuModelType.DEC: prefix = "decstation"; break;
								case Nrcap2.Enum.PuModelType.WENC: prefix = "gateway"; break;
							    case Nrcap2.Enum.PuModelType.WDEC: prefix = "decstation"; break;
								case Nrcap2.Enum.PuModelType.ESU: prefix = ""; return; break;
								default: break;
							}							   
							 
							var suffix = "_disabled";
							if(node.enable == "1" && node.online == "1")
							{
								suffix = "";
							}
							
							var icoclass = prefix + "" + suffix; 
							
							lastpuid = node.puid; 
							
							htmlstr += "<div style=\"white-space:nowrap;border:0px solid red;\">";
								htmlstr += "<input type=\"button\" id=\""+style+"_"+lastpuid+"_img_title\" class=\"plus\" onfocus=\"this.blur();\"onclick=\"WebClient.Resource.FetchChildResource('"+lastpuid+"','"+style+"');\" /><input type=\"button\" id=\""+style+"_"+lastpuid+"_img_ico\" class=\""+icoclass+"\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.DeviceResource.MainRegionInit('"+lastpuid+"','SELF','0');\" ondblclick=\"WebClient.Resource.FetchChildResource('"+lastpuid+"','"+style+"');\" /><a id=\""+style+"_"+lastpuid+"\" href=\"#self\" onfocus=\"this.blur();\"  onclick=\"WebClient.Resource.DeviceResource.MainRegionInit('"+lastpuid+"','SELF','0');\" ondblclick=\"WebClient.Resource.FetchChildResource('"+lastpuid+"','"+style+"');\" >"+node.name+"</a>"; 
							htmlstr += "</div>";
							htmlstr += "<div id=\""+style+"_"+lastpuid+"_childresourcebox\" class=\"childresourcebox_directline\" style=\"display:none;padding-left:15px;border:0px solid red;width:auto;height:auto;\">";
							htmlstr += "</div>";
						}
					);
					
					if(lastpuid == "")
					{
						htmlstr += "<span style=\"font-size:12px; font-style:italic; white-space:nowrap;\">(获得设备资源为空)</span>";
					}
					else
					{ 
						htmlstr =  htmlstr.replace(new RegExp("id=\""+style+"_"+lastpuid+"_childresourcebox\" class=\"childresourcebox_directline\"","gm"),"id=\""+style+"_"+lastpuid+"_childresourcebox\" class=\"childresourcebox_blankline\"");  
					}
					
					htmlstr += "</div>";  
				 	break;
					
		        default:
		            break;   
		    }		
		     
		    $(style + "Tree") ? $(style + "Tree").innerHTML = htmlstr : function(){return false;};
		},		
		
		//*20110412 start****************************************************************
		
		/* 处理（无限）多级逻辑分组获取节点资源 */
		SwitchFetchLogicGroupResource:function(rootIndex,level,logicIndex,logicParentIndexs){ 
			if(typeof rootIndex == "undefined")
			{
				return false;
			}
			
			if(typeof level == "undefined")
			{
				return false;
			}
			
			if(typeof logicIndex == "undefined")
			{
				return false;
			}
			
			if(typeof logicParentIndexs == "undefined")
			{
				return false;
			} 
			
			var logicGroup = WebClient.Resource.logicGroup;
			var logicResArr = new Array(); 
			
			level = parseInt(level);
			if(level == 1)
			{
				/* 根级逻辑分组 */
				if(rootIndex == logicIndex)
				{
					logicGroup.each(
						function(item){
							var node = item.value;
							if(node.index == rootIndex && node.childResource && node.childResource.constructor == Array)
							{ 
								if(node.childResource.length <= 0 || $("logic_root_"+rootIndex+"_childresourcebox").innerHTML == "" || ($("logic_root_"+rootIndex + "_logicempty") && $("logic_root_"+rootIndex + "_logicempty").value == "true"))
								{
									node.childResource = new Array();
									
									/* 获取根级逻辑节点 */
									var lgns = Nrcap2.GetLogicGroupNodes(WebClient.connectId,rootIndex); //alert(Object.toJSON(lgns));
									if(typeof lgns == "object" && lgns.constructor == Array)
									{
										for(var i = 0; i < lgns.length; i++)
										{
											var lgn = lgns[i];
											lgn.logicModel = "node";
											node.childResource.push(lgn);
										
										} // end for i
										
										logicResArr = node.childResource;
									} // end if lgns
									
								} // end if node.childResource
							} // end if node.Index
						}
					);
					/* 第二级逻辑节点 */
					WebClient.Resource.FetchChildLogicGroupNode_s(logicResArr,rootIndex,level,logicIndex,logicParentIndexs); 
				}
			}
			else
			{
				/* 子级逻辑分组 */
				//alert(rootIndex+":"+level+":"+logicIndex+":"+logicParentIndexs);
				
				if(logicParentIndexs.split(",").indexOf(logicIndex) < 0)
				{
					return false;
				}
				
				var lpIndexs = logicParentIndexs.split(","); 
				
				//alert(Object.toJSON(logicGroup)); 
				
				logicGroup.each(
					function(item){
						var node = item.value;
						
						if(node.index == rootIndex && node.childResource && node.childResource.constructor == Array)
						{  
							logicResArr = node.childResource;
							
							for(var i = 1;i < lpIndexs.length;i++)
							{
								var lpIndex = lpIndexs[i];
							
								if(i == 1 || lpIndex == logicIndex)
								{
									for(var m = 0;m < logicResArr.length;m++)
									{ 
										if(logicResArr[m].index == lpIndex)
										{
											if(typeof logicResArr[m].childResource && logicResArr[m].childResource.constructor == Array)
											{  
												logicResArr = logicResArr[m].childResource; 
											}
										}
										
									} // end for m
								}
								
								/*alert("i===" + i + ", lpIndex===" + lpIndex + ", logicIndex==="+ logicIndex);  
								alert(Object.toJSON(logicResArr)); */
								
								if(lpIndex != logicIndex)
								{ 
									for(var j = 0;j < logicResArr.length;j++)
									{ 
										if(logicResArr[j].index == lpIndex)
										{
											if(typeof logicResArr[j].childResource && logicResArr[j].childResource.constructor == Array)
											{ 
												/*alert("j====" + j);
												alert(Object.toJSON(logicResArr));*/ 
												
												logicResArr = logicResArr[j].childResource;
												
												/*alert("j====" + (j+1));
												alert(Object.toJSON(logicResArr)); */
											}
										}
										
									} // end for j
								}
								else
								{ 
									/*alert(111);
									alert(Object.toJSON(logicResArr)); */
									
									var logictype = "logicnode";
									 
									if((logicResArr && logicResArr.length > 0) && ($(rootIndex + "_" + logicIndex + "_childresourcebox") && $(rootIndex + "_" + logicIndex + "_childresourcebox").innerHTML != "") && ($(rootIndex + "_" + logicIndex + "_logicempty") && $(rootIndex + "_" + logicIndex + "_logicempty").value == "false"))
									{
										/* 隐藏的logictype */
										if($(rootIndex + "_" + logicIndex +"_logictype"))
										{
											if($(rootIndex + "_" + logicIndex +"_logictype").value == "logicnode")
											{
												logictype = "logicnode"; // logic group nodes
											}
											else
											{
												logictype = "logicres"; // logic group res
											}
										}
										
									}
									else
									{ 	
										if(!logicResArr) logicResArr = new Array();
										
										/* 获取逻辑分组下的节点 */ 
										var lgns = Nrcap2.GetLogicGroupNodes(WebClient.connectId,rootIndex,lpIndex); // alert(Object.toJSON(lgns)); 
										
										if(typeof lgns == "object" && lgns.constructor == Array)
										{
											
											
											if(lgns.length > 0)
											{
												/* if lgns is not null */
												for(var k = 0; k < lgns.length; k++)
												{
													var lgn = lgns[k];
													lgn.logicModel = "node";
													logicResArr.push(lgn);
												} // end for k
												
												logictype = "logicnode";
											}
											else
											{  
												logictype = "logicres";
												
											}
											
											/* if lgns is null, then it will be video resources */
											/* 获取逻辑分组下的资源 */ 
											var lgrs = Nrcap2.GetLogicGroupResource(WebClient.connectId,rootIndex,lpIndex); // alert(Object.toJSON(lgrs));
											if(typeof lgrs == "object" && lgrs.constructor == Array)
											{
												for(var m = 0; m < lgrs.length; m++)
												{
													var lgr = lgrs[m];
													lgr.logicModel = "res";
													logicResArr.push(lgr);
												} // end for m	
											}
											
										} 
										
									}  
									/*alert(222);
									alert(Object.toJSON(logicResArr));*/
									
									if(logictype == "logicnode")
									{
										//alert(555 + ":" + logictype);
										WebClient.Resource.FetchChildLogicGroupNode_s(logicResArr,rootIndex,level,logicIndex,logicParentIndexs); 
									}
									else
									{
										//alert(666 + ":"+ logictype);
										WebClient.Resource.FetchChildLogicGroupResource_s(logicResArr,rootIndex,level,logicIndex,logicParentIndexs); 
									}
									 
								
								}
											 
									
							} // end for i
							
							 /*alert(333);   
							 alert(Object.toJSON(node.childResource)); //return;*/
							 
						} 
						
					}
				);
				
				// alert(Object.toJSON(logicGroup));
				
				//logicGroup.each(
//					function(item){
//						var node = item.value;
//						
//						if(node.index == rootIndex && node.childResource && node.childResource.constructor == Array)
//						{ 
//						 	//alert(Object.toJSON(node.childResource)); //return;
//						
//							logicResArr = node.childResource;
//							
//							for(var i = 1;i < lpIndexs.length;i++)
//							{
//								var lpIndex = lpIndexs[i];
//								
//								var lgArr = new Array(); 
//									
//								for(var k = 0;k < logicResArr.length;k++)
//								{ 
//									//alert(Object.toJSON(logicResArr[k])); //return;
//									if(logicResArr[k].index == lpIndex)
//									{
//										//alert(logicResArr[k].index +":::"+ logicResArr[k].name+":::"+lpIndex);
//										
//										lgArr = logicResArr[k].childResource = new Array(); 
//										
//										if(lgArr && lgArr.constructor == Array)
//										{ 	 
//											/* 获取逻辑分组下的节点 */ 
//											var lgns = Nrcap2.GetLogicGroupNodes(WebClient.connectId,rootIndex,lpIndex); 
//											  
//											if(typeof lgns == "object" && lgns.constructor == Array)
//											{   
//											
//											    //alert(Object.toJSON(lgArr)); 
//												for(var j = 0; j < lgns.length; j++)
//												{
//													var lgn = lgns[j];
//													lgArr.push(lgn);
//												} // end for j
//												//alert(Object.toJSON(lgArr));
//												//alert(Object.toJSON(logicResArr))	
//												 
//												if(logicIndex == lpIndex) 
//												{
//													if(lgns.length <= 0)
//													{
//														//alert(111);
//														var lgr = Nrcap2.GetLogicGroupResource(WebClient.connectId,rootIndex,lpIndex); 
//														//alert(Object.toJSON(lgr)); 
//														if(typeof lgr == "object" && lgr.constructor == Array)
//														{
//															logicResArr[k].childResource = lgArr = lgr; 
//														}
//														WebClient.Resource.FetchChildLogicGroupResource_s(lgArr,rootIndex,level,logicIndex,logicParentIndexs);  
//													}
//													else
//													{
//														//alert(222);
//														WebClient.Resource.FetchChildLogicGroupNode_s(lgArr,rootIndex,level,logicIndex,logicParentIndexs);  
//													}		 
//													
//												}											
//												
//											} 
//											
//										} // end 
//										
//									} // end 
//									
//								} // end for k    
//									 
//								logicResArr = lgArr; // 往下一级遍历
















//								
//								//alert(Object.toJSON(logicResArr)); //return;
//									
//							} // end for i
//							  
//							 alert(Object.toJSON(node.childResource)); //return;
//						} 
//						
//					}
//				);
				
			}
			   
		},	
		
		GetLogicGroupNodeByIndex:function(rootIndex,logicIndex,logicParentIndexs){
			
			return [];
		},
		
		FetchChildLogicGroupNode_s:function(logicResArr,rootIndex,level,logicIndex,logicParentIndexs){
			//WebClient.Resource.SwitchFetchLogicGroupResource(rootIndex,(level + 1),logicIndex,logicParentIndexs + "," +logicIndex);
			if(!logicResArr || typeof logicResArr != "object" || logicResArr.constructor != Array)
			{
				return false;
			}
			 
			var lpIndexs = logicParentIndexs.replace(new RegExp(",","gm"),"_");  //alert(lpIndexs);
			var suffixFirst = rootIndex; 
			var suffixSecond = "";
			var htmlstr = "", lastnode = "";
			
			var childboxkeystr = suffixFirst;
			
			level = parseInt(level);
			if(level == 1)
			{
				childboxkeystr = "logic_root_" + suffixFirst; 
			}
			else
			{
				childboxkeystr = suffixFirst + "_" + logicIndex;
			} 
			
			if($(childboxkeystr + "_childresourcebox"))
			{
				if($(childboxkeystr + "_childresourcebox").innerHTML == "" || ($(childboxkeystr+"_logicempty") && $(childboxkeystr+"_logicempty").value == "true"))
				{
					if(logicResArr.length >= 0)
					{
						// alert(Object.toJSON(logicResArr)); 
						
						for(var i = 0; i < logicResArr.length; i++)
						{
							var logicArr = logicResArr[i];
							
							switch(logicArr.logicModel)
							{
								case 'node':
									var lgIndex = logicArr.index;
									suffixSecond = suffixFirst + "_" + lgIndex;
									var lgIndexs = logicParentIndexs + "," +lgIndex;
									
									htmlstr += "<div style=\"white-space:nowrap; border:0px dotted red; margin-top:0px !important; margin-top:0px; \">"; 
										htmlstr += "<input type=\"button\" id=\""+suffixSecond+"_img_title\" class=\"plus\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.SwitchFetchLogicGroupResource('"+rootIndex+"','"+(level+1)+"','"+lgIndex+"','"+lgIndexs+"');\" /><input type=\"button\" id=\""+suffixSecond+"_img_ico\" class=\"logic\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.SwitchFetchLogicGroupResource('"+rootIndex+"','"+(level+1)+"','"+lgIndex+"','"+lgIndexs+"');\" /><a href=\"#self\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.SwitchFetchLogicGroupResource('"+rootIndex+"','"+(level+1)+"','"+lgIndex+"','"+lgIndexs+"');\" >"+logicArr.name+"</a>";
								
									htmlstr += "</div>";
									
									break;
								
								case 'res':
									var puid = logicArr.puid;
									var ivIndex = logicArr.idx; 
									var ivEnable = logicArr.enable;
									suffixSecond = suffixFirst + "_" + logicIndex + "_" + puid + "_" + ivIndex;
									//alert(suffixSecond);
								
									var online = "0", enable = "0", flag = false;
									var res = WebClient.Resource.resource.get(puid);
									
									if(typeof res == "object")
									{
										if(!res.childResource)
										{
											var puRes = Nrcap2.FetchResource(WebClient.connectId,Nrcap2.Enum.FetchResourceLevel.Nrcap2_GetPUResourceInfo,0,4294967295,"",{"PUID":puid});
											//alert(puRes.toJSON());
											if(puRes.length > 0)
											{
												res.childResource = puRes;
											}
										}
										
										online = res.online;
										enable = res.enable;
										
										flag = true;
									} 
									
									var prefix = "inputvideo", suffix = "_disabled";
									if(flag)
									{ 
										if(online == "1" && enable == "1" && ivEnable == "1")
										{
											suffix = "";
										}
									}
									else
									{
										if(ivEnable == "1")
										{
											suffix = "";
										}
									}
									
									var icoclass = prefix + "" + suffix;
									
									htmlstr += "<div style=\"white-space:nowrap;margin-top:0px;border:0px gray dotted;\">";
									
										htmlstr += "<input type=\"button\" id=\""+suffixSecond+"_img_title\" class=\"outline\" onfocus=\"this.blur();\" onclick=\"WebClient.Video.PlayVideo('"+puid+"','"+ivIndex+"');\" /><input type=\"button\" id=\""+suffixSecond+"_img_ico\" class=\""+icoclass+"\" onfocus=\"this.blur();\" onclick=\"WebClient.Video.PlayVideo('"+puid+"','"+ivIndex+"');\" /><a href=\"#self\" onfocus=\"this.blur();\" onclick=\"WebClient.Video.PlayVideo('"+puid+"','"+ivIndex+"');\" >"+logicArr.name+"</a>";
										
									htmlstr += "</div>";
									break;
									
								default:
									break;
							} 
							
							htmlstr += "<div id=\""+suffixSecond+"_childresourcebox\" class=\"childresourcebox_directline\" style=\"display:none;padding-left:16px;\">"; 
							htmlstr += "</div>";
							
							lastnode = suffixSecond;  
						} // end for i
						// alert(htmlstr);
						if(htmlstr != "")
						{
							htmlstr = htmlstr.replace(new RegExp("id=\""+lastnode+"_img_title\" class=\"outline\"","gm"),"id=\""+lastnode+"_img_title\" class=\"endline\"");
							
							htmlstr = htmlstr.replace(new RegExp("id=\""+lastnode+"_childresourcebox\" class=\"childresourcebox_directline\"","gm"),"id=\""+lastnode+"_childresourcebox\" class=\"childresourcebox_blankline\"");
							
							htmlstr += "<input type=\"hidden\" id=\""+childboxkeystr+"_logicempty\" value=\"false\" />";
						}
						else
						{
							htmlstr += "<div style=\"white-space:nowrap;font-style:italic;\">"+(level ==  1 ? "[!未分配逻辑分组节点]" :"[!未分配逻辑分组资源]") + "</div>"; 
							htmlstr += "<input type=\"hidden\" id=\""+childboxkeystr+"_logicempty\" value=\"true\" />";
						} 
						
						htmlstr += "<input type=\"hidden\" id=\""+childboxkeystr+"_logictype\" value=\"logicnode\" />"; 
							
						$(childboxkeystr + "_childresourcebox").innerHTML = htmlstr;  
					}	
					
				} 
				
				if(level == 1)
				{
					WebClient.Resource.Expandsion($(childboxkeystr + "_childresourcebox"),$(childboxkeystr + "_img_title"),$(childboxkeystr + "_img_ico")); 
				}
				else
				{
					WebClient.Resource.Expandsion($(childboxkeystr + "_childresourcebox"),$(childboxkeystr + "_img_title")); 
				}
				
			} 
			 
		},
		
		FetchChildLogicGroupResource_s:function(logicResArr,rootIndex,level,logicIndex,logicParentIndexs){
			//WebClient.Resource.SwitchFetchLogicGroupResource(rootIndex,(level + 1),logicIndex,logicParentIndexs + "," +logicIndex);
			if(!logicResArr || typeof logicResArr != "object" || logicResArr.constructor != Array)
			{
				return false;
			}
			
			var suffixFirst = rootIndex; 
			var suffixSecond = "";
			var htmlstr = "", lastnode = "";
			
			var childboxkeystr = suffixFirst + "_" + logicIndex;   
			
			level = parseInt(level);
			
			if($(childboxkeystr + "_childresourcebox"))
			{ 
				if($(childboxkeystr + "_childresourcebox").innerHTML == "" || ($(childboxkeystr+"_logicempty") && $(childboxkeystr+"_logicempty").value == "true"))
				{
					if(typeof logicResArr == "object" && logicResArr.constructor == Array)
					{ 								
						logicResArr.each(
							function(item,i){
								var node = item;  //alert(Object.toJSON(node));
								
								var puid = node.puid;
								var ivIndex = node.idx; 
								var ivEnable = node.enable;
								
								suffixSecond = suffixFirst + "_" + logicIndex + "_" + puid + "_" + ivIndex; 
								//alert(suffixSecond);
								
								var online = "0", enable = "0", flag = false;
								var res = WebClient.Resource.resource.get(puid);
								
								if(typeof res == "object")
								{
									if(!res.childResource)
									{
										var puRes = Nrcap2.FetchResource(WebClient.connectId,Nrcap2.Enum.FetchResourceLevel.Nrcap2_GetPUResourceInfo,0,4294967295,"",{"PUID":puid});
										//alert(puRes.toJSON());
										if(puRes.length > 0)
										{
											res.childResource = puRes;
										}
									}
									
									online = res.online;
									enable = res.enable;
									
									flag = true;
								} 
								
								var prefix = "inputvideo", suffix = "_disabled";
								if(flag)
								{ 
									if(online == "1" && enable == "1" && ivEnable == "1")
									{
										suffix = "";
									}
								}
								else
								{
									if(ivEnable == "1")
									{
										suffix = "";
									}
								}
								
								var icoclass = prefix + "" + suffix;
								
								htmlstr += "<div style=\"white-space:nowrap;margin-top:0px;border:0px gray dotted;\">";
								
									htmlstr += "<input type=\"button\" id=\""+suffixSecond+"_img_title\" class=\"outline\" onfocus=\"this.blur();\" onclick=\"WebClient.Video.PlayVideo('"+puid+"','"+ivIndex+"');\" /><input type=\"button\" id=\""+suffixSecond+"_img_ico\" class=\""+icoclass+"\" onfocus=\"this.blur();\" onclick=\"WebClient.Video.PlayVideo('"+puid+"','"+ivIndex+"');\" /><a href=\"#self\" onfocus=\"this.blur();\" onclick=\"WebClient.Video.PlayVideo('"+puid+"','"+ivIndex+"');\" >"+node.name+"</a>";
									
								htmlstr += "</div>";
								
								htmlstr += "<div id=\""+suffixSecond+"_childresourcebox\" class=\"childresourcebox_directline\" style=\"display:none;padding-left:15px;\">"; 
								htmlstr += "</div>";
								
								lastnode = suffixSecond;
							}										  
						); //end list
						
						//alert("111_lgres++++++++++++" + htmlstr);
						
						if(htmlstr != "")
						{ 
							htmlstr = htmlstr.replace(new RegExp("id=\""+lastnode+"_img_title\" class=\"outline\"","gm"),"id=\""+lastnode+"_img_title\" class=\"endline\"");
							
							htmlstr = htmlstr.replace(new RegExp("id=\""+lastnode+"_childresourcebox\" class=\"childresourcebox_directline\"","gm"),"id=\""+lastnode+"_childresourcebox\" class=\"childresourcebox_blankline\"");
							
							htmlstr += "<input type=\"hidden\" id=\""+childboxkeystr+"_logicempty\" value=\"false\" />";
						}
						else
						{
							htmlstr += "<div style=\"white-space:nowrap;font-style:italic;\">[!未分配逻辑分组资源]</div>"; 
							htmlstr += "<input type=\"hidden\" id=\""+childboxkeystr+"_logicempty\" value=\"true\" />";
						}
						
						htmlstr += "<input type=\"hidden\" id=\""+childboxkeystr+"_logictype\" value=\"logicres\" />"; 
							
						$(childboxkeystr + "_childresourcebox").innerHTML = htmlstr;
						 
					}
				} 
					
				WebClient.Resource.Expandsion($(childboxkeystr + "_childresourcebox"),$(childboxkeystr + "_img_title")); 
			} 
			 
		},
				
		//*20110412 end****************************************************************
		
		FetchChildLogicGroupNode:function(logicIndex){
			if(typeof logicIndex == "undefined")
			{
				return false;
			}
			WebClient.Resource.logicGroup.each(
				function(item){
					var node = item.value;
					
					if(node.Index == logicIndex)
					{
						var suffixFirst = node.Index + "_" + node.Name;
						
						if($("logic_root_"+suffixFirst+"_childresourcebox") && typeof node.childResource == "object" && node.childResource.constructor == Array)
						{ 
							if(node.childResource.length > 0 && $("logic_root_"+suffixFirst+"_childresourcebox").innerHTML != "")
							{
								 
							}
							else
							{
								// 获取逻辑分组下的节点
								var lgn = Nrcap2.GetLogicGroupNodes(WebClient.connectId,node.Index);  //alert(Object.toJSON(lgn));
								
								if(typeof lgn == "object" && lgn.constructor == Array)
								{
									var htmlstr = "", lastnode = "", suffixSecond = "";
									
									for(var i = 0; i < lgn.length; i++)
									{
										var childRes = lgn[i];
										
										node.childResource.push({"Index":childRes.Index,"Name":childRes.Name,"ParentNode_Index":childRes.ParentNode_Index,"childResource":new Array()}); 
										
										suffixSecond = suffixFirst + "_" + childRes.Index + "_" + childRes.Name; 
										
										htmlstr += "<div style=\"white-space:nowrap; border:0px dotted red; margin-top:0px !important; margin-top:0px; \">";
											htmlstr += "<input type=\"button\" id=\""+suffixSecond+"_img_title\" class=\"plus\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.FetchChildLogicGroupResource('"+node.Index+"','"+childRes.Index+"');\" /><input type=\"button\" id=\""+suffixSecond+"_img_ico\" class=\"logic\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.FetchChildLogicGroupResource('"+node.Index+"','"+childRes.Index+"');\" /><a href=\"#self\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.FetchChildLogicGroupResource('"+node.Index+"','"+childRes.Index+"');\" >"+childRes.Name+"</a>";
										htmlstr += "</div>";
										htmlstr += "<div id=\""+suffixSecond+"_childresourcebox\" class=\"childresourcebox_directline\" style=\"display:none;padding-left:16px;\">"; 
										htmlstr += "</div>";
										
										lastnode = suffixSecond;  
									} // end for
									
									if(htmlstr != "")
									{
										htmlstr = htmlstr.replace(new RegExp("id=\""+lastnode+"_childresourcebox\" class=\"childresourcebox_directline\"","gm"),"id=\""+lastnode+"_childresourcebox\" class=\"childresourcebox_blankline\"");
									} 
									 
									if($("logic_root_"+suffixFirst+"_childresourcebox"))
									{
										$("logic_root_"+suffixFirst+"_childresourcebox").innerHTML = htmlstr;
									}
									
								} //end inner if
								
							}
							
						} //end suffixFirst
						
						WebClient.Resource.Expandsion($("logic_root_"+suffixFirst+"_childresourcebox"),$("logic_root_"+suffixFirst+"_img_title"),$("logic_root_"+suffixFirst+"_img_ico")); 
						
					}
					
				}
			); 
			
			//alert(WebClient.Resource.logicGroup.toJSON());
			
		},
		
		FetchChildLogicGroupResource:function(logicIndex,logicNodeIndex){
			if(typeof logicIndex == "undefined" || typeof logicNodeIndex == "undefined")
			{
				return false;
			}
			WebClient.Resource.logicGroup.each(
				function(item){
					var node = item.value;
					
					if(node.Index == logicIndex)
					{
						if(typeof node.childResource == "object" && node.childResource.constructor == Array)
						{
							var suffixFirst = node.Index + "_" + node.Name;
							
							for(var i = 0; i < node.childResource.length; i++)
							{
								var childRes = node.childResource[i];
								
								if(childRes.Index == logicNodeIndex)
								{
									var suffixSecond = suffixFirst + "_" + childRes.Index + "_" + childRes.Name;  
									
									if($(suffixSecond + "_childresourcebox") && typeof childRes.childResource == "object" && childRes.childResource.constructor == Array )
									{
										if(childRes.childResource.length > 0 && $(suffixSecond+"_childresourcebox").innerHTML != "")
										{
												
										}
										else
										{
											// 获取逻辑分组节点下的资源
			 								var lgr = Nrcap2.GetLogicGroupResource(WebClient.connectId,node.Index,childRes.Index);  // alert(Object.toJSON(lgr));	
											if(typeof lgr == "object" && lgr.constructor == Array)
											{
												childRes.childResource = lgr; 
												
												var htmlstr = "", lastnode = "";
												
												for(var j = 0; j < lgr.length; j++)
												{
													var child = lgr[j]; //alert(Object.toJSON(child));
													if(child.Type != Nrcap2.Enum.PuResourceType.VideoIn)
													{
														continue;
													}
													var PUID = child.PUID;
													var ivIdx = child.Idx; 
													var Enable = child.Enable;
												
													var online = "0", enable = "0", flag = false;
													var res = WebClient.Resource.resource.get(PUID);
													
													if(typeof res == "object")
													{
														if(!res.childResource)
														{
															var puResourcesInfos = Nrcap2.FetchResource(WebClient.connectId,Nrcap2.Enum.FetchResourceLevel.Nrcap2_GetPUResourceInfo,0,4294967295,"",{"PUID":PUID}); 
															//alert(puResourcesInfos.toJSON());  
															if(puResourcesInfos.length > 0)
															{
																res.childResource = puResourcesInfos; //保存pu子资源 
															}
															
														} 
														flag = true;
														online = res.online;
														enable = res.enable;   
													}
													
													var prefix = "inputvideo", suffix = "_disabled";
													if(flag)
													{
														if(online == "1" && enable == "1" && Enable == "1")
														{
															suffix = "";
														}
													} 
													else
													{
														if(Enable == "1")
														{
															suffix = "";
														}	
													}
													var icoclass = prefix + suffix;
													
													var suffixThird = suffixSecond + "_" + PUID + "_" + ivIdx;
													
													htmlstr += "<div style=\"white-space:nowrap; border:0px dotted red; margin-top:0px !important; margin-top:0px;\">";
													htmlstr += "<input type=\"button\" id=\""+suffixThird+"_img_title\" class=\"outline\" onfocus=\"this.blur();\" onclick=\"\" /><input type=\"button\" id=\""+suffixThird+"_img_ico\" class=\""+icoclass+"\" onfocus=\"this.blur();\" onclick=\"\" /><a href=\"#self\" onfocus=\"this.blur();\" onclick=\"WebClient.Video.PlayVideo('"+PUID+"','"+ivIdx+"');\" >"+child.Name+"</a>";
													htmlstr += "</div>";
													htmlstr += "<div id=\""+suffixThird+"_childresourcebox\" class=\"childresourcebox_directline\" style=\"display:none;padding-left:16px;\">";
													htmlstr += "</div>";
													
													lastnode = suffixThird;
													
												} //end for j	
												
												if(htmlstr != "")
												{
													htmlstr = htmlstr.replace(new RegExp("id=\""+lastnode+"_img_title\" class=\"outline\"","gm"),"id=\""+lastnode+"_img_title\" class=\"endline\"");
												} 
												
												if($(suffixSecond + "_childresourcebox"))
												{
													$(suffixSecond + "_childresourcebox").innerHTML = htmlstr;
												} 
												
												
									
											} // end lgr
											
										} 
										
									} 
									
									//alert(WebClient.Resource.logicGroup.toJSON());
									WebClient.Resource.Expandsion($(suffixSecond+"_childresourcebox"),$(suffixSecond+"_img_title")); 
									//alert(WebClient.Resource.resource.toJSON());
									
								}
								
							}
							
						} // end node.childResource
					} // end node.Index
					
				}
			); 
			
		},
		
		//原先的资源树，一次加载，但后面又改为异步请求加载
		CreateLogicTree:function(logicGroup){
			if(!logicGroup && typeof logicGroup != "object")
			{
				return false;
			}
			
			var htmlstr = "", lastLogicNode = ""; 
			
			var display = (logicGroup.keys().length <= 1 ? "block" : "none"); 
			
			logicGroup.each(
				function(item){
					var node = item.value; //alert(Object.toJSON(node));
					
					var suffixFirst = node.Index + "_" + node.Name; 
					
					htmlstr += "<div id=\"logic_root_"+suffixFirst+"\" style=\"white-space:nowrap; \">"; 
		                htmlstr += "<input type=\"button\" id=\"logic_root_"+suffixFirst+"_img_title\" class=\""+(display == "block"?"minus":"plus")+"\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.Expandsion($('logic_root_"+suffixFirst+"_childresourcebox'),$('logic_root_"+suffixFirst+"_img_title'),$('logic_root_"+suffixFirst+"_img_ico'));\" /><input type=\"button\" id=\"logic_root_"+suffixFirst+"_img_ico\" class=\""+(display == "block" ? "stationmodel_expand" : "stationmodel_collapse")+"\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.Expandsion($('logic_root_"+suffixFirst+"_childresourcebox'),$('logic_root_"+suffixFirst+"_img_title'),$('logic_root_"+suffixFirst+"_img_ico'));\" /><a href=\"#self\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.Expandsion($('logic_root_"+suffixFirst+"_childresourcebox'),$('logic_root_"+suffixFirst+"_img_title'),$('logic_root_"+suffixFirst+"_img_ico'));\" >"+node.Name+"</a>";  
		                
		            htmlstr += "</div>";  
		            htmlstr += "<div id=\"logic_root_"+suffixFirst+"_childresourcebox\" class=\"childresourcebox_directline\" style=\"display:"+display+";padding-left:15px;border:0px solid red;\">"; 
					
					//子结点 
					if(node.childResource.constructor == Array && typeof node.childResource == "object")
					{
						var html = "", lastnode = "";
						
						var childResource = node.childResource;
						for(var i = 0; i < childResource.length; i++)
						{
							var childRes = childResource[i];
							
							var suffixSecond = suffixFirst + "_" + childRes.Index + "_" + childRes.Name;
							
							html += "<div style=\"white-space:nowrap; border:0px dotted red; margin-top:0px !important; margin-top:0px; \">";
								html += "<input type=\"button\" id=\""+suffixSecond+"_img_title\" class=\"plus\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.Expandsion($('"+suffixSecond+"_childresourcebox'),$('"+suffixSecond+"_img_title'));\" /><input type=\"button\" id=\""+suffixSecond+"_img_ico\" class=\"logic\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.Expandsion($('"+suffixSecond+"_childresourcebox'),$('"+suffixSecond+"_img_title'));\" /><a href=\"#self\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.Expandsion($('"+suffixSecond+"_childresourcebox'),$('"+suffixSecond+"_img_title'));\" >"+childRes.Name+"</a>";
							html += "</div>";
							
							html += "<div id=\""+suffixSecond+"_childresourcebox\" class=\"childresourcebox_directline\" style=\"display:none;padding-left:16px;\">"; 
							
							if(childRes.childResource.constructor == Array && typeof childRes.childResource == "object")
							{
								var h = "", last = "";
								var childs = childRes.childResource; 
								for(var j = 0; j < childs.length; j++)
								{
									var child = childs[j]; //alert(Object.toJSON(child));
									
									if(child.Type != Nrcap2.Enum.PuResourceType.VideoIn)
									{
										continue;
									}
									
									var PUID = child.PUID;
									var ivIdx = child.Idx; 
									var Enable = child.Enable;
								
									var online = "0", enable = "0", flag = false;
									var res = WebClient.Resource.resource.get(PUID);
									if(typeof res == "object")
									{
										flag = true;
										online = res.online;
										enable = res.enable;
									} 
									var prefix = "inputvideo", suffix = "_disabled";
									if(flag)
									{
										if(online == "1" && enable == "1" && Enable == "1")
										{
											suffix = "";
										}
									} 
									else
									{
										if(Enable == "1")
										{
											suffix = "";
										}	
									}
									var icoclass = prefix + suffix;
									
									suffixThird = suffixSecond + "_" + PUID + "_" + ivIdx;
									
									h += "<div style=\"white-space:nowrap; border:0px dotted red; margin-top:0px !important; margin-top:0px;\">";
										h += "<input type=\"button\" id=\""+suffixThird+"_img_title\" class=\"outline\" onfocus=\"this.blur();\" onclick=\"\" /><input type=\"button\" id=\""+suffixThird+"_img_ico\" class=\""+icoclass+"\" onfocus=\"this.blur();\" onclick=\"\" /><a href=\"#self\" onfocus=\"this.blur();\" onclick=\"WebClient.Video.PlayVideo('"+PUID+"','"+ivIdx+"');\" >"+child.Name+"</a>";
									h += "</div>";
									h += "<div id=\""+suffixThird+"_childresourcebox\" class=\"childresourcebox_directline\" style=\"display:none;padding-left:16px;\">";
									h += "</div>";
									
									last = suffixThird;
								} 
								
								if(h != "")
								{
									h = h.replace(new RegExp("id=\""+last+"_img_title\" class=\"outline\"","gm"),"id=\""+last+"_img_title\" class=\"endline\"");
								}
								
								html += h;
							}
							
							html += "</div>";
							
							lastnode = suffixSecond;
						}
						
						if(html != "")
						{
							html = html.replace(new RegExp("id=\""+lastnode+"_childresourcebox\" class=\"childresourcebox_directline\"","gm"),"id=\""+lastnode+"_childresourcebox\" class=\"childresourcebox_blankline\"");
						}
						
						htmlstr += html;
					}/**/
						
					htmlstr += "</div>"; 
					 
					lastLogicNode = suffixFirst; 
				}								
				
			);
			
			if(htmlstr != "")
			{
				htmlstr = htmlstr.replace(new RegExp("id=\"logic_root_"+lastLogicNode+"_childresourcebox\" class=\"childresourcebox_directline\"","gm"),"id=\"logic_root_"+lastLogicNode+"_childresourcebox\" class=\"childresourcebox_blankline\""); 
			}
			else
			{
				htmlstr += "<span style=\"font-style:Italic;\">(获得逻辑分组资源为空)</span>";
			}
			//alert(htmlstr);
			return htmlstr;
		},
		
		FetchChildResource:function(puid,style){
			if(typeof style == "undefined" || !style)
		    {
		        return;
		    }
			// alert(puid + ":" + style); 
			var puResourcesInfos = new Array();
			switch(style)
			{
				case "logic": 
					break;
				case "video":
				case "query":
					if(typeof puid != "undefined" && $(style+"_"+puid+"_childresourcebox") && $(style+"_"+puid+"_img_title"))
					{  
						var resource = WebClient.Resource.resource;
						if(resource.get(puid))
						{
							if(resource.get(puid).childResource != null && $(style+"_"+puid+"_childresourcebox").innerHTML != "")
							{
								
							}
							else/**/
							{
								puResourcesInfos = Nrcap2.FetchResource(WebClient.connectId,Nrcap2.Enum.FetchResourceLevel.Nrcap2_GetPUResourceInfo,0,4294967295,"",{PUID:puid}); 
								//alert(puResourcesInfos.toJSON()); //return;
								if(puResourcesInfos.length > 0)
								{
									resource.get(puid).childResource = puResourcesInfos; //保存pu子资源 
									var htmlstr = "";
									var queryStyle = "complex"; //complex..simple
									var lastidx = 0;
									for(var j = 0, idx = 0; j < resource.get(puid).childResource.length;j++)
									{
										var online = resource.get(puid).online;
										var enable = resource.get(puid).enable;
										
										var childResource = resource.get(puid).childResource[j];
										
										if(childResource.type != Nrcap2.Enum.PuResourceType.VideoIn/* || childResource.idx != 0*/)
										{
											continue;
										} 
										
										var queryStyle = WebClient.Resource.QueryResource.queryStyle; //query style
										 
										queryFlag = (queryStyle != "complex" && style == "query" ? true : false); //alert(queryFlag);
										var prefix = "inputvideo", suffix = "_disabled";
										if(online == "1" && enable == "1" && childResource.enable == "1")
										{
											suffix = "";
										}
										var icoclass = prefix + "" + suffix;
										
										var type = childResource.type, idx = childResource.idx;  
										
										lastidx = type + "_" + idx; 
										
										htmlstr += "<div style=\"white-space:nowrap; border:0px dotted red;\">";
											htmlstr += "<input type=\"button\" id=\""+style+"_"+puid+"_"+lastidx+"_img_title\" class=\""+( queryFlag ? "plus" : "outline")+"\" onfocus=\"this.blur();\" onclick=\""+(style != "query" ? "" : "WebClient.Resource.FetchDateResource('"+puid+"','"+idx+"');" )+"\" /><input type=\"button\" id=\""+style+"_"+puid+"_"+lastidx+"_img_ico\" class=\""+icoclass+"\" onfocus=\"this.blur();\" onclick=\""+(style != "query" ? "" : "WebClient.Resource.FetchDateResource('"+puid+"','"+idx+"')" )+"\" /><a id=\""+style+"_"+puid+"_"+lastidx+"\" href=\"#self\" onfocus=\"this.blur();\" onclick=\""+(style != "query" ? "WebClient.Video.PlayVideo('"+puid+"','"+idx+"');" :  "WebClient.Resource.FetchDateResource('"+puid+"','"+idx+"');" )+"\" >"+childResource.name+"</a>";
										htmlstr += "</div>";
										htmlstr += "<div id=\""+style+"_"+puid+"_"+lastidx+"_childresourcebox\" style=\"display:none;padding-left:16px;\">"; 
		            					htmlstr += "</div>";
										   
									} 
									
									if(!queryFlag)
									{
										htmlstr = htmlstr.replace(new RegExp("id=\""+style+"_"+puid+"_"+lastidx+"_img_title\" class=\"outline\"","gm"),"id=\""+style+"_"+puid+"_"+lastidx+"_img_title\" class=\"endline\"");
									}
									
									$(style+"_"+puid+"_childresourcebox").innerHTML = htmlstr;
								}   
							}	
						}	
					 
						WebClient.Resource.Expandsion($(style+"_"+puid+"_childresourcebox"),$(style+"_"+puid+"_img_title"));
					}		
					
					break;
					
				case "device": // 设备管理 
					if(typeof puid != "undefined" && $(style+"_"+puid+"_childresourcebox") && $(style+"_"+puid+"_img_title"))
					{  
						var resource = WebClient.Resource.resource;
						if(resource.get(puid))
						{
							if(resource.get(puid).childResource != null && $(style+"_"+puid+"_childresourcebox").innerHTML != "")
							{
								
							}
							else/**/
							{
								puResourcesInfos = Nrcap2.FetchResource(WebClient.connectId,Nrcap2.Enum.FetchResourceLevel.Nrcap2_GetPUResourceInfo,0,4294967295,"",{PUID:puid}); 
								//alert(puResourcesInfos.toJSON()); //return;
								if(puResourcesInfos.length > 0)
								{
									resource.get(puid).childResource = puResourcesInfos; //保存pu子资源 
									var htmlstr = "";
									var queryStyle = "complex"; //complex..simple
									var lastidx = 0;
									for(var j = 0, idx = 0; j < resource.get(puid).childResource.length;j++)
									{
										var online = resource.get(puid).online;
										var enable = resource.get(puid).enable;
										
										var childResource = resource.get(puid).childResource[j];
										
										var type = childResource.type;
										var idx = childResource.idx;
										 
										var prefix = "", suffix = "_disabled";
										
										switch(type)
										{
											case Nrcap2.Enum.PuResourceType.GPS: prefix = "gps"; break;
											case Nrcap2.Enum.PuResourceType.WIFI: prefix = "wifi"; break;
											case Nrcap2.Enum.PuResourceType.AudioIn: prefix = "inputaudio"; break;
											case Nrcap2.Enum.PuResourceType.AlertIn: prefix = "inputdigitalline"; break;
											case Nrcap2.Enum.PuResourceType.AudioOut: prefix = "outputaudio"; break;
											case Nrcap2.Enum.PuResourceType.AlertOut: prefix = "outputdigitalline"; break;
											case Nrcap2.Enum.PuResourceType.VideoIn: prefix = "inputvideo"; break;
											case Nrcap2.Enum.PuResourceType.VideoOut: prefix = "outputvideo"; break;
											case Nrcap2.Enum.PuResourceType.PTZ: prefix = "ptz"; break;
											case Nrcap2.Enum.PuResourceType.SELF: prefix = "station"; continue; break;
											case Nrcap2.Enum.PuResourceType.Storager: prefix = "storager"; break;
											case Nrcap2.Enum.PuResourceType.SC: prefix = "storager"; break;
											case Nrcap2.Enum.PuResourceType.SerialPort: prefix = "serialport"; break;
											case Nrcap2.Enum.PuResourceType.Wireless: prefix = "logic"; break;
											default: continue; break;
										}
										
										if(online == "1" && enable == "1" && childResource.enable == "1")
										{
											suffix = "";
										}
										var icoclass = prefix + "" + suffix; 
										
										lastidx = type + "_" + idx; // 索引<=3
									 
										htmlstr += "<div style=\"white-space:nowrap; border:0px dotted red;\">";
											htmlstr += "<input type=\"button\" id=\""+style+"_"+puid+"_"+lastidx+"_img_title\" class=\"outline\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.DeviceResource.MainRegionInit('"+puid+"','"+type+"','"+idx+"');\" /><input type=\"button\" id=\""+style+"_"+puid+"_"+lastidx+"_img_ico\" class=\""+icoclass+"\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.DeviceResource.MainRegionInit('"+puid+"','"+type+"','"+idx+"');\" /><a id=\""+style+"_"+puid+"_"+lastidx+"\" href=\"#self\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.DeviceResource.MainRegionInit('"+puid+"','"+type+"','"+idx+"');\" >"+childResource.name+"</a>"; 
										htmlstr += "</div>";
										htmlstr += "<div id=\""+style+"_"+puid+"_"+lastidx+"_childresourcebox\" style=\"display:none;padding-left:16px;\">"; 
		            					htmlstr += "</div>";
										  
									} 
									 
									htmlstr = htmlstr.replace(new RegExp("id=\""+style+"_"+puid+"_"+lastidx+"_img_title\" class=\"outline\"","gm"),"id=\""+style+"_"+puid+"_"+lastidx+"_img_title\" class=\"endline\"");
									 
									 
									$(style+"_"+puid+"_childresourcebox").innerHTML = htmlstr;
								}   
							}	
						}	
						
						WebClient.Resource.Expandsion($(style+"_"+puid+"_childresourcebox"),$(style+"_"+puid+"_img_title"));
					}		
					break;
					
				default:
					break;
			}
		},

		//dates
		FetchDateResource:function(puid,ivIndex){  
			var dateLists = new Array(); 
			dateLists = WebClient.Resource.FetchQueryResource(puid,ivIndex); 
			
			var containerIndexs = WebClient.Query.detailContainerIndexs; //{"detailDates":1, "detailDays":2, "detailFiles":3 }
			
			var htmlstr = "",container = "detailDates"; //html element container
			var queryStyle = WebClient.Resource.QueryResource.queryStyle; //'complex'..'simple'
			switch(queryStyle)
			{
				case "complex": 
					var containers = WebClient.Query.detailContainerKeys;  //["detailDates","detailDays","detailFiles"] 
					for(var i = 0; i < containers.length; i++)
					{
						if($(containers[i]))
						{
							$(containers[i]).innerHTML = "";
						}
					}
				
					var resource = WebClient.Resource.resource;  //alert(Object.toJSON(resource));
					var titleNote = "", ivName = "";
					if(resource && resource.get(puid) && resource.get(puid).childResource)
					{
						var childResource = resource.get(puid).childResource;
						/*for(var j = 0; j < childResource.length; j++)
						{
							var childRes = childResource[j];
							if(childRes.idx == ivIndex && childRes.type == Nrcap2.Enum.PuResourceType.VideoIn)
							{
								ivName = childRes.name;
							}
						}*/
						
						childResource.each(
							function(childRes,j){ 
								if(childRes.idx == ivIndex && childRes.type == Nrcap2.Enum.PuResourceType.VideoIn)
								{
									ivName = childRes.name;  
								} 
							}										   
						);
						
						titleNote = ivName;
						
						WebClient.Query.detailTitleNote = {"ivName":"","ivDate":"","ivDay":""};
						WebClient.Query.detailTitleNote["ivName"] = titleNote; //导航头信息 
					} //end if
				
					var date = "";
					//dateLists = ["1298563200","1298560000","1298908800","1213113200","1221220000","1232328800","1241220000","1252328800","1261220000","1272328800","1282328800","1121220000","1132328800","1141220000","1152328800","1161220000","1172328800","1182328800","1021220000","1032328800","1041220000","1052328800","1061220000","1072328800","1082328800","1221220000","1222328800","1221220000","1222328800","1221220000","1222328800","1222328800"]; //for test , soon remove  
					dateLists = dateLists.uniq();  // turn to unique
					 
					if(dateLists.length > 0)
					{
						for(var i = 0;i < dateLists.length;i++)
						{
							var datelist = dateLists[i];
							datelist = new Date(parseInt(datelist) * 1000).format("yyyy年MM月"); //只取‘年月’ 
							// alert(datelist);
							if(date != datelist)
							{   
								date = datelist; //alert(date);
								htmlstr += "<div id=\"query_"+puid+"_"+ivIndex+"_"+date+"\" class=\"queryDateContainer\" webclienttype=\"result\" >";
									htmlstr += "<div id=\"query_"+puid+"_"+ivIndex+"_"+date+"_calendar\" class=\"queryDateCalendar\">";
										htmlstr += "<div class=\"calender\"></div>";
									htmlstr += "</div>";
									htmlstr += "<div id=\"query_"+puid+"_"+ivIndex+"_"+date+"_title\" class=\"queryDateTitle\">";
										htmlstr += "<a href=\"#self\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.FetchDayResource('"+puid+"','"+ivIndex+"','"+date+"');\" title=\""+date+"\">" + date + "</a>";
									htmlstr += "</div>";
								htmlstr += "</div>";
							} //end inner if 
						} //end for
					}//end outer if
					else
					{
						htmlstr += "<div style=\"margin:3px 0px 0px 5px;\">[无数据]</div>";
					}
					
				 
					container = containers[0];  //"detailDates"
					break;
				case "simple": 
					htmlstr += "";
					htmlstr += "";
					
					container = "query_" + puid + "_" + ivIndex + "_childresourcebox";
					break;
				default:
					return;
					break;
			}
			
			// alert(htmlstr);
			$(container)
			{
				$(container).innerHTML = htmlstr;
				WebClient.Resource.DetailResultDisplay(containerIndexs[container]); // 显示‘detailDates’ 
				WebClient.Resource.AttachQueryEvent(container,"queryDate"); // detailDates	
			}
		}, 
		
		AttachQueryEvent:function(objId,type){ 
			if(!objId || !type)
			{
				return;
			}
			
			var divs = $(objId).getElementsByTagName("DIV");
			for(var i = 0; i < divs.length;i++)
			{
				var div = divs[i];
				if(div.webclienttype == "result")
				{
					div.title = "双击查询";
					
					div.onmouseover = function(){
						this.style.border = "1px #808080 solid";
						this.style.backgroundColor = "#EAF3FC";
					}
					div.onmouseout = function(){
						this.style.border = "1px #FFFFFF solid";
						this.style.backgroundColor = "";
					}
					div.ondblclick = function(){
						
						//alert(this.id);		
						var params = this.id.split("_");  
						var puid = params[1];
						var ivIndex = params[2];
						var date = params[3]; //alert(puid+"#"+ivIndex+"#"+date); 
						
						switch(type)
						{
							case "queryDate": 
								//获取日期下的天数资源
								WebClient.Resource.FetchDayResource(puid,ivIndex,date); //detailDays
								break;
							case "queryDay":  
								var utctime = this.utctime; //alert(utctime);
								//获取日期下的详细资源
								WebClient.Resource.FetchQueryFilesResource(puid,ivIndex,utctime); //detailFiles
								break;
							default:				
								break;
						}
					} //end double click
					
				} //end if
				
			} //end for
			 	
		}, 
		 
		//days
		FetchDayResource:function(puid,ivIndex,date){
			var dateLists = new Array(); 
			dateLists = WebClient.Resource.FetchQueryResource(puid,ivIndex);
			
			var containers = WebClient.Query.detailContainerKeys;  //["detailDates","detailDays","detailFiles"] 
			var containerIndexs = WebClient.Query.detailContainerIndexs; //{"detailDates":1, "detailDays":2, "detailFiles":3 }
			
			var htmlstr = "",container = "detailDays"; //html element container
			var queryStyle = WebClient.Resource.QueryResource.queryStyle; //'complex'..'simple'
			switch(queryStyle)
			{
				case "complex":  
					WebClient.Query.detailTitleNote["ivDate"] = date; //导航头信息 
					
					var day = "";
				 	//dateLists = ["1298563200","1298040000","1298908800","1298340000","1298440000","1298108800","1298740000","1299208800","1299608800","1299708800","1282328800","1121220000","1132328800","1141220000","1152328800","1161220000","1172328800","1182328800","1021220000","1032328800","1041220000","1052328800","1061220000","1072328800","1082328800","1221220000","1222328800","1221220000","1222328800","1221220000","1222328800","1222328800" ]; //for test , soon remove   
					dateLists = dateLists.uniq();  // turn to unique
					
					for(var i = 0 ;i < dateLists.length;i++)
					{  	 	
						var datelist = dateLists[i];
						var eachdate = new Date(parseInt(datelist) * 1000).format("yyyy年MM月"); //只取‘年月’ 
						if(date != eachdate)
						{
							continue; //如果年月上不匹配，则跳过此日期继续匹配 

						}
						else
						{ 
							var eachday = new Date(parseInt(datelist) * 1000).format("dd日"); //只取date下的‘日’ 

						    //alert(eachday);
							if(day != eachday)
							{
								day = eachday; // change current day flag 
								
								htmlstr += "<div id=\"query_"+puid+"_"+ivIndex+"_"+date+"_"+day+"\" utctime=\""+datelist+"\" class=\"queryDateContainer\" webclienttype=\"result\" >";
									htmlstr += "<div id=\"query_"+puid+"_"+ivIndex+"_"+date+"_"+day+"_calendar\" class=\"queryDateCalendar\">";
										htmlstr += "<div class=\"calender\"></div>";
									htmlstr += "</div>";
									htmlstr += "<div id=\"query_"+puid+"_"+ivIndex+"_"+date+"_"+day+"_title\" class=\"queryDateTitle\">";
									htmlstr += "<a  id=\"query_"+puid+"_"+ivIndex+"_"+date+"_"+day+"_superlink\"  href=\"#self\" onfocus=\"this.blur();\" onclick=\"WebClient.Resource.FetchQueryFilesResource('"+puid+"','"+ivIndex+"','"+datelist+"');\" title=\""+day+"\">" + day + "</a>";
									htmlstr += "</div>";
								htmlstr += "</div>"; 
								
							} 
							
						}   
					} //end for 
					
					if(htmlstr == "")
					{
						htmlstr += "<div style=\"margin:3px 0px 0px 5px;\">[无数据]</div>"; 
					}
						
					container = containers[1]; //"detailDays"
					break; 
				default:
					return;
					break;
			}
			//alert(htmlstr);
			$(container)
			{
				$(container).innerHTML = htmlstr; 
				WebClient.Resource.DetailResultDisplay(containerIndexs[container]); // 显示‘detailDays’  
				WebClient.Resource.AttachQueryEvent(container,"queryDay"); // detailDays	
				
			}
		},
		
		//控制detail**的显示或隐藏
		//containerIndex [1..2..3]
		DetailResultDisplay:function(containerIndex){ 
			var containers = WebClient.Query.detailContainerKeys;  //["detailDates","detailDays","detailFiles"] 	
		 
			containerIndex = parseInt(containerIndex); 
			if(containerIndex > containers.length || containerIndex < 0 || /^-?\d+$/.test(containerIndex) != true)
			{
				return "error index";
			} 
			 
			for(var index = 0; index < containers.length; index++)
			{
				if($(containers[index]))
				{
					if(index == containerIndex -1)
					{
						$(containers[index]).style.display = "block"; 
					}
					else
					{
						$(containers[index]).style.display = "none"; 
					}
				}
				
			}
			 
			var titleNote = ""; // 导航头信息 
			
			if(containerIndex == 1)
			{  
				WebClient.Query.DetailTitleButtons.each(
					function(item){
						var node = item.value;
						node.active = false;
						if(node.index == 2)
						{
							if($(containers[1]) && $(containers[1]).innerHTML != "")
							{
								node.active = true;
								node.turnTo = containers[1];
							} 
						}
						
					}
				);    
				
				titleNote = WebClient.Query.detailTitleNote["ivName"] + ":/";  

			}
			else if(containerIndex == 2)
			{ 
				WebClient.Query.DetailTitleButtons.each(
					function(item){
						var node = item.value;
						node.active = false; 
						
						if(node.index == 1)
						{
							if($(containers[0]) && $(containers[0]).innerHTML != "")
							{
								node.active = true;
								node.turnTo = containers[0];
							}
						} 
						else if(node.index == 2)
						{
							if($(containers[2]) && $(containers[2]).innerHTML != "")
							{
								node.active = true;  
								node.turnTo = containers[2];
							} 
						}
						
					}
				); 
				
				titleNote = WebClient.Query.detailTitleNote["ivName"]  + ":/" + WebClient.Query.detailTitleNote["ivDate"] + "/"; 
			}
			else if(containerIndex == 3)
			{   
				WebClient.Query.DetailTitleButtons.each(
					function(item){
						var node = item.value;
						node.active = false; 
						
						if(node.index == 1)
						{
							if($(containers[1]) && $(containers[1]).innerHTML != "")
							{
								node.active = true;
								node.turnTo = containers[1];
							} 
						}  
						
					}
				); 
				
				titleNote = WebClient.Query.detailTitleNote["ivName"] + ":/" + WebClient.Query.detailTitleNote["ivDate"]  + "/" + WebClient.Query.detailTitleNote["ivDay"] + "/"; 
			}
			
			//alert(Object.toJSON(WebClient.Query.DetailTitleButtons));
			
			if($("detailTitleInfo")) $("detailTitleInfo").value = titleNote; //导航头信
			
			WebClient.Query.DisabledDetailTitleButtons(); //设置效果
			
			return true;
			
			//WebClient.Query.DetailTitleButtons.set(btn.id,{object:btn,index:j++,active:false,turnTo:"",description:null}); 
		},
		
		/*
		*	函数名		：FetchQueryResource
		*	函数功能   	：获取存储资源(dates) 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.02.28	
		*/
		FetchQueryResource:function(puid,ivIndex){ 
			var csuPuid = WebClient.Resource.csuPuid;  //alert(csuPuid);
			if(!csuPuid) return;  
			
			var curQMenuId = WebClient.NavMenu.currentQueryMenuId; //'mm_query_vod'..'mm_query_image'
			var type = "vod";
			if(curQMenuId.search(type) == -1)
			{
				type = "image";
			} 
			
			var curQCardId = WebClient.Resource.QueryResource.currentQueryCardId; //'queryPlatform'..'queryCEFS'
			
			var dateLists = new Array(); 
			switch(curQCardId)
			{
				case "queryPlatform": 
					dateLists  = Nrcap2.FetchIVDate(WebClient.connectId,csuPuid,puid,ivIndex,type);//平台下日期资源 
					
					break;
				case "queryCEFS": 
				
					break;
				default: 
					break;
			} 
			// alert(Object.toJSON(dateLists)); 
			return dateLists;
		},
		
		/*
		*	函数名		：FetchQueryFilesResource
		*	函数功能   	：获取存储资源(files) 
		*	备注			：得到存储资源文件的详细信息
		*	作者			：huzw
		*	时间			：2011.03.02	
		*/
		FetchQueryFilesResource:function(puid,ivIndex,date){  
			var csuPuid = WebClient.Resource.csuPuid;  //alert(csuPuid);
			if(!csuPuid) return;
			
			var curQMenuId = WebClient.NavMenu.currentQueryMenuId; //'mm_query_vod'..'mm_query_image'
			var type = "vod";
			if(curQMenuId.search(type) == -1)
			{
				type = "image";
			} 
			
			var curQCardId = WebClient.Resource.QueryResource.currentQueryCardId; //'queryPlatform'..'queryCEFS'
			
			var detailFiles = new Array(); 
			switch(curQCardId)
			{
				case "queryPlatform":  
					detailFiles  = Nrcap2.FetchIVDateFiles(WebClient.connectId,csuPuid,puid,ivIndex,type,date,0); //平台日期下详细资源 
					
					break;
				case "queryCEFS": 
				
					break;
				default: 
					break;
			} 
			//alert(Object.toJSON(detailFiles)); 
			if(typeof detailFiles != "object" || detailFiles.constructor != Array)
			{
				return false;
			}
			
			var containers = WebClient.Query.detailContainerKeys;  //["detailDates","detailDays","detailFiles"] 
			var containerIndexs = WebClient.Query.detailContainerIndexs; //{"detailDates":1, "detailDays":2, "detailFiles":3 }
			
			var container = "";
			
			var queryStyle = WebClient.Resource.QueryResource.queryStyle; //'complex'..'simple'
			switch(queryStyle)
			{
				case "complex":
					container = containers[2];
					WebClient.Query.detailTitleNote["ivDay"] = new Date(parseInt(date) * 1000).format("dd日");
					WebClient.Resource.DetailResultDisplay(containerIndexs[container]); //显示‘DetailFiles’ 
					WebClient.Resource.QueryFilesResultList(puid,ivIndex,type,detailFiles); //对详细信息进行列表 
					break;
				case "simple": 
					/*for(var i = 0; i < containers.length; i++)
					{
						conrainer = containers[i];		
						$(container)
						{
							if(i != 2)
							{
								$(container).style.display = "none"; 
							}
							else
							{
								$(container).style.display = "block"; //使detailFiles可见
							} 
						}
					}
					
					if($("detailTitle") && $("DetailPad") && $("DownloadPad"))
					{
						$("detailTitle").style.display = "none";
						//减小结果内容区高度 
						$("DetailPad").style.height -= $("detailTitle").offsetHeight;
						//增加下载信息区高度 
						$("DownloadPad").style.height += $("detailTitle").offsetHeight;
					}*/
					
					break;
				default:
					break;
			
			} 
			
			return detailFiles;
		},
		
		/*
		*	函数名		：QueryFilesResultList
		*	函数功能   	：详细列表 
		*	备注			：对查询到存储资源文件列表 
		*	作者			：huzw
		*	时间			：2011.03.03
		*/
		QueryFilesResultList:function(puid,ivIndex,type,detailFiles){
			//alert(Object.toJSON(detailFiles)); 
			if(typeof detailFiles != "object" || detailFiles.constructor != Array)
			{
				return false;
			}
			if(typeof type == "undefined" || (type != "vod" && type != "image"))
			{
				return false;
			}
			
			var htmlstr = "";
			switch(type)
			{
				case "vod":
				    //alert(Object.toJSON(detailFiles)); return;
					if(detailFiles.length <= 0)
					{
						htmlstr += "<div id=\"query_"+type+"_"+puid+"_"+ivIndex+"_title\" class=\"divth\" >";
							htmlstr += "<div class=\"divthtd\" style=\"width:40px;\">索引</div>"; 
							htmlstr += "<div class=\"divthtd\" style=\"width:110px;\">文件名称</div>"; 
							htmlstr += "<div class=\"divthtd\" style=\"width:60px;\">大小</div>"; 
							htmlstr += "<div class=\"divthtd\" style=\"width:80px;\">操作</div>"; 
							htmlstr += "<div class=\"divthtd\" style=\"width:100px;\">起始时间</div>"; 
							htmlstr += "<div class=\"divthtd\" style=\"width:100px;\">结束时间</div>"; 
							htmlstr += "<div class=\"divthtd\" style=\"width:60px;\">录像原因</div>"; 
							htmlstr += "<div class=\"divthtd\" style=\"width:60px;\">摄像点</div>"; 
							htmlstr += "<div class=\"divthtd\" style=\"width:60px;\">存储位置</div>"; 
							htmlstr += "<div class=\"divthtd\" style=\"width:110px;\">存储路径</div>"; 
						htmlstr += "</div>";
						htmlstr += "<div style=\"margin:3px 0px 0px 5px;\">[没有文件数据]</div>"; 
					}
					else
					{
						var resource = WebClient.Resource.resource;  //alert(Object.toJSON(resource));
						var ivName = "";
						if(resource && resource.get(puid) && resource.get(puid).childResource)
						{
							var childResource = resource.get(puid).childResource;
							for(var j = 0; j < childResource.length; j++)
							{
								var childRes = childResource[j];
								if(childRes.idx == ivIndex && childRes.type == Nrcap2.Enum.PuResourceType.VideoIn)
								{
									ivName = childRes.name;
								}
							}
						}
						
						var fileLocation = "平台存储";
						var curQCardId = WebClient.Resource.QueryResource.currentQueryCardId;
						if(curQCardId != "queryPlatform")
						{
							fileLocation = "前端存储";
						}
						
						//header
						htmlstr += "<div id=\"query_"+type+"_"+puid+"_"+ivIndex+"_title\" class=\"divth\" style=\"width:930px;\">";
							htmlstr += "<div class=\"divthtd\" style=\"width:50px;\">索引</div>"; 
							htmlstr += "<div class=\"divthtd\" style=\"width:130px;\">文件名称</div>"; 
							htmlstr += "<div class=\"divthtd\" style=\"width:60px;\">大小</div>"; 
							htmlstr += "<div class=\"divthtd\" style=\"width:100px;\">操作</div>"; 
							htmlstr += "<div class=\"divthtd\" style=\"width:120px;\">起始时间</div>"; 
							htmlstr += "<div class=\"divthtd\" style=\"width:120px;\">结束时间</div>"; 
							htmlstr += "<div class=\"divthtd\" style=\"width:60px;\">录像原因</div>"; 
							htmlstr += "<div class=\"divthtd\" style=\"width:60px;\">摄像点</div>"; 
							htmlstr += "<div class=\"divthtd\" style=\"width:60px;\">存储位置</div>"; 
							htmlstr += "<div class=\"divthtd\" style=\"width:130px;\">存储路径</div>"; 
						htmlstr += "</div>";  
						
						//body
						var classname = "divtr";
						for(var i = 0, index = 1; i < detailFiles.length; i++, index++)
						{
							var file = detailFiles[i]; 
							
							var fileSize = file.fileSize;
							if(fileSize < 1024)
							{
								fileSize = fileSize.toFixed(2) + "B";
							}
							else if(fileSize < 1024 * 1024)
							{
								fileSize = (fileSize/1024).toFixed(2) + "KB";
							}
							else
							{
								fileSize = (file.fileSize/(1024 * 1024)).toFixed(2) + "MB";
							}	
							
							/*if(i == 0)
							{
								// for test  
								var _timestr = 	file.beginTime;
								var _timetodate = new Date(parseInt(file.beginTime) * 1000).format("yyyy-MM-dd HH:mm:ss");
								var _testdate = "2011-04-20 15:18:33"; 
								var _datetotimestr = new Date(Date.parse(_testdate.replace(/-/g,"/"))).getTime()/1000;
								
								alert("ts:" + _timestr + ",td:" + _timetodate + ",tsd:" + _testdate + ",dt:" + _datetotimestr);
								
							}*/
							
							
							var beginTime = new Date(parseInt(file.beginTime) * 1000).format("yyyy-MM-dd HH:mm:ss");
						 	var endTime = new Date(parseInt(file.endTime) * 1000).format("yyyy-MM-dd HH:mm:ss");
							
							var vodTimeLength = parseInt(file.endTime) - parseInt(file.beginTime);
							var fileAllPath = file.filePath + "/" + file.fileName;
							
						    classname = (i % 2 == 0 ? "divtr" : "divtrother");
						  
							htmlstr += "<div id=\"query_"+type+"_"+puid+"_"+ivIndex+"_line_"+index+"\" class=\""+classname+"\"  style=\"width:930px;\" webclienttype=\"list\" ondblclick=\"WebClient.Query.PlayVod('"+file.fileName+"','"+file.filePath+"','"+file.csuPuid+"','"+vodTimeLength+"');\" >";
								htmlstr += "<div class=\"divtrtd\" style=\"width:50px;\" title=\""+index+"\"><span class=\"vodlogo\"></span><span>"+index+"</span></div>"; 
								htmlstr += "<div class=\"divtrtd\" style=\"width:130px;\">"+file.fileName+"</div>"; 
								htmlstr += "<div class=\"divtrtd\" style=\"width:60px;\">"+fileSize+"</div>"; 
								
								//相关操作
								htmlstr += "<div class=\"divtrtd\" style=\"width:100px;\">"; 
									htmlstr += "<span style=\"width:auto;height:auto;float:left;\">";
										htmlstr += "<input id=\"query_"+type+"_"+puid+"_"+ivIndex+"_play_"+index+"\" type=\"button\" style=\"width:45px;height:18px;color:#15428B;background-color:Transparent;border:1px #FFFFFF solid;\" onmouseover=\"this.style.fontWeight='bold';this.style.border='1px #000000 solid';\" onmouseout=\"this.style.fontWeight='normal';this.style.border='1px #FFFFFF solid';\" onclick=\"WebClient.Query.PlayVod('"+file.fileName+"','"+file.filePath+"','"+file.csuPuid+"','"+vodTimeLength+"');\" value=\"点播\" title=\"点播\" />";
									htmlstr += "</span>";
									htmlstr += "<span style=\"width:auto;height:auto;float:left;\">";
										htmlstr += "<input id=\"query_"+type+"_"+puid+"_"+ivIndex+"_download_"+index+"\" type=\"button\" style=\"width:45px;height:18px;color:#15428B;background-color:Transparent;border:1px #FFFFFF solid;\" onmouseover=\"this.style.fontWeight='bold';this.style.border='1px #000000 solid';\" onmouseout=\"this.style.fontWeight='normal';this.style.border='1px #FFFFFF solid';\" onclick=\"WebClient.Download.CreateDownload('"+type+"','"+puid+"','"+ivIndex+"','"+file.fileName+"','"+file.fileSize+"','"+file.filePath+"','"+file.csuPuid+"','"+file.beginTime+"','"+file.endTime+"');\" value=\"下载\" title=\"下载\" />";
									htmlstr += "</span>";
								htmlstr += "</div>"; 
								
								htmlstr += "<div class=\"divtrtd\" style=\"width:120px;\">"+beginTime+"</div>"; 
								htmlstr += "<div class=\"divtrtd\" style=\"width:120px;\">"+endTime+"</div>"; 
								htmlstr += "<div class=\"divtrtd\" style=\"width:60px;\" title=\""+file.planReason+"\">"+file.planReason+"</div>"; 
								htmlstr += "<div class=\"divtrtd\" style=\"width:60px;\" title=\""+ivName+"\">"+ivName+"</div>"; 
								htmlstr += "<div class=\"divtrtd\" style=\"width:60px;\">"+fileLocation+"</div>"; 
								htmlstr += "<div class=\"divtrtd\" style=\"width:130px;\" title=\""+fileAllPath+"\">"+fileAllPath+"</div>";  
							
							htmlstr += "</div>"; 
							
							
						} 
						
						while(i < 11)
						{
							classname = (i++ % 2 == 0 ? "divtr" : "divtrother");
							
							htmlstr += "<div id=\"query_"+type+"_"+puid+"_"+ivIndex+"_blankline_"+i+"\" class=\""+classname+"\" style=\"width:930px;\">";
								htmlstr += "<div class=\"divtrtd\" style=\"width:50px;\"></div>"; 
								htmlstr += "<div class=\"divtrtd\" style=\"width:130px;\"></div>"; 
								htmlstr += "<div class=\"divtrtd\" style=\"width:60px;\"></div>"; 
								htmlstr += "<div class=\"divtrtd\" style=\"width:100px;\"></div>"; 
								htmlstr += "<div class=\"divtrtd\" style=\"width:120px;\"></div>"; 
								htmlstr += "<div class=\"divtrtd\" style=\"width:120px;\"></div>"; 
								htmlstr += "<div class=\"divtrtd\" style=\"width:60px;\"></div>"; 
								htmlstr += "<div class=\"divtrtd\" style=\"width:60px;\"></div>"; 
								htmlstr += "<div class=\"divtrtd\" style=\"width:60px;\"></div>"; 
								htmlstr += "<div class=\"divtrtd\" style=\"width:130px;\"></div>"; 
							htmlstr += "</div>";  
						}
						
					}  
					
					break;
				case "image":
					break;
				default:
					break;			
			}
			
			$("detailFiles").innerHTML = htmlstr;  //alert($("detailFiles").innerHTML);
			WebClient.Resource.AttachQueryFilesResultListEvent(); //绑定结果文件列表事件
		},
		
		//绑定结果文件列表事件
		AttachQueryFilesResultListEvent:function(){
			if($("detailFiles"))
			{
				var filelines = $("detailFiles").getElementsByTagName("DIV");	
				for(var i = 0; i < filelines.length; i++)
				{
					var fileline = filelines[i];  
				    if(fileline.id && fileline.id.search("_line_") != -1 && fileline.webclienttype == "list")
					{ 
						fileline.title = "双击可播放";
						fileline.onmouseover = function(){
							this.className =  this.className + "over";  
						}; 
						fileline.onmouseout = function(){ 
							var classname = this.className.replace("over",""); 
							this.className = classname; 
						}; 
						fileline.onclick = function(){}; 
					}
					
				}//end for
				
			}//end if 
		},
		
		UpdateOnlineStatus:function(style){
			/*if(typeof style == "undefined" || !style)
		    {
		        return;
		    }*/
			/*if(typeof resource != "object" || !resource)
		    {
		        return;
		    }
			
			//重新获取资源
			var puInfos = Nrcap2.FetchResource(WebClient.connectId,Nrcap2.Enum.FetchResourceLevel.Nrcap2_GetPUInfo,0,4294967295,"");
			//alert(puInfos.toJSON()); new Array(); //
			for(var i = 0;i < puInfos.length;i++)
			{
				var puInfo = puInfos[i];
				var puid = puInfo["#text"];
				
				if(puid && resource.get(puid))
				{
					resource.get(puid).enable = puInfo.Enable; //使能信号
					resource.get(puid).online = puInfo.Online; //在线信号
					
					var puResourcesInfos = Nrcap2.FetchResource(WebClient.connectId,Nrcap2.Enum.FetchResourceLevel.Nrcap2_GetPUResourceInfo,0,4294967295,"",{PUID:puid}); 
					
					if(puResourcesInfos.length > 0)
					{ 
						if(resource.get(puid).childResource)
						{
							for(var j = 0; j < puResourcesInfos.length;j++)
							{
							 	if(puResourcesInfos[j].type != Nrcap2.Enum.PuResourceType.VideoIn)
								{
									continue;
								} 
								 
								if(resource.get(puid).childResource[j] && resource.get(puid).childResource[j].enable && resource.get(puid).childResource[j].idx == puResourcesInfos[j].idx)
								{
									resource.get(puid).childResource[j].enable = puResourcesInfos[j].enable;
								}  
							}
						}
						
					}
				} 	 
			}*/
			//alert(Object.toJSON(WebClient.Resource.resource)); 
		 
			WebClient.Resource.FetchAllResource(); // 重新获取总资源 
			
			WebClient.Resource.FetchLogicResource(); // 重新获取逻辑分组资源
			 
			var styles = ["video","query","logic"]; // prefixs of tree box 
			
			for(var i = 0; i < styles.length;i++)
			{
				style = styles[i];
				
				//更新页面元素效果
				switch(style){
					case "video":
					case "query":   
						var resource = WebClient.Resource.resource;
						// alert(Object.toJSON(resource));
						
						resource.each(
							function(item){
								var node = item.value;
								var puid = node.puid;
								var online = node.online;
								var enable = node.enable;
								var modelType = node.modelType;		
								  
								if(modelType != Nrcap2.Enum.PuModelType.ENC && modelType != Nrcap2.Enum.PuModelType.WENC && modelType != Nrcap2.Enum.PuModelType.DEC && modelType != Nrcap2.Enum.PuModelType.WDEC)
								{ 
									return;
								}
								
								var prefix = "";
								switch(modelType)
								{
									case Nrcap2.Enum.PuModelType.ENC:
									case Nrcap2.Enum.PuModelType.DEC:
										prefix = "station";
										break;
									case Nrcap2.Enum.PuModelType.WENC:
									case Nrcap2.Enum.PuModelType.WDEC:
										prefix = "gateway";
										break;
									default:
										break;
								}
								
								var suffix = "_disabled";
								if(enable == "1" && online == "1")
								{
									suffix = "";
								}
								
								var icoclass = prefix + "" + suffix; 
								
								if($(style+"_"+puid+"_img_ico"))
								{
									$(style+"_"+puid+"_img_ico").className = icoclass;
									
									WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.UpdateOnlineStatus",msg:"<pu>::"+style+"_"+puid+"_img_ico"+"::"+icoclass});
								}
								
								
								if(node.childResource)
								{
									for(var j = 0; j < node.childResource.length; j++)
									{
										var cn = node.childResource[j];
										
										if(cn.type != Nrcap2.Enum.PuResourceType.VideoIn)
										{
											continue;
										} 
										
										var cp = "inputvideo", cs = "_disabled";
										if(online == "1" && enable == "1" && cn.enable == "1")
										{
											cs = "";
										}
										var cico = cp + "" + cs;

										
										var idx = cn.idx;
										
										if($(style+"_"+puid+"_"+idx+"_img_ico"))
										{
											$(style+"_"+puid+"_"+idx+"_img_ico").className = cico;
										 
											WebClient.Debug.Note({time:WebClient.time.format("yyyy-MM-dd HH:mm:ss"),fn:"WebClient.Resource.UpdateOnlineStatus",msg:"<puRes>::"+style+"_"+puid+"_"+idx+"_img_ico"+"::"+cico});
										}
									} 
									
								} 
								
							}
							
						);
						
						break;
					case "logic":
						var logicGroup = WebClient.Resource.logicGroup;
						//alert(Object.toJSON(logicGroup));
						
						logicGroup.each(
							function(item){
								var node = item.value;
								
								if(node)
								{
									var lgIdx = node.Index;
									var lgName = node.Name; 
									var lgChild = node.childResource;
									
									if(lgChild && lgChild.length > 0)
									{ 
										for(var i = 0; i < lgChild.length; i++)
										{
											var lgn = lgChild[i];
											var lgnIdx = lgn.Index;
											var lgnName = lgn.Name; 
											
											var lgnChild = lgn.childResource;
											
											if(lgnChild && lgnChild.length > 0)
											{
												var preImgIco = lgIdx + "_" + lgName + "_" + lgnIdx + "_" + lgnName;
												 
												for(var j = 0; j < lgnChild.length; j++)
												{  
													var lgr = lgnChild[j];
													if(lgr.Type != Nrcap2.Enum.PuResourceType.VideoIn)
													{
														continue;
													}
													var PUID = lgr.PUID;
													var ivIdx = lgr.Idx; 
													var Enable = lgr.Enable;  
													
													//alert(preImgIco + "_" + PUID + "_" + ivIdx + "_img_ico"); 
													
													if($(preImgIco + "_" + PUID + "_" + ivIdx + "_img_ico"))
													{
														var flag = false;
														var res = WebClient.Resource.resource.get(PUID);
														var online = "0", enable = "0" ;
														if(typeof res == "object")
														{
															flag = true;
															online = res.online;
															enable = res.enable;
														} 
														var prefix = "inputvideo", suffix = "_disabled";
														if(flag)
														{
															if(online == "1" && enable == "1" && Enable == "1")
															{
																suffix = "";
															}
														} 
														else
														{
															if(Enable == "1")
															{
																suffix = "";
															}	
														} 
														var icoClass = prefix + "" + suffix;
														$(preImgIco + "_" + PUID + "_" + ivIdx + "_img_ico").className = icoClass;
													}
												} //end for j
												
											} //end lgnChild
											
										} //end for i
										
									} //end lgChild
								} //end node
								
							}
						);
						
						break;
					default:
						break;
				} //end switch
			} 
			
			
			
		},
		
	    Html:function(){
	    
	    },
	    
		Expandsion:function(obj,title,ico){
			if(obj)
			{
				if(obj.style.display == "none")
				{
					if(obj.innerHTML == "") return;
					obj.style.display = "block";
					if(title) title.className = "minus";
					if(ico)
					{
						ico.className = "stationmodel_expand";
					}
				}
				else
				{
					obj.style.display = "none";
					if(title) title.className = "plus";
					if(ico)
					{
						ico.className = "stationmodel_collapse";
					}
				}
			} 
		},
		
	    end:true
		
	},
	
	/*
	*	函数名		：Download
	*	函数功能   	：下载对象 
	*	备注			：无 
	*	作者			：huzw
	*	时间			：2011.03.09
	*/
	Download:{
		containers:["downloadVods","downloadImages"],
		//downloads:new Hash(), //remove
		
		/*
		*	函数名		：Init
		*	函数功能   	：初始化下载容器页面元素 
		*	备注			：无 
		*	作者			：huzw
		*	时间			：2011.03.09
		*/
		Init:function(){
			var containers = WebClient.Download.containers;
			for(var i = 0; i < containers.length; i++)
			{
				var container = containers[i]; 
				if($(container))
				{
					WebClient.Download.Html(container); //加载默认元素 
				}
			}
			
			/*for(var i = 0; i < containers.length; i++)
			{
				var container = containers[i];
				var type = "vod";
				if($(container))
				{
					WebClient.Download.Html(container); //加载默认元素
					
					if(container.toLowerCase().search(type) == -1)
					{
						type = "image";
					}
					WebClient.Download.downloads.set(container + "_Platform",{"container":container,"type":type,"model":"Platform","count":0,"content":new Hash()}); //平台下载
					WebClient.Download.downloads.set(container + "_CEFS",{"container":container,"type":type,"model":"CEFS","count":0,"content":new Hash()}); //前端下载
				}
			}
			//alert(Object.toJSON(WebClient.Download.downloads));
			//==>{"downloadVods_Platform":{"container":"downloadVods","type":"vod","model":"Platform","count":0,"content":{}} ,"downloadVods_CEFS":{"container":"downloadVods","type":"vod","model":"CEFS","count":0,"content":{}} ,"downloadImages_Platform":{"container":"downloadImages","type":"image","model":"Platform","count":0,"content":{}} ,"downloadImages_CEFS":{"container":"downloadImages","type":"image","model":"CEFS","count":0,"content":{}}}*/
			
		},
		
		StopAllDownloads:function(){
			//remove
			
		},
		
		/*
		*	函数名		：CreateDownload
		*	函数功能   	：创建下载对象的实例 
		*	备注			：无
		*	作者			：huzw
		*	时间			：2011.03.09
		*/
		CreateDownload:function(type,puid,puIVIdx,fileName,fileSize,filePath,csuPuid,beginTime,endTime,snapTime){
			//alert(type+":"+puid+":"+puIVIdx+":"+fileName+":"+filePath+":"+csuPuid+":"+beginTime+":"+endTime);
			if(!type || (type != "vod" && type != "image"))
			{
				return false;
			}
			
			var curQCardId = WebClient.Resource.QueryResource.currentQueryCardId; //queryPlatform..queryCEFS
			var model = "Platform";
			if(curQCardId.search(model) == -1)
			{
				model = "CEFS";
			}
			
			var fileAllPath = filePath + "/" + fileName;
			var ivName = WebClient.Query.detailTitleNote["ivName"]; //从查询结果导航头获取摄像点名称   
			var saveAllPath = "C://" + ivName + "_" + fileName; //暂用
			 
			var containers = WebClient.Download.containers;  
			
			var params = {}; 
			
			switch(type)
			{
				case "vod":  
					if(model == "Platform")
					{
						params = {
							"epId":Nrcap2.Connections.get(WebClient.connectId).connParam.epId,
							"fileName":fileName,
							"fileAllPath":fileAllPath,
							"saveAllPath":saveAllPath, //need to be changing
							"csuPuid":csuPuid,
							"puid":puid,
							"idx":puIVIdx,
							"offset":0,
							"length":-1,
							"customParams":{//自定义参数 
								"complete":false, //完成情况
								"progress":0, //下载进度
								"showAt":"down_" + fileName, //显示容器
								"fileSize":fileSize,
								"beginTime":beginTime,
								"endTime":endTime,
								"ivName":ivName
							}
						};
						
						//alert(Object.toJSON(params));
						var objDl = Nrcap2.Download.Create(WebClient.connectId,type,params); 
						objDl.Start(); // 开始下载 
						
 						if(!Utility.Clock.EventCallback.events.get("downloadTimer"))
						{
							//开始侦测回放视频状态 
							Utility.Clock.EventCallback.Set(
								new Utility.Struct.ClockEventStruct(
									"downloadTimer",
									200,
									function(t){
										 WebClient.Download.RefreshDownloadProgress();
									}
								)
							);
						}
						 
						 
					}
					else
					{
						return;	
					}
					
					WebClient.Download.Html(containers[0],"list"); //列出文件 
					
					break;
				case "image":  
					WebClient.Download.Html(containers[1],"list"); //列出文件
					if(model == "Platform")
					{
						
					}
					else
					{
						return;	
					}
					break;
				default:
					break;
			}
			
			/*WebClient.Download.downloads.each(
				function(item){
					var node = item.value;
					if(node.type == type && node.model == model)
					{
						node.content.						
					}
					
				}
			);
			alert(Object.toJSON(WebClient.Download.downloads));*/
			 
		}, 
		
		RefreshDownloadProgress:function(){

			var downloadflag = false; //是否有下载的对象文件
			
			Nrcap2.Download.downloads.each(
				function(item){
					var objDl = item.value;
					if(!objDl.customParams.complete)
					{
						downloadflag = true;
						var status = objDl.GetStatus(); //alert(Object.toJSON(status));
						
						var htmlstr = "";
						var description = status["description"];
						var byte = status["byte"];
						if(byte < 1024)
						{
							byte = byte + "B";
						}
						else if(byte < 1024 * 1024)
						{
							byte = Math.floor(byte/1024).toFixed(2) + "KB";
						}
						else
						{
							byte = Math.floor(byte/(1024 * 1024)).toFixed(2) + "MB";
						}
						htmlstr += description + ":" + byte;
						if($(objDl.customParams.showAt))
						{
							$(objDl.customParams.showAt).innerHTML = htmlstr;
						}
						
					}
				}
			);
			
			if(!downloadflag)
			{
				Utility.Clock.EventCallback.UnSet("downloadTimer");
			}
		},
		
		Html:function(container,flag){
			if(!container || !$(container))
			{
				return false;	
			}
			
			var htmlstr = "";
			switch(container)
			{
				case "downloadVods":
					htmlstr += "<div id=\"query_downloadVods_title\" class=\"divth\" style=\"width:1030px;\">";
						htmlstr += "<div class=\"divthtd\" style=\"width:50px;\">索引</div>"; 
						htmlstr += "<div class=\"divthtd\" style=\"width:130px;\">文件名称</div>"; 
						htmlstr += "<div class=\"divthtd\" style=\"width:60px;\">大小</div>"; 
						htmlstr += "<div class=\"divthtd\" style=\"width:150px;\">进度</div>"; 
						htmlstr += "<div class=\"divthtd\" style=\"width:100px;\">操作</div>"; 
						htmlstr += "<div class=\"divthtd\" style=\"width:120px;\">起始时间</div>"; 
						htmlstr += "<div class=\"divthtd\" style=\"width:120px;\">结束时间</div>"; 
						htmlstr += "<div class=\"divthtd\" style=\"width:60px;\">录像原因</div>"; 
						htmlstr += "<div class=\"divthtd\" style=\"width:60px;\">摄像点</div>"; 
						htmlstr += "<div class=\"divthtd\" style=\"width:60px;\">存储位置</div>"; 
						htmlstr += "<div class=\"divthtd\" style=\"width:100px;\">存储路径</div>"; 
					htmlstr += "</div>";
					
					var i = 0, classname = "divtr"; 
					 
					if(flag && flag == "list")
					{
						//alert(Object.toJSON(Nrcap2.Download.downloads));
						Nrcap2.Download.downloads.each(
							function(item){
								var objDl = item.value; 
								
								var fileLocation = "";
								if(objDl.fileVer == "Platform")
								{
									fileLocation = "平台存储"; 						
								}
								else
								{
									fileLocation = "前端存储";
								}
								
								classname = (i++ % 2 == 0 ? "divtr" : "divtrother");
								
								var beginTime = new Date(parseInt(objDl.customParams.beginTime) * 1000).format("yyyy-MM-dd HH:mm:ss");
						 		var endTime = new Date(parseInt(objDl.customParams.endTime) * 1000).format("yyyy-MM-dd HH:mm:ss");
								
								htmlstr += "<div id=\"query_downloadVods_line_"+i+"\" class=\""+classname+"\" style=\"width:1030px;\">";
									htmlstr += "<div class=\"divtrtd\" style=\"width:50px;\"><span class=\"vodlogo\"></span><span>"+i+"</span></div>"; 
									htmlstr += "<div class=\"divtrtd\" style=\"width:130px;\">"+objDl.fileParams.fileName+"</div>"; 
									htmlstr += "<div class=\"divtrtd\" style=\"width:60px;\">"+objDl.customParams.fileSize+"</div>"; 
									htmlstr += "<div class=\"divtrtd\" style=\"width:150px;\" id=\"down_"+objDl.fileParams.fileName+"\" ></div>"; 
									htmlstr += "<div class=\"divtrtd\" style=\"width:100px;\"></div>"; 
									htmlstr += "<div class=\"divtrtd\" style=\"width:120px;\">"+beginTime+"</div>"; 
									htmlstr += "<div class=\"divtrtd\" style=\"width:120px;\">"+endTime+"</div>"; 
									htmlstr += "<div class=\"divtrtd\" style=\"width:60px;\"></div>"; 
									htmlstr += "<div class=\"divtrtd\" style=\"width:60px;\" title=\""+objDl.customParams.ivName+"\">"+objDl.customParams.ivName+"</div>"; 
									htmlstr += "<div class=\"divtrtd\" style=\"width:60px;\">"+fileLocation+"</div>"; 
									htmlstr += "<div class=\"divtrtd\" style=\"width:100px;\" title=\""+objDl.fileParams.fileAllPath+"\">"+objDl.fileParams.fileAllPath+"</div>"; 
								htmlstr += "</div>";
								 
							}
						);/**/
						
					}
					 
					while(i < 10)
					{
						classname = (i++ % 2 == 0 ? "divtr" : "divtrother");
						
						htmlstr += "<div id=\"query_downloadVods_blankline_"+i+"\" class=\""+classname+"\" style=\"width:1030px;\">";
							htmlstr += "<div class=\"divtrtd\" style=\"width:50px;\"></div>"; 
							htmlstr += "<div class=\"divtrtd\" style=\"width:130px;\"></div>"; 
							htmlstr += "<div class=\"divtrtd\" style=\"width:60px;\"></div>"; 
							htmlstr += "<div class=\"divtrtd\" style=\"width:150px;\"></div>"; 
							htmlstr += "<div class=\"divtrtd\" style=\"width:100px;\"></div>"; 
							htmlstr += "<div class=\"divtrtd\" style=\"width:120px;\"></div>"; 
							htmlstr += "<div class=\"divtrtd\" style=\"width:120px;\"></div>"; 
							htmlstr += "<div class=\"divtrtd\" style=\"width:60px;\"></div>"; 
							htmlstr += "<div class=\"divtrtd\" style=\"width:60px;\"></div>"; 
							htmlstr += "<div class=\"divtrtd\" style=\"width:60px;\"></div>"; 
							htmlstr += "<div class=\"divtrtd\" style=\"width:100px;\"></div>"; 
						htmlstr += "</div>";  
					} 
					
					break;				
				case "downloadImages":
					htmlstr += "<div id=\"query_downloadImages_title\" class=\"divth\" style=\"width:870px;\">";
						htmlstr += "<div class=\"divthtd\" style=\"width:50px;\">索引</div>"; 
						htmlstr += "<div class=\"divthtd\" style=\"width:130px;\">文件名称</div>"; 
						htmlstr += "<div class=\"divthtd\" style=\"width:60px;\">大小</div>"; 
						htmlstr += "<div class=\"divthtd\" style=\"width:110px;\">进度</div>"; 
						htmlstr += "<div class=\"divthtd\" style=\"width:100px;\">操作</div>"; 
						htmlstr += "<div class=\"divthtd\" style=\"width:120px;\">抓拍时间</div>";  
						htmlstr += "<div class=\"divthtd\" style=\"width:60px;\">抓拍原因</div>"; 
						htmlstr += "<div class=\"divthtd\" style=\"width:60px;\">摄像点</div>"; 
						htmlstr += "<div class=\"divthtd\" style=\"width:60px;\">存储位置</div>"; 
						htmlstr += "<div class=\"divthtd\" style=\"width:100px;\">存储路径</div>"; 
					htmlstr += "</div>";
					
					var i = 0, classname = "divtr";
					while(i < 10)
					{
						classname = (i++ % 2 == 0 ? "divtr" : "divtrother");
						
						htmlstr += "<div id=\"query_downloadImages_blankline_"+i+"\" class=\""+classname+"\" style=\"width:870px;\">";
							htmlstr += "<div class=\"divtrtd\" style=\"width:50px;\"></div>"; 
							htmlstr += "<div class=\"divtrtd\" style=\"width:130px;\"></div>"; 
							htmlstr += "<div class=\"divtrtd\" style=\"width:60px;\"></div>"; 
							htmlstr += "<div class=\"divtrtd\" style=\"width:110px;\"></div>"; 
							htmlstr += "<div class=\"divtrtd\" style=\"width:100px;\"></div>"; 
							htmlstr += "<div class=\"divtrtd\" style=\"width:120px;\"></div>";  
							htmlstr += "<div class=\"divtrtd\" style=\"width:60px;\"></div>"; 
							htmlstr += "<div class=\"divtrtd\" style=\"width:60px;\"></div>"; 
							htmlstr += "<div class=\"divtrtd\" style=\"width:60px;\"></div>"; 
							htmlstr += "<div class=\"divtrtd\" style=\"width:100px;\"></div>";  
						htmlstr += "</div>";  
					}
					break;
				default:
					break;
			}
			
			$(container).innerHTML = htmlstr; //alert(htmlstr);
			
		},
		
		end:true
	},
	
	ClientOffset:function(obj){
        var valueTop = 0, valueLeft = 0;
        do
        {
            valueTop += obj.offsetTop || 0 ;
            valueLeft += obj.offsetLeft || 0;                
            obj = obj.offsetParent;
        }
        while(obj);  
        return [valueLeft, valueTop];
    },
    
	// 布防时间图











	GuardTimeMap:{
		_mapType:['min','wek'],
		_flag:0, // 默认
		_$:document.getElementById,
		_minutes:['0','5','10','15','20','25','30','35','40','45','50','55'],
		_weeks:['日','一','二','三','四','五','六'],
		_hours:['0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23'],
		
		Create:function(objId, mapType){
			if(!objId || !this._$(objId))
			{ 
				alert("布防时间图容器未知！");
				return false;
			}
			
			if(!mapType || this._mapType.indexOf(mapType) == -1)
			{
				alert("布防时间图类型未知！");
				return false;
			} 
			
			var horizontal  = this._hours; // 水平的











			var vertical = ""; // 竖直的 
			
			if(this._mapType.indexOf(mapType) == 0)
			{
				vertical = this._minutes; this._flag = 0;
			}
			else { vertical = this._weeks; this._flag = 1;}
 			
			var htmlstr = "", topbar = "", leftbar = "", bodystr = "";
			
			// top hours
			topbar += "<div style=\"width:425px; height:18px; float:left; border-bottom:1px solid #000000;\">";
				topbar += "<div type=\"gtm_corner_select\" title=\"表格反选\" style=\"cursor:pointer;width:16px; height:100%; float:left;\">&lt;&gt;</div>";
				if(horizontal.length > 0)
				{
					for(var i = 0; i < horizontal.length; i++)
					{
						var item = horizontal[i];
						topbar += "<div type=\"gtm_hoz_" + i + "\" style=\" cursor:default; width:16px; height:100%; text-align:center; float:left; border-left:1px solid #000000;\" >" + item + "</div>";
					} 
				} 
			topbar += "</div>";
			
			// left minutes/weeks
			leftbar += "<div style=\"width:16px; height:220px; float:left; border-right:1px solid #000000;\">"; 
				if(vertical.length > 0)
				{
					for(var i = 0; i < vertical.length; i++)
					{
						var item = vertical[i];
						leftbar += "<div type=\"gtm_ver_" + i + "\"  style=\" cursor:default; width:100%; height:17px; text-align:center; line-height:17px; vertical-align:center; float:left; border-top:1px solid #000000;\" >" + item + "</div>";
					} 
				} 
			leftbar += "</div>";
			
			  // body tds
			bodystr += "<div style=\" width:405px; height:220px; text-align:center; background-color:#ffffff; float:left; border:0px solid #000000;\"><table width=\"408\" height=\"220\" cellspacing=\"1\" cellpadding=\"0\" >"; 
			for(var j = 0; j < vertical.length; j++)
			{
				bodystr += "<tr style=\"width:auto;\" >";
				for(var k = 0; k < horizontal.length * (this._flag == 0 ? 1 : 2); k++)
				{
					// bodystr += "<td style=\"cursor:default; " + (3 < j && j < 6 ? "background-color:#00ff00;" : "") + " border:1px solid #000000;\">&nbsp;</td>";
	
					bodystr += "<td style=\"cursor:default; border:1px solid #000000;background-color:#00ff00;\">&nbsp;</td>";
	 
				}
				bodystr += "</tr>";
			}
			bodystr += "</table></div>";
			
			htmlstr += "<div id=\""+objId+"-inner\" style=\"float:center;width:425px;height:240px;color:#000000;background-color:Transparent;border:1px solid #000000;\">"; // background-color:#f5f5f5;
			
				htmlstr += topbar;
				htmlstr += leftbar;
				htmlstr += bodystr;
	
			htmlstr += "</div>";
			
			this._$(objId).innerHTML = htmlstr;	
			
			this.Event(objId, mapType);
		},
		
		Event:function(objId, mapType){
			if(!objId || !this._$(objId))
			{ 
				alert("布防时间图容器未知！");
				return false;
			}
			
			if(!mapType || this._mapType.indexOf(mapType) == -1)
			{
				alert("布防时间图类型未知！");
				return false;
			} 
			
			var horizontal  = this._hours; // 水平的











			var vertical = ""; // 竖直的 
			
			if(this._mapType.indexOf(mapType) == 0)
			{
				vertical = this._minutes; this._flag = 0;
			}
			else { vertical = this._weeks; this._flag = 1;}
			
			var maptitledivs = this._$(objId).getElementsByTagName("DIV");
			for(var i = 0; i < maptitledivs.length; i++)
			{
				var maptitlediv = maptitledivs[i]; 
				if(maptitlediv && maptitlediv.type && maptitlediv.type.search("gtm_") != -1)
				{ 
					maptitlediv.onclick = function(){ 
						if(this.type.search("_hoz_") != -1)
						{
							WebClient.GuardTimeMap.SetStatus(objId, mapType, "hoz", this.type.replace("gtm_hoz_",""), this);
						}
						else if(this.type.search("_ver_") != -1)
						{
							WebClient.GuardTimeMap.SetStatus(objId, mapType, "ver", this.type.replace("gtm_ver_",""), this);
						}  
						else if(this.type.search("_corner_select") != -1)
						{
							WebClient.GuardTimeMap.SetStatus(objId, mapType);	
						}
					}; 
				}
				
			}
			
			var maptds = this._$(objId).getElementsByTagName("TD");
			for(var j = 0; j < maptds.length; j++)
			{
				var maptd = maptds[j];
				if(maptd)
				{
					maptd.onclick = function(){
						WebClient.GuardTimeMap.ColorTD(this);
					};
					
				}
			}
		},
		
		SetStatus:function(objId, mapType ,flag, index){
			if(!objId || !this._$(objId))
			{ 
				alert("布防时间图容器未知！");
				return false;
			}
			
			if(!mapType || this._mapType.indexOf(mapType) == -1)
			{
				alert("布防时间图类型未知！");
				return false;
			} 
			
			var horizontal  = this._hours; // 水平的











			var vertical = ""; // 竖直的 
			
			if(this._mapType.indexOf(mapType) == 0)
			{
				vertical = this._minutes; this._flag = 0;
			}
			else { vertical = this._weeks; this._flag = 1;} 
			
			var maptds = this._$(objId).getElementsByTagName("TD");
	
			index = parseInt(index);
			
			if(flag == "ver")
			{ 
				for(var i = index * horizontal.length * (this._flag == 0 ? 1 : 2); i < (index + 1) * horizontal.length * (this._flag == 0 ? 1 : 2); i++)
				{ 
					this.ColorTD(maptds[i]);
				}	
			}
			else if(flag == "hoz")
			{ 
				switch(this._flag)
				{
					case 0:
						var tdcolumnIdx = index;
						for(var m = 0; m < vertical.length; m++)
						{
							this.ColorTD(maptds[(m * horizontal.length) + tdcolumnIdx]); 
						}
						break;
					case 1:
						if(arguments[4]) var obj = arguments[4]; else return false; 
				
						var Lx = event.x + document.body.scrollLeft; // alert(Lx);
						var ty = event.y + document.body.scrollTop; // alert(ty);
			
						var offset = GuardTimeMap.ClientOffset(obj);
			
						var objX = offset[0], objY = offset[1];
						var objW = obj.offsetWidth;
						var objH = obj.offsetHeight; 
						  
						if(objX <= Lx && Lx <= (objX + Math.ceil(objW/2)))
						{ 
							var tdcolumnIdx = index * 2;
						} 
						else if((objX + Math.ceil(objW/2)) < Lx && Lx <= (objX + objW))
						{ 
							var tdcolumnIdx = index * 2 + 1;
						}
						
						for(var m = 0; m < vertical.length; m++)
						{
							this.ColorTD(maptds[(m * horizontal.length * 2 ) + tdcolumnIdx]); 
						}
						break;
					default:
						break;
				}  
				// this.GetBinaryMapStr(objId, mapType);
				// this.GetHexMapStr(objId, mapType);
			} 
			else if(flag == "all")
			{
				for(var r = 0; r < maptds.length; r++)
				{
					maptds[r].style.backgroundColor = "#00ff00";
				}
			}
			else if(flag == "clear")
			{
				for(var s = 0; s < maptds.length; s++)
				{
					maptds[s].style.backgroundColor = "#ffffff";
				}
			}
			else
			{
				for(var t = 0; t < maptds.length; t++)
				{
					this.ColorTD(maptds[t]);
				}
			}		
		},
		
		GetHexMapStr:function(objId, mapType ,bstr){
			if(!objId || !this._$(objId))
			{ 
				alert("布防时间图容器未知！");
				return false;
			}
			
			if(!mapType || this._mapType.indexOf(mapType) == -1)
			{
				alert("布防时间图类型未知！");
				return false;
			} 
			
			var horizontal  = this._hours; // 水平的











			var vertical = ""; // 竖直的 
			
			if(this._mapType.indexOf(mapType) == 0)
			{
				vertical = this._minutes; this._flag = 0;
			}
			else { vertical = this._weeks; this._flag = 1;} 
			
			var hex = "";
		
			if(!bstr || typeof bstr == "undefined")
			{ 
				bstr = "";
				bstr = this.GetBinaryMapStr(objId, mapType);
				if(bstr.length != vertical.length * horizontal.length * (this._flag == 0 ? 1 : 2))
				{
					return false;
				}
			}
			 
			if(bstr.length % 4 != 0) 
			{
				for(var r = 0; r < bstr.length % 4; r++)
				{
					bstr += "0";
				}
			}
			
			for(var i = 0; i < bstr.length; i+=4)
			{
				var splitstr = bstr.substr(i, 4);
				hex += this.SwitchHexBinary(16,splitstr);
			}
			// alert(hex);
			 
			return hex;
		},

		GetBinaryMapStr:function(objId, mapType, hstr){
			if(!objId || !this._$(objId))
			{ 
				alert("布防时间图容器未知！");
				return false;
			}
			
			if(!mapType || this._mapType.indexOf(mapType) == -1)
			{
				alert("布防时间图类型未知！");
				return false;
			} 
			
			var horizontal  = this._hours; // 水平的











			var vertical = ""; // 竖直的 
			
			if(this._mapType.indexOf(mapType) == 0)
			{
				vertical = this._minutes; this._flag = 0;
			}
			else { vertical = this._weeks; this._flag = 1;} 
			
			var bina = ""; 
	
			if(!hstr || typeof hstr == "undefined")
			{ 
				hstr = ""; 
				var maptds = this._$(objId).getElementsByTagName("TD");
				
				switch(this._flag)
				{
					case 0: 
						var vertstr = "";
						var per = horizontal.length;
						
						for(var m = 0; m < per; m++)
						{ 
							for(var n = 0; n < vertical.length; n++)
							{
								vertstr += maptds[m + n * per].style.backgroundColor != "#00ff00" ? "0" : "1"; 
							}
						}
						// alert(vertstr); 
						bina += vertstr;
						break;
					case 1:
						for(var i = 0; i < maptds.length; i++)
						{ 
							var maptd = maptds[i];
							bina += maptd.style.backgroundColor != "#00ff00" ? "0" : "1";
						} 
						break;
					default:
						break;
				}   
			}
			else
			{ 
				for(var i = 0; i < hstr.length; i++)
				{
					var splitstr = hstr.charAt(i).toUpperCase();
					bina += WebClient.GuardTimeMap.SwitchHexBinary(2,splitstr);
				}
			} 
		  
			if(bina.length != vertical.length * horizontal.length * (this._flag == 0 ? 1 : 2))
			{
				return false;
			}
			
			// alert(bina);
					
			return bina;
		},
		
		ColorMapByHexBinaryStr:function(objId, mapType, type, v){
			if(!objId || !this._$(objId))
			{ 
				alert("布防时间图容器未知！");
				return false;
			}
			
			if(!mapType || this._mapType.indexOf(mapType) == -1)
			{
				alert("布防时间图类型未知！");
				return false;
			} 
			
			var horizontal  = this._hours; // 水平的











			var vertical = ""; // 竖直的 
			
			if(this._mapType.indexOf(mapType) == 0)
			{
				vertical = this._minutes; this._flag = 0;
			}
			else { vertical = this._weeks; this._flag = 1;}  
			
			if(!v || typeof v == "undefined") return false;
	
			var bstr = "";
	 
			if(type == 16)
			{
				bstr = this.GetBinaryMapStr(objId, mapType, v);	
			}
		   
			var maptds = this._$(objId).getElementsByTagName("TD");
	
			if(bstr.length != maptds.length) return false;
			
			switch(this._flag)
			{
				case 0: 
					var vertstr = "";
					var per = horizontal.length; 
					
					for(var i = 0; i < bstr.length && i < maptds.length; i++)
					{
						var splitstr = bstr.charAt(i);
						maptds[Math.floor(i/12) + Math.floor(i % 12) * per].style.backgroundColor = splitstr == "1"? "#00ff00" : "#ffffff";  
					} 
					// alert(vertstr);  
					break;
				case 1:
					for(var i = 0; i < bstr.length && i < maptds.length; i++)
					{
						var splitstr = bstr.charAt(i);
						maptds[i].style.backgroundColor = splitstr == "1"? "#00ff00" : "#ffffff";
					} 
					break;
				default:
					break;
			}  
			
		},
		
		ColorTD:function(obj){ 
			if(obj) obj.style.backgroundColor = obj.style.backgroundColor != "#00ff00" ? "#00ff00" : "#ffffff"; 
		},
		
		SwitchHexBinary:function (type,v)
		{
			if(type == 16)
			{
				switch(v.toString()){
				   case "0000":return "0";break;
				   case "0001":return "1";break;
				   case "0010":return "2";break;
				   case "0011":return "3";break;
				   case "0100":return "4";break;
				   case "0101":return "5";break;
				   case "0110":return "6";break;
				   case "0111":return "7";break;
				   case "1000":return "8";break;
				   case "1001":return "9";break;
				   case "1010":return "A";break;
				   case "1011":return "B";break;
				   case "1100":return "C";break;
				   case "1101":return "D";break;
				   case "1110":return "E";break;
				   case "1111":return "F";break;
				   default:return "0";break;
			  }
			}
			else
			{
				switch(v){
				   case "0":return "0000";break;
				   case "1":return "0001";break;
				   case "2":return "0010";break;
				   case "3":return "0011";break;
				   case "4":return "0100";break;
				   case "5":return "0101";break;
				   case "6":return "0110";break;
				   case "7":return "0111";break;
				   case "8":return "1000";break;
				   case "9":return "1001";break;
				   case "A":return "1010";break;
				   case "B":return "1011";break;
				   case "C":return "1100";break;
				   case "D":return "1101";break;
				   case "E":return "1110";break;
				   case "F":return "1111";break;
				   default:return "0000";break;
				}
			}	
		}, 
		
		ClientOffset:function(obj){
			if(obj)
			{
				var valueT = 0, valueL = 0;
				do
				{
					valueT += obj.offsetTop || 0;
					valueL += obj.offsetLeft || 0;
					obj = obj.offsetParent; 
				}
				while(obj); 
				return [valueL, valueT];
			}
		},	
		
		end:true
	},
	
	end:true
};

/* some global vars */
var Global = {
	route:"blue", //main css path prefix
	folder:"ch", //path folder for language of 'Chinese'..'English'
	defaultTitleBgColor:"#9bcaf3",
	activeTitleBgColor:"#65a3e5",
	
	Init:function(skin){
		if(!skin || typeof skin != "string")
		{
			return false;
		}
		
		var route = Global.route;
		
		if(skin.search("blue") != -1) route = "blue";
		else if(skin.search("metalgrey") != -1) route = "metalgrey";
		else if(skin.search("newyear") != -1) route = "newyear";
		else route = "blue";
		
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
		styleSheetList:new Array("blue","metalgrey","newyear"),
		defaultStyleSheet:"blue",
		
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
	
	window.attachEvent(
		"onresize",
		function(){  
			var clientW = document.body.clientWidth;
			var clientH = document.body.clientHeight;
			if($("windowPad"))
			{ 
				// 多窗口全屏显示 
				if(WebClient.DealManage.AllFullScreen.flag == 'start')
				WebClient.DealManage.AllFullScreen.Start();
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