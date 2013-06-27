/**
* CreMedia7.0平台Web监控系统
* FileName.......: utility.js
* Project........: AnHuiQiXiang7.0
* Create DateTime: 2010/04/12 14:55:00 $
*/

var Utility = {
    version:"2010.04.09",
	time:new Date(),
	guidRex : /^[a-z0-9]{34}$/i,
	
	test:function()
	{
		return false;
	},	
	
    // 获取浏览器窗口大小
    GetScreenSize:function()
    {
        var w = (window.innerWidth) ? window.innerWidth : (document.documentElement && document.documentElement.clientWidth) ? document.documentElement.clientWidth : document.body.offsetWidth;
        var h = (window.innerHeight) ? window.innerHeight : (document.documentElement && document.documentElement.clientHeight) ? document.documentElement.clientHeight : document.body.offsetHeight;
        return {w:w,h:h};  
    },
    
    // 生成一个随机色
    RandomColor:function()
    {
    	//16进制方式表示颜色0-F	
    	var arrHex = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];
    	var strHex = "0x";
    	var index;
    	for(var i = 0; i < 6; i++)
    	{
    	    //取得0-15之间的随机整数

    	    index = Math.round(Math.random() * 15);
    	    strHex += arrHex[index];
    	}
    	return strHex;
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
		return d.getFullYear()+"-"+Utility.AppendZero(d.getMonth()+1)+"-"+Utility.AppendZero(d.getDate())+" "+Utility.AppendZero(d.getHours())+":"+Utility.AppendZero(d.getMinutes())+":"+Utility.AppendZero(d.getSeconds());
    },
	
	//日期自动补零程序
    AppendZero:function(n)
	{
		return(("00"+ n).substr(("00"+ n).length-2));
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
    
    // 时钟
	Clock:{
		step:1000,                          // 刷新时间间隔
		timer:null,                         // 计时器

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
		    
		    if(typeof cb != "undefined")
		    {
		        this.cb = cb;
		    }
		    Utility.Clock.Calibration();
		
		},
		Calibration:function()
		{
		    // 本地获取时间
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
			            //alert(rv.responseText);
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
			        if (typeof Utility.Clock.cb == "function")
			        {
			            Utility.time.setTime(Utility.time.getTime()+Utility.Clock.step);
			            Utility.Clock.cb(Utility.time);
			        }
			        
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
		TimeFormat:function(time)
		{
		    if (typeof time == "undefined")
		    {
		        time = new Date().getTime();
		    }
		    if(jQuery.browser.safari)
			{
				return time.getFullYear()+"年"+time.getMonth()+"月"+time.getDate()+"日"+time.toLocaleTimeString()+"&nbsp;星期"+Utility.Clock.week[time.getDay()]+"&nbsp;";

			}
			else
			{
		        return time.toLocaleString()+"&nbsp;星期"+Utility.Clock.week[time.getDay()]+"&nbsp;";
		    }		    
		},
		Stop:function()
		{
			clearInterval(Utility.Clock.timer);
		},
		end:true
	},
	MACToGUID:function(mac)
	{
	    var guid = "";
	    if (mac.length > 8)
	    {
	        // 出后8位

	        guid = "0x030500000100000000000000"+mac.substring(mac.length-8);
	    }
	    
	    if(Utility.guidRex.test(guid))
	    {
	        return guid;
	    }
	    else
	    {
	        return mac;
	    }
	},
    end:true
}