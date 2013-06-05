<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%@page import="com.klspta.console.ManagerFactory"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/"; 
    String perConfig=ManagerFactory.getMenuManager().getPerConfig();
    String tabConfig=ManagerFactory.getMenuManager().getTabConfig();
    String localConfig=ManagerFactory.getMenuManager().getLocalConfig();

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>执法监察系统</title>
		
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf" %>
		<script src="<%=basePath%>base/gis/js/menuOperation.js" type="text/javascript"></script>
		<script src="<%=basePath%>base/include/ajax.js"></script>
	<style>		
		html,body {
			font: normal 12px verdana;
			margin: 0;
			padding: 0;
			border: 0 none;
			overflow: hidden;
			height: 100%;
		}
	</style>
 
		<script type="text/javascript">
  /*添加菜单click事件 add by 郭 2010-12-23*/
  _$perConfig="<%=perConfig%>";
  _$tabConfig="<%=tabConfig%>";
  _$localConfig="<%=localConfig%>";
    function onItemClick(item){
        execute(item.id,item.text,item.url_center,item.url_east)
    }
var border,win;

Ext.onReady(function(){

  Ext.ux.TabCloseMenu = function(){
    var tabs, menu, ctxItem;
    this.init = function(tp){
        tabs = tp;
        tabs.on('contextmenu', onContextMenu);
    }

    function onContextMenu(ts, item, e){
        if(!menu){ // create context menu on first right click
            menu = new Ext.menu.Menu([{
                id: tabs.id + '-close',
                text: '关闭标签',
                handler : function(){
                    tabs.remove(ctxItem);
                }
            },{
                id: tabs.id + '-close-others',
                text: '关闭其他标签',
                handler : function(){
                    tabs.items.each(function(item){
                        if(item.closable && item != ctxItem){
                            tabs.remove(item);
                        }
                    });
                }
            },{
                id: tabs.id + '-close-all',
                text: '关闭全部标签',
                handler : function(){
                    tabs.items.each(function(item){
                        if(item.closable){
                            tabs.remove(item);
                        }
                    });
                }
            }]);
        }
        ctxItem = item;
        var items = menu.items;
        items.get(tabs.id + '-close').setDisabled(!item.closable);
        var disableOthers = true;
        tabs.items.each(function(){
            if(this != item && this.closable){
                disableOthers = false;
                return false;
            }
        });
        items.get(tabs.id + '-close-others').setDisabled(disableOthers);
        var disableAll = true;
        tabs.items.each(function(){
            if(this.closable){
                disableAll = false;
                return false;
            }
        });
        items.get(tabs.id + '-close-all').setDisabled(disableAll);
        menu.showAt(e.getPoint());
      }
    };
	border =new Ext.Viewport( 
		{
		layout:"border",
		items:[
			        center_tabs =    new Ext.TabPanel({
                region: 'center', // a center region is ALWAYS required for border layout
                id:'aaaa',
                deferredRender: false,
                enableTabScroll:true, 
                plugins: new Ext.ux.TabCloseMenu(),
                activeTab: 0,     // first tab initially active
                items: [{
                    contentEl: 'center',
                    title: '地图服务',
                    id:'mapServices',
                    closable: false,
                    autoScroll: true,
                    autoDestroy:true
                }],
                autoDestroy:true
            }),
			{
                    region:'east',
                    id:'east-panel',
                    contentEl: 'east',
                    split:true,
                    width: 300,
                    minSize: 0,
                    maxSize: 300,
                    collapsible: true,
                    title:'操作栏',
                    collapsed:true,
                    margins:'2 2 0 0'
                }
			  ]
		}
	);
//  fullScreenFromCookie();
}
);


// function fullScreenFromCookie(){
//var fullScreen=getCookie('fullScreen');
//var fullScreen = false;
//true：全屏；false或空：普通
//if(fullScreen=='true'){
//			Ext.getCmp('east-panel').collapse();
//            top.main.rows='0,*'
//}else{
//			Ext.getCmp('east-panel').collapse();
//            top.main.rows='90,*'
//}
//}
function showWindow(showUrl,width,height){
	showWindowSWHC(showUrl,width,height,true);
}
function showWindowSWHC(showUrl,width,height,closable){
	var sch = window.screen.height / 2;
	var scw = window.screen.width / 2;
	sch = sch - height;
	scw = scw - width /2;
	showWindowSWHCXY(showUrl,width,height,closable,scw,sch);
}

var win = null;
function showWindowSWHCXY(showUrl,width,height,closable,localx,localy){
	if(width==0 || height==0){
		width=document.body.clientWidth;
		height=document.body.clientHeight;
	}
	win = new Ext.Window({
	    x:localx,
		y:localy,
		layout:'fit',
		width:width,
		height:height,
		closable : closable,
		resizable:false,
		closeAction:'close',
		shadow : true, 
		autoScroll:false,
		html: "<iframe id='process'  style='height:100%;width=100%;' src='"+showUrl+"' ></iframe>"
    });
	win.show(this);
}

function showMapTab(){
	center.addTab("mapServices","地图服务","");
}

function closeWin(){
	win.close();
}
	
</script>
	</head>
	<body>
		<iframe id="center" style="width: 100%; height: 100%;overflow: auto;"
			src="<%=basePath%>/base/gis/pages/gisViewFrame.jsp"></iframe>
		<iframe id="east" style="width: 100%; height: 100%; overflow: auto;"></iframe>
	</body>
</html>
