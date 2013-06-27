/**
* NrcapPlugsSDK FOR JavaScript 

* FileName.......: utility.js
* Project........: WebClient6.0SDK
* Create DateTime: jQueryDate: 2010-08-11 11:56:00
*/

String.prototype.trim = function(){return this.replace(/(^\s+)|\s+$/g,"");};

Date.prototype.format = function(mask)
{
    var d = this;    
    var zeroize = function (value, length)
    {
        if (!length) length = 2;
        value = String(value);
        for (var i = 0, zeros = ''; i < (length - value.length); i++)
        {
            zeros += '0';
        }
        return zeros + value;
    };
    
    if (typeof mask == "undefined" || mask == "" || mask == null)
    {
        mask = "yyyy-MM-dd hh:mm:ss";
    }
    return mask.replace(/"[^"]*"|'[^']*'|\b(?:d{1,4}|m{1,4}|yy(?:yy)?|([hHMstT])\1?|[lLZ])\b/g, function($0)
    {
        switch($0)
        {
            case 'd':   return d.getDate();    
            case 'dd':  return zeroize(d.getDate());    
            case 'ddd': return ['Sun','Mon','Tue','Wed','Thr','Fri','Sat'][d.getDay()];    
            case 'dddd':return ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][d.getDay()];    
            case 'M':   return d.getMonth() + 1;    
            case 'MM':  return zeroize(d.getMonth() + 1);    
            case 'MMM': return ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][d.getMonth()];    
            case 'MMMM':return ['January','February','March','April','May','June','July','August','September','October','November','December'][d.getMonth()];
            case 'yy':  return String(d.getFullYear()).substr(2);
            case 'yyyy':return d.getFullYear();
            case 'h':   return d.getHours() % 12 || 12;
            case 'hh':  return zeroize(d.getHours() % 12 || 12);
            case 'H':   return d.getHours();
            case 'HH':  return zeroize(d.getHours());
            case 'm':   return d.getMinutes();
            case 'mm':  return zeroize(d.getMinutes());
            case 's':   return d.getSeconds();
            case 'ss':  return zeroize(d.getSeconds());
            case 'l':   return zeroize(d.getMilliseconds(), 3);
            case 'L':   var m = d.getMilliseconds();
                    if (m > 99) m = Math.round(m / 10);
                    return zeroize(m);
            case 'tt':  return d.getHours() < 12 ? 'am' : 'pm';
            case 'TT':  return d.getHours() < 12 ? 'AM' : 'PM';
            case 'Z':   return d.toUTCString().match(/[A-Z]+$/);
            default:    return $0.substr(1, $0.length - 2);
        }
    });
}; 


;
(
function()
{
	var 
	window = this,	
	_$ = window.$,					// backup prototype framework
	version = "2010.08.10";
	
	var Utility = window.Utility = function() {
		return new Utility.Fn.Init();
	};
	
	Utility.Fn = Utility.prototype = {
		Init:function()
		{
			//alert("start my self frame work!");
		},
		end:true
	};
	
	Utility.NoConflict = function(deep)
	{
		if ( deep )
			window.Utility = _Utility;

		return Utility;
	};
    
    // 时钟
	Utility.Clock = {
		step:1000,                          // 刷新时间间隔
		timer:null,                         // 计时器

		status:false,
		cb:null,                      // 回调方法
		getTimeType:"local",                // 获取时间方法[local : 本地 , server : 服务器端 ]
		getTimeUrl:"",                      // 从服务器端获取时间URL
		calibrationTimeStep:15*60*1000,     // 校准时间步长
		totalDialTimes:0,		
		week:[ "日","一","二","三","四","五","六" ],
		
		Start:function(getTimeType,getTimeUrl,calibrationTimeStep,cb)
		{
		    if(typeof getTimeType != "undefined" && getTimeType != null && getTimeType != "")
		    {
		        this.getTimeType = getTimeType;
		    }
		    
		    if(typeof getTimeUrl != "undefined" && getTimeUrl != null && getTimeUrl != "")
		    {
		        this.getTimeUrl = getTimeUrl;
		    }
		    
		    if(typeof calibrationTimeStep != "undefined"  && calibrationTimeStep != null && calibrationTimeStep != "")
		    {
		        this.calibrationTimeStep = calibrationTimeStep;
		    }
		    
//		    if(typeof cb != "undefined")
//		    {
//		        this.cb = cb;
//		    }
            Utility.Clock.status = true;
		    Utility.Clock.Calibration();
		},
		
		Calibration:function()
		{
		    /* 本地获取时间 */
		    if (Utility.Clock.getTimeType != "server")
		    {
		        Utility.time = new Date();
		        Utility.Clock.Dial();
		    }
		    else
		    {
		        jQuery.ajax
		        (
		         {
			        type:"GET",
			        url:Utility.Clock.getTimeUrl+"&time="+Utility.time,
			        complete:function(rv)
			        {
				        var json = {status:"success",time:Utility.time};
				        
				        try
				        {
					        if(rv.responseText.search("status") != -1 && rv.responseText.search("time") != -1)  var json = eval("("+rv.responseText+")");	
				        }
				        catch(e)
				        {
				            json = {status:"",time:Utility.time};
				        }
				        
				        if (json.status == "success" && typeof json.time != "undefined")
				        {
					        Utility.time.setTime(json.time);
				        }
					    Utility.Clock.Dial();
			        }
		         }
		        );
		    }
		},
		Dial:function()
		{
			Utility.Clock.timer = setInterval
			(
			    function()
			    {
			        Utility.Clock.totalDialTimes = Utility.Clock.totalDialTimes+Utility.Clock.step;
			        Utility.time.setTime(Utility.time.getTime()+Utility.Clock.step);
//			        if (typeof Utility.Clock.cb == "function")
//			        {
//			            Utility.Clock.cb(Utility.time);
//			        }
                    Utility.Clock.EventCallback.Call();
			        if (Utility.Clock.totalDialTimes >= Utility.Clock.calibrationTimeStep)
			        {
			            Utility.Clock.totalDialTimes = 0;
			            clearInterval(Utility.Clock.timer);
			            Utility.Clock.Calibration();
			        }
			    },
			    Utility.Clock.step
			);
		},
		
		EventCallback:{
		    events:new Hash(),
		    Set:function(ev)
		    {
                if (typeof ev == "undefined" || !ev instanceof Utility.Struct.ClockEventStruct)
                {
                    return false;
                }
                
                if (typeof Utility.Clock.EventCallback.events == "undefined")
                {
                    Utility.Clock.EventCallback.events = new Hash();
                }
                
                if(Utility.Clock.EventCallback.events.get(ev.name))
                {
                    return false;
                }
                
                if(!Utility.Clock.EventCallback.events.get(ev.name))
                {
                    Utility.Clock.EventCallback.events.set(ev.name,ev);
                }
                return true;
		    },
		    UnSet:function(evName)
		    {   
                if(Utility.Clock.EventCallback.events.get(evName))
                {
                    Utility.Clock.EventCallback.events.unset(evName);
                }
		    },
		    Clear:function()
		    {
		        Utility.Clock.EventCallback.events = new Hash();
		    },
		    Call:function()
		    {
		        var c = Utility.Clock.totalDialTimes*Utility.Clock.step;
		        for(var i=0,max = Utility.Clock.EventCallback.events.keys().length;i < max;i++)
		        {
		            var ev = Utility.Clock.EventCallback.events.get(Utility.Clock.EventCallback.events.keys()[i]);
		            if ((c % ev.step) == 0 && typeof ev.callback != "undefined" && ev.callback.constructor == Function)
		            {
		                ev.callback(Utility.time);
		                //alert(ev.step+"::"+ev.name);
		            }
		        }
		    }
		},
		
		Stop:function()
		{
            Utility.Clock.status = false;
			clearInterval(Utility.Clock.timer);
		},
		
        // 标准的时间字符串转为时间戳

        DTStrToTimestamp:function(dateStr)
        {
            dateStr = dateStr.trim();
            var d = new Date();
            var patn = /^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-)) (20|21|22|23|[0-1]?\d):[0-5]?\d:[0-5]?\d$/;
            
            if(patn.test(dateStr))
            {
               return new Date(dateStr.substr(0,4),dateStr.substr(5,2),dateStr.substr(8,2),dateStr.substr(11,2),dateStr.substr(14,2),dateStr.substr(17,2)); 
            }
            else
            {
                return d;
            }
        },
    	
	    //日期自动补零程序
        AppendZero:function(n)
	    {
		    return(("00"+ n).substr(("00"+ n).length-2));
	    },
        
        // 标准的时间字符串转为时间戳

        TimestampToDTStr:function(timestamp)
        {
            var d = new Date();
		    try
		    {
        	    d = new Date(timestamp);
		    }
		    catch(e)
		    {
			    d = new Date();
		    }
		    return d.getFullYear()+"-"+Utility.Clock.AppendZero(d.getMonth()+1)+"-"+Utility.Clock.AppendZero(d.getDate())+" "+Utility.Clock.AppendZero(d.getHours())+":"+Utility.Clock.AppendZero(d.getMinutes())+":"+Utility.Clock.AppendZero(d.getSeconds());
        },
	    
        SecondsToTimeStr:function(second,splitChar,returnType)
        {
		    var splitArray = {s:"秒",m:"分钟",h:"小时"};
    		
		    if(typeof splitChar != "undefined" && splitChar != "")
		    {
			    splitArray = {s:"",m:splitChar,h:splitChar};
		    }
		    if(typeof returnType != "undefined" && returnType == "full")
		    {
		    }
		    else
		    {
			    returnType = "";
		    }
    		
            var timeStr = second;
            second = parseInt(second,10);
            if (!second)
            {
                second = 0;
            }
            if (second < 60)
            {
                timeStr = (returnType == "full" ? "0:0:" : "")+ second+splitArray["s"];
            }
            else if(second < 3600)
            {
                var s = (second%60);
                if(s == 0)
                {
                    timeStr = (returnType == "full" ? "0:"+Math.floor(second/60)+splitArray["m"]+":0" : Math.floor(second/60)+splitArray["m"]);
                }
                else
                {
                    timeStr = (returnType == "full" ? "0:" : "") + Math.floor(second/60)+splitArray["m"]+(second%60).toString()+splitArray["s"];
                }
            }
            else
            {
                var m = Math.floor((second%3600)/60);
                var s = Math.floor((second%3600)%60);
    			
			    if(m == 0 && returnType == "full")
			    {
				    m = "0"+splitArray["m"];
			    }
			    else if(m == 0)
			    {
				    m = "";
			    }
			    else
			    {
				    m = Math.floor((second%3600)/60).toString()+splitArray["m"];
			    }
    			
			    if(s == 0 && returnType == "full")
			    {
				    s = "0"+splitArray["s"];
			    }
			    else if(s == 0)
			    {
				    s = "";
			    }
			    else
			    {
				    s = Math.floor((second%3600)%60).toString()+splitArray["s"];
			    }
    			
                timeStr = Math.floor(second/3600)+splitArray["h"]+m+s ;
            }
            return timeStr;
        },
		end:true
	},
    
  
    /*
     *	函数名		：GetPageSize
     *	函数功能	：获取浏览器页面尺寸
     *	备注		：无
     *	作者		：Lingsen
     *	时间		：2010年08月10日

     *	返回值		：返回错误描述信息

     *	参数说明	：0个参数

     *  返回值      :[height,width]
     */
	Utility.GetPageSize = function()
	{
        /*检测浏览器的渲染模式*/
        var body = (document.compatMode&&document.compatMode.toLowerCase() == "css1compat")?document.documentElement:document.body;

        var bodyOffsetWidth = 0;
        var bodyOffsetHeight = 0;
        var bodyScrollWidth = 0;
        var bodyScrollHeight = 0;
        var pageDimensions = [0,0];
       
        pageDimensions[0]=body.clientHeight; 
        pageDimensions[1]=body.clientWidth; 
       
        bodyOffsetWidth=body.offsetWidth;
        bodyOffsetHeight=body.offsetHeight;
        bodyScrollWidth=body.scrollWidth;
        bodyScrollHeight=body.scrollHeight;

        if(bodyOffsetHeight > pageDimensions[0])
        {
            pageDimensions[0]=bodyOffsetHeight;
        }    
       
        if(bodyOffsetWidth > pageDimensions[1])
        {
            pageDimensions[1]=bodyOffsetWidth;
        }    
       
        if(bodyScrollHeight > pageDimensions[0])
        {
            pageDimensions[0]=bodyScrollHeight; 
        }     
       
        if(bodyScrollWidth > pageDimensions[1])
        {
            pageDimensions[1]=bodyScrollWidth;
        }   

        return pageDimensions;
	};
	
    /*
     *	函数名		：Drag
     *	函数功能	：模拟一个拖动层
     *	备注		：无
     *	作者		：Lingsen
     *	时间		：2010年08月10日

     *	返回值		：返回错误描述信息

     *	参数说明	：0个参数

     *  返回值      :Drag对象
     */
	Utility.Drag  = function()
	{
		this.dragBar = null;
		this.dragBox = null;
		this.startX = 0;
		this.startY = 0;
		
		this.StartDrag = function(dragBar,dragBox,dragSize,ChildWindow)
		{
			
		    try
		    {
			    if(!document.getElementById(dragBar) || !document.getElementById(dragBox))
			    {
				    return false;
			    }
    			
    			
			    this.dragBar = document.getElementById(dragBar);
			    this.dragBox = document.getElementById(dragBox);
			    var self = this;
    			
			    this.dragBar.onmousedown=function(a)
			    {
				    var d=ChildWindow.document;
				    if(!a)a=ChildWindow.event;
    				
				    var x=a.layerX?a.layerX:a.offsetX,y=a.layerY?a.layerY:a.offsetY;
    				
				    self.startX = x;
				    self.startY = y;
    				
				    if(self.dragBox.setCapture)self.dragBox.setCapture();
				    else if(ChildWindow.captureEvents)
    				
				    ChildWindow.captureEvents(Event.MOUSEMOVE|Event.MOUSEUP);
    				
				    d.onmousemove=function(a)
				    {
					    if(!a)a=ChildWindow.event;
					    if(!a.pageX)a.pageX=a.clientX;
					    if(!a.pageY)a.pageY=a.clientY;
					    var tx=a.pageX-self.startX,ty=a.pageY-self.startY;
    					
					    self.dragBox.style.left=(tx<dragSize[0]?dragSize[0]:tx>dragSize[1]?dragSize[1]:tx)+"px";
					    self.dragBox.style.top=(ty<dragSize[2]?dragSize[2]:ty>dragSize[3]?dragSize[3]:ty)+"px";	
    					
				    };
				    d.onmouseup=function()
				    {
					    if(self.dragBox.releaseCapture)
					    {
						    self.dragBox.releaseCapture();
					    }
					    else if(ChildWindow.captureEvents)
					    {
						    ChildWindow.captureEvents(Event.MOUSEMOVE|Event.MOUSEUP);
					    }
					    d.onmousemove=null;
					    d.onmouseup=null;
				    };
    						
			    };
			    this.dragBox.onmousedown=function(){return true;};
			}
			catch(e)
			{
			}
		}
	};
  
    /*
     *	函数名		：ClosePad
     *	函数功能	：关闭一个Pad层,实际就是设置其dispaly属性为none
     *	备注		：无
     *	作者		：Lingsen
     *	时间		：2010年08月10日

     *	返回值		：返回错误描述信息

     *	参数说明	：1个参数

     *      string padId            pad层的id
     */	
	Utility.ClosePad = function(padId)
	{
        if (document.getElementById(padId)) document.getElementById(padId).style.display = "none";
	};  
	
    /*
     *	函数名		：Debug
     *	函数功能    ：跟踪程序错误,状态信息,并且可以输出到指定的窗口内

     *	备注		：无
     *	作者		：Lingsen
     *	时间		：2010年08月10日

     */
    Utility.Debug = function(debugParam)
    {
        if (typeof debugParam == "undefined" || !debugParam instanceof Utility.Struct.DebugParamStruct)
        {
            debugParam = new Utility.Struct.DebugParamStruct();
        }
        
        this.debug = debugParam.debug;
        this.type = (debugParam.style == "watch" ? "watch" : "");
        this.watchWndPosition = debugParam.watchWndPosition;
        
        this.displayContainerId = null;
        /*
         *	函数名		：Note
         *	函数功能	：输出调试信息

         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2010年08月10日

         *	返回值		：返回错误描述信息

         *	参数说明	：1个参数

         *      string message      调试信息
         */	
        this.Note = function(message)
        {
            var msg = {time:(new Date()).format(),fn:"undefined",msg:""};
            if (typeof message == "object")
            {
                msg.time = (typeof message.time != "undefined" ? message.time : msg.time);
                msg.fn = (typeof message.time != "undefined" ? message.fn : msg.fn);
                msg.msg = (typeof message.time != "undefined" ? message.msg : msg.msg);
               
            }
            else if(typeof message == "string")
            {
                msg.msg = message;
            }
            else if (typeof message != "undefined")
            {
                msg.msg = message.toString();
            }
            
            var msgstr = "["+msg.time+"]";
            msgstr += "["+msg.fn+"]";
            msgstr += ":"+msg.msg;  
           // alert(msgstr + "****************");
            if(this.debug)
            {
                switch(this.type)
                {
                    case "watch":
                        this.WriteWatchWnd(msgstr);
                        break;
                    default:
                        alert(msgstr);
                    break;
                }
            }
            return true;
        };
        
        /*
         *	函数名		：Close
         *	函数功能	：关闭调试窗口

         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2010年08月10日

         *	返回值		：返回错误描述信息

         *	参数说明	：0个参数

         */
        this.Close = function()
        {
            if (document.getElementById("debugWatchWnd")) document.getElementById("debugWatchWnd").style.display = "none";
        };
        
        /*
         *	函数名		：CreateWatchWnd
         *	函数功能	：创建跟踪调试信息窗口

         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2010年08月10日

         *	返回值		：返回错误描述信息

         *	参数说明	：0个参数

         */
        this.CreateWatchWnd = function()
        {
            var htmlstr = "";
            htmlstr += "<div class=\"padtitle\"><div class=\"titleleft\"></div><div id=\"debugWatchWndDragbar\" class=\"titlecontent\" style=\"width:370px;\">调试信息</div><div class=\"titleclose4\" onmouseover=\"this.className='titleclose1';\" onmouseout=\"this.className='titleclose4';\" onclick=\"Utility.ClosePad('debugWatchWnd');\"  ></div></div>";
            htmlstr += "<div class=\"padcontent\" style=\"color:#FFFFFF;padding:0px;\"><textarea wrap=\"off\"  name=\"debugWatchMessageList\" id=\"\" style=\"width:97%;height:165px;\"></textarea>";
            
			var objbody = document.getElementsByTagName("body").item(0);
			
			var objWatchWnd = document.createElement("div");
			objWatchWnd.setAttribute('id','debugWatchWnd');
			
			objWatchWnd.style.height = "180";
			objbody.appendChild(objWatchWnd);
			objWatchWnd.style.position="absolute";
			objWatchWnd.style.top=this.watchWndPosition.top;
			objWatchWnd.style.left=this.watchWndPosition.left;
			
			objWatchWnd.style.zIndex="99999";
			objWatchWnd.style.width="400";
			objWatchWnd.innerHTML = htmlstr;
			
			var pad = new Utility.Drag();
			var pageSize = Utility.GetPageSize();
			pad.StartDrag("debugWatchWndDragbar","debugWatchWnd",[0,pageSize[0],0,pageSize[1]],window);
			
        };
        
        /*
         *	函数名		：WriteWatchWnd
         *	函数功能	：在跟踪调试信息窗口输出调试信息
         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2010年08月10日

         *	返回值		：返回错误描述信息

         *	参数说明	：1个参数

         *      string message      调试信息
         */
        this.WriteWatchWnd = function(msg)
        {
            if (!document.getElementById("debugWatchWnd")) this.CreateWatchWnd();
      
            if (document.getElementById("debugWatchWnd") && document.getElementById("debugWatchMessageList"))
            {
                document.getElementById("debugWatchWnd").style.display = "block";
                document.getElementById("debugWatchMessageList").value = msg+"\r\n"+document.getElementById("debugWatchMessageList").value;
            }
        };
        
        if (this.debug === true && this.type == "watch")
        {
            this.CreateWatchWnd();
        }
    };
     
	
    /*
     *	对象名		：Struct
     *	对象功能    ：定义各种数据结构

     *	备注		：无
     *	作者		：Lingsen
     *	时间		：2010年08月10日

     */
    Utility.Struct = 
    {
        /*
         *	函数名		：DebugParamStruct
         *	函数功能	：定义创建调试对象参数结构

         *	备注		：无
         *	作者		：Lingsen
         *	时间		：2010年08月10日

         *	返回值		：返回错误描述信息

         *	参数说明	：2个参数

         *      string message          是否开始调试状态

         *      string style            调试信息输出方式
         *      object watchWndPosition 高度信息窗口显示的位置{left:0,top:0}
         */
        DebugParamStruct:function(debug,style,watchWndPosition)
        {
            this.key = "DebugParamStruct";
            this.debug = (typeof debug != "undefined" && debug === true ? true :false);
            this.style = (typeof style != "undefined" ? style :"");
            this.watchWndPosition = {top:0,left:0};
            this.watchWndPosition.top = (typeof watchWndPosition == "object" && !isNaN(watchWndPosition.top)  ? parseInt(watchWndPosition.top) : 0);
            this.watchWndPosition.left = (typeof watchWndPosition == "object" && !isNaN(watchWndPosition.left)  ? parseInt(watchWndPosition.left) : 0);
        },
        
        ClockEventStruct:function(name,step,callback)
        {
            this.name = (typeof name != "undefined" ? name :"clockEvent"+new Date().getTime());
            this.step = (typeof step != "undefined" && !isNaN(parseInt(step,10)) ? parseInt(step,10) :15000);
            this.callback = (typeof callback != "undefined" && callback.constructor == Function ? callback : function(){return;});
        },
        end:true
    };
}
)();

/* cookie class*/
var Cookie = {
    CookieEnable:function()
    {    
	    var result=false;    	 
	    if(navigator.cookiesEnabled) 
		    return true;    	
	    document.cookie = "testcookie=yes;"; 
	    var cookieSet = document.cookie;     	
	    if (cookieSet.indexOf("testcookie=yes") > -1) 
		    result=true;     	
	    document.cookie = "";     	
	    return result; 
    },
        
    GetCookieVal:function(offset)
    {
        var endstr = document.cookie.indexOf(";",offset);
        if (endstr == -1)
        {
            endstr = document.cookie.length;
        }
        return unescape(document.cookie.substring(offset,endstr));
    },
    
    GetCookie:function(name)
    {
        var arg = name + "=";
        var alen = arg.length;
        var clen = document.cookie.length;
        var i= 0;
        while (i<clen)
        {
            var j = i+alen;
            
            if (document.cookie.substring(i,j) == arg)
            {
                return this.GetCookieVal(j);
            }
            i = document.cookie.indexOf(" ",i)+1;
            if(i==0) break;
        }
        return null;    
    },
    
    SetCookie:function(name,value)
    {
        var argv = arguments;
        var argc = arguments.length;
        var expires = new Date();
        if(2<argc)
        {
            expires = argv[2];
        }
        else
        {
	        expires.setTime(expires.getTime()+(24*60*60*1000*365));	        
        }
        var path = (3<argc)?argv[3]:null;
        var domain = (4<argc)?argv[4]:null;
        var secure = (5<argc)?argv[5]:null;
        document.cookie = name+"="+escape(value)+((expires == null)?" ":(";expires ="+expires.toGMTString()))+((path == null)?"  ":(";path = "+path))+((domain == null)?" ":(";domain =" +domain)) +((secure==true)?";secure":" ");
    },
    
    DelCookie:function(name)
    {
        var exp = new Date();
        exp.setTime (exp.getTime() - 1);
        var cval = this.GetCookie(name);
        document.cookie = name + "=" + cval + "; expires="+ exp.toGMTString();
    }
}
