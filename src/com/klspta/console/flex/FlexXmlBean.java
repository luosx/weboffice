package com.klspta.console.flex;

import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

public class FlexXmlBean {
    /**
     * 基本信息
     */
    private FlexBaseBean fbb;

    /**
     * 几何服务
     */
    private String geometryservice;

    /**
     * 地图信息
     */
    private FlexMapBean fmb;

    /**
     * 组件集合
     */
    private List<FlexWidgetBean> widgetList;

    public String toXml(Map<String, String> layerMap, Map<String, String> widgetMap) {
        StringBuffer flexBuffer = new StringBuffer("<?xml version=\"1.0\" ?>\n<configuration>\n");
        flexBuffer.append(fbb.toXMl());
        flexBuffer.append(" <geometryservice url=").append("\"").append(geometryservice).append("\"/>\n");
        flexBuffer.append(fmb.toXMl(layerMap));
        for (int i = 0; i < widgetList.size(); i++) {
            flexBuffer.append(widgetList.get(i).toXMl(widgetMap));
        }
        flexBuffer.append("</configuration>");
        return flexBuffer.toString();
    }

    public Document toXml2(Map<String, String> layerMap, Map<String, String> widgetMap) {
        Document document = DocumentHelper.createDocument();
        Element root = document.addElement("configuration");
        fbb.addXMl(root);
        Element element = root.addElement("geometryservice");
        element.addAttribute("url", geometryservice);
        fmb.addXML(root, layerMap);
        for (int i = 0; i < widgetList.size(); i++) {
            widgetList.get(i).addXML(root, widgetMap);
        }
        return document;
    }

    public void setFbb(FlexBaseBean fbb) {
        this.fbb = fbb;
    }

    public void setGeometryservice(String geometryservice) {
        this.geometryservice = geometryservice;
    }

    public void setFmb(FlexMapBean fmb) {
        this.fmb = fmb;
    }

    public void setWidgetList(List<FlexWidgetBean> widgetList) {
        this.widgetList = widgetList;
    }

    public List<FlexWidgetBean> getWidgetList() {
        return widgetList;
    }

    public FlexMapBean getFmb() {
        return fmb;
    }
}
