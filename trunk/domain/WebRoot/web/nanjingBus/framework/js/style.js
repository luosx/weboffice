/**
 * @author Administrator
 */
var mouserLocation;
var isMoveReady=false;
var e;
function mouserMenuMoveOnOrOut(obj,imagePath)
{
	if(imagePath.indexOf(".")==-1)
		obj.style.color=imagePath;
	else if(imagePath!=""||imagepath!="null")
	{
		//alert(obj.children[i]);
		//obj.style.background="url(<%=resourcePath%>/images/top/"+imagePath+")";
	}
}

function getIconName(imgPath)
{
	var startIndex=imgPath.lastIndexOf("/")+1;
	var endIndex=imgPath.indexOf('_');
	if(endIndex==-1)
	{
		endIndex=imgPath.lastIndexOf('.');
	}

	return imgPath.substring(startIndex,endIndex);
}
function getExtName(imgPath)
{
	return imgPath.substring(imgPath.lastIndexOf('.'));
}


function scrollMouserDown()
{
	e=getEvent();
	mouserLocation=e.clientY;	
	isMoveReady=true;	
}
function scrollMouserMove(menuDiv)
{
	if(!isMoveReady)
		return;
	var mousry=e.clientY
	var scrollChange=mouserLocation-mousry;
	mouserLocation=mousry;
	menuDiv.scrollTop+=scrollChange;
	
}
function scrollMouserUp()
{
	isMoveReady=false;

}
function getEvent()
{	
	if(window.event)
		return window.event;
	func=getEvent.caller;
	while(func!=null)
	{
		var arg0=func.arguments[0];
		if(arg0)
		{
			if((arg0.constructor==Event || arg0.constructor ==MouseEvent)
			||(typeof(arg0)=="object" && arg0.preventDefault && arg0.stopPropagation))
			{
				return arg0;
			}
		}
		func=func.caller;
	}
	return null;
}
document.documentElement.onselectstart = document.documentElement.ondrag = function(){return false;}
