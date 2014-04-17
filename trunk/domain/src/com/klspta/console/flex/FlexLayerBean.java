package com.klspta.console.flex;

import java.util.Map;

import org.dom4j.Element;

/**
 * 
 * <br>Title:flex图层bean
 * <br>Description:
 * <br>Author:陈强峰
 * <br>Date:2014-4-10
 */
public class FlexLayerBean extends AbsFlex {
    private String layerId="";
    
    private String label = "";

    private String type = "";

    private String visible = "";

    private String url = "";

    public FlexLayerBean(Map<String, Object> map) {
        this.layerId=check(map.get("id"));
        this.label = check(map.get("label"));
        this.type = check(map.get("type"));
        this.visible = check(map.get("visible"));
        this.url = check(map.get("url"));
    }

    /**
     * 
     * <br>Description:转成flexXml配置项
     * <br>Author:陈强峰
     * <br>Date:2014-4-10
     * @return
     */
    public String toXMl() {
        StringBuffer layerBuffer = new StringBuffer();
        layerBuffer.append("     <layer ");
        layerBuffer.append(" label=\"").append(label).append("\"");
        layerBuffer.append(" type=\"").append(type).append("\"");
        layerBuffer.append(" visible=\"").append(visible).append("\"");
        layerBuffer.append(" url=\"").append(url).append("\"");
        layerBuffer.append(" />\n");
        return layerBuffer.toString();
    }
    
    public void addXMl(Element root) {
        Element element = root.addElement("layer");
        element.addAttribute("label", label);
        element.addAttribute("type", type);
        element.addAttribute("visible", visible);
        element.addAttribute("url", url);
    }

    public String getLayerId() {
        return layerId;
    }

    public String getLabel() {
        return label;
    }
}
