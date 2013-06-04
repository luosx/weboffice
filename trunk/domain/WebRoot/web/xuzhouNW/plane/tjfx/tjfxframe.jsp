<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.klspta.model.projectinfo.ProjectInfo"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>执法监察统计分析</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<%@ include file="/base/include/ext.jspf"%>
		<style type="text/css">
html,body {
	font: normal 12px verdana;
	margin: 0;
	padding: 0;
	border: 0 none;
	overflow: hidden;
	height: 100%;
}

.x-panel-body p {
	margin: 5px;
}

.x-column-layout-ct .x-panel {
	margin-bottom: 5px;
}

.x-column-layout-ct .x-panel-dd-spacer {
	margin-bottom: 5px;
}

.settings {
	background-image: url(../shared/icons/fam/folder_wrench.png) !important;
}

.nav {
	background-image: url(../shared/icons/fam/folder_go.png) !important;
}
</style>
		<script type="text/javascript">	
	
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
                   document.location.reload();
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
  var left;
  var node= new Ext.tree.AsyncTreeNode({
	            expanded: true,
	            children: [{text: '合肥市',leaf:0,id:'320300',url:'web/xuzhouNW/plane/tjfx/qbtb_main.jsp?xzqhdm=3701__',expanded: true,children:
	                        [
	                             {text: '瑶海区',leaf:0,id:'370102',url :'web/xuzhouNW/plane/tjfx/qbtb_main.jsp?xzqhdm=370102',children:[]},
	                             {text: '庐阳区',leaf:0,id:'370181',url :'web/xuzhouNW/plane/tjfx/qbtb_main.jsp?xzqhdm=370181',children:[]},
                                 {text: '蜀山区',leaf:0,id:'370104',url :'web/xuzhouNW/plane/tjfx/qbtb_main.jsp?xzqhdm=370104',children:[]},
                                 {text: '包河区',leaf:0,id:'370105',url :'web/xuzhouNW/plane/tjfx/qbtb_main.jsp?xzqhdm=370105',children:[]},
                                 {text: '滨湖新区',leaf:0,id:'370113',url :'web/xuzhouNW/plane/tjfx/qbtb_main.jsp?xzqhdm=370113',children:[]},
                                  {text: '巢湖市',leaf:0,id:'370103',url :'web/xuzhouNW/plane/tjfx/qbtb_main.jsp?xzqhdm=370103',children:[]},
                                 {text: '高新区',leaf:0,id:'370112',url :'web/xuzhouNW/plane/tjfx/qbtb_main.jsp?xzqhdm=370112',children:[]},
                                 {text: '肥西县',leaf:0,id:'370125',url :'web/xuzhouNW/plane/tjfx/qbtb_main.jsp?xzqhdm=370125',children:[]},
                                 {text: '庐江县',leaf:0,id:'370124',url :'web/xuzhouNW/plane/tjfx/qbtb_main.jsp?xzqhdm=370124',children:[]},
                                 {text: '长丰县',leaf:0,id:'370101',url :'web/xuzhouNW/plane/tjfx/qbtb_main.jsp?xzqhdm=370101',children:[]},
                                 {text: '肥东县',leaf:0,id:'370126',url :'web/xuzhouNW/plane/tjfx/qbtb_main.jsp?xzqhdm=370126',children:[]}
                              ]}]
                                                      
	        })
  Ext.onReady(function(){
	left = new Ext.tree.TreePanel({
		region:"west",
		id:'west',
		title:"行政区",
		collapsible: true,
	    useArrows: true,
	    autoScroll: true,
	    animate: true,
	    enableDD: true,
	    autoHeight: false,
	    width: 200,
	    border: false,
	    margins: '2 2 0 2',
	    containerScroll: true,
	    rootVisible: false,

		listeners:{
			click:function(n){
				var url=n.attributes.url;
				var id =n.attributes.id;
				if(url){
					if(center.getItem(id)){
						//表示标签已打开，则激活
						center.setActiveTab(id);
					}else{
					var ifr = document.createElement("IFRAME"); 
					document.body.appendChild(ifr);  
					 ifr.height='100%';
					  ifr.width='100%';
					 ifr.src = url; 
					ifr.id=id+"_ifr";
						var p =new Ext.Panel({
							title:n.attributes.text,
							id:id,
							contentEl: id+'_ifr',
							closable:true
						});
						center.add(p);
						center.setActiveTab(p);
					}
					
				}
			}
		},
		root:node	
	});

	var center = new Ext.TabPanel({
		region:"center",
		enableTabScroll:true, 
		defaults:{autoScroll:true},
		plugins: new Ext.ux.TabCloseMenu(),
		animScroll:true, 
		activeTab:0,	
		
		enableTabScroll:true
	});
	center.setActiveTab("370100");
		
	var vp = new Ext.Viewport({
		layout:"border",
		items:[left,center]
	})
	var ifr = document.createElement("IFRAME"); 
	document.body.appendChild(ifr);  
	ifr.height='100%';
	ifr.width='100%';
	ifr.src = "web/xuzhouNW/plane/tjfx/qbtb_main.jsp?xzqhdm=3701__"; 
	ifr.id="370100_ifr";
	var p =new Ext.Panel({
	  title:"合肥市",
	  id:"370100",
	  contentEl: "370100_ifr",
	  closable:true
	   });
	center.add(p);
	center.setActiveTab(p);
})
	</script>
	</head>
	<body>

	</body>
</html>
