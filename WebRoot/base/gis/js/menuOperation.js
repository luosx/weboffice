	var _$perConfig;
	var _$tabConfig;
	var _$localConfig;
	var _$hasEastTabID  = '';
	var _$urlEast = '';
	var _$test = '';
    function execute(id,text,url_center,url_east){

	    if(_$perConfig.indexOf(id) >= 0){
		    executePreFunction(id, text,url_east);
	    }
	    if(url_east != ''){
	        _$hasEastTabID = _$hasEastTabID +"," + id;
	    }
	    if(_$tabConfig.indexOf(id) >= 0){
		    if(id=='carMonitor'){
		   		window.open("/zfjc/"+url_center);
		    }else if(id=='doubleWindow'){
		   		window.open("/zfjc/"+url_center);
		    }else if(id=='swipe'){
		    	window.open('/zfjc/flexUI/SwipeSpotlight.html');
		    }else{
	    	executeCreateTab(id,text,url_center,url_east)  ;
	    	}
	    }
	    if(_$localConfig.indexOf(id) >= 0){//打开本地可执行exe
	    	var Shell=new ActiveXObject("WScript.Shell"); 
			try{ 
			  var cmd="notpad.exe"; 
			  var aa=Shell.exec(url_center); 
			}
			catch(e) 
				{ 
				Ext.Msg.alert('提示','您的电脑未安装此程序，或安装路径不正确，请系统管理员。'); 
				} 
	    }
    }
    
	function executePreFunction(id, text,url_east){
	    Ext.getCmp('east-panel').expand();
        Ext.getCmp('east-panel').setTitle(text);
		document.all.east.src=url_east;
	}
	

	function 	executeCreateTab(id,text,url_center,url_east){					
					if(url_east != ''){						
						Ext.getCmp('east-panel').expand();		//每次点击菜单时，如果和east关联，则自动伸展east区域
						center.addTab(id,text,url_center,url_east);		 				
					}else{
						Ext.getCmp('east-panel').collapse();	
						center.addTab(id,text,url_center,url_east);	 				
					}
					
	}








