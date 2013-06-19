package com.klspta.web.xuzhouNW.xfjb.workflow;

import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.workflow.foundations.IWorkflowInsOp;
import com.klspta.base.workflow.foundations.WorkflowInsOp;
import com.klspta.base.workflow.foundations.WorkflowOp;
import com.klspta.console.ManagerFactory;

public class StartWorkflowXfjb extends AbstractBaseBean {
	public String yw_guid = "";

	/**
	 * 
	 * <br>
	 * Description:创建工作流实例 <br>
	 * Author:黎春行 <br>
	 * Date:2013-4-2
	 * 
	 * @throws Exception
	 */
	public void buildWorkflow() throws Exception {
		//1、获取参数 启动流程
		yw_guid = UtilFactory.getStrUtil().getGuid();
		String userId = request.getParameter("userId");
		String zfjcType = request.getParameter("zfjcType");
		String wfinsId = WorkflowOp.getInstance().start(
				zfjcType,
				ManagerFactory.getUserManager().getUserWithId(userId)
						.getFullName(), yw_guid);
		
		//2、处理业务相关初始化
		insertForm("wfxsfkxx", yw_guid);
		
		//3、response参数封装及跳转
		String urlPath = "model/workflow/pages/wf.jsp?yw_guid="
				+ yw_guid + "&zfjcType=" + zfjcType + "&wfInsId=" + wfinsId
				+ "&buttonHidden=la,return,back&zfjcName=信访举报";
		response(urlPath);
	}
	
	/**
	 * 
	 * <br>Description:相关业务表单初始化
	 * <br>Author:黎春行
	 * <br>Date:2013-6-17
	 */
	private void insertForm(String formname, String yw_guid){
		String[] formsName = formname.split("#");
		String  bh = buildID();
		for(int i = 0; i < formsName.length; i++){
			String sql = "insert into ";
			sql = sql + formsName[i] + "(yw_guid, bh) values (?, ?)";
			update(sql, YW, new Object[] { yw_guid, bh});
		}
	}
	
	
	/**
	 * 
	 * <br>Description:创建表单流水号
	 * <br>Author:黎春行
	 * <br>Date:2013-6-18
	 */
	private String buildID(){
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd", new DateFormatSymbols());
		String dateString = df.format(Calendar.getInstance().getTime());
		String numsql = "select t.bh num from wfxsfkxx t where t.bh like '" + dateString + "%' order by t.bh desc";
		String num;
		List<Map<String, Object>> result = query(numsql, YW);
		if(result.size() < 1){
			num = dateString + "001";
		}else{
			String nestNum = (String)result.get(0).get("num");
			String temp = nestNum.substring(nestNum.length() - 3, nestNum.length());
            if(Integer.parseInt(temp)>=1&&Integer.parseInt(temp)<999){   
                temp=String.valueOf(Integer.parseInt(temp)+1);   
            }   
            switch (temp.length()) {   
            case 1:   
                temp="00"+temp;   
                break;   
            case 2:   
                temp="0"+temp;   
                break;   
            default:   
                break;   
            }  
            num = dateString + temp;
		}
		return num;
	}
	
	
	/**
	 * 
	 * <br>Description:工作流的中止方法
	 * <br>Author:王雷
	 * <br>Date:2013-6-17
	 */
	public void deleteTask(){
	    String yw_guid = request.getParameter("yw_guid");
	    String wfInsId = request.getParameter("wfInsId");
	    //1.删除业务数据
	    String []datasheets={"wfxsfkxx"};
        String sql="";
	    for(int i=0;i<datasheets.length;i++){
	        sql="delete from "+datasheets[i]+" where yw_guid=?";
	        update(sql,YW,new Object[]{yw_guid});   
	    }
	    //2.删除工作流实例
	    IWorkflowInsOp workflowIns = WorkflowInsOp.getInstance();
	    workflowIns.deleteWfIns(wfInsId);
	    response("true");
	}
}
