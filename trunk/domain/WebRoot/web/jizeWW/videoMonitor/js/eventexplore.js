/**
* WebClient {http://www.crearo.com/} 
* FileName.......: eventexplore.js
* Project........: WebClient
* Create DateTime: $Date: 2011/09/19 16:00:00 $
*/

var EventExplore = {
	version: "v2011.09.19",
    lastModifyTime: "2011/09/21 11:00:00",
	
	parentWnd: null,
	timer: null,
	interval: 2000, 
	
	eventArrMsgs: new Array(),
	eventCount: 0, // 事件条数
	updateFlag: true,  
	sortFlag: "desc",
	sortChange: false,
	sortKey: "eventTime",
	sortName: "time",
	selectedLine: "",
	
	evtEContainer: "evtexplorepad",
	
	eventHeader: {
		"eventTime": "时间",
		"eventSrc": "来源",
		"eventModel": "类型",
		"eventDesc": "描述",
		"eventAlarm": "已处警"		
	},
	
	/* initialize login web page */
	Init: function(evtEContainer){  
		this.parentWnd = window.dialogArguments;
		 
		///* delete all element */
		$$("body")[0].update(); 
		///* switch body css */
		this.SwitchLinkStyle(); 
		
		evtEContainer = evtEContainer || this.evtEContainer;
		
		// alert(evtEContainer);
		
		///* unexist the element */ 
		if(!$(evtEContainer))
		{
			var objEvtEContainer = document.createElement("DIV");
			objEvtEContainer.setAttribute("id" , evtEContainer);
			$$("body")[0].appendChild(objEvtEContainer);
			
			$(evtEContainer).setStyle({
				position: "absolute",
				top: "0px",
				left: "0px",
				width: "100%",
				height: "100%",
				margin: "0px" 
			});
			
		}
		
		this.evtEContainer = evtEContainer;
		
		var htmlstr = "";
        htmlstr += "<div id=\"evtpad\" style=\"border:1px inset #CCCCCC;width:686px;height:381px;float:left;\">";        
       		htmlstr += "<div class='divth' style=\"width:686px; border-left:0px inset #CCCCCC; border-right:0px inset #CCCCCC;\" >";
				htmlstr += "<div id=\"eventTime\" sort=\"time\" onclick=\"EventExplore.SortExpress(this);\" class='divthtd' style=\"width:19%;cursor:hand;\" >&nbsp;"+this.eventHeader["eventTime"]+"&darr;</div>";
				htmlstr += "<div id=\"eventSrc\" sort=\"src\"  onclick=\"EventExplore.SortExpress(this);\"  class='divthtd' style=\"width:18%;\"  >&nbsp;"+this.eventHeader["eventSrc"]+"</div>";
				htmlstr += "<div id=\"eventModel\" sort=\"modelName\"  onclick=\"EventExplore.SortExpress(this);\"  class='divthtd' style=\"width:15%;\" >&nbsp;"+this.eventHeader["eventModel"]+"</div>";
				htmlstr += "<div id=\"eventDesc\" sort=\"desc\"  onclick=\"EventExplore.SortExpress(this);\"  class='divthtd' style=\"width:38%;\" >&nbsp;"+this.eventHeader["eventDesc"]+"</div>";
				htmlstr += "<div id=\"eventAlarm\" sort=\"alarm\"  onclick=\"EventExplore.SortExpress(this);\"  class='divthtd' style=\"width:8%;\" >&nbsp;"+this.eventHeader["eventAlarm"]+"</div>";   
			htmlstr += "</div>";
       		 
			htmlstr += "<div id=\"dataarea\" style=\"height:357px;overflow:hidden;overflow-y:scroll;width:100%;border:1px solid #b0b0b0;border-width:0px 1px 0px 0px;padding:0px;background:#FFFFFF;\">";
				
        	htmlstr += "</div>";
        
        htmlstr += "</div>";
        $(evtEContainer).update(htmlstr);  
	 	
		this.UpdateEventList();
		
	 	this.timer = setInterval(EventExplore.UpdateEventList, this.interval);
		
		/*var objEvtEContainer = document.createElement("DIV");
		objEvtEContainer.setAttribute("id" , "SDSDSDS");
		$("hello").insert({"before":objEvtEContainer}); 
		$("SDSDSDS").update("ddddddddddddddddddddddd");  
		objEvtEContainer.insert({"before":"ffffffffffffffffffffffffff"}); 
		*/
	},
	
	// 刷新事件
	UpdateEventList: function(){
		if($("dataarea"))
		{
			if(!this.sortChange)
			{
				if(!EventExplore.updateFlag)
				{
					var lastEvtMsg = EventExplore.parentWnd.WebClient.Event.lastEventMsg || {};
					if(!lastEvtMsg || !lastEvtMsg["time"]) return;
				} 
				EventExplore.updateFlag = false; 
				
				var translateMessages = EventExplore.parentWnd.WebClient.Event.translateMessages;  
				if(!translateMessages || typeof translateMessages == "undefined") return;   
			
				EventExplore.eventArrMsgs = eval(translateMessages.toJSON());
				EventExplore.SortExpress(); // sort custom 
			}
			this.sortChange = false;   
			 
			EventExplore.eventCount = EventExplore.eventArrMsgs.length;
		    // alert(EventExplore.eventCount);
			
			var htmlstr = "";
			
			if(EventExplore.eventCount == 0)
			{
				htmlstr += "<div id=\"eventList-no\" class='divtr' style=\"width:100%; border-left:0px inset #CCCCCC; border-right:0px inset #CCCCCC;\" >";
					htmlstr += "<div class='divtrtd' style=\"width:19%;cursor:hand;\" >&nbsp;</div>";
					htmlstr += "<div class='divtrtd'  style=\"width:18%;\"  >&nbsp;</div>";
					htmlstr += "<div class='divtrtd'  style=\"width:15%;\" >&nbsp;</div>";
					htmlstr += "<div class='divtrtd'  style=\"width:38%;\" >&nbsp;</div>";
					htmlstr += "<div class='divtrtd'  style=\"width:8%;\" >&nbsp;</div>";   
				htmlstr += "</div>";
			}
			else
			{
				var clsname = "divtrother", tmp = "";
				EventExplore.eventArrMsgs.each
				(
					function(item, i)
					{ 
						clsname = clsname != "divtr" ? "divtr" : "divtrother";
						// tmp = "";
						tmp += "<div id=\"eventList-"+i+"\" type=\"evt-list\" class='"+clsname+"' style=\"width:100%; border-left:0px inset #CCCCCC; border-right:0px inset #CCCCCC;\" >"; 
							tmp += "<div class='divtrtd' style=\"width:19%;cursor:hand;\" title=\""+item.time+"\" >&nbsp;"+item.time+"</div>"; 
							tmp += "<div class='divtrtd'  style=\"width:18%;\" title=\""+item.src+"\" >&nbsp;"+item.src+"</div>";  
							tmp += "<div class='divtrtd'  style=\"width:15%;\" title=\""+item.modelName+"\" >&nbsp;"+item.modelName+"</div>"; 
							tmp += "<div class='divtrtd'  style=\"width:38%;\" title=\""+item.desc+"\" >&nbsp;"+item.desc+"</div>";  
							tmp += "<div class='divtrtd'  style=\"width:8%;\" title=\""+item.alarm+"\" >&nbsp;"+item.alarm+"</div>";  
					    tmp += "</div>";
						
						/* if(EventExplore.sortFlag == "desc"){ 
							htmlstr = tmp + htmlstr; 
						} else {
							htmlstr = htmlstr + tmp;
						} */
						
					}
				);    
				
				htmlstr = tmp;
			}
 			
			if(htmlstr != "") $("dataarea").update(htmlstr);
			// $("dataarea").update(Object.toJSON(EventExplore.eventArrMsgs));
			
			// 绑定事件
			$$("#dataarea div").each
			(
			 	function(obj, i)
				{
					if(obj && obj.type == "evt-list")
					{
						obj.onmouseover = function(){
							if($(EventExplore.selectedLine) && EventExplore.selectedLine == this.id) return;
							this.className = this.className + "over";
						};
						obj.onmouseout = function(){ 
							if($(EventExplore.selectedLine) && EventExplore.selectedLine == this.id) return;
							this.className = this.className.replace("over", "");
						};
						obj.onclick = function(){
							// if(this.id != EventExplore.selectedLine)
							 {   
								 if($(EventExplore.selectedLine))
								 $(EventExplore.selectedLine).className = $(EventExplore.selectedLine).className.replace("over", "");
								
								 if($(this.id)) 
								 {
									 this.className = this.className.replace("over", "");
									 this.className = this.className + "over";
								 	 EventExplore.selectedLine = this.id;
								 }
								 
							 }
							 
						};
						
					}
					
				}
			);
			
			// if($(EventExplore.selectedLine)) $(EventExplore.selectedLine).onclick();
			
		}
		
	},
	
	/* switch body css */
	SwitchLinkStyle: function(){ 
		try
		{ 
			if(typeof EventExplore.parentWnd.Global.WebClientStyleSheet.Get != "undefined")
			{ 
				var css = "images/" + EventExplore.parentWnd.Global.WebClientStyleSheet.Get() + ".css"; // alert(css);
				if($("switchskin") && $("switchskin").readAttribute('href') != css) 
				$("switchskin").writeAttribute('href', css);
			}  
		}
		catch(e)
		{
		}
		
	},
	 
	/* sort by @obj.sort asc/desc */
	SortExpress: function(obj){
		// alert(obj.id);
		try
		{ 
			var type = "", flag = 0;
			if(!obj || !$(obj.id) || !obj.sort){
				type = this.sortName;
			} else {
				type = obj.sort; flag = 1; 
			} 
			 
			var evtAMs = this.eventArrMsgs;   
			// alert(Object.toJSON(this.eventArrMsgs)); 
			
			// sort by @obj.sort
			this.eventArrMsgs.sort(
				function(a, b){
					var s = t = "";
					switch(type){
						case "time": 
							s = a.time; t = b.time; 
							break;
						case "src": 
							s = a.src; t = b.src; 
							break; 
						case "modelName": 
							s = a.modelName; t = b.modelName; 
							break; 
						case "desc": 
							s = a.desc; t = b.desc; 
							break; 
						case "alarm": 
							s = a.alarm; t = b.alarm; 
							break; 
						default: 
							s = a.time; t = b.time; 
							break;
					} 
					if(s < t) return -1;
					else if(s > t) return 1;
					else return 0;
				}
			);  
			// alert(Object.toJSON(this.eventArrMsgs));
			
			/* change save sortFlag */
			if(flag == 1)
			{  
				if(this.sortFlag == "desc") {
					this.sortFlag = "asc";  
					$(obj.id).update("&nbsp;" + this.eventHeader[obj.id] + "&uarr;");
					
				} else {
					this.sortFlag = "desc"; 	
					$(obj.id).update("&nbsp;" + this.eventHeader[obj.id] + "&darr;");
				} 
				
				if(this.sortName != type)
				{   
					$(this.sortKey).update("&nbsp;" + this.eventHeader[this.sortKey]);
					this.sortName = type; 
					this.sortKey = obj.id;
				}
				
				this.sortChange = true;
			} 
			else
			{
				this.sortChange = false;
			}  
			 
			if(this.sortFlag == "desc") this.eventArrMsgs.reverse();
			// alert(Object.toJSON(this.eventArrMsgs));  
			if(this.sortChange) this.UpdateEventList(); // refresh list
		}
		catch(e)
		{
			alert(e.message + "::" + e.name);
		} 
		
	},
	
	UnLoad: function(){
		try
		{
			if(this.timer) 
			{
				window.clearInterval(this.timer);
				this.timer = null;	
			}
			
			if(EventExplore.parentWnd.WebClient.Event.eventDialogWindow) 
			EventExplore.parentWnd.WebClient.Event.eventDialogWindow = null; 
		}
		catch(e)
		{ 
		}
		
 	},
	
	Resize: function(){
		if($("evtpad"))
		{
			var Dimensions = document.viewport.getDimensions();
			var clientW = Dimensions.width;
			var clientH = Dimensions.height;
			
			$(this.evtEContainer).setStyle({
				width: clientW  + "px",
				height: clientH + "px"			 
 			});
			
			$("evtpad").setStyle({
				width: (clientW - 2) + "px",
				height: (clientH - 2) + "px"			 
 			});
			
		}
	},
	
	end: true
};

if(true)
{
	document.observe ( "dom:loaded", function(event){  
			EventExplore.Init(); 
		} 
	); 
	/*Event.observe ( window, "load", function(event){
			// the same as up lines
		} 
	);*/ 
	Event.observe ( window, "unload", function(event){
			EventExplore.UnLoad(); 
		} 
	);
	Event.observe ( window, "resize", function(event){
		 	// EventExplore.Resize(); 
		} 
	); 
}
