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

    private String groupLabel = "";

    private String label = "";

    private String icon = "";

    private String config = "";

    private String url = "";

    private String preload = "";

    private String left = "";

    private String top = "";

    private String right = "";

    private String bottom = "";

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
     * <br>Description:生成xml
     * <br>Author:陈强峰
     * <br>Date:2014-4-17
     * @param roleWidgetMap
     * @return
     */
    public String toXMl(Map<String, String> roleWidgetMap) {
        StringBuffer widgetBuffer = new StringBuffer();
        if (type.equals("widget")) {
            widgetToXml(widgetBuffer, roleWidgetMap);
        } else if (type.equals("group")) {
            groupToXml(widgetBuffer, roleWidgetMap);
        } else if (type.equals("container")) {
            containerToXml(widgetBuffer, roleWidgetMap);
        }
        return widgetBuffer.toString();
    }

    /**
     * 
     * <br>Description:容器生成xml
     * <br>Author:陈强峰
     * <br>Date:2014-4-17
     * @param widgetBuffer
     * @param roleWidgetBeans
     * @return
     */
    private String containerToXml(StringBuffer widgetBuffer, Map<String, String> roleWidgetBeans) {

        if (childList.size() > 0) {
            widgetBuffer.append(" <widgetcontainer");
            if (layout.length() > 0) {
                widgetBuffer.append(" layout=\"").append(layout).append("\"");
            }
            if (paneltype.length() > 0) {
                widgetBuffer.append(" paneltype=\"").append(paneltype).append("\"");
            }
            widgetBuffer.append(" initialstate=\"").append(initialstate).append("\"");
            widgetBuffer.append(" size=\"").append(size).append("\">\n");
            for (int i = 0; i < childList.size(); i++) {
                widgetBuffer.append(childList.get(i).toXMl(roleWidgetBeans));
            }
        }
        widgetBuffer.append(" </widgetcontainer>\n");
        return widgetBuffer.toString();
    }

    /**
     * 
     * <br>Description:组件组生成xml
     * <br>Author:陈强峰
     * <br>Date:2014-4-17
     * @param widgetBuffer
     * @param roleWidgetBeans
     * @return
     */
    private String groupToXml(StringBuffer widgetBuffer, Map<String, String> roleWidgetBeans) {
        widgetBuffer.append("  <widgetgroup");
        widgetBuffer.append(" label=\"").append(groupLabel).append("\">\n");
        for (int i = 0; i < childList.size(); i++) {
            widgetBuffer.append(childList.get(i).toXMl(roleWidgetBeans));
        }
        widgetBuffer.append("  </widgetgroup>\n");
        return widgetBuffer.toString();
    }

    /**
     * 
     * <br>Description:组件生产xml
     * <br>Author:陈强峰
     * <br>Date:2014-4-17
     * @param widgetBuffer
     * @param roleWidgetBeans
     * @return
     */
    private String widgetToXml(StringBuffer widgetBuffer, Map<String, String> roleWidgetBeans) {
        if (roleWidgetBeans.containsKey(getWidgetId())) {
            widgetBuffer.append("   <widget");
            widgetBuffer.append(" label=\"").append(label).append("\"");
            widgetBuffer.append(" icon=\"").append(icon).append("\"");
            widgetBuffer.append(" config=\"").append(config).append("\"");
            widgetBuffer.append(" url=\"").append(url).append("\"");
            widgetBuffer.append(" left=\"").append(left).append("\"");
            widgetBuffer.append(" right=\"").append(right).append("\"");
            widgetBuffer.append(" top=\"").append(top).append("\"");
            widgetBuffer.append(" bottom=\"").append(bottom).append("\"");
            widgetBuffer.append(" preload=\"").append(preload).append("\"/>\n");
        }
        return widgetBuffer.toString();
    }

    public void addXML(Element root, Map<String, String> roleWidgetMap) {
        if (type.equals("widget")) {
            addWidgetToXml(root, roleWidgetMap);
        } else if (type.equals("group")) {
            addGroupToXml(root, roleWidgetMap);
        } else if (type.equals("container")) {
            addContainerToXml(root, roleWidgetMap);
        }
    }

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

    private void addGroupToXml(Element root, Map<String, String> roleWidgetMap) {
        Element element = root.addElement("widgetgroup");
        element.addAttribute("label", label);
        for (int i = 0; i < childList.size(); i++) {
            childList.get(i).addXML(element, roleWidgetMap);
        }
    }

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
