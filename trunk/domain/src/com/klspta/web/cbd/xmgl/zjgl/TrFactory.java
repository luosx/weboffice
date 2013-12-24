package com.klspta.web.cbd.xmgl.zjgl;

import java.util.List;
import java.util.Map;

public class TrFactory {

    /*****
     * 
     * <br>Description:构建父类tr
     * <br>Author:朱波海
     * <br>Date:2013-12-18
     */
    public static StringBuffer buildFather(String yw_guid, String type) {
        StringBuffer stringBuffer = ZjglBuild.buildZjzc_father(yw_guid, type);
        return stringBuffer;
    }

    /*****
     * 
     * <br>Description:构建子类tr
     * <br>Author:朱波海
     * <br>Date:2013-12-18
     */
    public static StringBuffer buildChild(String yw_guid, List<Map<String, Object>> list, String type) {
        StringBuffer buffer = new StringBuffer();
        if (list != null) {
            for (int i = 0; i < list.size(); i++) {
                String tree_name = list.get(i).get("tree_name").toString();
                StringBuffer stringBuffer = ZjglBuild.buildZjzc_child(yw_guid, tree_name, type);
                buffer.append(stringBuffer);
            }
        }

        return buffer;
    }

    public static StringBuffer getmodel(List<Map<String, Object>> list, String yw_guid, String type) {
        StringBuffer buffer = new StringBuffer();
        if (list != null||list.size()>0) {
            StringBuffer fatehr = buildFather(yw_guid, type);
            StringBuffer chaild = buildChild(yw_guid, list, type);
            buffer.append(fatehr);
            buffer.append(chaild);
            return buffer;
        } else {
            StringBuffer fatehr = buildFather(yw_guid, type);
            buffer.append(fatehr);
            return buffer;
        }

    }
    public static StringBuffer getmod(String yw_guid){
        StringBuffer buffer = new StringBuffer();
        StringBuffer stringBuffer = ZjglBuild.buildZjlr(yw_guid);
        buffer.append(stringBuffer);
        return buffer;
        
    }

}
