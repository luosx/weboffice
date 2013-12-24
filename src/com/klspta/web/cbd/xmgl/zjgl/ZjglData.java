package com.klspta.web.cbd.xmgl.zjgl;

import java.util.List;
import java.util.Map;


import com.klspta.base.AbstractBaseBean;

public class ZjglData extends AbstractBaseBean {

    public List<Map<String, Object>> getZJGL_ZJLR(String yw_guid) {
        String sql = "select * from  XMZJGL_lr where  yw_guid=? order by  sort";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { yw_guid });
        //流入总计
        return list;
    }

    public List<Map<String, Object>> getZJGL_father(String yw_guid, String type) {
        String sql = "select * from  XMZJGL_ZC where status=? and yw_guid=? and zcstatus is  null order by  sort";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { type, yw_guid });
        return list;
    }

    public List<Map<String, Object>> getZJGL_child(String yw_guid, String tree_name, String type) {
        String sql = "select * from  XMZJGL_ZC where status=? and yw_guid=? and lb=?  and zcstatus is not null order by  sort";
        List<Map<String, Object>> list = query(sql, YW, new Object[] { type, yw_guid, tree_name });
        return list;
    }
    
    public void setMX( String yw_guid){
        String sql="select yw_guid from xmzjgl_zc where yw_guid=?";
        List<Map<String, Object>> query = query(sql, YW,new Object []{yw_guid});
        if(query.size()>0){
        }else{
        String lr_name[]={"1.1 筹融资金","1.1.1 金融机构贷款","1.1.2 实施主体带资","1.1.3 国有土地收益基金","1.2 出让回笼资金","1.3 其他资金"};
        String lr_type[]={"CRZJ","ZRJGDK","SSZTDZ","GYTDSYJJ","CRHLZJ","QTZJ"};
        String sr[]={"总计划审批","贷款审批","实施主体带资审批","国有土地收益基金审批","出让回笼资金审批","其他资金审批","实际支付","已批未付"};
        String st[]={"2.1.1 前期费用","2.1.2 拆迁费用","2.1.3 市政费用","2.1.4 财务费用","2.1.5 管理费","2.2 筹融资金返还","2.3 其他支出"};
        String s[]={"QQFY","CQFY","SZFY","CWFY","GLFY","CRZJFH","QTZC"};
        for(int i=0;i<st.length;i++){
            for(int j=0;j<sr.length;j++){
                String sqlString="insert into XMZJGL_ZC (yw_guid,status,lb,lj,sort) values(?,?,?,?,?)";
                update(sqlString, YW,new Object[]{yw_guid, s[i],st[i],sr[j],(j+1)});
            }
        }
        for(int k=0;k<lr_name.length;k++){
            String sqlString="insert into XMZJGL_LR (yw_guid,status,lb,sort) values(?,?,?,?)";
            update(sqlString, YW,new Object[]{yw_guid,lr_type[k],lr_name[k],(k+1)});
        }
        }
    }
    public void saveNode(String tree_name,String type,String yw_guid){
        String sr[]={"总计划审批","贷款审批","实施主体带资审批","国有土地收益基金审批","出让回笼资金审批","其他资金审批","实际支付","已批未付"};
        String s[]={"QQFY","CQFY","SZFY","CWFY","GLFY","CRZJFH","QTZC"};
        for(int j=0;j<sr.length;j++){
            String sqlString="insert into XMZJGL_ZC (yw_guid,status,lb,lj,zcstatus,sort) values(?,?,?,?,?,?)";
            update(sqlString, YW,new Object[]{yw_guid, type,tree_name,sr[j],type,(j+1)});
        }
    }
    
    public List<Map<String, Object>> getLR_sum(String yw_guid){
        String sql="select '资金流入' as lb,sum(ysfy) as ysfy,sum(lj) as lj,sum(yfsdz)as yfsdz,sum(zjjd) as zjjd,sum(cqye)as cqye ,sum(yy)as yy,sum(ey)as ey,sum(sany)as sany,sum(siy)as siy,sum(wy)as wy,sum(ly)as ly ,sum(qy)as qy ,sum(bay)as bay,sum(jy)as jy,sum(siyue)as siyue,sum(syy)as syy,sum(sey)as sey ,sum(lrsp)as lrsp   from xmzjgl_lr t where yw_guid=? ";
        List<Map<String, Object>> query = query(sql, YW,new Object[]{yw_guid});
        return query;
    }
    public void getZC_sum(String yw_guid){
        String sql="select '资金支出' as lb,sum(ysfy) as ysfy,sum(lj) as lj,sum(yfsdz)as yfsdz,sum(zjjd) as zjjd,sum(cqye)as cqye ,sum(yy)as yy,sum(ey)as ey,sum(sany)as sany,sum(siy)as siy,sum(wy)as wy,sum(ly)as ly ,sum(qy)as qy ,sum(bay)as bay,sum(jy)as jy,sum(siyue)as siyue,sum(syy)as syy,sum(sey)as sey ,sum(lrsp)as lrsp   from xmzjgl_zc t where yw_guid=? and sort=?";
        List<Map<String, Object>> query = query(sql, YW,new Object[]{yw_guid});
    }
    
}
