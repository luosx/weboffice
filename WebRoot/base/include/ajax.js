
function ajaxRequest(path, beanname, method, parameters) {
    if(window.XMLHttpRequest){
        objXMLReq = new XMLHttpRequest();
    }else if(window.ActiveXObject){
        objXMLReq = new ActiveXObject("Microsoft.XMLHTTP");
    }
    var URL = path + "service/rest/" + beanname + "/" + method ;
    objXMLReq.open("post", URL, false);
    if(parameters != null){
    	parameter = "&isPartlyRefresh=true&" + parameters;
    	
    }else{
    	parameter = "&isPartlyRefresh=true";
    }
    objXMLReq.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded');
    objXMLReq.send(parameter);
    var result = objXMLReq.responseText;            
    return result;
}

function wfsAjax(URL,layerName,bbox) {
    var objXMLReq = new ActiveXObject("Microsoft.XMLHTTP");         
    var defaultParm="?request=GetFeature&service=WFS&Version=1.0.0&";
    objXMLReq.open("get", URL + defaultParm + "typename=" + layerName + "&bbox=" + bbox, false);
    objXMLReq.send();
    var result = objXMLReq.responseText;            
    return result;
}

function pjsonAjax(URL){
    var objXMLReq = new ActiveXObject("Microsoft.XMLHTTP");         
    objXMLReq.open("get", URL , false);
    objXMLReq.send();
    var result = objXMLReq.responseText;            
    return result;
}


