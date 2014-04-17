package com.klspta.console.flex;

import java.util.List;
import java.util.Map;

import org.dom4j.Element;

/**
 * 
 * <br>Title:flex组件bean
 * <br>Description:
 * <br>Author:陈强峰
 * <br>Date:2014-4-10
 */
public class FlexWidgetBean extends AbsFlex {
    /**
     * 类型 
     */
    private String type;

    /**
     * 主键
     */
    private String widgetId;

    /**
     * 父id
     */
    private String widgetParentId;

    /**
     * 容器布局
     */
    private String layout = "";

    /**
     * 容器类型
     */
    private String paneltype = "";

    /**
     * 容器初始状态
     */
    private String initialstate = "";

    /**
     * 容器大小
     */
    private String size = "";

    private String label = "";

    private String icon = "";

    private String config = "";

    private String url = "";

    private String preload = "";

    private String left = "";

    private String top = "";

    private String right = "";

    private String bottom = "";

    /**
     * 子组件集合
     */
    private List<FlexWidgetBean> childList;

    public FlexWidgetBean(Map<String, Object> map) {
        this.widgetId = check(map.get("id"));
        this.widgetParentId = check(map.get("parent_id"));
        this.type = check(map.get("type"));
        if (type.equals("widget")) {
            this.label = check(map.get("widget_label"));
            this.icon = check(map.get("widget_icon"));
            this.config = check(map.get("widget_config"));
            this.url = check(map.get("widget_url"));
            this.preload = check(map.get("widget_preload"));
            this.left = check(map.get("widget_left"));
            this.top = check(map.get("widget_top"));
            this.right = check(map.get("widget_right"));
            this.bottom = check(map.get("widget_bottom"));
        } else if (type.equals("group")) {
            this.label = check(map.get("group_label"));
        } else if (type.equals("container")) {
            this.layout = check(map.get("container_layout"));
            this.paneltype = check(map.get("container_paneltype"));
            this.initialstate = check(map.get("container_initialstate"));
            this.size = check(map.get("container_size"));
        }
    }

    /**
     * 
     * <br>Description:添加元素入口
     * <br>Author:陈强峰
     * <br>Date:2014-4-17
     * @param root
     * @param roleWidgetMap 权限MAP
     */
    public void addXML(Element root, Map<String, String> roleWidgetMap) {
        if (type.equals("widget")) {
            addWidgetToXml(root, roleWidgetMap);
        } else if (type.equals("group")) {
            addGroupToXml(root, roleWidgetMap);
        } else if (type.equals("container")) {
            addContainerToXml(root, roleWidgetMap);
        }
    }

    /**
     * 
     * <br>Description:添加组件容器元素
     * <br>Author:陈强峰
     * <br>Date:2014-4-17
     * @param root
     * @param roleWidgetMap
     */
    private void addWidgetToXml(Element root, Map<String, String> roleWidgetMap) {
        if (roleWidgetMap.containsKey(widgetId)) {
            Element element = root.addElement("widget");
            element.addAttribute("label", label);
            element.addAttribute("icon", icon);
            element.addAttribute("config", config);
            element.addAttribute("url", url);
            element.addAttribute("left", left);
            element.addAttribute("right", right);
            element.addAttribute("top", top);
            element.addAttribute("bottom", bottom);
            element.addAttribute("preload", preload);
        }
    }
    /**
     * 
     * <br>Description:添加组件组元素
     * <br>Author:陈强峰
     * <br>Date:2014-4-17
     * @param root
     * @param roleWidgetMap
     */
    private void addGroupToXml(Element root, Map<String, String> roleWidgetMap) {
        Element element = root.addElement("widgetgroup");
        element.addAttribute("label", label);
        for (int i = 0; i < childList.size(); i++) {
            childList.get(i).addXML(element, roleWidgetMap);
        }
    }
    /**
     * 
     * <br>Description:添加组件元素
     * <br>Author:陈强峰
     * <br>Date:2014-4-17
     * @param root
     * @param roleWidgetMap
     */
    private void addContainerToXml(Element root, Map<String, String> roleWidgetMap) {
        if (childList.size() > 0) {
            Element element = root.addElement("widgetcontainer");
            if (layout.length() > 0) {
                element.addAttribute("layout", layout);
            }
            if (paneltype.length() > 0) {
                element.addAttribute("paneltype", paneltype);
            }
            element.addAttribute("initialstate", initialstate);
            element.addAttribute("size", size);
            for (int i = 0; i < childList.size(); i++) {
                childList.get(i).addXML(element, roleWidgetMap);
            }
        }
    }

    public String getWidgetId() {
        return widgetId;
    }

    public String getType() {
        return type;
    }

    public String getWidgetParentId() {
        return widgetParentId;
    }

    public void setChildList(List<FlexWidgetBean> childList) {
        this.childList = childList;
    }

    public List<FlexWidgetBean> getChildList() {
        return childList;
    }

    public String getLabel() {
        return label;
    }
}
