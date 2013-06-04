package com.klspta.base.workflow.foundations;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import net.sf.json.JSONArray;
import org.jbpm.api.task.Task;
import com.klspta.base.AbstractBaseBean;


/**
 * <br>Title:工作项列表通用工具类
 * <br>Description:
 * <br>Author:郭润沛
 * <br>Date:2011-7-1
 */
public class WorkItemListUtil extends AbstractBaseBean {
    private static WorkItemListUtil workItemIns = null;

    private WorkItemListUtil() {

    }

    public static WorkItemListUtil getInstance() {
        if (workItemIns == null) {
            workItemIns = new WorkItemListUtil();
        }
        return workItemIns;
    }

    /**
     * <br>Description:根据用户名和执法监察类型获取工作项列表
     * <br>Author:郭润沛
     * <br>Date:2011-7-1
     * @param userName
     * @param zfjcType
     * @return
     */
    public String getWorkItemList(String userName, String zfjcType) {
        List<Task> list = WorkflowInsOp.getInstance().getAllTaskListByUserName(userName);
        List allRows = new ArrayList();
        int i = 0;
        List listYw;
        for (Task task : list) {
            List oneRow = new ArrayList();
            String yw_guid = (String) WorkflowInsOp.getInstance().getParameter(task.getId(), "receiveid");
//            System.out.println(yw_guid);
            String sql = "select t.ajbh,t.ajmc, t.ajly,decode(t.balx,'P','普通案件','D','当场案件') as balx,t.slr from aj_case_main t where t.xtajbh=?";
            Object[] args = { yw_guid };
            listYw = query(sql,GTZF, args);
            if (listYw.size() > 0) {
                Map map = (Map) listYw.get(0);

                oneRow.add(yw_guid);
                //案件类型
                oneRow.add(map.get("balx"));
                //案由
                oneRow.add(map.get("ajmc"));
                //案件来源
                oneRow.add(map.get("ajly"));
                //办理人
                oneRow.add(map.get("slr"));
                //立案时间
                oneRow.add("");
                
                Date createTime = task.getCreateTime();
                oneRow.add(createTime.getYear() + "年" + createTime.getMonth() + "月" + createTime.getDay()
                        + "日");
                oneRow.add(task.getActivityName());
                oneRow.add(i++);
                oneRow.add(task.getId());
                allRows.add(oneRow);

            }

        }
        //        System.out.println(JSONArray.fromObject(allRows).toString());
        return JSONArray.fromObject(allRows).toString();
    }
}
