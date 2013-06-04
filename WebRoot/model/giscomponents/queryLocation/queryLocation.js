//查询并定位 add by guorp 2011-8-1
function queryLocation(){

//建设用地审批定位
if(zfjcType==4){
    center.center.queryAndLocation('YZ_JSYDSP',0,"YW_GUID='"+yw_guid+"'",7,true);
}

if(zfjcType==43||zfjcType==44||zfjcType==45){
    center.center.queryAndLocation('YZ_GDGZ',0,"GD_GUID='"+yw_guid+"'",7,true);
}

//外业巡查路线定位
if(zfjcType==2){
    center.center.queryAndLocation('YZ_EDIT',1,"YW_GUID='"+yw_guid+"'",7,true);
 }

 //信访举报地点定位
if(zfjcType==1){
    center.center.queryAndLocation('YZ_EDIT',0,"YW_GUID='"+yw_guid+"'",7,true);
    center.center.queryAndLocation('YZ_EDIT',1,"YW_GUID='"+yw_guid+"'",7,false);
    center.center.queryAndLocation('YZ_EDIT',2,"YW_GUID='"+yw_guid+"'",7,false);
 }
 
//实地巡查业务
 if(zfjcType==21){
 	center.center.queryAndLocation('10_YZ_WYXCHC',0,"PLOTID='"+dkid+"'",3,true);
 	center.center.queryAndLocation('10_YZ_WYXCHC',1,"PLOTID='"+dkid+"'",3,false);
 	center.center.queryAndLocation('10_YZ_WYXCHC',2,"PLOTID='"+dkid+"'",3,false);
 }
}

 //绘制位置查看 add by 王峰 2011-8-1
 function drawLocation(drawType){
    center.center.drawGeometry(drawType);
 }
 
 //删除设计的位置 add by 王峰 2011-8-1
 function delLocation(){
 	Ext.MessageBox.confirm('注意', '删除后不能恢复，您确定吗？',function(){
     window.location.replace(basePath+"shtcDataOperationAC.do?method=delLocation&yw_guid="+yw_guid+"&zfjcType="+zfjcType);        
   });
 }
 
 //删除实地巡查图层 add by 尹宇星 2011-8-5
 function delSdxc(){
 	window.location.replace(basePath+"sdxcDataOperationAC.do?method=delLocation&yw_guid="+yw_guid+"&zfjcType="+zfjcType+"&dkid="+dkid);
 }

function strToJson(str){
	var json = eval('(' + str + ')');
	return json;
}

function initYw(){
  center.center.initYw(zfjcType,yw_guid);

}
