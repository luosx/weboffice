package com.klspta.web.xuzhouNW.lacc.process;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.jbpm.api.task.Task;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.workflow.foundations.WorkflowInsOp;

public class ProcessList extends AbstractBaseBean {
    @SuppressWarnings( { "unchecked" })
    public void getProcessList() {

        String condition = request.getParameter("condition");
        String userName = request.getParameter("userName");
        DateFormat df = new SimpleDateFormat("yyyy年MM月dd日");
        Date date = new Date();
        List<Task> list = WorkflowInsOp.getInstance().getAllTaskListByUserName(userName);
        Collections.reverse(list);
        List allRows = new ArrayList();
        int i = 0;
        List<Map<String, Object>> listYw;
        String sql = "select t.ay,t.ajly,t.ksmc||t.grxm as dsr, to_char(t.slrq,'YYYY-MM-DD') as slrq,yw_guid,checked from lacpb t ";//where t.wfinsid=?
        Map<String, ?> map = null;
        //for (Task task : list) {
        List<String> oneRow = new ArrayList<String>();
        //listYw = query(sql, YW, new Object[] {task.getExecutionId()});
        listYw = query(sql, YW);
        //if (listYw.size() > 0) {System.out.println(task.getExecutionId());
        map = listYw.get(0);
        oneRow.add("" + (i + 1));// 序号
        oneRow.add(UtilFactory.getStrUtil().changeKeyWord((String) map.get("ay"), condition));
        oneRow.add(UtilFactory.getStrUtil().changeKeyWord((String) map.get("ajly"), condition));
        oneRow.add(UtilFactory.getStrUtil().changeKeyWord((String) map.get("dsr"), condition));
        oneRow.add(UtilFactory.getStrUtil().changeKeyWord((String) map.get("slrq"), condition));
        //oneRow.add(task.getActivityName());
        oneRow.add("受理立案");
        //oneRow.add(UtilFactory.getStrUtil().changeKeyWord(
        //	df.format(task.getCreateTime()), condition));
        oneRow.add(df.format(date));
        oneRow.add("" + i++);
        oneRow.add((String) map.get("yw_guid"));
        //oneRow.add(task.getId());// wfInsTaskId
        //oneRow.add(task.getExecutionId());// wfInsId
        oneRow.add("3660008");
        oneRow.add("ZFJC.3660008");

        oneRow.add((String) map.get("checked"));

        allRows.add(oneRow);
        //}
        //}
        response(allRows);
    }
}
