/**
* CreMedia7.0ƽ̨Web���ϵͳ
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
	
    // ��ȡ��������ڴ�С
    GetScreenSize:function()
    {
        var w = (window.innerWidth) ? window.innerWidth : (document.documentElement && document.documentElement.clientWidth) ? document.documentElement.clientWidth : document.body.offsetWidth;
        var h = (window.innerHeight) ? window.innerHeight : (document.documentElement && document.documentElement.clientHeight) ? document.documentElement.clientHeight : document.body.offsetHeight;
        return {w:w,h:h};  
    },
    
    // ����һ�����ɫ
    RandomColor:function()
    {
    	//16���Ʒ�ʽ��ʾ��ɫ0-F	
    	var arrHex = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];
    	var strHex = "0x";
    	var index;
    	for(var i = 0; i < 6; i++)
    	{
    	    //ȡ��0-15֮����������

    	    index = Math.round(Math.random() * 15);
    	    strHex += arrHex[index];
    	}
    	return strHex;
    },
    
    // ��׼��ʱ���ַ���תΪʱ���
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
    
    // ��׼��ʱ���ַ���תΪʱ���
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
	
	//�����Զ��������
    AppendZero:function(n)
	{
		return(("00"+ n).substr(("00"+ n).length-2));
	},
    SecondsToTimeStr:function(second,splitChar,returnType)
    {
		var splitArray = {s:"��",m:"����",h:"Сʱ"};
		
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
    
    // ʱ��
	Clock:{
		step:1000,                          // ˢ��ʱ����
		timer:null,                         // ��ʱ��

		cb:null,                      // �ص�����
		getTimeType:"local",                // ��ȡʱ�䷽��[local : ���� , server : �������� ]
		getTimeUrl:"",                      // �ӷ������˻�ȡʱ��URL
		calibrationTimeStep:15*60*1000,     // У׼ʱ�䲽��
		totalDialTimes:0,
		
		week:[ "��","һ","��","��","��","��","��" ],
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
		    // ���ػ�ȡʱ��
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
				return time.getFullYear()+"��"+time.getMonth()+"��"+time.getDate()+"��"+time.toLocaleTimeString()+"&nbsp;����"+Utility.Clock.week[time.getDay()]+"&nbsp;";

			}
			else
			{
		        return time.toLocaleString()+"&nbsp;����"+Utility.Clock.week[time.getDay()]+"&nbsp;";
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
	        // ����8λ

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