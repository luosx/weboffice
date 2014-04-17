package com.klspta.console.flex;

import java.util.Map;

import org.dom4j.Element;

/**
 * 
 * <br>Title:flex基础数据
 * <br>Description:
 * <br>Author:陈强峰
 * <br>Date:2014-4-10
 */
public class FlexBaseBean extends AbsFlex{

    private String title = "";

    private String subtitle = "";

    private String logo = "";

    private String style_colors = "";
    
    private String style_alpha = "";

    public FlexBaseBean(Map<String, Object> map) {
        this.title = check(map.get("title"));
        this.subtitle = check(map.get("subtitle"));
        this.logo = check(map.get("logo"));
        this.style_colors = check(map.get("style_colors"));
        this.style_alpha = check(map.get("style_alpha"));
    }

    /**
     * 
     * <br>Description:转成flexXml配置项
     * <br>Author:陈强峰
     * <br>Date:2014-4-10
     * @return
     */
    public String toXMl() {
        StringBuffer baseBuffer = new StringBuffer();
        baseBuffer.append(" <title>").append(title).append("</title>").append("\n");
        baseBuffer.append(" <subtitle>").append(subtitle).append("</subtitle>").append("\n");
        baseBuffer.append(" <logo>").append(logo).append("</logo>").append("\n");
       // baseBuffer.append(" <style>").append(style).append("</style>").append("\n");
        return baseBuffer.toString();
    }
    
    public void addXMl(Element root) {
        Element element = root.addElement("title");
        element.addText(title);
        element = root.addElement("subtitle");
        element.addText(subtitle);
        element = root.addElement("logo");
        element.addText(logo);
        element = root.addElement("style");
        Element elementColor = element.addElement("colors");
        elementColor.addText(style_colors);
        Element elementAlpha = element.addElement("alpha");
        elementColor.addText(style_colors);
    }
}
