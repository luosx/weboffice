package com.klspta.web.xuzhouNW.lacc;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

public class LaccManager extends AbstractBaseBean {
    /**
     * <br>
     * Description:获取立案查处待办案件 <br>
     * Author:赵伟 <br>
     * Date:2012-9-7
     */

    public void getProcessList() {
        // 获取参数
        String keyWord = request.getParameter("keyWord");
        String fullName = UtilFactory.getStrUtil().unescape(request.getParameter("fullName"));
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

        String sql = "select t.yw_guid,t.bh as ajbh ,t.ay,t.dwmc,t.ajly,t.grxm ,to_char(t.slrq,'yyyy-MM-dd hh24:mi:ss') as slrq,j.activity_name_ as bazt,j.wfInsId,to_char(j.create_ ,'yyyy-MM-dd hh24:mi:ss') as jssj,j.wfinsid from lacpb t join workflow.v_active_task j on t.yw_guid=j.yw_guid where j.assignee_=?";
        if (keyWord != null) {
            keyWord = UtilFactory.getStrUtil().unescape(keyWord);
            sql += " and (upper(t.bh)||upper(t.ay)||upper(t.ajly)||upper(t.grxm)||upper(t.slrq)||upper(j.create_)||upper(j.activity_name_) like '%"
                    + keyWord + "%')";
        }
        sql += " order by j.create_ desc";
        List<Map<String, Object>> result = query(sql, YW, new String[] { fullName });

        // 调整数据格式
        int i = 0;
        for (Map<String, Object> map : result) {
            if (map.get("dwmc") == null) {
                map.put("DSR", map.get("grxm"));
            } else {
                map.put("DSR", map.get("dwmc"));
            }
            map.put("INDEX", i++);
        }
        response(result);
    }

    /**
     * 
     * <br>
     * Description:立案查处任务下发 <br>
     * Author:陈强峰 <br>
     * Date:2012-9-11
     */
    public void getProcessListXf() {
        // 获取参数
        String keyWord = request.getParameter("keyWord");
        String userName = request.getParameter("userName");

        // 获取指定用户的所有节点任务
        String sql_tasklist = "select t1.* from jbpm4_task t1,JBPM4_EXECUTION t2 where t1.execution_id_=t2.id_ and t1.assignee_=?";
        List<Map<String, Object>> taskList = query(sql_tasklist, WORKFLOW, new String[] { userName });
        Map<String, Map<String, Object>> tasMapkList = new HashMap<String, Map<String, Object>>();
        for (int i = 0; i < taskList.size(); i++) {
            String key = taskList.get(i).get("execution_id_").toString();
            tasMapkList.put(key, taskList.get(i));
        }

        String str = "'1'";
        for (Map<String, Object> taskBean : taskList) {
            str += ",'" + taskBean.get("execution_id_").toString() + "'";
        }
        // 从立案呈批表和案源登记表中获取数据的sql
        String sql = "select  t2.ayzt ay, t2.ajly ajly,t1.yw_guid guid from lacpb t1, aydjb t2 where t1.yw_guid = t2.yw_guid and t1.checked='0'  and t1.wfinsid in ("
                + str + ")";
        if (keyWord != null) {
            keyWord = UtilFactory.getStrUtil().unescape(keyWord);
            sql += " and (upper(t2.ayzt)||upper(t2.ajly)||upper(t1.yw_guid)  like '%" + keyWord + "%')";
        }
        List<Map<String, Object>> caseList = query(sql, YW);
        response(caseList);
    }

    /**
     * <br>
     * Description:获取案件督查待办案件列表 <br>
     * Author:赵伟 <br>
     * Date:2012-9-8
     * 
     * @throws Exception
     */
    public void getajglProcessList() throws Exception {
        // 获取参数
        String keyWord = request.getParameter("keyWord");
        String userid = request.getParameter("userid");
        String name = "";
        try {
            name = "";//UtilFactory.getXzqhUtil().getNameByCode(ManagerFactory.getRoleManager().getRoleWithUserID(userid).get(0).getXzqh());
        } catch (Exception e) {
            e.printStackTrace();
        }
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        // 获取数据
        String sql = "select t.yw_guid,t.bh as ajbh,t.qy ,t.ay,t.dwmc,t.ajly,t.grxm ,to_char(t.slrq,'yyyy-MM-dd hh24:mi:ss') as slrq,j.activity_name_ as bazt,to_char(j.create_ ,'yyyy-MM-dd hh24:mi:ss') as jssj,j.assignee_,j.wfinsid from lacpb t join workflow.v_active_task j on t.yw_guid=j.yw_guid";

        if (!"徐州市".equals(name)) {
            sql += " where t.qy=?";
        }
        if (keyWord != null) {
            keyWord = UtilFactory.getStrUtil().unescape(keyWord);
            sql += " and (upper(t.bh)||upper(t.ay)||upper(t.ajly)||upper(j.assignee_)||upper(t.slrq)||upper(j.create_)||upper(j.activity_name_) like '%"
                    + keyWord + "%')";
        }
        sql += " order by j.create_";
        List<Map<String, Object>> result = null;
        if (!"徐州市".equals(name)) {
            result = query(sql, YW, new Object[] { name });
        } else {
            result = query(sql, YW);
        }

        // 调整数据格式
        int i = 0;
        for (Map<String, Object> map : result) {
            if (map.get("dwmc") == null) {
                map.put("DSR", map.get("grxm"));
            } else {
                map.put("DSR", map.get("dwmc"));
            }
            map.put("INDEX", i++);
        }
        response(result);
    }

    /**
     * <br>
     * Description:获取当前登陆人员已办案件 <br>
     * Author:赵伟 <br>
     * Date:2012-9-7
     * 
     * @throws Exception
     */
    public void getCompleteList() throws Exception {
        // 获取参数
        String keyWord = request.getParameter("keyWord");
        String fullName = UtilFactory.getStrUtil().unescape(request.getParameter("fullName"));
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

        // 获取数据
        String sql = "select t.yw_guid,t.bh as ajbh ,t.ay,t.dwmc,t.ajly,t.grxm ,to_char(t.slrq,'yyyy-MM-dd hh24:mi:ss') as slrq,j.activityname as bazt,j.wfInsId,to_char(j.create_ ,'yyyy-MM-dd hh24:mi:ss') as jssj,to_char(j.end_,'yyyy-MM-dd hh24:mi:ss') as yjsj,j.wfinsid from lacpb t join workflow.v_hist_task j on t.yw_guid=j.yw_guid where j.assignee_=?";
        if (keyWord != null) {
            keyWord = UtilFactory.getStrUtil().unescape(keyWord);
            sql += " and (upper(t.bh)||upper(t.ay)||upper(t.ajly)||upper(t.grxm)||upper(t.slrq)||upper(j.create_)||upper(j.activityname)||upper(j.end_) like '%"
                    + keyWord + "%')";
        }
        sql += " order by t.slrq desc";
        List<Map<String, Object>> result = query(sql, YW, new String[] { fullName });

        // 调整数据格式
        int i = 0;
        for (Map<String, Object> map : result) {
            if (map.get("dwmc") == null) {
                map.put("DSR", map.get("grxm"));
            } else {
                map.put("DSR", map.get("dwmc"));
            }
            map.remove("create_");
            map.put("CREATE_", map.get("jssj"));
            map.put("SLRQ", map.get("slrq"));
            map.put("INDEX", i++);
        }
        response(result);
    }

    /**
     * <br>
     * Description:获取立案查处，案件查询已办结案件 <br>
     * Author:赵伟 <br>
     * Date:2012-9-25
     */
    public void getajdcCompleteList() {
        // 获取参数
        String keyWord = request.getParameter("keyWord");
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String userid = request.getParameter("userid");
        String name = "";
        try {
            name = "";//UtilFactory.getXzqhUtil().getNameByCode(ManagerFactory.getRoleManager().getRoleWithUserID(userid).get(0).getXzqh());
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        // 获取数据
        //String sql = "select  t.yw_guid,t.bh as ajbh,t.qy ,t.ay,t.dwmc,t.ajly,t.grxm ,to_char(t.slrq,'yyyy-MM-dd') as slrq,j.activityname as bazt,to_char(j.create_ ,'yyyy-MM-dd') as jssj,to_char(j.end_,'yyyy-MM-dd hh24:mi:ss') as yjsj,j.wfinsid from lacpb t join workflow.hist_task j on t.yw_guid=j.yw_guid and  j.outcome_='结束' ";
        String sql = "select t.yw_guid,t.bh as ajbh ,t.ay,t.dwmc,t.ajly,t.grxm ,to_char(t.slrq,'yyyy-MM-dd hh24:mi:ss') as slrq,j.wfInsId,to_char(j.end_,'yyyy-MM-dd hh24:mi:ss') as yjsj,j.wfinsid from lacpb t join workflow.v_end_wfins j on t.yw_guid=j.yw_guid";
        if (!"徐州市".equals(name)) {
            sql += " where t.qy=?";
        }
        if (keyWord != null) {
            keyWord = UtilFactory.getStrUtil().unescape(keyWord);
            sql += " and (upper(t.bh)||upper(t.ay)||upper(t.ajly))||upper(t.grxm)||upper(t.slrq)||upper(j.end_)||upper(create_) like '%"
                    + keyWord + "%')";
        }
        sql += " order by t.slrq";
        List<Map<String, Object>> result = null;
        if (!"徐州市".equals(name)) {
            result = query(sql, YW, new Object[] { name });
        } else {
            result = query(sql, YW);
        }

        // 调整数据格式
        int i = 0;
        for (Map<String, Object> map : result) {
            if (map.get("dwmc") == null) {
                map.put("DSR", map.get("grxm"));
            } else {
                map.put("DSR", map.get("dwmc"));
            }
            map.remove("create_");
            //map.put("CREATE_", map.get("jssj"));
            map.put("END_", map.get("yjsj"));
            map.put("SLRQ", map.get("slrq"));
            map.put("INDEX", i++);
        }
        response(result);
    }

    /**
     * 
     * <br>
     * Description:获取节点和实例编号 <br>
     * Author:陈强峰 <br>
     * Date:2012-9-4
     */
    public void getNameAndId() {
        String guid = request.getParameter("guid");
        String sql = "select activityname,wfinsid,taskid from lacpb where yw_guid=?";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { guid });
        if (list.size() > 0) {
            response(list);
        } else {
            response("");
        }
    }

    /**
     * 
     * <br>
     * Description:获取当前案件对应的案件调查处理审批表的个数 <br>
     * Author:黎春行 <br>
     * Date:2012-10-8
     */
    public int getNumAjdccl(String guid) {
        String sql = "Select count(*) num from ajsccpb where yw_guid like ?";
        String yw_guid = guid + "v02";
        Object[] argsObjects = { yw_guid };
        List<Map<String, Object>> resuList = query(sql, YW, argsObjects);
        int i = Integer.parseInt(String.valueOf(resuList.get(0).get("num")));
        return i + 1;
    }

    public void saveBhAy() {
        String yw_guid = request.getParameter("yw_guid");
        String sjfgjzrq = request.getParameter("sjfgjzrq");
        String bh = UtilFactory.getStrUtil().unescape(request.getParameter("bh"));
        String ay = UtilFactory.getStrUtil().unescape(request.getParameter("ay"));

        String sql = "update cljdcpb set ay='" + ay + "', bh='" + bh + "',lasj=to_date('" + sjfgjzrq
                + "', 'YYYY-MM-DD HH24:MI:SS') where yw_guid = ?";
        update(sql, YW, new Object[] { yw_guid });

        String sql2 = "update jacpb set ay=?, bh=? ,lasj=to_date('" + sjfgjzrq
                + "', 'YYYY-MM-DD HH24:MI:SS') where yw_guid = ?";
        update(sql2, YW, new Object[] { ay, bh, yw_guid });

        String sql3 = "update flwscpb set ay=? where yw_guid = ?";
        update(sql3, YW, new Object[] { ay, yw_guid });
        response("true");
    }

}