﻿﻿﻿﻿﻿﻿﻿// esri.Map
var map;
// 地图服务
var mapServices;
// 初始化四至
var startExtent;
// taskManager
var application;
//Navigation toolbar
var navigationToolbar;
//Draw toolbar
var drawToolbar;
//geometry临时变量，用于记录客户端手绘图形
var geometries2;
//属性查询click事件监听加载状态，false为未加载，true为已加载
var isPropertiesQueryClickEventEnabled=false;
//检测图斑查询click事件监听加载状态，false为未加载，true为已加载
var isProjectQueryClickEventEnabled=false;
//审批项目查询click事件监听加载状态，false为未加载，true为已加载
var isSpProjectQueryClickEventEnabled=false;
//手绘图层click事件监听加载状态，false为未加载，true为已加载
var isShprojectQueryClickEventEnabled=false;
//shp导出click时间监听加载状态，false为未加载，true为已加载
var isShpExportQueryClickEventEnabled=false;
//框选
var isSelectedQueryClickEventEnabled=false;
//WFS查询
var isWFSQueryClickEventEnabled=false;
//寿光查询
var isSGQueryClickEventEnabled=false;

var isSelectJCTBClickEventEnabled=false;

var operationType = "";

var commonpms;
var commonsls;
var commonsms;
var commonsfs;
var commonbluelight;
var commoncar;
var commoncom;

var commonpoint;
var commonmarkB;
var commonmarkR;
//var commonsls_green;
//var commonsfs_green;

//#wangf# 以下八行内容提取到各自方法内部
var shflag;//手绘类型标识
var shgeometry;//手绘图层标识
var yw_guid = 0;//信访举报、外业查询业务ID
var zfjctype;//业务类型
var saveflag;
var showflag;
//弹出手绘信息页面
var winSh;
var formSh;

var addTaskWin;
var addTaskForm;
//窗体对象 属性现状规划
var win;

var center_tabs;

var resizeTimer;

//分析弹出页面
var winPro;
//几何学服务URL
var geometryServiceUrl;
//几何学服务
var geometryService;



