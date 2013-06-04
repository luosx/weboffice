	/**
	 * @author 任宝龙
	 */
    /**
     * 初始化
     */
    var basePath;
	function setYearSelect()
 	{	
 		var yearSelects=document.getElementsByName("year");

 		var selectObj;
 		var year=new Date().getYear();
 		for(var i=0;i<yearSelects.length;i++)
 		{
 			selectObj=yearSelects[i];
 			for(var y=1949;y<=year;y++)
 				selectObj.add(new Option(y,y));
 		}
 	}
 	function setWeekSelect(year)
 	{
 		var dayOfyear=365;
 		if((year%4==0&&year%100!=0)||year%400==0)
 			dayOfyear++;
 		var weeks=1;
 		var date=new Date(49,1,1)
 		var day=date.getDay()+1;
 		weeks+=(Math.floor((dayOfyear-day)/7));
 		
 		if((dayOfyear-day)%7>0)
 			weeks++;
		var  selectObj=document.getElementById("datetime42");
 		for(var i=1;i<=weeks;i++)
 		{
 			 selectObj.add(new Option(i+"周",i));
 		}
 	}
 	function setMonthSelect()
 	{
 		var selectObj=document.getElementById("datetime32");
 		for(var i=1;i<=12;i++)
 		{			
 			 selectObj.add(new Option(i+"月",i));
 		}
 	}
 	function queryInit()
 	{
 		setMonthSelect();
 		setYearSelect();
 		setWeekSelect(1949);
 		basePath=document.forms[0].action;
 		
 		columnDataContent=document.getElementById("columnDataContent");
		queryData=document.getElementById("queryData");
		columnData=document.getElementById("columnData");
 	}
 	function yearOfWeekChange(selectObj)
 	{
 		clearSelect(document.getElementById("datetime42")); 
 		setWeekSelect(selectObj.options[selectObj.selectedIndex]);
 	}
 	window.onload=queryInit;
 	/**
     * 时间处理
     */
 	var getTimeWay=0;
 	var previousCheckBox;
 	function selectWay()
 	{		
 		var eve=getEvent();
 		var checkedObj=getEleByEvent(eve);
 		setDisabled(checkedObj);
 		if(previousCheckBox!=undefined&&previousCheckBox!=checkedObj)
 		{			
 			previousCheckBox.checked=false;
 			setDisabled(previousCheckBox);
 		}
 		previousCheckBox=checkedObj;
 		getTimeWay=checkedObj.checked?checkedObj.id.substring(3):0;		
 	}
 	function setDisabled(checkedObj)
 	{
 		var index=checkedObj.id.substring(3);
 		var liObj=document.getElementById("date"+index);
   	    var nodes=liObj.childNodes;
   	   	var node;
 		for(var i=1;i<nodes.length;i++)
 		{
 			node=nodes[i];
 			if(node.tagName=="INPUT"||node.tagName=="SELECT")
 				node.disabled=!checkedObj.checked;
 		}
 	}
 	/**
 	 * 查询
 	 */
 	var columnDataContent;
 	var queryData;
 	var columnData;
 	function doQuery()
 	{
 		if(getTimeWay==0)
 		{
 			alert("请选择统计方式");
 			return;
 		}
 		var selectObj=document.getElementById("columnsValueSelect");
		if(selectObj.selectedIndex==-1)
		{
			alert("请选择统计名称");
			return;
		}

		setDateTimeValue();
		
 		var startTime=document.getElementById("beginTime").value;
 		var endTime=document.getElementById("endTime").value;		
 		var columns=selectObj.options[selectObj.selectedIndex].value;
	 		
		var path =basePath;
		var actionName = "queryAction";
		var actionMethod = "getQueryData";
		var parameter = "startTime=" + startTime+"&endTime="+endTime+"&columns="+columns;
		var data = ajaxRequest(path, actionName, actionMethod, parameter);
		data = eval('(' + data + ')');

		var columnNum=columns.split(",").length;
		
		var tableCode="<table  class='tableBorder' cellpadding='0' cellspacing='0' border='0' style='width:"+(132*columnNum)+"px;'>"
	
		columnDataContent.innerHTML=tableCode+data[0].column+"</table>";	
		queryData.innerHTML=tableCode+data[0].data +"</table>";	
				
		queryData.style.height=(document.body.clientHeight-95)+"px";
		columnDataContent.style.width=document.getElementById("columnDataContent").offsetWidth+30;

		var columnsEditHeight=document.getElementById("columnsEdit").offsetHeight;
		var dateEditHeight=document.getElementById("dateEdit").offsetHeight;
		
		document.body.scrollTop=columnsEditHeight+dateEditHeight+30;
 	}
	function selectCheck(checkId)
	{
		document.getElementById(checkId).checked=!document.getElementById(checkId).checked;
	}
 	function columnScroll()
 	{
 		columnData.scrollLeft=queryData.scrollLeft;
 	}
 	function setDateTimeValue()
 	{
 		switch(getTimeWay)
 		{
	 		case "1":
	 		   doWay1();
	 		   break;
	 		case "2":
	 		   doWay2();
	 		   break;
	 		case "3":
	 		   doWay3();
	 		   break;
	 		case "4":
	 		   doWay4();
	 		   break;
	 		case "5":
	 		   doWay5();
	 		   break;
 		}
 	}
 	function doWay1()
 	{
 		var selectObj=document.getElementById("datetime11");
 		var year=selectObj.options[selectObj.selectedIndex].value;
 		var beginTime=year+"-1-1";
 		var endTime=year+"-12-31";	
 		setDateTime(beginTime,endTime);
 		
 	}
 	function doWay2()
 	{
 		var selectObj=document.getElementById("datetime21");
 		var year=selectObj.options[selectObj.selectedIndex].value;
 		selectObj=document.getElementById("datetime22");
 		var quarter=selectObj.options[selectObj.selectedIndex].value;
 		var beginMonth;
 		var endMonth;
 		var months=getMonthsDaysByYear(year);
 		switch(quarter)
 		{
 			case "1":
	 			beginMonth=1;
	 			endMonth=3;
	 			break;
 			case "2":
	 			beginMonth=4;
	 			endMonth=6;
	 			break;
	 		case "3":
	 			beginMonth=7;
	 			endMonth=9;
	 			break;
	 		case "4":
	 			beginMonth=10;
	 			endMonth=12;
	 			break;
 		}
 		var beginTime=year+"-"+beginMonth+"-"+months[beginMonth];
 		var endTime=year+"-"+endMonth+"-"+months[endMonth];
 		setDateTime(beginTime,endTime);
 		
 	}
 	function doWay3()
 	{
 		var selectObj=document.getElementById("datetime31");
 		var year=selectObj.options[selectObj.selectedIndex].value;
 		selectObj=document.getElementById("datetime32");
 		var month=selectObj.options[selectObj.selectedIndex].value;
 		var months=getMonthsDaysByYear(year);
 		
 		var beginTime=year+"-"+month+"-1";
 		var endTime=year+"-"+month+"-"+months[month];		
 		setDateTime(beginTime,endTime);
 	}
 	function doWay4()
 	{
 		var selectObj=document.getElementById("datetime41");
 		var year=selectObj.options[selectObj.selectedIndex].value;
 		selectObj=document.getElementById("datetime42");
 		var weeks=selectObj.options[selectObj.selectedIndex].value;
 		var firstWeekDay=new Date(year,0,1).getDay();
 		var daysofyaer=7*(weeks-1)-firstWeekDay+1;
 		var months=getMonthsDaysByYear(year);
 		
 	 	var month; 
 		for(month=1;month<=12;month++)
 		{
 			if(months[month]>daysofyaer)
 				break;
 			daysofyaer-=months[month];
 		}
 		var beginTime=year+"-"+month+"-"+daysofyaer;
 		var endTime;
 		daysofyaer+=6;
 		if(months[month]>daysofyaer)
 		  endTime=year+"-"+month+"-"+daysofyaer;
 		else
 		{
 			daysofyaer-=months[month];
	 		if(month==12)
	 		{
	 			year++;
	 			month=1
	 		}
	 		else
	 		   month++;
 		}	
 		endTime=year+"-"+month+"-"+daysofyaer;
 		setDateTime(beginTime,endTime);
 	}
 	function doWay5()
 	{
 		var beginTime=document.getElementById("datetime51").value;
 		var endTime=document.getElementById("datetime52").value;
	
 		setDateTime(beginTime,endTime);
 	}
 	function setDateTime(beginTime,endTime)
 	{
 		document.getElementById("beginTime").value=beginTime;
 		document.getElementById("endTime").value=endTime;
 	}
 	function getMonthsDaysByYear(year)
 	{
 		var february;
 		if((year%4==0&&year%100!=0)||year%400==0)
 			february=29;
 		else
 			february=28;
 		var months=[0,31,february,31,30,31,30,31,31,30,31,30,31];
 		return months;
 	}
 	/**
 	 * 修改统计
 	 */
 	function showColumns()
 	{
		var backgroundDiv=document.getElementById("backgroundDiv");
		backgroundDiv.style.display="block";
		backgroundDiv.style.height=(document.body.scrollHeight)+"px";
		backgroundDiv.style.width=document.body.clientWidth+"px";
		
		var contentDiv=document.getElementById("contentDiv");
		contentDiv.style.display="block";
		//确定横坐标和纵坐标
		var clientWidth=document.body.clientWidth;
		var divWidth=contentDiv.offsetWidth;
		
		if((clientWidth-divWidth)>0)
			contentDiv.style.left=(clientWidth-divWidth)/2+"px";
		else
			contentDiv.style.left='100px';
			
		var clientHeight=document.body.clientHeight;
		var scrollHeight=Math.max(document.body.scrollHeight,document.documentElement.scrollHeight);
		var divHeight=contentDiv.offsetHeight;
		if((clientHeight-divHeight)>0)
		{
			var height=(clientHeight-divHeight)/2;	
			contentDiv.style.top=height+"px";
		}
		else
			contentDiv.style.top="100px";

 	}
 	function closeColumns()
 	{
 		document.getElementById("backgroundDiv").style.display="none";
 		document.getElementById("contentDiv").style.display="none";
 		
 	}

	var isAdd;
	function addColumns()
 	{
 		showColumns();
 		clearColumn();
 		isAdd=true;	
 	}
 	function updateColumns()
 	{
 		showColumns();
 		setColumn();
 		isAdd=false;
 		
 	}
 	function deleteColumns()
 	{
 		var selectObj=document.getElementById("columnsValueSelect");
 		if(selectObj.selectedIndex==-1)
 			return;
 		if(!confirm("您确认要删除？"))
 			return;
 		var queryName=selectObj.options[selectObj.selectedIndex].text;
 		
 		var userId=document.getElementById("userId").value;
		var path =basePath;
		var actionName = "queryAction";
		var actionMethod = "delete";
		var parameter = "queryName=" + queryName+"&userId="+userId;
		var data = ajaxRequest(path, actionName, actionMethod, parameter);	
		var data = eval('(' + data + ')');
		if(data["success"])
		{
			alert("删除成功!");
			selectObj.options.remove(selectObj.selectedIndex);
		}
		else
		{
			alert("删除失败!");
		}		
 	}
 	function saveColumns()
 	{
 		var queryName="";
 		var columns="";
 		var selectObj=document.getElementById("columnsValueSelect");
 		var options=selectObj.options;
 		var textObj=document.getElementById("columnsName");		
 		if(textObj.value=="")
 		{
 			alert("请输入统计名！");
 			return;
 		}	
 		if(isAdd)
 		{
			for(var i=0;i<options.length;i++)
			{
				if(options[i].text==textObj.value)
				{
					alert("该统计名以存在");
					return;
				}
			}
 		}
 		else
 		{
 			for(var i=0;i<options.length;i++)
			{
				if(options[i].text==textObj.value&&i!=selectObj.selectedIndex)
				{
					alert("该统计名以存在");
					return;
				}
			}
 		}
 		
 		var columns=document.getElementsByName("column");
 		var checkObj;
 		var columnValue="";
 		for(var i=0;i<column.length;i++)
 		{
 			checkObj=columns[i];
 			if(checkObj.checked)
 			{
 				 columnValue+=checkObj.value+","
 			}	
 		}
 		if(columnValue=="")
 		{
 			alert("请选择统计列!");
 			return;
 		}

 		queryName=textObj.value;
 		var oldQueryName=isAdd?queryName:options[selectObj.selectedIndex].text;
 		columnValue=columnValue.substring(0,columnValue.length-1);

 		var userId=document.getElementById("userId").value;
		var path =basePath;
		var actionName = "queryAction";
		var actionMethod ="save";
		var parameter = "queryName=" + queryName+"&columns="+columnValue+"&userId="+userId+"&oldQueryName="+oldQueryName;
		var data = ajaxRequest(path, actionName, actionMethod, parameter);	
		var data = eval('(' + data + ')');
		if(data["success"])
		{
			alert("保存成功!");
			if(!isAdd)
			{
				options[selectObj.selectedIndex].text=queryName;
				options[selectObj.selectedIndex].value=columnValue;		
			}
			else
			{
				options.add(new Option(queryName,columnValue));
				selectObj.selectedIndex=options.length-1;				
			}
		}
		else
		{
			alert("保存失败!");
		}
				
		closeColumns();
		
 	}
 	function clearColumn()
 	{
 		var columns=document.getElementsByName("column");
 		for(var i=0;i<column.length;i++)
		{
			columns[i].checked=false;
		}
 		document.getElementById("columnsName").value="";	
 	}
 	function setColumn()
 	{
 		document.getElementById("selectAll").checked=false;
 		var selectObj=document.getElementById("columnsValueSelect");
 		if(selectObj.selectedIndex==-1)
 		{
 			clearColumn();
 			return;
 		}
 		var columns=document.getElementsByName("column");
 		var values=selectObj.options[selectObj.selectedIndex].value.split(",");
		for(var i=0;i<column.length;i++)
		{
			columns[i].checked=false;
			for(var j=0;j<values.length;j++)
			{
				if(columns[i].value==values[j])	
				{
					columns[i].checked=true;
					break;
				}
			}	
		}
 		document.getElementById("columnsName").value=selectObj.options[selectObj.selectedIndex].text;
 		
 	}
 	/**
 	 * 提交查询
 	 */
	function selectAll()
	{
		var columns=document.getElementsByName("column");
 		var state=document.getElementById("selectAll").checked;
 		for(var i=0;i<column.length;i++)
 			columns[i].checked=state;

	}
	/**
	 * 导出
	 */
	function report()
	{
		 if(getTimeWay==0)
 		{
 			alert("请选择统计方式");
 			return;
 		}
 		var selectObj=document.getElementById("columnsValueSelect");
		if(selectObj.selectedIndex==-1)
		{
			alert("请选择统计名称");
			return;
		}
		setDateTimeValue();

 		document.getElementById("colums").value=selectObj.options[selectObj.selectedIndex].value;
 		document.getElementById("queryName").value=selectObj.options[selectObj.selectedIndex].text;
		var action=document.forms[0].action;
		if(action.indexOf("service/rest")==-1)
			document.forms[0].action=action+"service/rest/queryAction/report";
		document.forms[0].submit();
	}
	function clearSelect(selectObj)
	{
		selectObj.options.length=0;
	}
	
	function showOrCloseDiv(divId)
	{
		var div=document.getElementById(divId);
		div.style.display=(div.style.display=="block"||div.style.display==""? "none":"block");
	}
	