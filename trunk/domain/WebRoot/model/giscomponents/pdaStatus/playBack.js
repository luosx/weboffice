﻿var start_x='';
var start_y='';
var end_x='';
var end_y='';
var timer = new Timer(10);
var i=0;
var j=0;
var json='';

//定义ajax方法
function ajaxRequest2(path) {
    var objXMLReq = new ActiveXObject("Microsoft.XMLHTTP");
        objXMLReq.open("get", path, false);
        objXMLReq.send();
        var result = objXMLReq.responseText;            
        return result;
}

function showAllPath(){
    var start = document.getElementById("startTime").value;
    var end =  document.getElementById("endTime").value;
    if(start == "" || end == ""){ 
        alert("请选择要回放的时间段！"); 
        return;
    }
    var selectedComs = document.getElementById("sb");
    var list = "";
    for(var i = 1; i<selectedComs.length; i++){
        list = list + selectedComs.options[i].value + ",";
    }
    list = list.substring(0, list.length - 1);
    json=ajaxRequest2("http://61.177.187.246:8090/gisland/service/rest/wyrw/getHistoryById?id="+list+"&start="+start+"&end="+end);
    json=eval(json);
    timer.addEventListener(TimerEvent.TIMER, calTime); 
    var colors = ["#00ff00","#0000ff","#ff0000","#0ff000","#000ff0"];
    for(i = 0; i <　json.length; i++){
        //poly = parent.parent.center.initPolyLine(colors[i], 1.0, 3); 
        for(var j = 0; j < json[i].length; j++){
            //start_x=json[i][j].x;
            //start_y=json[i][j].y;
            //parent.parent.center.lineTo(poly, start_x, start_y);


        //------------------------------------------------------------------------------------------------------
        //调用百度地图方法 
            var x_=json[i][j].x;
            var y_=json[i][j].y; 
            if(start_x=='' || start_y==''){
                start_x = x_;
                start_y = y_;
            }else{
                end_x = x_;
                end_y = y_;
                parent.parent.center.drawLine(start_x, start_y,end_x, end_y,colors[i],2,1);     
                start_x=end_x;
                start_y=end_y;
            }
         //-------------------------------------------------------------------------------------------------------


        }
    }

}

var poly;
function playBack(id,start,end){
    parent.parent.center.clearOverlays();
    if(document.getElementById("sb").value == "全部设备"){
        showAllPath();
    }else{
        if(document.getElementById("start").value == "回放"){
            timer = new Timer(10);
            json="";
            i=0;
            j=0;
            json=ajaxRequest2("http://61.177.187.246:8090/gisland/service/rest/wyrw/getHistoryById?id="+id+"&start="+start+"&end="+end);
            json=eval(json);
            timer.addEventListener(TimerEvent.TIMER, calTime); 

            //poly = parent.parent.center.initPolyLine("#00ff00", 1.0, 3);
            //调用百度方法

            timer.start(); 

        }
        if( document.getElementById("start").value == "继续" || document.getElementById("start").value == "回放"){
            document.getElementById("start").value = "暂停";
        }else{
            document.getElementById("start").value = "继续";
        }
    }

}

function resetStatus(){
    timer.stop(); 
    document.getElementById("start").value = "回放";
}

function calTime(){
    if(document.getElementById("start").value == "继续"){
        return;    
    }
    if(j==json[i].length){
        resetStatus();
    }else{
        if (json[i][j].x != 0 && json[i][j].x != '') {
                    //start_x=json[i][j].x;
                    //start_y=json[i][j].y;
                    //parent.parent.center.lineTo(poly, start_x, start_y);

         //--------------------------------------------------------------------------------------------------------------------
                 //调用百度地图方法
             var   y_=json[i][j].x;
             var   x_=json[i][j].y;
               if(start_x=='' || start_y==''){
                    start_x = x_;
                    start_y = y_;
                }else{
                    end_x = x_;
                    end_y = y_;
                    parent.parent.center.drawLine(start_x, start_y,end_x, end_y,'red',2,1);    
                    start_x=end_x;
                    start_y=end_y;
            }
            //--------------------------------------------------------------------------------------------------------------------    
            


        }
    }
    j++;
}


/***
 * <br>Description:根据下拉列表框选择的区县，自动加载该区县中所有的PDA设备，在PDA下拉列表框中显示
 * <br>Author:李如意
 * <br>Date:2012-2-21 
 * @param {} obj
 */
function loadDevice(obj){
    var actionName = "pdaStatusAC";
    var actionMethod = "getAllPDA"; 
    var parameter="xzqdm="+obj.value;  
    var pdaList = ajaxRequest(path,actionName,actionMethod,parameter);   
    createSelectObj(pdaList);
} 

function onXSelectChange(obj){
    alert("");
    parent.parent.center.clearOverlays();
    resetStatus();
    loadDevice(obj);
    document.getElementById("start").disabled = true; 
}
function onDSelectChange(obj){
    parent.parent.center.clearOverlays();
    resetStatus();
    //因设备轨迹全部回放时，常常导致IE崩溃，故在此屏蔽 
    if(document.getElementById("sb").value == "全部设备"){
        document.getElementById("start").disabled = true;
    }else{
        document.getElementById("start").disabled = false; 
    }
}
function onStSelectChange(obj){
    parent.parent.center.clearOverlays();
    resetStatus();
}
function onEndSelectChange(obj){
    parent.parent.center.clearOverlays();
    resetStatus();
}

/***
 * <br>Description:读取PDA信息在下拉列表框中显示
 * <br>Author:李如意
 * <br>Date:2012-2-21  
 * @param {} data
 */
function createSelectObj(data){
    var arr = JSON.parse(data); 
    if(data != null && data.length>0){ 
        var obj = document.getElementById("sb"); 
        obj.innerHTML="";
        var op = document.createElement("option"); 
        op.setAttribute("value","全部设备");   
        op.appendChild(document.createTextNode("全部设备")); 
        obj.appendChild(op); 
        for(var o in arr){ 
            var op = document.createElement("option"); 
            op.setAttribute("value",arr[o][0]);   
            op.appendChild(document.createTextNode(arr[o][1]));//op.text=arr[o][1];//这一句在ie下不起作用，用下面这一句或者innerHTML 
            obj.appendChild(op); 
        }
    }
}

/***
 * <br>Description:根据时间判断
 * <br>Author:李如意
 * <br>Date:2012-2-21  
 * <br>时间大小比较（精确到秒），要求结束时间需晚于开始时间
 */
function check_playBack(value){
    var pda_id = document.getElementById("sb").value;
    //日期格式 2012-02-01 16:04:38 
    var start = document.getElementById("startTime").value;
    var end =  document.getElementById("endTime").value;
    if(pda_id == ""){
        alert("请选择要查看轨迹的设备！");
        return ;
    }
    if(start == "" || end == ""){ 
        alert("请选择要回放的时间段！"); 
        return;
    }else{
        var startTime = MyFormatTime(start);
        var endTime = MyFormatTime(end);
        if(startTime.getTime()<endTime.getTime()){
            if(value == 'dynamic'){
                playBack(pda_id,start,end); //要查询轨迹的设备id、开始时间、结束时间
            }else{
                staticDrawLine(pda_id,start,end); 
            }       
        }else{
                alert("结束时间必须晚于开始时间！"); 
                return; 
        }
    }
}


//对选择的设备轨迹静态全铺显示
function staticDrawLine(id,start,end){
    parent.parent.center.clearOverlays(); 
    var selectedComs = document.getElementById("sb");
    var colors = ["#00ff00","#0000ff","#ff0000","#0ff000","#000ff0"];
    if(document.getElementById("sb").value == "全部设备"){
        for(var i = 1; i<selectedComs.length; i++){
            json=ajaxRequest2("http://127.0.0.1:8080/gisland/service/rest/wyrw/getHistoryById?id="+selectedComs.options[i].value+"&start="+start+"&end="+end);
            json=eval(json);
            //对没有轨迹的设备过滤
            if(json != ""){
                parent.parent.center.staticDrawLine(json[0]);
            }
        }
    }else{
            json=ajaxRequest2("http://61.177.187.246:8090/gisland/service/rest/wyrw/getHistoryById?id="+id+"&start="+start+"&end="+end);
            json=eval(json);
            if(json != ""){
                parent.parent.center.staticDrawLine(json,'red',2,1);
            }
    }
}


/***
 * <br>Description:时间格式转换
 * <br>Author:李如意
 * <br>Date:2012-2-21  
 */
function MyFormatTime(str){
    var year=str.split('-')[0];
    var month=str.split('-')[1];
    var date = str.split('-')[2].split(' ')[0];
    var h = str.split('-')[2].split(' ')[1].split(':')[0];
    var m = str.split('-')[2].split(' ')[1].split(':')[1];
    var s = str.split('-')[2].split(' ')[1].split(':')[2];    
    return new Date(year,month,date,h,m,s);
}


