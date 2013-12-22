package com.klspta.web.cbd.xmgl.zjgl;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class ZjglData extends AbstractBaseBean {

    public List<Map<String, Object>> getZJGL_ZJLR(String yw_guid) {
        String sql = "select * from  XMZJGL_lr where  yw_guid=? order by  sort";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { yw_guid });
        return list;
    }

    public List<Map<String, Object>> getZJGL_father(String yw_guid, String type) {
        String sql = "select * from  XMZJGL_ZC where status=? and yw_guid=? order by  sort";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { type, yw_guid });
        return list;
    }

    public List<Map<String, Object>> getZJGL_child(String yw_guid, String tree_name, String type) {
        String sql = "select * from  XMZJGL_ZC where status=? and yw_guid=? and lb=? order by  sort";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { type, yw_guid, tree_name });
        return list;
    }
    
    public void setMX( String yw_guid){
        String sr[]={"总计划审批","贷款审批","实施主体带资审批","国有土地收益基金审批","出让回笼资金审批","其他资金审批","实际支付","已批未付"};
        String st[]={"2.1.1 前期费用","2.1.2 拆迁费用","2.1.3 市政费用","2.1.4 财务费用","2.1.5 管理费","2.2 筹融资金返还","2.3 其他支出"};
        String s[]={"QQFY","CQFY","SZFY","CWFY","GLFY","CRZJFH","QTZC"};
        for(int i=0;i<st.length;i++){
            for(int j=0;j<sr.length;j++){
                String sqlString="insert into XMZJGL_ZC (yw_guid,status,lb,lj) value(?,?,?,?)";
                update(sqlString, YW,new Object[]{yw_guid, s[i],st[i],sr[j]});
            }
            
        }
       
        
        
        
    }
}
