document.attachEvent("onpropertychange", AttributeNodeModified); 
function AttributeNodeModified(evt) 
{ 
//    if(evt.attrName == "href") {alert("href"); } 
//    if(evt.attrName == "src") { alert("src");} 
//    if(evt.attrName == "action") { alert("action");} 
	var url=window.location.search; 
	if(url.indexOf("?")!=-1) 
	{ 
		var str = url.substr(1) 
		strs = str.split("&"); 
		for(i=0;i<strs.length;i++) 
		{ 
			document.write([strs[i].split("=")[0]],'＝',unescape(strs[i].split("=")[1]),'<br>'); 
		} 
	} else
		; 
 }