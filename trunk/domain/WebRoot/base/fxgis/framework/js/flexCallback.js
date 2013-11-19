
function showVideo(s){
    window.showModalDialog("../../videoMonitor/pop.jsp?carname="+s,window,"dialogWidth=352px;dialogHeight=288px;status=no;scroll=no");
}
//flex加载完成后，会调用此方法，重置图层是否展现等，返回null则无需重置。
function getInitMapLayerVisiable(){
    return null;
}
//画点 回调方法
function drawPoint(s){
    tempValue=s;
}

//画面 回调方法
function drawPolygon(s){
}
//属性查询 回调方法
function identify(s){
}
//长度量算 回调方法
function measureLengths(s){
}
//面积量算 回调方法
function measureAreas(s){
}
//图斑查询 回调方法
function findExecute(s){
}
