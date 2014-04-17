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


    public Document getXml(Map<String, String> layerMap, Map<String, String> widgetMap) {
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
