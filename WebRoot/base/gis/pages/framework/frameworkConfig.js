//////////////////////////////////////////////////////////////////////////////////
////
////
////                         配置信息
////framework一共5跟文件：Config问配置信息；Application为总体控制文件；HttpRequest为rpc文件；
////interface为对外接口文件；TaskManager为进程守护文件。
////
////
/////////////////////////////////////////////////////////////////////////////////

var PropertiesPage ='1';
var XZPage = '2';
var GHPage = '3';

var _$WKID = "2364";

/**
 * rest请求服务
 */
var restUrl = "";

if(restUrl == null || restUrl == ""){
	var query = window.location.href;
	var ss = query.split("/");
	restUrl = "http://" + ss[2] + "/" + ss[3]+ "/service/rest/";
}


