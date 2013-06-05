<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.klspta.gisapp.utils.XmUtil"%>
<%@page import="com.klspta.supervisory.wpzfjc.form.WpzfjcbhtbBean"%>
<%@page import="com.klspta.supervisory.utils.WpzfjcbhtbUtil"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String jcbh = request.getParameter("jcbh");
    String yw_guid = XmUtil.selectYwGuid(jcbh);
    WpzfjcbhtbBean bhtbBean = WpzfjcbhtbUtil.getInstance().getBhtbBeanById(yw_guid);
    if(bhtbBean==null){
        bhtbBean =new WpzfjcbhtbBean();
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title></title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	</head>
	<%@ include file="/common/include/ext.jspf"%>
	<script type="text/javascript">
Ext.onReady(function() {
 var win = new Ext.Window({
					layout : 'fit',
					width : 600,
					height : 620,
					plain : true,
					closeAction : 'hide',
					listeners : {
						"hide" : function() {
							win.close();
				          window.close();
						}
					},
					items :new  Ext.form.FormPanel({
        //renderTo: 'bhtbInfo',
        autoHeight: true,
        frame:true,
        labelWidth:120,
        bodyStyle:'padding:5px 5px 0',
        width: 600, 
        items:[{ 
        	layout:'column', 
        	items:[{
        	columnWidth:.5,
        	layout:'form', 
        	defaults:{readOnly:true},  
        	items   : [
   			{ 	  						
                xtype: 'textfield',
                id      : 'kc01',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc01()%>',
                fieldLabel: '行政区划代码'
            },
            {
                xtype     : 'textfield',
           		id:'kc02',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc02()%>',
                fieldLabel: '行政区划名称'  
            }]
            },{
            	columnWidth:.5,
        		layout:'form',
        		defaults:{readOnly:true}, 
        	items:[{
                xtype: 'textfield',
                id      : 'kc03',
              	anchor:'95%',
              	value:'<%=bhtbBean.getKc03()%>',
                fieldLabel: '核查年度'
            },
            {
                xtype: 'textfield',
                id      : 'kc04',
              	anchor:'95%',
              	value:'<%=bhtbBean.getKc04()%>',
                fieldLabel: '地块编号'
            }]
            },
            {	
            	columnWidth:.5,
        		layout:'form', 
        		defaults:{readOnly:true},
        	items:[{
                xtype: 'textfield',
                id      : 'kc05',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc05()%>',
                fieldLabel: '图斑编号'
            },
            {
                xtype: 'textfield',
                id      : 'kc06',
                anchor:'95%',
                value:'<%=bhtbBean.getKc06()%>',
                fieldLabel: '土地坐落'
            }]
            },
            {
            	columnWidth:.5,
        		layout:'form', 
        		defaults:{readOnly:true},
        	items:[{
                xtype: 'textfield',
                id      : 'kc07',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc07()%>',
                fieldLabel: '土地面积'
            },{
            	xtype: 'textfield',
                id      : 'kc08',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc08()%>',
                fieldLabel: '填表单位' 
              }]
           },{
            	columnWidth:.5,
        		layout:'form', 
        		defaults:{readOnly:true},
        	items:[{
                xtype: 'textfield',
                id      : 'kc09',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc09()%>',
                fieldLabel: '填表时间'
            },{
            	xtype: 'textfield',
                id      : 'kc10',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc10()%>',
                fieldLabel: '填表人' 
              }]
           },{
            	columnWidth:.5,
        		layout:'form', 
        		defaults:{readOnly:true},
        	items:[{
                xtype: 'textfield',
                id      : 'kc11',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc11()%>',
                fieldLabel: '审核人'
            },{
            	xtype: 'textfield',
                id      : 'kc12',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc12()%>',
                fieldLabel: '土地类型' 
              }]
           },{
            	columnWidth:.5,
        		layout:'form', 
        		defaults:{readOnly:true},
        	items:[{
                xtype: 'textfield',
                id      : 'kc13',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc13()%>',
                fieldLabel: '用地单位(个人)'
            },{
            	xtype: 'textfield',
                id      : 'kc14',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc14()%>',
                fieldLabel: '用地时间' 
              }]
           },{
            	columnWidth:.5,
        		layout:'form', 
        		defaults:{readOnly:true},
        	items:[{
                xtype: 'textfield',
                id      : 'kc15',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc15()%>',
                fieldLabel: '实际用途'
            },{
            	xtype: 'textfield',
                id      : 'kc16',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc16()%>',
                fieldLabel: '是否集体' 
              }]
           },{
            	columnWidth:.5,
        		layout:'form', 
        		defaults:{readOnly:true},
        	items:[{
                xtype: 'textfield',
                id      : 'kc17',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc17()%>',
                fieldLabel: '是否国有'
            },{
            	xtype: 'textfield',
                id      : 'kc18',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc18()%>',
                fieldLabel: '集体面积' 
              }]
           },{
            	columnWidth:.5,
        		layout:'form', 
        		defaults:{readOnly:true},
        	items:[{
                xtype: 'textfield',
                id      : 'kc19',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc19()%>',
                fieldLabel: '国有面积'
            },{
            	xtype: 'textfield',
                id      : 'kc20',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc20()%>',
                fieldLabel: '农用地面积' 
              }]
           },{
            	columnWidth:.5,
        		layout:'form', 
        		defaults:{readOnly:true},
        	items:[{
                xtype: 'textfield',
                id      : 'kc21',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc21()%>',
                fieldLabel: '耕地面积'
            },{
            	xtype: 'textfield',
                id      : 'kc22',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc22()%>',
                fieldLabel: '基本农田面积' 
              }]
           },{
            	columnWidth:.5,
        		layout:'form', 
        		defaults:{readOnly:true},
        	items:[{
                xtype: 'textfield',
                id      : 'kc23',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc23()%>',
                fieldLabel: '未利用地面积'
            },{
            	xtype: 'textfield',
                id      : 'kc24',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc24()%>',
                fieldLabel: '符合规划面积' 
              }]
           },{
            	columnWidth:.5,
        		layout:'form', 
        		defaults:{readOnly:true},
        	items:[{
                xtype: 'textfield',
                id      : 'kc25',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc25()%>',
                fieldLabel: '不符合规划面积'
            },{
            	xtype: 'textfield',
                id      : 'kc26',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc26()%>',
                fieldLabel: '占用基本农田面积' 
              }]
           },{
            	columnWidth:.5,
        		layout:'form', 
        		defaults:{readOnly:true},
        	items:[{
                xtype: 'textfield',
                id      : 'kc27',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc27()%>',
                fieldLabel: '项目类型'
            },{
            	xtype: 'textfield',
                id      : 'kc28',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc28()%>',
                fieldLabel: '立项批准文号' 
              }]
           },{
            	columnWidth:.5,
        		layout:'form', 
        		defaults:{readOnly:true},
        	items:[{
                xtype: 'textfield',
                id      : 'kc29',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc29()%>',
                fieldLabel: '是否合法性审查'
            },{
            	xtype: 'textfield',
                id      : 'kc30',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc30()%>',
                fieldLabel: '违法主体' 
              }]
           },{
            	columnWidth:.5,
        		layout:'form', 
        		defaults:{readOnly:true},
        	items:[{
                xtype: 'textfield',
                id      : 'kc31',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc31()%>',
                fieldLabel: '违法类型'
            },{
            	xtype: 'textfield',
                id      : 'kc32',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc32()%>',
                fieldLabel: '受理机关' 
              }]
           },{
            	columnWidth:.5,
        		layout:'form', 
        		defaults:{readOnly:true},
        	items:[{
                xtype: 'textfield',
                id      : 'kc33',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc33()%>',
                fieldLabel: '受理时间'
            },{
            	xtype: 'textfield',
                id      : 'kc34',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc34()%>',
                fieldLabel: '是否通过巡查发现' 
              }]
           },{
            	columnWidth:.5,
        		layout:'form', 
        		defaults:{readOnly:true},
        	items:[{
                xtype: 'textfield',
                id      : 'kc35',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc35()%>',
                fieldLabel: '发现时间'
            },{
            	xtype: 'textfield',
                id      : 'kc36',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc36()%>',
                fieldLabel: '立案时间' 
              }]
           },{
            	columnWidth:.5,
        		layout:'form', 
        		defaults:{readOnly:true},
        	items:[{
                xtype: 'textfield',
                id      : 'kc37',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc37()%>',
                fieldLabel: '立案编号'
            },{
            	xtype: 'textfield',
                id      : 'kc38',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc38()%>',
                fieldLabel: '是否紧急用地' 
              }]
           },{
            	columnWidth:.5,
        		layout:'form', 
        		defaults:{readOnly:true},
        	items:[{
                xtype: 'textfield',
                id      : 'kc39',
               	anchor:'95%',
               	value:'<%=bhtbBean.getKc39()%>',
                fieldLabel: '立案查处结果'
            }]
           }]   
    }] 
}),
					buttons : [{
								text : '关闭',
								handler : function() {
									win.hide();
								}
							}]
	});
var flag='<%=bhtbBean.getKc01()%>';	
   if(flag==""){
    Ext.Msg.alert('提示', '未查询到卫片相关项目！',function clo(){ window.close();});
	}else{
   win.show();
   }
});
 //window.showModalDialog("/zfjc/supervisory/wpzfjc/pages/bhtb/bhtbInfo.jsp?yw_guid=<%=yw_guid%>","","dialogWidth=600px;dialogHeight=550px;status=no;scroll=no")
 // window.close();
</script>
	<body>
	</body>
</html>
