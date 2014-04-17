package com.klspta.console.flex;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;

import com.klspta.base.AbstractBaseBean;

/**
 * 
 * <br>Title:flex操作管理类
 * <br>Description:
 * <br>Author:陈强峰
 * <br>Date:2014-4-10
 */
public class FlexManager extends AbstractBaseBean {
    public static FlexManager instance;

    private Map<String, Map<String, String>> roleLayerMaps = new HashMap<String, Map<String, String>>();

    private Map<String, Map<String, String>> roleWidgetMaps = new HashMap<String, Map<String, String>>();

    private Map<String, Document> roleXmlBeans = new HashMap<String, Document>();

    private FlexXmlBean fxb;

    private FlexManager() {
        init();
    }

    public static FlexManager getInstance(String key) throws Exception {
        if ("NEW WITH MANAGER FACTORY!".equals(key)) {
            if (instance == null)
                instance = new FlexManager();
            return instance;
        } else
            throw new Exception("请从ManagerFacoory获取工具.");
    }

    private void init() {
        flush();
    }

    /**
     * 
     * <br>Description:刷新xml配置
     * <br>Author:陈强峰
     * <br>Date:2014-4-14
     */
    private void flush() {
        fxb = new FlexXmlBean();
        String sql = "select t.title,t.subtitle,t.logo,t.style_colors,style_alpha,t.geometryservice gts,t.map_wraparound180,t.map_initialextent,t.map_fullextent,t.map_top,t.map_addarcgisbasemaps from flex_base t";
        List<Map<String, Object>> list = query(sql, CORE);
        if (list.size() > 0) {
            fxb.setGeometryservice(list.get(0).get("gts").toString());
            FlexBaseBean fbb = new FlexBaseBean(list.get(0));
            FlexMapBean fmb = new FlexMapBean(list.get(0));
            sql = "select t.id,t.label,t.type,t.visibel,t.url from flex_layers t order by t.ranking ";
            list = query(sql, CORE);
            List<FlexLayerBean> flb = new ArrayList<FlexLayerBean>();
            if (list.size() > 0) {
                for (int i = 0; i < list.size(); i++) {
                    flb.add(new FlexLayerBean(list.get(i)));
                }
            }
            fxb.setFbb(fbb);
            fmb.setLayerList(flb);
            fxb.setFmb(fmb);
        }
        sql = "select t.* from flex_widget t order by t.ranking";
        list = query(sql, CORE);
        if (list.size() > 0) {
            Map<String, List<FlexWidgetBean>> container = new HashMap<String, List<FlexWidgetBean>>();
            List<FlexWidgetBean> widgetList = new ArrayList<FlexWidgetBean>();
            //查找根
            for (int i = 0; i < list.size(); i++) {
                FlexWidgetBean fwb = new FlexWidgetBean(list.get(i));
                if (fwb.getWidgetParentId().equals("0")) {
                    widgetList.add(fwb);
                    container.put(fwb.getWidgetId(), new ArrayList<FlexWidgetBean>());
                    list.remove(i--);
                }
            }
            //查找所有节点
            for (int i = 0; i < list.size(); i++) {
                FlexWidgetBean fwb = new FlexWidgetBean(list.get(i));
                if (fwb.getType().equals("group")) {
                    List<FlexWidgetBean> childList = new ArrayList<FlexWidgetBean>();
                    for (int t = 0; t < list.size(); t++) {
                        FlexWidgetBean childBean = new FlexWidgetBean(list.get(t));
                        if (childBean.getWidgetParentId().equals(fwb.getWidgetId())) {
                            childList.add(childBean);
                            list.remove(t--);
                        }
                    }
                    fwb.setChildList(childList);
                    list.remove(i--);
                }
                container.get(fwb.getWidgetParentId()).add(fwb);
            }
            //匹配容器节点
            for (int i = 0; i < widgetList.size(); i++) {
                FlexWidgetBean fwb = widgetList.get(i);
                fwb.setChildList(container.get(fwb.getWidgetId()));
            }
            fxb.setWidgetList(widgetList);
        }
    }

    /**
     * 
     * <br>Description:根据角色获取相应xmlDom
     * <br>Author:陈强峰
     * <br>Date:2014-4-14
     * @param roleId
     */
    public Document getRoleXMLDom(String roleId) {
        Document xmlDocument = roleXmlBeans.get(roleId);
        if (xmlDocument == null) {
            if (!roleLayerMaps.containsKey(roleId)) {
                refreshRoleLayer(roleId);
            }
            if (!roleWidgetMaps.containsKey(roleId)) {
                refreshRoleWidget(roleId);
            }
            xmlDocument = fxb.getXml(roleLayerMaps.get(roleId), roleWidgetMaps.get(roleId));
            roleXmlBeans.put(roleId, xmlDocument);
        }
        return xmlDocument;
    }

    /**
     * 
     * <br>Description:刷新相应角色权限
     * <br>Author:陈强峰
     * <br>Date:2014-4-14
     * @param roleId
     */
    private void refreshWithRoleId(String roleId) {
        refreshRoleLayer(roleId);
        refreshRoleWidget(roleId);
    }

    /**
     * 
     * <br>Description:刷新角色图层
     * <br>Author:陈强峰
     * <br>Date:2014-4-16
     * @param roleId
     */
    private void refreshRoleLayer(String roleId) {
        String sql = " select t.layerid from flex_role_layer t  where t.roleid=?";
        List<Map<String, Object>> list = query(sql, CORE, new Object[] { roleId });
        Map<String, String> map = new HashMap<String, String>();
        if (list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                map.put(list.get(i).get("layerid").toString(), null);
            }
        }
        roleXmlBeans.remove(roleId);
        roleLayerMaps.remove(roleId);
        roleLayerMaps.put(roleId, map);
    }

    /**
     * 
     * <br>Description:获取角色组件树
     * <br>Author:陈强峰
     * <br>Date:2014-4-16
     * @param roleId
     * @param widgets
     * @return
     */
    private void refreshRoleWidget(String roleId) {
        String sql = " select t.widgetid from flex_role_widget t  where t.roleid=?";
        List<Map<String, Object>> list = query(sql, CORE, new Object[] { roleId });
        Map<String, String> map = new HashMap<String, String>();
        if (list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                map.put(list.get(i).get("widgetid").toString(), null);
            }
        }
        roleXmlBeans.remove(roleId);
        roleWidgetMaps.remove(roleId);
        roleWidgetMaps.put(roleId, map);
    }

    /**
     * 
     * <br>Description:获取角色图层树
     * <br>Author:陈强峰
     * <br>Date:2014-4-16
     * @param roleId
     * @param widgets
     * @return
     */
    public String getLayerCheckTreeByRoleId(String roleId) {
        if (roleLayerMaps.containsKey(roleId)) {

        } else {
            refreshRoleLayer(roleId);
        }
        Map<String, String> roleLayerMap = roleLayerMaps.get(roleId);
        StringBuffer flexBuffer = new StringBuffer();
        flexBuffer.append("[{text:'组件',checked:false,leaf:0,children:[");
        List<FlexLayerBean> layerList = fxb.getFmb().getLayerList();
        FlexLayerBean flexLayerBean;
        for (int i = 0; i < layerList.size(); i++) {
            flexLayerBean = layerList.get(i);
            flexBuffer.append("{text:'").append(flexLayerBean.getLabel()).append("',");
            flexBuffer.append("id:'").append(flexLayerBean.getLayerId()).append("',");
            flexBuffer.append("leaf:1,");
            flexBuffer.append("checked:").append(
                    roleLayerMap.containsKey(flexLayerBean.getLayerId()) ? "true" : "false");
            flexBuffer.append("}");
            if (i < layerList.size() - 1) {
                flexBuffer.append(",");
            }
        }
        flexBuffer.append("]}]");
        return flexBuffer.toString();
    }

    /**
     * 
     * <br>Description:获取角色组件权限树
     * <br>Author:陈强峰
     * <br>Date:2014-4-15
     * @param roleId
     * @return
     */
    public String getWidgetCheckTreeByRoleId(String roleId) {
        if (roleWidgetMaps.containsKey(roleId)) {

        } else {
            refreshRoleWidget(roleId);
        }
        StringBuffer flexBuffer = new StringBuffer();
        flexBuffer.append("[{text:'组件',checked:false,leaf:0,children:[");
        List<FlexWidgetBean> fwb = fxb.getWidgetList();
        for (int i = 0; i < fwb.size(); i++) {
            FlexWidgetBean firstNode = fwb.get(i);
            flexBuffer.append("{text:'").append(firstNode.getLabel()).append("',");
            flexBuffer.append("id:'").append(firstNode.getWidgetId()).append("',");
            if (firstNode.getType().endsWith("widget")) {
                flexBuffer.append("leaf:1,");
                flexBuffer.append("checked:").append(
                        roleWidgetMaps.get(roleId).containsKey(firstNode.getWidgetId()) ? "true" : "false");
            } else {
                flexBuffer.append("leaf:0");
                flexBuffer.append(",checked:false");
                if (firstNode.getChildList().size() > 0) {
                    appendChild(flexBuffer, firstNode, roleId);
                }
            }
            flexBuffer.append("}");
            if (i < fwb.size() - 1) {
                flexBuffer.append(",");
            }
        }
        flexBuffer.append("]}]");
        return flexBuffer.toString();
    }

    /**
     * 
     * <br>Description:添加子节点
     * <br>Author:陈强峰
     * <br>Date:2014-4-17
     * @param flexBuffer
     * @param fwb
     * @param roleId
     */
    private void appendChild(StringBuffer flexBuffer, FlexWidgetBean fwb, String roleId) {
        flexBuffer.append(",children:[");
        List<FlexWidgetBean> list = fwb.getChildList();
        for (int i = 0; i < list.size(); i++) {
            FlexWidgetBean firstNode = list.get(i);
            flexBuffer.append("{text:'").append(firstNode.getLabel()).append("',");
            flexBuffer.append("id:'").append(firstNode.getWidgetId()).append("',");
            if (firstNode.getType().endsWith("widget")) {
                flexBuffer.append("leaf:1,");
                flexBuffer.append("checked:").append(
                        roleWidgetMaps.get(roleId).containsKey(firstNode.getWidgetId()) ? "true" : "false");
            } else {
                flexBuffer.append("leaf:0");
                flexBuffer.append(",checked:false");
                if (firstNode.getChildList().size() > 0) {
                    appendChild(flexBuffer, firstNode, roleId);
                }
            }
            flexBuffer.append("}");
            if (i < list.size() - 1) {
                flexBuffer.append(",");
            }
        }
        flexBuffer.append("]");
    }

    /**
     * 
     * <br>Description:保存角色授权图层
     * <br>Author:陈强峰
     * <br>Date:2014-4-16
     * @param roleId
     * @param widgets
     * @return
     */
    public int saveLayerRoleMap(String roleId, String layers) {
        String sql = "delete from flex_role_layer t where t.roleid=?";
        update(sql, CORE, new Object[] { roleId });
        int count = 0;
        String[] layerArr = layers.split(",");
        sql = "insert into flex_role_layer(roleid,layerid) values(?,?)";
        for (int i = 0; i < layerArr.length; i++) {
            count += update(sql, CORE, new Object[] { roleId, layerArr[i] });
        }
        refreshRoleLayer(roleId);
        return count;
    }

    /**
     * 
     * <br>Description:保存角色授权组件
     * <br>Author:陈强峰
     * <br>Date:2014-4-16
     * @param roleId
     * @param widgets
     * @return
     */
    public int saveWidgetRoleMap(String roleId, String widgets) {
        String sql = "delete from flex_role_widget t where t.roleid=?";
        update(sql, CORE, new Object[] { roleId });
        int count = 0;
        String[] widgetArr = widgets.split(",");
        sql = "insert into flex_role_widget(roleid,widgetid) values(?,?)";
        for (int i = 0; i < widgetArr.length; i++) {
            count += update(sql, CORE, new Object[] { roleId, widgetArr[i] });
        }
        refreshRoleWidget(roleId);
        return count;
    }

}
