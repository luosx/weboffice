/**
* Nrcap2SDK FOR JavaScript 中外合资创世科技版权所有. 
* FileName.......: nrcap2sdk.js
* Project........: Nrcap2JavascriptSDK
* Create DateTime: 2010/11/26 10:24:00 $
*/

var Nrcap2 = {
    version: "v2011.10.20.001", 	/*	版本 */
    language: "Chinese",		/* [中文,英文支持] */
    debug: false,			    /* 调试状态 */
    
     Connections: new Hash(),             /* Connection对象组,没有定义成数组Array形式是为了通过key直接访问 */      
    WindowContainers: new Hash(),        /* WindowContainers对象组,没有定义成数组Array形式是为了通过key直接访问 */ 	
	PopWindowContainers: new Hash(),	
	Downloads: new Hash(),		        /* 下载对象 */ 
        
    puidRex : /^[A-Za-z0-9]{1,18}$/i,		// puid reg
    intRex: /^-?\d+$/,					// 整数 reg  
	
   /*
     *	对象名		：Plug
     *	功能    	：Nrcap2对象
     *	备注		：无
     *	作者		：Lingsen
     *	时间		：2010年11月26日 
    */
    Plug:
    {
        inited: false,
        nc: null,
        nm: null,
		na: null,
		bsc: null,
		bsp: null,
		dc: null,
		dl: null 
    },
    
    /*
     *	对象名		：PlugHtml
     *	功能    	：插件对象的html元素
     *	备注		：无
     *	作者		：Lingsen
     *	时间		：2010年11月26日 
     */
    PlugHtml:
    {
        nc: "<OBJECT id=\"@id\" name=\"@name\" CLASSID=\"CLSID:19F9C7D6-477D-4A34-BB77-B29219A41F5C\" style=\"display:none;\" codebase=\"CreMedia7Nrcap2ATL.zip#version=1,2011,5,26\">",
		nm: "<OBJECT id=\"@id\" name=\"@name\" CLASSID=\"CLSID:4049773E-A62D-4C09-BF7E-74E6A943AFE9\" style=\"display:none;\" codebase=\"CreMedia7Nrcap2ATL.zip#version=1,2011,5,26\">",
        na: "<OBJECT id=\"@id\" name=\"@name\" CLASSID=\"CLSID:E32012F1-58D5-4040-88FF-DC784CDB24AD\" style=\"display:none;\" codebase=\"CreMedia7Nrcap2ATL.zip#version=1,2011,5,26\">",
        wnd: "<OBJECT classid=\"CLSID:C1A33A67-A0F2-42E0-80B6-38EFBDD8AD18\" id=\"@id\" name=\"@name\" width=\"352\" height=\"288\" style=\"border:1px solid #FFFFFF;\" codebase=\"CreMedia7Nrcap2ATL.zip#version=1,2010,9,28\" ><param name=\"_Version\" value=\"65536\"><param name=\"_ExtentX\" value=\"9313\"><param name=\"_ExtentY\" value=\"7620\"><param name=\"_StockProps\" value=\"0\"></OBJECT>",
		bsc: "<OBJECT id=\"@id\" name=\"@name\" CLASSID=\"CLSID:C59FD3F4-ED28-4A19-BBA9-FA37F8A5324F\" style=\"display:none;\" codebase=\"CreMedia7Nrcap2ATL.zip#version=1,2011,5,26\">",
		bsp: "<OBJECT id=\"@id\" name=\"@name\" CLASSID=\"CLSID:5645FBBF-CCD5-4749-B0A6-802808E921A1\" style=\"display:none;\" codebase=\"CreMedia7Nrcap2ATL.zip#version=1,2011,5,26\">",
		dc: "<OBJECT id=\"@id\" name=\"@name\" CLASSID=\"CLSID:E7B56638-B777-4B80-BE6F-A16C681FA4E4\" style=\"display:none;\" codebase=\"CreMedia7Nrcap2ATL.zip#version=1,2011,5,26\">",
        dl: "<OBJECT id=\"@id\" name=\"@name\" CLASSID=\"CLSID:C008FC30-7C8B-470F-82AA-FF9A21C4AA70\" style=\"display:none;\" codebase=\"CreMedia7Nrcap2ATL.zip#version=1,2011,5,26\">", 
        get:function(objname)
        {
            var htmlstr = "";
            switch(objname)
            {
                case "nc":
                    htmlstr = this.nc;
            	    break;
				case "nm":
                    htmlstr = this.nm;
            	    break;
                case "na":
                    htmlstr = this.na;
            	    break;
                case "wnd":
                    htmlstr = this.wnd;
            	    break;
				case "bsc":
                    htmlstr = this.bsc;
            	    break;
				case "bsp":
					htmlstr = this.bsp;
					break;
				case "dc":
                    htmlstr = this.dc;
            	    break;
				case "dl":
					htmlstr = this.dl;
					break;
                default:
            }
            return htmlstr;
        }
    },
    
    // 温馨提示
    WarmTip:{
        /*
         *	函数名		：Display
         *	函数功能	：显示温馨提示信息 
         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2008年11月14日 
         *	返回值		：无
         *	参数说明	：无
         */
        Display:function()
        {  
            var objPlugsNoteBox = document.createElement("DIV");
            objPlugsNoteBox.setAttribute("id","PlugsNoteBox");
            document.getElementsByTagName("body").item(0).appendChild(objPlugsNoteBox);
            objPlugsNoteBox.style.zIindex="999";
            objPlugsNoteBox.style.position="absolute";
            objPlugsNoteBox.style.width="100%";
            objPlugsNoteBox.style.height="100%";
            objPlugsNoteBox.style.top="0";
            objPlugsNoteBox.style.left="0";
            objPlugsNoteBox.style.filter="Alpha(Opacity=75)";
            objPlugsNoteBox.style.filter.MozOpacity="0.8";
            objPlugsNoteBox.style.filter.Opacity="0.8";                
            objPlugsNoteBox.style.backgroundColor="#C3E2FF";
            objPlugsNoteBox.style.color= "#990011";
            objPlugsNoteBox.style.fontSize= "14px";
            objPlugsNoteBox.style.textAlign= "left";
            objPlugsNoteBox.style.lineHeight= "180%";
            objPlugsNoteBox.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;［<b>温馨提示</b>］ 插件装载失败，请您检查一下是否已经成功安装插件！&nbsp;&nbsp;请点击底部或者顶部安装ActiveX控件的提示条！如果没有安装提示条可能是因为您的IE安全级别设置过高,请您修改后再试．另外你可以通过下载插件安装包手动安装插件,如果安装360安全卫士有可能会导致通过IE浏览器无法加载插件,您可以尝试使用360的浏览器浏览监控页面.&nbsp;&nbsp;<a href=\"CreMedia7Nrcap2ATL.zip\">这里下载</a>&nbsp;&nbsp;<a href=\"#self\" onclick=\"location.reload();\">刷新重试</a>";            
        },
        
        /*
         *	函数名		：None
         *	函数功能	：关闭温馨提示信息 

         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2008年11月14日 
         *	返回值		：无
         *	参数说明	：无
         */
        None:function()
        {
            if(document.getElementById("PlugsNoteBox"))
            {
                document.getElementsByTagName("body").item(0).removeChild(document.getElementById("PlugsNoteBox"));
            }
        }
    },
    
    /*
     *	对象名		：Timer
     *	功能    	：定时器对象
     *	备注		：无
     *	作者		：Lingsen
     *	时间		：2010年11月26日 
     */
	Timer:{
		interval:100,
		count:0,
		timer:null,
		events:new Hash(),
		Start:function()
		{
			Nrcap2.Timer.timer = setInterval(Nrcap2.Timer.Call,Nrcap2.Timer.interval);
		},
		Stop:function()
		{
			clearInterval(Nrcap2.Timer.timer);
		},
        Set:function(ev,cb)
        {
            if (typeof Nrcap2.Timer.events == "undefined")
            {
				Nrcap2.Debug.Write({fn:"Nrcap2.Timer.Set",msg:"Nrcap2.Timer.events undefined"});
                return false;
            }
			
            if (typeof cb != "object" || typeof cb.name != "string" || typeof cb.fu != "function" )
            {
				Nrcap2.Debug.Write({fn:"Nrcap2.Timer.Set",msg:"cb undefined "});
                return false;
            }
            
            if (!Nrcap2.Timer.events.get(ev))
            {
				Nrcap2.Timer.events.set(ev,new Hash());
            }
            Nrcap2.Timer.events.get(ev).set(cb.name,{name:cb.name,fu:cb.fu,interval:cb.interval});
        },
        UnSet:function(ev,cbName)
        {
            if (typeof Nrcap2.Timer.events == "undefined")
            {
				Nrcap2.Debug.Write({fn:"Nrcap2.Timer.UnSet",msg:"Nrcap2.Timer.events undefined. "});
                return false;
            }
            
            if (!Nrcap2.Timer.events.get(ev))
            {
				Nrcap2.Debug.Write({fn:"Nrcap2.Timer.UnSet",msg:"ev undefined "});
                return false;
            }
            
            if (typeof cbName != "string" )
            {
				Nrcap2.Debug.Write({fn:"Nrcap2.Timer.UnSet",msg:"cb name undefined "});
                return false;
            }
            Nrcap2.Timer.events.get(ev).unset(cbName);
        },
		
		Call:function()
		{
			Nrcap2.Timer.count++;
			Nrcap2.Timer.events.each
			(
			 	function(item)
				{
					var ev = item.value;
					if(ev && typeof ev.each == "function")
					{
						ev.each
						(
						 	function(evItem)
							{
								var fu = evItem.value;
								if( (Nrcap2.Timer.count*Nrcap2.Timer.interval) % fu.interval == 0)
								{
									if (typeof fu.fu == "function")
									{
										fu.fu();
									}
								}
							}
						)
					}
				}
			);
			if(Nrcap2.Timer.count == 100000000)
			{
				Nrcap2.Timer.count = 0;
			}
            return;
		},
		end:true
	},
    
    /*
     *	函数名		：Init
     *	函数功能	：初始化Nrcap2
     *	备注		：无
     *	作者		：Lingsen
     *	时间		：2010年11月26日 
     *	返回值		：NrcapError.NRCAP_SUCCESS 表示成功,其它对应NrcapError
     *	参数说明	：1
     *  Nrcap2.Struct.InitParamStruct initParam      初始化Nrcap2对象的参数 
     */
    Init:function(initParam)
    {        
        try
        {
			
            if (typeof initParam == "undefined" || initParam instanceof Nrcap2.Struct.InitParamStruct != true)
            {
                initParam = new Nrcap2.Struct.InitParamStruct();
            }
            
            /* 初始化调试信息对象 */
            Nrcap2.Debug.Init(initParam);
            
			var rv = Folder.Init(Nrcap2.debug); //alert(rv);
			if(rv == -1)
			{
                Nrcap2.WarmTip.Display();
				Nrcap2.Debug.Write({fn:"Nrcap2.Init",msg:"Folder assistant load error."});
				return Nrcap2.NrcapError.NRCAP_ERROR_INIT_NRCAPPLUG_FAILED;
			} 

            /* 加载插件 */
            var nm = Nrcap2.PlugHtml.get("nm").replace("id=\"@id\" name=\"@name\"","id=\"Nrcap2NM\" name=\"Nrcap2NM\"");
            var nc = Nrcap2.PlugHtml.get("nc").replace("id=\"@id\" name=\"@name\"","id=\"Nrcap2NC\" name=\"Nrcap2NC\"");
            var na = Nrcap2.PlugHtml.get("na").replace("id=\"@id\" name=\"@name\"","id=\"Nrcap2NA\" name=\"Nrcap2NA\"");
			var bsc = Nrcap2.PlugHtml.get("bsc").replace("id=\"@id\" name=\"@name\"","id=\"Nrcap2BSC\" name=\"Nrcap2BSC\"");
            var bsp = Nrcap2.PlugHtml.get("bsp").replace("id=\"@id\" name=\"@name\"","id=\"Nrcap2BSP\" name=\"Nrcap2BSP\"");
			
            if(!document.getElementById("Nrcap2Box"))
            {
                var objNrcap2Box = document.createElement("DIV");
                objNrcap2Box.setAttribute("id","Nrcap2Box");
                document.getElementsByTagName("body").item(0).appendChild(objNrcap2Box);
            }
			else
			{
				objNrcap2Box = document.getElementById("Nrcap2Box");	
			}
            
            objNrcap2Box.style.display = "none";
            objNrcap2Box.innerHTML = nm;
            objNrcap2Box.innerHTML += nc;
			objNrcap2Box.innerHTML += na;
			objNrcap2Box.innerHTML += bsc;
            objNrcap2Box.innerHTML += bsp;
			 
            /* 检测插件是否加载完成 */
            if (typeof Nrcap2NC.EnableDebug == "undefined")
            {
                Nrcap2.WarmTip.Display();
				Nrcap2.Debug.Write({fn:"Nrcap2.Init",msg:"Nrcap2NC load error. "});
                return Nrcap2.NrcapError.NRCAP_ERROR_LOADPLUG_NC;
            }
            if(typeof Nrcap2NM.Startup == "undefined")
            {
                Nrcap2.WarmTip.Display();
				Nrcap2.Debug.Write({fn:"Nrcap2.Init",msg:"Nrcap2NM load error. "});
                return Nrcap2.NrcapError.NRCAP_ERROR_LOADPLUG_NM;
            } 
			
            Nrcap2.Plug.nc = Nrcap2NC;
            Nrcap2.Plug.nm = Nrcap2NM;
			Nrcap2.Plug.na = Nrcap2NA;
			Nrcap2.Plug.bsc = Nrcap2BSC; 
            Nrcap2.Plug.bsp = Nrcap2BSP; 
			
			// alert(Nrcap2.debug);
			
            /* 插件加载完成,开始 */
            if (Nrcap2.debug)
            {
				Nrcap2.Plug.nc.EnableDebug(1);
                Nrcap2.Plug.nm.EnableDebug(1);
            }
            else
            {
				Nrcap2.Plug.nc.EnableDebug(0);
                Nrcap2.Plug.nm.EnableDebug(0);
            }
			
			
           	var rv = Nrcap2.Plug.nm.Startup();
            if(rv.split("#")[0] != 0x0000)
            {
				Nrcap2.Debug.Write({fn:"Nrcap2.Init",msg:"startup failed("+rv.split("#")[0]+"). "});
	            return Nrcap2.NrcapError.NRCAP_ERROR_INIT_SOCKET_FAILED;
            }
            
			var rv = Nrcap2.Plug.na.Startup();
			if(rv.split("#")[0] != 0x0000)
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.Init",msg:"startup failed("+rv.split("#")[0]+"). "});
	            return Nrcap2.NrcapError.NRCAP_ERROR_INIT_SOCKET_FAILED;
			}
			
            Nrcap2.Plug.inited = true;
			Nrcap2.Timer.Start();
			
            return Nrcap2.NrcapError.NRCAP_SUCCESS;
        }
        catch(e)
        {
			Nrcap2.Debug.Write({fn:"Nrcap2.Init",msg:e.message});
            return Nrcap2.NrcapError.NRCAP_ERROR_INIT_NRCAPPLUG_FAILED;
        }
    },
    
    /*
     *	函数名		：UnLoad
     *	函数功能	：卸载Nrcap2
     *	备注		：无
     *	作者		：Lingsen
     *	时间		：2010年04月09日.  
     *	返回值		：NrcapError.NRCAP_SUCCESS 表示成功,其它对应NrcapError
     *	参数说明	：无
     */
    UnLoad:function()
    {		
		Nrcap2.Timer.Stop();
		
        if(!Nrcap2.Plug.inited)
		{
			return Nrcap2.NrcapError.NRCAP_SUCCESS;
		}
		 
		Nrcap2.Download.UnLoad(); // 停止下载存储文件
		 
		Nrcap2.GPS.UnLoad(); // 停止获取gps数据
		 
        var keys = Nrcap2.Connections.keys().toArray();
           
        for(var i = 0;i < keys.length;i++)
        { 
            Nrcap2.DisConnection(keys[i]);
        }
		
		Nrcap2.Plug.na.Cleanup();
        Nrcap2.Plug.nm.Cleanup();
		//Nrcap2.Plug.nc.Close();
		
        if(document.getElementById("Nrcap2Box"))
        {
            document.getElementsByTagName("body").item(0).removeChild(document.getElementById("Nrcap2Box"));
        }
		this.Plug.inited = false;
        return Nrcap2.NrcapError.NRCAP_SUCCESS;
    },
    /*
     *	函数名		：CreateConnect
     *	函数功能	：新建一个连接对象,保存在Connections组里
     *	备注		：无
     *	作者		：Lingsen
     *	时间		：2010年11月26日.
     *	返回值		：成功返回connectId,其它对应NrcapError
     *	参数说明	：2个参数 
     *		NrcapConnectParams connParam  连接参数
     *  	bool autoConnect 创建连接对象后自动登录 
     */
    CreateConnect:function(connParam,autoConnect)
    {
        try
        {
            if (typeof connParam == "undefined" || connParam instanceof Nrcap2.Struct.ConnParamStruct != true)
            {
                connParam = new Nrcap2.Struct.ConnParamStruct();
            }
            Nrcap2.Debug.Write({fn:"Nrcap2.CreateConnect",msg:"create a connect."});
            if (!Nrcap2.Plug.inited)
            {                
                Nrcap2.Debug.Write({fn:"Nrcap2.CreateConnect",msg:"Nrcap2 no init."});
                return Nrcap2.NrcapError.NRCAP_ERROR_INIT_NRCAPPLUG_FAILED;
            }
            
            /* 检查一下是否已经有相同的连接存在 */
            var keys = Nrcap2.Connections.keys().toArray();
            for(var i = 0;i < keys.length;i++)
            {
                var conn = Nrcap2.Connections.get(keys[i]);
                if (conn.connParam.path == connParam.path)
                {
                    Nrcap2.Debug.Write({fn:"Nrcap2.CreateConnect",msg:"Nrcap2 connection already exist."});
	                if(typeof connParam.callbackFun == "function")
	                {
	                    connParam.callbackFun(Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_ALREADY,conn.connectId);  
	                }
                    return conn.connectId;
                }
            }
            
            /* 理论上是可能重复的 */
            var connectId = new Date().getTime()+""+parseInt(Math.random()*(9999-1000+1)+1000);
            
            if (Nrcap2.Connections.get(connectId) != null)
            {
                Nrcap2.Debug.Write({fn:"Nrcap2.CreateConnect",msg:"Nrcap2 connectId already exist."});
                            
                /* 新建connectId已经存在,不可创建 */
                if(typeof connParam.callbackFun == "function")
                {
                    connParam.callbackFun(Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_ALREADY,conn.connectId);  
                }
                return conn.connectId;
            } 
            
            var conn = new Nrcap2.Struct.ConnectionStruct(connectId,connParam,autoConnect);
            Nrcap2.Debug.Write({fn:"Nrcap2.CreateConnect",msg:"Nrcap2 create connection success."});
            Nrcap2.Connections.set(connectId,conn);  
            
			// 是否自动连接站点
			if(conn.autoConnect)
			{
			    Nrcap2.Open(connectId,connParam);
			}
			
			return connectId;
        }
        catch(e)
        {
			Nrcap2.Debug.Write({fn:"Nrcap2.CreateConnect",msg:e.message});
            return Nrcap2.NrcapError.NRCAP_ERROR_INIT_CONNECTION_FAILED;
        }
    },
    
    /*
     *	函数名		：Open
     *	函数功能	：连接站点  
     *	备注		：连接是异步发生,通过回调函数返回连接结果
     *	作者		：Lingsen
     *	时间		：2010年04月09日  
     *	返回值		：对应NrcapError
     *	参数说明	：2个参数 
     *	    object  connectId                        连接对象ID
     *	    NrcapConnectParams  connParam            连接参数
     */
    Open:function(connectId,connParam)
    {
        if (typeof connParam == "undefined" || connParam instanceof Nrcap2.Struct.ConnParamStruct != true)
        {
            connParam = new Nrcap2.Struct.ConnParamStruct();
        }
        try
        {
            if (!Nrcap2.Plug.inited || Nrcap2.Plug.nc == null)
            {
                Nrcap2.Debug.Write({fn:"Nrcap2.Open",msg:"plugs init failed."});
                Nrcap2.Connections.get(connectId).connParam.callbackFun(Nrcap2.NrcapError.NRCAP_ERROR_INIT_NRCAPPLUG_FAILED,connectId);
                return Nrcap2.NrcapError.NRCAP_ERROR_INIT_NRCAPPLUG_FAILED;
            }
        	
            if (typeof connectId == "undefined" || connectId == "")
            {
                connectId = this.CreateConnect(connParam,true);
                Nrcap2.Debug.Write({fn:"Nrcap2.Open",msg:"create connection,connectId="+connectId+"."});
                if (connectId == this.NrcapError.NRCAP_ERROR_INIT_CONNECTION_FAILED || connectId == this.NrcapError.NRCAP_ERROR_CONNECTION_PARAMS_FAILED)
                {
                    return connectId;
                }
            }
            if (!Nrcap2.Connections.get(connectId))
            {
                Nrcap2.Debug.Write({fn:"Nrcap2.Open",msg:"connection no exist."});
                Nrcap2.Connections.get(connectId).connParam.callbackFun(Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED,connectId);
                return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
            }
            //connParam.host,connParam.userId, connParam.pwd,connParam.epId,connParam.areaCode,connParam.clientType,connParam.userCustomData,connParam.bFixCUIAddress
            
			var connParams = Nrcap2.Connections.get(connectId).connParam;
			
			
            Nrcap2.Debug.Write({fn:"Nrcap2.Open",msg:"connect params,path="+connParams.path+",username="+connParams.username+",password="+connParams.password+",epId="+connParams.epId + ",bFixCUIAddress=" + connParams.bFixCUIAddress});
            
			var bFixCUIAddress = (connParams.bFixCUIAddress != null && typeof connParams.bFixCUIAddress != "undefined" && connParams.bFixCUIAddress == 1 ? 1 : 0);
			 
		    /* 开始连接 */
            rv = Nrcap2.Connections.get(connectId).nc.OpenNB(connParams.path, connParams.username, connParams.password, connParams.epId,  connParams.areaCode, connParams.clientType, connParams.userCustomData, bFixCUIAddress);
             
	        if (rv.split("#")[0] != 0x0000)
	        {
                Nrcap2.Debug.Write({fn:"Nrcap2.Open",msg:"connect failed,code="+rv.split("#")[0]+",description="+Nrcap2.NrcapError.ShowMessage(rv.split("#")[0])});
                connParams.callbackFun(Nrcap2.NrcapError.NRCAP_ERROR_OPEN_CONNECT_FAILED,connectId);
		        return Nrcap2.NrcapError.NRCAP_ERROR_OPEN_CONNECT_FAILED;
	        }
			Nrcap2.Connections.get(connectId).session = parseInt(rv.split("#")[1]);
            Nrcap2.Connections.get(connectId).connectStatus = "connecting";
			
			// Nrcap2.Debug.Write({fn:"Nrcap2.Open",msg:Object.toJSON(Nrcap2.Connections.get(connectId).connParam)});
			// Nrcap2.Debug.Write({fn:"Nrcap2.Open",msg:Object.toJSON(connParam)});
			 
            Nrcap2.Connections.get(connectId).connParam = connParam;
            Nrcap2.Debug.Write({fn:"Nrcap2.Open",msg:"connecting to server "});
            
			Nrcap2.Timer.Set("OpenNB",{name:"Open_callback",fu:function(){Nrcap2.Open_callback(connectId);},interval:100});
			// alert(Object.toJSON(Nrcap2.Connections));
            return Nrcap2.NrcapError.NRCAP_SUCCESS;
        }
        catch(e)
        {
            Nrcap2.Debug.Write({fn:"Nrcap2.Open",msg:"exception,error="+e.name+","+e.message});
            connParam.callbackFun(Nrcap2.NrcapError.NRCAP_ERROR_UNKNOW_EXCEPTION,connectId);
        }
    },
    
    /*
	*	函数名   ：Open_callback
	*	函数功能	：异步连接站点完成后处理方法
	*	备注		：  
	*	作者		：Lingsen
	*	时间		：2010年04月09日  
	*	返回值   ：对应NrcapError
	*	参数说明	：2个参数  
	*	        object  connectId  连接对象ID
	*/
    Open_callback:function(connectId)
    {
        var queryrv = Nrcap2.Connections.get(connectId).nc.GetOpenStatus(); // alert(queryrv);
        if (parseInt(queryrv).toString(16) == 0x00000000)
        {
			Nrcap2.Timer.UnSet("OpenNB","Open_callback");
            // 先找connectId是否正确
            if(Nrcap2.Connections.get(connectId) != null)
            {
                Nrcap2.Debug.Write({fn:"Nrcap2.Open_callback",msg:"connect success"});
			    // 1. 连接成功
			    Nrcap2.Connections.get(connectId).connectStatus = "connected";
			
				var requestParamStr = "<Msg Name=\"CUCustomMsgReq\"><Cmd Type=\"CTL\" OptID=\"CTL_CUI_QueryDomainRoad\" /></Msg>";
			    
			    //requestParamStr = Nrcap2.Connections.get(connectId).nc.GbktoUtf8(requestParamStr); 
			    
				// 获取系统名称				
				var rvstr = Nrcap2.Connections.get(connectId).nc.SendRequest(5,"",requestParamStr);  // alert(rvstr); 
				
				//rvstr = Nrcap2.Connections.get(connectId).nc.Utf8toGbk(rvstr);   // alert(rvstr); 
				
				var rvSplitIndex = rvstr.indexOf("#");  
				if(rvSplitIndex > -1)
				{
					var rvstr = rvstr.substr(rvSplitIndex+1);   
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
						    Nrcap2.Debug.Write({fn:"Nrcap2.Open_callback",msg:"SendRequest(CTL_CUI_QueryDomainRoad) XML ObjTree load error!"});
						}
						else
						{
						    try
						    {
							    var jsonResource = xmlObj.parseXML(rvstr);    //alert(Object.toJSON(jsonResource));
							    if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCustomMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DomainRoadSets && jsonResource.Msg.Cmd.DomainRoadSets.SystemName)
							    {
								    Nrcap2.Connections.get(connectId).systemName = jsonResource.Msg.Cmd.DomainRoadSets.SystemName;
							    }
							    else
							    { 
						            Nrcap2.Debug.Write({fn:"Nrcap2.Open_callback",msg:"SendRequest(CTL_CUI_QueryDomainRoad) Msg Name ro Cmd OptID error"});
							    }
							}
							catch(e)
							{
			                    Nrcap2.Debug.Write({fn:"Nrcap2.Open_callback",msg:"get system name exception"});
							}
						}
					}
							
				}
			    // 2. 开始获取资源  
			    // var rv = Nrcap2.FetchResource(connectId);
			    //if (rv == Nrcap2.NrcapError.NRCAP_SUCCESS)
			    //{
			    //}
			    // 3. 如果有回调函数,调用回调
			    if(typeof Nrcap2.Connections.get(connectId).connParam.callbackFun == "function")
			    {
			        Nrcap2.Connections.get(connectId).connParam.callbackFun(Nrcap2.NrcapError.NRCAP_SUCCESS,connectId);  
			    }  
			    return Nrcap2.NrcapError.NRCAP_SUCCESS;
            }
            else
            {			    
			    // 3. 如果有回调函数,调用回调
			    if(typeof Nrcap2.Connections.get(connectId).connParam.callbackFun == "function")
			    {
			        Nrcap2.Connections.get(connectId).connParam.callbackFun(Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED,connectId);
			    } 
			    Nrcap2.Debug.Write({fn:"Nrcap2.Open_callback",msg:"connect no exists"});
                return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
            }
            
        }
		else if(parseInt(queryrv).toString(16) == 0x00000001)
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.Open_callback",msg:"connect id="+connectId+",query connect stauts"});
			return;
		}
		else 
		{ 
			// Nrcap2.Connections.get(connectId).session = null;
			Nrcap2.Timer.UnSet("OpenNB","Open_callback");
			Nrcap2.Debug.Write({fn:"Nrcap2.Open_callback",msg:Nrcap2.NrcapError.ShowMessage(queryrv)});
		    // 3. 如果有回调函数,调用回调
		    if(typeof Nrcap2.Connections.get(connectId).connParam.callbackFun == "function")
		    {
		        Nrcap2.Connections.get(connectId).connParam.callbackFun(queryrv.split("#")[0],connectId);
		    }
		    return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
		}
    },
    
    /*
	*	函数名		：DisConnection
	*	函数功能	：删除一个连接对象.  
	*	作者		：Lingsen.
	*	时间		：2010年11月26日 .
	*	返回值		：对应NrcapError.
	*	参数说明	：1个参数 
	*	        object  connectId           连接对象ID
	*/
    DisConnection:function(connectId)
    {
        if (!Nrcap2.Plug.inited)
        {                
            return Nrcap2.NrcapError.NRCAP_ERROR_INIT_NRCAPPLUG_FAILED; 
        }
        
	    if(Nrcap2.Connections.get(connectId) != null)
		{ 
			if(Nrcap2.Connections.get(connectId).session != null)
			{ 
				// 删除这个连接的窗口和视频            
				Nrcap2.DiscardWindowsByConnectID(connectId);
				Nrcap2.Connections.get(connectId).nc.Close();
			}
			var rv = Nrcap2.Connections.unset(connectId);
			if(rv != null)
			{
				return Nrcap2.NrcapError.NRCAP_SUCCESS;
			}
			else
			{
				return Nrcap2.NrcapError.NRCAP_ERROR_DISCONNECTION_FAILED;
			} 
		}
		else  
		{
			return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
		}
		
       /* if (Nrcap2.Connections.get(connectId) != null && Nrcap2.Connections.get(connectId).session != null)
        {
            // 删除这个连接的窗口和视频            
            Nrcap2.DiscardWindowsByConnectID(connectId);
            Nrcap2.Connections.get(connectId).nc.Close();
            var rv = Nrcap2.Connections.unset(connectId);
            if (rv != null)
            {
                return Nrcap2.NrcapError.NRCAP_SUCCESS;
            }
            else
            {
                return Nrcap2.NrcapError.NRCAP_ERROR_DISCONNECTION_FAILED;
            }
        }
        else
        {
            return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
        }*/
    },
    /*
     *	函数名		：FetchResource
     *	函数功能	：创建PU资源对象.
     *	备注		：  
     *	作者		：Lingsen
     *	时间		：2010年04月13日   
     *	返回值		：成功返回NRCAP_SUCCESS
     *	参数说明	：1个参数 
     *	        string  connectId           连接id
     */
	FetchResource:function(connectId,fetchResLevel,offset,count,domainRoad,customParams)
	{
	    if(typeof fetchResLevel == "undefined")
	    {
	        return [];
	    }
	    var re = new RegExp(Nrcap2.Utility.Regexs.uint);
	    
	    if (typeof offset == "undefined" || !re.test(offset))
	    {
	        offset = 0;
	    }
	    if (typeof count == "undefined" || !re.test(count))
	    {
	        count = 0;
	    }
		if(typeof domainRoad == "undefined")
		{
			return [];
		}
	    if(fetchResLevel == Nrcap2.Enum.FetchResourceLevel.Nrcap2_GetPUInfo)
	    {
		    var requestParamStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Msg Name=\"CUCustomMsgReq\"><Cmd Type=\"CTL\" OptID=\""+Nrcap2.Enum.OperationID.CTL_CUI_QueryPUIDSets+"\"><PUIDSets DomainRoad=\""+domainRoad+"\" Offset=\""+offset+"\" Count=\""+count+"\" /></Cmd></Msg>";
		   //requestParamStr = Nrcap2.Connections.get(connectId).nc.GbktoUtf8(requestParamStr);
		    // alert(requestParamStr);
		    var rvstr = Nrcap2.Connections.get(connectId).nc.SendRequest(Nrcap2.Enum.RouteIDType.CUI,"",requestParamStr); // alert(rvstr);
		    
		    //rvstr = Nrcap2.Connections.get(connectId).nc.Utf8toGbk(rvstr);  //alert(rvstr);
			
		    var rvSplitIndex = rvstr.indexOf("#");
		    if(rvSplitIndex > -1)
		    {
			    var rvstr = rvstr.substr(rvSplitIndex+1); //alert(rvstr);
			    if(rvstr.length > 0)
			    {
				    var xmlObj = new XML.ObjTree();
				    if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
				    {
			            Nrcap2.Debug.Write({fn:"Nrcap2.FetchResource",msg:"fetch pu info error,XML ObjTree load error!"});
					    return [];
				    }
				    var jsonResource = xmlObj.parseXML(rvstr);
				    if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCustomMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.OptID ==Nrcap2.Enum.OperationID.CTL_CUI_QueryPUIDSets)
				    {
	                    var puinfo = new Array();	
						try
						{
							if(typeof jsonResource.Msg.Cmd.PUIDSets.PUID == "object" && jsonResource.Msg.Cmd.PUIDSets.PUID.constructor == Array)
							{  
								for(var i = 0;i < jsonResource.Msg.Cmd.PUIDSets.PUID.length;i++)
								{
									var pu = jsonResource.Msg.Cmd.PUIDSets.PUID[i];
									// alert(Object.toJSON(pu));
									puinfo.push(new Nrcap2.Struct.PUNodeStruct(pu["#text"],pu.Name,pu.Description,pu.ModelName,pu.ModelType,pu.ManufactureID,pu.HardwareVersion,pu.SoftwareVersion,pu.DeviceID,pu.ResType,pu.Enable,pu.Online));
								}
							}
							else if(typeof jsonResource.Msg.Cmd.PUIDSets.PUID == "object" && jsonResource.Msg.Cmd.PUIDSets.PUID.constructor != Array)
							{
								var pu = jsonResource.Msg.Cmd.PUIDSets.PUID;
								puinfo.push(new Nrcap2.Struct.PUNodeStruct(pu["#text"],pu.Name,pu.Description,pu.ModelName,pu.ModelType,pu.ManufactureID,pu.HardwareVersion,pu.SoftwareVersion,pu.DeviceID,pu.ResType,pu.Enable,pu.Online));
							}
						}
						catch(e)
						{
							return puinfo;
							Nrcap2.Debug.Write({fn:"Nrcap2.FetchResource",msg:"fetch no pu info! return null array!"});
						}
					    
	                    return puinfo;
				    }
				    else
				    {
			            Nrcap2.Debug.Write({fn:"Nrcap2.FetchResource",msg:"fetch pu info error,Msg Name ro Cmd OptID error"});
					    return [];
				    }
			    }
		    }
	    }
	    else if (fetchResLevel == Nrcap2.Enum.FetchResourceLevel.Nrcap2_GetPUResourceInfo)
	    {
	        if (typeof customParams == "undefined")
	        {
			    Nrcap2.Debug.Write({fn:"Nrcap2.FetchResource",msg:"fetch pu resource info error,custom params undefined."});
	            return [];
	        }
			
			// var rep = new RegExp(Nrcap2.Utility.Regexs.puid); 
	        var rep = new RegExp(Nrcap2.puidRex);
			 if (typeof customParams.PUID == "undefined" || !rep.test(customParams.PUID))
			//if (typeof customParams.PUID == "undefined" || !customParams.PUID)
	        { 
			    Nrcap2.Debug.Write({fn:"Nrcap2.FetchResource",msg:"fetch pu resource info error,puid undefined."});
	            return [];
	        }
			
			var requestParamStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Msg Name=\"CUCustomMsgReq\"><Cmd Type=\"CTL\" OptID=\""+Nrcap2.Enum.OperationID.CTL_CUI_QueryPUIDRes+"\"><PUID>"+customParams.PUID+"</PUID></Cmd></Msg>";
	
	        // 获取PU的描述信息 
			var rvstr = Nrcap2.Connections.get(connectId).nc.SendRequest(Nrcap2.Enum.RouteIDType.CUI,"",requestParamStr);
			Nrcap2.Debug.Write({fn:"Nrcap2.FetchResource",msg:"fetch pu resourceinfo ,rv="+rvstr});
			var rvSplitIndex = rvstr.indexOf("#"); 
			if(rvSplitIndex > -1)
			{
				var rvstr = rvstr.substr(rvSplitIndex+1); 
				if(rvstr.length > 0)
				{
					var xmlObj = new XML.ObjTree();
					if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
					{
			            Nrcap2.Debug.Write({fn:"Nrcap2.FetchResource",msg:"fetch pu resourceinfo ,XML ObjTree load error."});
						return [];
					}
					var jsonResource = xmlObj.parseXML(rvstr);  //alert(Object.toJSON(jsonResource));
					if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCustomMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.OptID == Nrcap2.Enum.OperationID.CTL_CUI_QueryPUIDRes && jsonResource.Msg.Cmd.PUID && jsonResource.Msg.Cmd.PUID.Res)
					{
	                    var puResourceInfos = new Array();	
					    if(typeof jsonResource.Msg.Cmd.PUID.Res == "object" && jsonResource.Msg.Cmd.PUID.Res.constructor == Array)
					    {
	                        for(var i = 0;i < jsonResource.Msg.Cmd.PUID.Res.length;i++)
	                        {
	                            var pures = jsonResource.Msg.Cmd.PUID.Res[i];
	                            puResourceInfos.push(new Nrcap2.Struct.PUResourceNodeStruct(pures.Type,pures.Idx,pures.Name,pures.Description,pures.Enable));
	                        }
					    }
					    else if(typeof jsonResource.Msg.Cmd.PUID.Res == "object" && jsonResource.Msg.Cmd.PUID.Res.constructor != Array)
					    {
	                        var pures = jsonResource.Msg.Cmd.PUID.Res;
	                        puResourceInfos.push(new Nrcap2.Struct.PUResourceNodeStruct(pures.Type,pures.Idx,pures.Name,pures.Description,pures.Enable));
					    }
						return puResourceInfos;
					}
					else
					{
			            Nrcap2.Debug.Write({fn:"Nrcap2.FetchResource",msg:"fetch pu resourceinfo ,Msg Name ro Cmd OptID error."});
					}
				}
			}
	    }
	    return [];
	},
    
	/**2011.03.10*********************************************************************************************************/
	 /*
     *	函数名		：GetLogicGroups
     *	函数功能	：获取逻辑分组
     *	备注		：












































     *	作者		：Lingsen
     *	时间		：2010年04月13日











































     *	返回值		：成功返回NRCAP_SUCCESS
     *	        string  connectId           连接id
     */
	GetLogicGroups:function(connectId)
	{
		var requestParamStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Msg Name=\"CUCustomMsgReq\"><Cmd Type=\"CTL\" OptID=\"CTL_CUI_QueryLogicGroupInfo\" /></Msg>";
		
   		//requestParamStr = Nrcap2.Connections.get(connectId).nc.GbktoUtf8(requestParamStr);  
	        
        var rvstr = Nrcap2.Connections.get(connectId).nc.SendRequest(5,"",requestParamStr);  // alert(rvstr);

		//rvstr = Nrcap2.Connections.get(connectId).nc.Utf8toGbk(rvstr); //alert(rvstr); 
		
		var rvSplitIndex = rvstr.indexOf("#");  
		if(rvSplitIndex > -1)
		{
			var rvstr = rvstr.substr(rvSplitIndex+1);   
			if(rvstr.length > 0)
			{
				var xmlObj = new XML.ObjTree();
				if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.GetLogicGroups",msg:"XML ObjTree load error!"});
					return [];
				}
				
				var jsonResource = xmlObj.parseXML(rvstr);	 //alert(Object.toJSON(jsonResource));
				//  
				if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCustomMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.OptID == "CTL_CUI_QueryLogicGroupInfo")
				{
					var logicGroups = new Array();
					if(typeof jsonResource.Msg.Cmd.LogicGroup == "object" && jsonResource.Msg.Cmd.LogicGroup.constructor == Array)
					{
						//return jsonResource.Msg.Cmd.LogicGroup;
						var lgcs = jsonResource.Msg.Cmd.LogicGroup;
						for(var i = 0; i < lgcs.length;i++ )
						{
							var lgc = lgcs[i]; 
							logicGroups.push(new Nrcap2.Struct.LogicGroupStruct(lgc.Index,lgc.Name,lgc.LastRefreshTime,lgc.RefreshInterval)); 
						} 
					}
					else if(typeof jsonResource.Msg.Cmd.LogicGroup == "object" && jsonResource.Msg.Cmd.LogicGroup.constructor != Array)
					{
						//return [jsonResource.Msg.Cmd.LogicGroup];
						var lgc = jsonResource.Msg.Cmd.LogicGroup;
						logicGroups.push(new Nrcap2.Struct.LogicGroupStruct(lgc.Index,lgc.Name,lgc.LastRefreshTime,lgc.RefreshInterval)); 
					}
					else
					{
						return [];
					}
					
					return logicGroups.uniq();
				}
				else
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.GetLogicGroups",msg:"Msg Name ro Cmd OptID error!"});
					return [];
				}
			}
		}
	},
    
    /*
     *	函数名		：GetLogicGroupNodes
     *	函数功能	：获取逻辑分组子节点  
     *	备注		： 
     *	作者		：Lingsen
     *	时间		：2010年04月13日 
     *	返回值		：成功返回NRCAP_SUCCESS
     *	参数说明	：5个参数 
     *	        string  connectId           连接id
     *	        string  logicGroupIndex     逻辑分组索引
     *	        string  logicGroupNodeIndex     父节点索引 
     *	        string  offset           	分页起始位 
     *	        string  count           	单页数  
     */
	GetLogicGroupNodes:function(connectId,logicGroupIndex,logicGroupNodeIndex,offset,count)
	{
		if(!Nrcap2.intRex.test(logicGroupIndex))
		{ 
			Nrcap2.Debug.Write({fn:"Nrcap2.GetLogicGroupNodes",msg:"logicGroupIndex not is number!"});
			return [];
		}
		
		if(!Nrcap2.intRex.test(logicGroupNodeIndex))
		{
			logicGroupNodeIndex = 0;
		}
		
		if(!Nrcap2.intRex.test(offset))
		{
			offset = 0;
		}
		
		if(!Nrcap2.intRex.test(count) || parseInt(count) < 0)
		{
			count = 4294967295;
		}
		//return [];
		var requestParamStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Msg Name=\"CUCustomMsgReq\"><Cmd Type=\"CTL\" OptID=\"CTL_CUI_QueryLogicGroupNode\"><LogicGroup Index=\""+logicGroupIndex+"\" NodeIndex=\""+logicGroupNodeIndex+"\" Offset=\""+offset+"\" Count=\""+count+"\" /></Cmd></Msg>"; 
		
		//requestParamStr = Nrcap2.Connections.get(connectId).nc.GbktoUtf8(requestParamStr);  
	        
        var rvstr = Nrcap2.Connections.get(connectId).nc.SendRequest(5,"",requestParamStr); // alert(rvstr);

		//rvstr = Nrcap2.Connections.get(connectId).nc.Utf8toGbk(rvstr); //alert(rvstr); 

		var rvSplitIndex = rvstr.indexOf("#");
		if(rvSplitIndex > -1)
		{
			var rvstr = rvstr.substr(rvSplitIndex+1);
			if(rvstr.length > 0)
			{
				var xmlObj = new XML.ObjTree();
				if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.GetLogicGroupNodes",msg:"XML ObjTree load error!"});
					return [];
				}
				
				var jsonResource = xmlObj.parseXML(rvstr);  //alert(Object.toJSON(jsonResource));
				//  
				if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCustomMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.OptID == "CTL_CUI_QueryLogicGroupNode")
				{
					var logicGroupNodes = new Array();
					if(typeof jsonResource.Msg.Cmd.Node == "object" && jsonResource.Msg.Cmd.Node.constructor == Array)
					{
						//return jsonResource.Msg.Cmd.Node;
						var lgns = jsonResource.Msg.Cmd.Node;
						for(var i = 0; i < lgns.length;i++ )
						{
							var lgn = lgns[i]; 
							logicGroupNodes.push(new Nrcap2.Struct.LogicGroupNodeStruct(lgn.Index,lgn.Name,lgn.ParentNode_Index)); 
						} 
					}
					else if(typeof jsonResource.Msg.Cmd.Node == "object" && jsonResource.Msg.Cmd.Node.constructor != Array)
					{
						//return [jsonResource.Msg.Cmd.Node];
						var lgn = jsonResource.Msg.Cmd.Node;
						logicGroupNodes.push(new Nrcap2.Struct.LogicGroupNodeStruct(lgn.Index,lgn.Name,lgn.ParentNode_Index)); 
					}
					else
					{
						return [];
					}
					
					return logicGroupNodes.uniq();
				}
				else
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.GetLogicGroupNodes",msg:"Msg Name ro Cmd OptID error!"});
					return [];
				}
			}
		}
	},
    
    /*
     *	函数名		：GetLogicGroupResource
     *	函数功能	：获取逻辑分组节点下的资源
     *	备注		： 
     *	作者		：Lingsen
     *	时间		：2010年04月13日  
     *	返回值		：成功返回NRCAP_SUCCESS
     *	参数说明	：5个参数 
     *	        string  connectId           连接id
     *	        string  logicGroupIndex         逻辑分组索引
     *	        string  logicGroupNodeIndex     逻辑分组节点索引
     *	        string  offset           		分页起始位 
     *	        string  count           		单页数 
     */
	GetLogicGroupResource:function(connectId,logicGroupIndex,logicGroupNodeIndex,offset,count)
	{
		if(!Nrcap2.intRex.test(logicGroupIndex))
		{ 
			Nrcap2.Debug.Write({fn:"Nrcap2.GetLogicGroupResource",msg:"logicGroupIndex not is number!"});
			return [];
		}
		
		if(!Nrcap2.intRex.test(logicGroupNodeIndex))
		{
			logicGroupNodeIndex = 0;
		}
		
		if(!Nrcap2.intRex.test(offset))
		{
			offset = 0;
		}
		
		if(!Nrcap2.intRex.test(count) || parseInt(count) < 0)
		{
			count = 4294967295;
		}
		
		var requestParamStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Msg Name=\"CUCustomMsgReq\"><Cmd Type=\"CTL\" OptID=\"CTL_CUI_QueryLogicGroupResource\"><LogicGroup Index=\""+logicGroupIndex+"\" NodeIndex=\""+logicGroupNodeIndex+"\" Offset=\""+offset+"\" Count=\""+count+"\" /></Cmd></Msg>";
		
		//requestParamStr = Nrcap2.Connections.get(connectId).nc.GbktoUtf8(requestParamStr);  
	        
       	var rvstr = Nrcap2.Connections.get(connectId).nc.SendRequest(5,"",requestParamStr); // alert(rvstr);

		//rvstr = Nrcap2.Connections.get(connectId).nc.Utf8toGbk(rvstr);  //alert(rvstr); 
		
		var rvSplitIndex = rvstr.indexOf("#");
		if(rvSplitIndex > -1)
		{
			var rvstr = rvstr.substr(rvSplitIndex+1);
			if(rvstr.length > 0)
			{
				var xmlObj = new XML.ObjTree();
				if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.GetLogicGroupResource",msg:"XML ObjTree load error!"});
					return [];
				}
				
				var jsonResource = xmlObj.parseXML(rvstr);  //alert(Object.toJSON(jsonResource));
				//  
				if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCustomMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.OptID == "CTL_CUI_QueryLogicGroupResource")
				{
					var logicGroupResource = new Array();
					if(typeof jsonResource.Msg.Cmd.Res == "object" && jsonResource.Msg.Cmd.Res.constructor == Array)
					{
						//return jsonResource.Msg.Cmd.Res;
						var lgrs = jsonResource.Msg.Cmd.Res;
						for(var i = 0; i < lgrs.length;i++ )
						{
							var lgr = lgrs[i]; 
							logicGroupResource.push(new Nrcap2.Struct.LogicGroupResourceStruct(lgr.PUID,lgr.Type,lgr.Idx,lgr.Name,lgr.Description,lgr.Enable,lgr.ParentNode_Index));
						}
					}
					else if(typeof jsonResource.Msg.Cmd.Res == "object" && jsonResource.Msg.Cmd.Res.constructor != Array)
					{
						//return [jsonResource.Msg.Cmd.Res];
						lgr = jsonResource.Msg.Cmd.Res;
						logicGroupResource.push(new Nrcap2.Struct.LogicGroupResourceStruct(lgr.PUID,lgr.Type,lgr.Idx,lgr.Name,lgr.Description,lgr.Enable,lgr.ParentNode_Index)); 
					}
					else
					{
						return [];
					}
					
					return logicGroupResource.uniq();
				} 
				else
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.GetLogicGroupResource",msg:"Msg Name ro Cmd OptID error!"});
					return [];
				}
			}
		}
	},
    /**2011.03.10*********************************************************************************************************/
	
	/* 2011.04.10*/    
    /*
     *	函数名		：FetchChildUser
     *	函数功能	：获取子用户信息
     *	备注		： 
     *	作者		：Lingsen
     *	时间		：2011年04月10日  
     *	返回值		：成功返回子用户信息数组,Array UserInfoStruct
     *	参数说明	：1个参数 
     *	        string  connectId           连接id
     */
	FetchChildUser:function(connectId)
	{
	    if(!Nrcap2.Connections.get(connectId))
	    { 
			Nrcap2.Debug.Write({fn:"Nrcap2.FetchChildUser",msg:"connectId is no extsis!"});
	        return Nrcap2.NRCAP_ERROR_CONNECTIONID_FAILED;
	    }
	    var currentUserIndex = -1;
		var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCustomMsgReq\"><Cmd Type=\"CTL\" OptID=\"CTL_CUI_QueryUserIndex\" /></Msg>";
       	var rvstr = Nrcap2.Connections.get(connectId).nc.SendRequest(5,"",requestParamStr);
       	
		var rvSplitIndex = rvstr.indexOf("#");
		if(rvSplitIndex > -1)
		{
			var rvstr = rvstr.substr(rvSplitIndex+1);
			if(rvstr.length > 0)
			{
				var xmlObj = new XML.ObjTree();
				if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.FetchChildUser",msg:"XML ObjTree load error!"});
					return [];
				}
				
				var jsonResource = xmlObj.parseXML(rvstr);
				
				if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCustomMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.OptID == "CTL_CUI_QueryUserIndex")
				{
					if(typeof jsonResource.Msg.Cmd.User == "object")
					{
					    currentUserIndex = jsonResource.Msg.Cmd.User.Index;
					}
				} 
				else
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.FetchChildUser",msg:"Msg Name ro Cmd OptID error!"});
					return [];
				}
			}
		}
		
		requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCustomMsgReq\"><Cmd Type=\"CTL\" OptID=\"CTL_CUI_QuerySubUser\"><User Index=\""+currentUserIndex+"\" Recursive=\"0\" /></Cmd></Msg>";
       	rvstr = Nrcap2.Connections.get(connectId).nc.SendRequest(5,"",requestParamStr);
		rvSplitIndex = rvstr.indexOf("#");
		if(rvSplitIndex > -1)
		{
			var rvstr = rvstr.substr(rvSplitIndex+1);
			if(rvstr.length > 0)
			{
				var xmlObj = new XML.ObjTree();
				if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.FetchChildUser",msg:"XML ObjTree load error!"});
					return [];
				}
				
				var jsonResource = xmlObj.parseXML(rvstr);
				
				if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCustomMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.OptID == "CTL_CUI_QuerySubUser")
				{
				    var tmp_users = new Array();
	                var users = new Array();	
					if(typeof jsonResource.Msg.Cmd.User == "object" && jsonResource.Msg.Cmd.User.constructor == Array)
					{
	                    for(var i = 0;i < jsonResource.Msg.Cmd.User.length;i++)
	                    {
	                        var u = jsonResource.Msg.Cmd.User[i];
	                        users.push(new Nrcap2.Struct.UserInfoStruct(u.Index,u.Identity,null,null,null,null,null,u.ParentUser_Index,null,null,null,null,null));
	                    }
					}
					else if(typeof jsonResource.Msg.Cmd.User == "object" && jsonResource.Msg.Cmd.User.constructor != Array)
					{
	                    var u = jsonResource.Msg.Cmd.User;
	                    users.push(new Nrcap2.Struct.UserInfoStruct(u.Index,u.Identity,null,null,null,null,null,u.ParentUser_Index,null,null,null,null,null));
					}
	                return users;
				} 
				else
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.FetchChildUser",msg:"Msg Name ro Cmd OptID error!"});
					return [];
				}
			}
		}
		return [];
	},
    
    /*
     *	函数名		：QueryUserIndex
     *	函数功能	：获取当前登录用户索引











































     *	备注		： 
     *	作者		：Lingsen
     *	时间		：2011年04月10日  
     *	返回值		：成功返回NRCAP_SUCCESS
     *	参数说明	：1个参数 
     *	        string  connectId           连接id
     */
	QueryUserIndex:function(connectId)
	{
	    if(!Nrcap2.Connections.get(connectId))
	    { 
			Nrcap2.Debug.Write({fn:"Nrcap2.QueryUserIndex",msg:"connectId is no extsis!"});
	        return Nrcap2.NRCAP_ERROR_CONNECTIONID_FAILED;
	    }
	    var currentUserIndex = -1;
		var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCustomMsgReq\"><Cmd Type=\"CTL\" OptID=\"CTL_CUI_QueryUserIndex\" /></Msg>";
       	var rvstr = Nrcap2.Connections.get(connectId).nc.SendRequest(5,"",requestParamStr); // alert(rvstr);
       	
		var rvSplitIndex = rvstr.indexOf("#");
		if(rvSplitIndex > -1)
		{
			var rvstr = rvstr.substr(rvSplitIndex+1);
			if(rvstr.length > 0)
			{
				var xmlObj = new XML.ObjTree();
				if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.QueryUserIndex",msg:"XML ObjTree load error!"});
					return currentUserIndex;
				}
				
				var jsonResource = xmlObj.parseXML(rvstr);
				
				if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCustomMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.OptID == "CTL_CUI_QueryUserIndex")
				{
					if(typeof jsonResource.Msg.Cmd.User == "object")
					{
					    currentUserIndex = jsonResource.Msg.Cmd.User.Index;
					}
				} 
				else
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.QueryUserIndex",msg:"Msg Name ro Cmd OptID error!"});
					return currentUserIndex;
				}
			}
		}
		return currentUserIndex;
	},
    
    /*
     *	函数名		：QueryUserIndex
     *	函数功能	：获取用户的详细信息
     *	备注		： 
     *	作者		：Lingsen
     *	时间		：2011年04月10日  
     *	返回值		：成功返回NRCAP_SUCCESS
     *	参数说明	：2个参数 
     *	        string  connectId           连接id
     *	        number  userIndex           用户索引
     */
	QueryUserInfo:function(connectId,userIndex)
	{
	    if(!Nrcap2.Connections.get(connectId))
	    { 
			Nrcap2.Debug.Write({fn:"Nrcap2.QueryUserInfo",msg:"connectId is no extsis!"});
	        return Nrcap2.NRCAP_ERROR_CONNECTIONID_FAILED;
	    }
	    
	    var re = new RegExp(Nrcap2.Utility.Regexs.uint);
	    
	    if(typeof userIndex == null || typeof userIndex == "undefined" || !re.test(userIndex))
	    { 
	        Nrcap2.Debug.Write({fn:"Nrcap2.QueryUserInfo",msg:"userIndex is null or no exists!"});
		    return false;
	    }
	    
		var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCustomMsgReq\"><Cmd Type=\"CTL\" OptID=\"CTL_CUI_QueryUserInfo\"><User Index=\""+userIndex+"\" /></Cmd></Msg>";
       	var rvstr = Nrcap2.Connections.get(connectId).nc.SendRequest(5,"",requestParamStr);  // alert(rvstr);
		var rvSplitIndex = rvstr.indexOf("#");
		if(rvSplitIndex > -1)
		{
			var rvstr = rvstr.substr(rvSplitIndex+1);
			if(rvstr.length > 0)
			{
				var xmlObj = new XML.ObjTree();
				if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.QueryUserInfo",msg:"XML ObjTree load error!"});
					return {};
				}
				
				var jsonResource = xmlObj.parseXML(rvstr);
				
				if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCustomMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.OptID == "CTL_CUI_QueryUserInfo")
				{
				    var u = jsonResource.Msg.Cmd.User;
				    return new Nrcap2.Struct.UserInfoStruct(userIndex,u.Identity,u.Active,u.Priority,u.MaxSessionNum,u.ActorType,u.Actor_Index,u.ParentUser_Index,u.AccreditedPassword,u.EnableWhiteList,u.Name,u.Phones,u.Description,u.Remark);  
				} 
				else
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.QueryUserInfo",msg:"Msg Name ro Cmd OptID error!"});
					return {};
				}
			}
		}
		return {};
	},
    
    /*
     *	函数名		：AddUserInfo
     *	函数功能	：添加用户 
     *	备注		： 
     *	作者		：Lingsen
     *	时间		：2011年04月10日  
     *	返回值		：成功返回NRCAP_SUCCESS
     *	参数说明	：2个参数 
     *	        string  connectId           连接id
     *	        Nrcap2.Struct.UserInfoStruct  userinfo           用户信息
     */
	AddUserInfo:function(connectId,userinfo)
	{
	    if(!Nrcap2.Connections.get(connectId))
	    { 
			Nrcap2.Debug.Write({fn:"Nrcap2.AddUserInfo",msg:"connectId is no extsis!"});
	        return false;
	    }
	    
		if(!userinfo instanceof Nrcap2.Struct.UserInfoStruct)
		{ 
			Nrcap2.Debug.Write({fn:"Nrcap2.AddUserInfo",msg:"userinfo struct error!"});
			return false;				
		} // alert(Object.toJSON(userinfo));
	    //var parentIndex = Nrcap2.QueryUserIndex(connectId);
	    var parentUserinfo = Nrcap2.QueryUserInfo(connectId,userinfo.parentUserIndex);
	    //userinfostr += " Index=\""+parentIndex+"\" Identity=\""+userinfo.identity+"\" Password=\""+userinfo.password+"\" Active=\"1\" Priority=\""+(parseInt(parentUserinfo.Priority)+1)+"\" MaxSessionNum=\""+userinfo.MaxSessionNum+"\" ActorType=\""+parentUserinfo.ActorType+"\" Actor_Index=\"2\"  Name=\""+(userinfo.name != null ? userinfo.name:"")+"\" Phones=\""+(userinfo.phones != null ? userinfo.phones:"")+"\" Description=\""+(userinfo.description != null ? userinfo.description:"")+"\" Remark=\""+(userinfo.remark != null? userinfo.remark:"")+"\" ";
	    
		if(!parentUserinfo instanceof Nrcap2.Struct.UserInfoStruct)
		{ 
			Nrcap2.Debug.Write({fn:"Nrcap2.AddUserInfo",msg:"parent user no exists!"});
			return false;				
		}
		
		if(parseInt(userinfo.priority) < parseInt(parentUserinfo.priority))
		{ 
			Nrcap2.Debug.Write({fn:"Nrcap2.AddUserInfo",msg:"priority can't than parent user high!"});
		    return false;
		}
		 
		if(userinfo.password == null || typeof userinfo.password == "undefined")
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.AddUserInfo",msg:"userinfo.password error!"});
			return false;	
		}
		
		var psw_md5 = MD5.Hex_MD5(userinfo.password); 
		
	    var userinfostr = " Index=\""+userinfo.parentUserIndex+"\" Identity=\""+userinfo.identity+"\" Password=\""+psw_md5+"\" Active=\""+userinfo.active+"\" Priority=\""+userinfo.priority+"\" MaxSessionNum=\""+userinfo.maxSessionNum+"\" ActorType=\""+parentUserinfo.actorType+"\" Actor_Index=\"2\"  Name=\""+(userinfo.name != null ? userinfo.name:"")+"\" Phones=\""+(userinfo.phones != null ? userinfo.phones:"")+"\" Description=\""+(userinfo.description != null ? userinfo.description:"")+"\" Remark=\""+(userinfo.remark != null? userinfo.remark:"")+"\" EnableWhiteList=\""+(userinfo.enableWhiteList != null ? userinfo.enableWhiteList:"0")+"\" ";
	    
		var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCustomMsgReq\"><Cmd Type=\"CTL\" OptID=\"CTL_CUI_AddUser\"><User "+userinfostr+" /></Cmd></Msg>"; // alert(requestParamStr);
       	var rvstr = Nrcap2.Connections.get(connectId).nc.SendRequest(5,"",requestParamStr); // alert(rvstr);
		var rvSplitIndex = rvstr.indexOf("#");
		if(rvSplitIndex > -1)
		{
			var rvstr = rvstr.substr(rvSplitIndex+1);
			if(rvstr.length > 0)
			{
				var xmlObj = new XML.ObjTree();
				if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.AddUserInfo",msg:"XML ObjTree load error!"});
					return false;
				}
				
				var jsonResource = xmlObj.parseXML(rvstr);
				
				if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCustomMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.OptID == "CTL_CUI_AddUser")
				{
				    return jsonResource.Msg.Cmd.NUErrorCode == "0" ? true : jsonResource.Msg.Cmd.NUErrorCode;
				} 
				else
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.AddUserInfo",msg:"Msg Name ro Cmd OptID error!"});
					return false;
				}
			}
		}
		return false;
	},
    
    /*
     *	函数名		：UpdateUserInfo
     *	函数功能	：更新用户信息 
     *	备注		： 
     *	作者		：Lingsen
     *	时间		：2011年04月10日  
     *	返回值		：成功返回NRCAP_SUCCESS
     *	参数说明	：2个参数 
     *	        string                            connectId           连接id
     *	        Nrcap.Struct.UserInfoStruct       userinfo            用户信息
     */
	UpdateUserInfo:function(connectId,userinfo)
	{
	    if(!Nrcap2.Connections.get(connectId))
	    {
			Nrcap2.Debug.Write({fn:"Nrcap2.UpdateUserInfo",msg:"connectId is no extsis!"});
	        return false;
	    }
	    
	    var userinfostr = "";
	    
	    var re=new RegExp(Nrcap2.Utility.Regexs.uint);
	    
	    if(typeof userinfo != "object" || typeof userinfo.index == "undefined")
	    { 
			Nrcap2.Debug.Write({fn:"Nrcap2.UpdateUserInfo",msg:"userindex is null!"});
	        return false;
	    }
	    userinfostr += " Index=\""+userinfo.index+"\" ";

	    if(typeof userinfo.password != "undefined" && Nrcap2.Utility.CheckByteLength(userinfo.password,0,32) == true )
	    {
			if(userinfo.password == null)
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.AddUserInfo",msg:"userinfo.password error!"});
				return false;	
			}
			
			var psw_md5 = MD5.Hex_MD5(userinfo.password); 
			
	        userinfostr += " Password=\""+psw_md5+"\" "; // alert(userinfostr);
	    }
	    
	    if(typeof userinfo.active != "undefined" && re.test(userinfo.active) && userinfo.active == 1 || userinfo.active == 0)
	    {
	        userinfostr += " Active=\""+userinfo.active+"\" ";
	    }
	    
	    if(typeof userinfo.priority != "undefined" && re.test(userinfo.priority))
	    {
	        userinfostr += " Priority=\""+userinfo.priority+"\" ";
	    }
	    
	    if(typeof userinfo.maxSessionNum != "undefined" && re.test(userinfo.maxSessionNum))
	    {
	        userinfostr += " MaxSessionNum=\""+userinfo.maxSessionNum+"\" ";
	    }
	    
	    if(typeof userinfo.name != "undefined" && Nrcap2.Utility.CheckByteLength(userinfo.name,0,32) == true)
	    {
	        userinfostr += " Name=\""+userinfo.name+"\" ";
	    }
	    
	    if(typeof userinfo.phones != "undefined" && Nrcap2.Utility.CheckByteLength(userinfo.phones,0,128) == true)
	    {
	        userinfostr += " Phones=\""+userinfo.phones+"\" ";
	    }
	    
	    if(typeof userinfo.description != "undefined"  && Nrcap2.Utility.CheckByteLength(userinfo.description,0,256) == true)
	    {
	        userinfostr += " Description=\""+userinfo.description+"\" ";
	    }
	    
	    if(typeof userinfo.remark != "undefined" && Nrcap2.Utility.CheckByteLength(userinfo.remark,0,4096) == true)
	    {
	        userinfostr += " Remark=\""+userinfo.remark+"\" ";
	    }
	    
		var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCustomMsgReq\"><Cmd Type=\"CTL\" OptID=\"CTL_CUI_UpdateUser\"><User "+userinfostr+" /></Cmd></Msg>"; // alert(requestParamStr);return;
       	var rvstr = Nrcap2.Connections.get(connectId).nc.SendRequest(5,"",requestParamStr); // alert(rvstr);
		var rvSplitIndex = rvstr.indexOf("#");
		if(rvSplitIndex > -1)
		{
			var rvstr = rvstr.substr(rvSplitIndex+1);
			if(rvstr.length > 0)
			{
				var xmlObj = new XML.ObjTree();
				if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.UpdateUserInfo",msg:"XML ObjTree load error!"});
					return false;
				}
				
				var jsonResource = xmlObj.parseXML(rvstr);
				
				if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCustomMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.OptID == "CTL_CUI_UpdateUser")
				{
				    return jsonResource.Msg.Cmd.NUErrorCode == "0" ? true : jsonResource.Msg.Cmd.NUErrorCode;
				} 
				else
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.UpdateUserInfo",msg:"Msg Name ro Cmd OptID error!"});
					return false;
				}
			}
		}
		return false;
	},
    
    /*
     *	函数名		：QueryUserResource
     *	函数功能	：获取用户的资源
     *	备注		： 
     *	作者		：Lingsen
     *	时间		：2011年04月10日  
     *	返回值		：成功返回NRCAP_SUCCESS
     *	参数说明	：2个参数 
     *	        string                      connectId           连接id
     *	        number                      userIndex           用户索引
     */
	QueryUserResource:function(connectId,userIndex)
	{
	    var allocatedResource = new Array();
	    if(!Nrcap2.Connections.get(connectId))
	    { 
			Nrcap2.Debug.Write({fn:"Nrcap2.QueryUserResource",msg:"connectId is no extsis!"});
	        return allocatedResource;
	    }
	    
	    var re=new RegExp(Nrcap2.Utility.Regexs.uint);
	    
	    if(typeof userIndex == "undefined" || !re.test(userIndex) )
	    { 
			Nrcap2.Debug.Write({fn:"Nrcap2.QueryUserResource",msg:"userIndex no extsis!"});
	        return allocatedResource;
	    }
		var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCustomMsgReq\"><Cmd Type=\"CTL\" OptID=\"CTL_CUI_QueryUserResource\"><User Index=\""+userIndex+"\" /></Cmd></Msg>";
       	var rvstr = Nrcap2.Connections.get(connectId).nc.SendRequest(5,"",requestParamStr);
       	
		var rvSplitIndex = rvstr.indexOf("#");
		if(rvSplitIndex > -1)
		{
			var rvstr = rvstr.substr(rvSplitIndex+1);
			if(rvstr.length > 0)
			{
				var xmlObj = new XML.ObjTree();
				if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.QueryUserResource",msg:"XML ObjTree load error!"});
				}
				
				var jsonResource = xmlObj.parseXML(rvstr);
				
				if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCustomMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.OptID == "CTL_CUI_QueryUserResource")
				{
					if(typeof jsonResource.Msg.Cmd.Res == "object" && jsonResource.Msg.Cmd.Res.constructor == Array)
					{
	                    for(var i = 0;i < jsonResource.Msg.Cmd.Res.length;i++)
	                    {
	                        var r = jsonResource.Msg.Cmd.Res[i];
	                        allocatedResource.push(new Nrcap2.Struct.UserResourceStruct(r.PUID,r.Type,r.Idx));
	                    }
					}
					else if(typeof jsonResource.Msg.Cmd.Res == "object" && jsonResource.Msg.Cmd.Res.constructor != Array)
					{
	                    var r = jsonResource.Msg.Cmd.Res;
	                    allocatedResource.push(new Nrcap2.Struct.UserResourceStruct(r.PUID,r.Type,r.Idx));
					}
					
				} 
				else
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.QueryUserResource",msg:"Msg Name ro Cmd OptID error!"});
				}
			}
		}
		return allocatedResource;
	},
    
    /*
     *	函数名		：UpdateUserResource
     *	函数功能	：更新用户的资源
     *	备注		： 
     *	作者		：Lingsen
     *	时间		：2011年04月10日  
     *	返回值		：成功返回NRCAP_SUCCESS
     *	参数说明	：3个参数 
     *	        string                      connectId           连接id
     *	        number                      userIndex           用户索引
     *	        array                       resource            用户资源,资源节点类型请参考PUResourceNodeStruct
     */
	UpdateUserResource:function(connectId,userIndex,resource)
	{
	     if(!Nrcap2.Connections.get(connectId))
	    { 
			Nrcap2.Debug.Write({fn:"Nrcap2.QueryUserResource",msg:"connectId is no extsis!"});
	        return false;
	    }
	    
	    var re=new RegExp(Nrcap2.Utility.Regexs.uint);
	    
	    if(typeof userIndex == "undefined" || !re.test(userIndex) )
	    { 
			Nrcap2.Debug.Write({fn:"Nrcap2.QueryUserResource",msg:"userIndex no exists!"});
	        return false;
	    } 
	    
		if(typeof resource != "object")
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.QueryUserResource",msg:"resource object error!"});
			return false;
		} 
	    //alert(222);
	    var allocatedResource = Nrcap2.QueryUserResource(connectId,userIndex);
		if(allocatedResource.length > 0)
		{
		    requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCustomMsgReq\"><Cmd Type=\"CTL\" OptID=\"CTL_CUI_RemoveUserResource\"><User Index=\""+userIndex+"\" >";
		    for(var i = 0;i < allocatedResource.length;i++)
		    {
		        requestParamStr += "<Res PUID=\""+allocatedResource[i].puid+"\" Type=\""+allocatedResource[i].type+"\" Idx=\""+allocatedResource[i].idx+"\" />";
		    }
		    requestParamStr += "</User></Cmd></Msg>";
		    
       	    rvstr = Nrcap2.Connections.get(connectId).nc.SendRequest(5,"",requestParamStr); //alert(rvstr);
		    rvSplitIndex = rvstr.indexOf("#");
		    
		    if(rvSplitIndex > -1)
		    {
			    var rvstr = rvstr.substr(rvSplitIndex+1);
			    if(rvstr.length > 0)
			    {
				    var xmlObj = new XML.ObjTree();
				    if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
				    { 
					    Nrcap2.Debug.Write({fn:"Nrcap2.QueryUserResource",msg:"XML ObjTree load erro!"});
				    }
    				
				    var jsonResource = xmlObj.parseXML(rvstr);
    				
				    if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCustomMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.OptID == "CTL_CUI_RemoveUserResource")
				    { 
					    Nrcap2.Debug.Write({fn:"Nrcap2.QueryUserResource",msg:"RemoveUserResource success!"});
				    } 
				    else
				    { 
					    Nrcap2.Debug.Write({fn:"Nrcap2.QueryUserResource",msg:"Msg Name ro Cmd OptID error!"});
				    }
			    }
		    }
		}
		
		if(resource.length > 0)
		{
		    requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCustomMsgReq\"><Cmd Type=\"CTL\" OptID=\"CTL_CUI_AddUserResource\"><User Index=\""+userIndex+"\" >";
		    for(var i = 0;i < resource.length;i++)
		    {
		        requestParamStr += "<Res PUID=\""+resource[i].puid+"\" Type=\""+resource[i].type+"\" Idx=\""+resource[i].idx+"\" />";
		    }
		    requestParamStr += "</User></Cmd></Msg>";
		    
       	    rvstr = Nrcap2.Connections.get(connectId).nc.SendRequest(5,"",requestParamStr);
       	    
		    rvSplitIndex = rvstr.indexOf("#");
		    
		    if(rvSplitIndex > -1)
		    {
			    var rvstr = rvstr.substr(rvSplitIndex+1);
			    if(rvstr.length > 0)
			    {
				    var xmlObj = new XML.ObjTree();
				    if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
				    { 
					    Nrcap2.Debug.Write({fn:"Nrcap2.QueryUserResource",msg:"XML ObjTree load error!"});
				    }
    				
				    var jsonResource = xmlObj.parseXML(rvstr);
    				
				    if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCustomMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.OptID == "CTL_CUI_AddUserResource")
				    { 
					    Nrcap2.Debug.Write({fn:"Nrcap2.QueryUserResource",msg:"AddUserResource success!"});
				    } 
				    else
				    { 
					    Nrcap2.Debug.Write({fn:"Nrcap2.QueryUserResource",msg:"Msg Name ro Cmd OptID error!"});
				    }
			    }
		    }
		}
		return true;
	},
    
    /*
     *	函数名		：DeleteUser
     *	函数功能	：删除用户. 
     *	备注		： 
     *	作者		：Lingsen
     *	时间		：2011年04月10日  
     *	返回值		：成功返回NRCAP_SUCCESS
     *	参数说明	：2个参数 
     *	        string                      connectId           连接id
     *	        number                      userIndex           用户索引
     */
	DeleteUser:function(connectId,userIndex)
	{
	    if(!Nrcap2.Connections.get(connectId))
	    {
			Nrcap2.Debug.Write("DeleteUser:connectId is no extsis");
	        return false;
	    }
	    
	    var re=new RegExp(Nrcap2.Utility.Regexs.uint);
	    
	    if(typeof userIndex == "undefined" || !re.test(userIndex) )
	    {
			Nrcap2.Debug.Write("DeleteUser:userIndex no exists");
	        return false;
	    }
	    
		var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCustomMsgReq\"><Cmd Type=\"CTL\" OptID=\"CTL_CUI_DeleteUser\"><User Index=\""+userIndex+"\" /></Cmd></Msg>";
       	var rvstr = Nrcap2.Connections.get(connectId).nc.SendRequest(5,"",requestParamStr);
		var rvSplitIndex = rvstr.indexOf("#");
		if(rvSplitIndex > -1)
		{
			var rvstr = rvstr.substr(rvSplitIndex+1);
			if(rvstr.length > 0)
			{
				var xmlObj = new XML.ObjTree();
				if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
				{
					Nrcap2.Debug.Write("DeleteUser:XML ObjTree load error!");
					return false;
				}
				
				var jsonResource = xmlObj.parseXML(rvstr);
				
				if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCustomMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.OptID == "CTL_CUI_DeleteUser")
				{
				    return jsonResource.Msg.Cmd.NUErrorCode == "0" ? true : jsonResource.Msg.Cmd.NUErrorCode;
				} 
				else
				{
					Nrcap2.Debug.Write("DeleteUser:Msg Name ro Cmd OptID error");
					return false;
				}
			}
		}
		return true;
	},
	 
    /*
     *	函数名		：InitWindows
     *	函数功能	：初始化播放窗口
     *	备注		：  
     *	作者		：Lingsen
     *	时间		：2010年04月13日  
     *	返回值		：成功返回NRCAP_SUCCESS
     *	参数说明	：0个参数  
	 */
    InitWindows:function()
    {  
		var keys = Nrcap2.WindowContainers.keys(); 
		for(var i = 0; i < keys.length; i++)
		{
			Nrcap2.DiscardWindow(keys[i]);	
		}
		Nrcap2.WindowContainers = new Hash();
		return Nrcap2.NrcapError.NRCAP_SUCCESS; 
    },
    
    /*
     *	函数名		：CreateWindow
     *	函数功能	：初始化一个视频窗口对象 
     *	备注		：   
     *	作者		：Lingsen
     *	时间		：2010年04月13日 
     *	修改		：2011年09月26日	 
     *	返回值		：成功返回窗口对象 其它对应NrcapError
     *	参数说明	：3个参数 
	 *	        string          connectId             连接ID
     *	        string          containerId           视频窗口容器ID
     *	        WindowEvent     windowEvent           视频窗口需要绑定的事件
	 *			Nrcap2.Enum.NrcapStreamType	 streamType	  
	 				流类型【区别‘实时视频("REALTIME")’、‘回放点播’("STORAGE")】	
     */
    CreateWindow:function(connectId, containerId, windowEvent, streamType )
    {
        try
        {                
            if(!document.getElementById(containerId))
            {
			    Nrcap2.Debug.Write({fn:"Nrcap2.CreateWindow",msg:"container no exists."});
                return Nrcap2.NrcapError.NRCAP_ERROR_INIT_WINDOW_FAILED;
            }
            
		    var t_wndname = containerId+"_wnd";		    
		    var t_nmname = new Date().getTime()+""+parseInt(Math.random()*(999-100+1)+100)+"_nm";
		    
		    var t_wndwidth = document.getElementById(containerId).offsetWidth-4;
		    var t_wndheight = document.getElementById(containerId).offsetHeight-4;
		   
			document.getElementById(containerId).innerHTML = Nrcap2.PlugHtml.get("wnd").replace("id=\"@id\" name=\"@name\" width=\"352\" height=\"288\"","id=\""+t_wndname+"\" name=\""+t_wndname+"\" width=\""+t_wndwidth+"\" height=\""+t_wndheight+"\"");
            if (!document.getElementById(t_nmname))
            {
				document.getElementById("Nrcap2Box").innerHTML += Nrcap2.PlugHtml.get("nm").replace("id=\"@id\" name=\"@name\"","id=\""+t_nmname+"\" name=\""+t_nmname+"\"");
            }
            
            if(!document.getElementById(t_wndname))
            {
                return Nrcap2.NrcapError.NRCAP_ERROR_INIT_WINDOW_FAILED;
            }
		
		 	var wnd = new Nrcap2.Struct.WindowStruct(containerId, t_wndname, t_nmname, connectId, streamType);
            
			if(!wnd instanceof Nrcap2.Struct.WindowStruct)
			{
				return Nrcap2.NrcapError.NRCAP_ERROR_INIT_WINDOW_FAILED;				
			}
			
			// 设置窗口样式 
			wnd.SetStyle({enableFullScreen:false,enableMask:false,enableMainPopMenu:false});   
			 
			if(typeof Nrcap2.Connections.get(connectId).connParam.dssAddress != "undefined" && Nrcap2.Connections.get(connectId).connParam.dssAddress != "")
			{
				wnd.nm.AttachFixedDSSAddr(Nrcap2.Connections.get(connectId).connParam.dssAddress);
			}
			else
			{
				wnd.nm.DetachFixedDSSAddr();
			}
            wnd.wnd.SetLanguage(Nrcap2.language);
            // 绑定窗口事件
            if(windowEvent)
            {
                Nrcap2.WindowAttachEvent(windowEvent, wnd);
            }
            return wnd;
        }
        catch(e)
        {
            Nrcap2.Debug.Write({fn:"Nrcap2.CreateWindow",msg:"error="+e.message+e.name});
            return Nrcap2.NrcapError.NRCAP_ERROR_INIT_WINDOW_FAILED;
        }
    },
    //*****************************************************************************************
	/*
	*	函数名		:	CreatePopWindow
	*	函数功能	：	创建弹出窗口.
	*	备注		： .
	*	作者		：	huzw
	*	时间		：	2010.12.14 
	*	修改		：	2011.09.27
	*	返回值		：	成功返回窗口对象 其它对应NrcapError.
	*	参数说明	：	5个参数.
    *	        string          connectId               连接ID
	*			object			popWindowFrame			弹出窗体主对象  
 	*	        string          containerId             视频窗口容器ID
 	*	        WindowEvent     windowEvent             视频窗口需要绑定的事件
 	*	        object     		vodParams             	点播视频参数
	*/
	CreatePopWindow:function(connectId,containerId,windowEvent,popWindowFrame,vodParams)
	{
		try
		{
			var randomName = new Date().getTime() + "" + Math.round(Math.random()*(999-100+1)+100);
			var t_nmname = randomName + "_nm";
			var t_wndname = randomName + "_popwnd";
			
			if(typeof popWindowFrame != "object")
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.CreatePopWindow",msg:"pop window frame no exists!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_INIT_WINDOW_FAILED;
			}
			
			if(!popWindowFrame.document.getElementById("main"))
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.CreatePopWindow",msg:"pop window frame container no exists"});
				return Nrcap2.NrcapError.NRCAP_ERROR_INIT_WINDOW_FAILED;
			}
			
			var t_wndwidth = vodParams.size.w - 2;
			var t_wndheight = vodParams.size.h - 2;
			
			popWindowFrame.document.getElementById("main").innerHTML = Nrcap2.PlugHtml.get("wnd").replace("id=\"@id\" name=\"@name\" width=\"352\" height=\"288\"","id=\""+ t_wndname +"\" name=\""+ t_wndname +"\" width=\""+ t_wndwidth +"\" height=\""+ t_wndheight +"\""); 
			
			if(vodParams.bDisplayControlBar === true && popWindowFrame.document.getElementById("playcontrolbar"))
			{
				popWindowFrame.document.getElementById("playcontrolbar").innerHTML = "";
			}
			
			if(!popWindowFrame.document.getElementById(t_nmname))
			{
				popWindowFrame.document.getElementById("Nrcap2Box").innerHTML +=  Nrcap2.PlugHtml.get("nm").replace("id=\"@id\" name=\"@name\"","id=\""+ t_nmname +"\" name=\""+ t_nmname +"\"");
			}
			
			// 以下创建窗口结构仍需实际考虑
			var streamType = Nrcap2.Enum.NrcapStreamType['st_vod'];
			var customParams = {
				controlbar: popWindowFrame.document.getElementById("playcontrolbar")
			};
			
			var wnd = new Nrcap2.Struct.WindowStruct(containerId, t_wndname, t_nmname, connectId, streamType, customParams);
			// if(typeof wnd.wnd == "undefined" || wnd.wnd == "")
			wnd.wnd = popWindowFrame.document.getElementById(t_wndname);
			// if(typeof wnd.nm == "undefined" || wnd.nm == "")
			wnd.nm = popWindowFrame.document.getElementById(t_nmname);
			
			wnd.status = {
				playvideoing: false,
				recording: false,
				playaudioing: false,
				upaudioing: false
			};
			
			wnd.SetStyle({
				enableFullScreen: false,
				enableMask: false,
				enableMainPopMenu: false
			});
			
			// alert(Object.toJSON(wnd));
			
		/*	// 设置窗口样式
			popWindowFrame.document.getElementById(t_wndname).enableFullScreen(0);
			popWindowFrame.document.getElementById(t_wndname).enableMask(0);
			popWindowFrame.document.getElementById(t_wndname).enableMainPopMenu(0);
			
			var wnd = {
				// popWindowFrame:popWindowFrame, 
				containerId:containerId,
				wndname:t_wndname,
				nmname:t_nmname,
				wnd:popWindowFrame.document.getElementById(t_wndname),
				nm:popWindowFrame.document.getElementById(t_nmname),
				connectId:connectId,
				puid:null, 
				type:"STORAGE",   
				style:{
                    enableFullScreen:false,
                    enableMask:false,
					enableMainPopMenu:false
                },
                status:{
                    playvideoing:false,
                    recording:false,
                    playaudioing:false,
                    upaudioing:false
                },
				vodParams:{
					speed:0,
					startTime:0,
					endTime:"",
					fileName:"",
					controlbar:popWindowFrame.document.getElementById("playcontrolbar")
				},
				SetStyle:function(style){
					if (typeof style.enableFullScreen != "undefined" && style.enableFullScreen == true)
                    {
                        this.style.enableFullScreen = true;
                        this.wnd.enableFullScreen(1);
                    }
                    else
                    {
                        this.style.enableFullScreen = false;
                        this.wnd.enableFullScreen(0);
                    }
                    if (typeof style.enableMask != "undefined" && style.enableMask == true)
                    {
                        this.style.enableMask = true;
                        this.wnd.enableMask(1);
                    }
                    else
                    {
                        this.style.enableMask = false;
                        this.wnd.enableMask(0);
                    }
                    if (typeof style.enableMainPopMenu != "undefined" && style.enableMainPopMenu == true)
                    {
                        this.style.enableMainPopMenu = true;
                        this.wnd.enableMainPopMenu(1);
                    }
                    else
                    {
                        this.style.enableMainPopMenu = false;
                        this.wnd.enableMainPopMenu(0);
                    }	
				}			
			}//end wnd */
			
			wnd.wnd.SetLanguage(Nrcap2.Language);
			
			if(typeof Nrcap2.Connections.get(connectId).connParam.dssAddress != "undefined" && Nrcap2.Connections.get(connectId).connParam.dssAddress != "")
			{
				wnd.nm.AttachFixedDSSAddr(Nrcap2.Connections.get(connectId).connParam.dssAddress);
			}
			else
			{
				wnd.nm.DetachFixedDSSAddr();
			}
			//绑定窗口事件
			if(windowEvent instanceof Nrcap2.Struct.WindowEventStruct)
			{
				Nrcap2.WindowAttachEvent(windowEvent,wnd);
			}
			return wnd;
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.CreateWindow",msg:"error="+e.message+e.name});
            return Nrcap2.NrcapError.NRCAP_ERROR_INIT_WINDOW_FAILED;
		}
	},
	
	
	//*****************************************************************************************
	
    /*
     *	函数名		：DiscardWindowsByConnectID
     *	函数功能	：按connectId删除所有相关的视频窗口
     *	备注		： 
     *	作者		：Lingsen
     *	时间		：2010年04月13日 
     *	返回值   ：成功返回NRCAP_SUCCESS
     *	参数说明	：1个参数 
     *	        string          connectId               连接ID
     */
    DiscardWindowsByConnectID: function(connectId)
    {

		try
		{ 
            var keys = Nrcap2.WindowContainers.keys(); 
			// alert(Object.toJSON(Nrcap2.WindowContainers));
			for(var i = 0;i < keys.length;i++)
			{ 
				if(Nrcap2.WindowContainers && Nrcap2.WindowContainers.get(keys[i]) && Nrcap2.WindowContainers.get(keys[i]).window && Nrcap2.WindowContainers.get(keys[i]).window.connectId == connectId)
				{
					Nrcap2.DiscardWindow(keys[i]);            
				} 
			}
			keys = Nrcap2.PopWindowContainers.keys();
	
			for(var i = 0;i < keys.length;i++)
			{
				if(Nrcap2.PopWindowContainers && Nrcap2.PopWindowContainers.get(keys[i]) && Nrcap2.PopWindowContainers.get(keys[i]).window && Nrcap2.PopWindowContainers.get(keys[i]).window.connectId == connectId)
				{
					Nrcap2.DiscardPopWindow(keys[i]);            
				}
			}
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.DiscardWindowsByConnectID",msg:"error="+e.message});
		}
        // Nrcap2.WindowContainers = new Hash();
        // Nrcap2.PopWindowsContainers = new Hash();
        return Nrcap2.NrcapError.NRCAP_SUCCESS;
    },
    
    
    
    /*
     *	函数名		：DiscardWindow
     *	函数功能	：按windowKey删除所视频窗口
     *	备注		： 
     *	作者		：Lingsen
     *	时间		：2010年04月13日 
     *	返回值		：成功返回NRCAP_SUCCESS
     *	参数说明	：1个参数 
     *	        string  windowKey           视频窗口ID
     */
    DiscardWindow:function(windowKey)
    { 
        if(Nrcap2.WindowContainers && Nrcap2.WindowContainers.get(windowKey))
        { 
			if(Nrcap2.WindowContainers.get(windowKey).window){
				switch(Nrcap2.WindowContainers.get(windowKey).window.type)	
				{
					case Nrcap2.Enum.NrcapStreamType['st_video']: 
						if(Nrcap2.WindowContainers.get(windowKey).window.status.playvideoing)
						{ 
							Nrcap2.StopVideo(Nrcap2.WindowContainers.get(windowKey).window);
						}
						break;
					
					case Nrcap2.Enum.NrcapStreamType['st_vod']:  
						if(Nrcap2.WindowContainers.get(windowKey).window.status.playvoding)
						{ 
							Nrcap2.StopVod(Nrcap2.WindowContainers.get(windowKey).window);
						}
						break;
					
					default: break; 
				} 
			}
			 
			if($(windowKey+"_window"))
            {
                $(windowKey+"_window").innerHTML = "";
            }
			Nrcap2.WindowContainers.unset(windowKey);  
        }
    },
    
    /*
     *	函数名		：DiscardWindow
     *	函数功能	：按windowKey删除所视频窗口
     *	备注		： 
     *	作者		：Lingsen
     *	时间		：2010年04月13日 
     *	返回值		：成功返回NRCAP_SUCCESS
     *	参数说明	：1个参数 
     *	        string  windowKey           视频窗口ID
     */
    DiscardPopWindow:function(windowKey)
    {
        if(Nrcap2.PopWindowContainers && Nrcap2.PopWindowContainers.get(windowKey))
        { 
			if(Nrcap2.WindowContainers.get(windowKey).window){
				switch(Nrcap2.WindowContainers.get(windowKey).window.type)	
				{
					case Nrcap2.Enum.NrcapStreamType['st_video']: 
						if(Nrcap2.WindowContainers.get(windowKey).window.status.playvideoing)
						{ 
							Nrcap2.StopVideo(Nrcap2.WindowContainers.get(windowKey).window);
						}
						break;
					
					case Nrcap2.Enum.NrcapStreamType['st_vod']:  
						if(Nrcap2.WindowContainers.get(windowKey).window.status.playvoding)
						{ 
							Nrcap2.StopVod(Nrcap2.WindowContainers.get(windowKey).window);
						}
						break;
					
					default: break; 
				} 
			}
			
			if(Nrcap2.PopWindowContainers.get(windowKey).window.popWindowFrame && typeof Nrcap2.PopWindowContainers.get(windowKey).window.popWindowFrame.close == "object")
			{
				Nrcap2.PopWindowContainers.get(windowKey).window.popWindowFrame.close();
			}
			
            if($(windowKey+"_window"))
            {
                $(windowKey+"_window").innerHTML = "";
            }
            Nrcap2.PopWindowContainers.unset(windowKey);
        }
    },
    
    /*
     *	函数名		：WindowAttachEvent
     *	函数功能	：绑定视频窗口事件 
     *	备注		： 
     *	作者		：Lingsen
     *	时间		：2010年04月14日 
     *	返回值   ：成功返回NRCAP_SUCCESS
     *	参数说明	：2个参数 
     *	        WindowEvent     windowEvent          视频窗口需要绑定的事件
     *	        Window          objWnd               视频窗口
     */
    WindowAttachEvent:function(windowEvent,objWnd)
    {
        if(!objWnd || typeof objWnd != "object")
        {
			Nrcap2.Debug.Write({fn:"Nrcap2.WindowAttachEvent",msg:"window object no exists,bind event failed"});
            return false;
        }
        
        if(windowEvent.onStop.status)
        {
            var stopCallBack = windowEvent.onStop.callback;
			objWnd.wnd.attachEvent("onStop",function(){Nrcap2.FireStop(objWnd,stopCallBack);},false);	// 绑定窗口停止播放事件		
        }
        
        if(windowEvent.onClick.status)
        {
            var clickCallBack = windowEvent.onClick.callback;            
			objWnd.wnd.attachEvent("onClick",function(){Nrcap2.FireClick(objWnd,clickCallBack);},false);	// 绑定窗口单击事件		
        }
		
        if(windowEvent.onFullScreen.status)
        {
			var fullScreenCallBack = windowEvent.onFullScreen.callback;
			objWnd.wnd.attachEvent("onFullScreen",function(){Nrcap2.FireFullScreen(objWnd, fullScreenCallBack);},false);	// 绑定全屏事件		
        }
        
        if(windowEvent.onRestore.status)
        { 
			var restoreCallback = windowEvent.onRestore.callback;
			objWnd.wnd.attachEvent("onRestore",function(){Nrcap2.FireRestore(objWnd, restoreCallback);},false);	// 绑定恢复全屏事件
        }
        
        if (windowEvent.onPop.status)
        { 
            objWnd.wnd.attachEvent("onPop",function(){Nrcap2.FirePop(objWnd);},false);
        }
        
        if (windowEvent.onPTZControl.status)
        {
            objWnd.wnd.attachEvent("onPTZControl",function(){Nrcap2.FirePTZControl(objWnd,arguments);},false);
        }
        
        if (windowEvent.onSnapshot.status)
        {
			var snapshotCallback = windowEvent.onSnapshot.callback;
            objWnd.wnd.attachEvent("onSnapshot",function(){Nrcap2.FireSnapshot(objWnd,snapshotCallback);},false);	// 绑定抓拍事件
        }
        
        if (windowEvent.onStartRecord.status)
        {
            var startRecordCallBack = windowEvent.onStartRecord.callback;     
            objWnd.wnd.attachEvent("onStartRecord",function(){Nrcap2.FireStartRecord(objWnd,startRecordCallBack);},false);	// 绑定本地录像开始事件  
 
        }   
       	
        if (windowEvent.onStopRecord.status)
        {
            var stopRecordCallBack = windowEvent.onStopRecord.callback;   
            objWnd.wnd.attachEvent("onStopRecord",function(){Nrcap2.FireStopRecord(objWnd,stopRecordCallBack);},false);	// 绑定窗口本地录像停止事件
        } 
        
        if(windowEvent.onCustomMenuCommand.status)
        {
            for(var i = 0;i < windowEvent.onCustomMenuCommand.menu.length;i++)
            {
                objWnd.wnd.appendMainMenu(windowEvent.onCustomMenuCommand.menu[i].key,windowEvent.onCustomMenuCommand.menu[i].text);                
            }
            var customMenuCommandCallBack = windowEvent.onCustomMenuCommand.callback;     
            objWnd.wnd.attachEvent("onCustomMenuCommand",function(){Nrcap2.FireCustomMenuCommand(objWnd,customMenuCommandCallBack,arguments);},false);	// 绑定窗口刷新事件
        }         
        return true;
    },
    
    // 停止视频事件
    FireStop:function(objWnd,stopCallBack)
    {
        if(typeof objWnd == "object" )
        {
            if(typeof stopCallBack == "function"){stopCallBack();};            
		}
    },
    
    // 单击视频窗口事件
    FireClick:function(objWnd,clickCallBack)
    {
        if(typeof objWnd == "object" )
        {
            if(typeof clickCallBack == "function"){clickCallBack();};
		}
    },
    
    // 全屏视频事件
    FireFullScreen:function(objWnd, fullScreenCallBack)
    {
        if(typeof objWnd == "object" )
        {
		    objWnd.nm.AttachDisplayWindow(objWnd.wnd.getWindowHandle());
		    objWnd.wnd.refresh(); 
			 
			if(typeof fullScreenCallBack == "function"){fullScreenCallBack();};
		}
    },
    
    // 恢复视频事件
    FireRestore:function(objWnd, restoreCallback)
    { 
		if(typeof objWnd == "object" )
		{
			objWnd.nm.AttachDisplayWindow(objWnd.wnd.getWindowHandle());
			objWnd.wnd.refresh();
			if(typeof restoreCallback == "function"){restoreCallback();};
		}
    },
    
    // 浮动小窗口事件 
    FirePop:function(objWnd)
    { 
		if(typeof objWnd == "object" )
		{	
			objWnd.nm.AttachDisplayWindow(objWnd.wnd.getWindowHandle());
			objWnd.wnd.refresh();
		}
    },
    
    // 云台控制事件
    FirePTZControl:function(objWnd,t_arguments)
    {
		if(typeof objWnd == "object" )
		{
			if(t_arguments[0])
			{
				//alert(t_arguments[0]);
				//Nrcap2.PTZControl(objWnd,(t_arguments[0].toLowerCase().search("stop") != -1 ? "stop" : "start"),t_arguments[0].toLowerCase());
				
				var connectId = objWnd.connectId;
				var puid = objWnd.params.puid;
				var ivIdx = objWnd.params.idx;
				var direction = Nrcap2.Enum.PTZDirection[t_arguments[0].toLowerCase()];
				//alert(connectId+":"+puid+":"+ivIdx+":"+direction);
				Nrcap2.PTZ.Control(connectId, puid, ivIdx, direction); 
				
			}
			
		}
    },
     
    // 抓拍事件
    FireSnapshot:function(objWnd,snapshotCallback)
    {
		if(typeof objWnd == "object" )
		{  
			if(typeof snapshotCallback == "function")
			{
				snapshotCallback();
			} 
		}
    },
    
    // 开始录像事件  
    FireStartRecord:function(objWnd,startRecordCallBack)
    {
		if(typeof objWnd == "object" )
		{	
			 if(typeof startRecordCallBack == "function"){startRecordCallBack();};
		}
    },
    
    // 停止录像事件
    FireStopRecord:function(objWnd,stopRecordCallBack)
    {
		if(typeof objWnd == "object" )
		{	
			 if(typeof stopRecordCallBack == "function"){stopRecordCallBack();};
		}
    },
    
    // 云台控制事件
    FireCustomMenuCommand:function(objWnd,customMenuCommandCallBack,t_arguments)
    {
		if(typeof objWnd == "object" )
		{
			if(typeof customMenuCommandCallBack == "function"){customMenuCommandCallBack(t_arguments[0]);};
		}
    },
	
    // << -s- 2011.09.09 Add @huzw Beta
	/*
	 *	函数名		：DestoryWindow
	 *	函数功能	：移除窗口插件






	 *	作者		：huzw
	 *	时间		：2011.09.09
	 *	返回值		：对应NrcapError
	 *	参数说明	：3个参数  
	 *	        string  connectId        视频所属连接ID
	 *	        Nrcap2.Struct.WindowStruct  objWnd           视频窗口对象
	 *			string flag 是否保留本地录像或抓拍[0保留，非零不保留]
	 */
	DestoryWindow: function(connectId, objWnd, flag){
		try
		{
			if(objWnd && objWnd.wnd)
			{ 
				if(objWnd.status.recording)
			    {
			        if(typeof flag == "undefined" || parseInt(flag) == 0) Nrcap2.LocalRecord(objWnd);
			    }
			    
			    if(objWnd.status.playaudioing)
			    {
			        if(typeof flag == "undefined" || parseInt(flag) == 0) Nrcap2.PlayAudio(objWnd);
			    }
			    
			    if(objWnd.status.upaudioing ||
				   objWnd.status.talking)
			    {
			         if(typeof flag == "undefined" || parseInt(flag) == 0) Nrcap2.StopCallTalk(objWnd);
			    }  
				   
				objWnd.wnd.restore();
				objWnd.wnd.refresh();  
				 
				if(objWnd.wnd)
				{
					var parent = objWnd.wnd.parentNode;
					if(parent) parent.removeChild(objWnd.wnd); 
				}	 // alert(objWnd.wnd);

				objWnd.status.playvideoing = false;   
			}
			else
			{
			    Nrcap2.Debug.Write({fn:"Nrcap2.DestoryWindow",msg:"window object no exists"});
				return Nrcap2.NrcapError.NRCAP_ERROR_WINDOW_NOEXIST;
			}
			return Nrcap2.NrcapError.NRCAP_SUCCESS;
		}
		catch(e)
		{
		    Nrcap2.Debug.Write({fn:"Nrcap2.DestoryWindow",msg:"error="+e.message+","+e.name});
			return Nrcap2.NrcapError.NRCAP_ERROR_STOPVIDEO_FAILED;
		}
	},
	
	/*
	 *	函数名		：RestoreWindow
	 *	函数功能	：新建窗口插件并绑定视频
	 *	作者		：huzw
	 *	时间		：2011.09.09
	 *	返回值		：对应NrcapError
	 *	参数说明	：4个参数  
	 *	        string connectId        视频所属连接ID
	 *			string containerId	 	窗口插件容器 
	 *	        Nrcap2.Struct.WindowEventStruct  windowEvent       窗口事件对象
	 *	        Nrcap2.Struct.WindowStruct  objWnd       视频窗口对象 
	 */
	RestoreWindow: function(connectId, containerId, windowEvent, objWnd){
		try
		{
			if(objWnd && objWnd.nm)
			{ 
				 
				if(!document.getElementById(containerId))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.RestoreWindow",msg:"container no exists."});
					return Nrcap2.NrcapError.NRCAP_ERROR_INIT_WINDOW_FAILED;
				}
				
				var t_wndname = containerId + "_wnd";		    
				var t_nmname = objWnd.nmname;
				
				var t_wndwidth = document.getElementById(containerId).offsetWidth - 4;
				var t_wndheight = document.getElementById(containerId).offsetHeight - 4;
			   
				document.getElementById(containerId).innerHTML = Nrcap2.PlugHtml.get("wnd").replace("id=\"@id\" name=\"@name\" width=\"352\" height=\"288\"","id=\""+t_wndname+"\" name=\""+t_wndname+"\" width=\""+t_wndwidth+"\" height=\""+t_wndheight+"\""); 
				
				if(!document.getElementById(t_wndname))
				{
					return Nrcap2.NrcapError.NRCAP_ERROR_INIT_WINDOW_FAILED;
				}
			 
				if(!objWnd instanceof Nrcap2.Struct.WindowStruct)
				{
					return Nrcap2.NrcapError.NRCAP_ERROR_INIT_WINDOW_FAILED;				
				}
				
				objWnd.containerId = containerId; 
				objWnd.wndName = t_wndname;
				objWnd.wnd = document.getElementById(t_wndname); 
				
				// 绑定窗口事件
				if(windowEvent)
				{
					Nrcap2.WindowAttachEvent(windowEvent, objWnd);
				} 
				 
				// 设置窗口样式
				objWnd.SetStyle({
					enableFullScreen: objWnd.style.enableFullScreen,
					enableMask: objWnd.style.enableMask,
					enableMainPopMenu: objWnd.style.enableMainPopMenu
				});
				objWnd.wnd.SetLanguage(Nrcap2.language);
				objWnd.wnd.style.visibility = "visible";
				
				objWnd.wnd.restore();
				objWnd.wnd.refresh();
				objWnd.nm.AttachDisplayWindow(objWnd.wnd.getWindowHandle());
				 
				objWnd.status.playvideoing = true;
				
				// alert(Object.toJSON(objWnd));
			}
			else
			{
			    Nrcap2.Debug.Write({fn:"Nrcap2.RestoreWindow",msg:"window object no exists"});
				return Nrcap2.NrcapError.NRCAP_ERROR_WINDOW_NOEXIST;
			}
			return Nrcap2.NrcapError.NRCAP_SUCCESS;
		}
		catch(e)
		{
		    Nrcap2.Debug.Write({fn:"Nrcap2.RestoreWindow",msg:"error="+e.message+","+e.name});
			return false;
		}
	},
	
	
	// 2011.09.09 Add @huzw Beta -e- >>
	
    /*
     *	函数名		：PlayVideo
     *	函数功能	：播放视频 
     *	作者		：Lingsen
     *	时间		：2010年04月13日 
     *	返回值		：对应NrcapError
     *	参数说明	：3个参数  
     *	        string  connectId        视频所属连接ID
     *	        string  objWnd           视频窗口对象
	 * 			string 	puid			 设备PUID
	 *			string	idx 			 资源索引
	 *			Nrcap2.Enum.NrcapStreamType	streamType 流类型  
     */
    PlayVideo:function(connectId, objWnd, puid, idx, streamType)
    {
		try
		{
			if(objWnd && objWnd.wnd)
			{
				if(!puid || !Nrcap2.puidRex.test(puid))
				{
			        Nrcap2.Debug.Write({fn:"Nrcap2.PlayVideo",msg:"puid undefined"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				
				if( idx == null || typeof idx == "undefined" || !Nrcap2.intRex.test(idx)) 
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.PlayVideo",msg:"idx undefined"});
					return false;
				}  
				
				var streamType = streamType || Nrcap2.Enum.NrcapStreamType['st_video'];
				
				objWnd.nm.AttachSessionHandle(Nrcap2.Connections.get(connectId).session);		
				objWnd.wnd.enableFullScreen(objWnd.style.enableFullScreen);
				objWnd.nm.AttachDisplayWindow(objWnd.wnd.getWindowHandle());
				
				if(typeof Nrcap2.Connections.get(connectId).connParam.bFixCUIAddress != "undefined" && Nrcap2.Connections.get(connectId).connParam.bFixCUIAddress == 1)
				{
					objWnd.nm.AttachFixedDSSAddr(Nrcap2.Connections.get(connectId).connParam.path.split(":")[0]);
				}
				 
				var rv = objWnd.nm.PlayVideo(Nrcap2.Connections.get(connectId).connParam.epId, puid, idx, streamType);
				if(rv.split("#")[0] != 0x0000)
				{
			        Nrcap2.Debug.Write({fn:"Nrcap2.PlayVideo",msg:"error="+Nrcap2.NrcapError.ShowMessage(rv.split("#")[0])});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLAYVIDEO_FAILED;
				}
				objWnd.params.puid = puid;
				objWnd.params.idx = idx;
				objWnd.connectId = connectId;
				objWnd.status.playvideoing = true;
			}
			else
			{
			    Nrcap2.Debug.Write({fn:"Nrcap2.PlayVideo",msg:"window object no exists"});
				return Nrcap2.NrcapError.NRCAP_ERROR_WINDOW_NOEXIST;
			}
			return Nrcap2.NrcapError.NRCAP_SUCCESS;
		}
		catch(e)
		{
		    Nrcap2.Debug.Write({fn:"Nrcap2.PlayVideo",msg:"error="+e.message+","+e.name});
			return Nrcap2.NrcapError.NRCAP_ERROR_PLAYVIDEO_FAILED;
		}
    },
    
    /*
     *	函数名		：StopVideo
     *	函数功能	：停止播放视频 
     *	备注		： 
     *	作者		：Lingsen
     *	时间		：2010.04.13
     *	修改		：2011.10.19 
     *	返回值		：对应NrcapError
     *	参数说明	：1个参数 
     *	        string  objWnd           视频窗口对象
     */
    StopVideo:function(objWnd)
    {  
		try
		{
			if(objWnd && objWnd.wnd)
			{
			    if(objWnd.status.recording)
			    {
			        Nrcap2.RecordVideo(objWnd);
			    }
			    
			    if(objWnd.status.playaudioing)
			    {
			        Nrcap2.PlayAudio(objWnd);
			    }
			     
				if(objWnd.status.upaudioing || 
				   objWnd.status.talking)
				{
					Nrcap2.StopCallTalk(objWnd);
				}
				
				objWnd.nm.StopPlayVideo();
				objWnd.wnd.restore();
				objWnd.wnd.refresh();
				objWnd.nm.DetachSessionHandle();
				objWnd.nm.Refresh();
				objWnd.params.puid = null; 
				objWnd.params.idx = 0;
				objWnd.connectId = null;
				objWnd.status.playvideoing = false;
				objWnd.nm.DetachFixedDSSAddr();
				objWnd.nm.Close();
			}
			else
			{
			    Nrcap2.Debug.Write({fn:"Nrcap2.StopVideo",msg:"window object no exists"});
				return Nrcap2.NrcapError.NRCAP_ERROR_WINDOW_NOEXIST;
			}
			return true;
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.StopVideo",msg:"error="+e.message+","+e.name});
			return Nrcap2.NrcapError.NRCAP_ERROR_STOPVIDEO_FAILED;
		}
    },
    
    /*
     *	函数名		：PlayAudio
     *	函数功能	：播放音频 
     *	作者		：Lingsen
     *	时间		：2010年04月19日 
     *	返回值		：对应NrcapError
     *	参数说明	：1个参数 
     *	        string  objWnd           视频窗口对象
     */
	PlayAudio:function(objWnd)
	{		
		try
		{
			if(objWnd && objWnd.wnd)
			{
				if(objWnd.status.playvideoing && !objWnd.status.playaudioing)
				{
					var rv = objWnd.nm.PlayAudio(Nrcap2.Connections.get(objWnd.connectId).connParam.epId, objWnd.params.puid, objWnd.params.idx,Nrcap2.Enum.NrcapStreamType["st_video"]);
					
					if(rv.split("#")[0] != 0x0000)
					{
			            Nrcap2.Debug.Write({fn:"Nrcap2.PlayAudio",msg:"error="+Nrcap2.NrcapError.ShowMessage(rv.split("#")[0])});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLAYAUDIO_FAILED;
					}
					 
					objWnd.status.playaudioing = true;
                    return Nrcap2.NrcapError.NRCAP_SUCCESS;
				}
			    else if(objWnd.status.playvideoing && objWnd.status.playaudioing)
			    {
    			    // 关闭声音
					objWnd.nm.StopPlayAudio();
					objWnd.status.playaudioing = false;
					return Nrcap2.NrcapError.NRCAP_SUCCESS;
			    }
			    else
			    {
                    // 窗口没有播放视频
                    return Nrcap2.NrcapError.NRCAP_ERROR_VIDEOTOPPED;
			    }
			}
			else
			{
	            Nrcap2.Debug.Write({fn:"Nrcap2.PlayAudio",msg:"window object no exists"});
			}
			return false;			
		}
		catch(e)
		{
	        Nrcap2.Debug.Write({fn:"Nrcap2.PlayAudio",msg:"error="+e.message+"::"+e.name});
            return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED;
		}
	},
    
	/*
	*	函数名	：	AudioVolumeControl
	*	函数功能	：	视频音量控制  
	*	备注		：  无 
	*	作者		：	huzw
	*	时间		：	2011.04.20 
	*	返回值	：	成功返回0~100整数,失败NrcapError
	*	参数说明	：	1个参数  
	*			object objWnd	视频窗口对象
	*			string action 	动作["get":获取音量,"set":设置音量]
	*			unit	value	设置音量的值[action = "set"使用]
	*/ 
	AudioVolumeControl:function(objWnd,action,value){
		try
		{
			if(objWnd && objWnd.wnd)
			{
				if(typeof action =="undefined" || (action != "get" && action != "set"))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.AudioVolumnControl",msg:"action error!"});	
					return false;
				}
				 
				if(action == "set")
				{
					if(typeof value == "undefined")
					{
						return false;
					}
					else
					{  
						value = parseInt(value);
						if(value < 0)
						{
							value = 0;
						} 
						else if(value > 100)
						{
							value = 100;	
						}
					}
				}    
				if(objWnd.status.playvideoing)
				{
					var conn = Nrcap2.Connections.get(objWnd.connectId);
					
					var rv = -1;
					switch(action)
					{
						case 'get': 
							rv = conn.nc.GetConfig(151,objWnd.puid,Nrcap2.Enum.PuResourceType.AudioIn,objWnd.idx,"","CFG_IA_Volume"); //alert(rv);
							var rvstr = rv.indexOf("#");
							if(rvstr > -1)
							{
								if(parseInt(rv.split("#")[0]) == 0x0000)
								{
									rv = parseInt(rv.split("#")[1]);
									if(rv < 0 || rv > 100 )
									{
										rv = 0;
									}
								}
								else
								{
								 	Nrcap2.Debug.Write({fn:"Nrcap2.AudioVolumnControl",msg:"get audio volume error! code = " + rv.split("#")[0]}); 
								} 
							} 
							return rv;
							break; 
						case 'set':							
							rv = conn.nc.SetConfig(151,objWnd.puid,Nrcap2.Enum.PuResourceType.AudioIn,objWnd.idx,"","CFG_IA_Volume",value); 
							if(parseInt(rv) == 0)
							{
								return Nrcap2.NrcapError.NRCAP_SUCCESS;
							}
							else
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.AudioVolumnControl",msg:"set audio volume error! code = " + rv}); 
							} 
							break;
						default:
							return false;
							break;
					}  
				}
				else
				{
					// 窗口没有播放视频
					Nrcap2.Debug.Write({fn:"Nrcap2.AudioVolumnControl",msg:"object window no video playing!"});	
                    return Nrcap2.NrcapError.NRCAP_ERROR_VIDEOTOPPED;
				}
			}	
			else
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.AudioVolumnControl",msg:"object window no exists!"});	
				return Nrcap2.NrcapError.NRCAP_ERROR_WINDOW_FAILED;
			}
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.AudioVolumnControl",msg:"error = " + e.message + "::" + e.name});
			return false;
		}
		
	},
	
	//*****************************************************************************************
	/*
	*	函数名		:	GetVideoStatus
	*	函数功能	：	获取视频播放状态  
	*	备注		：  无 
	*	作者		：	huzw
	*	时间		：	2010年12月14日  
	*	返回值		：	成功返回状态值，否则为""
	*	参数说明	：	1个参数  
	*			object objWnd	视频窗口对象
	*/
	GetVideoStatus:function(objWnd)
	{
		try
		{
			if(objWnd && objWnd.wnd)
			{
				var videoStatus = objWnd.nm.GetVideoStatus();
				return Nrcap2.Enum.LanguagePack.playStatus[parseInt(videoStatus)][Nrcap2.language];				
			}
			else
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.GetVideoStatus",msg:"object window no exists!"});
				//return Nrcap2.NrcapError.NRCAP_ERROR_WINDOW_FAILED;
			}
			return "";
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.GetVideoStatus",msg:"error = " + e.message + "::" + e.name});
			return "";
		}
	},
	
	/*
	*	函数名		:	SnapShot
	*	函数功能	：	本地抓拍
	*	备注		：  
	*	作者		：	huzw
	*	时间		：	2010.12.13
	*	修改		：	2011.10.12
	*	返回值		：	对应NrcapError
	*	参数说明	：	1个参数 
	*			object objWnd	窗口对象
	*			string savePath	本地存储目录
	*/
	SnapShot:function(objWnd, savePath)
	{
		try
		{
			if(objWnd && objWnd.wnd)
			{
				if(savePath == null || typeof savePath == "undefined")
				{
					savePath = "";	
				}  
				var flag = true;
				switch(objWnd.type)
				{
					case Nrcap2.Enum.NrcapStreamType["st_video"]:
						if(!objWnd.status.playvideoing) flag = false; 
						break; 
					case Nrcap2.Enum.NrcapStreamType["st_vod"]:
						if(!objWnd.status.playvoding) flag = false; 
						break; 
					default:
						Nrcap2.Debug.Write({fn:"Nrcap2.SnapShot", msg:"窗口对象类型{objWnd.type}不正确"});
						return Nrcap2.NrcapError.NRCAP_ERROR_SNAP_FAILED;
						break;
				}  
				if(flag == false){
					// 窗口没有在播放（点播）视频（录像）



					Nrcap2.Debug.Write({fn:"Nrcap2.SnapShot",msg:"video/vod no playing!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_VIDEOTOPPED;
				} else {
					// 本地抓拍视频  
					objWnd.nm.Snapshot(savePath);
					return Nrcap2.NrcapError.NRCAP_SUCCESS;
				} 
			}
			else
			{
				// 窗口不存在 
				Nrcap2.Debug.Write({fn:"Nrcap2.SnapShot",msg:"object window no exists!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_WINDOW_FAILED;
			}
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.SnapShot",msg:"error="+e.message+"::"+e.name});
			return Nrcap2.NrcapError.NRCAP_ERROR_SNAP_FAILED;
		}
		
	},
	
	/*
	*	函数名		:	LocalRecord
	*	函数功能	：	启动或停止本地视频/录像存储
	*	备注		： 	RecordVideo => LocalRecord
	*	作者		：	huzw
	*	时间		：	2010.12.13
	*	修改		：	2011.10.12
	*	返回值		：	对应NrcapError
	*	参数说明	：	2个参数 
	*			object objWnd	窗口对象
	*			string savePath	本地存储目录
	*/
	LocalRecord: function(objWnd, savePath)
	{
		try
		{
			if(objWnd && objWnd.wnd)
			{
				if(savePath == null || typeof savePath == "undefined")
				{
					savePath = "";	
				}  
				var flag = true;
				switch(objWnd.type)
				{
					case Nrcap2.Enum.NrcapStreamType["st_video"]:
						if(!objWnd.status.playvideoing) flag = false; 
						break; 
					case Nrcap2.Enum.NrcapStreamType["st_vod"]:
						if(!objWnd.status.playvoding) flag = false; 
						break; 
					default:
						Nrcap2.Debug.Write({fn:"Nrcap2.LocalRecord", msg:"窗口对象类型{objWnd.type}不正确"});
						return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED;
						break;
				}  
				if(flag == false){
					// 窗口没有在播放（点播）视频（录像）



					Nrcap2.Debug.Write({fn:"Nrcap2.LocalRecord",msg:"video/vod no playing!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_VIDEOTOPPED;
				} else {
					if(!objWnd.status.recording)
					{ 
						rv = objWnd.nm.StartRecord(savePath); // alert(rv); 
						if(rv.split("#")[0] == 0x0000)
						{
							objWnd.status.recording = true;
							objWnd.wnd.SetRecording(1); 
						}
						else
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.LocalRecord",msg:"error = " + Nrcap2.NrcapError.ShowMessage(rv.split("#")[0])});
							return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED;
						}
					}
					else if(objWnd.status.recording)
					{
						objWnd.nm.StopRecord();
						objWnd.wnd.SetRecording(0);
						objWnd.status.recording = false; 
					} 
				}  
				return Nrcap2.NrcapError.NRCAP_SUCCESS;
			}
			else
			{
				// 窗口不存在 
				Nrcap2.Debug.Write({fn:"Nrcap2.LocalRecord",msg:"object window no exists!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_WINDOW_FAILED;
			} 
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.LocalRecord",msg:"error="+e.message+"::"+e.name});
			return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED;
		} 
	},
	
	/*
	*	函数名		:	StartRemoteRecord
	*	函数功能	：	启动远程存储
	*	备注		：   
	*	作者		：	huzw
	*	时间		：	2011.05.04 
	*	返回值		：	对应NrcapError
	*	参数说明	：	5个参数  
	*			string connectId	视频所属连接ID
	*			string puid			设备PUID
	*			uint   idx			资源索引
	*			string streamType	流类型[Nrcap2.Enum.NrcapStreamType对象]
	*			string position		文件位置[platform/CEFS]
	*			object customParams 自定义参数 
	*				{
	*					reason	  	启动原因，可能的取值：Manual，各种事件等
	*					duration  	持续时间，单位分钟。最小1分钟，最长1440分钟（24小时） 

	*					serialNo	登录平台获取流的帐号
	*					serialToken	登录平台获取流的口令
	*				}
	*			string csuPuid		平台存储服务器对应的PUID
	*/
	StartRemoteRecord:function(connectId,puid,idx,streamType,position,customParams,csuPuid){
		try
		{
			var fn = "Nrcap2.StartRemoteRecord";
			var _flag = Nrcap2.ShareParamsCheck(connectId,puid,idx,fn); 
			if(_flag != true) return _flag;
			
			if(!streamType || typeof streamType == "undefined")
			{
				Nrcap2.Debug.Write({fn:fn,msg:"StartRemoteRecord streamType error!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED;
			}
			
			if(!position || typeof position == "undefined"|| (position != "platform" && position != "CEFS"))
			{
				Nrcap2.Debug.Write({fn:fn,msg:"StartRemoteRecord position error!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED;
			}
			else
			{
				if(position == "platform")
				{
					if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
					{
						Nrcap2.Debug.Write({fn:fn,msg:"StartRemoteRecord CSU puid error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
					}
				}
			}
			
			var reason = "Manual", duration = "15", serialNo = "admin", serialToken = "";
			
			if(customParams && typeof customParams == "object")
			{
				if(customParams.reason != null && customParams.reason != "undefined")
				{
					reason = customParams.reason;
				} 
				if(customParams.duration != null && customParams.duration != "undefined")
				{
					duration = parseInt(Math.round(customParams.duration)); 
					if(duration < 1 || duration > 1440)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"StartRemoteRecord customParams.duration error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED;
					} 
				}
				if(customParams.serialNo != null && customParams.serialNo != "undefined")
				{
					serialNo = customParams.serialNo;
				}			
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"StartRemoteRecord customParams.serialNo null!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED;
				}
				if(customParams.serialToken != null && customParams.serialToken != "undefined")
				{
					serialToken = MD5.Hex_MD5(customParams.serialToken);  // turn to md5 character
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"StartRemoteRecord customParams.serialToken null!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED;


				}  
			}
			
			var Conn = Nrcap2.Connections.get(connectId); 
			var epId = Conn.connParam.epId;
			
			var requestParamStr = "";
			
			switch(position.toLowerCase())
			{
				case "platform":
					requestParamStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\" ><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\" ><DstRes Type=\"SC\" Idx=\"0\" OptID=\"CTL_SC_ManualStart\" ><Param Reason=\""+reason+"\" Duration=\""+duration+"\" SerialNo=\""+serialNo+"\" SerialToken=\""+serialToken+"\" ></Param></DstRes></Cmd><ObjSets><Res ObjType=\"151\" ObjID=\""+puid+"\" Type=\"IV\" Idx=\""+idx+"\" CmdType=\"CTL\" OptID=\"CTL_SCHEDULER_StartStream\" EPID=\""+epId+"\" ><Param Value=\""+streamType+"\" ></Param></Res></ObjSets></Msg>";
					 
					Nrcap2.Debug.Write({fn:fn,msg:"Request:"+requestParamStr}); // alert(requestParamStr);
			
					var rvstr = Conn.nc.SendRequest(151,csuPuid,requestParamStr);  //  alert(rvstr);  
					
					Nrcap2.Debug.Write({fn:fn,msg:"Response:"+rvstr}); 
					 
					var rvSplitIndex = rvstr.indexOf("#");
					if(rvSplitIndex > -1)
					{
						rvstr = rvstr.substr(rvSplitIndex + 1);
						if(rvstr.length > 0)
						{
							var xmlObj = new XML.ObjTree();
							if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
							{
								Nrcap2.Debug.Write({fn:fn,msg:"XML ObjTree load error!"});
								return false;
							} 
							
							var jsonResource = xmlObj.parseXML(rvstr); // alert(Object.toJSON(jsonResource));
							
							if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes && jsonResource.Msg.Cmd.DstRes.OptID == "CTL_SC_ManualStart")
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode)
								{
									if(jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
									{
										Nrcap2.Debug.Write({fn:fn,msg:"StartRemoteRecord success!"});
										return Nrcap2.NrcapError.NRCAP_SUCCESS; 
									}	
									else 
									{
										Nrcap2.Debug.Write({fn:fn,msg:"ErrorCode = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
										return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED; 
									}
								}
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"StartRemoteRecord response ErrorCode exception error!"});	
									return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED; 
								}							
								
							}
							else if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.NUErrorCode)
							{
								Nrcap2.Debug.Write({fn:fn,msg:"NUErrorCode = "+jsonResource.Msg.Cmd.NUErrorCode});
								return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED; 
							}
							else
							{
								Nrcap2.Debug.Write({fn:fn,msg:"Msg Name ro Cmd OptID error!"});	
								return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED; 
							} 
						}
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"StartRemoteRecord response exception error!"});	
						return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED; 	
					}
				 
					break;
				case "cefs":
					alert("暂不支持前端录像!");
					Nrcap2.Debug.Write({fn:fn,msg:"暂不支持前端录像!"}); 
					return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED;
					
					requestParamStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\" ><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\" ><DstRes Type=\"SC\" Idx=\"0\" OptID=\"CTL_SC_ManualStart\" ><Param Type=\"IV\" Idx=\""+idx+"\" StreamType=\""+streamType+"\" Duration=\""+duration+"\" ></Param></DstRes></Cmd></Msg>";
					
					Nrcap2.Debug.Write({fn:fn,msg:"Request:"+requestParamStr});   alert(requestParamStr);
			
					var rvstr = Conn.nc.SendRequest(151,puid,requestParamStr);   alert(rvstr);  
					
					Nrcap2.Debug.Write({fn:fn,msg:"Response:"+rvstr}); return 0;
					
					
					break;
				default:
					return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED; 
					break;
			} 
			
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:fn,msg:"StartRemoteRecord exception error! error code = " + e.message + ":" + e.name});
			return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED; 	
		}
		
	}, 
	
	/*
	*	函数名		:	StopRemoteRecord
	*	函数功能	：	停止远程存储
	*	备注		：   
	*	作者		：	huzw
	*	时间		：	2011.05.04 
	*	返回值		：	对应NrcapError
	*	参数说明	：	5个参数  
	*			string connectId	视频所属连接ID
	*			string puid			设备PUID
	*			uint   idx			资源索引
	*			string streamType	流类型[Nrcap2.Enum.NrcapStreamType对象]
	*			string position		文件位置[platform/CEFS] 
	*			string csuPuid		平台存储服务器对应的PUID
	*/
	StopRemoteRecord:function(connectId,puid,idx,streamType,position,csuPuid){
		try
		{
			var fn = "Nrcap2.StopRemoteRecord";
			var _flag = Nrcap2.ShareParamsCheck(connectId,puid,idx,fn); 
			if(_flag != true) return _flag;
			
			if(!streamType || typeof streamType == "undefined")
			{
				Nrcap2.Debug.Write({fn:fn,msg:"StopRemoteRecord streamType error!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED;
			}
			
			if(!position || typeof position == "undefined"|| (position != "platform" && position != "CEFS"))
			{
				Nrcap2.Debug.Write({fn:fn,msg:"StopRemoteRecord position error!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED;
			}
			else
			{
				if(position == "platform")
				{
					if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
					{
						Nrcap2.Debug.Write({fn:fn,msg:"StopRemoteRecord CSU puid error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
					}
				}
			}
			
			var Conn = Nrcap2.Connections.get(connectId);
			var epId = Conn.connParam.epId;
			
			var requestParamStr = "";
			
			switch(position.toLowerCase())
			{
				case "platform":
					requestParamStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\" ><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\" ><DstRes Type=\"SC\" Idx=\"0\" OptID=\"CTL_SC_ManualStop\" ><Param /></DstRes></Cmd><ObjSets><Res ObjType=\"151\" ObjID=\""+puid+"\" Type=\"IV\" Idx=\""+idx+"\" CmdType=\"CTL\" OptID=\"CTL_SCHEDULER_StartStream\" EPID=\""+epId+"\" ><Param Value=\""+streamType+"\" ></Param></Res></ObjSets></Msg>";
					
					Nrcap2.Debug.Write({fn:fn,msg:"Request:"+requestParamStr}); // alert(requestParamStr);  
			
					var rvstr = Conn.nc.SendRequest(151,csuPuid,requestParamStr); // alert(rvstr);  
					
					Nrcap2.Debug.Write({fn:fn,msg:"Response:"+rvstr});  
					  
					var rvSplitIndex = rvstr.indexOf("#");
					if(rvSplitIndex > -1)
					{
						rvstr = rvstr.substr(rvSplitIndex + 1);
						if(rvstr.length > 0)
						{
							var xmlObj = new XML.ObjTree();
							if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
							{
								Nrcap2.Debug.Write({fn:fn,msg:"XML ObjTree load error!"});
								return false;
							} 
							
							var jsonResource = xmlObj.parseXML(rvstr); // alert(Object.toJSON(jsonResource));
							
							if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes && jsonResource.Msg.Cmd.DstRes.OptID == "CTL_SC_ManualStop")
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode)
								{
									if(jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
									{
										Nrcap2.Debug.Write({fn:fn,msg:"StopRemoteRecord success!"});
										return Nrcap2.NrcapError.NRCAP_SUCCESS; 
									}	
									else 
									{
										Nrcap2.Debug.Write({fn:fn,msg:"ErrorCode = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
										return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED; 
									}

								}
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"StopRemoteRecord response ErrorCode exception error!"});	
									return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED; 
								}							
								
							}
							else if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.NUErrorCode)
							{
								Nrcap2.Debug.Write({fn:fn,msg:"NUErrorCode = "+jsonResource.Msg.Cmd.NUErrorCode});
								return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED; 
							}
							else
							{
								Nrcap2.Debug.Write({fn:fn,msg:"Msg Name ro Cmd OptID error!"});	
								return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED; 
							} 
						}
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"StopRemoteRecord response exception error!"});	
						return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED; 	
					}
				 
					break;
				case "cefs":
					alert("暂不支持前端录像!");
					Nrcap2.Debug.Write({fn:fn,msg:"暂不支持前端录像!"}); 
					return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED; 	
					break;
				default:
					return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED; 
					break;
			} 
			
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:fn,msg:"StopRemoteRecord exception error! error code = " + e.message + ":" + e.name});
			return Nrcap2.NrcapError.NRCAP_ERROR_RECORD_FAILED; 	
		}
	},
	
	/*
	*	函数名   ：	StartTalk
	*	函数功能	：	开始对讲. 
	*	备注		： 
	*	作者		：	huzw
	*	时间		：	2011.10.18
	*	参数		：3个参数 
	*		string connectId	连接ID
	*		Nrcap2.Struct.WindowStruct objWnd 窗体
	*		string resOAIdx 资源（OA）索引 
	*/
	StartTalk: function(connectId, objWnd, resOAIdx)
	{
		try
		{
			if(objWnd && objWnd.wnd)
			{
				if(!objWnd.status.playvideoing)
				{
					// 窗口没有在播放视频 
					Nrcap2.Debug.Write({fn:"Nrcap2.StartTalk",msg:"video no playing!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_VIDEOTOPPED;
				}
				
				if(resOAIdx == null || typeof resOAIdx == "undefined")
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.StartTalk",msg:"param resOAIdx error!"});
					return false;
				}
				
				// na若不存在，就需要创建 
				if(!objWnd.na || typeof objWnd.na == "undefined")
				{
					var containerId = objWnd.containerId;
					var t_naname = containerId + "_na";
					if(!document.getElementById("Nrcap2Box"))
					{
						var objNrcap2Box = document.createElement("DIV");
						objNrcap2Box.setAttribute("id","Nrcap2Box");
						document.getElementsByTagName("body").item(0).appendChild(objNrcap2Box);
					}
					else
					{
						objNrcap2Box = document.getElementById("Nrcap2Box");	
					}
					 
					objNrcap2Box.innerHTML += Nrcap2.PlugHtml.get("na").replace("id=\"@id\" name=\"@name\"","id=\""+t_naname+"\" name=\""+t_naname+"\"");  
					 
					objWnd.na = document.getElementById(t_naname); 
					objWnd.naName = t_naname;
					objWnd.status.talking = false;
				}
				 
				if(!objWnd.na || typeof objWnd.na == "undefined")
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.StartTalk",msg:"create na failed!"}); 
					return Nrcap2.NrcapError.NRCAP_ERROR_LOADPLUG_NA;
				}
				
				var connectId = connectId || objWnd.connectId;
				var conn = Nrcap2.Connections.get(connectId);  
				objWnd.na.AttachSessionHandle(conn.session);
				// var nrv = objWnd.na.Startup(); 
				var epId = conn.connParam.epId; // alert(epId);
				
				var get_ct_s = Nrcap2.GetCallTalkStatus(objWnd); // alert(Object.toJSON(get_ct_s));
				if(get_ct_s && get_ct_s.flag && get_ct_s.flag != 1)
				{ 
					// 通道非空闲 
					Nrcap2.Debug.Write({fn:"Nrcap2.StartTalk",msg:"error="+Nrcap2.NrcapError.ShowMessage(rv.split("#")[0])});
				 	return Nrcap2.NrcapError.NRCAP_ERROR_CALLORTALKCHANNEL_HOT;
				}
				
				if(!objWnd.status.talking)
				{   
					var rv = objWnd.na.StartTalk(epId, objWnd.params.puid, resOAIdx);
					// alert("start talk: " + rv);
					if(rv.toString().split("#")[0] != 0x0000)
					{
						Nrcap2.Debug.Write({fn:"Nrcap2.StartTalk",msg:"error="+Nrcap2.NrcapError.ShowMessage(rv.split("#")[0])});
				 		return Nrcap2.NrcapError.NRCAP_ERROR_STARTCALLORTALK_FAILED;
					} 
					objWnd.status.talking = true;
				}
				else
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.StartTalk",msg:"talk has exists"});
				 	return Nrcap2.NrcapError.NRCAP_ERROR_STARTCALLORTALK_EXISTS;	
				}
				
				return Nrcap2.NrcapError.NRCAP_SUCCESS;
			}
			else
			{
				 Nrcap2.Debug.Write({fn:"Nrcap2.StartTalk",msg:"window object no exists"});
				 return Nrcap2.NrcapError.NRCAP_ERROR_WINDOW_FAILED;
			}
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.StartTalk",msg:"start talk ecxeption, error:" + e.message + "::" + e.name});
		  	return Nrcap2.NrcapError.NRCAP_ERROR_STARTCALLORTALK_FAILED;	
		}
	}, 
	
	/*
	*	函数名   ：	GetCallTalkStatus
	*	函数功能	：	获取喊话或对讲通道状态. 
	*	备注		： 
	*	作者		：	huzw
	*	时间		：	2011.10.19
	*	参数		：1个参数 
	*		Nrcap2.Struct.WindowStruct objWnd 窗体 
	*/
	GetCallTalkStatus: function(objWnd)
	{
		try
		{
			if(objWnd && objWnd.wnd)
			{
				if(!objWnd.na || typeof objWnd.na == "undefined")
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.GetCallTalkStatus",msg:"create na failed!"}); 
					return Nrcap2.NrcapError.NRCAP_ERROR_LOADPLUG_NA;
				}
				var flag = parseInt(objWnd.na.GetStatus()); 
				var desc = Nrcap2.Enum.LanguagePack["calltalk"][flag][Nrcap2.language]; 
				return new Nrcap2.Struct.CallTalkChannelStatusStruct(flag, desc);
 			}
			else
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.GetCallTalkStatus",msg:"window object no exists"});
				return Nrcap2.NrcapError.NRCAP_ERROR_WINDOW_FAILED;
			}
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.GetCallTalkStatus",msg:"start talk ecxeption, error:" + e.message + "::" + e.name});
		  	return Nrcap2.NrcapError.NRCAP_ERROR_GETCALLORTALKSTATUS_FAILED;
		}
	},
	
	/*
	*	函数名   ：	StopCallTalk
	*	函数功能	：	停止喊话或对讲. 
	*	备注		： 
	*	作者		：	huzw
	*	时间		：	2011.10.19
	*	参数		：1个参数 
	*		Nrcap2.Struct.WindowStruct objWnd 窗体 
	*/
	StopCallTalk: function(objWnd)
	{
		try
		{
			if(objWnd && objWnd.wnd)
			{
				if(!objWnd.na || typeof objWnd.na == "undefined")
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.StopCallTalk",msg:"create na failed!"}); 
					return Nrcap2.NrcapError.NRCAP_ERROR_LOADPLUG_NA;
				}
				objWnd.na.Stop(); 
				objWnd.na.DetachSessionHandle();
				objWnd.status.upaudioing = false;
				objWnd.status.talking = false;
				 
				return Nrcap2.NrcapError.NRCAP_SUCCESS; 
			}
			else
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.StopCallTalk",msg:"window object no exists"});
				return Nrcap2.NrcapError.NRCAP_ERROR_WINDOW_FAILED;
			}
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.StopCallTalk",msg:"start talk ecxeption, error:" + e.message + "::" + e.name});
		  	return Nrcap2.NrcapError.NRCAP_ERROR_STOPCALLORTALK_FAILED;
		}
	},
	
	/*
	*	函数名   ：	LocalVolumeControl
	*	函数功能	：	本地音量控制. 
	*	备注		： 
	*	作者		：	huzw
	*	时间		：	2011.10.19
	*	参数		：3个参数 
	*		Nrcap2.Struct.WindowStruct objWnd 窗体
	* 		Nrcap2.Enum.LocalControlID control 本地控制对象
	*		string value 设置的值
	*/
	LocalVolumeControl: function(objWnd, control, value){
		try
		{
			if(objWnd && objWnd.wnd)
			{
				if(!objWnd.na || typeof objWnd.na == "undefined")
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.LocalVolumeControl",msg:"create na failed!"}); 
					return Nrcap2.NrcapError.NRCAP_ERROR_LOADPLUG_NA;
				}
				
				var type = "set", rv = "";
				switch(control)
				{
					case Nrcap2.Enum.LocalControlID.GetInputVolume: type = "get"; 
						rv = objWnd.na.GetInputVolume(); alert(rv)
						break; 
					case Nrcap2.Enum.LocalControlID.GetOutputVolume: type = "get";  
						rv = objWnd.na.GetOutputVolume(); 
						break; 
					default: 
						var flag = true;
						if(	control && typeof control != "undefined" ){
							if(value == null || typeof value == "undefined" || parseInt(value) < 0 || parseInt(value) > 100){
								flag = false;	
							}
							
							if(flag == true){
								if(parseInt(value) > 0 || 
									parseInt(value) < 100) value = parseInt(value) + 1;
								if( control == Nrcap2.Enum.LocalControlID.SetInputVolume ){ 
									objWnd.na.SetInputVolume(value);
								} else if( control == Nrcap2.Enum.LocalControlID.SetOutputVolume ){
									objWnd.na.SetOutputVolume(value); 
								}
								else { flag = false; }
							}
							
						} else { flag = false; }
						
						if(flag == false){
							Nrcap2.Debug.Write({fn:"Nrcap2.LocalVolumeControl",msg:"param control or value error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_LOCALVOLUME_FAILED;
						} 
						break;
				} 
				
				if(type == "get"){
					if(parseInt(rv) >= 0 || parseInt(rv) <= 100){
						return parseInt(rv);	
					} else {
						Nrcap2.Debug.Write({fn:"Nrcap2.LocalVolumeControl",msg:"get value, error:" + rv});
		  				return Nrcap2.NrcapError.NRCAP_ERROR_LOCALVOLUME_FAILED;
					} 
				} else {
					return Nrcap2.NrcapError.NRCAP_SUCCESS; 
				}
			}
			else
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.LocalVolumeControl",msg:"window object no exists"});
				return Nrcap2.NrcapError.NRCAP_ERROR_WINDOW_FAILED;
			}
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.LocalVolumeControl",msg:"ecxeption, error:" + e.message + "::" + e.name});
		  	return Nrcap2.NrcapError.NRCAP_ERROR_LOCALVOLUME_FAILED;
		}
	},
	
	/*
	*	函数名   ：	PlatformStorage
	*	函数功能	：	平台存储（计划）对象
	*	备注		： 
	*	作者		：	huzw
	*	时间		：	2011.05.17
	*/
	PlatformStorage:{
		GetPlan:function(connectId, csuPuid, name){ 
			try
			{
				var fn = "Nrcap2.PlatformStorage.GetPlan";
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(!name || typeof name == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"name error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETPLAN_FAILED;
				}
				
				var allPlanNames = this.GetAllPlanNames(connectId, csuPuid);  // alert(allPlanNames);
				if(!allPlanNames || typeof allPlanNames != "object" || allPlanNames.constructor != Array )
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"get allPlanNames error!"}); 
				}
				else
				{
					if(allPlanNames.length <= 0 || allPlanNames.indexOf(name) == -1)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"plan name not exists!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETPLAN_FAILED;
					}
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId;
				
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\"SC\" Idx=\"0\" OptID=\"CTL_SC_GetPlan\"><Param Name=\""+name+"\" /></DstRes></Cmd></Msg>"; 
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr});  // alert(requestParamStr);  
				
				var rvstr = conn.nc.SendRequest(151,csuPuid,requestParamStr);  //  alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#");   
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML objtree load error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETPLAN_FAILED;
						}
						
						var jsonResource = xmlObj.parseXML(rvstr);  // alert(Object.toJSON(jsonResource));
						
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
						{
							if(jsonResource.Msg.Cmd.DstRes.OptID && jsonResource.Msg.Cmd.DstRes.OptID == "CTL_SC_GetPlan" && jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
							{
								var planInfo = new Object();
								if(jsonResource.Msg.Cmd.DstRes.Param && typeof jsonResource.Msg.Cmd.DstRes.Param == "object")
								{
									var param = jsonResource.Msg.Cmd.DstRes.Param;
									planInfo = new Nrcap2.Struct.PlatformStoragePlanStruct(name, param.Guard, param.Cycle, param.CycleParam, param.GuardTimeMap);
								}
								else
								{
									// still success, but no Param tag
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Param) error!"}); 
								} 
								
								return planInfo;
							}
							else
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (ErrorCode) error! error code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETPLAN_FAILED;
								}								
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (OptID) error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETPLAN_FAILED;	
								}
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Msg Name or Msg Cmd) error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETPLAN_FAILED;	
						}
						
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error, not find XML string!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETPLAN_FAILED;	
					}
					
				}
				else
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"return error, not find char '#'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETPLAN_FAILED;
				}
				
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! Source = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETPLAN_FAILED;
			}
		},
		
		SetPlan:function(connectId, csuPuid, params){ 
			try
			{
				var fn = "Nrcap2.PlatformStorage.SetPlan"; 
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(!params || typeof params == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_SETPLAN_FAILED;
				}
				
				var paramStr = "<Param ";
				
				var allPlanNames = this.GetAllPlanNames(connectId, csuPuid);  // alert(allPlanNames);
				if(!allPlanNames || typeof allPlanNames != "object" || allPlanNames.constructor != Array )
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"get allPlanNames error!"});
					allPlanNames = new Array();
				} 
				
				if(typeof params == "object")
				{
					if(params.name && typeof params.name != "undefined")
					{
						if(allPlanNames.indexOf(params.name ) != -1)
						{
							Nrcap2.Debug.Write({fn:fn,msg:"plan name have existsed!"});
							// return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_SETPLAN_FAILED;
						} 
						
						paramStr += " Name=\"" + params.name + "\"";
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"plan name(null+) error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_SETPLAN_FAILED;	
					}
					
					var guard = typeof params.guard != "undefined" && (params.guard == "0" || params.guard == "1") ? params.guard : "1";
					paramStr += " Guard=\"" + guard + "\""; 
					
					var cycle = typeof params.cycle != "undefined" && ["Weekly","Everyday","Once"].indexOf(params.cycle) != -1 ? params.cycle : "Everyday";
					paramStr += " Cycle=\"" + cycle + "\""; 
					
					if(params.cycleParam != null && typeof params.cycleParam != "undefined")
					{
						if(params.cycle == "Weekly" && (parseInt(params.cycleParam) <= 0 || parseInt(params.cycleParam) >= 128))
						{
							Nrcap2.Debug.Write({fn:fn,msg:"plan cycleParam value beyond range error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_SETPLAN_FAILED;	
						}
						
						paramStr += " CycleParam=\"" + params.cycleParam + "\""; 
					}
					else
					{
						if(typeof cycle != "undefined" && cycle != "Everyday")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"plan cycleParam(null+) error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_SETPLAN_FAILED;
						} 
					}
					 
					if(params.guardTimeMap && typeof params.guardTimeMap != "undefined")
					{
						var guardTimeMap = params.guardTimeMap.toString().strip().replace(new RegExp("0x","gm"),"");  
						
						var guardTimeMapLength = parseInt(guardTimeMap.length), lengthExceptionFlag = false; 
						// alert(guardTimeMapLength);
						switch(cycle)
						{
							case "Once": 
							case "Everyday":
								if(guardTimeMapLength != 36 * 2) lengthExceptionFlag = true;
								break;
							case "Weekly":
								var cycleParam = params.cycleParam;
								var cpToBinary = parseInt(cycleParam).toString(2);
								var countOfOneFlag = 0;
								
								if(cpToBinary.length < 0 || cpToBinary.length > 7)
								{
									Nrcap2.Debug.Write({fn:fn,msg:"plan cycleParam length beyond range error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_SETPLAN_FAILED;	
								}
								
								for(var i = 0; i < cpToBinary.length; i++)
								{
									var perchar = cpToBinary.charAt(i); 
									if(perchar == "1") countOfOneFlag++;
								}
								
								if(guardTimeMapLength != countOfOneFlag * 36 * 2) lengthExceptionFlag = true;
								
								break;
							default:
								break;
										
						}
						
						if(lengthExceptionFlag)
						{
							Nrcap2.Debug.Write({fn:fn,msg:"plan guardTimeMap length error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_SETPLAN_FAILED;		
						}
						
						paramStr += " GuardTimeMap=\"" + guardTimeMap + "\""; 
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"plan guardTimeMap(null+) error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_SETPLAN_FAILED;
					}
					
					if(params.serialNo != null && typeof params.serialNo != "undefined")
					{
						paramStr += " SerialNo=\"" + params.serialNo + "\""; 
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"plan serialNo(null+) error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_SETPLAN_FAILED;
					}
					
					if(params.serialToken != null && typeof params.serialToken != "undefined")
					{
						var md5_serialToken = MD5.Hex_MD5(params.serialToken);
						paramStr += " SerialToken=\"" + md5_serialToken + "\""; 
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"plan serialToken(null+) error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_SETPLAN_FAILED;
					}
				}
				 
				paramStr += " ></Param>";
				
				//alert(paramStr); 
				//return;
				 
				// eg: paramStr = "<Param Name=\"tt\" Guard=\"1\" Cycle=\"Everyday\" CycleParam=\"0\" GuardTimeMap=\"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\" SerialNo=\"admin\" SerialToken=\"d41d8cd98f00b204e9800998ecf8427e\"></Param>";
				 
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId; 
				
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\"SC\" Idx=\"0\" OptID=\"CTL_SC_SetPlan\">" + paramStr + "</DstRes></Cmd></Msg>"; 
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr}); // alert(requestParamStr);  
				
				var rvstr = conn.nc.SendRequest(151,csuPuid,requestParamStr); // alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#"); // return;
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML objtree load error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_SETPLAN_FAILED;
						}
						
						var jsonResource = xmlObj.parseXML(rvstr); // alert(Object.toJSON(jsonResource));
						
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
						{
							if(jsonResource.Msg.Cmd.DstRes.OptID && jsonResource.Msg.Cmd.DstRes.OptID == "CTL_SC_SetPlan" && jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
							{
								return Nrcap2.NrcapError.NRCAP_SUCCESS;
							}
							else
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (ErrorCode) error! error code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_SETPLAN_FAILED;	
								}								
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (OptID or Param) error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_SETPLAN_FAILED;	
								}
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Msg Name or Msg Cmd) error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_SETPLAN_FAILED;	
						}
						
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error, not find XML string!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_SETPLAN_FAILED;		
					}
					
				}
				else
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"return error, not find char '#'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_SETPLAN_FAILED;
				}
				
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! Source = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_SETPLAN_FAILED;
			}
		},
		
		DelPlan:function(connectId, csuPuid, planName){
			try
			{
				var fn = "Nrcap2.PlatformStorage.DelPlan";
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(!planName || typeof planName == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"planName error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_DELPLAN_FAILED;
				}
				
				var allPlanNames = this.GetAllPlanNames(connectId, csuPuid);  // alert(allPlanNames);
				
				if(!allPlanNames || typeof allPlanNames != "object" || allPlanNames.constructor != Array )
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"get allPlanNames error!"});
					// return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_DELPLAN_FAILED;	
				}
				else
				{ 
					if(allPlanNames.length <= 0 || allPlanNames.indexOf(planName) == -1)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"delete plan name success!"});
					    return Nrcap2.NrcapError.NRCAP_SUCCESS;
					} 
				}
				 
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId; 
				
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\"SC\" Idx=\"0\" OptID=\"CTL_SC_DelPlan\"><Param Name=\""+planName+"\" /></DstRes></Cmd></Msg>"; 
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr}); // alert(requestParamStr);
				
				var rvstr = conn.nc.SendRequest(151,csuPuid,requestParamStr); // alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#"); 
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML objtree load error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_DELPLAN_FAILED;
						}
						
						var jsonResource = xmlObj.parseXML(rvstr); // alert(Object.toJSON(jsonResource));
						
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
						{
							if(jsonResource.Msg.Cmd.DstRes.OptID && jsonResource.Msg.Cmd.DstRes.OptID == "CTL_SC_DelPlan" && jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
							{
								return Nrcap2.NrcapError.NRCAP_SUCCESS;
							}
							else
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (ErrorCode) error! error code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_DELPLAN_FAILED;	
								}								
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (OptID or Param) error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_DELPLAN_FAILED;	
								}
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Msg Name or Msg Cmd) error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_DELPLAN_FAILED;	
						}
						
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error, not find XML string!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_DELPLAN_FAILED;		
					}
					
				}
				else
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"return error, not find char '#'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_DELPLAN_FAILED;
				}
				
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! Source = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_DELPLAN_FAILED;
			}
		},
		
		GetPlanResource:function(connectId, csuPuid, name){
			try
			{
				var fn = "Nrcap2.PlatformStorage.GetPlanResource";
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(!name || typeof name == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"name error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETPLANRES_FAILED;
				}
				
				var allPlanNames = this.GetAllPlanNames(connectId, csuPuid);  // alert(allPlanNames);
				if(!allPlanNames || typeof allPlanNames != "object" || allPlanNames.constructor != Array )
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"get allPlanNames error!"}); 
				}
				else
				{
					if(allPlanNames.length <= 0 || allPlanNames.indexOf(name) == -1)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"plan name no exists in platform!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETPLANRES_FAILED;
					}
				}
				
				var offset = 0, count = 10000000;  // 这里暂且用固定上限值 
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId;
				
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\"SC\" Idx=\"0\" OptID=\"CTL_SC_GetPlanRes\"><Param Name=\""+name+"\" Offset=\""+offset+"\" Cnt=\""+count+"\" /></DstRes></Cmd></Msg>"; 
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr}); // alert(requestParamStr);  
				
				var rvstr = conn.nc.SendRequest(151,csuPuid,requestParamStr); // alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#");  
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML objtree load error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETPLANRES_FAILED;
						}
						
						var jsonResource = xmlObj.parseXML(rvstr);  // alert(Object.toJSON(jsonResource));
						
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
						{
							if(jsonResource.Msg.Cmd.DstRes.OptID && jsonResource.Msg.Cmd.DstRes.OptID == "CTL_SC_GetPlanRes" && jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
							{
								var planResInfo = new Array();
								if(jsonResource.Msg.Cmd.DstRes.Param && typeof jsonResource.Msg.Cmd.DstRes.Param.Res == "object")
								{
									if(jsonResource.Msg.Cmd.DstRes.Param.Res  && jsonResource.Msg.Cmd.DstRes.Param.Res.constructor == Array)
									{
										var planRes = jsonResource.Msg.Cmd.DstRes.Param.Res;
										planRes.each
										(
											function(res,index)
											{  
												if(!res.Param || typeof res.Param == "undefined") res.Param = "";
												planResInfo.push(new Nrcap2.Struct.PlatformStoragePlanResourceStruct(name, res.ObjID, res.Type, res.Idx, res.OptID, res.Param.Value));  
											}
										);  
									}
									else if(jsonResource.Msg.Cmd.DstRes.Param.Res  && jsonResource.Msg.Cmd.DstRes.Param.Res.constructor != Array)
									{
										var res = jsonResource.Msg.Cmd.DstRes.Param.Res;
										if(!res.Param || typeof res.Param == "undefined") res.Param = "";
										planResInfo.push(new Nrcap2.Struct.PlatformStoragePlanResourceStruct(name, res.ObjID, res.Type, res.Idx, res.OptID, res.Param.Value)); 	
									} 
								}  
								else
								{
									// still success, but no Param tag
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Param or Res) error!"}); 
								} 
								
								return planResInfo.uniq();
							}
							else
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (ErrorCode) error! error code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETPLANRES_FAILED;	
								}								
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (OptID) error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETPLANRES_FAILED;	
								}
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Msg Name or Msg Cmd) error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETPLANRES_FAILED;	
						}
						
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error, not find XML string!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETPLANRES_FAILED;		
					}
				}
				else
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"return error, not find char '#'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETPLANRES_FAILED;
				}
				
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! Source = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETPLANRES_FAILED;
			}
		},
		
		AddResourceToPlan:function(connectId, csuPuid, params){ 
			try
			{
				var fn = "Nrcap2.PlatformStorage.AddResourceToPlan";
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(!params || typeof params == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_ADDRESTOPLAN_FAILED;
				}
				else
				{
					if(typeof params != "object" || !params instanceof Nrcap2.Struct.PlatformStoragePlanResourceStruct)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"typeof params error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_ADDRESTOPLAN_FAILED;
					}
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId;
				
				var objResXmlStr = "<Res ObjType=\"151\" ";
				 
				if(params.name != null && params.name != "undefined")
				{ 
					var allPlanNames = this.GetAllPlanNames(connectId, csuPuid); // alert(allPlanNames);
					if(!allPlanNames || typeof allPlanNames != "object" || allPlanNames.constructor != Array )
					{ 
						Nrcap2.Debug.Write({fn:fn,msg:"get allPlanNames error!"}); 
					}
					else
					{
						if(allPlanNames.length <= 0 || allPlanNames.indexOf(params.name) == -1)
						{
							Nrcap2.Debug.Write({fn:fn,msg:"plan name no exists in platform!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_ADDRESTOPLAN_FAILED;
						}
					} 
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.name(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_ADDRESTOPLAN_FAILED;
				} 
				if(params.puid != null && params.puid != "undefined")
				{
					objResXmlStr += " ObjID=\"" + params.puid + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.puid(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_ADDRESTOPLAN_FAILED;	
				}
				if(params.resType != null && params.resType != "undefined")
				{
					objResXmlStr += " Type=\"" + params.resType + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.resType(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_ADDRESTOPLAN_FAILED;	
				}
				if(params.resIdx != null && params.resIdx != "undefined")
				{
					objResXmlStr += " Idx=\"" + params.resIdx + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.resIdx(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_ADDRESTOPLAN_FAILED;	
				}
				
				var optID = "";
				if(params.optID != null && params.optID != "undefined")
				{
					optID = params.optID;
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.optID(null+) error!"});  
				}
				
				if(["CTL_PTZ_MoveToPresetPos", "CTL_SCHEDULER_StartStream", "CTL_COMMONRES_StartStream"].indexOf(optID) == -1)
				{
					optID = params.resType == "PTZ" ? "CTL_PTZ_MoveToPresetPos" : "CTL_SCHEDULER_StartStream";
				}
				
				objResXmlStr += " OptID=\"" + optID + "\"";
					
				var userIndex = Nrcap2.QueryUserIndex(connectId);
				if(userIndex == -1)
				{
					Nrcap2.Debug.Write({fn:fn,msg:"Priority error! check user index failed!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_ADDRESTOPLAN_FAILED;
				}
				else
				{ 
					var userInfo = Nrcap2.QueryUserInfo(connectId, userIndex);
					if(userInfo && typeof userInfo == "object" && userInfo.priority && typeof userInfo.priority != "undefined")
					{
						var priority = userInfo.priority;
						
						objResXmlStr += " Prio=\""+priority+"\"";
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"Priority error! check user info failed!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_ADDRESTOPLAN_FAILED;
					}
				}  
				
				objResXmlStr += " EPID=\""+epId+"\""; 
				
				if(params.value == null || params.value == "undefined")
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"params.value(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_ADDRESTOPLAN_FAILED;	
				}
				 
				objResXmlStr += " CmdType=\"CTL\">";
				objResXmlStr += " <Param " + ( params.value != "" ? "Value=\"" + params.value + "\"" : "") + "/>";
				objResXmlStr += " </Res>"; 
				
				// alert(objResXmlStr);
				// return;
				
				// <Res> could be one more + 
				// <Res ObjType=\"151\"  ObjID=\"151007233130065022\" Type=\"IV\" Idx=\"1\" OptID=\"CTL_SCHEDULER_StartStream\" Prio=\"1\" EPID=\"system\" CmdType=\"CTL\"> <Param Value=\"STORAGE\" /> </Res>
				
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\"SC\" Idx=\"0\" OptID=\"CTL_SC_AddResToPlan\"><Param Name=\""+params.name+"\" /></DstRes></Cmd><ObjSets >"+objResXmlStr+"</ObjSets></Msg>"; 
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr});  //alert(requestParamStr);  
				
				var rvstr = conn.nc.SendRequest(151,csuPuid,requestParamStr); //alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#"); 
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML objtree load error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_ADDRESTOPLAN_FAILED;
						}
						
						var jsonResource = xmlObj.parseXML(rvstr);  // alert(Object.toJSON(jsonResource));
						
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
						{
							if(jsonResource.Msg.Cmd.DstRes.OptID && jsonResource.Msg.Cmd.DstRes.OptID == "CTL_SC_AddResToPlan" && jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
							{  //alert(99999999)
								return Nrcap2.NrcapError.NRCAP_SUCCESS;
							}
							else
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (ErrorCode) error! error code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_ADDRESTOPLAN_FAILED;	
								}								
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (OptID) error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_ADDRESTOPLAN_FAILED;	
								}
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Msg Name or Msg Cmd) error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_ADDRESTOPLAN_FAILED;	
						}
						
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error, not find XML string!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_ADDRESTOPLAN_FAILED;		
					}
				}
				else
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"return error, not find char '#'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_ADDRESTOPLAN_FAILED;
				}
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! Source = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_ADDRESTOPLAN_FAILED;
			}
		},
		
		RemoveResourceFromPlan:function(connectId, csuPuid, params){
			try
			{
				var fn = "Nrcap2.PlatformStorage.RemoveResourceFromPlan";
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});

					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(!params || typeof params == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_REMOVERESFROMPLAN_FAILED;
				}
				else
				{
					if(typeof params != "object" || !params instanceof Nrcap2.Struct.PlatformStoragePlanResourceStruct)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"typeof params error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_REMOVERESFROMPLAN_FAILED;
					}
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId;
				
				var objResXmlStr = "<Res ObjType=\"151\" ";
				 
				if(params.name != null && params.name != "undefined")
				{ 
					var allPlanNames = this.GetAllPlanNames(connectId, csuPuid); // alert(allPlanNames);
					if(!allPlanNames || typeof allPlanNames != "object" || allPlanNames.constructor != Array )
					{ 
						Nrcap2.Debug.Write({fn:fn,msg:"get allPlanNames error!"}); 
					}
					else
					{
						if(allPlanNames.length <= 0 || allPlanNames.indexOf(params.name) == -1)
						{
							Nrcap2.Debug.Write({fn:fn,msg:"plan name no exists in platform!"});
							return Nrcap2.NrcapError.NRCAP_SUCCESS;
						}
					} 
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.name(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_REMOVERESFROMPLAN_FAILED;
				} 
				if(params.puid != null && params.puid != "undefined")
				{
					objResXmlStr += " ObjID=\"" + params.puid + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.puid(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_REMOVERESFROMPLAN_FAILED;	
				}
				if(params.resType != null && params.resType != "undefined")
				{
					objResXmlStr += " Type=\"" + params.resType + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.resType(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_REMOVERESFROMPLAN_FAILED;	
				}
				if(params.resIdx != null && params.resIdx != "undefined")
				{
					objResXmlStr += " Idx=\"" + params.resIdx + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.resIdx(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_REMOVERESFROMPLAN_FAILED;	
				}
				if(params.optID != null && params.optID != "undefined")
				{
					objResXmlStr += " OptID=\"" + params.optID + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.optID(null+) error!"});
					 
					// still running
					objResXmlStr += " OptID=\"" + (params.optID == "PTZ" ? "CTL_PTZ_MoveToPresetPos" : "CTL_SCHEDULER_StartStream" ) + "\"";
				}
				if(params.value == null || params.value == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.value(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_REMOVERESFROMPLAN_FAILED;	
				}				
				
				objResXmlStr += " CmdType=\"CTL\" Prio=\"1\" EPID=\""+epId+"\">";
				objResXmlStr += " <Param " + ( params.value != "" ? "Value=\"" + params.value + "\"" : "") + "/>";
				objResXmlStr += " </Res>"; 
				
				//alert(objResXmlStr);
				//return; 
				
				// eg: objResXmlStr ="<Res ObjType=\"151\" ObjID=\"151084731947205736\" Type=\"IV\" Idx=\"2\" CmdType=\"CTL\" OptID=\"CTL_SCHEDULER_StartStream\" Prio=\"1\" EPID=\""+epId+"\" ><Param Value=\"STORAGE\"></Param></Res>";
				
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\"SC\" Idx=\"0\" OptID=\"CTL_SC_RemoveResFromPlan\"><Param Name=\""+params.name+"\" /></DstRes></Cmd><ObjSets >"+objResXmlStr+"</ObjSets></Msg>"; 
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr}); // alert(requestParamStr);  
				
				var rvstr = conn.nc.SendRequest(151,csuPuid,requestParamStr); // alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#");  
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML objtree load error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_REMOVERESFROMPLAN_FAILED;
						}
						
						var jsonResource = xmlObj.parseXML(rvstr);  // alert(Object.toJSON(jsonResource));
						
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
						{
							if(jsonResource.Msg.Cmd.DstRes.OptID && jsonResource.Msg.Cmd.DstRes.OptID == "CTL_SC_RemoveResFromPlan" && jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
							{  
								return Nrcap2.NrcapError.NRCAP_SUCCESS;
							}
							else
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (ErrorCode) error! error code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_REMOVERESFROMPLAN_FAILED;	
								}								
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (OptID) error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_REMOVERESFROMPLAN_FAILED;	
								}
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Msg Name or Msg Cmd) error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_REMOVERESFROMPLAN_FAILED;	
						}
						
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error, not find XML string!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_REMOVERESFROMPLAN_FAILED;		
					}
				}
				else
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"return error, not find char '#'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_REMOVERESFROMPLAN_FAILED;
				}
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! Source = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_REMOVERESFROMPLAN_FAILED;
			}
		},
		
		GetAllPlanNames:function(connectId, csuPuid){
			try
			{
				var fn = "Nrcap2.PlatformStorage.GetAllPlanNames";
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId; 
				
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\"SC\" Idx=\"0\" OptID=\"CTL_SC_GetAllPlanNames\"><Param /></DstRes></Cmd></Msg>"; 
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr}); // alert(requestParamStr);
				
				var rvstr = conn.nc.SendRequest(151,csuPuid,requestParamStr); // alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#"); 
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML objtree load error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETALLPLANNAMES_FAILED;
						}
						
						var jsonResource = xmlObj.parseXML(rvstr); // alert(Object.toJSON(jsonResource));
						
						var planNames = new Array();
						
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
						{
							if(jsonResource.Msg.Cmd.DstRes.OptID && jsonResource.Msg.Cmd.DstRes.OptID == "CTL_SC_GetAllPlanNames" && jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
							{ 
								if(jsonResource.Msg.Cmd.DstRes.Param && typeof jsonResource.Msg.Cmd.DstRes.Param.Plan == "object")
								{ 
									if(jsonResource.Msg.Cmd.DstRes.Param.Plan.constructor == Array)
									{
										var plan = jsonResource.Msg.Cmd.DstRes.Param.Plan;
										
										plan.each(
											function(node){											
												var name = node.Name; // alert(name);
												planNames.push(name);
											}
										);
										 
									}
									else if(jsonResource.Msg.Cmd.DstRes.Param.Plan.constructor != Array)
									{ 
										planNames.push(jsonResource.Msg.Cmd.DstRes.Param.Plan.Name); 
									}
								} 
								
								//alert(Object.toJSON(planNames))
								return planNames.uniq();
							}
							else
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (ErrorCode) error! error code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETALLPLANNAMES_FAILED;	
								}								
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (OptID or Param) error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETALLPLANNAMES_FAILED;	
								}
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Msg Name or Msg Cmd) error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETALLPLANNAMES_FAILED;	
						} 
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error, not find XML string!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETALLPLANNAMES_FAILED;
					}
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"return error, not find char '#'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETALLPLANNAMES_FAILED;
				}				
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! Source = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_GETALLPLANNAMES_FAILED;
			}
		},	
		
		end:true		
	},
	
	/*
	*	函数名   ：	PlatformLinkAction
	*	函数功能	：	平台联动管理对象
	*	备注		： 
	*	作者		：	huzw
	*	时间		：	2011.06.08
	*/
	PlatformLinkAction:{
		
		GetAllPlanNames:function(connectId, csuPuid){
			try
			{
				var fn = "Nrcap2.PlatformLinkAction.GetAllPlanNames";
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId; 
				
				var operationId = "CTL_LA_GetAllPlanNames";
				
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\"SELF\" Idx=\"0\" OptID=\""+operationId+"\"><Param /></DstRes></Cmd></Msg>"; 
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr}); // alert(requestParamStr);
				
				var rvstr = conn.nc.SendRequest(19,csuPuid,requestParamStr); // alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#"); 
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML objtree load error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETALLPLANNAMES_FAILED;
						}
						
						var jsonResource = xmlObj.parseXML(rvstr); // alert(Object.toJSON(jsonResource));
						
						var planNames = new Array();
						
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
						{
							if(jsonResource.Msg.Cmd.DstRes.OptID && jsonResource.Msg.Cmd.DstRes.OptID == operationId && jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
							{ 
								if(jsonResource.Msg.Cmd.DstRes.Param && typeof jsonResource.Msg.Cmd.DstRes.Param.PlanName != "undefined")
								{ 
									if(jsonResource.Msg.Cmd.DstRes.Param.PlanName.constructor == Array)
									{
										var plan = jsonResource.Msg.Cmd.DstRes.Param.PlanName;
										
										planNames = planNames.concat(plan);  
									}
									else if(jsonResource.Msg.Cmd.DstRes.Param.PlanName.constructor != Array)
									{ 
										planNames.push(jsonResource.Msg.Cmd.DstRes.Param.PlanName); 
									}
								}  
								// alert(Object.toJSON(planNames))
								return planNames.uniq();
							}
							else
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (ErrorCode) error! error code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETALLPLANNAMES_FAILED;	
								}								
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (OptID or Param) error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETALLPLANNAMES_FAILED;	
								}
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Msg Name or Msg Cmd) error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETALLPLANNAMES_FAILED;	
						} 
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error, not find XML string!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETALLPLANNAMES_FAILED;
					}
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"return error, not find char '#'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETALLPLANNAMES_FAILED;
				}				
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! Source = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETALLPLANNAMES_FAILED;
			}
		},
		
		GetPlan:function(connectId, csuPuid, planName){ 
			try
			{
				var name = planName;
				
				var fn = "Nrcap2.PlatformLinkAction.GetPlan";
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(!name || typeof name == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"name error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLAN_FAILED;
				}
				
				var allPlanNames = this.GetAllPlanNames(connectId, csuPuid); // alert(allPlanNames);
				if(!allPlanNames || typeof allPlanNames != "object" || allPlanNames.constructor != Array)
				{
					Nrcap2.Debug.Write({fn:fn,msg:"get all plan names error!"});
				}
				else
				{
					if(allPlanNames.length <= 0 || allPlanNames.indexOf(name) == -1)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"plan name not exists!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLAN_FAILED;
					}
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId;
				
				var operationId = "CTL_LA_GetPlan";
				
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\"SELF\" Idx=\"0\" OptID=\""+operationId+"\"><Param Name=\""+name+"\" /></DstRes></Cmd></Msg>";
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr});  // alert(requestParamStr);  
				
				var rvstr = conn.nc.SendRequest(19,csuPuid,requestParamStr);  // alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#"); 
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML objtree load error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLAN_FAILED;
						}
						
						var jsonResource = xmlObj.parseXML(rvstr); // alert(Object.toJSON(jsonResource));
						
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
						{
							if(jsonResource.Msg.Cmd.DstRes.OptID && jsonResource.Msg.Cmd.DstRes.OptID == operationId && jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
							{
								var planInfo = new Object();

								if(jsonResource.Msg.Cmd.DstRes.Param && typeof jsonResource.Msg.Cmd.DstRes.Param == "object")
								{
									var param = jsonResource.Msg.Cmd.DstRes.Param;
									planInfo = new Nrcap2.Struct.PlatformLinkActionPlanStruct(name, param.Guard, param.Cycle, param.CycleParam, param.GuardTmMap, param.CombineTm, param.TriggerStatus);
								}
								else
								{
									// still success, but no Param tag
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Param) error!"}); 
								} 
								
								return planInfo;
							}
							else
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (ErrorCode) error! error code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLAN_FAILED;
								}								
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (OptID) error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLAN_FAILED;	
								}
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Msg Name or Msg Cmd) error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLAN_FAILED;	
						}
						
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error, not find XML string!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLAN_FAILED;	
					}
					
				}
				else
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"return error, not find char '#'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLAN_FAILED;
				}
				
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! Source = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLAN_FAILED;
			}
		},
		
		SetPlan:function(connectId, csuPuid, params){
			try
			{
				var fn = "Nrcap2.PlatformLinkAction.SetPlan";
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(!params && typeof params == "undefined")
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"params error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_SETPLAN_FAILED;
				}
				 
				var paramStr = "<Param ";
				
				var allPlanNames = this.GetAllPlanNames(connectId, csuPuid);
				if(!allPlanNames || typeof allPlanNames != "object" || allPlanNames.constructor != Array)
				{
					Nrcap2.Debug.Write({fn:fn, msg:"get allPlanNames error!"});
					allPlanNames = new Array();
				}
				
				if(typeof params == "object")
				{
					if(params.name && typeof params.name != "undefined")
					{
						if(allPlanNames.indexOf(params.name) != -1)
						{
							Nrcap2.Debug.Write({fn:fn,msg:"plan name have existsed!"}); 
						} 
						
						paramStr += " Name=\"" + params.name + "\"";
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"plan name(null+) error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_SETPLAN_FAILED;	
					}	
					
					var guard = typeof params.guard != "undefined" && (params.guard == "0" || params.guard == "1")? params.guard : "1";
					paramStr += " Guard=\"" + guard + "\"";
					
					var cycle = typeof params.cycle != "undefined" && ["Weekly","Everyday","Once"].indexOf(params.cycle) != -1 ? params.cycle : "Everyday";
					paramStr += " Cycle=\"" + cycle + "\""; 
					
					if(params.cycleParam != null && typeof params.cycleParam != "undefined")
					{
						if(params.cycle == "Weekly" && (parseInt(params.cycleParam) <= 0 || parseInt(params.cycleParam) >= 128))
						{
							Nrcap2.Debug.Write({fn:fn,msg:"plan cycleParam value beyond range error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_SETPLAN_FAILED;	
						}
						
						paramStr += " CycleParam=\"" + params.cycleParam + "\""; 
					}
					else
					{
						if(typeof cycle != "undefined" && cycle != "Everyday")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"plan cycleParam(null+) error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_SETPLAN_FAILED;
						} 
					}
					
					if(params.guardTimeMap && typeof params.guardTimeMap != "undefined")
					{
						var guardTimeMap = params.guardTimeMap.toString().strip().replace(new RegExp("0x","gm"),"");
						
						var guardTimeMapLength = parseInt(guardTimeMap.length), lengthExceptionFlag = false; 
						// alert(guardTimeMapLength);
						
						switch(cycle)
						{
							case "Once": 
							case "Everyday":
								if(guardTimeMapLength != 36 * 2) lengthExceptionFlag = true;
								break;
							case "Weekly":
								var cycleParam = params.cycleParam;
								var cpToBinary = parseInt(cycleParam).toString(2);
								var countOfOneFlag = 0;
								
								if(cpToBinary.length < 0 || cpToBinary.length > 7)
								{
									Nrcap2.Debug.Write({fn:fn,msg:"plan cycleParam length beyond range error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_SETPLAN_FAILED;	
								}
								
								for(var i = 0; i < cpToBinary.length; i++)
								{
									var perchar = cpToBinary.charAt(i); 
									if(perchar == "1") countOfOneFlag++;
								}
								
								if(guardTimeMapLength != countOfOneFlag * 36 * 2) lengthExceptionFlag = true;
								
								break;
							default:
								break;
						}
						
						if(lengthExceptionFlag)
						{
							Nrcap2.Debug.Write({fn:fn,msg:"plan guardTimeMap length error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_SETPLAN_FAILED;		
						}
						
						paramStr += " GuardTmMap=\"" + guardTimeMap + "\""; 
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"plan guardTimeMap(null+) error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_SETPLAN_FAILED;
					}
					
					var errorFlag = false;
					if(params.combineTime != null && typeof params.combineTime != "undefined")
					{
						if(params.combineTime == "") params.combineTime = 0;
						if(!Nrcap2.intRex.test(params.combineTime)) errorFlag = true;
						
						paramStr += " CombineTm=\"" + params.combineTime + "\""; 
					}
					else { errorFlag = true; }  
						
					if(errorFlag == true)
					{ 
						Nrcap2.Debug.Write({fn:fn,msg:"plan combineTime(null+) error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_SETPLAN_FAILED; 
					}  
				}
				
				paramStr += " ></Param>"; // alert(paramStr); 
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId; 
				
				var operationId = "CTL_LA_SetPlan";
				
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\"SELF\" Idx=\"0\" OptID=\""+operationId+"\">" + paramStr + "</DstRes></Cmd></Msg>"; 
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr}); // alert(requestParamStr);  
				
				var rvstr = conn.nc.SendRequest(19,csuPuid,requestParamStr); // alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#"); // return;
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML objtree load error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_SETPLAN_FAILED;
						}
						
						var jsonResource = xmlObj.parseXML(rvstr); // alert(Object.toJSON(jsonResource));
						
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
						{
							if(jsonResource.Msg.Cmd.DstRes.OptID && jsonResource.Msg.Cmd.DstRes.OptID == operationId && jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
							{
								return Nrcap2.NrcapError.NRCAP_SUCCESS;
							}
							else
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (ErrorCode) error! error code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_SETPLAN_FAILED;	
								}								
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (OptID or Param) error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_SETPLAN_FAILED;	
								}
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Msg Name or Msg Cmd) error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_SETPLAN_FAILED;	
						}
						
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error, not find XML string!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_SETPLAN_FAILED;		
					}
					
				}
				else
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"return error, not find char '#'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_SETPLAN_FAILED;
				}
				
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! Source = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_SETPLAN_FAILED;	
			}
		},
		
		DelPlan:function(connectId, csuPuid, planName){
			try
			{
				var fn = "Nrcap2.PlatformLinkAction.DelPlan";
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(!planName || typeof planName == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"planName error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_DELPLAN_FAILED;
				}
				
				var allPlanNames = this.GetAllPlanNames(connectId, csuPuid);  // alert(allPlanNames);
				
				if(!allPlanNames || typeof allPlanNames != "object" || allPlanNames.constructor != Array )
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"get allPlanNames error!"});
					// return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_DELPLAN_FAILED;	
				}
				else
				{ 
					if(allPlanNames.length <= 0 || allPlanNames.indexOf(planName) == -1)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"delete plan name success!"});
					    return Nrcap2.NrcapError.NRCAP_SUCCESS;
					} 
				}
				 
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId; 
				
				var operationId = "CTL_LA_DelPlan";
				
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\"SELF\" Idx=\"0\" OptID=\""+operationId+"\"><Param Name=\""+planName+"\" /></DstRes></Cmd></Msg>"; 
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr}); // alert(requestParamStr);
				
				var rvstr = conn.nc.SendRequest(19,csuPuid,requestParamStr); // alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#"); 
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML objtree load error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_DELPLAN_FAILED;
						}
						
						var jsonResource = xmlObj.parseXML(rvstr); // alert(Object.toJSON(jsonResource));
						
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
						{
							if(jsonResource.Msg.Cmd.DstRes.OptID && jsonResource.Msg.Cmd.DstRes.OptID == operationId && jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
							{
								return Nrcap2.NrcapError.NRCAP_SUCCESS;
							}
							else
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (ErrorCode) error! error code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_DELPLAN_FAILED;	
								}								
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (OptID or Param) error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_DELPLAN_FAILED;	
								}
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Msg Name or Msg Cmd) error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_DELPLAN_FAILED;	
						}
						
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error, not find XML string!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_DELPLAN_FAILED;		
					}
					
				}
				else
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"return error, not find char '#'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_DELPLAN_FAILED;
				}
				

			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! Source = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_DELPLAN_FAILED;
			}
		},
		
		/* 获取联动计划事件源 */
		GetPlanEvent:function(connectId, csuPuid, planName, offset, count){
			try
			{
				var name = planName;
				
				var fn = "Nrcap2.PlatformLinkAction.GetPlanEvent";
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(!name || typeof name == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"name error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLANEVENT_FAILED;
				}
				 
				if(typeof offset == "undefined" || !Nrcap2.intRex.test(offset))
				{
					offset = 0;
				} 
				
				if(typeof count == "undefined" || !Nrcap2.intRex.test(count))
				{
					count = 10000000;
				} 
				
				var allPlanNames = this.GetAllPlanNames(connectId, csuPuid);  // alert(allPlanNames);
				if(!allPlanNames || typeof allPlanNames != "object" || allPlanNames.constructor != Array )
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"get allPlanNames error!"}); 
				}
				else
				{
					if(allPlanNames.length <= 0 || allPlanNames.indexOf(name) == -1)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"plan name no exists in platform!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLANEVENT_FAILED;
					}
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId; 
				
				var operationId = "CTL_LA_GetPlanEvent"; 
				
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\"SELF\" Idx=\"0\" OptID=\""+operationId+"\"><Param Name=\""+name+"\" Offset=\""+offset+"\" Cnt=\""+count+"\" ></Param></DstRes></Cmd></Msg>"; 
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr}); // alert(requestParamStr);  
				
				var rvstr = conn.nc.SendRequest(19,csuPuid,requestParamStr); // alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#");  
				 
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML objtree load error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLANEVENT_FAILED;
						}
						
						var jsonResource = xmlObj.parseXML(rvstr);  //  alert(Object.toJSON(jsonResource));  
						
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
						{
							if(jsonResource.Msg.Cmd.DstRes.OptID && jsonResource.Msg.Cmd.DstRes.OptID == operationId && jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
							{
								var planEventInfo = new Array();
								if(jsonResource.Msg.Cmd.DstRes.Param && typeof jsonResource.Msg.Cmd.DstRes.Param.Res == "object")
								{
									if(jsonResource.Msg.Cmd.DstRes.Param.Res  && jsonResource.Msg.Cmd.DstRes.Param.Res.constructor == Array)
									{ 
										var planRes = jsonResource.Msg.Cmd.DstRes.Param.Res;
										planRes.each
										(
											function(res,index)
											{  
												if(!res.Param || typeof res.Param == "undefined") res.Param = "";
												planEventInfo.push(new Nrcap2.Struct.PlatformLinkActionPlanEventStruct(name, res.ObjType, res.ObjID, res.Param.ResName, res.ResType, res.ResIdx, res.EventID));  
											}
										);  
									}
									else if(jsonResource.Msg.Cmd.DstRes.Param.Res  && jsonResource.Msg.Cmd.DstRes.Param.Res.constructor != Array)
									{
										var res = jsonResource.Msg.Cmd.DstRes.Param.Res;
										if(!res.Param || typeof res.Param == "undefined") res.Param = "";
										planEventInfo.push(new Nrcap2.Struct.PlatformLinkActionPlanEventStruct(name, res.ObjType, res.ObjID, res.Param.ResName, res.ResType, res.ResIdx, res.EventID)); 	
									} 
								}  
								else
								{
									// still success, but no Param tag
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Param or Res) error!"}); 
								} 
								// alert(Object.toJSON(planEventInfo));
								return planEventInfo.uniq();
							}
							else
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (ErrorCode) error! error code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLANEVENT_FAILED;	
								}								
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (OptID) error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLANEVENT_FAILED;	
								}
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Msg Name or Msg Cmd) error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLANEVENT_FAILED;	
						}
						
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error, not find XML string!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLANEVENT_FAILED;		
					}
				}
				else
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"return error, not find char '#'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLANEVENT_FAILED;
				}  
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! Source = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLANEVENT_FAILED;
			}
		},
		
		/* 向联动计划添加事件源 */
		AddEventToPlan:function(connectId, csuPuid, params){
			try
			{
				var fn = "Nrcap2.PlatformLinkAction.AddEventToPlan";
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(!params || typeof params == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
				}
				else
				{
					if(typeof params != "object" || !params instanceof Nrcap2.Struct.PlatformLinkActionPlanEventStruct)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"typeof params error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
					}
				}
				
				var objResXmlStr = "<Src ";
				
				if(params.name != null && typeof params.name != "undefined")
				{ 
					var allPlanNames = this.GetAllPlanNames(connectId, csuPuid); // alert(allPlanNames);
					if(!allPlanNames || typeof allPlanNames != "object" || allPlanNames.constructor != Array )
					{ 
						Nrcap2.Debug.Write({fn:fn,msg:"get allPlanNames error!"}); 
					}
					else
					{
						if(allPlanNames.length <= 0 || allPlanNames.indexOf(params.name) == -1)
						{
							Nrcap2.Debug.Write({fn:fn,msg:"plan name no exists in platform!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
						}
					} 
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.name(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
				} 
				
				if(params.objType != null && params.objType != "undefined")
				{
					objResXmlStr += " ObjType=\"" + params.objType + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.objType(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;	
				}
				
				if(params.objId != null && params.objId != "undefined")
				{
					objResXmlStr += " ObjID=\"" + params.objId + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.objId(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;	
				}
				
				if(params.resType != null && params.resType != "undefined")
				{
					objResXmlStr += " ResType=\"" + params.resType + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.resType(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;	
				}
				
				if(params.resIdx != null && params.resIdx != "undefined")
				{
					objResXmlStr += " ResIdx=\"" + params.resIdx + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.resIdx(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;	
				}
				
				if(params.eventId != null && params.eventId != "undefined")
				{
					objResXmlStr += " EventID=\"" + params.eventId + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.eventId(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;	
				}
				
				objResXmlStr += " >";
				
				if(params.resName != null && params.resName != "undefined")
				{
					objResXmlStr += "<Param ResName=\"" + params.resName + "\" />";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.resName(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;	
				}
				
				objResXmlStr += "</Src>";
				
				// alert(objResXmlStr);
				// return; 
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId;
				
				var operationId = "CTL_LA_AddEventToPlan";
				
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\"SELF\" Idx=\"0\" OptID=\""+operationId+"\"><Param Name=\""+params.name+"\" /></DstRes></Cmd><SrcSets >"+objResXmlStr+"</SrcSets></Msg>"; 
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr}); // alert(requestParamStr);  
				
				var rvstr = conn.nc.SendRequest(19,csuPuid,requestParamStr); // alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#");
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML objtree load error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
						}
						
						var jsonResource = xmlObj.parseXML(rvstr); // alert(Object.toJSON(jsonResource));
						
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
						{
							if(jsonResource.Msg.Cmd.DstRes.OptID && jsonResource.Msg.Cmd.DstRes.OptID == operationId && jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
							{  
								return Nrcap2.NrcapError.NRCAP_SUCCESS;
							}
							else
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (ErrorCode) error! error code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;	
								}								
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (OptID) error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;	
								}
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Msg Name or Msg Cmd) error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;	
						} 
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error, not find XML string!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;		
					}
				}
				else
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"return error, not find char '#'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
				}
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! Source = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
			}
		},
		
		RemoveEventFromPlan:function(connectId, csuPuid, params){
			try
			{
				var fn = "Nrcap2.PlatformLinkAction.RemoveEventFromPlan";
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(!params || typeof params == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEEVENTFORMPLAN_FAILED;
				}
				else
				{
					if(typeof params != "object" || !params instanceof Nrcap2.Struct.PlatformLinkActionPlanEventStruct)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"typeof params error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEEVENTFORMPLAN_FAILED;
					}
				}
				
				var objResXmlStr = "<Src ";
				
				if(params.name != null && typeof params.name != "undefined")
				{ 
					var allPlanNames = this.GetAllPlanNames(connectId, csuPuid); // alert(allPlanNames);
					if(!allPlanNames || typeof allPlanNames != "object" || allPlanNames.constructor != Array )
					{ 
						Nrcap2.Debug.Write({fn:fn,msg:"get allPlanNames error!"}); 
					}
					else
					{
						if(allPlanNames.length <= 0 || allPlanNames.indexOf(params.name) == -1)
						{
							Nrcap2.Debug.Write({fn:fn,msg:"plan name no longer exists in platform!"});
							return Nrcap2.NrcapError.NRCAP_SUCCESS;
						}
					} 
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.name(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEEVENTFORMPLAN_FAILED;
				} 
				
				if(params.objType != null && params.objType != "undefined")
				{
					objResXmlStr += " ObjType=\"" + params.objType + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.objType(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEEVENTFORMPLAN_FAILED;	
				}
				
				if(params.objId != null && params.objId != "undefined")
				{
					objResXmlStr += " ObjID=\"" + params.objId + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.objId(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEEVENTFORMPLAN_FAILED;	
				}
				
				if(params.resType != null && params.resType != "undefined")
				{
					objResXmlStr += " ResType=\"" + params.resType + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.resType(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEEVENTFORMPLAN_FAILED;	
				}
				
				if(params.resIdx != null && params.resIdx != "undefined")
				{
					objResXmlStr += " ResIdx=\"" + params.resIdx + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.resIdx(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEEVENTFORMPLAN_FAILED;	
				}
				
				if(params.eventId != null && params.eventId != "undefined")
				{
					objResXmlStr += " EventID=\"" + params.eventId + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.eventId(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEEVENTFORMPLAN_FAILED;	
				}
				
				objResXmlStr += " >";
				
				if(params.resName != null && params.resName != "undefined")
				{
					objResXmlStr += "<Param ResName=\"" + params.resName + "\" />";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.resName(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEEVENTFORMPLAN_FAILED;	
				}
				
				objResXmlStr += "</Src>";
				
				// alert(objResXmlStr);
				// return; 
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId;
				
				var operationId = "CTL_LA_RemoveEventFromPlan";
				
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\"SELF\" Idx=\"0\" OptID=\""+operationId+"\"><Param Name=\""+params.name+"\" /></DstRes></Cmd><SrcSets >"+objResXmlStr+"</SrcSets></Msg>"; 
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr});   alert(requestParamStr);  
				
				var rvstr = conn.nc.SendRequest(19,csuPuid,requestParamStr);   alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#");
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML objtree load error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMSTORAGE_REMOVERESFROMPLAN_FAILED;
						}
						
						var jsonResource = xmlObj.parseXML(rvstr);  // alert(Object.toJSON(jsonResource));
						
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
						{
							if(jsonResource.Msg.Cmd.DstRes.OptID && jsonResource.Msg.Cmd.DstRes.OptID == operationId && jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
							{  
								return Nrcap2.NrcapError.NRCAP_SUCCESS;
							}
							else
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (ErrorCode) error! error code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEEVENTFORMPLAN_FAILED;	
								}								
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (OptID) error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEEVENTFORMPLAN_FAILED;	
								}
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Msg Name or Msg Cmd) error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEEVENTFORMPLAN_FAILED;	
						}
						
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error, not find XML string!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEEVENTFORMPLAN_FAILED;		
					}
				}
				else
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"return error, not find char '#'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEEVENTFORMPLAN_FAILED;
				}
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! Source = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEEVENTFORMPLAN_FAILED;
			}
		},
		
		/* 获取联动计划的动作 */
		GetPlanAction:function(connectId, csuPuid, planName, offset, count){
			try
			{
				var name = planName;
				
				var fn = "Nrcap2.PlatformLinkAction.GetPlanAction";
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(!name || typeof name == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"name error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLANACTION_FAILED;
				}
				 
				if(typeof offset == "undefined" || !Nrcap2.intRex.test(offset))
				{
					offset = 0;
				} 
				
				if(typeof count == "undefined" || !Nrcap2.intRex.test(count))
				{
					count = 10000000;
				} 
				
				var allPlanNames = this.GetAllPlanNames(connectId, csuPuid);  // alert(allPlanNames);
				if(!allPlanNames || typeof allPlanNames != "object" || allPlanNames.constructor != Array )
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"get allPlanNames error!"}); 
				}
				else
				{
					if(allPlanNames.length <= 0 || allPlanNames.indexOf(name) == -1)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"plan name no exists in platform!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLANACTION_FAILED;
					}
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId; 
				
				var operationId = "CTL_LA_GetPlanAction"; 
				
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\"SELF\" Idx=\"0\" OptID=\""+operationId+"\"><Param Name=\""+name+"\" Offset=\""+offset+"\" Cnt=\""+count+"\" ></Param></DstRes></Cmd></Msg>"; 
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr}); // alert(requestParamStr);  
				
				var rvstr = conn.nc.SendRequest(19,csuPuid,requestParamStr);  // alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#");  
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML objtree load error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLANACTION_FAILED;
						}
						
						var jsonResource = xmlObj.parseXML(rvstr); // alert(Object.toJSON(jsonResource));  
						
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
						{
							if(jsonResource.Msg.Cmd.DstRes.OptID && jsonResource.Msg.Cmd.DstRes.OptID == operationId && jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
							{
								var planActionInfo = new Array();
								if(jsonResource.Msg.Cmd.DstRes.Param && typeof jsonResource.Msg.Cmd.DstRes.Param.Res == "object")
								{
									// 动作子标签格式化函数
									var _paramTag = function(_optId, _param){
										try
										{
											var _pTag = new Object();
											if(_param && (typeof _param.Param != "undefined" || typeof _param.Description != "undefined"))
											{
												switch(_optId)
												{
													case "CTL_SC_ManualStart": /* 手动启动存储 */
														_pTag = {reason:_param.Param.Reason, duration:_param.Param.Duration, serialNo:_param.Param.SerialNo, serialToken:_param.Param.SerialToken, objType:_param.Param.ObjSets.Res.ObjType, objID:_param.Param.ObjSets.Res.ObjID, resType:_param.Param.ObjSets.Res.Type, resIdx:_param.Param.ObjSets.Res.Idx, optID:_param.Param.ObjSets.Res.OptID, value:_param.Param.ObjSets.Res.Param.Value}; 
														break; 
													case "EVT_LA_ViewThroughMainWindow": /* 在主窗口浏览 */
													case "EVT_LA_ViewThroughAnyWindow": /* 在任意窗口浏览 */
														_pTag = {LAPlanName:_param.Description.LAPlanName, PUID:_param.Description.PUID, PUName:_param.Description.PUName, PUDesc:_param.Description.PUDesc, ResIdx:_param.Description.ResIdx, ResName:_param.Description.ResName, ResDesc:_param.Description.ResDesc};
														break;
													case "EVT_LA_SendMessage": /* 向客户发送消息 */
														_pTag = {LAPlanName:_param.Description.LAPlanName, Message:_param.Description.Message};
														break;
													case "EVT_LA_SendAlert": /* 向客户报警信号 */
														_pTag = {LAPlanName:_param.Description.LAPlanName, SoundPath:_param.Description.SoundPath};
														break;
													case "CTL_ES_SMSSend": /* 向手机发送短信息 */
														_pTag = {No:_param.Param.No, Text:_param.Param.Text};
														break;
													case "CTL_SP_WriteData": /* 向串口发送字符串 */
														_pTag = {Data:_param.Param.Data};
														break;
													case "CTL_PTZ_MoveToPresetPos": /* 前往预置位 */
														_pTag = {presetPos:_param.Param.PresetPos};
														break;
													case "CTL_PTZ_StartAutoScan": /* 启动自动扫描 */
													case "CTL_PTZ_StopAutoScan": /* 停止自动扫描 */
													case "CTL_PTZ_RunTour": /* 启动巡航 */
													case "CTL_PTZ_StopTour": /* 停止巡航 */
														_pTag = {};
														break;
													case "CFG_ODL_ConnectStatus": /* 自定义联动 */
														_pTag = {Value:_param.Param.Value};
														break;
													default:
														break;
												}
											} 
											return _pTag;
										}
										catch(e)
										{
											Nrcap2.Debug.Write({fn:fn,msg:"return exception error, may be some tag(null+)!"});
											return {};
										} 
									};
									
									if(jsonResource.Msg.Cmd.DstRes.Param.Res  && jsonResource.Msg.Cmd.DstRes.Param.Res.constructor == Array)
									{
										var planRes = jsonResource.Msg.Cmd.DstRes.Param.Res;
										planRes.each
										(
											function(res,index)
											{    
												var paramTag = _paramTag(res.OptID, res.Param); // alert(Object.toJSON(paramTag));
												 
												planActionInfo.push(new Nrcap2.Struct.PlanformLinkActionPlanActionStruct(name, res.ObjType, res.ObjID, res.Type, res.Idx, res.CmdType, res.OptID, res.Prio, res.Param.ResName, res.Param.DelayTm, res.Param.CycleTm, res.Param.CycleNum, paramTag));
											}
										);  
									}
									else if(jsonResource.Msg.Cmd.DstRes.Param.Res  && jsonResource.Msg.Cmd.DstRes.Param.Res.constructor != Array)
									{
										var res = jsonResource.Msg.Cmd.DstRes.Param.Res;
										
										var paramTag = _paramTag(res.OptID, res.Param); // alert(Object.toJSON(paramTag));
												 
										planActionInfo.push(new Nrcap2.Struct.PlanformLinkActionPlanActionStruct(name, res.ObjType, res.ObjID, res.Type, res.Idx, res.CmdType, res.OptID, res.Prio, res.Param.ResName, res.Param.DelayTm, res.Param.CycleTm, res.Param.CycleNum, paramTag));	
									} 
								}  
								else
								{
									// still success, but no Param tag
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Param or Res) error!"}); 
								} 
								
								return planActionInfo.uniq();
							}
							else
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (ErrorCode) error! error code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLANACTION_FAILED;	
								}								
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (OptID) error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLANACTION_FAILED;	
								}
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Msg Name or Msg Cmd) error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLANACTION_FAILED;	
						}
						
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error, not find XML string!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLANACTION_FAILED;		
					}
				}
				else
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"return error, not find char '#'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLANACTION_FAILED;
				}
				
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! Source = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_GETPLANACTION_FAILED;
			}
		},
		
		AddActionToPlan:function(connectId, csuPuid, params){
			try
			{
				var fn = "Nrcap2.PlatformLinkAction.AddActionToPlan"; 
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(!params || typeof params == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDACTIONTOPLAN_FAILED;
				}
				else
				{
					if(typeof params != "object" || !params instanceof Nrcap2.Struct.PlanformLinkActionPlanActionStruct)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"typeof params error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDACTIONTOPLAN_FAILED;
					}
				}
				
				var objResXmlStr = "<Res ";
				
				if(params.name != null && typeof params.name != "undefined")
				{ 
					var allPlanNames = this.GetAllPlanNames(connectId, csuPuid); // alert(allPlanNames);
					if(!allPlanNames || typeof allPlanNames != "object" || allPlanNames.constructor != Array )
					{ 
						Nrcap2.Debug.Write({fn:fn,msg:"get allPlanNames error!"}); 
					}
					else
					{
						if(allPlanNames.length <= 0 || allPlanNames.indexOf(params.name) == -1)
						{
							Nrcap2.Debug.Write({fn:fn,msg:"plan name no exists in platform!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
						}
					} 
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.name(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
				} 
				
				if(params.objType != null && typeof params.objType != "undefined")
				{
					objResXmlStr += " ObjType=\"" + params.objType + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.objType(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
				}
				
				if(params.objID != null && typeof params.objID != "undefined")
				{
					objResXmlStr += " ObjID=\"" + params.objID + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.objID(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
				}
				
				if(params.resType != null && typeof params.resType != "undefined")
				{
					objResXmlStr += " Type=\"" + params.resType + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.resType(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
				}
				
				if(params.resIdx != null && typeof params.resIdx != "undefined")
				{
					objResXmlStr += " Idx=\"" + params.resIdx + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.resIdx(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
				}
				
				if(params.cmdType != null && typeof params.cmdType != "undefined")
				{
					objResXmlStr += " CmdType=\"" + params.cmdType + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.cmdType(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
				}
				
				if(params.optID != null && typeof params.optID != "undefined")
				{
					objResXmlStr += " OptID=\"" + params.optID + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.optID(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
				}
				
				if(params.prio != null && typeof params.prio != "undefined")
				{
					objResXmlStr += " Prio=\"" + params.prio + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.prio(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
				}
				
				objResXmlStr += " ><Param ";
				
				if(params.delayTime != null && typeof params.delayTime != "undefined")
				{
					objResXmlStr += " DelayTm=\""+params.delayTime+"\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.delayTime(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
				}
				
				if(params.cycleTime != null && typeof params.cycleTime != "undefined")
				{
					objResXmlStr += " CycleTm=\""+params.cycleTime+"\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.cycleTime(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
				}
				
				if(params.cycleNum != null && typeof params.cycleNum != "undefined")
				{
					objResXmlStr += " CycleNum=\""+params.cycleNum+"\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.cycleNum(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
				}
				
				if(params.resName != null && typeof params.resName != "undefined")
				{
					objResXmlStr += " ResName=\""+params.resName+"\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.resName(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
				}
				
				objResXmlStr += "  >";
				var paramTagXmlStr = "";
				 
				if(!params.paramTag || typeof params.paramTag != "object")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.paramTag(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
				}
				else
				{
					try
					{
						var _pTag = params.paramTag;
						
						switch(params.optID)
						{
							case "CTL_SC_ManualStart": /* 手动启动存储 */ 		
								paramTagXmlStr = "<Param Reason=\""+_pTag.reason+"\" Duration=\""+_pTag.duration+"\" SerialNo=\""+_pTag.serialNo+"\" SerialToken=\""+_pTag.serialToken+"\" ><ObjSets><Res ObjType=\""+_pTag.objType+"\" ObjID=\""+_pTag.objID+"\" Type=\""+_pTag.resType+"\" Idx=\""+_pTag.resIdx+"\" OptID=\""+_pTag.optID+"\" ><Param Value=\""+_pTag.value+"\" ></Param></Res></ObjSets></Param> ";
								break; 
							case "EVT_LA_ViewThroughMainWindow": /* 在主窗口浏览 */
							case "EVT_LA_ViewThroughAnyWindow": /* 在任意窗口浏览 */ 
								paramTagXmlStr = "<Description  LAPlanName=\""+_pTag.LAPlanName+"\" PUID=\""+_pTag.PUID+"\" PUName=\""+_pTag.PUName+"\" PUDesc=\""+_pTag.PUDesc+"\" ResIdx=\""+_pTag.ResIdx+"\" ResName=\""+_pTag.ResName+"\" ResDesc=\""+_pTag.ResDesc+"\" ></Description > ";
								break;
							case "EVT_LA_SendMessage": /* 向客户发送消息 */ 
								paramTagXmlStr = "<Description  LAPlanName=\""+_pTag.LAPlanName+"\" Message=\""+_pTag.Message+"\" ></Description > ";
								break;
							case "EVT_LA_SendAlert": /* 向客户报警信号 */ 
								paramTagXmlStr = "<Description  LAPlanName=\""+_pTag.LAPlanName+"\" SoundPath=\""+_pTag.SoundPath+"\" ></Description > ";
								break;
							case "CTL_ES_SMSSend": /* 向手机发送短信息 */ 
								paramTagXmlStr = "<Param  No=\""+_pTag.No+"\" Text=\""+_pTag.Text+"\" ></Param > ";
								break;
							case "CTL_SP_WriteData": /* 向串口发送字符串 */
								paramTagXmlStr = "<Param  Data=\""+_pTag.Data+"\" ></Param > ";
								break;
							case "CTL_PTZ_MoveToPresetPos": /* 前往预置位 */ 
								paramTagXmlStr = "<Param  PresetPos=\""+_pTag.presetPos+"\" ></Param > ";
								break;
							case "CTL_PTZ_StartAutoScan": /* 启动自动扫描 */
							case "CTL_PTZ_StopAutoScan": /* 停止自动扫描 */
							case "CTL_PTZ_RunTour": /* 启动巡航 */
							case "CTL_PTZ_StopTour": /* 停止巡航 */
								paramTagXmlStr = "<Param /> ";
								break;
							case "CFG_ODL_ConnectStatus": /* 自定义联动 */ 
								paramTagXmlStr = "<Param  Value=\""+_pTag.Value+"\" ></Param > ";
								break;
							default:
							 	paramTagXmlStr = "<Param /> ";
								break;	
						}
						
					}
					catch(e)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"params.paramTag(null+) error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED;
					}  
				}
				
				objResXmlStr += paramTagXmlStr; 
				objResXmlStr += "</Param></Res>";
				
				//alert(objResXmlStr);
				//return;
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId;
				
				var operationId = "CTL_LA_AddActionToPlan";
				
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\"SELF\" Idx=\"0\" OptID=\""+operationId+"\"><Param Name=\""+params.name+"\" /></DstRes></Cmd><ObjSets >"+objResXmlStr+"</ObjSets></Msg>"; 
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr}); // alert(requestParamStr);  
				
				var rvstr = conn.nc.SendRequest(19,csuPuid,requestParamStr); // alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#"); 
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML objtree load error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDACTIONTOPLAN_FAILED;
						}
						
						var jsonResource = xmlObj.parseXML(rvstr);  // alert(Object.toJSON(jsonResource));
						
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
						{
							if(jsonResource.Msg.Cmd.DstRes.OptID && jsonResource.Msg.Cmd.DstRes.OptID == operationId && jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
							{  
								return Nrcap2.NrcapError.NRCAP_SUCCESS;
							}
							else
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (ErrorCode) error! error code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDACTIONTOPLAN_FAILED;	
								}								
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (OptID) error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDACTIONTOPLAN_FAILED;	
								}
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Msg Name or Msg Cmd) error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDACTIONTOPLAN_FAILED;	
						}
						
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error, not find XML string!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDACTIONTOPLAN_FAILED;		
					}
				}
				else
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"return error, not find char '#'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDACTIONTOPLAN_FAILED;
				}
				
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! Source = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDACTIONTOPLAN_FAILED;
			}
		},
		
		RemoveActionFromPlan:function(connectId, csuPuid, params){
			try
			{
				var fn = "Nrcap2.PlatformLinkAction.RemoveActionFromPlan";
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(!params || typeof params == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDACTIONTOPLAN_FAILED;
				}
				else
				{
					if(typeof params != "object" || !params instanceof Nrcap2.Struct.PlanformLinkActionPlanActionStruct)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"typeof params error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_ADDACTIONTOPLAN_FAILED;
					}
				}
				
				var objResXmlStr = "<Res ";
				
				if(params.name != null && typeof params.name != "undefined")
				{ 
					var allPlanNames = this.GetAllPlanNames(connectId, csuPuid); // alert(allPlanNames);
					if(!allPlanNames || typeof allPlanNames != "object" || allPlanNames.constructor != Array )
					{ 
						Nrcap2.Debug.Write({fn:fn,msg:"get allPlanNames error!"}); 
					}
					else
					{
						if(allPlanNames.length <= 0 || allPlanNames.indexOf(params.name) == -1)
						{
							Nrcap2.Debug.Write({fn:fn,msg:"plan name no longer exists in platform!"});
							return Nrcap2.NrcapError.NRCAP_SUCCESS;
						}
					} 
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.name(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;
				} 
				
				if(params.objType != null && typeof params.objType != "undefined")
				{
					objResXmlStr += " ObjType=\"" + params.objType + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.objType(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;
				}
				
				if(params.objID != null && typeof params.objID != "undefined")
				{
					objResXmlStr += " ObjID=\"" + params.objID + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.objID(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;
				}
				
				if(params.resType != null && typeof params.resType != "undefined")
				{
					objResXmlStr += " Type=\"" + params.resType + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.resType(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;
				}
				
				if(params.resIdx != null && typeof params.resIdx != "undefined")
				{
					objResXmlStr += " Idx=\"" + params.resIdx + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.resIdx(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;
				}
				
				if(params.cmdType != null && typeof params.cmdType != "undefined")
				{
					objResXmlStr += " CmdType=\"" + params.cmdType + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.cmdType(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;
				}
				
				if(params.optID != null && typeof params.optID != "undefined")
				{
					objResXmlStr += " OptID=\"" + params.optID + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.optID(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;
				}
				
				if(params.prio != null && typeof params.prio != "undefined")
				{
					objResXmlStr += " Prio=\"" + params.prio + "\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.prio(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;
				}
				
				objResXmlStr += " ><Param ";
				
				if(params.delayTime != null && typeof params.delayTime != "undefined")
				{
					objResXmlStr += " DelayTm=\""+params.delayTime+"\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.delayTime(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;
				}
				
				if(params.cycleTime != null && typeof params.cycleTime != "undefined")
				{
					objResXmlStr += " CycleTm=\""+params.cycleTime+"\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.cycleTime(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;
				}
				
				if(params.cycleNum != null && typeof params.cycleNum != "undefined")
				{
					objResXmlStr += " CycleNum=\""+params.cycleNum+"\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.cycleNum(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;
				}
				
				if(params.resName != null && typeof params.resName != "undefined")
				{
					objResXmlStr += " ResName=\""+params.resName+"\"";
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.resName(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;
				}
				
				objResXmlStr += "  >";
				var paramTagXmlStr = "";
				 
				if(!params.paramTag || typeof params.paramTag != "object")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"params.paramTag(null+) error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;
				}
				else
				{
					try
					{
						var _pTag = params.paramTag;
						
						switch(params.optID)
						{
							case "CTL_SC_ManualStart": /* 手动启动存储 */ 		
								paramTagXmlStr = "<Param Reason=\""+_pTag.reason+"\" Duration=\""+_pTag.duration+"\" SerialNo=\""+_pTag.serialNo+"\" SerialToken=\""+_pTag.serialToken+"\" ><ObjSets><Res ObjType=\""+_pTag.objType+"\" ObjID=\""+_pTag.objID+"\" Type=\""+_pTag.resType+"\" Idx=\""+_pTag.resIdx+"\" OptID=\""+_pTag.optID+"\" ><Param Value=\""+_pTag.value+"\" ></Param></Res></ObjSets></Param> ";
								break; 
							case "EVT_LA_ViewThroughMainWindow": /* 在主窗口浏览 */
							case "EVT_LA_ViewThroughAnyWindow": /* 在任意窗口浏览 */ 
								paramTagXmlStr = "<Description  LAPlanName=\""+_pTag.LAPlanName+"\" PUID=\""+_pTag.PUID+"\" PUName=\""+_pTag.PUName+"\" PUDesc=\""+_pTag.PUDesc+"\" ResIdx=\""+_pTag.ResIdx+"\" ResName=\""+_pTag.ResName+"\" ResDesc=\""+_pTag.ResDesc+"\" ></Description > ";
								break;
							case "EVT_LA_SendMessage": /* 向客户发送消息 */ 
								paramTagXmlStr = "<Description  LAPlanName=\""+_pTag.LAPlanName+"\" Message=\""+_pTag.Message+"\" ></Description > ";
								break;
							case "EVT_LA_SendAlert": /* 向客户报警信号 */ 
								paramTagXmlStr = "<Description  LAPlanName=\""+_pTag.LAPlanName+"\" SoundPath=\""+_pTag.SoundPath+"\" ></Description > ";
								break;
							case "CTL_ES_SMSSend": /* 向手机发送短信息 */ 
								paramTagXmlStr = "<Param  No=\""+_pTag.No+"\" Text=\""+_pTag.Text+"\" ></Param > ";
								break;
							case "CTL_SP_WriteData": /* 向串口发送字符串 */
								paramTagXmlStr = "<Param  Data=\""+_pTag.Data+"\" ></Param > ";
								break;
							case "CTL_PTZ_MoveToPresetPos": /* 前往预置位 */ 
								paramTagXmlStr = "<Param  PresetPos=\""+_pTag.presetPos+"\" ></Param > ";
								break;
							case "CTL_PTZ_StartAutoScan": /* 启动自动扫描 */
							case "CTL_PTZ_StopAutoScan": /* 停止自动扫描 */
							case "CTL_PTZ_RunTour": /* 启动巡航 */
							case "CTL_PTZ_StopTour": /* 停止巡航 */
								paramTagXmlStr = "<Param /> ";
								break;
							case "CFG_ODL_ConnectStatus": /* 自定义联动 */ 
								paramTagXmlStr = "<Param  Value=\""+_pTag.Value+"\" ></Param > ";
								break;
							default:
							 	paramTagXmlStr = "<Param /> ";
								break;	
						}
						
					}
					catch(e)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"params.paramTag(null+) error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;
					}  
				}
				
				objResXmlStr += paramTagXmlStr; 
				objResXmlStr += "</Param></Res>";
				
				//alert(objResXmlStr);
				//return;
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId;
				
				var operationId = "CTL_LA_RemoveActionFromPlan";
				
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\"SELF\" Idx=\"0\" OptID=\""+operationId+"\"><Param Name=\""+params.name+"\" /></DstRes></Cmd><ObjSets >"+objResXmlStr+"</ObjSets></Msg>"; 
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr}); // alert(requestParamStr);  
				
				var rvstr = conn.nc.SendRequest(19,csuPuid,requestParamStr); // alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#"); 
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML objtree load error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;
						}
						
						var jsonResource = xmlObj.parseXML(rvstr);  // alert(Object.toJSON(jsonResource));
						
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
						{
							if(jsonResource.Msg.Cmd.DstRes.OptID && jsonResource.Msg.Cmd.DstRes.OptID == operationId && jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
							{  
								return Nrcap2.NrcapError.NRCAP_SUCCESS;
							}
							else
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (ErrorCode) error! error code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;	
								}								
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (OptID) error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;	
								}
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Msg Name or Msg Cmd) error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;	
						}
						
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error, not find XML string!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;		
					}
				}
				else
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"return error, not find char '#'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;
				}
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! Source = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFORMPLAN_FAILED;
			}
		},

		/* 手动启动一个联动计划 */
		ManualTriggerPlan:function(connectId, csuPuid, LAPlanName){
			try
			{
				var fn = "Nrcap2.PlanformLinkAction.ManualTriggerPlan";
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});  
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				
				if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				} 
				
				if(!LAPlanName || typeof LAPlanName == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"LAPlanName(null+) error!"});  
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_MANUALTRIGGERPLAN_FAILED;
				}
				else
				{
					var allPlanNames = this.GetAllPlanNames(connectId, csuPuid);	 // alert(allPlanNames);
					if(!allPlanNames || typeof allPlanNames != "object" || allPlanNames.constructor != Array)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"get allPlanNames error!"}); 
					}
					else
					{
						if(allPlanNames.length < 0 || allPlanNames.indexOf(LAPlanName) == -1)
						{
							Nrcap2.Debug.Write({fn:fn,msg:"plan name no exists in platform!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_MANUALTRIGGERPLAN_FAILED;
						}
					} 
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId;
				
				var operationId = "CTL_LA_ManualTriggerPlan";
				
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\"SELF\" Idx=\"0\" OptID=\""+operationId+"\"><Param Name=\""+LAPlanName+"\" /></DstRes></Cmd></Msg>";
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr}); // alert(requestParamStr);  
				
				var rvstr = conn.nc.SendRequest(19,csuPuid,requestParamStr); // alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#");  
				
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML objtree load error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_MANUALTRIGGERPLAN_FAILED;
						}
						
						var jsonResource = xmlObj.parseXML(rvstr);  // alert(Object.toJSON(jsonResource));
						
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
						{
							if(jsonResource.Msg.Cmd.DstRes.OptID && jsonResource.Msg.Cmd.DstRes.OptID == operationId && jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
							{  
								return Nrcap2.NrcapError.NRCAP_SUCCESS;
							}
							else
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (ErrorCode) error! error code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_MANUALTRIGGERPLAN_FAILED;	
								}								
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (OptID) error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_MANUALTRIGGERPLAN_FAILED;	
								}
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Msg Name or Msg Cmd) error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_MANUALTRIGGERPLAN_FAILED;	
						}
						
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error, not find XML string!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_MANUALTRIGGERPLAN_FAILED;		
					}
				}
				else
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"return error, not find char '#'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_MANUALTRIGGERPLAN_FAILED;
				}
				
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! Source = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_MANUALTRIGGERPLAN_FAILED;
			}
		},
		
		/* 手动停止一个联动计划 */
		ManualStopPlan:function(connectId, csuPuid, LAPlanName){
			try
			{
				var fn = "Nrcap2.PlanformLinkAction.ManualStopPlan";
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});  
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				
				if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				} 
				
				if(!LAPlanName || typeof LAPlanName == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"LAPlanName(null+) error!"});  
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_MANUALTRIGGERPLAN_FAILED;
				}
				else
				{
					var allPlanNames = this.GetAllPlanNames(connectId, csuPuid);	 // alert(allPlanNames);
					if(!allPlanNames || typeof allPlanNames != "object" || allPlanNames.constructor != Array)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"get allPlanNames error!"}); 
					}
					else
					{
						if(allPlanNames.length < 0 || allPlanNames.indexOf(LAPlanName) == -1)
						{
							Nrcap2.Debug.Write({fn:fn,msg:"plan name no exists in platform!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_MANUALTRIGGERPLAN_FAILED;
						}
					} 
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId;
				
				var operationId = "CTL_LA_ManualStopPlan";
				
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\"SELF\" Idx=\"0\" OptID=\""+operationId+"\"><Param Name=\""+LAPlanName+"\" /></DstRes></Cmd></Msg>";
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr}); // alert(requestParamStr);  
				
				var rvstr = conn.nc.SendRequest(19,csuPuid,requestParamStr); // alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#");   
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML objtree load error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_MANUALSTOPPLAN_FAILED;
						}
						
						var jsonResource = xmlObj.parseXML(rvstr);  // alert(Object.toJSON(jsonResource));
						
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
						{
							if(jsonResource.Msg.Cmd.DstRes.OptID && jsonResource.Msg.Cmd.DstRes.OptID == operationId && jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
							{  
								return Nrcap2.NrcapError.NRCAP_SUCCESS;
							}
							else
							{
								if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (ErrorCode) error! error code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_MANUALSTOPPLAN_FAILED;	
								}								
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (OptID) error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_MANUALSTOPPLAN_FAILED;	
								}
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"return error, some XML nodes (Msg Name or Msg Cmd) error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_MANUALSTOPPLAN_FAILED;	
						}
						
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error, not find XML string!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_MANUALSTOPPLAN_FAILED;		
					}
				}
				else
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"return error, not find char '#'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_MANUALSTOPPLAN_FAILED;
				}
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! Source = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_PLATFORMLA_MANUALSTOPPLAN_FAILED;
			}
		},
		
		end:true
	},
	
	/*
	*	函数名   ：	GPS
	*	函数功能	：	GPS对象
	*	备注		： 
	*	作者		：	huzw
	*	时间		：	2011.06.08
	*/
	GPS:{
		gpsDatas:new Hash(),
		
		UnLoad:function(){
			if(this.gpsDatas)
			{
				this.gpsDatas.each
				(
				 	function(item)
					{
						var node = item.value;
						if(node.inited || node.status)
						{							
							node.Close(); // 关闭数据通道 	
						}
					}
				);
			}
		},
		
		/* 创建一个gps数据收集(dc)通道实例 */
		Create:function(connectId, puid, resType, resIdx, streamType, customParams){
			try
			{ 
				var fn = "Nrcap2.GPS.Create";
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				if(!puid || !Nrcap2.puidRex.test(puid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				} 
				if(typeof resType == "undefined" || resType != "GPS")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"resType error! should be string 'GPS'!"});
					return false;
				}  
				if(typeof resIdx == "undefined" ||!Nrcap2.intRex.test(resIdx))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"resIdx error!"});
					return false;
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId;
				
				var gpsdckey = ""; gpsdckey = puid; // 以puid为键值 
				
				/* 创建数据通道实例 */
				var t_dcname = new Date().getTime() + "" + Math.round(Math.random*(999-100+1)+100) + "_dc";
				if(!document.getElementById(t_dcname))
				{
					document.getElementById("Nrcap2Box").innerHTML = Nrcap2.PlugHtml.get("dc").replace("id=\"@id\" name=\"@name\"","id=\""+ t_dcname +"\" name=\""+ t_dcname +"\"");
				}
				
				customParams = (typeof customParams != "undefined" ? customParams : null);	
				
				var objGPSDc = new Nrcap2.Struct.GPSDataCollectionStruct(
					gpsdckey,
					connectId,
					document.getElementById(t_dcname),
					puid,
					resType,
					resIdx,
					streamType,
					customParams,
					null,
					null,
					null
				); 
				objGPSDc.Open = function(){
					return Nrcap2.GPS.Open(this);
				};
				objGPSDc.GetOpenStatus = function(){
					return Nrcap2.GPS.GetOpenStatus(this);
				};
				objGPSDc.Close = function(){
					return Nrcap2.GPS.Close(this);
				};
				objGPSDc.GetGPSCurrentStatus = function(){
					return Nrcap2.GPS.GetGPSCurrentStatus(this);
				};
				
				if(this.gpsDatas.get(gpsdckey))
				{
					this.gpsDatas.get(gpsdckey).Close();
					this.gpsDatas.unset(gpsdckey);
				} 
				
				this.gpsDatas.set(gpsdckey,objGPSDc);
				
				objGPSDc.Open(); // create gps dc firstly
				
				return objGPSDc;
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Create gps exception error! code=" + e.message + ":" + e.name});
				return false;
			}  
		},
		
		Open:function(objGPSDc)
		{
			try
			{
				var fn = "Nrcap2.GPS.Open"; 
				
				if(objGPSDc && objGPSDc.dc)
				{
					if(objGPSDc.inited)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"gps dc have created!"});
						return Nrcap2.NrcapError.NRCAP_SUCCESS;
					}
					
					var connectId = objGPSDc.connectId;
					
					var conn = Nrcap2.Connections.get(connectId);
					var epId = conn.connParam.epId;
					var nc7_session = conn.session; // NC7句柄
					//alert();
					 
					var paramstr = nc7_session +","+ epId+","+ objGPSDc.puid+","+ objGPSDc.resType+","+objGPSDc.resIdx +","+ "CTL_SCHEDULER_StartStream" +","+ "<Param StreamType=\""+objGPSDc.streamType+"\" StreamTranMode=\"AUTO\"></Param>"; // alert(paramstr);		
					
					Nrcap2.Debug.Write({fn:fn, msg:paramstr}); // 参数串 
					// 向平台获取Token
					var gpsToken = objGPSDc.dc.GetTokenFromPlatform(nc7_session, epId, objGPSDc.puid, objGPSDc.resType, objGPSDc.resIdx, "CTL_SCHEDULER_StartStream", "<Param StreamType=\""+objGPSDc.streamType+"\" StreamTranMode=\"AUTO\"></Param>");  

					// var gpsToken = objGPSDc.dc.GetTokenFromDev(nc7_session, epId, objGPSDc.puid, objGPSDc.resType, objGPSDc.resIdx, "CTL_COMMONRES_StartStream_PullMode", "<Param StreamType=\""+objGPSDc.streamType+"\" StreamTranMode=\"AUTO\"></Param>");   
					  
					Nrcap2.Debug.Write({fn:fn, msg:"puid:"+ objGPSDc.puid + ", gpsToken:"+gpsToken});
					
					var gpsTokenArr = gpsToken.split("#");
					 
					if(gpsTokenArr[0] && parseInt(gpsTokenArr[0]) == 0x0000)
					{
						var bsc = Nrcap2.Plug.bsc;
						var bsp = Nrcap2.Plug.bsp;
						
						bsc.reset(1);
						bsc.addUInt(parseInt(gpsTokenArr[1]));  
						bsp.attachBuffer(bsc.getBuffer(),bsc.getLength(),1);
						
						var bspIP = bsp.parseIp();
						
						Nrcap2.Debug.Write({fn:fn, msg:"dc id="+bspIP+",port="+parseInt(gpsTokenArr[2])+",token="+gpsTokenArr[3]});
						
						var dc7_session = objGPSDc.dc.OpenNB(bspIP, parseInt(gpsTokenArr[2]), gpsTokenArr[3], "", "");
						
						Nrcap2.Debug.Write({fn:fn, msg:"dc dc7_session="+dc7_session});
						
						if(parseInt(dc7_session) == 0x0000)
						{
							Nrcap2.Debug.Write({fn:fn, msg:"create a dc error, dc7_session is 0x00000000"});
							return false;
						} 
						
						objGPSDc.session = dc7_session; // dc7句柄
          				objGPSDc.inited = true;
						 
						Nrcap2.Debug.Write({fn:"Nrcap2.GPS.Stop",msg:"open GPS dc success!"});
						return Nrcap2.NrcapError.NRCAP_SUCCESS;
					} 
					else
					{ 
						// Nrcap2.Debug.Write({fn:fn, msg:"puid:"+ objGPSDc.puid + ", gpsToken:error!"});
						Nrcap2.GPS.Close(objGPSDc); // 要关闭通道
					}
					 
					Nrcap2.Debug.Write({fn:"Nrcap2.GPS.Stop",msg:"open GPS dc error(token null)!"});
					return false;
				}
				else
                {
                    return Nrcap2.NrcapError.NRCAP_ERROR_LOADPLUG_DC;
                }
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.GPS.Start",msg:"exception,error = " + e.message + "::" + e.name});
				return false;
			}
		},
		 
		GetOpenStatus:function(objGPSDc)
		{
			try
			{
				var fn = "Nrcap2.GPS.Close";
				
				if(objGPSDc && objGPSDc.dc)
				{ 
					var queryrv = objGPSDc.dc.GetOpenStatus();
			 
			 		if(parseInt(queryrv) < 0)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"GPS dc status false!"});
						Nrcap2.GPS.Close(objGPSDc); // 关闭通道
					} 
					else if(parseInt(queryrv) == 0)
					{
						objGPSDc.status = true;	
					}					
					else if(parseInt(queryrv) == 1)
					{
						objGPSDc.status = false;	
					}
					
					return Nrcap2.NrcapError.NRCAP_SUCCESS;
				}
				else
                {
                    return Nrcap2.NrcapError.NRCAP_ERROR_LOADPLUG_DC;
                }
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.GPS.Stop",msg:"exception,error = " + e.message + "::" + e.name});
				return false;
			}
		},
		
		Close:function(objGPSDc)
		{
			try
			{
				if(objGPSDc && objGPSDc.dc)
				{
					objGPSDc.dc.Close(); 
					objGPSDc.inited = false;
					objGPSDc.status = false;
					
					Nrcap2.Debug.Write({fn:"Nrcap2.GPS.Stop",msg:"stop GPS dc success!"});
					return Nrcap2.NrcapError.NRCAP_SUCCESS;
				}
				else
                {
                    return Nrcap2.NrcapError.NRCAP_ERROR_LOADPLUG_DC;
                }
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.GPS.Close",msg:"exception,error = " + e.message + "::" + e.name});
				return false;
			}
		},
		
		GetGPSCurrentStatus:function(objGPSDc){ 
			try
			{
				var fn = "Nrcap2.GPS.GetGPSCurrentStatus"; 
				
				if(objGPSDc && objGPSDc.dc)
				{
					if(typeof objGPSDc != "object" || !objGPSDc instanceof Nrcap2.Struct.GPSDataCollectionStruct)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"objGPSDc struct error!"});
						return false;
					}
				
					var curGPSLists = new Array();
					
					Nrcap2.GPS.GetOpenStatus(objGPSDc); // 探测数据通道是否连接成功
					
					if(objGPSDc.inited != true)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"create GPS dc not inited!"});
						Nrcap2.GPS.Open(objGPSDc); // 开始重新打开
						return curGPSLists;
					} 
					
					if(objGPSDc.status != true)
					{ 
						Nrcap2.GPS.GetOpenStatus(objGPSDc); // 探测数据通道是否连接成功
						return curGPSLists;
					}
					
					// 获取一帧信息 
					var oneFrameData = objGPSDc.dc.RecvFrame();
					// alert(oneFrameData); //return {puid:objGPSDc.puid}; 
					
					var ofdArr = oneFrameData.split("#");
					
					if(ofdArr[0] != null && typeof ofdArr[0] != "undefined")
					{
						switch(parseInt(ofdArr[0]))
						{
							case 0:
								// 格式化解析出的字符串值 
								var _FormatNumber = function(num,decimalNum,bolLeadingZero,bolParens,bolCommas)   
								{   
									if(isNaN(parseInt(num)))
										return   "NaN";   
									var tmpNum = num;   
									var iSign = num   <   0   ?   -1   :   1; // 得到数字符号   
									
								    // 调整小数点位数到给定的数字/ 
									tmpNum *= Math.pow(10,decimalNum);   
									tmpNum = Math.round(Math.abs(tmpNum))
									tmpNum /= Math.pow(10,decimalNum); 
									tmpNum *= iSign; // 重新调整符号   
									var tmpNumStr = new String(tmpNum);   
									
								    // 处理是否有前导0   
									if(!bolLeadingZero && num < 1 && num > -1 && num != 0)   
										if(num > 0)   
											tmpNumStr = tmpNumStr.substring(1,tmpNumStr.length);   
										else   
											tmpNumStr = "-" + tmpNumStr.substring(2,tmpNumStr.length);   
									
								    // 处理是否有逗号   
									if (bolCommas && (num >= 1000 ||num <= -1000)) 
									{   
										var iStart = tmpNumStr.indexOf(".");   
										if(iStart < 0)   
											iStart = tmpNumStr.length;   
										iStart -= 3;   
										while (iStart >= 1)
										{
											tmpNumStr = tmpNumStr.substring(0,iStart) + "," + tmpNumStr.substring(iStart,tmpNumStr.length)   
											iStart   -=   3;   
										}   
									}   
									
								    // 处理是否有括号   
									if(bolParens && num < 0)   
										tmpNumStr = "(" + tmpNumStr.substring(1,tmpNumStr.length) + ")";   
									 return   tmpNumStr; // 返回格式化后字符串   
								}; 
								
								var bsc = Nrcap2.Plug.bsc;
								var bsp = Nrcap2.Plug.bsp; 
								
								// 解析出获取的gps数据
								var binFrameBuf = parseInt(ofdArr[1]);
								var frameLen = parseInt(ofdArr[2]);
								var frameInfo = parseInt(ofdArr[3]);
								var infoLen = ofdArr[4];
								
								bsp.attachBuffer(binFrameBuf, frameLen, 1);
								var latitude = _FormatNumber(bsp.parseFloat(), 6, false, false, false); // 纬度
								var longitude = _FormatNumber(bsp.parseFloat(), 6, false, false, false); // 经度
								var bearing = _FormatNumber(bsp.parseFloat(), 6, false, false, false); // 方向
								var speed = _FormatNumber(bsp.parseFloat(), 6, false, false, false); // 速度
								var altitude = _FormatNumber(bsp.parseFloat(), 6, false, false, false); // 海拔
								 
								//time = bsp.parseUint();  // alert(time);
								var time = _FormatNumber(bsp.parseUint(), 6, false, false, false); // 时间 
								time = Nrcap2.Utility.DateFormat("yyyy-MM-dd HH:mm:ss", new Date(parseInt(time)*1000)); 
								
								rv = bsp.parseShort(); // 保留字 

								var state = bsp.parseChar(); // 设备状态  
								 
								var maxspeed = _FormatNumber(bsp.parseShort(), 6, false, false, false);// 最高限速 
								var minspeed = _FormatNumber(bsp.parseShort(), 6, false, false, false);// 最低限速		
								rv = bsp.parseInt(); // 保留字   
								 
								var curGPSLists = new Nrcap2.Struct.GPSDataInfoStruct(objGPSDc.puid, objGPSDc.resType, objGPSDc.resIdx, time, longitude, latitude, bearing, altitude, state, speed, maxspeed, minspeed, 0);  
								
								Nrcap2.Debug.Write({fn:fn,msg:"GPS dc frame >" + Object.toJSON(curGPSLists)}); 
								
								return curGPSLists;
								break;
							case 1:
								Nrcap2.Debug.Write({fn:fn,msg:"GPS dc null frame, continue get!"}); 
								break;
							default:
								Nrcap2.Debug.Write({fn:fn,msg:"GPS dc frame error!"}); 
								Nrcap2.GPS.Close(objGPSDc);
								break; 
						}  
					}
					else  
					{
						Nrcap2.Debug.Write({fn:fn,msg:"GPS dc get data error!"}); 						
					} 
					
					return curGPSLists;
				}
				else
                {
					Nrcap2.Debug.Write({fn:fn,msg:"dc load error!"});
                    return Nrcap2.NrcapError.NRCAP_ERROR_LOADPLUG_DC;
                }
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"exception,error = " + e.message + "::" + e.name});
				return false;
			}						
		}, 
		
		/* 获取历史GPS数据 */
		GetGPSHistory:function(connectId, csuPuid, puid, resType, resIdx, beginTime, endTime, offset, count){
			try
			{
				var fn = "Nrcap2.GPS.GetGPSHistory";
				
				if(!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				} 
				if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				} 
				if(!puid || !Nrcap2.puidRex.test(puid))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"csuPuid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				} 
				if(typeof resType == "undefined" || resType != "GPS")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"resType error! should be string 'GPS'!"});
					return false;
				}  
				if(typeof resIdx == "undefined" ||!Nrcap2.intRex.test(resIdx))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"resIdx error!"});
					return false;
				}
				 
				if(!beginTime || typeof beginTime == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"beginTime error!"});
					return false;
				}
				if(!endTime || typeof endTime == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"beginTime error!"});
					return false;
				} 
				 
			    bTimeUTC = new Date(beginTime.replace(/-/g,"/")).getTime()/1000;
				eTimeUTC = new Date(endTime.replace(/-/g,"/")).getTime()/1000; 
				
				var oft = 0, cnt = 200; // 暂为固定值 
			    
				if(arguments[7] != null && typeof arguments[7] != "undefined")
				{
					oft = parseInt(arguments[7]);
				} 
			 	
				if(arguments[8] != null && typeof arguments[8] != "undefined")
				{
					cnt = parseInt(arguments[8]);
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId; 
				
				var operationId = "CTL_SC_QueryHistoryGPSData";
				 
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\"SC\" Idx=\"0\" OptID=\""+operationId+"\"><Param Offset=\""+oft+"\" Cnt=\""+cnt+"\" BeginTime=\""+bTimeUTC+"\" EndTime=\""+eTimeUTC+"\" ></Param></DstRes></Cmd><ObjSets><Res ObjType=\"151\" ObjID=\""+puid+"\" Type=\""+resType+"\" Idx=\""+resIdx+"\" CmdType=\"CTL\" OptID=\""+operationId+"\" EPID=\""+epId+"\" ></Res></ObjSets></Msg>"; 
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr}); // alert(requestParamStr);
				
				var rvstr = conn.nc.SendRequest(151, csuPuid, requestParamStr); // alert(rvstr); return;
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#");
				
				var gpsLists = [];
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML ObjTree load error!"});
							return [];	
						}
						
						var jsonResource = xmlObj.parseXML(rvstr);  // alert(Object.toJSON(jsonResource));
						
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes && jsonResource.Msg.Cmd.DstRes.OptID == operationId)
						{ 
							if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
							{
								Nrcap2.Debug.Write({fn:fn,msg:"DstRes ErrorCode = " + jsonResource.Msg.Cmd.NUErrorCode});
								return [];
							}
							
							if(jsonResource.Msg.Cmd.DstRes.Param && jsonResource.Msg.Cmd.DstRes.Param.Res && jsonResource.Msg.Cmd.DstRes.Param.Res.ObjID == puid)
							{ 
								var Res = jsonResource.Msg.Cmd.DstRes.Param.Res;
								var objId = Res.ObjID, type = Res.Type, idx = Res.Idx, GPS = Res.GPS;
								
								if(GPS && typeof GPS == "object")
								{  
									// 获取组合gpsLists
									var _getGPSlists = function(gps){
										if(gps && typeof gps == "object")
										{
											var gpstime = Nrcap2.Utility.DateFormat("yyyy-MM-dd HH:mm:ss",new Date(parseInt(gps.UTC) * 1000));  
											gpsLists.push(new Nrcap2.Struct.GPSDataInfoStruct(objId, type, idx, gpstime, gps.Longitude, gps.Latitude, gps.Bearing, gps.Altitude, gps.State, gps.Speed, gps.MaxSpeed, gps.MinSpeed, gps.Timestamp));	
										}
									};
									
									if(GPS.constructor == Array)
									{   
										GPS.each
										(
										 	function(gps)
											{ 
												_getGPSlists(gps); // 内部函数
											}
										);  
									}
									else
									{ 
										_getGPSlists(GPS); // 内部函数
									} 
								}
								else
								{
									Nrcap2.Debug.Write({fn:fn,msg:"typeof GPS error!"});
									return [];	
								}
							}
							else
							{
								Nrcap2.Debug.Write({fn:fn,msg:"Param Res or ObjID error!"});
								return [];	
							}
							
							
						}
						else if(jsonResource && jsonResource.Msg && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRep" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.NUErrorCode)
						{
							Nrcap2.Debug.Write({fn:fn,msg:"NUErrorCode = " + jsonResource.Msg.Cmd.NUErrorCode});
							return [];
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"Msg Name or Cmd OptID error!"});
							return [];	
						}
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error, not find xml string!"});
						return [];
					}
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"return error, not find char '#'!"});
					return [];
				}  
				
				return gpsLists.uniq();
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"get gps history exception error! code=" + e.message + ":" + e.name});
				return false;
			}
		},
		
		end:true
	},
	
	PTZ:{
	    
	    /*
	    *	函数名		：	PTZ.Init
	    *	函数功能	：	提供的标准化控制
	    *	备注		： 
	    *	作者		：	huzw
	    *	时间		：	2010年12月13日 
	    *	返回值		：	对应NrcapError
	    *	参数说明	：	3个参数 
	    *			object objWnd		视频窗口对象
	    *			string control		云台控制状态[PTZControl对象，启动/停止]
	    *			string direction	云台控制方向[PTZDirection对象]
	    */
	    Init:function(objWnd, control, direction){
	        if(!objWnd || !objWnd.wnd)
		    {
		        Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.Init",msg:""});
			    return Nrcap2.NrcapError.NRCAP_ERROR_WINDOW_FAILD;
		    }
    		
		    if(!objWnd.status.playvideoing)
		    {
			    return Nrcap2.NrcapError.NRCAP_ERROR_VIDEOTOPPED;
		    }
	        if(!direction || typeof direction == "undefined")
	        {
	            Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.Control",msg:"PTZ direction error!"});
	            return Nrcap2.NrcapError.NRCAP_ERROR_PTZCONTROL_ERROR;
	        }
	        
	        if(control == Nrcap2.Enum.PTZControl["stop"])
	        {
	            switch(direction.toLowerCase())
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
	        
	        var rv = Nrcap2.PTZ.Control(objWnd.connectId, objWnd.params.puid, objWnd.params.idx, direction);
	        
	        return rv;
	    },
	    
	    /*
	    *	函数名		：	PTZ.Control
	    *	函数功能	：	云台控制
	    *	备注		： 
	    *	作者		：	huzw
	    *	时间		：	2010年12月13日 
	    *	返回值		：	对应NrcapError
	    *	参数说明	：	3个参数 
	    *			string connectId	视频所属连接ID
	    *           string puid         设备的PUID
	    *           Uint idx          	设备的IV索引
	    *			string direction	云台控制方向[PTZDirection对象]
	    */
	    Control:function(connectId, puid, idx, direction){
	        if(!connectId || !Nrcap2.Connections.get(connectId))
	        {
	            Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.Control",msg:"connectId error!"});
			    return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
	        }
	        if(!puid || !Nrcap2.puidRex.test(puid))
	        {
	            Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.Control",msg:"IV puid error!"});
			    return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
		    }
		    if(typeof idx == "undefined" || !Nrcap2.intRex.test(idx))
		    {
			    Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.Control",msg:"IV idx error!"+"_"+idx});
			    return false;
		    }
		    
		    //var PTZDirection = Nrcap2.Enum.PTZDirection[direction.toLowerCase()]; //应该废弃
		    var PTZDirection = direction;
			
		    if(!PTZDirection || typeof PTZDirection == "undefined")
	        {
	            Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.Control",msg:"PTZ direction error!"});
	            return Nrcap2.NrcapError.NRCAP_ERROR_PTZCONTROL_ERROR;
	        }
	        
	        var conn = Nrcap2.Connections.get(connectId);
	        var epId = conn.connParam.epId; //企业ID
	        
	        //发送控制命令	send control mission		 
  			var requestParamStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n\t<Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\">\r\n\t\t<Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\">\r\n\t\t\t<DstRes Type=\"PTZ\" Idx=\""+idx+"\" OptID=\""+PTZDirection+"\">\r\n\t\t\t\t<Param Degree=\"0\">\r\n\t\t\t\t</Param>\r\n\t\t\t</DstRes>\r\n\t\t</Cmd>\r\n\t</Msg>\r\n"; 
  			
  			Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.Control",msg:"Request:" + requestParamStr}); // alert(requestParamStr);
			
			//requestParamStr = conn.nc.GbktoUtf8(requestParamStr);  
	        
       		var rvstr = conn.nc.SendRequest(151, puid, requestParamStr); // alert(rvstr);

			//rvstr = conn.nc.Utf8toGbk(rvstr); 
  			  
		    Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.Control",msg:"Response:" + rvstr});
		    
		    var rvSplitIndex = rvstr.indexOf("#");
			if(rvSplitIndex > -1)
			{
				rvstr = rvstr.substr(rvSplitIndex + 1); 				
				if(rvstr.length > 0)
				{
					var xmlObj =new XML.ObjTree();
					if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
					{
						Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.Control",msg:"XML objtree load error!"});
						return false;
					}
					
					var jsonResource = xmlObj.parseXML(rvstr); 	
					if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
					{
						var res = jsonResource.Msg.Cmd.DstRes;
						if(res.Type == "PTZ" && res.Idx == idx && res.OptID == PTZDirection)
						{
							if(res.ErrorCode == "0")
							{
							    Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.Control",msg:"PTZ control success!"});
								return Nrcap2.NrcapError.NRCAP_SUCCESS;
							}							
							else
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.Control",msg:"Control ErrorCode="+res.ErrorCode});
								return Nrcap2.NrcapError.NRCAP_ERROR_PTZCONTROL_FAILED;
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.Control",msg:"PTZ control failed!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PTZCONTROL_FAILED;
						}
					}
					else
					{
						Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.Control",msg:"Msg Cmd or Msg OptID error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PTZCONTROL_FAILED;
					}
				} 
			}
			else
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.Control",msg:"PTZ direction fiald!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_PTZCONTROL_FAILED;
			}    
	    },
	    
		/*
		*	函数名		:	GetSpeed
		*	函数功能	：	获取云台速度 
		*	备注		： 
		*	作者		：	huzw
		*	时间		：	2011年03月28日 
		*	返回值		：	number
		*	参数说明	：	3个参数 
		*			string  connectId	所属连接ID 			
		*           string puid         设备的PUID
	    *           Uint idx          	设备的IV索引
		*	        string  param		设置云台速度的参数, Nrcap2.Enum.ConfigID对象值  
		*/
		GetSpeed:function(connectId,puid,idx,param){
			if(!connectId || !Nrcap2.Connections.get(connectId))
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.GetSpeed",msg:"connectId error!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
			}
			if(!puid || !Nrcap2.puidRex.test(puid))
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.GetSpeed",msg:"IV puid error!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
			}
			if(idx == null || typeof idx == "undefined" || !Nrcap2.intRex.test(idx))
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.GetSpeed",msg:"IV idx error!"});
				return false;
			}
			
			if(!param || typeof param != "string")
			{
				return false;
			}
			
			var rv = 0 , rvstr = "", ptzParam = "";
			
			ptzParam = Nrcap2.Enum.ConfigID[param];
		
			rvstr = Nrcap2.Connections.get(connectId).nc.GetConfig(151, puid, Nrcap2.Enum.PuResourceType.PTZ, idx, "", ptzParam);
			//alert(rvstr);
			rvstr = rvstr.toString();
		
			if(parseInt(rvstr.split("#")[0]) == 0x0000)
			{
				rv = rvstr.split("#")[1];
			} 
			else 
			{ 
				Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.GetSpeed",msg:"get input video params failed,error="+ rvstr});  
				rv = rvstr.split("#")[0];
			}
			
			return parseInt(rv);
		},
		
		/*
		*	函数名		:	SetSpeed
		*	函数功能	：	设置云台速度 
		*	备注		： 
		*	作者		：	huzw
		*	时间		：	2011年03月28日 
		*	返回值		：	number
		*	参数说明	：	3个参数 
		*			string  connectId	所属连接ID 			
		*           string puid         设备的PUID
	    *           Uint idx          	设备的IV索引
		*	        string  param		设置云台速度的参数, Nrcap2.Enum.ConfigID对象值  
		*			uint	value		设置云台速度参数值 
		*/
		SetSpeed:function(connectId,puid,idx,param,value){
			if(!connectId || !Nrcap2.Connections.get(connectId))
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.SetSpeed",msg:"connectId error!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
			}
			if(!puid || !Nrcap2.puidRex.test(puid))
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.SetSpeed",msg:"IV puid error!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
			}
			if(idx == null || typeof idx == "undefined" || !Nrcap2.intRex.test(idx))
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.SetSpeed",msg:"IV idx error!"});
				return false;
			}
			
			if(!param || typeof param != "string")
			{
				return false;
			} 
			
			if(value == null || typeof value == "undefined")
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.SetSpeed",msg:"set param value error!"});
				return false;
			} 
			
			var rv = 0 , rvstr = "", ptzParam = "";
			
			ptzParam = Nrcap2.Enum.ConfigID[param];
		
			rvstr = Nrcap2.Connections.get(connectId).nc.SetConfig(151,puid,Nrcap2.Enum.PuResourceType.PTZ,idx,"",ptzParam,value);
			//alert(rvstr);
			rvstr = rvstr.toString();
		
			if(parseInt(rvstr.split("#")[0]) == 0x0000)
			{
				rv = Nrcap2.NrcapError.NRCAP_SUCCESS; 
			} 
			else 
			{ 
				Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.SetSpeed",msg:"get input video params failed,error="+ rvstr});  
				rv = parseInt(rvstr.split("#")[0]);
			}
			
			return rv;
		},
		 
		/*
		*	函数名		:	PresetPosControl
		*	函数功能	：	云台预置位控制 
		*	备注		： 
		*	作者		：	huzw
		*	时间		：	2011年04月18日 
		*	返回值		：	number
		*	参数说明	：	6个参数 
		*			string connectId	视频所属连接ID
	    *           string puid         设备的PUID
	    *           Uint idx          	设备的IV索引
		*			string action 		动作["set":设置预置位,"get":前往预置位]
	    *			Unit presetPos		预置位的编号 
		*			string presetName   预置位的名称[action = 'set'使用]
		*/
		PresetPosControl:function(connectId,puid,idx,action,presetPos,presetName){
			if(!connectId || !Nrcap2.Connections.get(connectId))
	        {
	            Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.PresetPosControl",msg:"PTZ PresetPosControl connectId error!"});
			    return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
	        }
	        if(!puid || !Nrcap2.puidRex.test(puid))
	        {
	            Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.PresetPosControl",msg:"PTZ PresetPosControl IV puid error!"});
			    return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
		    } 
		    if(typeof idx == "undefined" || !Nrcap2.intRex.test(idx))
		    {
			    Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.PresetPosControl",msg:"PTZ PresetPosControl IV idx error!"});
			    return  Nrcap2.NrcapError.NRCAP_ERROR_PRESETPOSCONTROL_PARAM_FAILED;
		    } 
			if(typeof presetPos == "undefined" || !Nrcap2.intRex.test(presetPos))
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.PresetPosControl",msg:"PTZ PresetPosControl presetPos error!"});
			    return  Nrcap2.NrcapError.NRCAP_ERROR_PRESETPOSCONTROL_PARAM_FAILED;
			}
			
			if(typeof action == "undefined" || (action != "set" && action != "get"))
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.PresetPosControl",msg:"PTZ PresetPosControl action error!"});
				return  Nrcap2.NrcapError.NRCAP_ERROR_PRESETPOSCONTROL_PARAM_FAILED;
			}
			
			if(action == "set")
			{
			 	if(!presetName || !Object.isString(presetName) || !Nrcap2.Utility.CheckByteLength(presetName,0,63))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.PresetPosControl",msg:"PTZ presetName error!"});
					return  Nrcap2.NrcapError.NRCAP_ERROR_PRESETPOSCONTROL_PARAM_FAILED;
				}
			}
			
			var conn = Nrcap2.Connections.get(connectId);
	        var epId = conn.connParam.epId; //企业ID
	        
	        //发送控制命令	send control mission	
			var requestParamStr = "";
				requestParamStr += "<?xml version=\"1.0\" encoding=\"utf-8\" ?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\">";
				requestParamStr += (action == "get" ? "<DstRes Type=\"PTZ\" Idx=\""+idx+"\" OptID=\"CTL_PTZ_MoveToPresetPos\"><Param PresetPos=\""+presetPos+"\"></Param></DstRes>" : "<DstRes Type=\"PTZ\" Idx=\""+idx+"\" OptID=\"CTL_PTZ_SetPresetPos\"><Param PresetPos=\""+presetPos+"\" Name=\""+presetName+"\"></Param></DstRes>");
				requestParamStr += "</Cmd></Msg>";
			
			//alert("ptz PresetPosControl request::" + requestParamStr);
			
			Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.PresetPosControl",msg:"Request:" + requestParamStr});
			
			var rvstr = conn.nc.SendRequest(151,puid,requestParamStr);  //alert("ptz PresetPosControl response::" + rvstr);	
			
			Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.PresetPosControl",msg:"Response:" + rvstr});
			 
			var rvSplitIndex = rvstr.indexOf("#");
			if(rvSplitIndex > -1)
			{
				rvstr = rvstr.substr(rvSplitIndex + 1); 				
				if(rvstr.length > 0)
				{ 
					var xmlObj = new XML.ObjTree();
					if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
					{
						Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.PresetPosControl",msg:"XML objtree load error!"});
						return false;
					}
					  
					var jsonResource = xmlObj.parseXML(rvstr); // alert(Object.toJSON(jsonResource));	
					if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
					{
						var res = jsonResource.Msg.Cmd.DstRes;
						if(res.Type == "PTZ" && res.Idx == idx && res.OptID == (action == "get" ? "CTL_PTZ_MoveToPresetPos" : "CTL_PTZ_SetPresetPos"))
						{
							if(res.ErrorCode == "0")
							{
							    Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.PresetPosControl",msg:"PTZ PresetPosControl success!"});
								return Nrcap2.NrcapError.NRCAP_SUCCESS;
							}							
							else
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.PresetPosControl",msg:"PresetPosControl ErrorCode="+res.ErrorCode});
								return Nrcap2.NrcapError.NRCAP_ERROR_PRESETPOSCONTROL_FAILED;
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.PresetPosControl",msg:"PTZ PresetPosControl failed!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PRESETPOSCONTROL_FAILED;
						}
					}
					else
					{
						Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.PresetPosControl",msg:"Msg Cmd or Msg OptID error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PRESETPOSCONTROL_FAILED;
					}
				} 
			}
			else
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.PresetPosControl",msg:"PTZ PresetPosControl failed!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_PRESETPOSCONTROL_FAILED;
			}    
			
		}, 
		
	    end:true
	},
	
	/*
	*	函数名		:	PTZControl
	*	函数功能	：	云台控制
	*	备注		： 
	*	作者		：	huzw
	*	时间		：	2010年12月13日 
	*	返回值		：	对应NrcapError
	*	参数说明	：	3个参数 
	*			object objWnd		视频窗口对象
	*			string control		云台控制状态[PTZControl对象，启动/停止]
	*			string direction	云台控制方向[PTZDirection对象]
	*/
	PTZControl:function(objWnd, control, direction)
	{
		if(!objWnd || !objWnd.wnd)
		{
			return Nrcap2.NrcapError.NRCAP_ERROR_WINDOW_FAILD;
		}
		
		if(!objWnd.status.playvideoing)
		{
			return Nrcap2.NrcapError.NRCAP_ERROR_VIDEOTOPPED;
		}
		
		if(typeof direction == "undefined")
		{
			return Nrcap2.NrcapError.NRCAP_ERROR_PTZCONTROL_ERROR;
		}
		direction = direction.toLowerCase();
		var PTZDirection = Nrcap2.Enum.PTZDirection[direction];
		//alert(PTZDirection);
		if(typeof PTZDirection != "undefined")
		{
			if(control == Nrcap2.Enum.PTZControl["stop"])
			{ 
				switch(direction)
				{
					case "turnleft":
					case "turnright":
					case "turnup":
					case "turndown":
					case "stopturn":
						PTZDirection = Nrcap2.Enum.PTZDirection["stopturn"];
				    	break;
						
					case "aperturea":
					case "aperturem":
				    case "stopaperture":
						PTZDirection = Nrcap2.Enum.PTZDirection["stopaperture"];
				    	break;
					
					case "focusfar":
					case "focusnear": 
					case "stopfocus":
						PTZDirection = Nrcap2.Enum.PTZDirection["stopfocus"];
				    	break;
					
					case "zoomin":
					case "zoomout":
					case "stopzoom":
					 	PTZDirection = Nrcap2.Enum.PTZDirection["stopzoom"];
				    	break;
					default:
						PTZDirection = "";
						break;
				}
				//alert(PTZDirection);
				if(PTZDirection == "") return this.NrcapError.NRCAP_ERROR_PTZCONTROL_ERROR;
			}
		 	
			//发送控制命令			 
  			var requestParamStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+Nrcap2.Connections.get(objWnd.connectId).connParam.epId+"\"><DstRes Type=\"PTZ\" Idx=\""+objWnd.idx+"\" OptID=\""+PTZDirection+"\"><Param Degree=\"0\"></Param></DstRes></Cmd></Msg>"; 
		    Nrcap2.Debug.Write({fn:"Nrcap2.PTZControl",msg:"Request:"+requestParamStr});
		   
			//requestParamStr = Nrcap2.Connections.get(objWnd.connectId).nc.GbktoUtf8(requestParamStr);  
	        
       	 	var rvstr = Nrcap2.Connections.get(objWnd.connectId).nc.SendRequest(151,objWnd.puid,requestParamStr);

			//rvstr = Nrcap2.Connections.get(objWnd.connectId).nc.Utf8toGbk(rvstr);  //alert(rvstr); 
			
		    Nrcap2.Debug.Write({fn:"Nrcap2.PTZControl",msg:"Response:" + rvstr}); 
		    
		 	var rvSplitIndex = rvstr.indexOf("#");
			if(rvSplitIndex > -1)
			{
				rvstr = rvstr.substr(rvSplitIndex + 1); 				
				if(rvstr.length > 0)
				{
					var xmlObj =new XML.ObjTree();
					if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
					{
						Nrcap2.Debug.Write({fn:"Nrcap2.PTZControl",msg:"XML objtree load error!"});
						return false;
					}
					
					var jsonResource = xmlObj.parseXML(rvstr);
					if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes)
					{
						var res = jsonResource.Msg.Cmd.DstRes;
						if(res.Type == "PTZ" && res.Idx == objWnd.Idx && res.OptID == PTZDirection)
						{
							if(res.ErrorCode == "0")
							{
							    Nrcap2.Debug.Write({fn:"Nrcap2.PTZ.Control",msg:"PTZ control success!"});
								return Nrcap2.NrcapError.NRCAP_SUCCESS;
							}							
							else
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.PTZControl",msg:"Control ErrorCode="+res.ErrorCode});
								return Nrcap2.NrcapError.NRCAP_ERROR_PTZCONTROL_FAILED;
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.PTZControl",msg:"PTZ control failed!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PTZCONTROL_FAILED;
						}
					}
					else
					{
						Nrcap2.Debug.Write({fn:"Nrcap2.PTZControl",msg:"Msg Cmd or Msg OptID error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PTZCONTROL_FAILED;
					}
				} 
			}
			else
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.PTZControl",msg:"PTZ direction fiald!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_PTZCONTROL_FAILED;
			}
		}
	}, 
	
	/*
	*	函数名		:	GetVideoInParam
	*	函数功能	：	获取视频的参数 
	*	备注		： 
	*	作者		：	huzw
	*	时间		：	2011年03月21日 
	*	返回值		：	number
	*	参数说明	：	3个参数 
	*			string  connectId	所属连接ID 			
	*	        string  control     控制命令
	*	        string  puid		设备puid
	*	        string  param		设置视频的参数, Nrcap2.Enum.ConfigID对象值  
	*/
	GetVideoInParam:function(connectId,puid,idx,param){
		if(!connectId || !Nrcap2.Connections.get(connectId))
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.GetVideoInParam",msg:"connectId error!"});
			return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
		}
		if(!puid || !Nrcap2.puidRex.test(puid))
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.GetVideoInParam",msg:"IV puid error!"});
			return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
		}
		if(idx == null || typeof idx == "undefined" || !Nrcap2.intRex.test(idx))
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.GetVideoInParam",msg:"IV idx error!"});
			return false;
		} 
		
		if(!param || typeof param != "string")
		{
			return false;
		}
		var rv = 0 , rvstr = "", ivParam = "";
		
		ivParam = Nrcap2.Enum.ConfigID[param];
		
		rvstr = Nrcap2.Connections.get(connectId).nc.GetConfig(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,"",param);
		//alert(rvstr);
		
		rvstr = rvstr.toString();
		
		if(parseInt(rvstr.split("#")[0]) == 0x0000)
		{
			rv = rvstr.split("#")[1];
		} 
        else 
        { 
            Nrcap2.Debug.Write({fn:"Nrcap2.GetVideoInParam",msg:"get input video params failed,error="+ rv.toString().split("#")[0]});  
            rv = rvstr.split("#")[0];
        }
		
		return parseInt(rv);
	},
	
	/*
	*	函数名		:	SetVideoInParam
	*	函数功能	：	设置视频的参数 
	*	备注		： 
	*	作者		：	huzw
	*	时间		：	2011年03月24日 
	*	返回值		：	number
	*	参数说明	：	3个参数 
	*			string  connectId	所属连接ID 			
	*	        string  control     控制命令
	*	        string  puid		设备puid
	*	        string  param		设置视频的参数, Nrcap2.Enum.ConfigID对象值  
	*			uint	value		设置视频参数值 
	*/
	SetVideoInParam:function(connectId,puid,idx,param,value){
		if(!connectId || !Nrcap2.Connections.get(connectId))
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.SetVideoInParam",msg:"connectId error!"});
			return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
		}
		if(!puid || !Nrcap2.puidRex.test(puid))
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.SetVideoInParam",msg:"IV puid error!"});
			return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
		}
		if(idx == null || typeof idx == "undefined" || !Nrcap2.intRex.test(idx))
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.SetVideoInParam",msg:"IV idx error!"});
			return false;
		}
		
		if(!param || typeof param != "string")
		{
			return false;
		}
		
		if(value == null || typeof value == "undefined")
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.SetVideoInParam",msg:"set param value error!"});
			return false;
		}
		
		var rv = 0 , rvstr = "", ivParam = "";
		
		ivParam = Nrcap2.Enum.ConfigID[param];
		 
		//alert( puid+ ":" +  idx+ ":" + param + ":" +value);  
		
		rvstr = Nrcap2.Connections.get(connectId).nc.SetConfig(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,"",param,value);
		
		//alert(rvstr); 
		
		rvstr = rvstr.toString();
		
		if(parseInt(rvstr.split("#")[0]) == 0x0000)
		{
			rv = Nrcap2.NrcapError.NRCAP_SUCCESS;   
		} 
        else 
        { 
            Nrcap2.Debug.Write({fn:"Nrcap2.SetVideoInParam",msg:"set input video params failed,error="+ rv.toString().split("#")[0]});  
            rv = parseInt(rvstr.split("#")[0]);
        }
		
		return rv;
	},
	
	/*
	*	函数名	：	QueryFiles
	*	函数功能	：  查询存储文件  
	*	备注		：  无


































	*	作者		：	huzw
	*	时间		：	2011.04.29 
	*	返回值	：	成功返回文件列表（Array），否则对应NrcapError
	*	参数说明	：	5个参数  
	*			string connectId	视频所属连接ID
	*			string puid			设备PUID
	*			uint   idx			资源索引
	*			string streamType	流类型[Nrcap2.Enum.NrcapStreamType对象]
	*			Nrcap2.Enum.StorageFileType position	文件位置[platform/CEFS]
	*			object customParams 自定义参数/  
	*				{
	*					beginTime	 查询的起始时间, UTC。如果没有，UTC就取0
	*					endTime    查询的结束时间, UTC。如果没有，就相当于现在的UTC
	*					offset	分页条件，返回的第一条记录的偏移值 
	*					count	分页条件，返回记录的最大值  
	*					logicMode	是逻辑模式，取值是AND或OR，决定了ObjShare
	*					reason  是查询存储的原因，可以有多个(以#分开)
	*				}
	*			string csuPuid		平台存储服务器对应的PUID
	*/
	QueryFiles:function(connectId,puid,idx,streamType,position,customParams,csuPuid){
		try
		{ 
			var fn = "Nrcap2.QueryFiles";
			var _flag = Nrcap2.ShareParamsCheck(connectId,puid,idx,fn); 
			if(_flag != true) return _flag;
			
			if(!streamType || typeof streamType == "undefined")
			{
				Nrcap2.Debug.Write({fn:fn,msg:"QueryFiles streamType error!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_FETCHIVDATEFILES_FAILED;
			}
			
			if(!position || typeof position == "undefined"|| (position != "platform" && position != "CEFS"))
			{
				Nrcap2.Debug.Write({fn:fn,msg:"QueryFiles position error!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_FETCHIVDATEFILES_FAILED;
			}
			else
			{
				if(position == "platform")
				{
					if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
					{
						Nrcap2.Debug.Write({fn:fn,msg:"QueryFiles CSU puid error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
					}
				}
			}
			
			var offset = 0 , cntCount = 0, beginTime = 0, endTime = "", logicMode = "AND", reason = "";
			
			if(customParams && typeof customParams == "object")
			{
				if(customParams.offset != null && typeof customParams.offset != "undefined")
				{
					offset = parseInt(customParams.offset);
				}	
				if(customParams.count != null && typeof customParams.count != "undefined")
				{
					cntCount = parseInt(customParams.count);
				}	
				if(customParams.beginTime != null && typeof customParams.beginTime != "undefined")
				{
					beginTime = customParams.beginTime;
				}
				if(customParams.endTime != null && typeof customParams.endTime != "undefined")
				{
					endTime = customParams.endTime;
				}
				else
				{
					endTime = Math.ceil(new Date().getTime()/1000);	
				}
				if(customParams.logicMode != null && typeof customParams.logicMode != "undefined")
				{
					logicMode = customParams.logicMode;
				}
				if(customParams.reason != null && typeof customParams.reason != "undefined")
				{
					reason = customParams.reason;
				}
			}
			else
			{
				endTime = Math.ceil(new Date().getTime()/1000);	
			}
			
			var reasonStr = "", operationId = "CTL_SC_QueryFiles";
			if(reason.indexOf("#") != -1)
			{
				var reasons = reason.split("#");
				reasons.each(
					function(item){
						reasonStr += "<Reason>"+item+"</Reason>";		
					}
				); 
			}
			else
			{
				reasonStr += "<Reason>"+reason+"</Reason>";	
			}
			 
			var Conn = Nrcap2.Connections.get(connectId); 
			var epId = Conn.connParam.epId;
						
			var requestParamStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+ epId +"\"><DstRes Type=\"SC\" Idx=\"0\" OptID=\""+operationId+"\"><Param Offset=\""+offset+"\" Cnt=\""+ cntCount +"\" BeginTime=\""+beginTime+"\" EndTime=\""+endTime+"\" StreamType=\""+ streamType +"\" LogicMode=\""+ logicMode +"\" >"+reasonStr+"</Param></DstRes></Cmd><ObjSets><Res ObjType=\"151\" ObjID=\""+puid+"\" Type=\"IV\" Idx=\""+idx+"\" CmdType=\"CTL\" OptID=\""+operationId+"\" EPID=\""+ epId +"\"></Res></ObjSets></Msg>";
			
			Nrcap2.Debug.Write({fn:fn,msg:"Request:"+requestParamStr});  // alert(requestParamStr);
			
			var rvstr = Conn.nc.SendRequest(151,csuPuid,requestParamStr);  // alert(rvstr);  
			
			Nrcap2.Debug.Write({fn:fn,msg:"Response:"+rvstr}); 
			
			var filelist = new Array(); 
			
			var rvSplitIndex = rvstr.indexOf("#");
			if(rvSplitIndex > -1)
			{
				rvstr = rvstr.substr(rvSplitIndex + 1);
				if(rvstr.length > 0)
				{
					var xmlObj = new XML.ObjTree();
					if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
					{
						Nrcap2.Debug.Write({fn:fn,msg:"XML ObjTree load error!"});
						return [];	
					} 
					
					var jsonResource = xmlObj.parseXML(rvstr);  // alert(Object.toJSON(jsonResource));
					
					if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes && jsonResource.Msg.Cmd.DstRes.OptID == operationId)
					{
						if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"ErrorCode = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
						}
						 
						if(jsonResource.Msg.Cmd.DstRes.Param && jsonResource.Msg.Cmd.DstRes.Param.Res && jsonResource.Msg.Cmd.DstRes.Param.Res.ObjID == puid)
						{  
							if(jsonResource.Msg.Cmd.DstRes.Param.Res.File && typeof jsonResource.Msg.Cmd.DstRes.Param.Res.File == "object")
							{
								if(jsonResource.Msg.Cmd.DstRes.Param.Res.File.constructor == Array)
								{
									var flist = [];
									for(var i = 0;i < jsonResource.Msg.Cmd.DstRes.Param.Res.File.length; i++)
									{
										var File = jsonResource.Msg.Cmd.DstRes.Param.Res.File[i]; 
										 
								     	if(position == "platform") File.csuPuid = csuPuid; // 记录平台存储器对应的PUID
										 
										flist.push(new Nrcap2.Struct.SCIVDateFileStruct(File.Name,File.Path,File.Size,File.BeginTime,File.EndTime,File.Reason,File.csuPuid)); 
										 
									} 
									
									filelist = filelist.concat(flist);
									
									/* if(jsonResource.Msg.Cmd.DstRes.Param.Res.File.length >= cntCount && cntCount == 1000)
									{
										// 根据Cnt = cntCount,则知若file.length = cntCount 就可能还有文件资源没有fetch过来 
										var filelist_nextpage = Nrcap2.QueryFiles(connectId,puid,idx,streamType,position,{beginTime:beginTime,endTime:endTime,offset:parseInt(offset + cntCount),count:cntCount,logicMode:logicMode,reason:reason},csuPuid);
										
										if(typeof filelist_nextpage == "object" && filelist_nextpage.constructor == Array && filelist_nextpage.length > 0)
										{
											filelist = filelist.concat(filelist_nextpage);
										}								
									} */
								}
								else
								{ 
									if(position == "platform") jsonResource.Msg.Cmd.DstRes.Param.Res.File.csuPuid = csuPuid;
								 	
									var File = jsonResource.Msg.Cmd.DstRes.Param.Res.File;
									
									filelist.push(new Nrcap2.Struct.SCIVDateFileStruct(File.Name,File.Path,File.Size,File.BeginTime,File.EndTime,File.Reason,File.csuPuid));  
								}
							}
							else
							{
								Nrcap2.Debug.Write({fn:fn,msg:"Msg Param File Error!"});		
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"Msg Param or ObjID Error!"});	
						}
					}
					else if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.NUErrorCode)
					{
						Nrcap2.Debug.Write({fn:fn,msg:"NUErrorCode = "+jsonResource.Msg.Cmd.NUErrorCode});
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"Msg Name ro Cmd OptID error!"});	
					}
				}
				else
				{
					return [];	
				}
					
			}
				
			return filelist.uniq();
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:fn,msg:"QueryFiles exception error! error code = " + e.message + ":" + e.name});
			return false;
		}
	},
	
	DeleteFiles:function(connectId,csuPuid,fileArray){
		
	},
	
	/*
	*	函数名		:	FetchIVDate
	*	函数功能	：	获取平台存储下有存储文件的日期  
	*	备注		：  
	*	作者		：	huzw
	*	时间		：	2010年12月16日 
	*	返回值		：	成功返回日期列表（Array），否则对应NrcapError
	*	参数说明	：	5个参数  
	*			string connectId	视频所属连接ID
	*			string csuPuid		平台存储服务器对应的PUID
	*			string puid			视频对应的PUID
	*			uint   idx			视频索引
	*			string type			查询录像或图片["vod","image"]
	*/
	FetchIVDate:function(connectId,csuPuid,puid,idx,type)
	{
		if(!connectId || !Nrcap2.Connections.get(connectId))
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDates",msg:"connectId error!"});
			return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
		}
		if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDates",msg:"CSU puid error!"});
			return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
		}
		if(!puid || !Nrcap2.puidRex.test(puid))
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDates",msg:"IV puid error!"});
			return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
		}
		if(idx == null || typeof idx == "undefined" || !Nrcap2.intRex.test(idx))
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDates",msg:"IV idx error!"});
			return false;
		}
		
		var operationId = Nrcap2.Enum.OperationID["CTL_SC_QueryIVDate"];
		var streamType = typeof type != "undefined" && (type == "vod" || type == "image") ? Nrcap2.Enum.NrcapStreamType["st_" + type]:"";
		if(!operationId || streamType == "")
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDates",msg:"fetch IV dates failed!"});
			return Nrcap2.NrcapError.NRCAP_ERROR_FETCHIVDATE_FAILED;
		}
		
		var cntCount = 1000;  // 每次查询文件的最大条数 
		var Conn = Nrcap2.Connections.get(connectId);
		var epId = Conn.connParam.epId;
		
		var requestParamStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n\t<Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\">\r\n\t\t<Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+ epId +"\">\r\n\t\t\t<DstRes Type=\"SC\" Idx=\"0\" OptID=\""+ operationId +"\">\r\n\t\t\t\t<Param Offset=\"0\" Cnt=\""+cntCount+"\" StreamType=\""+ streamType +"\">\r\n\t\t\t\t</Param>\r\n\t\t\t</DstRes>\r\n\t\t</Cmd>\r\n\t\t<ObjSets>\r\n\t\t\t<Res ObjType=\"151\" ObjID=\""+puid+"\" Type=\"IV\" Idx=\""+idx+"\" CmdType=\"CTL\" OptID=\""+ operationId +"\" EPID=\""+ epId +"\">\r\n\t\t\t</Res>\r\n\t\t</ObjSets>\r\n\t</Msg>"; 
		 
		Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDate",msg:"Request:"+requestParamStr});  
		 
		//requestParamStr = Conn.nc.GbktoUtf8(requestParamStr);   
		
		var rvstr = Conn.nc.SendRequest(151,csuPuid,requestParamStr);  

		//rvstr = Conn.nc.Utf8toGbk(rvstr);  //alert(rvstr);
		
	 	Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDate",msg:"Response:"+rvstr}); 
	 	
		var datelist = new Array(); //=>[]
		
		var rvSplitIndex = rvstr.indexOf("#");
		if(rvSplitIndex > -1)
		{
			rvstr = rvstr.substr(rvSplitIndex + 1);
			if(rvstr.length > 0)
			{
				var xmlObj = new XML.ObjTree();
				if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDate",msg:"XML ObjTree load error!"});
					return datelist;						 
				}
				
				var jsonResource = xmlObj.parseXML(rvstr);   //alert(Object.toJSON(jsonResource));
				
				if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes && jsonResource.Msg.Cmd.DstRes.OptID == operationId)
				{
				 	if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
					{
						Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDate",msg:"errorCode = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
					}
					
					if(jsonResource.Msg.Cmd.DstRes.Param && jsonResource.Msg.Cmd.DstRes.Param.Res && jsonResource.Msg.Cmd.DstRes.Param.Res.ObjID == puid )
					{
						if(typeof jsonResource.Msg.Cmd.DstRes.Param.Res.Date == "object" && jsonResource.Msg.Cmd.DstRes.Param.Res.Date.constructor == Array)
						{
							datelist = datelist.concat(jsonResource.Msg.Cmd.DstRes.Param.Res.Date);
						}
						else if(typeof jsonResource.Msg.Cmd.DstRes.Param.Res.Date == "string" || (typeof jsonResource.Msg.Cmd.DstRes.Param.Res.Date == "object" && jsonResource.Msg.Cmd.DstRes.Param.Res.Date.constructor != Array))
						{
							datelist.push(jsonResource.Msg.Cmd.DstRes.Param.Res.Date);
						}
					}
					else
					{
						Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDate",msg:"Msg Param ObjID Error"});
					} 
				}
				else if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.NUErrorCode)
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDate",msg:"NUErrorCode = "+jsonResource.Msg.Cmd.NUErrorCode});
			 	}
				else
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDate",msg:"Msg Name ro Cmd OptID error!"});					 
				}
				
			}
			else
			{
				return datelist;
			}
		} 
		
		return datelist.uniq();
		// .uniq()返回去除数组重复元素后的版本。如果没有重复的元素，返回原始数组 

	},

	/*
	*	函数名		:	FetchIVDateFiles
	*	函数功能	：	获取平台某日期下的存储文件 
	*	备注		： 
	*	作者		：	huzw
	*	时间		：	2010年12月16日 
	*	返回值		：	成功返回文件列表（Array），否则对应NrcapError
	*	参数说明	：	7个参数 
	*			string connectId	视频所属连接ID
	*			string csuPuid		平台存储服务器对应的PUID
	*			string puid			视频对应的PUID
	*			uint   idx			视频索引
	*			string type			查询录像或图片["vod","image"]
	*			string datetime		查询时用到的某一日期
	*			string offset		查询文件起始的条目数[默认为0]
	*/
	FetchIVDateFiles:function(connectId,csuPuid,puid,idx,type,datetime,offset)
	{
		if(!connectId || !Nrcap2.Connections.get(connectId))
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDateFiles",msg:"connectId error!"});
			return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
		}
		if(!csuPuid || !Nrcap2.puidRex.test(csuPuid))
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDateFiles",msg:"CSU puid error!"});
			return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
		}
		if(!puid || !Nrcap2.puidRex.test(puid))
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDateFiles",msg:"IV puid error!"});
			return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
		}
		if(idx == null || typeof idx == "undefined" || !Nrcap2.intRex.test(idx))
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDateFiles",msg:"IV idx error!"});
			return false;
		}
		if(!datetime || typeof datetime == "undefined")
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDateFiles",msg:"Fetch IV datefiles failed!"});
			return Nrcap2.NrcapError.NRCAP_ERROR_FETCHIVDATEFILES_FAILED;
		}
		if(!offset || typeof offset == "undefined")
		{
			offset = 0;
		}
		
		var operationId = Nrcap2.Enum.OperationID["CTL_SC_QueryIVDateFiles"];
		var streamType = typeof type != "undefined" && (type == "vod" || type == "image") ? Nrcap2.Enum.NrcapStreamType["st_" + type]:"";
		if(!operationId || streamType == "")
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDateFiles",msg:"fetch IV datefiles failed!"});
			return Nrcap2.NrcapError.NRCAP_ERROR_FETCHIVDATEFILES_FAILED;
		}
		
		var cntCount = 1000;  //每次查询文件的最大条数 
		
		var Conn = Nrcap2.Connections.get(connectId); 
		var epId = Conn.connParam.epId;
		
		var requestParamStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+ epId +"\"><DstRes Type=\"SC\" Idx=\"0\" OptID=\""+ operationId +"\"><Param Offset=\""+offset+"\" Cnt=\""+ cntCount +"\" StreamType=\""+ streamType +"\" Date=\""+datetime+"\" ></Param></DstRes></Cmd><ObjSets><Res ObjType=\"151\" ObjID=\""+puid+"\" Type=\"IV\" Idx=\""+idx+"\" CmdType=\"CTL\" OptID=\""+ operationId +"\" EPID=\""+ epId +"\"></Res></ObjSets></Msg>";
		
		Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDateFiles",msg:"Request:"+requestParamStr});  
		   
		//requestParamStr = Conn.nc.GbktoUtf8(requestParamStr);   
		
		var rvstr = Conn.nc.SendRequest(151,csuPuid,requestParamStr);   

		//rvstr = Conn.nc.Utf8toGbk(rvstr);  //alert(rvstr); 
		
	 	Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDateFiles",msg:"Response:"+rvstr}); 
		
		var filelist = []; 
		
		var rvSplitIndex = rvstr.indexOf("#");
		if(rvSplitIndex > -1)
		{
			rvstr = rvstr.substr(rvSplitIndex + 1);
			if(rvstr.length > 0)
			{
				var xmlObj = new XML.ObjTree();
				if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDateFiles",msg:"XML ObjTree load error!"});
					return [];	
				}
				
				var jsonResource = xmlObj.parseXML(rvstr); //alert(Object.toJSON(jsonResource));
				if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes && jsonResource.Msg.Cmd.DstRes.OptID == operationId)
				{
					if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
					{
						Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDateFiles",msg:"errorCode = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
					}
					
					if(jsonResource.Msg.Cmd.DstRes.Param && jsonResource.Msg.Cmd.DstRes.Param.Res && jsonResource.Msg.Cmd.DstRes.Param.Res.ObjID == puid )
					{ 
					    if(typeof jsonResource.Msg.Cmd.DstRes.Param.Res.File == "object")
					    { 
					        if(jsonResource.Msg.Cmd.DstRes.Param.Res.File.constructor != Array)
					        {
					            var array = [];
					            array.push(jsonResource.Msg.Cmd.DstRes.Param.Res.File); 
					            jsonResource.Msg.Cmd.DstRes.Param.Res.File = array;
					        }					        
    					    
						    if(jsonResource.Msg.Cmd.DstRes.Param.Res.File.constructor == Array)
						    {
							    var flist = [];
							    for(var i = 0;i < jsonResource.Msg.Cmd.DstRes.Param.Res.File.length; i++)
							    {
								     var File = jsonResource.Msg.Cmd.DstRes.Param.Res.File[i];
								     //记录平台存储器对应的PUID
								     File.csuPuid = csuPuid;
    								 
								     flist.push(new Nrcap2.Struct.SCIVDateFileStruct(File.Name,File.Path,File.Size,File.BeginTime,File.EndTime,File.Reason,File.csuPuid));
							    }
						 	    filelist = filelist.concat(flist);
    							
							    if(jsonResource.Msg.Cmd.DstRes.Param.Res.File.length >= cntCount)
							    {
								    //根据Cnt = cntCount,则知若file.length = cntCount 就可能还有文件资源没有fetch过来
    								
								    var filelist_nextpage = Nrcap2.FetchIVDateFiles(connectId,csuPuid,puid,idx,type,datetime,parseInt(offset) + cntCount);
    								
								    if(typeof filelist_nextpage == "object" && filelist_nextpage.constructor == Array && filelist_nextpage.length > 0)
								    {
								 	    filelist = filelist.concat(filelist_nextpage);
								    }								
							    } 
						    }
						    else if(jsonResource.Msg.Cmd.DstRes.Param.Res.File.constructor != Array)
						    {
							    jsonResource.Msg.Cmd.DstRes.Param.Res.File.csuPuid = csuPuid;
							    filelist.push(jsonResource.Msg.Cmd.DstRes.Param.Res.File);
						    }
						}
						else
						{
						    Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDateFiles",msg:"Files Type Error!"});
						}
					}
					else
					{
						Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDateFiles",msg:"Msg Param ObjID Error!"});
					}
				}
				else if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.NUErrorCode)
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDateFiles",msg:"NUErrorCode = "+jsonResource.Msg.Cmd.NUErrorCode});
				}
				else
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.FetchIVDateFiles",msg:"Msg Name ro Cmd OptID error!"});	
				}
			}
			else
			{
				return [];	
			}
		}
		
		return filelist.uniq();
	},
	
	/*
	*	函数名		:	PlayVod
	*	函数功能	：	点播视频
	*	备注		： 
	*	作者		：	huzw
	*	时间		：	2010.12.14 
	*	修改		：	2011.09.26
	*	返回值		：	对应NrcapError
	*	参数说明	：	3个参数  
	*			string connectId	视频所属连接ID
	*			object objWnd		视频窗口对象 
	*			object params	    点播视频控制参数
				{
					Nrcap2.Enum.StorageFileType type	文件类型	 
					string puid						存储服务器的PUID
					string idx 						点播前端文件视频头索引 
					string speed					点播速度(0~4)
					string startTime 				点播开始时间 
					string endTime					点播结束时间
					string fileFullPath				点播平台文件全路径名
					string fileTimeLength 			点播文件时长
					object customParams				自定义参数 
				} 
				说明：




					1、点播平台文件(params.type = 'platform')时，选择 {puid、speed、startTime、fileFullPath、fileTimeLength}传入： 
					puid 为中心存储器PUID 
					startTime 为点播开始时间(整型)，相对于文件的开始时间，单位为:秒



 
					2、点播前端文件(params.type = 'CEFS')时，选择 {puid、idx、speed、startTime、endTime、fileTimeLength}传入： 
					puid 为所属设备PUID;
					startTime 为点播开始时间，UTC时间
					endTime	 为点播结束时间，UTC时间
	*						
	*/ 
	PlayVod: function(connectId, objWnd, params)
	{		 
		try
		{
			if(objWnd && objWnd.wnd)
			{
				if(!connectId || typeof connectId == "undefined"){
					Nrcap2.Debug.Write({fn:"Nrcap2.PlayVod",msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				}
			 
				if(!params || typeof  params == "undefined") {
					Nrcap2.Debug.Write({fn:"Nrcap2.PlayVod",msg:"params error!"});
					return false;
				}
				
				var type = "", found = false;
				if(params.type && typeof params.type !="unndefined"){
					type = params.type;
				}
				for(var key in Nrcap2.Enum.StorageFileType)
				{
					if(Nrcap2.Enum.StorageFileType[key] == type) found = true;
				}
				if(found == false){ 
					Nrcap2.Debug.Write({fn:"Nrcap2.PlayVod",msg:"params.type undefined error!"});
					return false;
				}
				  
				var puid = null, idx = 0, speed = 0, startTime = 0, endTime = 0, fileFullPath = null, fileTimeLength = 0;
				for(var key in params)
				{
					var value = params[key];
					switch(key)
					{
						case "puid": puid = value; break;
						case "idx":	idx = value; break;
						case "speed": speed = value; break;
						case "startTime":startTime = value; break;
						case "endTime": endTime = value; break;
						case "fileFullPath": fileFullPath = value; break;
						case "fileTimeLength": fileTimeLength = value; break;
						default: break;
					} 
				}
				
				if(!puid || !Nrcap2.puidRex.test(puid) ){
					Nrcap2.Debug.Write({fn:"Nrcap2.PlayVod",msg:"params.puid undefined error!"});
					return false;
				}
				 
				var epId = Nrcap2.Connections.get(connectId).connParam.epId; 
				
				objWnd.nm.AttachSessionHandle(Nrcap2.Connections.get(connectId).session);
				objWnd.wnd.enableFullScreen(objWnd.style.enableFullScreen);
				objWnd.nm.AttachDisplayWindow(objWnd.wnd.getWindowHandle());
				
				if(typeof Nrcap2.Connections.get(connectId).connParam.bFixCUIAddress != "undefined" && Nrcap2.Connections.get(connectId).connParam.bFixCUIAddress == 1 ) 
				{ 
					objWnd.nm.AttachFixedDSSAddr(Nrcap2.Connections.get(connectId).connParam.path.split(":")[0]); 
				} 
				 
				var rv = "";
				
				if(type == Nrcap2.Enum.StorageFileType['platform']){ 
					if(!fileFullPath || fileFullPath == ""){
						Nrcap2.Debug.Write({fn:"Nrcap2.PlayVod",msg:"params.fileFullPath undefined error!"});
						return false;					
					} 
							
					// 点播平台文件
					rv = objWnd.nm.PlayVod_Platform(epId, puid, fileFullPath, speed, startTime, 1);  
					
				 }  else { 
					// 暂不支持点播前端设备文件
					// Nrcap2.Debug.Write({fn:"Nrcap2.PlayVod",msg:"暂不支持点播前端设备文件!"});
					// return false; 
					rv = objWnd.nm.PlayVod_CEFS(epId, puid, startTime, endTime, idx, speed, 1); 
				 }			 
			 
				if(rv.toString().split("#")[0] != 0x0000)
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.PlayVod",msg:"error = " + Nrcap2.NrcapError.ShowMessage(rv.toString().split("#")[0])});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLAYVOD_FAILED;
				} 
			 
				objWnd.connectId = connectId;
				objWnd.params.puid = puid ;
				objWnd.params.idx = idx;
				objWnd.params.speed = speed;
				objWnd.params.startTime = startTime;
				objWnd.params.endTime = endTime;
				objWnd.params.fileFullPath = fileFullPath;
				objWnd.params.fileTimeLength = fileTimeLength; 
  
				objWnd.status.playvoding = true;
				 
				if(params.customParam && typeof params.customParam == "object")
				{
					objWnd.customParams  = params.customParams;
				}				
				
				Nrcap2.Debug.Write({fn:"Nrcap2.PlayVod",msg:"success playvoding!"});
				return Nrcap2.NrcapError.NRCAP_SUCCESS;
			}
			else
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.PlayVod",msg:"vod window no exists!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_WINDOW_NOEXIST;
			}
			
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.PlayVod",msg:"error = " + e.message + "::" + e.name});
			return Nrcap2.NrcapError.NRCAP_ERROR_PLAYVOD_FAILED;
		}
		
		//暂不支持点播前端设备文件
	},
	
	/*
	*	函数名		:	StopVod
	*	函数功能	：	停止视频点播
	*	备注		： 
	*	作者		：	huzw
	*	时间		：	2010年12月15日 
	*	返回值		：	对应NrcapError
	*	参数说明	：	1个参数  
	*			object objWnd		视频窗口对象
	*/ 
	StopVod:function(objWnd)
	{
		try
		{
			if(objWnd && objWnd.wnd)
			{
				if(objWnd.status.recording)
				{
					Nrcap2.LocalRecord(objWnd);
				}
				if(objWnd.status.playaudioing)
				{
					Nrcap2.PlayVodAudio(objWnd);
				}
				objWnd.nm.StopPlayVod();
				objWnd.nm.Refresh();
				objWnd.wnd.restore();
				objWnd.wnd.refresh();
				objWnd.nm.DetachSessionHandle(); 	
				objWnd.connectId = null; 
				objWnd.params.puid = null;		 
				objWnd.params.idx = 0;
				objWnd.params.speed = 0;
				objWnd.params.startTime = 0;
				objWnd.params.endTime = 0;
				objWnd.params.fileFullPath = null;
				objWnd.params.fileTimeLength = 0; 
				objWnd.status.playvoding = false;
				objWnd.nm.DetachFixedDSSAddr(); 
				objWnd.nm.Close();
			}
			else
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.StopVod",msg:"vod window no exists!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_WINDOW_NOEXIST;
			}
			Nrcap2.Debug.Write({fn:"Nrcap2.StopVod",msg:"stop play vod success!"});
			return Nrcap2.NrcapError.NRCAP_SUCCESS;
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.StopVod",msg:"error = " + e.message + "::" + e.name});
			return Nrcap2.NrcapError.NRCAP_ERROR_STOPVOD_FAILED;
		}
	},
	
	/*
	*	函数名		:	PlayVodJump
	*	函数功能	：	跳到指定时间点进行点播 
	*	备注		： 
	*	作者		：	huzw
	*	时间		：	2010年12月15日 
	*	返回值	：	对应NrcapError
	*	参数说明	：	5个参数 
	*			string connectId	视频所属连接ID
	*			object objWnd		视频窗口对象 
	*			Nrcap2.Enum.StorageFileType type	文件类型	 	
	*/ 
	PlayVodJump:function(connectId, objWnd, type)
	{
		try
		{
			if(objWnd && objWnd.wnd && objWnd.status.playvoding)
			{
				//还需修改
		        //Nrcap2.StopVod(objWnd);
		        //Nrcap2.PlayVod(connectId, objWnd, csuPuid, vodFullPath, vodParams); 
				// alert(Object.toJSON(vodParams));
				
				// < 2011.09.27 -s-
				if(!type || typeof type == "undefined")
				{ 
					Nrcap2.Debug.Write({fn:"Nrcap2.PlayVodJump",msg:"type undefined error!"});	
					return Nrcap2.NrcapError.NRCAP_ERROR_PLAYVOD_FAILED;
				}
				
				objWnd.nm.StopPlayVod();
				objWnd.nm.Refresh();
				
				var rv = "";
				if(type == Nrcap2.Enum.StorageFileType['platform']){
					
					rv = objWnd.nm.PlayVod_Platform(Nrcap2.Connections.get(connectId).connParam.epId, objWnd.params.puid, objWnd.params.fileFullPath, objWnd.params.speed, objWnd.params.startTime, 1); 
					
				} else {
					
					// 暂不支持点播前端设备文件
					Nrcap2.Debug.Write({fn:"Nrcap2.PlayVod",msg:"暂不支持点播前端设备文件!"});
					return false; 	
					rv = objWnd.nm.PlayVod_CEFS(Nrcap2.Connections.get(connectId).connParam.epId, objWnd.params.puid, objWnd.params.startTime, objWnd.params.endTime, objWnd.params.idx, objWnd.params.speed, 1); 
				} 
				// alert(rv);
				
				if(rv.toString().split("#")[0] != 0x0000)
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.PlayVodJump",msg:"error = " + Nrcap2.NrcapError.ShowMessage(rv.toString().split("#")[0])});
					return Nrcap2.NrcapError.NRCAP_ERROR_PLAYVOD_FAILED;
				} 
				
				Nrcap2.Debug.Write({fn:"Nrcap2.PlayVod",msg:"success playvoding!"});
				return Nrcap2.NrcapError.NRCAP_SUCCESS;  
				
				// -e- 2011.09.27 > 
				
  			}
			else
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.PlayVodJump",msg:"vod window no exists!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_WINDOW_NOEXIST;
			}
			return Nrcap2.NrcapError.NRCAP_SUCCESS;
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.PlayVodJump",msg:"error = " + e.message + "::" + e.name});
			return Nrcap2.NrcapError.NRCAP_ERROR_PLAYVOD_FAILED;
		}
	},
		
	/*
	*	函数名		:	PlayVodAudio
	*	函数功能	：	点播音频
	*	备注		： 
	*	作者		：	huzw
	*	时间		：	2010年12月15日  
	*	返回值	：	对应NrcapError
	*	参数说明	：	1个参数  
	*			object objWnd		视频窗口对象
 	*/ 
	PlayVodAudio:function(objWnd)
	{
		try
		{
			if(objWnd && objWnd.wnd)
			{
				if(objWnd.status.playaudioing == true)
				{
					objWnd.nm.EnableVodAudio(0);
					objWnd.status.playaudioing = false;
				}
				else
				{
					objWnd.nm.EnableVodAudio(1);
					objWnd.status.playaudioing = true;
				}
			}
			else
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.PlayVodAudio",msg:"vod window no exists!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_WINDOW_NOEXIST;
			}
			return Nrcap2.NrcapError.NRCAP_SUCCESS;
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.PlayVodAudio",msg:"error = " + e.message + "::" + e.name});
		    return Nrcap2.NrcapError.NRCAP_ERROR_PLAYVODAUDIO_FAILED;
		}
	},
	
	/*
	*	函数名		:	SetPlayVodSpeed
	*	函数功能	：	设置点播视频速度
	*	备注		： 
	*	作者		：	huzw
	*	时间		：	2010年12月15日 
	*	返回值		：	对应NrcapError
	*	参数说明	：	2个参数 
	*			object objWnd		视频窗口对象
	*			Nrcap2.Enum.VodSpeedDirect direct	["fast","slow"]
 	*/ 
	SetPlayVodSpeed:function(objWnd,direct)
	{
		try
		{
			if(objWnd && objWnd.wnd)
			{
				direct = direct.toLowerCase();
				var speed = objWnd.params.speed;
				
				if(direct == Nrcap2.Enum.VodSpeedDirect["fast"])
				{
					 speed ++;
					 if(speed < 0 || speed > 2 )
					 {
						speed = 0; 
					 }
				}
				else if(direct == Nrcap2.Enum.VodSpeedDirect["slow"])
				{
					 speed --;
					 if(speed < -2 || speed > 0 )
					 {
						speed = 0; 
					 }
				}
				else
				{
					//其他情况	
					speed = 0; 
					//return Nrcap2.NrcapError.NRCAP_ERROR_SETPLAYVODSPEED_FAILED;
				}
				
				objWnd.nm.VodSetSpeed(speed);	
				//记录改变的速度值 
				objWnd.params.speed = speed;		
			}
			else
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.SetPlayVodSpeed",msg:"vod window no exists!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_WINDOW_NOEXIST;
			}
			return Nrcap2.NrcapError.NRCAP_SUCCESS;
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.SetPlayVodSpeed",msg:"error = " + e.message + "::" + e.name});
		    return Nrcap2.NrcapError.NRCAP_ERROR_SETPLAYVODSPEED_FAILED;
		}
	},
	
	/*
	*	函数名		:	GetVodStatus
	*	函数功能	：	获取点播视频状态 
	*	备注		： 
	*	作者		：	huzw
	*	时间		：	2010年12月16日 
	*	返回值		：	成功返回状态 
	*			{	
	*				currentTime		//当前已播放时间(s)
	*				falg			//状态信号量(整型[1,2,3,4])
	*				description		//状态详细描述 
	*			}						
	*					否则对应NrcapError
	*	参数说明	：	1个参数 object objWnd	视频窗口对象 		
 	*/ 
	GetVodStatus:function(objWnd)
	{
		try
		{
			if(objWnd && objWnd.wnd)
			{
				var vodStatus = parseInt(objWnd.nm.GetVodStatus());
				var curTime = objWnd.nm.VodGetCurrentTime();
				// alert(vodStatus);
				return new Nrcap2.Struct.VodWholeStatusStruct(curTime, vodStatus, Nrcap2.Enum.LanguagePack.playStatus[vodStatus][Nrcap2.language]);				 
			}
			else
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.GetVodStatus",msg:"vod window no exists!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_WINDOW_NOEXIST;	
			}
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:"Nrcap2.GetVodStatus",msg:"error = " + e.message + "::" + e.name});
		    return Nrcap2.NrcapError.NRCAP_ERROR_GETVODSTATUS_FAILED;
		}
	},
	
	/*
	*	对象名		:	Download
	*	功能		：	下载对象
	*	备注		：	无 

	*	作者		：	huzw
	*	时间		：	2010年12月17日 
 	*/ 
	Download:
	{
		downloads: new Hash(),
		
		UnLoad: function()
		{
			if(Nrcap2.Download.downloads.keys().length > 0)
			{
				Nrcap2.Download.downloads.each(
					function(item){
						var objDl = item.value;
						objDl.Stop();
					}
				);
			}
		},
		
		/*
		*	函数名		:	Create
		*	函数功能	：	创建下载对象dl的一个实例 
		*	备注		：	无 
		*	作者		：	huzw
		*	时间		：	2010.12.17 
		*	返回值	：	成功返回dl对象，否则对应NrcapError
		*	参数		：	3个参数 
		*			string	connectId	连接ID
		*			string	type		下载录像或图片["vod","image"]
		*			object	params		下载文件相关参数
		*/ 
		Create: function(connectId,type,params)
		{
			try
			{
				if(typeof type == "undefined" || (type != "vod" && type != "image"))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.Download.Create",msg:"type is not of 'vod' or 'image'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOAD_PARAMS_ERROR;
				}
				if(typeof params == "undefined" || typeof params != "object") 
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.Download.Create",msg:"params error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOAD_PARAMS_ERROR;
				}
				if(!params.epId || typeof params.epId == "undefined")
				{ 
				    params.epId = Nrcap2.Connections.get(connectId).connParam.epId; 
				}
				
				if(type == "vod" || type == "image")
				{
					var fileVer = "platform";   //默认下载平台文件 
					
					var dlkey = "";
					var fileParams = null; 
					
				 	if(fileVer == "platform")
					{
						//vod or image
						fileParams = new Nrcap2.Struct.DownloadPlatformFilesParamStruct(
							params.epId,
							params.fileName,
							params.fileAllPath,
							params.saveAllPath,
							params.csuPuid
						);
						fileParams.puid = (!params.puid ? null : params.puid);
						fileParams.idx = (!params.idx ? 0 : params.idx);
						fileParams.offset = (!params.offset ? 0 : params.offset);
						fileParams.length = (!params.length ? -1 : params.length);
						dlkey = fileParams.fileAllPath;
					}
					else
					{
						//还需考虑
						if(type = "vod")
						{
							fileParams = new Nrcap2.Struct.DownloadCEFSVodFilesParamStruct(
								params.epId,
								params.beginTime,
								params.endTime,
								params.puid,
								params.idx,
								params.saveAllPath 
							);
							
							dlkey = fileParams.puid + "_" + new Date(Date.parse(fileParams.beginTime.replace(/-/g,"/"))).getTime() + "_" + new Date(Date.parse(fileParams.endTime.replace(/-/g,"/"))).getTime();
						}
						else if(type = "image")
						{
							fileParams = new Nrcap2.Struct.DownloadCEFSImageFilesParamStruct(
								params.epId,
								params.fileTime,
								params.noInSecond,  // 抓拍秒内编号,从0开始 
								params.puid,
								params.idx,
								params.saveAllPath 
							);
							
							dlkey = fileParams.puid + "_" + new Date(Date.parse(fileParams.fileTime.replace(/-/g,"/"))).getTime() + "_" + fileParams.noInSecond;
						}
						else
						{
							return false;	
						}
					} 
				}	
				
				/*创建下载对象dl的一个实例*/
				var t_dlname = new Date().getTime() + "" + Math.round(Math.random*(999-100+1)+100) + "_dl";
				if(!document.getElementById(t_dlname))
				{
					document.getElementById("Nrcap2Box").innerHTML += Nrcap2.PlugHtml.get("dl").replace("id=\"@id\" name=\"@name\"","id=\""+ t_dlname +"\" name=\""+ t_dlname +"\"");
				}
				
				var objDl = new Nrcap2.Struct.DownloadStruct(
					dlkey,
					connectId,
					document.getElementById(t_dlname),
					type,
					fileVer,
					fileParams,
					(typeof params.customParams != "undefined" ? params.customParams : null),
					null,
					null,
					null
				);
				
				objDl.Start = function()
				{
					return Nrcap2.Download.StartDownload(this);
				};
				objDl.Stop = function()
				{
					return Nrcap2.Download.StopDownload(this);
				};
				objDl.GetStatus = function()
				{ 
					var status = 0, byte = 0, bitrate = 0;
					status = parseInt(Nrcap2.Download.GetDownloadStatus(this));
					byte = parseInt(Nrcap2.Download.GetDownloadByte(this));
				    bitrate = parseInt(Nrcap2.Download.GetDownloadBitRate(this));
					
					return new Nrcap2.Struct.DownloadStatusStruct(status,Nrcap2.Enum.LanguagePack.downloadStatus[status][Nrcap2.language],byte,bitrate);
				};
				
				if(Nrcap2.Download.downloads.get(dlkey))
				{
					Nrcap2.Download.downloads.get(dlkey).Stop();
					Nrcap2.Download.downloads.unset(dlkey);
				}
				Nrcap2.Download.downloads.set(dlkey,objDl);
				
				return objDl;				
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.Download.Create",msg:"exception,error="+e.message+e.name});
                return Nrcap2.NrcapError.NRCAP_ERROR_LOADPLUG_DL;
			}
		},
		
		/*开始下载*/
		StartDownload:function(objDl)
		{
			try
			{
				if(objDl && objDl.dl)
				{ 
				
                    if (typeof objDl.connectId == "undefined" )
                    {
                        Nrcap2.Debug.Write({fn:"Nrcap2.Download.StartDownload",msg:"connect id error!"});
                        return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOADFILE_FAILED;
                    }
					
					if(typeof objDl.type == "undefined" || (objDl.type != "vod" && objDl.type != "image"))
					{
						Nrcap2.Debug.Write({fn:"Nrcap2.Download.StartDownload",msg:"type is not of 'vod' or 'image'!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOAD_PARAMS_ERROR;
					}
					
					var fileVer = objDl.fileVer;
					if(typeof fileVer == "undefined" || (fileVer != "platform" && fileVer != "CEFS"))
					{
						//return;	
					}
					
					// 绑定连接句柄
					objDl.dl.AttachSessionHandle(Nrcap2.Connections.get(objDl.connectId).session);
					
					if(objDl.fileVer == "platform")
					{
						var fileParams = objDl.fileParams;
						
						if(!fileParams.csuPuid || !Nrcap2.puidRex.test(fileParams.csuPuid))
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.Download.StartDownload",msg:"CSU puid error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
						}
						if(!fileParams.fileAllPath || typeof fileParams.fileAllPath == "undefined")
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.Download.StartDownload",msg:"fileAllPath error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOAD_PARAMS_ERROR;
						}
						 
						if(!fileParams.saveAllPath || typeof fileParams.saveAllPath == "undefined")
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.Download.StartDownload",msg:"saveAllPath error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOAD_PARAMS_ERROR;
						}
						
						if(typeof fileParams.offset == "undefined")
						{
							fileParams.offset = 0; // 从文件头开始下载 
						}
						if(typeof fileParams.length == "undefined")
						{
							fileParams.length = -1; // 下载全部文件
						}
						
						if(typeof fileParams.epId == "undefined")
						{
							fileParams.epId = Nrcap2.Connections.get(objDl.connectId).connParam.epId;
						}
						// alert(Object.toJSON(fileParams));
						// 开始下载平台文件 
						var rv = objDl.dl.DownloadFile(fileParams.epId,fileParams.csuPuid,fileParams.fileAllPath,fileParams.saveAllPath,fileParams.offset,fileParams.length); // alert(rv);
						rv = parseInt(rv);
						if(rv.toString().split("#")[0]!= 0x0000)
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.Download.StartDownload",msg:"error = " + Nrcap2.NrcapError.ShowMessage(rv.toString().split("#")[0])});
							return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOADFILD_FAILED;
						}						 
						return Nrcap2.NrcapError.NRCAP_SUCCESS;
					}
					else if(fileVer == "CEFS")
					{
						if(objDl.type == "vod")
						{
							if(!fileParams.puid || !Nrcap2.puidRex.test(fileParams.puid))
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.Download.StartDownload",msg:"CEFS vod puid error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
							}
							if(fileParams.idx == null || typeof fileParams.idx == "undefined" || !Nrcap2.intRex.test(idx))
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.Download.StartDownload",msg:"CEFS vod idx error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOAD_PARAMS_ERROR;
							}
							if(!fileParams.beginTime || typeof fileParams.beginTime == "undefined")
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.Download.StartDownload",msg:"CEFS vod beginTime error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOAD_PARAMS_ERROR;
							}
							if(!fileParams.endTime || typeof fileParams.endTime == "undefined")
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.Download.StartDownload",msg:"CEFS vod endTime error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOAD_PARAMS_ERROR;
							}
							if(!fileParams.saveAllPath || typeof fileParams.saveAllPath == "undefined")
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.Download.StartDownload",msg:"CEFS vod saveAllPath error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOAD_PARAMS_ERROR;
							}
							if(!fileParams.epId || typeof fileParams.epId == "undefined")
							{
								fileParams.epId = Nrcap2.Connections.get(objDl.connectId).connParam.epId;
							}
							
							var rv = objDl.dl.DownloadRecord_CEFS(fileParams.epId,fileParams.puid,fileParams.beginTime,fileParams.endTime,fileParams.idx,fileParams.saveAllPath);
							rv = parseInt(rv);
							if(rv.toString().split("#")[0] != 0x0000)
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.Download.StartDownload",msg:"error = " + Nrcap2.NrcapError.ShowMessage(rv.toString().split("#")[0])});
								return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOADFILD_FAILED;
							}
							
							return Nrcap2.NrcapError.NRCAP_SUCCESS;
						}
						else if(objDl.type == "image")
						{
							if(!fileParams.puid || !Nrcap2.puidRex.test(fileParams.puid))
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.Download.StartDownload",msg:"CEFS vod puid error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
							}
							if(fileParams.idx == null || typeof fileParams.idx == "undefined" || !Nrcap2.intRex.test(idx))
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.Download.StartDownload",msg:"CEFS vod idx error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOAD_PARAMS_ERROR;
							}
							if(!fileParams.fileTime || typeof fileParams.fileTime == "undefined")
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.Download.StartDownload",msg:"CEFS vod fileTime error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOAD_PARAMS_ERROR;
							}
							if(!fileParams.noInSecond || typeof fileParams.noInSecond == "undefined")
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.Download.StartDownload",msg:"CEFS vod noInSecond error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOAD_PARAMS_ERROR;
							}
							if(!fileParams.saveAllPath || typeof fileParams.saveAllPath == "undefined")
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.Download.StartDownload",msg:"CEFS vod saveAllPath error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOAD_PARAMS_ERROR;
							}
							if(!fileParams.epId || typeof fileParams.epId == "undefined")
							{
								fileParams.epId = Nrcap2.Connections.get(objDl.connectId).connParam.epId;
							}
							
							var rv = objDl.dl.DownloadSnapshot_CEFS(fileParams.epId,fileParams.puid,fileParams.fileTime,fileParams.noInSecond,fileParams.idx,fileParams.saveAllPath);
							rv = parseInt(rv);
							if(rv.toString().split("#")[0] != 0x0000)
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.Download.StartDownload",msg:"error = " + Nrcap2.NrcapError.ShowMessage(rv.toString().split("#")[0])});
								return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOADFILD_FAILED;
							}
							
							return Nrcap2.NrcapError.NRCAP_SUCCESS;
						}
					}
					else
					{
						return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOADFILD_FAILED;	
					}
				}
				else
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.Download.StartDownload",msg:"load dl failed!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_LOADPLUG_DL;
				}
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.Download.StartDownload",msg:"exception,error="+e.message+e.name});
                return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOADFILE_FAILED;
			}
		},
		
		/* 停止下载 */
		StopDownload:function(objDl)
		{
			try
			{ 
				if(objDl && objDl.dl)
				{
					objDl.dl.StopDownload();
					objDl.dl.DetachSessionHandle();
					//以下两行可以让开发者根据需要自行处理  
					//Nrcap2.Download.downloads.unset(objDl.key);
					//objDl.fileParams = null;
					
					Nrcap2.Debug.Write({fn:"NrcapPlus.Download.StopDownload",msg:"stop download success!"});
					return Nrcap2.NrcapError.NRCAP_SUCCESS;
				}
				else
                {
                    return Nrcap2.NrcapError.NRCAP_ERROR_LOADPLUG_DL;
                }
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.Download.StopDownload",msg:"exception,error = " + e.message + "::" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOADFILE_FAILED;
			}
		},
		
		/* 获取下载状态信号量值[1,..,7] */
		GetDownloadStatus:function(objDl)
		{
			try
			{
				if(objDl && objDl.dl)
				{
					var downloadstatus = objDl.dl.GetDownloadStatus();
					
					return downloadstatus;
				}
				else
                {
                    return Nrcap2.NrcapError.NRCAP_ERROR_LOADPLUG_DL;
                }
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.Download.GetDownloadStatus",msg:"exception,error = " + e.message + "::" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOADFILE_FAILED;
			}
		},
		
		/*
		* 获取已经下载的字节数(非CEFS下)
		* 获取已经下载的时间长度(CEFS下)
		*/
		GetDownloadByte:function(objDl)
		{
			try
			{
				if(objDl && objDl.dl)
				{ 
					return objDl.dl.GetDownloadByte(); 
				}
				else
                {
                    return Nrcap2.NrcapError.NRCAP_ERROR_LOADPLUG_DL;
                }
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.Download.GetDownloadedBytes",msg:"exception,error = " + e.message + "::" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOADFILE_FAILED;
			}
		},
		
		/*获取码率(Kbps)*/
		GetDownloadBitRate:function(objDl)
		{
			try
			{
				if(objDl && objDl.dl)
				{
					return objDl.dl.GetDownloadBitRate();
				}
				else
               {
                    return Nrcap2.NrcapError.NRCAP_ERROR_LOADPLUG_DL;
                }
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.Download.GetBitRate",msg:"exception,error = " + e.message + "::" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOADFILE_FAILED;
			}
		},
		
		end:true
	},
	//*****************************************************************************************
    
	/* 事件对象 */
	Event:{ 
		
		/*
		*	函数名   ：Get
		*	函数功能	：获取设备事件.
		*	备注		：无
		*	作者		：huzw
		*	时间		：2011.04.20 
		*	返回值	：成功Object(Nrcap2.Struct.EventInfoStruct),失败{}
		*	参数说明	：1个参数  
		*  string connectId   连接ID
		*/
		Get:function(connectId){
			try
			{
				if (!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.Event.Get",msg:"connect id error!"});
					//return Nrcap2.NrcapError.NRCAP_ERROR_DOWNLOADFILE_FAILED;
					return {};
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var rvstr = conn.nc.RecvNotify(); // alert(rvstr);
				
				var rvSplitIndex = rvstr.indexOf("#");
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex +1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.Event.Get",msg:"XML ObjTree load error!"});  
							return {};
						}
						 
						var jsonResource = xmlObj.parseXML(rvstr); // alert(Object.toJSON(jsonResource));
						
						var eventMsg = new Object();
						 
						if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "Event" && jsonResource.Msg.ID)
						{
							var msg = jsonResource.Msg;
							
							var eventId = msg.ID;
							var offlineFlag = msg["OfflineFlag"] || "";
							var mSrc = msg.Src || {};
							var mDes = msg.Description || {}; 
							
							var eventSrc = {};
							var eventDes = mDes;
							  
							eventSrc = {
								"SrcIDType": (typeof mSrc["SrcIDType"] != "undefined" ? mSrc["SrcIDType"] : ""),	
								"SrcID": (typeof mSrc["SrcID"] != "undefined" ? mSrc["SrcID"] : ""),
								"ResType": (typeof mSrc["ResType"] != "undefined" ? mSrc["ResType"] : ""),
								"ResIdx": (typeof mSrc["ResIdx"] != "undefined" ? mSrc["ResIdx"] : ""),
								"ResName": (typeof mSrc["ResName"] != "undefined" ? mSrc["ResName"] : ""),
								"ResDesc":(typeof mSrc["ResDesc"] != "undefined" ? mSrc["ResDesc"] : "") 
							};
							
							eventMsg = new Nrcap2.Struct.EventInfoStruct(
								eventId,
								msg.Name,
								msg.Time,
								msg.Level,
								msg.IgnoreFlag,
								offlineFlag,
								eventSrc,
								eventDes
							);   
						     
							Nrcap2.Debug.Write({fn:"Nrcap2.Event.Get",msg:Object.toJSON(eventMsg)});
						   
							/* switch(eventId)
							{
								case "EVT_CU_Online": case "EVT_CU_Offline": break;
								case "EVT_SG_DiskError": break;
								case "EVT_ST_EmergentAlert": break;
								case "EVT_ST_UnusableTimeAlert": case "EVT_ST_OverSpeed": break;
								case "EVT_ST_ArriveStation": break;
								case "EVT_ST_DepartStation": break;
								case "EVT_ST_StationLinger": break;
								case "EVT_ST_CustomManualNotify": break;
								case "EVT_IV_ChannelChanged": break;
								case "EVT_OV_VideoBindedOffline": case "EVT_OV_VideoBindedChanged": break;
								case "EVT_IDL_CountChanged": break;
								case "EVT_ODL_StatusChanged": break;
								case "EVT_GPS_LowSpeed": break;
								case "EVT_GPS_InERailAlarm": case "EVT_GPS_OutERailAlarm": break;
								case "EVT_GPS_LineDepart": break;
								default: break;
							} */
						}
						else
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.Event.Get",msg:"Msg Name ro ID error!"});
							return {};
						}
						 
						return eventMsg; 
					}
					
				}
				else
				{    
					Nrcap2.Debug.Write({fn:"Nrcap2.Event.Get",msg:"当前无触发事件！"});
					return {};
				}
				
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.Event.Get",msg:"exception,error = " + e.message + "::" + e.name});
				return {};
			}  
		}, 
		
		/*
		*	函数名	：QueryEventLog
		*	函数功能	：查询事件日志 
		*	备注		：无
		*	作者		：huzw
		*	时间		：2011.05.12  
		*/ 
		QueryEventLog:function(connectId,objSets,resParams){
			try
			{
				var fn = "Nrcap2.Event.QueryEventLog";
				if (!connectId || typeof connectId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"connect id error!"}); 
					return [];
				}
				
				var objSetsXmlStr = "", offset = 0, count = 200;
				
				if(typeof objSets == "object")
				{
					if(typeof objSets.offset != "undefined" && Nrcap2.intRex.test(objSets.offset))
					{
						objSetsXmlStr += " Offset=\"" + objSets.offset + "\" ";
					}
					else
					{
						objSetsXmlStr += " Offset=\"" + offset + "\" ";
					}
					if(typeof objSets.count != "undefined" && Nrcap2.intRex.test(objSets.count))
					{
						objSetsXmlStr += " Count=\"" + objSets.count + "\" ";
					} 
					else
					{
						objSetsXmlStr += " Count=\"" + count + "\" ";
					}
					if(typeof objSets.beginTime != "undefined")
					{
						objSetsXmlStr += " BeginTime=\"" + (objSets.beginTime ? objSets.beginTime : 0) + "\" ";
					}
					if(typeof objSets.endTime != "undefined")
					{
						objSetsXmlStr += " EndTime=\"" + (objSets.endTime ? objSets.endTime : Math.ceil(new Date().getTime()/1000)) + "\" ";
					}
					if(typeof objSets.id != "undefined")
					{
						objSetsXmlStr += (objSets.id ? " ID=\"" +  objSets.id + "\" ": "");
					}
					if(typeof objSets.level != "undefined")
					{
						objSetsXmlStr += (objSets.level ? " Level=\"" +  objSets.level + "\" ": "");
					}
					if(typeof objSets.offlineFlag != "undefined")
					{
						objSetsXmlStr += (objSets.offlineFlag != null && (objSets.offlineFlag == 0 || objSets.offlineFlag == 1) ? " OfflineFlag=\"" +  objSets.offlineFlag + "\" ": "");
					}
					if(typeof objSets.ignoreFlag != "undefined")
					{
						objSetsXmlStr += (objSets.ignoreFlag != null && (objSets.ignoreFlag == 0 || objSets.ignoreFlag == 1) ? " IgnoreFlag=\"" +  objSets.ignoreFlag + "\" ": "");
					}
					if(typeof objSets.sourceIP != "undefined")
					{
						objSetsXmlStr += (objSets.sourceIP ? " SourceIP=\"" +  objSets.sourceIP + "\" ": "");
					}
					if(typeof objSets.sourcePort != "undefined")
					{
						objSetsXmlStr += (objSets.sourcePort ? " SourcePort=\"" +  objSets.sourcePort + "\" ": "");
					}
					if(typeof objSets.processed != "undefined")
					{
						objSetsXmlStr += (objSets.processed ? " Processed=\"" +  objSets.processed + "\" ": "");
					}
					if(typeof objSets.processBeginTime != "undefined")
					{
						objSetsXmlStr += (objSets.processBeginTime ? " ProcessBeginTime=\"" + objSets.processBeginTime + "\" ": "") ;
					}
					if(typeof objSets.processEndTime != "undefined")
					{
						objSetsXmlStr += (objSets.processEndTime ? " ProcessEndTime=\"" + objSets.processEndTime + "\" ": "") ;
					}
					if(typeof objSets.processUserID != "undefined")
					{
						objSetsXmlStr += (objSets.processUserID ? " ProcessUserID=\"" + objSets.processUserID + "\" ": "") ;
					}
					if(typeof objSets.processIP != "undefined")
					{
						objSetsXmlStr += (objSets.processIP ? " ProcessIP=\"" + objSets.processIP + "\" ": "") ;
					}
				}
				
				var resXmlStr = "";
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId;   
				var operationId = "CTL_LOG_QueryEventLog";
				
				if(typeof resParams == "object")
				{
					if(resParams.constructor != Array)
					{ 
						resParams = [resParams]; 
					}
					if(resParams.constructor == Array)
					{
						resParams.each(
							function(item,index){
								var node = item; 
								resXmlStr += " <Res " +
									" ObjType=\"" + node.objType + "\"" +
									" ObjID=\"" + node.objID + "\"" +
									" Type=\"" + node.resType + "\"" +
									" Idx=\"" + node.resIdx + "\"" +
									" CmdType=\"CTL\" OptID=\"" + operationId + "\" EPID=\""+epId+"\" >" + 
									" <Param /></Res> ";  // 
							
							}
						); 
					}
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"resParams error!"}); 
					return [];	
				}
				 
				var requestParamStr = "<?xml version=\"1.0\" encoding=\"utf-8\" ?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\" ><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\" ><DstRes Type=\"SELF\" Idx=\"0\" OptID=\"" + operationId + "\" ><Param /></DstRes></Cmd><ObjSets " + objSetsXmlStr + " BeginTime=\"1305507861\" EndTime=\"1305594261\" Processed=\"1\" >" + resXmlStr + "</ObjSets></Msg>";  // 
				
				//requestParamStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\" > <Cmd Type=\"CTL\" Prio=\"1\" EPID=\"system\" > <DstRes Type=\"SELF\" Idx=\"0\" OptID=\"CTL_LOG_QueryEventLog\" ></DstRes> </Cmd> <ObjSets Offset=\"0\" Count=\"200\" BeginTime=\"1305507861\" EndTime=\"1305594261\" Processed=\"1\" > <Res ObjType=\"151\" ObjID=\"151007233130065022\" Type=\"SELF\" Idx=\"0\" CmdType=\"CTL\" OptID=\"CTL_LOG_QueryEventLog\" EPID=\"system\" ></Res></ObjSets> </Msg>";
				
				Nrcap2.Debug.Write({fn:fn,msg:"request:" + requestParamStr}); // alert(requestParamStr);  
				
				var rvstr = conn.nc.SendRequest(13,"155000100000000001",requestParamStr); // alert(rvstr); // 155000100000000001
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr}); 
				
				return [];
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"exception,error = " + e.message + "::" + e.name});
				return [];
			} 
		}, 
		
		end:true		
	},
	
	/*
	*	函数名	：CommonResource
	*	函数功能	：所有资源对象 
	*	备注		：无
	*	作者		：huzw
	*	时间		：2011.04.21  
	*/ 
	CommonResource:{
		/*
		*	函数名	：CommonResourceControl
		*	函数功能	：资源描述控制 
		*	备注		：无
		*	作者		：huzw
		*	时间		：2011.04.21  
		*	返回值	：成功Array(),失败NrcapError
		*	参数说明	：	6个参数  
		*			string connectId	视频窗口对象
		*			string puid		设备PUID
		*			string idx		资源索引
		*			string type		设备子资源的类型[Nrcap2.Enum.PuResourceType对象]
		*			string action 	动作["get":获取资源信息,"set":设置资源信息] 
		*			Nrcap2.Struct.CommonResDescriptionStruct value	设置资源信息的值[action = "set"使用]
		*/ 
		DescriptionControl:function(connectId,puid,idx,type,action,value){
			try
			{
				if(!connectId || !Nrcap2.Connections.get(connectId))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.CommonResource.DescriptionControl",msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				}
				if(!puid || !Nrcap2.puidRex.test(puid))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.CommonResource.DescriptionControl",msg:"param puid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(idx == null || typeof idx == "undefined" || !Nrcap2.intRex.test(idx))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.CommonResource.DescriptionControl",msg:"param idx error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
				} 
				if(!type || typeof type == "undefined")
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.CommonResource.DescriptionControl",msg:"param type error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
				}				
				
				if(typeof action == "undefined" || (action != "get" && action != "set"))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.CommonResource.DescriptionControl",msg:"param action error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
				}
				else
				{  
					if(action == "set")
					{
						if(value == null || typeof value !="object" || !value instanceof Nrcap2.Struct.CommonResDescriptionStruct)
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.CommonResource.DescriptionControl",msg:"param value error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
						}
						else
						{
							if(!Nrcap2.Utility.CheckByteLength(value.name,0,63) || !Nrcap2.Utility.CheckByteLength(value.description,0,511))
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.CommonResource.DescriptionControl",msg:"param value.name or value.description beyond range error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGVALUELENGTH_BYONDRANGE_ERROR;
							}
							
							var valueStr = "<Param><Res ResType=\""+value.resType+"\" ResIdx=\""+value.resIdx+"\" Name=\""+value.name+"\" Desc=\""+value.description+"\" Enable=\""+value.enable+"\" /></Param>";
							
						}
						 
					}
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				switch(action)
				{
					case 'get': // alert(puid+","+type+","+idx);
						rvstr = conn.nc.GetConfigEx(151,puid,type,idx,"","CFG_COMMONRES_Desc");  // alert(rvstr);
						 
						/*var requestParamStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\" ><Cmd Type=\"GET\" Prio=\"1\" EPID=\""+Nrcap2.Connections.get(connectId).connParam.epId+"\" ><DstRes Type=\"IV\" Idx=\""+idx+"\" OptID=\"CFG_COMMONRES_Desc\" StreamType=\"\" ></DstRes></Cmd></Msg>";
						
						Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.FrameRateControl",msg:"request = " + requestParamStr}); // alert(requestParamStr);
						
						var rvstr = conn.nc.SendRequest(151,puid,requestParamStr);  alert(rvstr);  return 0;*/

					    
						var rvSplitIndex= rvstr.indexOf("#");
						if(rvSplitIndex > -1)
						{							
							rvstr = rvstr.substr(rvSplitIndex + 1);
							if(rvstr.length > 0)
							{
								var xmlObj = new XML.ObjTree();
								if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
								{
									Nrcap2.Debug.Write({fn:"Nrcap2.CommonResource.DescriptionControl",msg:"XML ObjTree load error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
								}
								
								var jsonResource = xmlObj.parseXML(rvstr);  // alert(Object.toJSON(jsonResource));
								
								var descObj = new Object(); 
								if(jsonResource && jsonResource.Param && jsonResource.Param.Res)
								{
									var res = jsonResource.Param.Res;
									
									descObj = new Nrcap2.Struct.CommonResDescriptionStruct(puid,res.ResType,res.ResIdx,res.Name,res.Desc,res.Enable);
									
									//alert(Object.toJSON(descObj));
									return descObj;
								}
								else
								{
									 Nrcap2.Debug.Write({fn:"Nrcap2.CommonResource.DescriptionControl",msg:"no param tag!"});
									 return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
								} 
							} 
							
							return false;
						}
						else
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.CommonResource.DescriptionControl",msg:"get Description error!"});  
							return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
						}
						
						break;
					case 'set': 
						var rv = -1; // alert(valueStr);
						rv = conn.nc.SetConfigEx(151,puid,type,idx,"","CFG_COMMONRES_Desc",valueStr); 
						if(parseInt(rv) == 0)
						{
							rv = Nrcap2.NrcapError.NRCAP_SUCCESS;
						}
						else
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.CommonResource.DescriptionControl",msg:"set Description error:code = " + rv});  
							rv = -1;
						}
						return rv;
						break;
					default:
						break;
				}  
				
				return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED; 
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.CommonResource.DescriptionControl",msg:"DescriptionControl error:" + e.message + "," + e.name});  
				return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
			} 
		},
		
		/* 站点所有资源描述控制 */
		StationResDescSetsControl:function(){
			
		},
		
		end:true
	}, 
	
	/*
	*	函数名	：ShareFunctions
	*	函数功能	：共有的函数对象
	*	备注		：[sdk内部使用] 
	*	作者		：huzw
	*	时间		：2011.04.28 
	*/ 
	ShareConfigFunctions:{
		/* 站点(ST) */
		Station:{
		 	SimpleControl:function(connectId,puid,configId,action,model,value){
				try
				{
					var fn = "Nrcap2.ShareConfigFunctions.Station.SimpleControl";
					
					var puIdx = 0; // 设备索引，应该只有0
					
					var _flag = Nrcap2.ShareParamsCheck(connectId,puid,puIdx,fn); 
					if(_flag != true) return _flag;
					
					if(!configId || typeof configId == "undefined")
					{
						Nrcap2.Debug.Write({fn:fn,msg:"Station SimpleControl configId error!"});  
						return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
					}
					 
					if(typeof action == "undefined" || (action != "get" && action != "set"))
					{
						Nrcap2.Debug.Write({fn:fn,msg:"Station SimpleControl action error!"}); 
						return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
					}
					else
					{ 
						var errorFlag = false;
						
						if(action == "set")
						{
							if(value == null || typeof value == "undefined")
							{
								Nrcap2.Debug.Write({fn:fn,msg:"Station SimpleControl set param value error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
							}
							else
							{  
								switch(model)
								{
									case 'signal': 
										if(!Nrcap2.intRex.test(value) || (value != 0 && value != 1))
										{
											errorFlag = true;
										}
										break;
									case 'ip': break;
									case 'string':
										if(!Object.isString(value) || !Nrcap2.Utility.CheckByteLength(value,0,63))
										{
											errorFlag = true;
										}
										break;	
									case 'puid': 
										if(!Nrcap2.puidRex.test(value) || !Nrcap2.Utility.CheckByteLength(value,18,18))
										{
											errorFlag = true;
										}
										break;
									case 'pwdhex':
										if(!Nrcap2.Utility.CheckByteLength(value,32,32))
										{
											errorFlag = true;
										}
										break;
									case 'other': break;
									default: break;
								} 
								
								if(errorFlag)
								{
									Nrcap2.Debug.Write({fn:fn,msg:"Station SimpleControl model for '" + model + "' beyond range error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGVALUELENGTH_BYONDRANGE_ERROR;
								}    
							}	
						}  
					}
					
					var conn = Nrcap2.Connections.get(connectId);
					var rv = -1, rvstr = ""; 
					
					switch(action)
					{
						case 'get': 
							rvstr = conn.nc.GetConfig(151,puid,Nrcap2.Enum.PuResourceType.SELF,puIdx,"",configId); // alert(rvstr); 
							var rvSplitIndex = rvstr.indexOf("#");
							if(rvSplitIndex > -1)
							{
								rvstr = rvstr.substr(rvSplitIndex + 1);
								if(rvstr.length > 0)
								{	
									Nrcap2.Debug.Write({fn:fn,msg:rvstr});			
									
									switch(model)
									{
										case 'signal': rv = parseInt(rvstr);
											if(rv != 0 && rv != 1)
											{
												errorFlag = true;
											}
											break;
										case 'ip': rv = rvstr; 
											break;
										case 'string': rv = rvstr; 
											if(!Object.isString(rv) || !Nrcap2.Utility.CheckByteLength(rv,0,63))
											{
												errorFlag = true;
											}
											break;
										case 'puid': rv = rvstr; 
											if(!Nrcap2.Utility.CheckByteLength(rv,(18+9),(18+9)))
											{
												errorFlag = true;
											}
											break;
										case 'pwdhex': rv = rvstr;   
											if(!Nrcap2.Utility.CheckByteLength(rv,(32+9),(32+9)))
											{
												errorFlag = true;
											}
											break;
										default: rv = rvstr; 
											break;
									} 
								}
								else
								{
									errorFlag = true;
								}
								 
								if(errorFlag)
								{
									Nrcap2.Debug.Write({fn:fn,msg:"Station SimpleControl get control exception null error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
								}
								else
								{
									return rv;	
								}
							}
							else
							{
								Nrcap2.Debug.Write({fn:fn,msg:"Station SimpleControl get control exception error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
							}
							break;
						case 'set':
							rvstr = conn.nc.SetConfig(151,puid,Nrcap2.Enum.PuResourceType.SELF,puIdx,"",configId,value);
							if(parseInt(rvstr) == 0)
							{
								rv = Nrcap2.NrcapError.NRCAP_SUCCESS;
							}
							else
							{
								Nrcap2.Debug.Write({fn:fn,msg:"Station SimpleControl set control failed!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
							}
							break;
						default: 
							break;
					}
					
					return rv;
				}
				catch(e)
				{
					Nrcap2.Debug.Write({fn:fn,msg:"Station SimpleControl exception error!Error code = " + e.message + ":" + e.name});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
				}
				 
			}, 
			
			ComplexControl:function(connectId,puid,configId,action,model,param){
				try
				{
					var fn = "Nrcap2.ShareConfigFunctions.Station.ComplexControl";
					
					var puIdx = 0; // 设备索引，应该只有0
					
					var _flag = Nrcap2.ShareParamsCheck(connectId,puid,puIdx,fn); 
					if(_flag != true) return _flag;
					
					if(!configId || typeof configId == "undefined")
					{
						Nrcap2.Debug.Write({fn:fn,msg:"Station ComplexControl configId error!"});  
						return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
					}
					 
					if(typeof action == "undefined" || (action != "get" && action != "set"))
					{
						Nrcap2.Debug.Write({fn:fn,msg:"Station ComplexControl action error!"}); 
						return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
					}
					else
					{ 
						var errorFlag = false;
						
						if(action == "set")
						{
							if(param == null || typeof param == "undefined")
							{
								Nrcap2.Debug.Write({fn:fn,msg:"Station ComplexControl set param params error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
							}
							else
							{  
								switch(model)
								{
									case 'signal': break; 
									case 'other': break;
									default: break;
								} 
								
								if(errorFlag)
								{
									Nrcap2.Debug.Write({fn:fn,msg:"Station ComplexControl model for '" + model + "' beyond range error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGVALUELENGTH_BYONDRANGE_ERROR;
								}    
							}	
						}  
					}
					
					var conn = Nrcap2.Connections.get(connectId);
					var rv = -1, rvstr = ""; 
					
					switch(action)
					{
						case 'get':
							rvstr = conn.nc.GetConfigEx(151,puid,Nrcap2.Enum.PuResourceType.SELF,puIdx,"",configId); // alert(rvstr);
							
							var rvSplitIndex = rvstr.indexOf("#");
							
							if(rvSplitIndex > -1)
							{
								rvstr = rvstr.substr(rvSplitIndex +1);
								if(rvstr.length > 0)
								{
									var xmlObj = new XML.ObjTree();
									if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
									{
										Nrcap2.Debug.Write({fn:fn,msg:"XML object error!"});
										return false;
									}
									
									var jsonResource = xmlObj.parseXML(rvstr);
									if(jsonResource && jsonResource.Param)
									{  
										var _TurnToSets = function(_SelectValues){
											if(typeof _SelectValues != "undefined")
											{
												var _Sets = new Array(); 
												
												if(_SelectValues.constructor == Array)
												{
													_Sets = _SelectValues.uniq();
												}
												else
												{
													_Sets.push(_SelectValues);
												}  
												// alert(Object.toJSON(_Sets));
												rv = _Sets;
											}
											else
											{
												errorFlag = true;
											}
										};
										
										switch(model)
										{  
											case 'SupportedTransmitModeSets': 
											 	var _Modes = jsonResource.Param.Mode;
												_TurnToSets(_Modes);
												break;  
											case 'SupportedProxyTypeSets': 
											 	var _Types = jsonResource.Param.Type;
											    _TurnToSets(_Types);
												break;  
											case 'SupportedEventSets':  
												var _SrcRes = jsonResource.Param.SrcRes;
												_TurnToSets(_SrcRes); //[{Type:"..",Event:".."},...] 
												break;
											case 'SupportedActionSets': 
											 	var _Actions = jsonResource.Param.Action;
												_TurnToSets(_Actions); 
												break; 	
											case 'DeviceLinkActions': // 前端联动
												if(jsonResource.Param.deviceLinkActions && typeof jsonResource.Param.deviceLinkActions != "undefined")
												{
													var _DeviceLinkAction = jsonResource.Param.deviceLinkActions.deviceLinkAction;
													if(_DeviceLinkAction && typeof _DeviceLinkAction == "object")
													{
														_TurnToSets(_DeviceLinkAction); 
													}
													else
													{
														errorFlag = true;	
													}
												}
												else
												{
													errorFlag = true;	
												}
												break;
											default:  
												var _Values = jsonResource.Param.Value;
												_TurnToSets(_Values);  
												break;												
										}
										
										if(errorFlag)
										{
											Nrcap2.Debug.Write({fn:fn,msg:"Station ComplexControl model for '" + model + "' beyond range error!"});
											return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGVALUELENGTH_BYONDRANGE_ERROR;
										}
										
										return rv; 
									}
									else
									{
										Nrcap2.Debug.Write({fn:fn,msg:"get ComplexControl param error!"});  
										return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
									}
								}  
							}
							else
							{
								Nrcap2.Debug.Write({fn:fn,msg:"get ComplexControl error:code = " + rv});  
								return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
							} 
							break;
						case 'set':
							rvstr = conn.nc.SetConfigEx(151,puid,Nrcap2.Enum.PuResourceType.SELF,puIdx,"",configId,paramStr);
							if(parseInt(rvstr) == 0)
							{
								rv = Nrcap2.NrcapError.NRCAP_SUCCESS;
							}
							else
							{
								Nrcap2.Debug.Write({fn:fn,msg:"VideoIn ComplexControl set control failed!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
							}
							break;
						default:
							break; 
					}
					
					return rv;
				}
				catch(e)
				{
					Nrcap2.Debug.Write({fn:fn,msg:"Station ComplexControl exception error!Error code = " + e.message + ":" + e.name});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
				}		
				
			},			
			
			end:true
		},
		
		/* 输入视频IV */
		VideoIn:{ 
			SimpleControl:function(connectId,puid,idx,configId,action,streamType,model,value){ 
				try
				{
					var fn = "Nrcap2.ShareConfigFunctions.VideoIn.SimpleControl";
					
					var _flag = Nrcap2.ShareParamsCheck(connectId,puid,idx,fn); 
					if(_flag != true) return _flag;
					
					if(!configId || typeof configId == "undefined")
					{
						Nrcap2.Debug.Write({fn:fn,msg:"VideoIn SimpleControl configId error!"});  
						return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
					}
					
					if(streamType == null || typeof streamType == "undefined")
					{
						Nrcap2.Debug.Write({fn:fn,msg:"VideoIn SimpleControl streamType error!"});  
						return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
					}
					 
					if(typeof action == "undefined" || (action != "get" && action != "set"))
					{
						Nrcap2.Debug.Write({fn:fn,msg:"VideoIn SimpleControl action error!"}); 
						return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
					}
					else
					{ 
						var errorFlag = false;
						
						if(action == "set")
						{
							if(value == null || typeof value == "undefined")
							{
								Nrcap2.Debug.Write({fn:fn,msg:"VideoIn SimpleControl set param 'param' error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
							}
							else
							{  
								switch(model)
								{
									case 'signal': 
										if(value < 0 || value > 100)
										{
											errorFlag = true;
										} 
										break;  
									default: break;
								} 
								
								// alert(paramStr); 
								
								if(errorFlag)
								{
									Nrcap2.Debug.Write({fn:fn,msg:"VideoIn SimpleControl model for '" + model + "' beyond range error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGVALUELENGTH_BYONDRANGE_ERROR;
								}   
								
							}	
						}  
					}
					
					var conn = Nrcap2.Connections.get(connectId);
					var rv = -1, rvstr = ""; 
					
					switch(action)
					{
						case 'get': 
							Nrcap2.Debug.Write({fn:fn,msg:puid + ":" + idx + ":" + streamType + ":" + configId});
							
							rvstr = conn.nc.GetConfig(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,streamType,configId); // alert(rvstr); 
							
							var rvSplitIndex = rvstr.indexOf("#");
							
							if(rvSplitIndex > -1)
							{
								rvstr = rvstr.substr(rvSplitIndex +1);
								if(rvstr.length > 0)
								{ 									 
									switch(model)
									{
										case 'signal': rv = parseInt(rvstr);
											if(rv < 0 || rv > 100)
											{
												errorFlag = true;
											}
											break; 
										default: rv = rvstr; 
											break;												
									}
									
									if(errorFlag)
									{
										Nrcap2.Debug.Write({fn:fn,msg:"VideoIn SimpleControl model for '" + model + "' beyond range error!"});
										return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGVALUELENGTH_BYONDRANGE_ERROR;
									}
										
									return rv; 
								}  
							}
							else
							{
								Nrcap2.Debug.Write({fn:fn,msg:"VideoIn SimpleControl get control error:code = " + rv});  
								return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
							} 
							break;
						case 'set':
							rvstr = conn.nc.SetConfig(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,streamType,configId,value);
							if(parseInt(rvstr) == 0)
							{
								rv = Nrcap2.NrcapError.NRCAP_SUCCESS;
							}
							else
							{
								Nrcap2.Debug.Write({fn:fn,msg:"VideoIn SimpleControl set control failed!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
							}
							break;
						default: 
							break;
					}
					
					return rv;
				}
				catch(e)
				{
					Nrcap2.Debug.Write({fn:fn,msg:"VideoIn SimpleControl exception error!Error code = " + e.message + ":" + e.name});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
				}
			},
			
			ComplexControl:function(connectId,puid,idx,configId,action,streamType,model,param){ 
				try
				{
					var fn = "Nrcap2.ShareConfigFunctions.VideoIn.ComplexControl";
					
					var _flag = Nrcap2.ShareParamsCheck(connectId,puid,idx,fn); 
					if(_flag != true) return _flag;
					
					if(!configId || typeof configId == "undefined")
					{
						Nrcap2.Debug.Write({fn:fn,msg:"VideoIn ComplexControl configId error!"});  
						return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
					}
					
					if(streamType == null || typeof streamType == "undefined")
					{
						Nrcap2.Debug.Write({fn:fn,msg:"VideoIn ComplexControl streamType error!"});  
						return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
					}
					 
					if(typeof action == "undefined" || (action != "get" && action != "set"))
					{
						Nrcap2.Debug.Write({fn:fn,msg:"VideoIn ComplexControl action error!"}); 
						return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
					}
					else
					{ 
						var errorFlag = false;
						
						if(action == "set")
						{
							if(param == null || typeof param == "undefined")
							{
								Nrcap2.Debug.Write({fn:fn,msg:"VideoIn ComplexControl set param 'param' error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
							}
							else
							{ 
								var paramStr = "<Param />";
									
								switch(model)
								{
									case 'frame': 
										if(typeof param !="object" || typeof param.name == "undefined" || param.name.strip() == "" || typeof param.value == "undefined" || param.value.strip() == "")
										{
											Nrcap2.Debug.Write({fn:fn,msg:"param value error!"});
											return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
										} 
										else
										{
											paramStr = "<Param " + param.name +"=\""+ param.value + "\" />";  
										} 
										break;  
									default:
										paramStr = "<Param Value=\""+ param + "\" />";  
										break; 
								} 
								
								// alert(paramStr); 
								
								if(errorFlag)
								{
									Nrcap2.Debug.Write({fn:fn,msg:"VideoIn ComplexControl model for '" + model + "' beyond range error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGVALUELENGTH_BYONDRANGE_ERROR;
								}   
							}	
						}  
					}
					
					var conn = Nrcap2.Connections.get(connectId);
					var rv = -1, rvstr = ""; 
					
					switch(action)
					{
						case 'get': 
							rvstr = conn.nc.GetConfigEx(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,streamType,configId);  //  alert(rvstr);
							
							var rvSplitIndex = rvstr.indexOf("#");
							
							if(rvSplitIndex > -1)
							{
								rvstr = rvstr.substr(rvSplitIndex +1);
								if(rvstr.length > 0)
								{
									var xmlObj = new XML.ObjTree();
									if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
									{
										Nrcap2.Debug.Write({fn:fn,msg:"XML object error!"});
										return false;
									}
									
									var jsonResource = xmlObj.parseXML(rvstr);
									if(jsonResource && jsonResource.Param)
									{  
										var _TurnToSets = function(_SelectValues){
											if(typeof _SelectValues != "undefined")
											{
												var _Sets = new Array(); 
												
												if(_SelectValues.constructor == Array)
												{
													_Sets = _SelectValues.uniq();
												}
												else
												{
													_Sets.push(_SelectValues);
												}  
												// alert(Object.toJSON(_Sets));
												rv = _Sets;
											}
											else
											{
												errorFlag = true;
											}
										};
										
										switch(model)
										{
											case 'frame':
												var name = "", value = "";
												
												if(typeof jsonResource.Param.FramePerSec != "undefined")
												{
													name = "FramePerSec";
													value = jsonResource.Param.FramePerSec;	
												}
												else if(typeof jsonResource.Param.SecPerFrame != "undefined")
												{
													name = "SecPerFrame";
													value = jsonResource.Param.SecPerFrame;	
												}
												else
												{
													errorFlag = true;
												}
												 
												rv = {"name":name,"value":value};
												
												break;
											
											case 'SupportedEncoderSets': 
											 	var _Encoders = jsonResource.Param.Encoder;
												_TurnToSets(_Encoders);
												break; 
											
											case 'SupportedStreamTypeSets':
												var _StreamType = jsonResource.Param.StreamType;
											    _TurnToSets(_StreamType);
												break;
												
											case 'SupportedResolutionSets':
												var _Resolution = jsonResource.Param.Resolution;
												_TurnToSets(_Resolution); 
												break;
												
											case 'SupportedGPSAddModeSets':
												var _Mode = jsonResource.Param.Mode;
												_TurnToSets(_Mode); 
												break;
												
											default:  
												var _Values = jsonResource.Param.Value;
												_TurnToSets(_Values);  
												break;												
										}
										
										if(errorFlag)
										{
											Nrcap2.Debug.Write({fn:fn,msg:"VideoIn ComplexControl model for '" + model + "' beyond range error!"});
											return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGVALUELENGTH_BYONDRANGE_ERROR;
										}
										
										return rv; 
									}
									else
									{
										Nrcap2.Debug.Write({fn:fn,msg:"get ComplexControl param error!"});  
										return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
									}
								}  
							}
							else
							{
								Nrcap2.Debug.Write({fn:fn,msg:"get ComplexControl error:code = " + rv});  
								return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
							} 
							break;
						case 'set':
							rvstr = conn.nc.SetConfigEx(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,streamType,configId,paramStr);
							if(parseInt(rvstr) == 0)
							{
								rv = Nrcap2.NrcapError.NRCAP_SUCCESS;
							}
							else
							{
								Nrcap2.Debug.Write({fn:fn,msg:"VideoIn ComplexControl set control failed!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
							}
							break;
						default: 
							break;
					}
					
					return rv;
				}
				catch(e)
				{
					Nrcap2.Debug.Write({fn:fn,msg:"VideoIn ComplexControl exception error!Error code = " + e.message + ":" + e.name});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
				}
			}, 
			
			end:true
		},
		
		end:true
	},
	
	/*
	*	函数名	：DNSConfig
	*	函数功能	：DNS配置对象 
	*	备注		：无
	*	作者		：huzw
	*	时间		：2011.04.28  
	*/ 
	DNSConfig:{
		/* DHCP时是否自动获取DNS */
		ObtainDNSDynamicControl:function(connectId,puid,action,value){
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_ObtainDNSDynamic",action,"signal",value);
		},
		
		/* 配置的DNS,当CFG_ST_ObtainDNSDynamic为0时生效 */
		DNSIPControl:function(connectId,puid,action,value){
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_DNSIP",action,"ip",value);
		},
		
		end:true
	},
	
	/*
	*	函数名	：LANConfig
	*	函数功能	：本地网络(LAN)配置对象
	*	备注		：无
	*	作者		：huzw
	*	时间		：2011.04.29  
	*/ 
	LANConfig:{
		/* 是否启用DHCP */
		EnableDHCPControl:function(connectId,puid,action,value){
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_EnableDHCP",action,"signal",value);
		},
		
		/* 配置的IP地址 */
		IPAddressControl:function(connectId,puid,action,value){
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_IP",action,"ip",value);
		},
		
		/* 配置的子网掩码 */
		SubnetMaskControl:function(connectId,puid,action,value){
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_SubnetMask",action,"ip",value);
		},
		
		/* 配置的网关IP */
		GatewayIPControl:function(connectId,puid,action,value){
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_GatewayIP",action,"ip",value);
		},
		
		/* DHCP获取的IP地址 */
		GetDHCPIP:function(connectId,puid){
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_DHCPIP","get","ip");
		},
		
		/* DHCP获取的子网掩码 */
		GetDHCPSubnetMask:function(connectId,puid){
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_DHCPSubnetMask","get","ip");
		},
		
		/* DHCP获取的网关IP */
		GetDHCPGatewayIP:function(connectId,puid){
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_DHCPGatewayIP","get","ip");
		},
		
		end:true
	},
	
	/*
	*	函数名	：PPPoEConfig
	*	函数功能	：PPPoE配置对象
	*	备注		：无
	*	作者		：huzw
	*	时间		：2011.04.29  
	*/ 
	PPPoEConfig:{
		/* 是否启用PPPoE */
		EnablePPPoEControl:function(connectId,puid,action,value){
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_EnablePPPoE",action,"signal",value);
		},
		
		/* PPPoE用户名 */
		PPPoEUserNameControl:function(connectId,puid,action,value){
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_PPPoEUserName",action,"string",value);
		},
		
		/* PPPoE用户密码 */
		PPPoEUserPswControl:function(connectId,puid,action,value){
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_PPPoEUserPsw",action,"string",value);
		},
		
		/* PPPoE状态 */
		/*  Free 	空闲,表示没有启动PPPoE拨号
			Dialing	拨号中.  
			OK		拨号成功
		*/
		GetPPPoEStatus:function(connectId,puid){
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_PPPoEStatus","get","other");
		},
		
		/* PPPoE获取的IP地址 */
		GetPPPoEIP:function(connectId,puid){
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_PPPoEIP","get","ip");
		},
		
		
		end:true
	},
	
	/*
	*	函数名	：PlatformAccessConfig
	*	函数功能	：平台接入配置.
	*	备注		：无
	*	作者		：huzw
	*	时间		：2011.05.03  
	*/ 
	PlatformAccessConfig:{
		/* 平台地址ip:port等 */
		PlatformAddressControl:function(connectId,puid,action,value){
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_PlatformAddr",action,"ip",value);
		},
		
		/* 备份平台地址ip:port等 */
		SecondaryPlatformAddressControl:function(connectId,puid,action,value){
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_SecondaryPlatformAddr",action,"ip",value);
		},
		
		/* PUID */
		PUIDControl:function(connectId,puid,action,value){
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_PUID",action,"puid",value);	
		}, 
		
		/* 设备接入密码 */
		RegPswControl:function(connectId,puid,action,value){
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_RegPsw",action,"pwdhex",value);
		},
		
		/* 获取平台接入状态 */
		GetRegPlatformStatus:function(connectId,puid){
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_RegPlatformStatus","get","other");
		},
		
		/* 获取支持的流传输方式 */
		GetSupportedTransmitModeSets:function(connectId,puid){
			var model = "SupportedTransmitModeSets";
			return Nrcap2.ShareConfigFunctions.Station.ComplexControl(connectId,puid,"CFG_ST_SupportedTransmitModeSets","get",model);
		},
		
		/* 流传输方式 */
		TransmitModeControl:function(connectId,puid,action,value){
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_TransmitMode",action,"other",value);
		},
		
		/* 是否启用密码保护 */
		EnablePasswordProtectControl:function(connectId,puid,action,value)
		{
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_EnablePasswordProtect",action,"signal",value);
		},
		
		/* 是否使用代理接入平台 */
		ConnectPlatformByProxyControl:function(connectId,puid,action,value)
		{
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_ConnectPlatformByProxy",action,"signal",value);
		},
		
		/* 获取支持的代理类型 */
		GetSupportedProxyTypeSets:function(connectId,puid)
		{
			var model = "SupportedProxyTypeSets";
			return Nrcap2.ShareConfigFunctions.Station.ComplexControl(connectId,puid,"CFG_ST_SupportedProxyTypeSets","get",model);
		},
		
		/* 代理类型 */
		ProxyTypeControl:function(connectId,puid,action,value)
		{
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_ProxyType",action,"string",value);
		},
		
		/* 代理地址 */
		ProxyAddressControl:function(connectId,puid,action,value)
		{
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_ProxyAddr",action,"string",value);
		},
		
		/* 代理是否需要密码 */
		ProxyNeedPswControl:function(connectId,puid,action,value)
		{
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_ProxyNeedPsw",action,"signal",value);
		},
		
		/* 代理用户名 */
		ProxyUserNameControl:function(connectId,puid,action,value)
		{
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_ProxyUserName",action,"string",value);
		},
		
		/* 代理密码 */
		ProxyUserPswControl:function(connectId,puid,action,value)
		{
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_ProxyUserPsw",action,"string",value);
		},
		
		end:true
	},
	
	/*
	*	函数名	：DeviceInfoConfig
	*	函数功能	：设备信息配置.
	*	备注		：无
	*	作者		：huzw
	*	时间		：2011.05.11  
	*/ 
	DeviceInfoConfig:{
		/* 设备型号 */
		GetModel:function(connectId,puid){ 
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,idx,"CFG_ST_Model","get","string");
		},
		
		/* 软件版本 */
		GetSoftwareVersion:function(connectId,puid){ 
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_SoftwareVersion","get","string");
		},
		
		/* 硬件型号 */
		GetHardwareModel:function(connectId,puid){ 
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_HardwareModel","get","string");
		},
		
		/* 硬件版本 */
		GetHardwareVersion:function(connectId,puid){ 
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_HardwareVersion","get","string");
		},
		
		/* 厂商ID */
		GetProducerID:function(connectId,puid){ 
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_ProducerID","get","string");
		},
		
		/* 设备ID */
		GetDeviceID:function(connectId,puid){ 
			return Nrcap2.ShareConfigFunctions.Station.SimpleControl(connectId,puid,"CFG_ST_DeviceID","get","string");
		},
		
		end:true
	},
	
	/*
	*	函数名	：DeviceLinkActionConfig
	*	函数功能	：前端联动配置.
	*	备注		：无
	*	作者		：huzw
	*	时间		：2011.05.12  
	*/ 
	DeviceLinkActionConfig:{
		/* 支持的事件 */
		GetSupportedEventSets:function(connectId,puid){
			var model = "SupportedEventSets";
			return Nrcap2.ShareConfigFunctions.Station.ComplexControl(connectId,puid,"CFG_ST_SupportedEventSets","get",model);
		},
		
		/* 支持的动作 */
		GetSupportedActionSets:function(connectId,puid){
			var model = "SupportedActionSets";
			return Nrcap2.ShareConfigFunctions.Station.ComplexControl(connectId,puid,"CFG_ST_SupportedActionSets","get",model);
		},
		
		/* 前端联动 */
		DeviceLinkActionsControl:function(connectId,puid,action,params){
			var valueParams = "<Param />";
			 
			if(!params || typeof params != "object")
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.DeviceLinkActionConfig.DeviceLinkActionsControl",msg:"params error!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
			}
			else
			{
				if(typeof params == "object" && params.constructor != Array)
				{
					params = [params];	
				} 
				
				if(typeof params == "object" && params.constructor == Array)
				{
					valueParams = "<deviceLinkActions>";
					params.each(
						function(item,index){
							var node = item[index];
							
							valueParams += "<deviceLinkAction>";
							
							valueParams += "<eventType>" + node.eventType + "</eventType>";
							valueParams += "<eventSrcNo>" + node.eventSrcNo + "</eventSrcNo>";
							valueParams += "<guardMap>" + node.guardMap + "</guardMap>";
							valueParams += "<action>" + node.action + "</action>";
							
							var actionParamXmlStr = "";
							switch(node.action)
							{
								case 'alertOut':
									break;
									
								case 'sendEmail':
									break;
									
								case 'ftpUpload':
									break;
									
								case 'record':
									break;
									
								case 'snapshot':
									break;
									
								case 'moveToPresetPosition':
									break;
									
								case 'online':
									break;
									
								case 'sendSMS':
									break;
									
								default:  
									break;																	
							}
							
							valueParams += "<actionParams>" + actionParamXmlStr + "</actionParams>";
							
							valueParams += "</deviceLinkAction>";
						}
					);
					valueParams += "</deviceLinkActions>";
				}			
			}
			
			var model = "DeviceLinkActions";
			return Nrcap2.ShareConfigFunctions.Station.ComplexControl(connectId,puid,"CFG_ST_DeviceLinkActions",action,model,valueParams); 
		},
				
		end:true
	},	
	
	/*
	*	函数名	：ShareParamsCheck
	*	函数功能	：检查一些共有的参数 
	*	备注		：[sdk内部使用] 
	*	作者		：huzw
	*	时间		：2011.04.25
	*	参数		：4个参数 
	*/ 
	ShareParamsCheck:function(connectId,puid,idx,fn){
		try
		{
			if(!fn || typeof fn == "undefined")
			{
				fn = "Nrcap2.xxx";	
			}
			if(!connectId || !Nrcap2.Connections.get(connectId))
			{
				Nrcap2.Debug.Write({fn:fn,msg:"param connectId error!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
			}
			if(!puid || !Nrcap2.puidRex.test(puid))
			{
				Nrcap2.Debug.Write({fn:fn,msg:"param puid error!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
			}
			if(idx == null || typeof idx == "undefined" || !Nrcap2.intRex.test(idx))
			{
				Nrcap2.Debug.Write({fn:fn,msg:"param idx error!"});
				return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
			} 
			return true;
		}
		catch(e)
		{
			Nrcap2.Debug.Write({fn:fn,msg:"exception error:" + e.message + "," + e.name});  
			return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;	
		}
	},
	
	/*
	*	函数名	：CaptureParam
	*	函数功能	：视频采集参数对象 
	*	备注		：无
	*	作者		：huzw
	*	时间		：2011.04.25  
	*/ 
	CaptureParam:{ 
		/*
		*	函数名	：CameraStatus
		*	函数功能	：摄像机状态 
		*	备注		：无
		*	作者		：huzw
		*	时间		：2011.04.25   
		*	返回值	：成功返回0/1,0表示无视频,1表示有视频;失败NrcapError
		*	参数说明	：3个参数  
		*			string connectId	视频窗口对象
		*			string puid		设备PUID
		*			unit idx		视频头索引  
		*/ 
		CameraStatus:function(connectId,puid,idx){
			try
			{
				var fn = "Nrcap2.CaptureParam.CameraStatus";
				var _flag = Nrcap2.ShareParamsCheck(connectId,puid,idx,fn); 
				if(_flag != true) return _flag;
				
				var rv = -1;
				
				var rvstr = Nrcap2.Connections.get(connectId).nc.GetConfig(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,"","CFG_IV_CameraStatus");
				
				var rvSplitIndex = rvstr.indexOf("#");
				if(rvSplitIndex > -1)
				{ 
					if(parseInt(rvstr.split("#")[0]) == 0x0000) 
					{
						rvstr = parseInt(rvstr.split("#")[1]);
						if(rvstr != 0 && rvstr != 1)
						{
							rv = -1;
						}   
						else
						{
							rv = rvstr;
						}
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"get CameraStatus error:code = " + rvstr});  
					} 
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"get CameraStatus error:code = " + rvstr});  
				}
				return rv;
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"exception error:" + e.message + "," + e.name});  
				return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;	
			}
		},
		
		VideoInParamControl:function(connectId,puid,idx,param,action,value){ 
			try
			{
				var fn = "Nrcap2.CaptureParam.VideoInParamControl";
				var _flag = Nrcap2.ShareParamsCheck(connectId,puid,idx,fn); 
				if(_flag != true) return _flag;
				
				if(!param || typeof param == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"VideoInParamControl param error!"});  
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
				}
				
				if(typeof action == "undefined" || (action != "get" && action != "set"))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"VideoInParamControl action error!"}); 
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
				}
				else
				{
					if(action == "set")
					{
						if(value == null || typeof value == "undefined" || !Nrcap2.intRex.test(value))
						{
							Nrcap2.Debug.Write({fn:fn,msg:"set param value error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
						}
						else
						{
							if(value < 0 || value > 100)
							{
								Nrcap2.Debug.Write({fn:fn,msg:"param value beyond range error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGVALUELENGTH_BYONDRANGE_ERROR;
							}
						}
					}  
				}
				
				var rv = -1, rvstr = "", ivParam = "";
				
				ivParam = Nrcap2.Enum.ConfigID[param];
				
				switch(action)
				{
					case 'get':
						rv = Nrcap2.Connections.get(connectId).nc.GetConfig(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,"",param);
						
						rvstr = rv.indexOf("#");
						if(rvstr > -1)
						{
							if(parseInt(rv.split("#")[0]) == 0x0000) 
							{
								rv = parseInt(rv.split("#")[1]);
								if(rv < 1 || rv > 100)
								{
									rv = -1;
								}  
							}
							else
							{
								Nrcap2.Debug.Write({fn:fn,msg:"get VideoInParam error:code = " + rv});  
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"get VideoInParam error:code = " + rv});  
						}
						
						return rv;
						break;
					case 'set':
						rvstr = Nrcap2.Connections.get(connectId).nc.SetConfig(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,"",param,value);
						if(parseInt(rvstr) == 0)
						{
							rv = Nrcap2.NrcapError.NRCAP_SUCCESS;
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"set VideoInParamControl error:code = " + rvstr});  
							rv = -1;
						}
						return rv;
						break;
					default:
						break;
				} 
				
				return  Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;				
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"VideoInParamControl exception error:" + e.message + "," + e.name});  
				return  Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
			} 
			
		},
		
		SupportedAnalogFormatModeSets:function(){
			
		},
		
		AnalogFormatModeControl:function(){ 
			
		},
		
		SupportedAnalogFormatSets:function(){
			
		},
		
		ManualAnalogFormatControl:function(){
			
		},
		
		CurrentAnalogFormat:function(){
			
		},
		
		end:true
	},
	
	/*
	*	函数名	：VideoOverlay
	*	函数功能	：视频叠加对象 
	*	备注		：无
	*	作者		：huzw
	*	时间		：2011.04.25  
	*/ 
	VideoOverlay:{
		/* 是否叠加时间 */
		AddTimeControl:function(connectId,puid,idx,action,streamType,value){
			return this.AddShareControl(connectId,puid,idx,action,streamType,"time",value);
		},
		
		/* 叠加时间位置 */
		TimeAddPositionControl:function(connectId,puid,idx,action,value){ 
			return this.ShareAddPositionControl(connectId,puid,idx,action,"time",value);
		},
		
		/* 是否叠加共享 */ 
		AddShareControl:function(connectId,puid,idx,action,streamType,type,value){
			try
			{
				var fn = "Nrcap2.VideoOverlay.AddShareControl"; 
					 
				if(typeof type == "undefined" || !Object.isString(type))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"AddShareControl type error!"}); 
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
				}
				
				var _flag = Nrcap2.ShareParamsCheck(connectId,puid,idx,fn); 
				if(_flag != true) return _flag;	 
				
				if(typeof action == "undefined" || (action != "get" && action != "set"))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"AddShareControl action error!"}); 
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
				}
				else
				{
					if(!streamType || typeof streamType == "undefined")
					{
						Nrcap2.Debug.Write({fn:fn,msg:"param streamType error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
					}
					
					if(action == "set")
					{
						if(value == null || typeof value == "undefined" || !Nrcap2.intRex.test(value))
						{
							Nrcap2.Debug.Write({fn:fn,msg:"set param value error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
						}
						else
						{
							if(value != 0 && value != 1)
							{
								Nrcap2.Debug.Write({fn:fn,msg:"param value beyond range error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGVALUELENGTH_BYONDRANGE_ERROR;
							}
						}
					}  
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var rv = -1, rvstr = "", ConfigId = "";
				 
				switch(type)
				{
					case 'time': ConfigId = "CFG_IV_AddTime"; break;
					case 'logo': ConfigId = "CFG_IV_AddLogo"; break;
					case 'text': ConfigId = "CFG_IV_AddText"; break;
					case 'alarm': ConfigId = "CFG_IV_AddAlarm"; break;
					case 'gps': ConfigId = "CFG_IV_AddGPS"; break;
					default: 
						Nrcap2.Debug.Write({fn:fn,msg:"AddShareControl type error!"}); 
						return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
						break;
				} 
				
				switch(action)
				{
					case 'get':
						rv = conn.nc.GetConfig(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,streamType,ConfigId);
						//alert(rv);
						rvstr = rv.indexOf("#");
						if(rvstr > -1)
						{
							if(parseInt(rv.split("#")[0]) == 0x0000) 
							{
								rv = parseInt(rv.split("#")[1]);
								if(rv != 0 && rv != 1)
								{
									rv = -1;
								}  
							}
							else
							{
								Nrcap2.Debug.Write({fn:fn,msg:"get AddShare error:code = " + rv});  
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"get AddShare error:code = " + rv});  
						}
						
						return rv;
						break;
					case 'set':
						rvstr = conn.nc.SetConfig(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,streamType,ConfigId,value);
						if(parseInt(rvstr) == 0)
						{
							rv = Nrcap2.NrcapError.NRCAP_SUCCESS;
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"set AddShare error:code = " + rvstr});  
							rv = -1;
						}
						return rv;
						break;
					default: 
						break;	
				}
				return rv;
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"AddShareControl exception error:" + e.message + "," + e.name});  
				return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
			}
		},
		
		/* 叠加位置共享 */ 
		ShareAddPositionControl:function(connectId,puid,idx,action,type,value){
			try
			{ 
				var	fn = "Nrcap2.VideoOverlay.ShareAddPositionControl";
					 
				if(typeof type == "undefined" || !Object.isString(type))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"ShareAddPositionControl type error!"}); 
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
				}
				
				var _flag = Nrcap2.ShareParamsCheck(connectId,puid,idx,fn); 
				if(_flag != true) return _flag;	
				
				if(typeof action == "undefined" || (action != "get" && action != "set"))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"ShareAddPositionControl action error!"}); 
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
				}
				else
				{ 
					if(action == "set")
					{ 
						if(value == null || typeof value != "object" || typeof value["XPos"] == "undefined" || typeof value["YPos"] == "undefined")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"set param value error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
						}
						else
						{
							var XPos = parseInt(value["XPos"]);
							var YPos = parseInt(value["YPos"]);
							
							if(XPos < 0 || XPos > 351 || YPos < 0 || YPos > 287)
							{
								Nrcap2.Debug.Write({fn:fn,msg:"set param value.XPos or value.YPos beyond range error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGVALUELENGTH_BYONDRANGE_ERROR;
							}
							var valueStr = "<Param XPos=\""+XPos+"\" YPos=\""+YPos+"\"></Param>";
							 
							//alert(valueStr); return false;
							
						}
					}  
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var rv = {}, rvstr = "", ConfigId = "";
				 
				switch(type)
				{
					case 'time': ConfigId = "CFG_IV_TimeAddPosition"; break;
					case 'logo': ConfigId = "CFG_IV_LogoAddPosition"; break;
					case 'text': ConfigId = "CFG_IV_TextAddPosition"; break;
					default: 
						Nrcap2.Debug.Write({fn:fn,msg:"ShareAddPositionControl type error!"}); 
						return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
						break;
				} 
				
				switch(action)
				{
					case 'get':  
						rvstr = conn.nc.GetConfigEx(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,"",ConfigId); 
						 
						var rvstrIndex = rvstr.indexOf("#");
						if(rvstrIndex > -1)
						{
							rvstr = rvstr.substr(rvstrIndex + 1);
							
							if(rvstr.length > 0)
							{
								var xmlObj = new XML.ObjTree();
								if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
								{
									Nrcap2.Debug.Write({fn:fn,msg:"XML ObjTree load error!"});
									return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
								}
								else
								{
									try
									{
										var jsonResource = xmlObj.parseXML(rvstr);    //alert(Object.toJSON(jsonResource));
										
										if(jsonResource && jsonResource.Param && jsonResource.Param.XPos && jsonResource.Param.YPos)
										{
											rv = {"XPos":jsonResource.Param.XPos,"YPos":jsonResource.Param.YPos};
										}
										else
										{
											Nrcap2.Debug.Write({fn:fn,msg:"get ShareAddPosition Param X/Y Pos error!"});  
										}
									}
									catch(e)
									{
										Nrcap2.Debug.Write({fn:fn,msg:"get ShareAddPosition Param exception error!"}); 	
									}
								}
								
							} 
							else
							{
								Nrcap2.Debug.Write({fn:fn,msg:"get ShareAddPosition error:code = " + rvstr});  
							}
							
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"get ShareAddPosition error:code = " + rvstr});  
						}
						
						return rv;
						break;
					case 'set':
						//alert(valueStr);
						rvstr = conn.nc.SetConfigEx(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,"",ConfigId,valueStr);
						//alert(rvstr);
						if(parseInt(rvstr) == 0)
						{
							rv = Nrcap2.NrcapError.NRCAP_SUCCESS;
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"set ShareAddPosition error:code = " + rvstr});  
							rv = -1;
						}
						return rv;
						break;
					default: 
						break;	
				}
				return rv; 
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"ShareAddPositionControl exception error:" + e.message + "," + e.name});  
				return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
			}		 
		},
		
		/* 是否叠加图标 */
		AddLogoControl:function(connectId,puid,idx,action,streamType,value){
			return this.AddShareControl(connectId,puid,idx,action,streamType,"logo",value); 
		},
		
		/* 叠加图标的位置 */
		LogoAddPositionControl:function(connectId,puid,idx,action,value){
			return this.ShareAddPositionControl(connectId,puid,idx,action,"logo",value);
		},
		
		/* 是否叠加文字 */
		AddTextControl:function(connectId,puid,idx,action,streamType,value){
			return this.AddShareControl(connectId,puid,idx,action,streamType,"text",value);
		},
		
		/* 叠加文字的位置 */
		TextAddPositionControl:function(connectId,puid,idx,action,value){
			return this.ShareAddPositionControl(connectId,puid,idx,action,"text",value);
		},
		
		/* 叠加文字的内容 */
		TextAddContentControl:function(connectId,puid,idx,action,value){
			try
			{
				var fn = "Nrcap2.VideoOverlay.TextAddContentControl";
				var _flag = Nrcap2.ShareParamsCheck(connectId,puid,idx,fn); 
				if(_flag != true) return _flag;	
				
				if(typeof action == "undefined" || (action != "get" && action != "set"))
				{
					Nrcap2.Debug.Write({fn:fn,msg:"TextAddContentControl action error!"}); 
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
				}
				else
				{ 
					if(action == "set")
					{ 
						if(!Object.isString(value) || !Nrcap2.Utility.CheckByteLength(value,0,63))
						{
							Nrcap2.Debug.Write({fn:fn,msg:"TextAddContentControl value beyond range error!"}); 
							return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGVALUELENGTH_BYONDRANGE_ERROR;
						}
					}  
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var rv = -1, rvstr = "";
				
				switch(action)
				{
					case 'get':
						rvstr = conn.nc.GetConfig(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,"","CFG_IV_TextAdd");
						//alert(rvstr);
						
						var rvstrIndex = rvstr.indexOf("#");
						if(rvstrIndex > -1)
						{
							rvstr = rvstr.substr(rvstrIndex + 1);
							
							if(rvstr.length > 0)
							{
								rv = rvstr;
							}
							else
							{
								Nrcap2.Debug.Write({fn:fn,msg:"get textAddContent error!"});  
							}				
							
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"get textAddContent error!"});  
						}		
						
						return rv; 
						break;
					case 'set':
						//alert(value);
						rvstr = conn.nc.SetConfig(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,"","CFG_IV_TextAdd",value);
						//alert(rvstr);
						rvstr = rvstr.toString();
						
						if(parseInt(rvstr.split("#")) == 0x0000)
						{
							rv = Nrcap2.NrcapError.NRCAP_SUCCESS;
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"set textAddContent error!error code:" + rvstr});  
						}
						return rv;
						break;
					default:
						break;
				}
				
				return rv; 
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"TextAddContentControl exception error:" + e.message + "," + e.name});  
				return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
			}
		},
		
		/* 是否叠加报警信息 */
		AddAlarmControl:function(connectId,puid,idx,action,streamType,value){ 
			return this.AddShareControl(connectId,puid,idx,action,streamType,"alarm",value); 
		},
		
		/* 是否叠加GPS信息 */
		AddGPSControl:function(connectId,puid,idx,action,streamType,value){
			return this.AddShareControl(connectId,puid,idx,action,streamType,"gps",value); 
		},
		
		/* 支持的GPS信息叠加模式 */
		GetSupportedGPSAddModeSets:function(connectId,puid,idx){
			var streamType = "", model = "SupportedGPSAddModeSets";
			return Nrcap2.ShareConfigFunctions.VideoIn.ComplexControl(connectId,puid,idx,"CFG_IV_SupportedGPSAddModeSets","get",streamType,model);
		},
		
		/* GPS信息叠加模式Full/Speed Only */
		GPSAddModeControl:function(connectId,puid,idx,action,streamType,value){
		    var model = "other";
			return Nrcap2.ShareConfigFunctions.VideoIn.SimpleControl(connectId,puid,idx,"CFG_IV_GPSAddMode",action,streamType,model,value);
		},
		
		/* 速度报警时是否警告色叠加GPS */
		AddGPSAlarmControl:function(connectId,puid,idx,action,value){
		    var streamType = "", model = "signal";
			return Nrcap2.ShareConfigFunctions.VideoIn.SimpleControl(connectId,puid,idx,"CFG_IV_AddGPSAlarm",action,streamType,model,value);
		},
		
		/* 是否叠加地理信息 */
		AddGEOInfoControl:function(connectId,puid,idx,action,streamType,value){
		    var model = "signal";
			return Nrcap2.ShareConfigFunctions.VideoIn.SimpleControl(connectId,puid,idx,"CFG_IV_AddGEOInfo",action,streamType,model,value);
		},
		
		end:true
	},
	
	/*
	*	函数名	：EncodeParam
	*	函数功能	：编码参数对象 
	*	备注		：无
	*	作者		：huzw
	*	时间		：2011.04.21  
	*/ 
	EncodeParam:{
		/* 支持的编码算法 */
		GetSupportedEncoderSets:function(connectId,puid,idx){
			// 是否需要流类型['REALTIME' .etc], 若不需要就赋值为空字符串
			var streamType = "";  
			return Nrcap2.ShareConfigFunctions.VideoIn.ComplexControl(connectId,puid,idx,"CFG_IV_SupportedEncoderSets","get",streamType,"SupportedEncoderSets");
		},
		
		/* 编码算法 */
		EncoderControl:function(connectId,puid,idx,action,value){
			// model = 'other'为不需处理的参数值,下同
			var streamType = "", model = "other";  
			return Nrcap2.ShareConfigFunctions.VideoIn.SimpleControl(connectId,puid,idx,"CFG_IV_Encoder",action,streamType,model,value);
		},
		
		/* 存储流预录时间 */
		PrevRecordTimeControl:function(connectId,puid,idx,action,value){ 
			var streamType = "", model = "other";  
			return Nrcap2.ShareConfigFunctions.VideoIn.SimpleControl(connectId,puid,idx,"CFG_IV_PrevRecordTime",action,streamType,model,value);
		},
		
		/* 存储流预录时间 */
		GetSupportedStreamTypeSets:function(connectId,puid,idx){ 
			var streamType = "", model = "SupportedStreamTypeSets";  
			return Nrcap2.ShareConfigFunctions.VideoIn.ComplexControl(connectId,puid,idx,"CFG_IV_SupportedStreamTypeSets","get",streamType,model);
		},
		
		/* 是否使能流类型 */
		EnableStreamTypeControl:function(connectId,puid,idx,action,streamType,value){  
			var model = "other";  
			return Nrcap2.ShareConfigFunctions.VideoIn.SimpleControl(connectId,puid,idx,"CFG_IV_EnableStreamType",action,streamType,model,value);
		},
		
		/* 支持的编码分辨率 */
		GetSupportedResolutionSets:function(connectId,puid,idx,streamType){  
			var model = "SupportedResolutionSets"; 
			return Nrcap2.ShareConfigFunctions.VideoIn.ComplexControl(connectId,puid,idx,"CFG_IV_SupportedResolutionSets","get",streamType,model);
		},
		
		/* 编码分辨率 */
		ResolutionControl:function(connectId,puid,idx,action,streamType,value){  
			var model = "other";  
			return Nrcap2.ShareConfigFunctions.VideoIn.SimpleControl(connectId,puid,idx,"CFG_IV_Resolution",action,streamType,model,value);
		}, 
		
		/*
		*	函数名	：KeyFrameInterval
		*	函数功能	：关键帧间隔控制
		*	备注		：无
		*	作者		：huzw
		*	时间		：2011.04.21  
		*	返回值	：	(get)成功返回1~1000整数;(set)成功0,失败NrcapError
		*	参数说明	：	6个参数  
		*			string connectId	视频窗口对象
		*			string puid		设备PUID
		*			unit idx		视频头索引 
		*			string action 	动作["get":获取关键帧间隔,"set":设置关键帧间隔]
		*			sting 	streamType  流类型[Nrcap2.Enum.NrcapStreamType对象]
		*			unit	value	设置关键帧间隔的值[action = "set"使用]
		*/ 
		KeyFrameIntervalControl:function(connectId,puid,idx,action,streamType,value){
			try
			{
				if(!connectId || !Nrcap2.Connections.get(connectId))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.KeyFrameIntervalControl",msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				}
				if(!puid || !Nrcap2.puidRex.test(puid))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.KeyFrameIntervalControl",msg:"IV puid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(idx == null || typeof idx == "undefined" || !Nrcap2.intRex.test(idx))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.KeyFrameIntervalControl",msg:"IV idx error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
				} 
				
				if(typeof action == "undefined" || (action != "get" && action != "set"))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.KeyFrameIntervalControl",msg:"param action error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
				}
				else
				{
					if(!streamType || typeof streamType == "undefined")
					{
						Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.KeyFrameIntervalControl",msg:"param streamType error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
					}
					
					if(action == "set")
					{
						if(value == null || typeof value =="undefined" || !Nrcap2.intRex.test(value))
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.KeyFrameIntervalControl",msg:"param value error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
						}
						else
						{
							value = parseInt(value);
							if(value < 1 || value > 1000)
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.KeyFrameIntervalControl",msg:"param value beyond range error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGVALUELENGTH_BYONDRANGE_ERROR;
							} 
						}
					}
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var rv = -1;
				switch(action)
				{
					case 'get':
						rv = conn.nc.GetConfig(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,streamType,"CFG_IV_KeyFrameInterval");
						
						var rvstr = rv.indexOf("#");
						if(rvstr > -1)
						{
							if(parseInt(rv.split("#")[0]) == 0x0000) 
							{
								rv = parseInt(rv.split("#")[1]);
								if(rv < 1 || rv > 1000)
								{
									rv = -1;
								}  
							}
							else
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.KeyFrameIntervalControl",msg:"get KeyFrameInterval error:code = " + rv});  
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.KeyFrameIntervalControl",msg:"get KeyFrameInterval error:code = " + rv});  
						}
						
						break;
					case 'set':
						rv = conn.nc.SetConfig(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,streamType,"CFG_IV_KeyFrameInterval",value);
						if(parseInt(rv) == 0)
						{
							rv = Nrcap2.NrcapError.NRCAP_SUCCESS;
						}
						else
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.KeyFrameIntervalControl",msg:"set KeyFrameInterval error:code = " + rv});  
							rv = -1;
						}
						break;
					default:
						break;
				}  
				return rv;
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.KeyFrameIntervalControl",msg:"KeyFrameIntervalControl error:" + e.message + "," + e.name});  
				return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
			}
		},
		
		/*
		*	函数名	：QualityModeControl
		*	函数功能	：编码质量模式控制







































		*	备注		：无
		*	作者		：huzw
		*	时间		：2011.04.21  
		*	返回值	：	(get)成功返回字符串['VBR','CBR','ABR'],(set)成功0,失败NrcapError
		*	参数说明	：	6个参数  
		*			string connectId	视频窗口对象
		*			string puid		设备PUID
		*			string idx		视频头索引. 
		*			string action 	动作["get":获取编码质量模式,"set":设置编码质量模式]
		*			sting 	streamType  流类型[Nrcap2.Enum.NrcapStreamType对象]
		*			string	value	设置编码质量模式的值[action = "set"使用]
		*/ 
		QualityModeControl:function(connectId,puid,idx,action,streamType,value){
			try
			{
				if(!connectId || !Nrcap2.Connections.get(connectId))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.QualityModeControl",msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				}
				if(!puid || !Nrcap2.puidRex.test(puid))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.QualityModeControl",msg:"IV puid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(idx == null || typeof idx == "undefined" || !Nrcap2.intRex.test(idx))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.QualityModeControl",msg:"IV idx error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
				} 
				
				if(typeof action == "undefined" || (action != "get" && action != "set"))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.QualityModeControl",msg:"param action error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
				}
				else
				{
					if(!streamType || typeof streamType == "undefined")
					{
						Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.QualityModeControl",msg:"param streamType error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
					}
					
					if(action == "set")
					{
						if(value == null || typeof value =="undefined")
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.QualityModeControl",msg:"param value error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
						} 
					}
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var rv = -1;
				switch(action)
				{
					case 'get':
						rv = conn.nc.GetConfig(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,streamType,"CFG_IV_QualityControlMode");
						
						var rvstr = rv.indexOf("#");
						if(rvstr > -1)
						{
							if(parseInt(rv.split("#")[0]) == 0x0000) 
							{
								rv = rv.split("#")[1]; 
							}
							else
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.QualityModeControl",msg:"get QualityMode error:code = " + rv});  
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.QualityModeControl",msg:"get QualityMode error:code = " + rv});  
						}
						
						break;
					case 'set':
						rv = conn.nc.SetConfig(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,streamType,"CFG_IV_QualityControlMode",value);
						if(parseInt(rv) == 0)
						{
							rv = Nrcap2.NrcapError.NRCAP_SUCCESS;
						}
						else
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.QualityModeControl",msg:"set QualityMode error:code = " + rv});  
							rv = -1;
						}
						break;
					default:
						break;
				}  
				return rv;
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.QualityModeControl",msg:"QualityModeControl error:" + e.message + "," + e.name});  
				return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
			}
			
		},
		
		/*
		*	函数名	：BitRateControl
		*	函数功能	：目标码率控制.
		*	备注		：无
		*	作者		：huzw
		*	时间		：2011.04.21  
		*	返回值	：	(get)成功返回0-10000[kbps],(set)成功0,失败NrcapError
		*	参数说明	：	6个参数.
		*			string connectId	视频窗口对象.
		*			string puid		设备PUID
		*			string idx		视频头索引 
		*			string action 	动作["get":获取目标码率,"set":设置目标码率]
		*			sting 	streamType  流类型[Nrcap2.Enum.NrcapStreamType对象]
		*			unit	value	设置目标码率的值[action = "set"使用]
		*/ 
		BitRateControl:function(connectId,puid,idx,action,streamType,value){
			try
			{
				if(!connectId || !Nrcap2.Connections.get(connectId))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.BitRateControl",msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				}
				if(!puid || !Nrcap2.puidRex.test(puid))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.BitRateControl",msg:"IV puid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(idx == null || typeof idx == "undefined" || !Nrcap2.intRex.test(idx))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.BitRateControl",msg:"IV idx error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
				} 
				
				if(typeof action == "undefined" || (action != "get" && action != "set"))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.BitRateControl",msg:"param action error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
				}
				else
				{
					if(!streamType || typeof streamType == "undefined")
					{
						Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.BitRateControl",msg:"param streamType error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
					}
					
					if(action == "set")
					{
						if(value == null || typeof value =="undefined" || !Nrcap2.intRex.test(value))
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.BitRateControl",msg:"param value error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
						}
						else
						{
							value = parseInt(value);
							if(value < 0 || value > 10000)
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.BitRateControl",msg:"param value beyond range error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGVALUELENGTH_BYONDRANGE_ERROR;
							} 
						}
					}
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var rv = -1;
				switch(action)
				{
					case 'get':
						rv = conn.nc.GetConfig(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,streamType,"CFG_IV_BitRate");
						
						var rvstr = rv.indexOf("#");
						if(rvstr > -1)
						{
							if(parseInt(rv.split("#")[0]) == 0x0000) 
							{
								rv = parseInt(rv.split("#")[1]);
								if(rv < 0 || rv > 10000)
								{
									rv = -1;
								}  
							}
							else
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.BitRateControl",msg:"get BitRate error:code = " + rv});  
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.BitRateControl",msg:"get BitRate error:code = " + rv});  
						}
						
						break;
					case 'set':
						rv = conn.nc.SetConfig(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,streamType,"CFG_IV_BitRate",value);
						if(parseInt(rv) == 0)
						{
							rv = Nrcap2.NrcapError.NRCAP_SUCCESS;
						}
						else
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.BitRateControl",msg:"set BitRate error:code = " + rv});  
							rv = -1;
						}
						break;
					default:
						break;
				}  
				return rv;
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.BitRateControl",msg:"BitRateControl error:" + e.message + "," + e.name});  
				return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
			}
			
		},
		
		/*
		*	函数名	：FrameRateControl
		*	函数功能	：目标帧率控制 
		*	备注		：无
		*	作者		：huzw
		*	时间		：2011.04.21  
		*	返回值	：	失败NrcapError
		*	参数说明	：	6个参数  
		*			string connectId	视频窗口对象
		*			string puid		设备PUID
		*			string idx		视频头索引 
		*			string action 	动作["get":获取目标帧率,"set":设置目标帧率]
		*			sting 	streamType  流类型[Nrcap2.Enum.NrcapStreamType对象]
		*			unit	value	设置目标帧率的值[action = "set"使用]
		*/ 
		FrameRateControl:function(connectId,puid,idx,action,streamType,value){
			try
			{
				if(!connectId || !Nrcap2.Connections.get(connectId))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.FrameRateControl",msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				}
				if(!puid || !Nrcap2.puidRex.test(puid))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.FrameRateControl",msg:"IV puid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(idx == null || typeof idx == "undefined" || !Nrcap2.intRex.test(idx))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.FrameRateControl",msg:"IV idx error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
				} 
				
				if(typeof action == "undefined" || (action != "get" && action != "set"))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.FrameRateControl",msg:"param action error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
				}
				else
				{
					if(!streamType || typeof streamType == "undefined")
					{
						Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.FrameRateControl",msg:"param streamType error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
					}
					
					if(action == "set")
					{
						
						if(!value || typeof value !="object" || typeof value.name == "undefined" || value.name.strip() == "" || typeof value.value == "undefined" || value.value.strip() == "" )
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.FrameRateControl",msg:"param value error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
						} 
						else
						{
							var valueStr = "<Param " + value.name +"=\""+ value.value + "\" />"; // alert(valueStr);  
						}
							 
					}
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId;
				
				switch(action)
				{
					case 'get':
						var rvstr = conn.nc.GetConfigEx(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,streamType,"CFG_IV_FrameRate");
						// alert(rvstr);
						var rvSplitIndex = rvstr.indexOf("#");
						if(rvSplitIndex > -1)
						{
							rvstr = rvstr.substr(rvSplitIndex +1);
							if(rvstr.length > 0)
							{
								var xmlObj = new XML.ObjTree();
								if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
								{
									Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.FrameRateControl",msg:"XML object error!"});
									return false;
								}
								
								var jsonResource = xmlObj.parseXML(rvstr);
								if(jsonResource && jsonResource.Param)
								{ 
									var name = "", value = "";
									if(typeof jsonResource.Param.FramePerSec != "undefined")
									{
										name = "FramePerSec";
										value = jsonResource.Param.FramePerSec;	
									}
									else if(typeof jsonResource.Param.SecPerFrame != "undefined")
									{
										name = "SecPerFrame";
										value = jsonResource.Param.SecPerFrame;	
									}
									 
									return {"name":name,"value":value};
								}
								else
								{
									Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.FrameRateControl",msg:"get FrameRate param error!"});  
									return false;
								}
							}  
						}
						else
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.FrameRateControl",msg:"get FrameRate error:code = " + rv});  
							return false;
						}
						
						break;
					case 'set':
						var rv = -1;    
						rv = conn.nc.SetConfigEx(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,streamType,"CFG_IV_FrameRate",valueStr);	 // alert(rv);
						/**other method***
						//var requestParamStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\" ><Cmd Type=\"SET\" Prio=\"1\" EPID=\""+epId+"\" ><DstRes Type=\"IV\" Idx=\""+idx+"\" OptID=\"CFG_IV_FrameRate\" StreamType=\""+streamType+"\" > " + valueStr + "</DstRes></Cmd></Msg>";
						
						//Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.FrameRateControl",msg:"request = " + requestParamStr}); // alert(requestParamStr);
						
						//var rvstr = conn.nc.SendRequest(151,puid,requestParamStr); // alert(rvstr); 

						//Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.FrameRateControl",msg:"response = " + rvstr}); return 0;*/
						
						if(parseInt(rv) == 0)
						{
							rv = Nrcap2.NrcapError.NRCAP_SUCCESS;
						}
						else
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.FrameRateControl",msg:"set FrameRate error:code = " + rv});  
							rv = -1;
						}
						return rv;
						break;
					default:
						return false;
						break;
				}   
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.FrameRateControl",msg:"FrameRateControl error:" + e.message + "," + e.name});  
				return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
			}
			
		},
		
		/*
		*	函数名	：ImageDefinitionControl
		*	函数功能	：图片清晰度控制
		*	备注		：无
		*	作者		：huzw
		*	时间		：2011.04.21  
		*	返回值	：	(get)成功返回0-100[100最清晰,0最模糊],(set)成功0,失败NrcapError
		*	参数说明	：	6个参数  
		*			string connectId	视频窗口对象
		*			string puid		设备PUID
		*			string idx		视频头索引 
		*			string action 	动作["get":获取图片清晰度,"set":设置图片清晰度]
		*			sting 	streamType  流类型[Nrcap2.Enum.NrcapStreamType对象]
		*			unit	value	设置图片清晰度的值[action = "set"使用]
		*/ 
		ImageDefinitionControl:function(connectId,puid,idx,action,streamType,value){
			try
			{
				if(!connectId || !Nrcap2.Connections.get(connectId))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.ImageDefinitionControl",msg:"connectId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONNECTIONID_FAILED;
				}
				if(!puid || !Nrcap2.puidRex.test(puid))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.ImageDefinitionControl",msg:"IV puid error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_PUID_FAILED;
				}
				if(idx == null || typeof idx == "undefined" || !Nrcap2.intRex.test(idx))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.ImageDefinitionControl",msg:"IV idx error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
				} 
				
				if(typeof action == "undefined" || (action != "get" && action != "set"))
				{
					Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.ImageDefinitionControl",msg:"param action error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
				}
				else
				{
					if(!streamType || typeof streamType == "undefined")
					{
						Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.ImageDefinitionControl",msg:"param streamType error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
					}
					
					if(action == "set")
					{
						if(value == null || typeof value =="undefined" || !Nrcap2.intRex.test(value))
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.ImageDefinitionControl",msg:"param value error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;
						}
						else
						{
							value = parseInt(value);
							if(value < 0 || value > 100)
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.ImageDefinitionControl",msg:"param value beyond range error!"}); 
								return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGVALUELENGTH_BYONDRANGE_ERROR;
							} 
						}
					}
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var rv = -1;
				switch(action)
				{
					case 'get':
						rv = conn.nc.GetConfig(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,streamType,"CFG_IV_ImageDefinition");
						
						var rvstr = rv.indexOf("#");
						if(rvstr > -1)
						{
							if(parseInt(rv.split("#")[0]) == 0x0000) 
							{
								rv = parseInt(rv.split("#")[1]);
								if(rv < 0 || rv > 100)
								{
									rv = -1;
								}  
							}
							else
							{
								Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.ImageDefinitionControl",msg:"get ImageDefinition error:code = " + rv});  
							}
						}
						else
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.ImageDefinitionControl",msg:"get ImageDefinition error:code = " + rv});  
						}
						
						break;
					case 'set':
						// alert(puid+","+Nrcap2.Enum.PuResourceType.VideoIn+","+idx+","+streamType+","+value); //return 0;
						rv = conn.nc.SetConfig(151,puid,Nrcap2.Enum.PuResourceType.VideoIn,idx,streamType,"CFG_IV_ImageDefinition",value);
						
						if(parseInt(rv) == 0)
						{
							rv = Nrcap2.NrcapError.NRCAP_SUCCESS;
						}
						else
						{
							Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.ImageDefinitionControl",msg:"set ImageDefinition error:code = " + rv});  
							rv = -1;
						}
						break;
					default:
						break;
				}  
				return rv;
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:"Nrcap2.EncodeParam.ImageDefinitionControl",msg:"ImageDefinitionControl error:" + e.message + "," + e.name});  
				return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
			}
			
		},
		
		/* 连贯性和清晰度优先系数 */
		ABRPriorityControl:function(connectId,puid,idx,action,streamType,value){
			return Nrcap2.ShareConfigFunctions.VideoIn.SimpleControl(connectId,puid,idx,"CFG_IV_ABRPriority",action,streamType,'signal',value);	
		},
		
		/* 最低帧率 */
		FloorFrameRateControl:function(connectId,puid,idx,action,streamType,param){
			return Nrcap2.ShareConfigFunctions.VideoIn.ComplexControl(connectId,puid,idx,"CFG_IV_FloorFrameRate",action,streamType,'frame',param);			
		}, 
		
		end:true
	},
	
	/*
	*	函数名	：DeviceRecordConfig
	*	函数功能	：前端存储配置对象 
	*	备注		：无
	*	作者		：huzw
	*	时间		：2011.05.12  
	*/ 
	DeviceRecordConfig:{
		
		/* 定时录像时间表 */
		RecordScheduleControl:function(connectId,puid,idx,action,value){ 
			/**
			* value = "0xFF00F0F0FA0BA0..."; The length is (84 + 1) bytes
			* Hex -> Binary: parseInt("0xFF00...",16).toString(2)
			* Binary -> Hex: "0x" + parseInt("1111111100000000...",2).toString(16).toUpperCase()
			*/
			var streamType = "", model = "other";
			return Nrcap2.ShareConfigFunctions.VideoIn.SimpleControl(connectId,puid,idx,"CFG_IV_RecordSchedule",action,streamType,model,value);	  
		},		
		
		/* 是否录制对应音频 */
		RecordAudioControl:function(connectId,puid,idx,action,value){  
			var streamType = "", model = "signal";
			return Nrcap2.ShareConfigFunctions.VideoIn.SimpleControl(connectId,puid,idx,"CFG_IV_RecordAudio",action,streamType,model,value);	  
		},	
		
		/* 定时拍照时间表 */
		SnapScheduleControl:function(connectId,puid,idx,action,value){ 
			/**
			* value = "0xFF00F0F0FA0BA0..."; The length is (84 + 1) bytes
			* Hex -> Binary: parseInt("0xFF00...",16).toString(2)
			* Binary -> Hex: "0x" + parseInt("1111111100000000...",2).toString(16).toUpperCase()
			*/
			var streamType = "", model = "other";
			return Nrcap2.ShareConfigFunctions.VideoIn.SimpleControl(connectId,puid,idx,"CFG_IV_SnapSchedule",action,streamType,model,value);	  
		},	
		
		end:true
	},
	
	
	/*
	*	函数名	：Config
	*	函数功能	：配置对象 
	*	备注		：实现简单和复杂配置，以后将完善
	*	作者		：huzw
	*	时间		：2011.05.17  
	*/ 
	Config:{
		GetSimple:function(connectId, puid, resType, resIdx, configId, streamType){
			try
			{ 
				var fn = "Nrcap2.Config.GetSimple"; 
				var _flag = Nrcap2.ShareParamsCheck(connectId,puid,resIdx,fn); 
				if(_flag != true) return _flag;
				
				if(!resType || typeof resType == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"resType error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;	
				}
				
				if(!configId || typeof configId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"configId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;	
				}
				
				if(streamType == null || typeof streamType == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"streamType error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;	
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId;
				
				if(configId.toLowerCase().search("_st_") != -1)
				{
					 resType != Nrcap2.Enum.PuResourceType.SELF ? resType = Nrcap2.Enum.PuResourceType.SELF : "";	 
				}
				else if(configId.toLowerCase().search("_iv_") != -1)
				{
					resType != Nrcap2.Enum.PuResourceType.VideoIn ? resType = Nrcap2.Enum.PuResourceType.VideoIn : "";		
				}
				else if(configId.toLowerCase().search("_ptz_") != -1)
				{
					resType != Nrcap2.Enum.PuResourceType.PTZ ? resType = Nrcap2.Enum.PuResourceType.PTZ : "";		
				}
				else if(configId.toLowerCase().search("_ia_") != -1)
				{
					resType != Nrcap2.Enum.PuResourceType.AudioIn ? resType = Nrcap2.Enum.PuResourceType.AudioIn : "";		
				}
				else if(configId.toLowerCase().search("_oa_") != -1)
				{
					resType != Nrcap2.Enum.PuResourceType.AudioOut ? resType = Nrcap2.Enum.PuResourceType.AudioOut : "";		
				}
				
				switch(resType)
				{
					case Nrcap2.Enum.PuResourceType.SELF:
					case Nrcap2.Enum.PuResourceType.AudioOut:
						resIdx = "0";
						break;
					default:
						break;
				}
				
				Nrcap2.Debug.Write({fn:fn,msg:"puid:"+puid+",resType:"+resType+",resIdx:"+resIdx+",configId:"+configId});
				
				var rvstr = conn.nc.GetConfig(151, puid, resType, resIdx, streamType, configId); // alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"get simple rvstr:" + rvstr}); // return;
				
				var rvSplitIndex = rvstr.indexOf("#"), rv = -1;
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{ 
						rv = rvstr.toString();
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"get simple rvstr length error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;	
					} 
				}
				else
				{
					Nrcap2.Debug.Write({fn:fn,msg:"get simple rvstr error! code = " + rvstr.toString().split("#")[0]});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;	
				} 
				
				return rv;
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! code = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
			}
		},
		
		SetSimple:function(connectId, puid, resType, resIdx, configId, streamType, value){
			try
			{
				var fn = "Nrcap2.Config.SetSimple";
				var _flag = Nrcap2.ShareParamsCheck(connectId,puid,resIdx,fn); 
				if(_flag != true) return _flag;
				
				if(!resType || typeof resType == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"resType error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;	
				}
				
				if(!configId || typeof configId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"configId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;	
				}
				
				if(streamType == null || typeof streamType == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"streamType error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;	
				}
				
				if(value == null || typeof value == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"value error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;	
				}
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId;
				
				if(configId.toLowerCase().search("_st_") != -1)
				{
					 resType != Nrcap2.Enum.PuResourceType.SELF ? resType = Nrcap2.Enum.PuResourceType.SELF : "";	 
				}
				else if(configId.toLowerCase().search("_iv_") != -1)
				{
					resType != Nrcap2.Enum.PuResourceType.VideoIn ? resType = Nrcap2.Enum.PuResourceType.VideoIn : "";		
				}
				else if(configId.toLowerCase().search("_ptz_") != -1)
				{
					resType != Nrcap2.Enum.PuResourceType.PTZ ? resType = Nrcap2.Enum.PuResourceType.PTZ : "";		
				}
				else if(configId.toLowerCase().search("_ia_") != -1)
				{
					resType != Nrcap2.Enum.PuResourceType.AudioIn ? resType = Nrcap2.Enum.PuResourceType.AudioIn : "";		
				}
				else if(configId.toLowerCase().search("_oa_") != -1)
				{
					resType != Nrcap2.Enum.PuResourceType.AudioOut ? resType = Nrcap2.Enum.PuResourceType.AudioOut : "";		
				}
				
				switch(resType)
				{
					case Nrcap2.Enum.PuResourceType.SELF:
					case Nrcap2.Enum.PuResourceType.AudioOut:
						resIdx = "0";
						break;
					default:
						break;
				}
				
				Nrcap2.Debug.Write({fn:fn,msg:"puid:"+puid+",resType:"+resType+",resIdx:"+resIdx+",configId:"+configId});
				
				var rvstr = conn.nc.SetConfig(151, puid, resType, resIdx, streamType, configId, value);  // alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"set simple rvstr:" + rvstr}); //  return; 
				
				if(parseInt(rvstr) != 0)
				{ 
					Nrcap2.Debug.Write({fn:fn,msg:"set simple rvstr error! code = " + parseInt(rvstr).toString()});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;	
				} 
				
				return Nrcap2.NrcapError.NRCAP_SUCCESS;  
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! code = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
			}
		},
		
		
		GetComplex:function(connectId, puid, resType, resIdx, configId, streamType){
			try
			{ 
				var fn = "Nrcap2.Config.GetComplex";
				var _flag = Nrcap2.ShareParamsCheck(connectId,puid,resIdx,fn); 
				if(_flag != true) return _flag;
				 
				if(!resType || typeof resType == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"resType error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;	
				}
				 
				if(!configId || typeof configId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"configId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;	
				}
				 
				if(streamType == null || typeof streamType == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"streamType error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;	
				}
				 
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId;
				
				if(configId.toLowerCase().search("_st_") != -1)
				{
					 resType != Nrcap2.Enum.PuResourceType.SELF ? resType = Nrcap2.Enum.PuResourceType.SELF : "";
				}
				else if(configId.toLowerCase().search("_iv_") != -1)
				{
					resType != Nrcap2.Enum.PuResourceType.VideoIn ? resType = Nrcap2.Enum.PuResourceType.VideoIn : "";		
				}
				else if(configId.toLowerCase().search("_ptz_") != -1)
				{
					resType != Nrcap2.Enum.PuResourceType.PTZ ? resType = Nrcap2.Enum.PuResourceType.PTZ : "";		
				}
				else if(configId.toLowerCase().search("_ia_") != -1)
				{
					resType != Nrcap2.Enum.PuResourceType.AudioIn ? resType = Nrcap2.Enum.PuResourceType.AudioIn : "";		
				}
				else if(configId.toLowerCase().search("_oa_") != -1)
				{
					resType != Nrcap2.Enum.PuResourceType.AudioOut ? resType = Nrcap2.Enum.PuResourceType.AudioOut : "";		
				}
				 
				switch(resType)
				{
					case Nrcap2.Enum.PuResourceType.SELF:
					case Nrcap2.Enum.PuResourceType.AudioOut:
						resIdx = "0";
						break;
					default:
						break;
				}
				
				Nrcap2.Debug.Write({fn:fn,msg:"puid:"+puid+",resType:"+resType+",resIdx:"+resIdx+",configId:"+configId});
				 
				var rvstr = conn.nc.GetConfigEx(151, puid, resType, resIdx, streamType, configId); // alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"get complex rvstr:" + rvstr});
				
				var rvSplitIndex = rvstr.indexOf("#");
				
				if(rvSplitIndex > -1)
				{
					rvstr = rvstr.substr(rvSplitIndex + 1);
					
					if(rvstr.length > 0)
					{
						var xmlObj = new XML.ObjTree();
						if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
						{
							Nrcap2.Debug.Write({fn:fn,msg:"XML ObjTree error!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
						}
						
						var jsonResource = xmlObj.parseXML(rvstr); // alert(Object.toJSON(jsonResource));
						
						if(jsonResource && jsonResource.Param)
						{
							var objRes = new Object();
							var errorFlag = false;
							
							var _TurnToSets = function(_SelectValues){
								if(typeof _SelectValues != "undefined")
								{
									var _Sets = new Array(); 
									
									if(_SelectValues.constructor == Array)
									{
										_Sets = _SelectValues.uniq();
									}
									else
									{
										_Sets.push(_SelectValues);
									}  
									//alert(Object.toJSON(_Sets));
									objRes = _Sets;
								}
								else
								{
									errorFlag = true;
								}
							};
										
							// switch this
							switch(configId)
							{
								case 'CFG_IV_SupportedPreprocessorSets': /* 支持的预处理方式 */
									var _Preprocessors = jsonResource.Param.Preprocessor;
									_TurnToSets(_Preprocessors);  
									break;
									
								case 'CFG_IV_SupportedEncoderSets': /* 支持的编码算法 */
								case 'CFG_IA_SupportedEncoderSets':
								case 'CFG_OA_SupportedEncoderSets':
									var _Encoders = jsonResource.Param.Encoder;
									_TurnToSets(_Encoders);  
									break;
									
								case 'CFG_IV_SupportedStreamTypeSets': /* 支持的流类型 */
								case 'CFG_IA_SupportedStreamTypeSets':
									var _StreamTypes = jsonResource.Param.StreamType;
									_TurnToSets(_StreamTypes);  
									break;
									
								case 'CFG_IV_SupportedResolutionSets': /* 支持的编码分辨率 */
								case 'CFG_IV_SupportedSnapResolutionSets': /* 支持的抓拍分辨率 */
									var _Resolutions = jsonResource.Param.Resolution;
									_TurnToSets(_Resolutions);  
									break;
									
								case 'CFG_IV_SupportedQualityControlModeSets': /* 支持的编码质量控制模式 */ 
								case 'CFG_IA_SupportedInputModeSets': /* 支持的音频输入模式 */
								case 'CFG_OA_SupportedInputModeSets': 
								case 'CFG_IV_SupportedAnalogFormatModeSets': /* 支持的视频制式选择方式 */
								case 'CFG_IV_SupportedGPSAddModeSets': /* 支持的GPS信息叠加模式 */
								case 'CFG_IDL_SupportedAlertInModeSets': /* 支持的报警触发模式 */
									var _Modes = jsonResource.Param.Mode; // alert(Object.toJSON(_Modes));
									_TurnToSets(_Modes);  
									break;
									
								case 'CFG_IV_SupportedAnalogFormatSets': /* 支持的视频制式 */
									var _Formats = jsonResource.Param.Format;
									_TurnToSets(_Formats);  
									break;
									
								case 'CFG_IV_SupportedMobileDetectTypeSets': /* 支持的侦测方式 */
									var _Types = jsonResource.Param.Type;
									_TurnToSets(_Types);  
									break; 
									
								case 'CFG_IA_SupportedSampleRateSets': /* 支持的音频输入采样率 */
								case 'CFG_OA_SupportedOutputSampleRateSets': /* 支持的音频输出采样率 */
								case 'CFG_OA_SupportedInputSampleRateSets':/* 支持的音频输入采样率 */
									var _SampleRates = jsonResource.Param.SampleRate;
									_TurnToSets(_SampleRates);  
									break;  
									
								case 'CFG_OA_SupportedDecoderSets': /* 支持的解码算法 */
									var _Decoders = jsonResource.Param.Decoder;
									_TurnToSets(_Decoders);  
									break;  
									
								case 'CFG_SP_SupportedBaudRateSets': /* 支持的波特率 */
									var _Rates = jsonResource.Param.Rate;
									_TurnToSets(_Rates);  
									break;
									
								case 'CFG_SP_SupportedDataBitsSets': /* 支持的数据位 */
									var _DataBits= jsonResource.Param.DataBits;
									_TurnToSets(_DataBits);  
									break;
									
								case 'CFG_SP_SupportedParitySets': /* 支持的校验位 */
									var _Paritys= jsonResource.Param.Parity;
									_TurnToSets(_Paritys);  
									break;
									
								case 'CFG_SP_SupportedStopBitsSets': /* 支持的停止位 */
									var _StopBits= jsonResource.Param.StopBits;
									_TurnToSets(_StopBits);  
									break;
								
								case 'CFG_COMMONRES_Desc': 
									var res = jsonResource.Param.Res;
									if(typeof res == "object")
									{
										objRes = new Nrcap2.Struct.CommonResDescriptionStruct(puid,res.ResType,res.ResIdx,res.Name,res.Desc,res.Enable);
									} else { errorFlag = true; }  
									break;
									
								case 'CFG_ST_ResDescSets': 
									if(typeof jsonResource.Param.Station != "undefined" && jsonResource.Param.Station.Res)
									{
										var res = jsonResource.Param.Station.Res;
										objRes = new Array();
										if(typeof res == "object")
										{
											var st = jsonResource.Param.Station;
											objRes.push(new Nrcap2.Struct.CommonResDescriptionStruct(puid, resType, resIdx, st.Name, st.Desc));
											
											if(res.constructor == Array)
											{
												res.each
												(
													function(item)
													{
														objRes.push(new Nrcap2.Struct.CommonResDescriptionStruct(puid,item.ResType,item.ResIdx,item.Name,item.Desc,item.Enable));
													}
												);
											}
											else
											{
												objRes.push(new Nrcap2.Struct.CommonResDescriptionStruct(puid,res.ResType,res.ResIdx,res.Name,res.Desc,res.Enable));
											} 
											
										} else { errorFlag = true; }  
									}else { errorFlag = true; }    
									break;
									
								case 'CFG_ST_SupportedEventSets': /* 支持的事件 */
										if(typeof jsonResource.Param.SrcRes != "undefined")
										{
											objRes = new Array();
											
											if(jsonResource.Param.SrcRes.constructor == Array)
											{ 
												jsonResource.Param.SrcRes.each
												(
													function(node)
													{
														objRes.push({'type':node.Type, 'event':node.Event});
													}
												);
											}
											else
											{
												var node = jsonResource.Param.SrcRes;
												objRes.push({'type':node.Type, 'event':node.Event});
											} 
										}else { errorFlag = true; }   
										break;
										
								case 'CFG_ST_SupportedActionSets': /* 支持的动作 */
									var _Actions = jsonResource.Param.Action;
									_TurnToSets(_Actions); 
									break;
									
								case 'CFG_IV_FrameRate':
								case 'CFG_IV_FloorFrameRate':
									if(typeof jsonResource.Param.FramePerSec != "undefined")
									{ 
										objRes = {'name':"FramePerSec",'value':jsonResource.Param.FramePerSec};		
									}
									else if(typeof jsonResource.Param.SecPerFrame != "undefined")
									{
										objRes = {'name':"SecPerFrame",'value':jsonResource.Param.SecPerFrame};	
									}
									else { errorFlag = true; } 
									break;
									
								case 'CFG_IV_TimeAddPosition':
								case 'CFG_IV_LogoAddPosition':
								case 'CFG_IV_TextAddPosition': 
									if(typeof jsonResource.Param == "object") objRes = jsonResource.Param;
									else { errorFlag = true; } 
									break;
								
								case 'CFG_IDL_SupportedWorkModeSets':
									var _WorkModes = jsonResource.Param.WorkMode;
									_TurnToSets(_WorkModes); 
									break;
								
								default:
									var _Values = jsonResource.Param.Value;
									_TurnToSets(_Values);  
									break; 
							}
							
							if(errorFlag)
							{
								Nrcap2.Debug.Write({fn:fn,msg:"return value error!"});
								return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGVALUELENGTH_BYONDRANGE_ERROR;
							}
							
							return objRes;
						}
						else
						{
							Nrcap2.Debug.Write({fn:fn,msg:"return error!xml string no Param tag!"});
							return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
						} 
					}
					else
					{
						Nrcap2.Debug.Write({fn:fn,msg:"return error!xml string(null+) error!"});
						return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
					}
				}
				else
				{	
					Nrcap2.Debug.Write({fn:fn,msg:"return error!xml string no char '#'!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
				}				
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! code = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
			}
		},
		
		SetComplex:function(connectId, puid, resType, resIdx, configId, streamType, param){
			try
			{
				var fn = "Nrcap2.Config.SetComplex";
				var _flag = Nrcap2.ShareParamsCheck(connectId,puid,resIdx,fn); 
				if(_flag != true) return _flag;
				
				if(!resType || typeof resType == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"resType error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;	
				}
				
				if(!configId || typeof configId == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"configId error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;	
				}
				
				if(streamType == null || typeof streamType == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"streamType error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;	
				}
				
				if(param == null || typeof param == "undefined")
				{
					Nrcap2.Debug.Write({fn:fn,msg:"param error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;	
				} 
				
				var conn = Nrcap2.Connections.get(connectId);
				var epId = conn.connParam.epId;
				
				if(configId.toLowerCase().search("_st_") != -1)
				{
					 resType != Nrcap2.Enum.PuResourceType.SELF ? resType = Nrcap2.Enum.PuResourceType.SELF : "";
				}
				else if(configId.toLowerCase().search("_iv_") != -1)
				{
					resType != Nrcap2.Enum.PuResourceType.VideoIn ? resType = Nrcap2.Enum.PuResourceType.VideoIn : "";		
				}
				else if(configId.toLowerCase().search("_ptz_") != -1)
				{
					resType != Nrcap2.Enum.PuResourceType.PTZ ? resType = Nrcap2.Enum.PuResourceType.PTZ : "";		
				}
				else if(configId.toLowerCase().search("_ia_") != -1)
				{
					resType != Nrcap2.Enum.PuResourceType.AudioIn ? resType = Nrcap2.Enum.PuResourceType.AudioIn : "";		
				}
				else if(configId.toLowerCase().search("_oa_") != -1)
				{
					resType != Nrcap2.Enum.PuResourceType.AudioOut ? resType = Nrcap2.Enum.PuResourceType.AudioOut : "";		
				}
				 
				switch(resType)
				{
					case Nrcap2.Enum.PuResourceType.SELF:
					case Nrcap2.Enum.PuResourceType.AudioOut:
						resIdx = "0";
						break;
					default:
						break;
				}
				
				Nrcap2.Debug.Write({fn:fn,msg:typeof param == "object" ? $H(param).inspect() : param});
				
				var valueXmlStr = "<Param ", errorFlag = false;
				
				switch(configId)
				{ 
					case 'CFG_COMMONRES_Desc':
						if(typeof param == "object")
						{
							valueXmlStr += "><Res ResType=\""+param.resType+"\" ResIdx=\""+param.resIdx+"\" Name=\""+param.name+"\" Desc=\""+param.description+"\" Enable=\""+param.enable+"\"></Res>";   
						}
						else { errorFlag = true; } 
						break;
						
					case 'CFG_IV_TimeAddPosition':
					case 'CFG_IV_LogoAddPosition':
					case 'CFG_IV_TextAddPosition': 
						if(typeof param == "object")
						{
							valueXmlStr += " XPos=\""+param.XPos+"\" YPos=\""+param.YPos+"\" >";   
						}
						else { errorFlag = true; } 
						break;
					
					case 'CFG_IV_FrameRate':
					case 'CFG_IV_FloorFrameRate':
						/*if(typeof jsonResource.Param.FramePerSec != "undefined")
						{ 
							objRes = {'name':"FramePerSec",'value':jsonResource.Param.FramePerSec};		
						}
						else if(typeof jsonResource.Param.SecPerFrame != "undefined")
						{
							objRes = {'name':"SecPerFrame",'value':jsonResource.Param.FramePerSec};	

						}*/
						if(typeof param == "object")
						{
							valueXmlStr += " "+param.name+"=\""+param.value+"\" >";  
						}
						else { errorFlag = true; } 
						break;
					default:
						valueXmlStr += " Value=\""+param+"\">";
						break;	 
				}
				
				valueXmlStr += "</Param>";
				
				if(errorFlag == true)
				{
					Nrcap2.Debug.Write({fn:fn,msg:"valueXmlStr error!"});
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGPARAM_ERROR;	
				}
				
				//alert(valueXmlStr);
				//return;
				
				Nrcap2.Debug.Write({fn:fn,msg:"puid:" + puid + ",resType:" + resType + ",resIdx:" + resIdx + ",streamType:" + streamType +",configId:" + configId + ",valueXmlStr:" + valueXmlStr});
				
				var rvstr = conn.nc.SetConfigEx(151, puid, resType, resIdx, streamType, configId, valueXmlStr); //alert(rvstr);
				
				Nrcap2.Debug.Write({fn:fn,msg:"response:" + rvstr});
				
				if(parseInt(rvstr) != 0)
				{ 
					return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
				}
				
				return Nrcap2.NrcapError.NRCAP_SUCCESS;
			}
			catch(e)
			{
				Nrcap2.Debug.Write({fn:fn,msg:"Exception error! code = " + e.message + ":" + e.name});
				return Nrcap2.NrcapError.NRCAP_ERROR_CONFIGCONTROL_FAILED;
			}
		},
		
		end:true		
	},
	 
	/*
	*	函数名	：Control
	*	函数功能	：控制对象 
	*	备注		：实现简单和复杂控制，以后将完善
	*	作者		：huzw
	*	时间		：2011.06.27  
	*/ 
	Control:{
	    CommonGet:function(connectId, puid, resType, resIdx, controlID, param, streamType)
	    {
	        try
	        { 
	            var fn = "Nrcap2.Control.CommonGet";
			    var _flag = Nrcap2.ShareParamsCheck(connectId,puid,resIdx,fn); 
			    if(_flag != true) return _flag;
    			
			    if(!resType || typeof resType == "undefined")
			    {
				    Nrcap2.Debug.Write({fn:fn,msg:"resType error!"});
				    return false;	
			    }
    			
			    if(!controlID || typeof controlID == "undefined")
			    {
				    Nrcap2.Debug.Write({fn:fn,msg:"configId error!"});
				    return false;	
			    }
    			
			    if(streamType == null || typeof streamType == "undefined")
			    {
				    Nrcap2.Debug.Write({fn:fn,msg:"streamType error!"}); 	
			    }
    			
			    if(param == null || typeof param == "undefined")
			    {
				    Nrcap2.Debug.Write({fn:fn,msg:"param error!"}); 
				    return false;
			    } 
    			
			    var conn = Nrcap2.Connections.get(connectId);
			    var epId = conn.connParam.epId;
    			
			    //发送控制命令	send control mission		 
  			    var requestParamStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\""+resType+"\" Idx=\""+resIdx+"\" OptID=\""+controlID+"\">"+param+"</DstRes></Cmd></Msg>"; 
      			
  			    Nrcap2.Debug.Write({fn:fn,msg:"Request:" + requestParamStr});  
    			 
       		    var rvstr = conn.nc.SendRequest(151,puid,requestParamStr); // alert(rvstr);
           		
		        Nrcap2.Debug.Write({fn:fn,msg:"Response:" + rvstr});
    			
    			var rvSplitIndex = rvstr.indexOf("#");
    			
			    if(rvSplitIndex > -1)
			    {
				    rvstr = rvstr.substr(rvSplitIndex + 1);
    				
				    if(rvstr.length > 0)
				    {
					    var xmlObj = new XML.ObjTree();
					    if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
					    {
						    Nrcap2.Debug.Write({fn:fn,msg:"XML ObjTree error!"});
						    return false;
					    }
    					
					    var jsonResource = xmlObj.parseXML(rvstr); //  alert(Object.toJSON(jsonResource));
    					
    					if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes && jsonResource.Msg.Cmd.DstRes.OptID == controlID)
    					{
    					    if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode != "0")
    					    {
    					        Nrcap2.Debug.Write({fn:fn,msg:"ErrorCode error! code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
    					        return {};
    					    }
    					    
    					    if(jsonResource.Msg.Cmd.DstRes.Param && typeof jsonResource.Msg.Cmd.DstRes.Param == "object")
    					    {
    					        return jsonResource.Msg.Cmd.DstRes.Param;
    					    }
    					    else{
    					         Nrcap2.Debug.Write({fn:fn,msg:"Param(null+) error!"});
    					         return {};
    					    }
    					}
    					else
    					{
    					    if(jsonResource.Msg.Cmd.NUErrorCode && jsonResource.Msg.Cmd.NUErrorCode != "0")
    					    {
    					        Nrcap2.Debug.Write({fn:fn,msg:"NUErrorCode error! code = " + jsonResource.Msg.Cmd.NUErrorCode});
    					    }
    					    return {};
    					}
    					
				    }
			    }
    						
			}
	        catch(e)
	        {
	            Nrcap2.Debug.Write({fn:fn,msg:"Exception error! code = " + e.message + ":" + e.name});
				return false;
	        }
	    },
	    
	    CommonSet:function(connectId, puid, resType, resIdx, controlID, param, streamType)
	    {
	        try
	        { 
	            var fn = "Nrcap2.Control.CommonSet";
			    var _flag = Nrcap2.ShareParamsCheck(connectId,puid,resIdx,fn); 
			    if(_flag != true) return _flag;
    			
			    if(!resType || typeof resType == "undefined")
			    {
				    Nrcap2.Debug.Write({fn:fn,msg:"resType error!"});
				    return false;	
			    }
    			
			    if(!controlID || typeof controlID == "undefined")
			    {
				    Nrcap2.Debug.Write({fn:fn,msg:"configId error!"});
				    return false;	
			    }
    			
			    if(streamType == null || typeof streamType == "undefined")
			    {
				    Nrcap2.Debug.Write({fn:fn,msg:"streamType error!"}); 	
			    }
    			
			    if(param == null || typeof param == "undefined")
			    {
				    Nrcap2.Debug.Write({fn:fn,msg:"param error!"}); 
				    return false;
			    } 
    			
			    var conn = Nrcap2.Connections.get(connectId);
			    var epId = conn.connParam.epId;
    			
			    //发送控制命令	send control mission		 
  			    var requestParamStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Msg Name=\"CUCommonMsgReq\" DomainRoad=\"\"><Cmd Type=\"CTL\" Prio=\"1\" EPID=\""+epId+"\"><DstRes Type=\""+resType+"\" Idx=\""+resIdx+"\" OptID=\""+controlID+"\">"+param+"</DstRes></Cmd></Msg>"; 
      			
  			    Nrcap2.Debug.Write({fn:fn,msg:"Request:" + requestParamStr}); // alert(requestParamStr);
    			 
       		    var rvstr = conn.nc.SendRequest(151,puid,requestParamStr); // alert(rvstr);
           		
		        Nrcap2.Debug.Write({fn:fn,msg:"Response:" + rvstr});
    			
    			var rvSplitIndex = rvstr.indexOf("#");
    			
			    if(rvSplitIndex > -1)
			    {
				    rvstr = rvstr.substr(rvSplitIndex + 1);
    				
				    if(rvstr.length > 0)
				    {
					    var xmlObj = new XML.ObjTree();
					    if(typeof xmlObj != "object" || typeof xmlObj.parseXML != "function")
					    {
						    Nrcap2.Debug.Write({fn:fn,msg:"XML ObjTree error!"});
						    return false;
					    }
    					
					    var jsonResource = xmlObj.parseXML(rvstr); //  alert(Object.toJSON(jsonResource));
    					
    					if(jsonResource && jsonResource.Msg && jsonResource.Msg.Name == "CUCommonMsgRsp" && jsonResource.Msg.Cmd && jsonResource.Msg.Cmd.DstRes && jsonResource.Msg.Cmd.DstRes.OptID == controlID)
    					{
    					    if(jsonResource.Msg.Cmd.DstRes.ErrorCode && jsonResource.Msg.Cmd.DstRes.ErrorCode == "0")
    					    {
    					        Nrcap2.Debug.Write({fn:fn,msg:"Set success!"});
    					        return Nrcap2.NrcapError.NRCAP_SUCCESS;
    					    }
    					    else
    					    {
    					        Nrcap2.Debug.Write({fn:fn,msg:"ErrorCode error! code = " + jsonResource.Msg.Cmd.DstRes.ErrorCode});
    					        return false;
    					    }
    					}
    					else
    					{
    					    if(jsonResource.Msg.Cmd.NUErrorCode && jsonResource.Msg.Cmd.NUErrorCode != "0")
    					    {
    					        Nrcap2.Debug.Write({fn:fn,msg:"NUErrorCode error! code = " + jsonResource.Msg.Cmd.NUErrorCode});
    					    }
    					    return false;
    					}
    					
				    }
			    }
    						
			}
	        catch(e)
	        {
	            Nrcap2.Debug.Write({fn:fn,msg:"Exception error! code = " + e.message + ":" + e.name});
				return false;
	        }
	    },
	    
	    end:true
	},
	
    Struct:{
		/*
		*	函数名		：InitParamStruct
		*	函数功能	：初始化Nrcap2对象参数结构
		*	备注		：无
		*	作者		：Lingsen
		*	时间		：2010年11月26日 
		*	返回值		：无
		*	参数说明	：2个参数 
		*  bool debug      是否开始调试状态 
		*  function cb     调试信息输出回调函数
		*/
        InitParamStruct:function(debug,cb)
        {
            this.debug = (typeof debug != "undefined" && debug === true ? true :false);
            this.debugCallback=(typeof cb != "undefined" ? cb :null);
        },
        
         /*
         *	函数名		：ConnParamStruct
         *	函数功能	：初始化连接服务器参数结构 
         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2010年11月26日 
         *	返回值		：无
         *	参数说明	：3个参数 
         *  string path         服务器地址
         *  string username     登录用户名 
         *  string password     登录密码
         */
        ConnParamStruct:function(path,epId,username,password,areaCode,clientType,userCustomData,bFixCUIAddress,callbackFun)
        {
            var re=new RegExp(Nrcap2.Utility.Regexs.domain);
            this.path = (typeof path != "undefined" && re.test(path) ? path : "127.0.0.1:8866");
            this.epId = (typeof epId != "undefined" && epId != null ? epId : "");
            this.username = (typeof username != "undefined" && username != null ? username : "");
            this.password = (typeof password != "undefined" && password != null ? password : "");
            this.areaCode = (typeof areaCode != "undefined" && areaCode != null ? areaCode : "");
            this.clientType = (typeof clientType != "undefined" && clientType != null ? clientType : "");
            this.userCustomData = (typeof userCustomData != "undefined" && userCustomData != null ? userCustomData : "");
			this.bFixCUIAddress = (typeof bFixCUIAddress != "undefined" && bFixCUIAddress != null ? bFixCUIAddress : 0 );
            this.callbackFun = (typeof callbackFun != "undefined" && callbackFun.constructor == Function ? callbackFun : function(){return;});
        },
        
         /*
         *	函数名		：ConnectionStruct
         *	函数功能	：创建一个连接对象 
         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2010年11月26日 
         *	返回值		：无
         *	参数说明	：3个参数 
         *  string connectId         随机生成的connectId
         *  Nrcap2.Struct.ConnParamStruct connParams        连接服务器参数,服务器地址,登录用户名,密码
         *  bool autoConnect 创建连接对象后自动登录 
         */
        ConnectionStruct:function(connectId,connParam,autoConnect)
        {
            this.connectId = connectId;
            var ncObj = Nrcap2.PlugHtml.get("nc").replace("id=\"@id\" name=\"@name\"","id=\"Nrcap2NC_"+connectId+"\" name=\"Nrcap2NC_"+connectId+"\"");
			var dcObj = Nrcap2.PlugHtml.get("dc").replace("id=\"@id\" name=\"@name\"","id=\"Nrcap2DC_"+connectId+"\" name=\"Nrcap2DC_"+connectId+"\"");
            if(!document.getElementById("Nrcap2Box"))
            {
                var objNrcap2Box = document.createElement("DIV");
                objNrcap2Box.setAttribute("id","Nrcap2Box");
                document.getElementsByTagName("body").item(0).appendChild(objNrcap2Box);
            } 
            document.getElementById("Nrcap2Box").style.display = "none"; 
            document.getElementById("Nrcap2Box").innerHTML += ncObj;
			document.getElementById("Nrcap2Box").innerHTML += dcObj;  
            this.nc = document.getElementById("Nrcap2NC_"+connectId);
			this.dc = document.getElementById("Nrcap2DC_"+connectId);
            this.autoConnect = (typeof autoConnect != "undefined" && autoConnect != true ? false : true);
            this.connType = "server";
            this.status = "idel";
            this.connParam = (connParam instanceof Nrcap2.Struct.ConnParamStruct ? connParam : new Nrcap2.Struct.ConnParamStruct());
            this.session = null;
			this.systemName = "";
            this.resource = new Hash();
            this.sortmergeResource = new Hash();
            //this.openIntervalTimer = null;
        },
         
		//*****************************************************************************************
		/*
		*	函数名		:	WindowStruct
		*	函数功能	：	窗口信息结构
		*	备注		： 
		*	作者		：	huzw
		*	时间		：	2011年09月26日 
		*	返回值		：	无 
		*	参数说明	：	8个参数 
		*			string containerId	插件容器id
 		*			string wndName		Wnd对象id
 		*			string nmName		nm对象id
		*			string connectId	与服务器连接id
		*			string type			Nrcap2.Enum.NrcapStreamType对象  
		* 			object customParams 自定义参数 
		*			string style		窗口样式
 		*			string status		窗口各状态值 
 		*/
		WindowStruct: function(containerId, wndName, nmName, connectId, type, customParams, status, style)
		{
			this.containerId = ( document.getElementById(containerId) && typeof containerId != "undefined"? containerId : "" );
			this.wndName = ( document.getElementById(wndName) && typeof wndName != "undefined"? wndName : "" );
			this.nmName = ( document.getElementById(nmName) && typeof nmName != "undefined"? nmName : "" );
			this.wnd = ( document.getElementById(wndName) && typeof wndName != "undefined"? document.getElementById(wndName) : "" );
			this.nm = ( document.getElementById(nmName) && typeof nmName != "undefined"? document.getElementById(nmName) : "" );
			this.connectId = ( typeof connectId != "undefined"? connectId : "" );  
			
			var type = type || Nrcap2.Enum.NrcapStreamType['st_video']; 
			var found = false;
			var streamType = Nrcap2.Enum.NrcapStreamType || {};
			for(var key in streamType)
			{
				if(found) break;
				if(type && streamType[key].indexOf(type) != -1)
				{	
					found = true;  	
				} 
			}
			this.type = ( found == true ? type : streamType['st_video'] );
		 
			this.params = {
				puid: null, /* 设备PUID */
				idx: 0  /* 资源索引 */
			};
			
			this.status = {
				playaudioing: ( typeof status != "undefined" && typeof status.playaudioing!= "undefined" && status.playaudioing ==true ? true : false ),
				recording: ( typeof status != "undefined" && typeof status.recording!= "undefined" && status.recording == true ? true : false )
			};
			
			if(this.type == streamType['st_vod']){
				
				this.params.speed = 0; /* 点播速度 */
				this.params.startTime = 0; /* 点播开始时间 */
				this.params.endTime = 0; /* 点播结束时间 */
				this.params.fileFullPath = null; /* 点播文件全路径 */ 
				this.params.fileTimeLength = 0; /* 点播文件时长 */
				
				this.status.playvoding = ( typeof status != "undefined" && typeof status.playvoding != "undefined" && status.playvoding == true ? true : false ); 
				 
			} else {
				
				this.status.playvideoing = ( typeof status != "undefined" && typeof status.playvideoing!= "undefined" && status.playvideoing ==true ? true : false ); 
				this.status.upaudioing = ( typeof status != "undefined" && typeof status.upaudioing!= "undefined" && status.upaudioing == true ? true : false );  
				this.status.talking = ( typeof status != "undefined" && typeof status.talking!= "undefined" && status.talking == true ? true : false );   
			}
			
			this.customParams = ( customParams && typeof customParams != "undefined" ? customParams : {} ); 
			
			this.style = {
				enableFullScreen: ( typeof style != "undefined" && typeof style.enableFullScreen!= "undefined" && style.enableFullScreen ==true ? true : false ),
				enableMask: ( typeof style != "undefined" && typeof style.enableMask!= "undefined" && style.enableMask == true ? true:false ),
				enableMainPopMenu: ( typeof style != "undefined" && typeof style.enableFullScreen!= "undefined" && style.enableFullScreen ==false ? false : true )
			};
			
			this.SetStyle = function(style){
				if(typeof style.enableFullScreen != "undefined" && style.enableFullScreen == true)
				{
					this.style.enableFullScreen = true;
					this.wnd.enableFullScreen(1);
				}
				else
				{
					this.style.enableFullScreen = false;
					this.wnd.enableFullScreen(0);
				}
				if(typeof style.enableMask != "undefined" && style.enableMask == true)
				{
					this.style.enableMask = true;
					this.wnd.enableMask(1);
				}
				else
				{
					this.style.enableMask = false;
					this.wnd.enableMask(0);
				}
				if(typeof style.enableMainPopMenu != "undefined" && style.enableMainPopMenu == true)
				{
					this.style.enableMainPopMenu = true;
					this.wnd.enableMainPopMenu(1);
				}
				else
				{
					this.style.enableMainPopMenu = false;
					this.wnd.enableMainPopMenu(0);
				}
			}
		},
		
		/*
		*	函数名		:	WindowContainerStruct
		*	函数功能	：	窗口容器信息结构
		*	备注		： 	支持实时视频、录像点播等信息存储
		*	作者		：	huzw
		*	时间		：	2011年09月26日 
		*	返回值		：	无 
		*	参数说明	：	8个参数 
		*			string container	窗口插件的Dom容器对象
 		*			string active		窗口是否被激活




 		*			Nrcap2.Struct.WindowStruct  _window	 窗口对象
		*			Nrcap2.Enum.NrcapStreamType type 	 流类型对象 
						[区别‘REALTIME’(实时视频), ’STORAGE’(录像回放点播) 
		* 			object description  正在播放的视频资源描述  
 		*/
		WindowContainerStruct: function(container, type, active, _window, description){
			this.container = ( container && typeof container != "undefined" ? container : "" );
			this.type = ( type && typeof type != "undefined" ? type : Nrcap2.Enum.NrcapStreamType['st_video']);
			this.active = ( typeof active != "undefined" && active == true? true : false );
			this.window = ( _window && typeof _window != "undefined" ? _window : null );
			this.description = ( typeof description != "undefined" ? description : null );
		},
		
		/*
		*	函数名		:	SCIVDateFileStruct
		*	函数功能	：	平台存储文件信息结构
		*	备注		： 
		*	作者		：	huzw
		*	时间		：	2010年12月16日 
		*	返回值		：	无 
		*	参数说明	：	7个参数 
		*			string fileName		文件名 
 		*			string filePath		文件全路径 
 		*			string fileSize		文件大小
		*			string beginTime	开始时间 
		*			string endTime		结束时间
 		*			string planReason	录像计划原因 
 		*			string csuPuid		平台存储器的PUID 
 		*/
		SCIVDateFileStruct:function(fileName,filePath,fileSize,beginTime,endTime,planReason,csuPuid)
		{
			this.fileName = (typeof fileName != "undefined" ? fileName : "");
			this.filePath = (typeof filePath != "undefined" ? filePath : "");
			this.fileSize = (typeof fileSize != "undefined" ? fileSize : "");
			this.beginTime = (typeof beginTime != "undefined" ? beginTime : "");
			this.endTime = (typeof endTime != "undefined" ? endTime : "");
			this.planReason = (typeof planReason != "undefined" ? planReason : "");
			this.csuPuid = (typeof csuPuid != "undefined" ? csuPuid : "");
		},
		
		/*

		*	函数名		:	VodWholeStatusStruct
		*	函数功能	：	点播状态信息结构 
		*	备注		： 
		*	作者		：	huzw
		*	时间		：	2010年12月17日 
		*	返回值		：	无 
		*	参数说明	：	3个参数 
		*			string currentTime		当前已播放时间(s)
 		*			Uint flag				点播状态信号量[1,2,3,4]
 		*			string description		点播状态具体描述 
 		*/
		VodWholeStatusStruct:function(currentTime,flag,description)
		{
			this.currentTime = (typeof currentTime != "undefined" ?  currentTime : 0);
			this.flag = (typeof flag != "undefined" ?  flag : 0);
			this.description = (typeof description != "undefined" ?  description : "");
		},
		
		
		/*平台下载资源信息结构*/
		DownloadPlatformFilesParamStruct:function(epId,fileName,filePath,saveAllPath,csuPuid,puid,idx,offset,length)
		{
			this.epId = (typeof epId != "undefined" ? epId : "");
			this.fileName = (typeof fileName != "undefined" ? fileName : "");
			this.fileAllPath = (typeof filePath != "undefined" ? filePath : "");
			this.saveAllPath = (typeof saveAllPath != "undefined" ? saveAllPath : "");
 			this.csuPuid = (typeof csuPuid != "undefined" ? csuPuid : "");
			this.puid = (typeof puid != "undefined" ? puid : "");
			this.idx = (typeof idx != "undefined" ? idx : "");
			this.offset = (typeof offset != "undefined" ? offset : 0);
			this.length = (typeof length != "undefined" ? length : -1);
		},
		
		/*前端下载Vod资源信息结构*/
		DownloadCEFSVodFilesParamStruct:function(epId,beginTime,endTime,puid,idx,saveAllPath)
		{
			this.epId = (typeof epId != "undefined" ? epId : "");
			this.beginTime = (typeof beginTime != "undefined" ? beginTime : "");
			this.endTime = (typeof endTime != "undefined" ? endTime : "");
			this.saveAllPath = (typeof saveAllPath != "undefined" ? saveAllPath : ""); 
			this.puid = (typeof puid != "undefined" ? puid : "");
			this.idx = (typeof idx != "undefined" ? idx : ""); 
		}, 
		
		/*前端下载Image资源信息结构*/
		DownloadCEFSImageFilesParamStruct:function(epId,fileTime,noInSecond,puid,idx,saveAllPath)
		{
			this.epId = (typeof epId != "undefined" ? epId : "");
			this.fileTime = (typeof fileTime != "undefined" ? fileTime : "");
			this.noInSecond = (typeof noInSecond != "undefined" ? noInSecond : "");
			this.saveAllPath = (typeof saveAllPath != "undefined" ? saveAllPath : ""); 
			this.puid = (typeof puid != "undefined" ? puid : "");
			this.idx = (typeof idx != "undefined" ? idx : ""); 
		}, 
		
		/*
		*	函数名		:	DownloadStruct
		*	函数功能	：	下载对象信息结构
		*	备注		： 
		*	作者		：	huzw
		*	时间		：	2010年12月17日 
		*	返回值		：	无 
		*	参数说明	：	7个参数 
		*			string key			下载对象的键值 
 		*			string connectId	连接ID
 		*			string dl			指向DL实例对象
		*			string type			下载文件类型(录像或图片)["vod","image"]
		*			string fileVer		下载文件保存格式["Platform","CEFS"]
		*			object fileParams	下载文件相关参数
		*			object customParams	下载文件自定义参数 
 		*/
		DownloadStruct:function(key,connectId,dl,type,fileVer,fileParams,customParams)
		{
			this.key = (typeof key != "undefined" ? key : "");
			this.connectId = (typeof connectId != "undefined" ? connectId : "");
			this.dl = (typeof dl != "undefined" ? dl : "");
			this.type = (typeof type != "undefined" ? type : "");
			this.fileVer = (typeof fileVer != "undefined" ? fileVer : "");
			this.fileParams = (typeof fileParams != "undefined" ? fileParams : null);
			this.customParams = (typeof customParams != "undefined" ? customParams : null);
			
			this.Start = function(){};
			this.Stop = function(){};
			this.GetStatus = function(){};
		},
		
		/*
		*	函数名		:	DownloadStatusStruct
		*	函数功能	：	下载状态信息结构 
		*	备注		： 
		*	作者		：	huzw
		*	时间		：	2010年12月17日 
		*	返回值		：	无 
		*	参数说明	：	4个参数 
		*			Uint flag			 下载状态信号量[1,2,3,4,5,6,7]
 		*			string description	 下载状态具体描述		
 		*			Uint byte			 已经下载的字节数 
		*			Uint bitrate		 下载码率 
 		*/
		DownloadStatusStruct:function(flag,description,byte,bitrate)
		{
			this.flag = (typeof flag != "undefined" ? flag : 0);
			this.description = (typeof description != "undefined" ? description : "");
			this.byte = (typeof byte != "undefined" ? byte : 0);
			this.bitrate = (typeof bitrate != "undefined" ? bitrate : 0);
		},
		
		//*****************************************************************************************
        
		/*
         *	函数名	 	：WindowEventStruct
         *	函数功能	：窗口事件信息结构 
         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2010年08月11日 
         *	返回值		：无
         *	参数说明	：15个参数 
         *  string stop                  视频停止响应事件
         *  string click                 单击窗口事件
         *  string fullScreen            全屏事件
         *  string restore               全屏恢复事件
         *  string pop                   弹出小窗口事件 
         *  string startRecord           开始录像事件 
         *  string stopRecord            停止录像事件
         *  string ptzControl            云台控制事件
         *  string enableMainPopMenu     是否打开右键菜单
         *  string customMenuCommand     自定义菜单响应事件 
         *  string menuBigWnd            大小窗口切换事件
         *  string topMost               弹出窗口置顶
         *  string maskClick             视频遮挡单击事件
         *  string maskDarg              视频遮拖动开始事件 
         *  string maskDragEnd           视频遮拖动结束事件   
         */
        WindowEventStruct:function(stop,click,fullScreen,restore,pop,snapshot,startRecord,stopRecord,ptzControl,enableMainPopMenu,customMenuCommand,menuBigWnd,topMost,maskClick,maskDarg,maskDragEnd)
        {
            this.onStop = {status:false,callback:""};
            this.onStop.status = (typeof stop != "undefined" && typeof stop.status != "undefined" && stop.status== true? true:false);
            this.onStop.callback = (typeof stop != "undefined" && typeof stop.callback != "undefined" && stop.callback.constructor == Function ? stop.callback:"");
            
            this.onClick = {status:false,callback:""};
            this.onClick.status = (typeof click != "undefined" && typeof click.status != "undefined" && click.status== true? true:false);
            this.onClick.callback = (typeof click != "undefined" && typeof click.callback != "undefined" && click.callback.constructor == Function ? click.callback:"");
            
            this.onFullScreen = {status:true,callback:""};            
            this.onFullScreen.status = (typeof fullScreen != "undefined" && typeof fullScreen.status != "undefined" && fullScreen.status== false? false:true);
            this.onFullScreen.callback = (typeof fullScreen != "undefined" && typeof fullScreen.callback != "undefined" && fullScreen.callback.constructor == Function ? fullScreen.callback:"");
            
            this.onRestore = {status:true,callback:""};
            this.onRestore.status = (typeof restore != "undefined" && typeof restore.status != "undefined" && restore.status== false? false:true);
            this.onRestore.callback = (typeof restore != "undefined" && typeof restore.callback != "undefined" && restore.callback.constructor == Function ? restore.callback:"");
            
            this.onPop = {status:false,callback:null};
            this.onPop.status = (typeof pop != "undefined" && typeof pop.status != "undefined" && pop.status== true? true:false);
            this.onPop.callback = (typeof pop != "undefined" && typeof pop.callback != "undefined" && pop.callback.constructor == Function ? pop.callback:"");
            
            this.onSnapshot = {status:false,callback:null};
            this.onSnapshot.status = (typeof snapshot != "undefined" && typeof snapshot.status != "undefined" && snapshot.status== true? true:false);
            this.onSnapshot.callback = (typeof snapshot != "undefined" && typeof snapshot.callback != "undefined" && snapshot.callback.constructor == Function ? snapshot.callback:"");
            
            this.onStartRecord = {status:false,callback:null};        
            this.onStartRecord.status = (typeof startRecord != "undefined" && typeof startRecord.status != "undefined" && startRecord.status== true? true:false);
            this.onStartRecord.callback = (typeof startRecord != "undefined" && typeof startRecord.callback != "undefined" && startRecord.callback.constructor == Function ? snapshot.callback:"");
            
            this.onStopRecord = {status:false,callback:null};        
            this.onStopRecord.status = (typeof stopRecord != "undefined" && typeof stopRecord.status != "undefined" && stopRecord.status== true? true:false);
            this.onStopRecord.callback = (typeof stopRecord != "undefined" && typeof stopRecord.callback != "undefined" && stopRecord.callback.constructor == Function ? stopRecord.callback:null);
            
            this.onPTZControl = {status:false,callback:""};        
            this.onPTZControl.status = (typeof ptzControl != "undefined" && typeof ptzControl.status != "undefined" && ptzControl.status== true? true:false);
            this.onPTZControl.callback = (typeof ptzControl != "undefined" && typeof ptzControl.callback != "undefined" && ptzControl.callback.constructor == Function ? ptzControl.callback:"");
            
            /*this.enableMainPopMenu = {status:false};   
            this.enableMainPopMenu.status = (typeof enableMainPopMenu != "undefined" && typeof enableMainPopMenu.status != "undefined" && enableMainPopMenu.status== true? true:false);*/
            
            this.onCustomMenuCommand = {status:false,menu:new Array(),callback:""};
            this.onCustomMenuCommand.status = (typeof customMenuCommand != "undefined" && typeof customMenuCommand.status != "undefined" && customMenuCommand.status== true? true:false);
            this.onCustomMenuCommand.menu = (typeof customMenuCommand != "undefined" && typeof customMenuCommand.menu != "undefined" ? customMenuCommand.menu:"");
            this.onCustomMenuCommand.callback = (typeof customMenuCommand != "undefined" && typeof customMenuCommand.callback != "undefined" && customMenuCommand.callback.constructor == Function ? customMenuCommand.callback:"");
            
            this.onMenu_BigWnd = {status:false,callback:""};        
            this.onMenu_BigWnd.status = (typeof menuBigWnd != "undefined" && typeof menuBigWnd.status != "undefined" && menuBigWnd.status== true? true:false);
            this.onMenu_BigWnd.callback = (typeof menuBigWnd != "undefined" && typeof menuBigWnd.callback != "undefined" && menuBigWnd.callback.constructor == Function ? menuBigWnd.callback:"");
            
            this.onTopMost = {status:false,callback:""};        
            this.onTopMost.status = (typeof topMost != "undefined" && typeof topMost.status != "undefined" && topMost.status== true? true:false);
            this.onTopMost.callback = (typeof topMost != "undefined" && typeof topMost.callback != "undefined" && topMost.callback.constructor == Function ? topMost.callback:"");
            
            this.onMaskClick = {status:false,callback:""};        
            this.onMaskClick.status = (typeof maskClick != "undefined" && typeof maskClick.status != "undefined" && maskClick.status== true? true:false);
            this.onMaskClick.callback = (typeof maskClick != "undefined" && typeof maskClick.callback != "undefined" && maskClick.callback.constructor == Function ? maskClick.callback:"");
            
            this.onMaskDrag = {status:false,callback:""};        
            this.onMaskDrag.status = (typeof maskDarg != "undefined" && typeof maskDarg.status != "undefined" && maskDarg.status== true? true:false);
            this.onMaskDrag.callback = (typeof maskDarg != "undefined" && typeof maskDarg.callback != "undefined" && maskDarg.callback.constructor == Function ? maskDarg.callback:"");
            
            this.onMaskDragEnd = {status:false,callback:""}  ;      
            this.onMaskDragEnd.status = (typeof maskDragEnd != "undefined" && typeof maskDragEnd.status != "undefined" && maskDragEnd.status== true? true:false);
            this.onMaskDragEnd.callback = (typeof maskDragEnd != "undefined" && typeof maskDragEnd.callback != "undefined" && maskDragEnd.callback.constructor == Function ? maskDragEnd.callback:"");
        },
         /*
         *	函数名		：PUNodeStruct
         *	函数功能	：PU资源节点结构
         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2010年08月11日 
         *	返回值		：无
         *	参数说明	：9个参数 
         *  string puid             资源GUID
         *  string name             资源GUID
         *  string description            资源型号
         *  string modelName             资源名称
         *  string modelType      资源描述
         *  string manufactrueID           资源是否可用
         *  string resType           资源是否使能
         *  string enable           父节点GUID
         *  string online             资源类型
         *  string childResource    子资源 
         */
        PUNodeStruct:function(puid,name,description,modelName,modelType,manufactrueID,hardwareVersion,softwareVersion,deviceID,resType,enable,online,childResource)
        {
            this.puid = (typeof puid != "undefined" ? puid : "");
            this.name = (typeof name != "undefined" ? name : "");
            this.description = (typeof description != "undefined" ? description : "");
            this.modelName = (typeof modelName != "undefined" ? modelName : "");
            this.modelType = (typeof modelType != "undefined" ? modelType : "");
            this.manufactrueID = (typeof manufactrueID != "undefined" ? manufactrueID : "");
			this.hardwareVersion = (typeof hardwareVersion != "undefined" ? hardwareVersion : "");
			this.softwareVersion = (typeof softwareVersion != "undefined" ? softwareVersion : ""); 
			this.deviceID = (typeof deviceID != "undefined" ? deviceID : ""); 
            this.resType = (typeof resType != "undefined" ? resType : 0);
            this.enable = (typeof enable != "undefined" ? enable : 0);
            this.online = (typeof online != "undefined" ? online : 0);
            this.childResource = (typeof childResource != "undefined" ? childResource : null);
        },
         /*
         *	函数名		：PUResourceNodeStruct
         *	函数功能	：PU子资源节点结构 
         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2010年08月11日 
         *	返回值		：无
         *	参数说明	：5个参数 
         *  string type             资源GUID 
         *  string idx            资源型号
         *  string name             资源GUID
         *  string description             资源类型
         *  string enable           父节点GUID
         */
        PUResourceNodeStruct:function(type,idx,name,description,enable)
        {
            this.type = (typeof type != "undefined" ? type : "");
            this.idx = (typeof idx != "undefined" ? idx : "");
            this.name = (typeof name != "undefined" ? name : "");
            this.description = (typeof description != "undefined" ? description : "");
            this.enable = (typeof enable != "undefined" ? enable : 0);
        },
         /*
         *	函数名		：UserInfoStruct
         *	函数功能	：用户信息结构 
         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2011年04月10日 
         *	返回值		：无
         *	参数说明	：13个参数 
         *  number index                用户索引
         *  string identity             用户ID 
         *  number active               是否激活  
		 *  number priority             优先级   
         *  Number maxSessionNum       允许最大在线数
         *  string actorType            角色类型
         *  number actorIndex           角色索引
         *  number parentUserIndex      父用户索引 
         *  string password   			接入密码
         *  number enableWhiteList      允许白名单 
         *  string name                 用户名称
         *  string phones               电话
         *  string description          描述
         *  string remark               备注
         */
        UserInfoStruct:function(index,identity,active,priority,maxSessionNum,actorType,actorIndex,parentUserIndex,password,enableWhiteList,name,phones,description,remark)
        {
            this.index = (typeof index != "undefined" ? index : 0);
            this.identity = (typeof identity != "undefined" ? identity : "");
            this.active = (typeof active != "undefined" ? active : 0);
            this.priority = (typeof priority != "undefined" ? priority : "");
            this.maxSessionNum = (typeof maxSessionNum != "undefined" ? maxSessionNum : 0);
            this.actorType = (typeof actorType != "undefined" ? actorType : "");
            this.actorIndex = (typeof actorIndex != "undefined" ? actorIndex : 0);
            this.parentUserIndex = (typeof parentUserIndex != "undefined" ? parentUserIndex : 0);
            this.password = (typeof password != "undefined" ? password : "");
			this.enableWhiteList = (typeof enableWhiteList != "undefined" ? enableWhiteList : 0);
            this.name = (typeof name != "undefined" ? name : "");
            this.phones = (typeof phones != "undefined" ? phones : "");
            this.description = (typeof description != "undefined" ? description : "");
            this.remark = (typeof remark != "undefined" ? remark : "");
        },
        
         /*
         *	函数名		：UserResourceStruct
         *	函数功能	：用户信息结构 
         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2011年04月11日 
         *	返回值		：无
         *	参数说明	：3个参数 
         *  string puid             用户ID 
         *  number type               是否激活 
         *  number idx             优先级 
         */
        UserResourceStruct:function(puid,type,idx)
        {
            this.puid = (typeof puid != "undefined" ? puid : "");
            this.type = (typeof type != "undefined" ? type : "");
            this.idx = (typeof idx != "undefined" ? idx : 0);
        },

         /*
         *	函数名		：DebugMessageStruct
         *	函数功能	：调试信息结构 
         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2010年11月26日 
         *	返回值		：无
         *	参数说明	：3个参数 
         *  string time   时间
         *  string fn     函数
         *  string msg    描述
         */
        DebugMessageStruct:function(time,fn,msg)
        {
            this.time = time;
            this.fn = fn;
            this.msg = msg;
        },
		
		 /*
         *	函数名		：LogicGroupStruct
         *	函数功能	：逻辑分组信息结构 
         *	备注		：无
         *	作者		：huzw
         *	时间		：2011.04.15 
         *	返回值		：无
         *	参数说明	：5个参数 
         *  string index   逻辑分组索引
         *  string name    逻辑分组名称
         *  string lastRefreshTime    最新刷新时间   
		 *  string refreshInterval	  刷新时间间隔
		 *  Nrcap2.Struct.LogicGroupNodeStruct childResource 	逻辑分组节点数组对象
         */
		LogicGroupStruct:function(index,name,lastRefreshTime,refreshInterval,childResource)
		{
			this.index = (index != null && typeof index != "undefined" ? index : "0" );
			this.name = (name != null && typeof name != "undefined" ? name : "" );
			this.lastRefreshTime = (lastRefreshTime != null && typeof lastRefreshTime != "undefined" ? lastRefreshTime : "" );
			this.refreshInterval = (refreshInterval != null && typeof refreshInterval != "undefined" ? refreshInterval : "" );
			this.childResource = (childResource != null && typeof childResource == "object" && childResource.constructor == Array ? childResource : new Array());
			
		},
		
		 /*
         *	函数名		：LogicGroupNodeStruct
         *	函数功能	：逻辑分组节点信息结构 
         *	备注		：无
         *	作者		：huzw
         *	时间		：2011.04.15 
         *	返回值		：无
         *	参数说明	：4个参数 
         *  string index   逻辑分组节点索引
         *  string name    逻辑分组节点名称
         *  string parentNode_Index    逻辑分组节点上级索引
		 *  Nrcap2.Struct.LogicGroupNodeStruct / Nrcap2.Struct.LogicGroupResourceStruct childResource  数组对象
         */
		LogicGroupNodeStruct:function(index,name,parentNode_Index,childResource)
		{
			this.index = (index != null && typeof index != "undefined" ? index : "0" );
			this.name = (name != null && typeof name != "undefined" ? name : "" );
			this.parentNode_Index = (parentNode_Index != null && typeof parentNode_Index != "undefined" ? parentNode_Index : "0" ); 
			this.childResource = (childResource != null && typeof childResource == "object" && childResource.constructor == Array ? childResource : new Array());
			
		},
		
		 /*
         *	函数名		：LogicGroupNodeStruct
         *	函数功能	：逻辑分组节点下资源信息结构 
         *	备注		：无
         *	作者		：huzw
         *	时间		：2011.04.15 
         *	返回值		：无
         *	参数说明	：6个参数 
		 *  string puid	   设备PUID 
		 *  string type    资源类型Nrcap2.Enum.PuResourceType.VideoIn
         *  string idx     视频资源索引 
         *  string name    视频头名称 
		 *  string description 描述
		 *  string enable  视频头是否使能 
         *  string parentNode_Index    逻辑分组节点上级索引
         */
		LogicGroupResourceStruct:function(puid,type,idx,name,description,enable,parentNode_Index)
		{
			this.puid = (puid != null && typeof puid != "undefined" ? puid : "" ); 
			this.type = (type != null && typeof type != "undefined" ? type : "" );
			this.idx = (idx != null && typeof idx != "undefined" ? idx : "0" );  
			this.name = (name != null && typeof name != "undefined" ? name : "" ); 
			this.description = (description != null && typeof description != "undefined" ? description : "" );
			this.enable = (enable != null && typeof enable != "undefined" ? enable : "0" );    
			this.parentNode_Index = (parentNode_Index != null && typeof parentNode_Index != "undefined" ? parentNode_Index : "0" ); 
		},
		
		/*
		*	函数名		：EventInfoStruct
		*	函数功能	：设备事件信息结构 
		*	备注		：无
		*	作者		：huzw
		*	时间		：2011.04.20 
		*	返回值		：无
		*	参数说明	：8个参数 
		*  string eventId	设备事件ID 
		*  string name     事件标志名["Event"]
		*  string time     事件发生时间戳 
		*  string level    事件类型["Notify":通知,"Alarm":报警]
		*  string ignoreFlag 是否可忽略信号量
		*	string offlineFlag 是否在线信号量 
		*  string eventSrc  事件发生源信息 
		*  string eventDes  事件描述
		*/
		EventInfoStruct:function(eventId,name,time,level,ignoreFlag,offlineFlag,eventSrc,eventDes)
		{
			this.eventId = (typeof eventId != "undefined" ? eventId : "");
			this.name = (typeof name != "undefined" ? name : "");
			this.time = (typeof time != "undefined" ? time : "");
			this.level = (typeof level != "undefined" ? level : "");
			this.ignoreFlag = (typeof ignoreFlag != "undefined" ? ignoreFlag : "1");
			this.offlineFlag = (typeof offlineFlag != "undefined" ? offlineFlag : "1");
			this.eventSrc = (typeof eventSrc != "undefined" ? eventSrc : {});
			this.eventDes = (typeof eventDes != "undefined" ? eventDes : {});
		},
		
		/*
		*	函数名	：CommonResDescriptionStruct
		*	函数功能	：所有资源描述信息结构 
		*	备注		：无
		*	作者		：huzw
		*	时间		：2011.04.21 
		*	返回值	：无
		*	参数说明	：6个参数 
		*  string puid 		设备PUID
		*  string resType	资源类型[Nrcap2.Enum.PuResourceType对象]
		*  string resIdx    资源索引
		*  string name      资源名称
		*  string description    资源描述
		*  string enable 是否使能 
		*/
		CommonResDescriptionStruct:function(puid,resType,resIdx,name,description,enable)
		{
			this.puid = (typeof puid != "undefined" ? puid : "");
			this.resType = (typeof resType != "undefined" ? resType : "");
			this.resIdx = (typeof resIdx != "undefined" ? resIdx : "0");
			this.name = (typeof name != "undefined" ? name : "");
			this.description = (typeof description != "undefined" ? description : "");
			this.enable = (typeof enable != "undefined" ? enable : "1");	
		},
		
		/*
		*	函数名	：PlatformStoragePlanStruct
		*	函数功能	：平台存储计划信息结构 
		*	备注		：无
		*	作者		：huzw
		*	时间		：2011.05.17
		*/
		PlatformStoragePlanStruct:function(name, guard, cycle, cycleParam, guardTimeMap, serialNo, serialToken){
			this.name = (typeof name != "undefined" ? name : "");
			this.guard = (typeof guard != "undefined" ? guard : "1");
			this.cycle = (typeof cycle != "undefined" ? cycle : "");
			this.cycleParam = (typeof cycleParam != "undefined" ? cycleParam : "");
			this.guardTimeMap = (typeof guardTimeMap != "undefined" ? guardTimeMap : "");	
			this.serialNo = (typeof serialNo != "undefined" ? serialNo : "");
			this.serialToken = (typeof serialToken != "undefined" ? serialToken : "");
		},
		
		/*
		*	函数名	：PlatformStoragePlanResourceStruct
		*	函数功能	：平台存储计划资源信息结构 
		*	备注		：无
		*	作者		：huzw
		*	时间		：2011.05.17
		*/
		PlatformStoragePlanResourceStruct:function(name, puid, resType, resIdx, optId, value){
			this.name = (typeof name != "undefined" ? name : "");
			this.puid = (typeof puid != "undefined" ? puid : "");
			this.resType = (typeof resType != "undefined" ? resType : "");
			this.resIdx = (typeof resIdx != "undefined" ? resIdx : "");
			this.optID = (typeof optId != "undefined" ? optId : "");	
			this.value = (value != null || typeof value != "undefined" ? value : ""); 
		},
		
		/*
		*	函数名	：GPSDataInfoStruct
		*	函数功能	：GPS数据信息结构 
		*	备注		：无
		*	作者		：huzw
		*	时间		：2011.06.08
		*/
		GPSDataInfoStruct:function( puid, resType, resIdx, time, longitude, latitude, bearing, altitude, state, speed, maxspeed, minspeed, timestamp)
		{ 
			this.puid = (typeof puid != "undefined" ? puid : "");
			this.resType = (typeof resType != "undefined" ? resType : "");
			this.resIdx = (typeof resIdx != "undefined" ? resIdx : "");
			this.time = (typeof time != "undefined" ? time : "");	
			this.longitude = (typeof longitude != "undefined" ? longitude : "");
			this.latitude = (latitude != null || typeof latitude != "undefined" ? latitude : "");  
			this.bearing = (typeof bearing != "undefined" ? bearing : "");
			this.altitude = (typeof altitude != "undefined" ? altitude : "");
			this.state = (typeof state != "undefined" ? state : "");	
			this.speed = (speed != null || typeof speed != "undefined" ? speed : ""); 
			this.maxspeed = (maxspeed != null || typeof maxspeed != "undefined" ? maxspeed : ""); 
			this.minspeed = (minspeed != null || typeof minspeed != "undefined" ? minspeed : ""); 
			this.timestamp = (typeof timestamp != "undefined" ? timestamp : "");	
		},
		
		/*
		*	函数名	：GPSDataCollectionStruct
		*	函数功能	：GPS数据通道信息结构 
		*	备注		：无
		*	作者		：huzw
		*	时间		：2011.06.10
		*/
		GPSDataCollectionStruct:function(dckey, connectId, dc, puid, resType, resIdx, streamType, customParams)
		{
			this.key = (typeof dckey != "undefined" ? dckey : "");			
			this.connectId = (typeof connectId != "undefined" ? connectId : "");
			this.dc = (typeof dc != "undefined" ? dc : null);
			this.puid = (typeof puid != "undefined" ? puid : null);
			this.resType = (typeof resType != "undefined" ? resType : "GPS");
			this.resIdx = (typeof resIdx != "undefined" ? resIdx : "0");
			this.streamType = (streamType && typeof streamType != "undefined" ? streamType : "REALTIME");
			this.customParams = (customParams && typeof customParams != "undefined" ? customParams : {});
			this.session = null;
			this.inited = false; // OpenNB是否建立
			this.status = false; // 探测数据通道是否连接成功
			
			this.Open = function(){};
			this.GetOpenStatus = function(){};
			this.Close = function(){};
			this.GetGPSCurrentStatus = function(){}; 
		},
		 
		/*
		*	函数名	：PlatformLinkActionPlanStruct
		*	函数功能	：平台联动计划信息结构 
		*	备注		：无
		*	作者		：huzw
		*	时间		：2011.08.19
		*/
		PlatformLinkActionPlanStruct:function(name, guard, cycle, cycleParam, guardTimeMap, combineTime, triggerStatus)
		{
			this.name = (typeof name != "undefined" ? name : "");
			this.guard = (typeof guard != "undefined" ? guard : "1");
			this.cycle = (typeof cycle != "undefined" ? cycle : "");
			this.cycleParam = (typeof cycleParam != "undefined" ? cycleParam : "");
			this.guardTimeMap = (typeof guardTimeMap != "undefined" ? guardTimeMap : "");	
			this.combineTime = (typeof combineTime != "undefined" ? combineTime : 0);
			this.triggerStatus = (typeof triggerStatus != "undefined" ? triggerStatus : "");
		},
		
		/*
		*	函数名	：PlatformLinkActionPlanEventStruct
		*	函数功能	：平台联动计划事件源信息结构 
		*	备注		：无
		*	作者		：huzw
		*	时间		：2011.06.14
		*/
		PlatformLinkActionPlanEventStruct:function(name, objType, objId, resName, resType, resIdx, eventId)
		{
			this.name = (typeof name != "undefined" ? name : ""); // 联动计划名称
			this.objType = (typeof objType != "undefined" ? objType : "151");
			this.objId = (typeof objId != "undefined" ? objId : "");
			this.resName = (typeof resName != "undefined" ? resName : "");
			this.resType = (typeof resType != "undefined" ? resType : "");	
			this.resIdx = (typeof resIdx != "undefined" ? resIdx : 0);
			this.eventId = (typeof eventId != "undefined" ? eventId : "");
		},
		
		/*
		*	函数名	：PlanformLinkActionPlanActionStruct
		*	函数功能	：平台联动计划动作集信息结构 
		*	备注		：无
		*	作者		：huzw
		*	时间		：2011.06.15
		*/ 
		PlanformLinkActionPlanActionStruct:function(name, objType, objID, resType, resIdx, cmdType, optID, prio, resName, delayTime, cycleTime, cycleNum, paramTag)
		{
			this.name = (typeof name != "undefined" ? name : ""); // 联动计划名称
			this.objType = (typeof objType != "undefined" ? objType : "151");
			this.objID = (typeof objID != "undefined" ? objID : "");
			this.resType = (typeof resType != "undefined" ? resType : "");	
			this.resIdx = (typeof resIdx != "undefined" ? resIdx : "");
			this.cmdType = (typeof cmdType != "undefined" ? cmdType : "");	
			this.optID = (typeof optID != "undefined" ? optID : "");
			this.prio = (typeof prio != "undefined" ? prio : "1"); 
			this.resName = (typeof resName != "undefined" ? resName : "");
			this.delayTime = (typeof delayTime != "undefined" ? delayTime : "");
			this.cycleTime = (typeof cycleTime != "undefined" ? cycleTime : "");
			this.cycleNum = (typeof cycleNum != "undefined" ? cycleNum : "");
			this.paramTag = (typeof paramTag != "undefined" ? paramTag : new Object());
		},
		
		/*
		*	函数名		:	CallTalkChannelStatusStruct
		*	函数功能	：	喊话或对讲通道状态信息结构 
		*	备注		： 
		*	作者		：	huzw
		*	时间		：	2011.10.19
		*	返回值		：	无 
		*	参数说明	：	2个参数 
		*			Uint flag			 喊话或对讲通道状态信号量[1,2,3]
 		*			string description	 喊话或对讲通道状态具体描述		 
 		*/
		CallTalkChannelStatusStruct:function(flag, description)
		{
			this.flag = (typeof flag != "undefined" ? flag : 0);
			this.description = (typeof description != "undefined" ? description : ""); 
		},
		
        end:true
    
    },
    
    Enum:{
        FetchResourceLevel:
        {
            Nrcap2_GetPUInfo                        :                   "Nrcap2_GetPUInfo",
            Nrcap2_GetPUResourceInfo                :                   "Nrcap2_GetPUResourceInfo"
        },
        
        RouteIDType:
        {
            CUI:5
        },
        
        OperationID:
        {
            CTL_CUI_QueryPUIDSets       :       "CTL_CUI_QueryPUIDSets",
            CTL_CUI_QueryPUIDRes        :       "CTL_CUI_QueryPUIDRes",
			
			CTL_SC_QueryIVDate			:		"CTL_SC_QueryIVDate",
			CTL_SC_QueryIVDateFiles		:		"CTL_SC_QueryIVDateFiles",
						
			end:true
        },
		
		//******************************************************************************
		LocalControlID:
		{
			"GetInputVolume"		:		"GetInputVolume",		/* 获取本地输入音量 */
			"SetInputVolume"		:		"SetInputVolume",		/* 设置本地输入音量 */	
			"GetOutputVolume"		:		"GetOutputVolume",		/* 获取本地输出音量 */	
			"SetOutputVolume"		:		"SetOutputVolume",		/* 设置本地输出音量 */	 
			
			end: true
		}, 
		
		ConfigID:
		{
			"CFG_PTZ_Speed"			:		"CFG_PTZ_Speed",		/* 云台速度 */
			"CFG_IV_Brightness"		:		"CFG_IV_Brightness",	/* 亮度 */	
			"CFG_IV_Contrast"		:		"CFG_IV_Contrast",		/* 对比度 */	
			"CFG_IV_Hue"			:		"CFG_IV_Hue",			/* 色调 */	
			"CFG_IV_Saturation"		:		"CFG_IV_Saturation",	/* 饱和度 */	
			
			end:true
		},
		
		PuModelType:
		{
			"ENC"			:		"ENC",		/* 有线编码器 */
			"WENC"			:		"WENC",		/* 无线编码器 */
			"DEC"			:		"DEC",		/* 有线解码器 */
			"WDEC"			:		"WDEC",		/* 无线解码器 */
			"CSU"			:		"CSU",		/* 中心存储单元 */
			"ESU"			:		"ESU",		/* 企业自建存储单元 */ 
			
			end:true
		},
		
		PuResourceType:
		{
			"GPS"			:		"GPS",		/* GPS模块 */
			"WIFI"			:		"WIFI",		/* WIFI模块 */
			"AudioIn"		:		"IA",		/* 输入音频 */
			"AlertIn"		:		"IDL",		/* 输入报警 */
			"AudioOut"		:		"OA",		/* 输出音频 */
			"AlertOut"		:		"ODL",		/* 输出报警 */
			"VideoIn"		:		"IV",		/* 输入视频 */
			"VideoOut"		:		"OV",		/* 输出视频 */
			"PTZ"			:		"PTZ",		/* 云台 */
			"SELF"			:		"SELF",		/* 设备本身 */ 
			"Storager"		:		"SG",		/* 存储器(前端存储) */
			"SC"			:		"SC",		/* 存储器(中心存储) */
			"SerialPort"	:		"SP", 		/* 设备串口 */
			"Wireless"		:		"WM", 		/* 无线模块 */
			
			end:true
		},
		
		NrcapStreamType:
		{
			"st_video"			:		"REALTIME",		/* 实时流 */
			"st_vod"			:		"STORAGE",		/* 存储流 */
			"st_image"			:		"PICTURE",		/* 图片流 */
			
			"st_phone2G"		:		"MOBILE2G",		/* 2G手机观看码流 */
			"st_phone3G"		:		"MOBILE3G",		/* 3G手机观看码流 */
			"st_platTS"			:		"TRANSCODE",	/* 平台转码流 */
			
			end:true
		},
		
		StorageFileType:
		{
			"platform"	:	"platform", 	/* 文件存储在平台 */
			"CEFS"		:	"CEFS"			/* 文件存储在前端设备 */
		},
		
		VodSpeedDirect:
		{
			"fast"		:		"fast",		/* 点播加速 */
			"slow"		:		"slow"		/* 点播减速 */
		},
		
		PTZControl:
		{
			"start"		:		"start",	/* 云台启动 */
			"stop"		:		"stop"		/* 云台停止 */
		},
		
		PTZDirection:
		{
			"turnleft"			:		"CTL_PTZ_StartTurnLeft",	/* 向左转 */
			"turnright"			:		"CTL_PTZ_StartTurnRight",	/* 向右转 */
			"turnup"			:		"CTL_PTZ_StartTurnUp",		/* 向上转 */
			"turndown"			:		"CTL_PTZ_StartTurnDown",	/* 向下转 */
			"stopturn"			:		"CTL_PTZ_StopTurn",			/* 停止转动 */
			
			"aperturea"			:		"CTL_PTZ_AugmentAperture",	/* 增大光圈 */
			"aperturem"			:		"CTL_PTZ_MinishAperture",	/* 缩小光圈 */
			"stopaperture"		:		"CTL_PTZ_StopApertureZoom",	/* 停止光圈缩放 */
			
			"focusfar"			:		"CTL_PTZ_MakeFocusFar",		/* 推远焦点 */
			"focusnear"			:		"CTL_PTZ_MakeFocusNear",	/* 拉近焦点 */
			"stopfocus"			:		"CTL_PTZ_StopFocusMove",	/* 停止焦点移动 */
			
			"zoomin"			:		"CTL_PTZ_ZoomInPicture",	/* 放大图像 */
			"zoomout"			:		"CTL_PTZ_ZoomOutPicture",	/* 缩小图像 */
			"stopzoom"			:		"CTL_PTZ_StopPictureZoom",	/* 停止图像缩放 */
			
			end:true
		},		
		
		/*支持中英文*/
		LanguagePack:
		{
			"playStatus":	// PlayVideo或PlayVod状态 
			[{Chinese:"",English:""},
			 {Chinese:"准备就绪",English:"ready"},
			 {Chinese:"正在连接",English:"connecting"},
			 {Chinese:"正在缓冲",English:"buffering"},
			 {Chinese:"正在播放",English:"playing"}],
			
			"downloadStatus":	// download状态 
			[{Chinese:"",English:""},
			 {Chinese:"请求Token",English:"requesting Token"},
			 {Chinese:"接收Token",English:"Token response"},
			 {Chinese:"请求下载",English:"requesting download"},
			 {Chinese:"接收响应",English:"receive response"},
			 {Chinese:"正在缓冲",English:"buffering"},
			 {Chinese:"正在下载",English:"downloading"},
			 {Chinese:"下载完毕",English:"completed"}],
			
			"calltalk": // 喊话或对讲通道状态

			[{Chinese:"",English:""},
			 {Chinese:"通道空闲",English:"channel free"},
			 {Chinese:"正在建立",English:"channel creating"},
			 {Chinese:"建立成功",English:"channel created"}],
			
			end:true
		},
		
		//******************************************************************************
        
		end:true
    },
    
    
  
    
    /*
	*	对象名		：Utility
	*	功能    	：公共功能对象 
	*	备注		：无
	*	作者		：Lingsen
	*	时间		：2010年11月26日 
	*/
    Utility:{
         /*
         *	函数名		：DateFormat
         *	函数功能	：格式化返回当前客户端系统时间  
         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2010年11月26日 
         *	返回值		：无
         *	参数说明	：1个参数.  
         *  string mask 时间样式
         */
        DateFormat:function(mask,d)
        {
            if (typeof d == "undefined" || !d instanceof Date)
            {
                d = new Date();
            }

            if (typeof mask == "undefined" || mask == "" || mask == null)
            {
                mask = "yyyy-MM-dd HH:mm:ss";
            }
            return mask.replace(/"[^"]*"|'[^']*'|\b(?:d{1,4}|[m|M]{1,4}|yy(?:yy)?|([hHMstT])\1?|[lLZ])\b/g, function($0)
            {
                switch($0)
                {
                    case 'd':   return d.getDate();    
                    case 'dd':  return Nrcap2.Utility.Zeroize(d.getDate());    
                    case 'ddd': return ['Sun','Mon','Tue','Wed','Thr','Fri','Sat'][d.getDay()];    
                    case 'dddd':return ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][d.getDay()];    
                    case 'M':   return d.getMonth() + 1;    
                    case 'MM':  return Nrcap2.Utility.Zeroize(d.getMonth() + 1);    
                    case 'MMM': return ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][d.getMonth()];    
                    case 'MMMM':return ['January','February','March','April','May','June','July','August','September','October','November','December'][d.getMonth()];
                    case 'yy':  return String(d.getFullYear()).substr(2);
                    case 'yyyy':return d.getFullYear();
                    case 'h':   return d.getHours() % 12 || 12;
                    case 'hh':  return Nrcap2.Utility.Zeroize(d.getHours() % 12 || 12);
                    case 'H':   return d.getHours();
                    case 'HH':  return Nrcap2.Utility.Zeroize(d.getHours());
                    case 'm':   return d.getMinutes();
                    case 'mm':  return Nrcap2.Utility.Zeroize(d.getMinutes());
                    case 's':   return d.getSeconds();
                    case 'ss':  return Nrcap2.Utility.Zeroize(d.getSeconds());
                    case 'l':   return Nrcap2.Utility.Zeroize(d.getMilliseconds(), 3);
                    case 'L':   var m = d.getMilliseconds();
                    if (m > 99) m = Math.round(m / 10);
                    return zeroize(m);
                    case 'tt':  return d.getHours() < 12 ? 'am' : 'pm';
                    case 'TT':  return d.getHours() < 12 ? 'AM' : 'PM';
                    case 'Z':   return d.toUTCString().match(/[A-Z]+$/);
                    default:    return $0.substr(1, $0.length - 2);
                }
            });
        },
        
        GetDateTimeUTCSeconds:function(d)
        {
            if (typeof d == "undefined" || !d instanceof Date)
            {
                d = new Date();
            }
            return d.getTime()/1000;
        },
		
        /* 标准的时间字符串转为时间戳 */
        DTStrToTimestamp:function(dateStr)
        {
            dateStr = dateStr.trim();
            var d = new Date();
            var patn = /^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-)) (20|21|22|23|[0-1]?\d):[0-5]?\d:[0-5]?\d$/;
            
            if(patn.test(dateStr))
            {
               return new Date(dateStr.substr(0,4),(parseInt(dateStr.substr(5,2),10)-1),dateStr.substr(8,2),dateStr.substr(11,2),dateStr.substr(14,2),dateStr.substr(17,2)); 
            }
            else
            {
                return d;
            }
        },
    	
         /*
         *	函数名		：Zeroize
         *	函数功能	：根据长度左补零
         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2010年11月26日 
         *	返回值		：无
         *	参数说明	：2个参数 
         *  string value 	需要补零的值 
         *  number length 	需要补零的值的长度
         */
        Zeroize:function (value, length)
        {
            if (!length) length = 2;
            value = String(value);
            for (var i = 0, zeros = ''; i < (length - value.length); i++)
            {
                zeros += '0';
            }
            return zeros + value;
        },
    
        NetToHost16:function(u)
        {
            u = parseInt(u,10);
            return ((((u) << 8) & 0xFF00) | ((u) >> 8));
        },
    
        NetToHost32:function(u)
        {
            u = parseInt(u,10);
            return (((u) << 24) | (((u) << 8) & 0x00FF0000) |  (((u) >> 8) & 0x0000FF00)| (0x000000FF & ((u) >> 24)));
        },
        
        XML:function(type,xmlFile)
        {
            try
            {
                var xmlDoc;
                if(window.ActiveXObject)
                {
                    xmlDoc = new ActiveXObject('Microsoft.XMLDOM');
                    xmlDoc.async = false;
                    if (typeof type != "undefined" && type == "path")
                    {
                        xmlDoc.load(xmlFile);
                    }
                    else
                    {
                        xmlDoc.loadXML(xmlFile);
                    }
                }
                else if (document.implementation&&document.implementation.createDocument)
                {
                    xmlDoc = document.implementation.createDocument('', '', null);
                    
                    if (typeof type != "undefined" && type == "path")
                    {
                        xmlDoc.load(xmlFile);
                    }
                    else
                    {
                        xmlDoc.loadXML(xmlFile);
                    }
                }
                else
                {
                    return null;
                }
                return xmlDoc;
            }
            catch(e)
            {
                Nrcap2.Debug.Write({fn:"Nrcap2.Utility.XML",msg:"create xml doc exception,error="+e.message});
            }
            return null;
        },	
		
        /*
		*	对象名		：CheckByteLength
		*	功能    	：验证字串长度  
		*	备注		：无
		*	作者		：Lingsen
		*	时间		：2011年04月10日 
		*/
	    CheckByteLength:function(value,minlen,maxlen)
	    {
		    if (!value) value = "";    		
		    var l = value.length;
		    var blen = 0;
		    for(i=0; i<l; i++) {
		    if ((value.charCodeAt(i) & 0xff00) != 0)
		    {
			    blen ++;
		    }
			    blen ++;
		    }
		    if (blen > maxlen || blen < minlen)
		    {
			    return false;
		    }
		    return true;
	    },
	
        /*
         *	对象名		：Regexs
         *	功能    	：预定义正则式,   
         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2010年08月10日 
         */
        Regexs:{
            "uint"  : /^[0-9]*$/,
            "domain": "^((https|http|ftp|rtsp|mms)?://)" 
			        + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" /* ftp的user@ */
			        + "(([0-9]{1,3}\.){3}[0-9]{1,3}" /* IP形式的URL- 199.194.52.184 */
			        + "|" /* 允许IP和DOMAIN（域名）*/
			        + "([0-9a-z_!~*'()-]+\.)*" /* 域名- www. */
			        + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." /* 二级域名 */
			        + "[a-z]{2,6})" /* first level domain- .com or .museum */
			        + "(:[0-9]{1,4})?" /* 端口- :80 */
			        + "((/?)|" /* a slash isn't required if there is no file name */
			        + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$",
            guid    : /^0x[a-z0-9]{32}$/i,
            "puid"  : /^[A-Za-z0-9]{1,18}$/i,		// puid reg
            end:true
        },
        end:true
    },
    
	
    // 错误码 
    NrcapError:
    {
        NRCAP_SUCCESS                                           :   0x0000,         // 操作成功
        NRCAP_ERROR_INIT_SOCKET_FAILED		                    :   0x000B,         // 初始化socket失败
        
		NRCAP_ERROR_UNKNOW_EXCEPTION							:	0x1000,			// 未知类型异常	
		NRCAP_ERROR_CONNECTIONID_ALREADY						:   0x1002,			// 连接已存在 
		
        NRCAP_ERROR_LOADPLUG_NC                                 :   0x8001,         // NC未加载 
        NRCAP_ERROR_LOADPLUG_NM                                 :   0x8002,         // NM未加载 
        NRCAP_ERROR_LOADPLUG_BSP                                :   0x8003,         // BSP未加载 
        NRCAP_ERROR_LOADPLUG_BSC                                :   0x8004,         // BSC未加载 
        NRCAP_ERROR_LOADPLUG_DW                                 :   0x8005,         // DW未加载 
		NRCAP_ERROR_LOADPLUG_DC									:	0x8007,			// DC未加载  
		NRCAP_ERROR_LOADPLUG_DL									:	0x8009,			// DL未加载

		NRCAP_ERROR_LOADPLUG_NA									:	0x8011,			// NA未加载

		
        NRCAP_ERROR_INIT_NRCAPPLUG_FAILED                       :   0x6000,         // 初始化Nrcap2对象失败
        NRCAP_ERROR_NRCAPPLUG_ISNULL                            :   0x6001,         // Nrcap2为空 
        NRCAP_ERROR_INIT_CONNECTION_FAILED                      :   0x6010,         // 初始化连接对象失败  
        NRCAP_ERROR_CONNECTIONID_ALREADY_EXIST                  :   0x6011,         // 新创建连接ID已经存在
        NRCAP_ERROR_OPEN_CONNECT_FAILED                         :   0x6012,         // 连接失败
        NRCAP_ERROR_CONNECTIONID_FAILED                         :   0x6013,         // 连接ID不存在  
        NRCAP_ERROR_DISCONNECTION_FAILED                        :   0x6014,         // 删除一个连接对象失败 
        NRCAP_ERROR_CONNECTION_PARAMS_FAILED                    :   0x6016,         // 连接服务器参数错误  
        NRCAP_ERROR_CREATE_RESOURCELIST_FAILED                  :   0x6020,         // 获取资源失败
        NRCAP_ERROR_SORT_RESOURCE_FAILED                        :   0x6021,         // 对资源排序失败  
		NRCAP_ERROR_PUID_FAILED									:	0x6022,			// PUID格式不正确		
		NRCAP_ERROR_FETCHIVDATE_FAILED							:	0x6024,			// 获取有存储文件日期失败 
		NRCAP_ERROR_FETCHIVDATEFILES_FAILED						:	0x6026,			// 获取某日期下文件失败  
        NRCAP_ERROR_INIT_WINDOW_FAILED                          :   0x6030,         // 初始化视频窗口失败 
        NRCAP_ERROR_WINDOW_NOEXIST                              :   0x6031,         // 视频窗口不存在  
        NRCAP_ERROR_PLAYVIDEO_FAILED                            :   0x6032,         // 播放视频失败
        NRCAP_ERROR_GETDESCRIPTION_FAILED                       :   0x6034,         // 资源树上查找节点失败
        NRCAP_ERROR_RESOURCEINDEXOF_FAILED                      :   0x6035,         // 资源树查找资源 
        
        NRCAP_ERROR_VIDEOTOPPED                                 :   0x6036,         // 视频没有再播放 
        NRCAP_ERROR_WINDOW_FAILED                               :   0x6037,         // 视频窗口不存在        
        NRCAP_ERROR_RECORD_FAILED                               :   0x6038,         // 录像失败
        NRCAP_ERROR_SNAP_FAILED                                 :   0x6039,         // 抓拍失败
        NRCAP_ERROR_PLAYAUDIO_FAILED                            :   0x603A,         // 播放音频失败
        NRCAP_ERROR_PTZCONTROL_FAILED                        	:   0x603B,         // 云台控制失败
        NRCAP_ERROR_PTZCONTROL_ERROR			                :   0x603C,         // 控制云台Control命令错误
		
		NRCAP_ERROR_PLAYVODAUDIO_FAILED							:	0x6040,			// 播放点播录像音频失败
		NRCAP_ERROR_PLAYVOD_FAILED								:	0x6041,			// 开始点播失败



		NRCAP_ERROR_STOPVOD_FAILED								:	0x6042,			// 停止点播失败
		NRCAP_ERROR_SETPLAYVODSPEED_FAILED						:	0x6044,			// 设置点播播放速度失败
		NRCAP_ERROR_GETVODSTATUS_FAILED							:	0x6046,			// 获取点播状态失败 
		
		NRCAP_ERROR_CREATE_DOWNLOAD_OBJECT_ERROR				:	0x6101,			// 创建download对象失败
		NRCAP_ERROR_DOWNLOAD_PARAMS_ERROR						:	0x6103,			// 下载点播文件参数错误
		NRCAP_ERROR_DOWNLOAD_VODPATH_ERROR						:	0x6105,			// 下载点播文件路径错误
		NRCAP_ERROR_DOWNLOAD_VODNAME_ERROR						:	0x6107,			// 下载点播文件名称错误
		NRCAP_ERROR_DOWNLOAD_SAVEFULLPATH_ERROR					:	0x6109,			// 下载点播文件名称保存的全路径错误
		NRCAP_ERROR_DOWNLOAD_OBJECT_NOEXIST						:	0x610B,			// 下载点播对象不存在 

		NRCAP_ERROR_DOWNLOADFILE_FAILED							:	0x610D,			// 下载点播文件失败
        
        NRCAP_ERROR_GETCONFIG_FAILED                            :   0x7000,         // 获取CONFIG命令失败
        NRCAP_ERROR_SETCONFIG_FAILED                            :   0x7001,         // 设置CONFIG命令失败
		
		NRCAP_ERROR_PRESETPOSCONTROL_FAILED						:	0x7010,			// 预置位控制失败 
		NRCAP_ERROR_PRESETPOSCONTROL_PARAM_FAILED				:	0x7013,			// 预置位控制参数出错  

        NRCAP_ERROR_CONFIGVALUELENGTH_BYONDRANGE_ERROR          :   0x7100,         // 配置值长度超出范围 
		NRCAP_ERROR_CONFIGPARAM_ERROR                           :   0x7102,         // 配置参数出错
		NRCAP_ERROR_CONFIGCONTROL_FAILED						:	0x7104,			// 配置控制失败
		
		NRCAP_ERROR_PLATFORMSTORAGE_GETPLAN_FAILED				:	0x7301,			// 获取平台存储计划失败 
		NRCAP_ERROR_PLATFORMSTORAGE_SETPLAN_FAILED				:	0x7303,			// 设置平台存储计划失败 
		NRCAP_ERROR_PLATFORMSTORAGE_DELPLAN_FAILED				:	0x7305,			// 删除平台存储计划失败 
		NRCAP_ERROR_PLATFORMSTORAGE_GETPLANRES_FAILED			:	0x7307,			// 获取平台存储计划资源失败 
		NRCAP_ERROR_PLATFORMSTORAGE_ADDRESTOPLAN_FAILED			:	0x7309,			// 添加平台存储计划资源失败 
		NRCAP_ERROR_PLATFORMSTORAGE_REMOVERESFROMPLAN_FAILED	:	0x7311,			// 删除平台存储计划资源失败 
		NRCAP_ERROR_PLATFORMSTORAGE_GETALLPLANNAMES_FAILED		:	0x7313,			// 获取所有平台存储计划名失败 
		
		NRCAP_ERROR_PLATFORMLA_GETPLAN_FAILED					:	0x7401,			// 获取平台联动计划失败 
		NRCAP_ERROR_PLATFORMLA_SETPLAN_FAILED					:	0x7403,			// 设置平台联动计划失败 
		NRCAP_ERROR_PLATFORMLA_DELPLAN_FAILED					:	0x7405,			// 删除平台联动计划失败 
		NRCAP_ERROR_PLATFORMLA_GETPLANRES_FAILED				:	0x7407,			// 获取平台联动计划资源失败 
		NRCAP_ERROR_PLATFORMLA_GETPLANEVENT_FAILED				:	0x7409,			// 获取平台联动计划事件源失败 
		NRCAP_ERROR_PLATFORMLA_ADDEVENTTOPLAN_FAILED			:	0x7411,			// 添加平台联动计划事件源失败 
		NRCAP_ERROR_PLATFORMLA_REMOVEEVENTFROMPLAN_FAILED		:	0x7413,			// 删除平台联动计划事件源失败 
		NRCAP_ERROR_PLATFORMLA_GETPLANACTION_FAILED				:	0x7415,			// 获取平台联动计划事件源失败 
		NRCAP_ERROR_PLATFORMLA_ADDACTIONTOPLAN_FAILED			:	0x7417,			// 添加平台联动计划事件源失败 
		NRCAP_ERROR_PLATFORMLA_REMOVEACTIONFROMPLAN_FAILED		:	0x7419,			// 删除平台联动计划事件源失败  
		
		NRCAP_ERROR_CALLORTALKCHANNEL_HOT						:	0x9001,			// 喊话或对讲通道非空闲

		NRCAP_ERROR_STARTCALLORTALK_EXISTS						:	0x9003,			// 喊话或对讲已存在
		NRCAP_ERROR_STARTCALLORTALK_FAILED						:	0x9005,			// 开启喊话或对讲失败 
		NRCAP_ERROR_GETCALLORTALKSTATUS_FAILED					:	0x9007,			// 获取喊话或对讲通道状态失败

		NRCAP_ERROR_STOPCALLORTALK_FAILED						:	0x9009,			// 停止喊话或对讲失败

		 
        /*
         *	函数名		：ShowErrorMessage
         *	函数功能	：获取错误描述信息  
         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2008年11月14日 
         *	返回值		：返回错误描述信息 
         *	参数说明	：1个参数 
         *		Number errorCode        错误码; 
         */
        ShowMessage:function(errorCode)
        {
            var rv = "";
            switch(parseInt(errorCode))
            {
			  case 0xFFFFFFFE:
				rv = (Nrcap2.language == "Chinese" ? "登陆平台地址端口错误" : " platform IP:Port error");
                break;
			  case 0xFFFFFED3:
				rv = (Nrcap2.language == "Chinese" ? "用户名或企业ID错误" : " username or epid error");
                break;
			  case 0xFFFFFECE:
				rv = (Nrcap2.language == "Chinese" ? "密码错误" : " password error");
				break;
			  case 0x1000: 
				rv = (Nrcap2.language == "Chinese" ? "未知类型异常" : " unknown exception");
                break;
			  case 0x1002:
				rv = (Nrcap2.language == "Chinese" ? "连接已存在" : " connection already exists");
                break;
              case 0x6000:
                rv = (Nrcap2.language == "Chinese" ? "初始化Nrcap2对象失败" : " initialization Nrcap2 failed");
                break;
              case 0x6001:
                rv = (Nrcap2.language == "Chinese" ? "Nrcap2为空" : " Nrcap2 is null");
                break;
              case 0x6010:
                rv =  (Nrcap2.language == "Chinese" ? "初始化连接对象失败" : " initialization connecting object failed");
                break;
              case 0x6011:
                rv =  (Nrcap2.language == "Chinese" ? "新创建连接ID已经存在" : " connection id already exists");
                break;
              case 0x6012:
                rv =  (Nrcap2.language == "Chinese" ? "连接失败" : " connection failed ");
                break;
              case 0x6013:
                rv =  (Nrcap2.language == "Chinese" ? "连接ID不存在" : " connection id is null");
                break;
              case 0x6014:
                rv =  (Nrcap2.language == "Chinese" ? "删除一个连接对象失败" : " delete a connection object failed ");
                break;
              case 0x6016:
                rv =  (Nrcap2.language == "Chinese" ? "连接服务器参数错误" : " connection params failed ");
                break;
              case 0x6020:
                rv =  (Nrcap2.language == "Chinese" ? "获取资源失败" : " get resource failed");
                break;
              case 0x6021:
                rv =  (Nrcap2.language == "Chinese" ? "对资源排序失败" : " sort resource failed");
                break;
			  case 0x6022:
                rv =  (Nrcap2.language == "Chinese" ? "PUID格式不正确" : " puid format error");
                break;
			  case 0x6024:
                rv =  (Nrcap2.language == "Chinese" ? "获取有存储文件日期失败" : " fetch storage file date failed");
                break;
			  case 0x6026:
                rv =  (Nrcap2.language == "Chinese" ? "获取某日期下文件失败" : " fetch storage file failed");
                break; 
              case 0x6030:
                rv =  (Nrcap2.language == "Chinese" ? "初始化视频窗口失败" : " initialization window failed");
                break;
              case 0x6031:
                rv =  (Nrcap2.language == "Chinese" ? "视频窗口不存在" : " window is null");
                break;
              case 0x6032:
                rv =  (Nrcap2.language == "Chinese" ? "播放视频失败" : " play video failed");
                break;
              case 0x6034:
                rv =  (Nrcap2.language == "Chinese" ? "资源树上查找节点失败" : " search node failed ");
                break;
			  case 0x6035:
                rv =  (Nrcap2.language == "Chinese" ? "资源树查找资源" : " search resource failed ");
                break;
              case 0x6036:
                rv =  (Nrcap2.language == "Chinese" ? "视频没有再播放" : " video has stopped"); 
                break;
              case 0x6037:
                rv =  (Nrcap2.language == "Chinese" ? "视频窗口不存在" : " window is null");
                break;
              case 0x6038:
                rv =  (Nrcap2.language == "Chinese" ? "录像失败" : " record failed");
                break;
              case 0x6039:
                rv =  (Nrcap2.language == "Chinese" ? "抓拍失败" : " snapshot failed");
                break;
			  case 0x603A:
                rv =  (Nrcap2.language == "Chinese" ? "播放音频失败" : " play audio failed");
                break;
			  case 0x603B:
                rv =  (Nrcap2.language == "Chinese" ? "云台控制失败" : " ptz control failed");
                break;
			  case 0x603C:
                rv =  (Nrcap2.language == "Chinese" ? "控制云台Control命令错误" : " ptz config error");
                break;
              case 0x6040:
                rv =  (Nrcap2.language == "Chinese" ? "播放点播录像音频失败" : " play vod audio failed");
                break;
			  case 0x6042:
                rv =  (Nrcap2.language == "Chinese" ? "停止点播失败" : " stop vod failed");
                break; 
			  case 0x6044:
                rv =  (Nrcap2.language == "Chinese" ? "设置点播播放速度失败" : " set play vod speed failed");
                break;
			  case 0x6046:
                rv =  (Nrcap2.language == "Chinese" ? "获取点播状态失败" : " get play vod status failed");
                break;
              case 0x8001:
                rv =  (Nrcap2.language == "Chinese" ? "NC未加载" : " NC without loading ");
                break;
              case 0x8002:
                rv =  (Nrcap2.language == "Chinese" ? "NM未加载" : " NM without loading");
                break;
              case 0x8003:
                rv =  (Nrcap2.language == "Chinese" ? "BSP未加载" : " BSP without loading");
                break;
              case 0x8004:
                rv =  (Nrcap2.language == "Chinese" ? "BSC未加载" : " BSC without loading");
                break;
              case 0x8005:
                rv =  (Nrcap2.language == "Chinese" ? "DW未加载" : " DW without loading");
                break;
              case 0x8011:
                rv =  (Nrcap2.language == "Chinese" ? "NA未加载" : " NA without loading");
                break; 
			
			  case 0x9001:
                rv =  (Nrcap2.language == "Chinese" ? "喊话或对讲通道非空闲" : " call or talk channel not free");
                break;
              case 0x9003:
                rv =  (Nrcap2.language == "Chinese" ? "喊话或对讲已存在" : " call or talk has exists");
                break;
              case 0x9005:
                rv =  (Nrcap2.language == "Chinese" ? "开启喊话或对讲失败" : " start call or talk failed");
                break;
              case 0x9007:
                rv =  (Nrcap2.language == "Chinese" ? "获取喊话或对讲通道状态失败" : " get call or talk channel status failed");
                break; 
			  case 0x9009:
                rv =  (Nrcap2.language == "Chinese" ? "停止喊话或对讲失败" : " stop call or talk failed");
                break; 	
				
              default:
                rv = (Nrcap2.language == "Chinese" ? "发生错误("+(errorCode)+")" : " error(code:"+(errorCode)+")");
                break;
            }  
            return rv;
        }
    },
    
    /*
     *	对象名		：Debug
     *	功能    	：调试对象



	 *	备注		：无
     *	作者		：Lingsen
     *	时间		：2010年11月26日. 
     */
    Debug:{
        message:new Array(),        /* 调试信息数据 */
        callback:null,              /* 调试信息输出回调函数 */    
        /*
         *	函数名		：Init
         *	函数功能	：初始化Nrcap2调试信息对象
         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2010年11月26日 
         *	返回值		：无
         *	参数说明	：1个参数/
         *  Nrcap2.Struct.InitParamStruct   param    设置调试参数
         */
        Init:function(param)
        {
            if (typeof param != "undefined" && typeof param.debug != "undefined" && param.debug === true)
            {
                Nrcap2.debug = true;
            }
            else
            {
                Nrcap2.debug = false;
            } 
            if (typeof param != "undefined" && typeof param.debugCallback == "function")
            {
                Nrcap2.Debug.callback = param.debugCallback;
            }
        },
        
         /*
         *	函数名		：Write
         *	函数功能	：输出调试信息 
         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2010年11月26日 
         *	返回值		：无
         *	参数说明	：1个参数/ 
         *  Object  message  调试信息对象[fn:函数名,msg:描述]
         */
        Write:function(message)
        {
            message.time = Nrcap2.Utility.DateFormat();
            var msg = new Nrcap2.Struct.DebugMessageStruct(message.time,message.fn,message.msg);
            
            if (Nrcap2.debug)
            {
                Nrcap2.Debug.message.push(msg);
                if (typeof Nrcap2.Debug.callback == "function")
                {
                    Nrcap2.Debug.callback(msg);
                }
            }
            return Nrcap2.NrcapError.NRCAP_SUCCESS;
        },
        
         /*
         *	函数名		：Clear
         *	函数功能	：清除调试信息记录 
         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2010年11月26日 
         *	返回值		：无
         *	参数说明	：2个参数/  
         *	number start    调试信息记录开始索引 
         *	number offset   调试信息记录结束索引
         */
        Clear:function(start,offset)
        {
            if (typeof start != "undefined" && parseInt(start) > 0)
            {
                start = parseInt(start);
                if (start > Nrcap2.Debug.message.length)
                {
                    return false;
                }
            }
            else
            {
                start = 0;
            }
            if (typeof offset != "undefined" && parseInt(offset) > 0)
            {
                offset = parseInt(offset);
                if (offset > Nrcap2.Debug.message.length)
                {
                    offset = Nrcap2.Debug.message.length;
                }
            }
            else
            {
                offset = 0;
            }
            Nrcap2.Debug.message.splice(start,offset);
        },
        
         /*
         *	函数名		：GetLastMessage
         *	函数功能	：获取最新一条调试信息记录.   
         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2010年11月26日 
         *	返回值		：无
         *	参数说明	：无
         */
        GetLastMessage:function()
        {
            var lastIndex = Nrcap2.Debug.message.length;
            return lastIndex > 0 ? Nrcap2.Debug.message[lastIndex-1] : "";
        },
        end:true
    },
	end:true
};

/**folder********************************************************************************************************/
/**
* WebClient 中外合资创世科技版权所有  
* FileName.......: folder.js
* Project........: WebClient
* CreateBy.......: huzw
* Create DateTime: 2010/11/09 11:30:00 $
* 功能...........: 操作文件(夹) 
*/

var Folder = {
    debug: 0, // 是否开启调试，为0关闭，其他值开启  
    pluginConfigFileName: "WebClientPlugin.ini",
	contentCookie:{
		localsnapshotpath : "",
		localrecordpath : "",
		downloadpicturepath : "",
		downloadrecordpath : ""
	},
	
    /* 系统启动根目录(默认值) */
    systemRoot: "C:/WINDOWS/system32/",
	 
    Plug:{
        init: false,
        fd: null   // 指向folder插件
    },
    
    /* object */
    PlugHtml:{
        fd: "<OBJECT id=\"@id\" name=\"@name\" CLASSID=\"CLSID:4363764D-D7D9-4EC5-A17D-F42A5A6E3926\" style=\"display:none;\" codebase=\"CreMedia7Nrcap2ATL.zip#version=1,0,11,514\"></OBJECT>",
        
        get:function(objname){
            var htmlstr = "";
            switch(objname){
                case "fd":
                    htmlstr = this.fd;
                    break;
                default:
                    break;
            } 
            return htmlstr;
        },
        
        end:true
    },
    
    /* 初始化插件,成功0，失败-1 */
    Init:function(debug)
    {
       try
       {
            /* 加载插件 */
            var fd = Folder.PlugHtml.get("fd").replace("id=\"@id\" name=\"@name\"","id=\"FolderAssistant\" name=\"FolderAssistant\"");
            
            if(!document.getElementById("FolderPlugBox"))
            {
                var objFolderPlugBox = document.createElement("DIV");
                objFolderPlugBox.setAttribute("id","FolderPlugBox");
                document.getElementsByTagName("body").item(0).appendChild(objFolderPlugBox);
            }
			else
			{
				objFolderPlugBox = document.getElementById("FolderPlugBox");
			}
            objFolderPlugBox.style.display = "none";
            objFolderPlugBox.innerHTML = fd; 
            /* 检测插件是否加载完成 */
            if(typeof FolderAssistant.DebugSwitch == "undefined")
            {
                return -1;
            }
            else
			{    
				Folder.Plug.init = true;
				Folder.Plug.fd = FolderAssistant;
				
                /* 是否开启调试功能 */
                Folder.debug = (typeof debug != "undefined" && debug == true ? true : false);
                Folder.DebugSwitch(Folder.debug);
				
				/* 获取系统启动根目录,暂时不用 */
				Folder.systemRoot = Folder.Plug.fd.GetSystemRoot();
				 
				var rv = Folder.ReadConfigFile(); // alert(rv);
				if(rv == -1)
				{
					return rv;
				}
			}
            return 0;
       }
       catch(e)
       {
            return -1;
       }
    },
    
	/* 读配置文件 */
	ReadConfigFile:function(){
		try
		{
            var fileAllName = Folder.systemRoot + "/" + Folder.pluginConfigFileName;
			var contentStr = Folder.Plug.fd.ReadFile(fileAllName); // alert(contentStr);
			var contentArr = contentStr.split("\r\n").compact().without(""); // alert(Object.toJSON(contentArr));
		 
		 	var checkVersion = false, exception = false, i = 0;
			contentArr.each(
				function(item, index){
					var nodes = item.split("="); // alert(nodes[0].toLowerCase());
					
					var nodeValue = nodes[1]; 
					if(!nodeValue || typeof nodeValue == "undefined")
					{
						nodeValue = "";
					}
					
					switch(nodes[0].toLowerCase())
					{
						case 'localsnapshotpath':
							Folder.contentCookie.localsnapshotpath = nodeValue;
							break;
						case 'localrecordpath':
							Folder.contentCookie.localrecordpath = nodeValue;
							break;
						case 'downloadpicturepath':
							Folder.contentCookie.downloadpicturepath = nodeValue;
							break;
						case 'downloadrecordpath':
							Folder.contentCookie.downloadrecordpath = nodeValue;
							break;
						default:
							break; 
					}
				}	
			);
			return Folder.contentCookie;
		}
		catch(e)
		{
			return -1;	
		}
	},
	
	/* 写配置文件 */
	WriteConfigFile:function(contentArr,flag){
		try
		{ 
			if(contentArr == null || typeof contentArr == "undefined")
			{
				return -1;	
			}
			else
			{
				if(flag == null || typeof flag == "undefined")
				{
					flag = 0;
				} 
				 
				var contentStr = "";
				
				if(typeof contentArr == "object" && flag == 0)
				{
					contentStr += "[clientSavePath]\r\n";
					
					if(contentArr.localsnapshotpath != null && typeof contentArr.localsnapshotpath != "undefined")
					{
						contentStr += "localsnapshotpath=" + contentArr.localsnapshotpath + "\r\n";
					}
					else
					{
						var localsnapshotpath = (this.contentCookie.localsnapshotpath != null && typeof this.contentCookie.localsnapshotpath != "undefined" ? this.contentCookie.localsnapshotpath : "");
						
						contentStr += "localsnapshotpath="+localsnapshotpath+"\r\n";
					}
					if(contentArr.localrecordpath != null && typeof contentArr.localrecordpath != "undefined")
					{
						contentStr += "localrecordpath=" + contentArr.localrecordpath + "\r\n";
					}
					else
					{
						var localrecordpath = (this.contentCookie.localrecordpath != null && typeof this.contentCookie.localrecordpath != "undefined" ? this.contentCookie.localrecordpath : "");
						
						contentStr += "localrecordpath="+localrecordpath+"\r\n";
					}  
					if(contentArr.downloadpicturepath != null && typeof contentArr.downloadpicturepath != "undefined")
					{
						contentStr += "downloadpicturepath=" + contentArr.downloadpicturepath + "\r\n";
					}
					else
					{
						var downloadpicturepath = (this.contentCookie.downloadpicturepath != null && typeof this.contentCookie.downloadpicturepath != "undefined" ? this.contentCookie.downloadpicturepath : "");
						
						contentStr += "downloadpicturepath="+downloadpicturepath+"\r\n";
					} 
					if(contentArr.downloadrecordpath != null && typeof contentArr.downloadrecordpath != "undefined")
					{
						contentStr += "downloadrecordpath=" + contentArr.downloadrecordpath + "\r\n";
					}
					else
					{
						var downloadrecordpath = (this.contentCookie.downloadrecordpath != null && typeof this.contentCookie.downloadrecordpath != "undefined" ? this.contentCookie.downloadrecordpath : "");
						 
						contentStr += "downloadrecordpath="+downloadrecordpath+"\r\n";
					} 
					
					contentStr += "[end]\r\n";
				}
				else
				{
					if(flag = 1)
					{
						contentStr = contentArr.toString();
					}
					else
					{
						return -1;	
					}  
				} // alert(contentStr);
				
				var fileAllName = Folder.systemRoot + "/" + Folder.pluginConfigFileName;
				
				var length = contentStr.length; 
				var blen = 0;
				for(i=0; i<length; i++) {
					if ((contentStr.charCodeAt(i) & 0xff00) != 0)
					{
						blen ++;
					}
					blen ++;
				} 
				length = blen; // 真实长度
				// alert(contentStr.length + "<=" + length);
				
				var rv = Folder.Plug.fd.WriteFile(fileAllName,contentStr,length,flag); // alert(rv); 
				
				if(parseInt(rv) != 0)
				{
					return -1;
				}
				
				return rv;
			} 
		}
		catch(e)
		{
			return -1;
		}
		
	},
	
	/* 读文件 */
	ReadFile:function(fileName){
		try
		{ 
			var rv = Folder.Plug.fd.ReadFile(fileName);  // alert(rv);
			
			if(parseInt(rv) == -1)
			{
				return -1;	
			}
			
			return rv;
		}
		catch(e)
		{
			return -1;	
		}
	},
	
	/* 写文件 */
	WriteFile:function(fileName,content,contentLength,flag){
		try
		{
			var rv = Folder.Plug.fd.WriteFile(fileName,content,contentLength,flag);  // alert(rv);
			
			if(parseInt(rv) != 0)
			{
				return -1;	
			}
			
			return rv;
		}
		catch(e)
		{
			return -1;	
		}
	},
	
    /*是否开启调试功能,参数flag为0关闭，其他值开启*/
    DebugSwitch:function(flag){
        Folder.Plug.fd.DebugSwitch(flag);
    },
    
    /*打开路径设置对话框，成功返回路径，失败-1*/
    GetFileFolder:function(){
        try
        {  
            rv = Folder.Plug.fd.GetFileFolder();
			
            if(rv == null || rv == "")
            {
                rv = -1;
            }
            return rv;
        }
        catch(e)
        {
            return -1;
        } 
    },
    
    /*按文件夹名folderName创建文件夹,成功0，失败-1*/
    CreateFolder:function(folderName){
        try
        { 
            var rv = -1;
            rv = Folder.Plug.fd.CreateDirctory(folderName);
            return rv;
        }
        catch(e)
        {
            return -1;
        } 
    },
    
    /*文件fileName(全路径)是否存在,存在0，不存在-1*/
    FileExist:function(fileName){
        try
        { 
            var rv = -1;
            rv = Folder.Plug.fd.FileExist(fileName);//alert(rv);
            if(rv == 1)
                rv = 0; //存在
            else
                rv = -1;//不存在 
            return rv;
        }
        catch(e)
        {
            return -1;
        } 
    },
    
    /*按文件名fileName(全路径)删除文件,成功0，失败-1*/
    DeleteByFileName:function(fileName){
        try
        {
            var rv = -1;//alert(fileName);
            rv = Folder.Plug.fd.DeleteFile(fileName);
            return rv;
        }
        catch(e)
        {
            return -1;
        }
    
    },
    
    /*删除指定文件夹(folderName)下的所有文件,成功0，失败-1*/
    DeleteAllFiles:function(folderName){
        try
        {
            var rv = -1;
            rv = Folder.Plug.fd.DeleteAllFile(folderName);
            return rv;
        }
        catch(e)
        {
            return -1;
        }
    
    },
    
    end:true

};

/**XML***********************************************************************************************************/

// ========================================================================
//  XML.ObjTree -- XML source code from/to JavaScript object like E4X
// ========================================================================

if ( typeof(XML) == 'undefined' ) XML = function() {};

//  constructor
XML.ObjTree = function () {
    return this;
};

//  class variables
XML.ObjTree.VERSION = "0.24";

//  object prototype
XML.ObjTree.prototype.xmlDecl = '<?xml version="1.0" encoding="UTF-8" ?>\n';
XML.ObjTree.prototype.attr_prefix = '';
XML.ObjTree.prototype.overrideMimeType = 'text/xml';

//  method: parseXML( xmlsource )
XML.ObjTree.prototype.parseXML = function ( xml ) {
    var root;
    if ( window.DOMParser ) {
        var xmldom = new DOMParser();
//      xmldom.async = false;           // DOMParser is always sync-mode
        var dom = xmldom.parseFromString( xml, "application/xml" );
        if ( ! dom ) return;
        root = dom.documentElement;
    } else if ( window.ActiveXObject ) {
        xmldom = new ActiveXObject('Microsoft.XMLDOM');
        xmldom.async = false;
        xmldom.loadXML( xml );
        root = xmldom.documentElement;
    }
    if ( ! root ) return;
    return this.parseDOM( root );
};

//  method: parseHTTP( url, options, callback )
XML.ObjTree.prototype.parseHTTP = function ( url, options, callback ) {
    var myopt = {};
    for( var key in options ) {
        myopt[key] = options[key];                  // copy object
    }
    if ( ! myopt.method ) {
        if ( typeof(myopt.postBody) == "undefined" &&
             typeof(myopt.postbody) == "undefined" &&
             typeof(myopt.parameters) == "undefined" ) {
            myopt.method = "get";
        } else {
            myopt.method = "post";
        }
    }
    if ( callback ) {
        myopt.asynchronous = true;                  // async-mode
        var __this = this;
        var __func = callback;
        var __save = myopt.onComplete;
        myopt.onComplete = function ( trans ) {
            var tree;
            if ( trans && trans.responseXML && trans.responseXML.documentElement ) {
                tree = __this.parseDOM( trans.responseXML.documentElement );
            } else if ( trans && trans.responseText ) {
                tree = __this.parseXML( trans.responseText );
            }
            __func( tree, trans );
            if ( __save ) __save( trans );
        };
    } else {
        myopt.asynchronous = false;                 // sync-mode
    }
    var trans;
    if ( typeof(HTTP) != "undefined" && HTTP.Request ) {
        myopt.uri = url;
        var req = new HTTP.Request( myopt );        // JSAN
        if ( req ) trans = req.transport;
    } else if ( typeof(Ajax) != "undefined" && Ajax.Request ) {
        var req = new Ajax.Request( url, myopt );   // ptorotype.js
        if ( req ) trans = req.transport;
    }
//  if ( trans && typeof(trans.overrideMimeType) != "undefined" ) {
//      trans.overrideMimeType( this.overrideMimeType );
//  }
    if ( callback ) return trans;
    if ( trans && trans.responseXML && trans.responseXML.documentElement ) {
        return this.parseDOM( trans.responseXML.documentElement );
    } else if ( trans && trans.responseText ) {
        return this.parseXML( trans.responseText );
    }
}

//  method: parseDOM( documentroot )
XML.ObjTree.prototype.parseDOM = function ( root ) {
    if ( ! root ) return;

    this.__force_array = {};
    if ( this.force_array ) {
        for( var i=0; i<this.force_array.length; i++ ) {
            this.__force_array[this.force_array[i]] = 1;
        }
    }

    var json = this.parseElement( root );   // parse root node
    if ( this.__force_array[root.nodeName] ) {
        json = [ json ];
    }
    if ( root.nodeType != 11 ) {            // DOCUMENT_FRAGMENT_NODE
        var tmp = {};
        tmp[root.nodeName] = json;          // root nodeName
        json = tmp;
    }
    return json;
};

//  method: parseElement( element )
XML.ObjTree.prototype.parseElement = function ( elem ) {
    //  COMMENT_NODE
    if ( elem.nodeType == 7 ) {
        return;
    }

    //  TEXT_NODE CDATA_SECTION_NODE
    if ( elem.nodeType == 3 || elem.nodeType == 4 ) {
        var bool = elem.nodeValue.match( /[^\x00-\x20]/ );
        if ( bool == null ) return;     // ignore white spaces
        return elem.nodeValue;
    }

    var retval;
    var cnt = {};

    //  parse attributes
    if ( elem.attributes && elem.attributes.length ) {
        retval = {};
        for ( var i=0; i<elem.attributes.length; i++ ) {
            var key = elem.attributes[i].nodeName;
			
            if ( typeof(key) != "string" ) continue;
            var val = elem.attributes[i].nodeValue;
            //if ( ! val ) continue;
			if (typeof val == "undefined" || val == null ) continue;
			
            key = this.attr_prefix + key;
			
			
			if ( typeof(cnt[key]) == "undefined" )
			{
				cnt[key] = 0;
			}
            cnt[key] ++;
            this.addNode( retval, key, cnt[key], val );
        }
    }

    //  parse child nodes (recursive)
    if ( elem.childNodes && elem.childNodes.length ) {
        var textonly = true;
        if ( retval ) textonly = false;        // some attributes exists
        for ( var i=0; i<elem.childNodes.length && textonly; i++ ) {
            var ntype = elem.childNodes[i].nodeType;
            if ( ntype == 3 || ntype == 4 ) continue;
            textonly = false;
        }
        if ( textonly ) {
            if ( ! retval ) retval = "";
            for ( var i=0; i<elem.childNodes.length; i++ ) {
                retval += elem.childNodes[i].nodeValue;
            }
        } else {
            if ( ! retval ) retval = {};
            for ( var i=0; i<elem.childNodes.length; i++ ) {
                var key = elem.childNodes[i].nodeName;
                if ( typeof(key) != "string" ) continue;
                var val = this.parseElement( elem.childNodes[i] );
                if ( ! val ) continue;
                if ( typeof(cnt[key]) == "undefined" ) cnt[key] = 0;
                cnt[key] ++;
                this.addNode( retval, key, cnt[key], val );
            }
        }
    }
    return retval;
};

//  method: addNode( hash, key, count, value )
XML.ObjTree.prototype.addNode = function ( hash, key, cnts, val ) {
    if ( this.__force_array[key] ) {
        if ( cnts == 1 ) hash[key] = [];
        hash[key][hash[key].length] = val;      // push
    } else if ( cnts == 1 ) {                   // 1st sibling
        hash[key] = val;
    } else if ( cnts == 2 ) {                   // 2nd sibling
        hash[key] = [ hash[key], val ];

    } else {                                    // 3rd sibling and more
        hash[key][hash[key].length] = val;
    }
};

//  method: writeXML( tree )
XML.ObjTree.prototype.writeXML = function ( tree ) {
    var xml = this.hash_to_xml( null, tree );
    return this.xmlDecl + xml;
};

//  method: hash_to_xml( tagName, tree )
XML.ObjTree.prototype.hash_to_xml = function ( name, tree ) {
    var elem = [];
    var attr = [];
    for( var key in tree ) {
        if ( ! tree.hasOwnProperty(key) ) continue;
        var val = tree[key];
        if ( key.charAt(0) != this.attr_prefix ) {
            if ( typeof(val) == "undefined" || val == null ) {
                elem[elem.length] = "<"+key+" />";
            } else if ( typeof(val) == "object" && val.constructor == Array ) {
                elem[elem.length] = this.array_to_xml( key, val );
            } else if ( typeof(val) == "object" ) {
                elem[elem.length] = this.hash_to_xml( key, val );
            } else {
                elem[elem.length] = this.scalar_to_xml( key, val );
            }
        } else {
            attr[attr.length] = " "+(key.substring(1))+'="'+(this.xml_escape( val ))+'"';
        }
    }
    var jattr = attr.join("");
    var jelem = elem.join("");
    if ( typeof(name) == "undefined" || name == null ) {
        // no tag
    } else if ( elem.length > 0 ) {
        if ( jelem.match( /\n/ )) {
            jelem = "<"+name+jattr+">\n"+jelem+"</"+name+">\n";
        } else {
            jelem = "<"+name+jattr+">"  +jelem+"</"+name+">\n";
        }
    } else {
        jelem = "<"+name+jattr+" />\n";
    }
    return jelem;
};

//  method: array_to_xml( tagName, array )
XML.ObjTree.prototype.array_to_xml = function ( name, array ) {
    var out = [];
    for( var i=0; i<array.length; i++ ) {
        var val = array[i];
        if ( typeof(val) == "undefined" || val == null ) {
            out[out.length] = "<"+name+" />";
        } else if ( typeof(val) == "object" && val.constructor == Array ) {
            out[out.length] = this.array_to_xml( name, val );
        } else if ( typeof(val) == "object" ) {
            out[out.length] = this.hash_to_xml( name, val );
        } else {
            out[out.length] = this.scalar_to_xml( name, val );
        }
    }
    return out.join("");
};

//  method: scalar_to_xml( tagName, text )
XML.ObjTree.prototype.scalar_to_xml = function ( name, text ) {
    if ( name == "#text" ) {
        return this.xml_escape(text);
    } else {
        return "<"+name+">"+this.xml_escape(text)+"</"+name+">\n";
    }
};

//  method: xml_escape( text )
XML.ObjTree.prototype.xml_escape = function ( text ) {
    return String(text).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
};

/**MD5***********************************************************************************************************/

var MD5 = {
	hexcase : 0,  /* hex output format. 0 - lowercase; 1 - uppercase        */
	b64pad  : "", /* base-64 pad character. "=" for strict RFC compliance   */
	chrsz   : 8,  /* bits per input character. 8 - ASCII; 16 - Unicode      */
	
	Hex_MD5:function (s)
	{
		return MD5.BinlToHex(MD5.Core_MD5(MD5.StrToBinl(s), s.length * MD5.chrsz));
	},
	
	B64_MD5:function(s){ return MD5.BinlToB64(MD5.Core_MD5(MD5.StrToBinl(s), s.length * MD5.chrsz));},
	Str_MD5:function(s){ return MD5.BinlToStr(MD5.Core_MD5(MD5.StrToBinl(s), s.length * MD5.chrsz));},
	Hex_HMac_MD5:function(key, data) { return MD5.BinlToHex(MD5.Core_HMac_MD5(key, data)); },
	B64_HMac_MD5:function(key, data) { return MD5.BinlToB64(MD5.core_HMac_MD5(key, data)); },
	Str_HMac_MD5:function(key, data) { return MD5.BinlToStr(MD5.core_HMac_MD5(key, data)); },
	
	/*
	 * Perform a simple self-test to see if the VM is working
	 */
	MD5_VM_Test:function()
	{
	  return MD5.Hex_MD5("abc") + "==900150983cd24fb0d6963f7d28e17f72";
	},

	/*
	 * Calculate the MD5 of an array of little-endian words, and a bit length
	 */
	Core_MD5:function(x, len)
	{
	  /* append padding */
		x[len >> 5] |= 0x80 << ((len) % 32);
		x[(((len + 64) >>> 9) << 4) + 14] = len;
		
		var a =  1732584193;
		var b = -271733879;
		var c = -1732584194;
		var d =  271733878;
		
		for(var i = 0,max = x.length; i < max; i += 16)
		{
			var olda = a;
			var oldb = b;
			var oldc = c;
			var oldd = d;
			
			a = MD5.MD5_FF(a, b, c, d, x[i+ 0], 7 , -680876936);
			d = MD5.MD5_FF(d, a, b, c, x[i+ 1], 12, -389564586);
			c = MD5.MD5_FF(c, d, a, b, x[i+ 2], 17,  606105819);
			b = MD5.MD5_FF(b, c, d, a, x[i+ 3], 22, -1044525330);
			a = MD5.MD5_FF(a, b, c, d, x[i+ 4], 7 , -176418897);
			d = MD5.MD5_FF(d, a, b, c, x[i+ 5], 12,  1200080426);
			c = MD5.MD5_FF(c, d, a, b, x[i+ 6], 17, -1473231341);
			b = MD5.MD5_FF(b, c, d, a, x[i+ 7], 22, -45705983);
			a = MD5.MD5_FF(a, b, c, d, x[i+ 8], 7 ,  1770035416);
			d = MD5.MD5_FF(d, a, b, c, x[i+ 9], 12, -1958414417);
			c = MD5.MD5_FF(c, d, a, b, x[i+10], 17, -42063);
			b = MD5.MD5_FF(b, c, d, a, x[i+11], 22, -1990404162);
			a = MD5.MD5_FF(a, b, c, d, x[i+12], 7 ,  1804603682);
			d = MD5.MD5_FF(d, a, b, c, x[i+13], 12, -40341101);
			c = MD5.MD5_FF(c, d, a, b, x[i+14], 17, -1502002290);
			b = MD5.MD5_FF(b, c, d, a, x[i+15], 22,  1236535329);
			
			a = MD5.MD5_GG(a, b, c, d, x[i+ 1], 5 , -165796510);
			d = MD5.MD5_GG(d, a, b, c, x[i+ 6], 9 , -1069501632);
			c = MD5.MD5_GG(c, d, a, b, x[i+11], 14,  643717713);
			b = MD5.MD5_GG(b, c, d, a, x[i+ 0], 20, -373897302);
			a = MD5.MD5_GG(a, b, c, d, x[i+ 5], 5 , -701558691);
			d = MD5.MD5_GG(d, a, b, c, x[i+10], 9 ,  38016083);
			c = MD5.MD5_GG(c, d, a, b, x[i+15], 14, -660478335);
			b = MD5.MD5_GG(b, c, d, a, x[i+ 4], 20, -405537848);
			a = MD5.MD5_GG(a, b, c, d, x[i+ 9], 5 ,  568446438);
			d = MD5.MD5_GG(d, a, b, c, x[i+14], 9 , -1019803690);
			c = MD5.MD5_GG(c, d, a, b, x[i+ 3], 14, -187363961);
			b = MD5.MD5_GG(b, c, d, a, x[i+ 8], 20,  1163531501);
			a = MD5.MD5_GG(a, b, c, d, x[i+13], 5 , -1444681467);
			d = MD5.MD5_GG(d, a, b, c, x[i+ 2], 9 , -51403784);
			c = MD5.MD5_GG(c, d, a, b, x[i+ 7], 14,  1735328473);
			b = MD5.MD5_GG(b, c, d, a, x[i+12], 20, -1926607734);
			
			a = MD5.MD5_HH(a, b, c, d, x[i+ 5], 4 , -378558);
			d = MD5.MD5_HH(d, a, b, c, x[i+ 8], 11, -2022574463);
			c = MD5.MD5_HH(c, d, a, b, x[i+11], 16,  1839030562);
			b = MD5.MD5_HH(b, c, d, a, x[i+14], 23, -35309556);
			a = MD5.MD5_HH(a, b, c, d, x[i+ 1], 4 , -1530992060);
			d = MD5.MD5_HH(d, a, b, c, x[i+ 4], 11,  1272893353);
			c = MD5.MD5_HH(c, d, a, b, x[i+ 7], 16, -155497632);
			b = MD5.MD5_HH(b, c, d, a, x[i+10], 23, -1094730640);
			a = MD5.MD5_HH(a, b, c, d, x[i+13], 4 ,  681279174);
			d = MD5.MD5_HH(d, a, b, c, x[i+ 0], 11, -358537222);
			c = MD5.MD5_HH(c, d, a, b, x[i+ 3], 16, -722521979);
			b = MD5.MD5_HH(b, c, d, a, x[i+ 6], 23,  76029189);
			a = MD5.MD5_HH(a, b, c, d, x[i+ 9], 4 , -640364487);
			d = MD5.MD5_HH(d, a, b, c, x[i+12], 11, -421815835);
			c = MD5.MD5_HH(c, d, a, b, x[i+15], 16,  530742520);
			b = MD5.MD5_HH(b, c, d, a, x[i+ 2], 23, -995338651);
			
			a = MD5.MD5_II(a, b, c, d, x[i+ 0], 6 , -198630844);
			d = MD5.MD5_II(d, a, b, c, x[i+ 7], 10,  1126891415);
			c = MD5.MD5_II(c, d, a, b, x[i+14], 15, -1416354905);
			b = MD5.MD5_II(b, c, d, a, x[i+ 5], 21, -57434055);
			a = MD5.MD5_II(a, b, c, d, x[i+12], 6 ,  1700485571);
			d = MD5.MD5_II(d, a, b, c, x[i+ 3], 10, -1894986606);
			c = MD5.MD5_II(c, d, a, b, x[i+10], 15, -1051523);
			b = MD5.MD5_II(b, c, d, a, x[i+ 1], 21, -2054922799);
			a = MD5.MD5_II(a, b, c, d, x[i+ 8], 6 ,  1873313359);
			d = MD5.MD5_II(d, a, b, c, x[i+15], 10, -30611744);
			c = MD5.MD5_II(c, d, a, b, x[i+ 6], 15, -1560198380);
			b = MD5.MD5_II(b, c, d, a, x[i+13], 21,  1309151649);
			a = MD5.MD5_II(a, b, c, d, x[i+ 4], 6 , -145523070);
			d = MD5.MD5_II(d, a, b, c, x[i+11], 10, -1120210379);
			c = MD5.MD5_II(c, d, a, b, x[i+ 2], 15,  718787259);
			b = MD5.MD5_II(b, c, d, a, x[i+ 9], 21, -343485551);
			
			a = MD5.Safe_Add(a, olda);
			b = MD5.Safe_Add(b, oldb);
			c = MD5.Safe_Add(c, oldc);
			d = MD5.Safe_Add(d, oldd);
		}
		return Array(a, b, c, d);
	},
	
	/*
	 * These functions implement the four basic operations the algorithm uses.
	 */
	MD5_CMN:function(q, a, b, x, s, t)
	{
	  return MD5.Safe_Add(MD5.Bit_Rol(MD5.Safe_Add(MD5.Safe_Add(a, q), MD5.Safe_Add(x, t)), s),b);
	},
	MD5_FF:function(a, b, c, d, x, s, t)
	{
	  return MD5.MD5_CMN((b & c) | ((~b) & d), a, b, x, s, t);
	},
	MD5_GG:function(a, b, c, d, x, s, t)
	{
	  return MD5.MD5_CMN((b & d) | (c & (~d)), a, b, x, s, t);
	},
	MD5_HH:function(a, b, c, d, x, s, t)
	{
	  return MD5.MD5_CMN(b ^ c ^ d, a, b, x, s, t);
	},
	MD5_II:function(a, b, c, d, x, s, t)
	{
	  return MD5.MD5_CMN(c ^ (b | (~d)), a, b, x, s, t);
	},
	
	/*
	 * Calculate the HMAC-MD5, of a key and some data
	 */
	Core_HMac_MD5:function(key, data)
	{
	  var bkey = MD5.StrToBinl(key);
	  if(bkey.length > 16) bkey = MD5.Core_MD5(bkey, key.length * MD5.chrsz);
	
	  var ipad = Array(16), opad = Array(16);
	  for(var i = 0; i < 16; i++)
	  {
		ipad[i] = bkey[i] ^ 0x36363636;
		opad[i] = bkey[i] ^ 0x5C5C5C5C;
	  }
	
	  var hash = MD5.Core_MD5(ipad.concat(MD5.StrToBinl(data)), 512 + data.length * MD5.chrsz);
	  return MD5.Core_MD5(opad.concat(hash), 512 + 128);
	},
	
	/*
	 * Add integers, wrapping at 2^32. This uses 16-bit operations internally
	 * to work around bugs in some JS interpreters.
	 */
	Safe_Add:function(x, y)
	{
	  var lsw = (x & 0xFFFF) + (y & 0xFFFF);
	  var msw = (x >> 16) + (y >> 16) + (lsw >> 16);
	  return (msw << 16) | (lsw & 0xFFFF);
	},
	
	/*
	 * Bitwise rotate a 32-bit number to the left.
	 */
	Bit_Rol:function(num, cnt)
	{
	  return (num << cnt) | (num >>> (32 - cnt));
	},
	

	/*
	 * Convert a string to an array of little-endian words
	 * If MD5.chrsz is ASCII, characters >255 have their hi-byte silently ignored.
	 */
	StrToBinl:function(str)
	{
	  var bin = Array();
	  var mask = (1 << MD5.chrsz) - 1;
	  for(var i = 0,max = str.length * MD5.chrsz; i < max; i += MD5.chrsz)
		bin[i>>5] |= (str.charCodeAt(i / MD5.chrsz) & mask) << (i%32);
	  return bin;
	},
	
	/*
	 * Convert an array of little-endian words to a string
	 */
	BinlToStr:function(bin)
	{
	  var str = "";
	  var mask = (1 << MD5.chrsz) - 1;
	  for(var i = 0,max = bin.length * 32; i < max; i += MD5.chrsz)
		str += String.fromCharCode((bin[i>>5] >>> (i % 32)) & mask);
	  return str;
	},
	
	/*
	 * Convert an array of little-endian words to a hex string.
	 */
	BinlToHex:function(binarray)
	{
	  var hex_tab = MD5.hexcase ? "0123456789ABCDEF" : "0123456789abcdef";
	  var str = "";
	  for(var i = 0; i < binarray.length * 4; i++)
	  {
		str += hex_tab.charAt((binarray[i>>2] >> ((i%4)*8+4)) & 0xF) +
			   hex_tab.charAt((binarray[i>>2] >> ((i%4)*8  )) & 0xF);
	  }
	  return str;
	},

	/*
	 * Convert an array of little-endian words to a base-64 string
	 */
	BinlToB64:function(binarray)
	{
	  var tab = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
	  var str = "";
	  for(var i = 0; i < binarray.length * 4; i += 3)
	  {
		var triplet = (((binarray[i   >> 2] >> 8 * ( i   %4)) & 0xFF) << 16)
					| (((binarray[i+1 >> 2] >> 8 * ((i+1)%4)) & 0xFF) << 8 )
					|  ((binarray[i+2 >> 2] >> 8 * ((i+2)%4)) & 0xFF);
		for(var j = 0; j < 4; j++)
		{
		  if(i * 8 + j * 6 > binarray.length * 32) str += MD5.b64pad;
		  else str += tab.charAt((triplet >> 6*(3-j)) & 0x3F);
		}
	  }
	  return str;
	},

	end:true
};
	

