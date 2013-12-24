package com.klspta.web.cbd.xmgl.zjgl;

import java.util.List;
import java.util.Map;


public class Contorl {
    //前期费用\拆迁费用\市政费用\财务费用\管理费用\筹融资金返还\ 其他支出
public static String YIKFZC="YIKFZC";
public static String  QQFY="QQFY";
public static String  CQFY="CQFY";
public static String  SZFY="SZFY";
public static String  CWFY="CWFY";
public static String  GLFY="GLFY";
public static String  CRZJFH="CRZJFH";
public static String  QTZC="QTZC";

    
    public StringBuffer  getTable(String yw_guid){
        StringBuffer stringBuffer = new StringBuffer();
       //后去table头
        StringBuffer title = ZjglBuild.buildTitle();
        stringBuffer.append(title);
        //资金流入
        StringBuffer zjlr = TrFactory.getmod(yw_guid);
        stringBuffer.append(zjlr);
        
        TreeManager treeManager = new  TreeManager();
        //一级开发-前期费用
       List<Map<String, Object>> zc_qqfy = treeManager.getZC_tree(yw_guid,QQFY);
       StringBuffer qqfy = TrFactory.getmodel(zc_qqfy,yw_guid, QQFY);
       stringBuffer.append(qqfy);
       //一级开发-拆迁费用
       List<Map<String, Object>> zc_cqfy = treeManager.getZC_tree(yw_guid, CQFY);
       StringBuffer cqfy = TrFactory.getmodel(zc_cqfy,yw_guid, CQFY);
       stringBuffer.append(cqfy);
       //一级开发-市政费用
       List<Map<String, Object>> zc_szfy = treeManager.getZC_tree(yw_guid, SZFY);
       StringBuffer szfy = TrFactory.getmodel(zc_szfy,yw_guid, CQFY);
       stringBuffer.append(szfy);
       //一级开发-财务费用
       List<Map<String, Object>> zc_cwfy = treeManager.getZC_tree(yw_guid,CWFY);
       StringBuffer cwfy = TrFactory.getmodel(zc_cwfy,yw_guid, CWFY);
       stringBuffer.append(cwfy);
       //一级开发-管理费用
       List<Map<String, Object>> zc_glfy = treeManager.getZC_tree(yw_guid,GLFY);
       StringBuffer glfy = TrFactory.getmodel(zc_glfy,yw_guid, GLFY);
       stringBuffer.append(glfy);
       //一级开发-筹融资金返还
       List<Map<String, Object>> zc_crzjfh = treeManager.getZC_tree(yw_guid,CRZJFH);
       StringBuffer crzjfh= TrFactory.getmodel(zc_crzjfh,yw_guid, CRZJFH);
       stringBuffer.append(crzjfh);
       //一级开发-其他支出
       List<Map<String, Object>> zc_qtzc = treeManager.getZC_tree(yw_guid,QTZC);
       StringBuffer qtzc = TrFactory.getmodel(zc_qtzc,yw_guid, QTZC);
       stringBuffer.append(qtzc);
        return stringBuffer;
        
    }
    
    public String getTextMode(String yw_guid){
        //是否项目初始化
        new ZjglData().setMX(yw_guid);
        StringBuffer stringBuffer = new StringBuffer();
        StringBuffer title = ZjglBuild.buildTitle();
        stringBuffer.append(title);
        TreeManager treeManager = new  TreeManager();
        //资金流入
        StringBuffer zjlr = TrFactory.getmod(yw_guid);
        stringBuffer.append(zjlr);
        TreeManager Manager = new  TreeManager();
        //一级开发-前期费用
       List<Map<String, Object>> zc_qqfy = Manager.getZC_tree(yw_guid,QQFY);
       StringBuffer qqfy = TrFactory.getmodel(zc_qqfy,yw_guid, QQFY);
       stringBuffer.append(qqfy);
       //一级开发-拆迁费用
       List<Map<String, Object>> zc_cqfy = Manager.getZC_tree(yw_guid, CQFY);
       StringBuffer cqfy = TrFactory.getmodel(zc_cqfy,yw_guid, CQFY);
       stringBuffer.append(cqfy);
       //一级开发-市政费用
       List<Map<String, Object>> zc_szfy = treeManager.getZC_tree(yw_guid, SZFY);
       StringBuffer szfy = TrFactory.getmodel(zc_szfy,yw_guid, SZFY);
       stringBuffer.append(szfy);
       //一级开发-财务费用
       List<Map<String, Object>> zc_cwfy = treeManager.getZC_tree(yw_guid,CWFY);
       StringBuffer cwfy = TrFactory.getmodel(zc_cwfy,yw_guid, CWFY);
       stringBuffer.append(cwfy);
       //一级开发-管理费用
       List<Map<String, Object>> zc_glfy = treeManager.getZC_tree(yw_guid,GLFY);
       StringBuffer glfy = TrFactory.getmodel(zc_glfy,yw_guid, GLFY);
       stringBuffer.append(glfy);
       //一级开发-筹融资金返还
       List<Map<String, Object>> zc_crzjfh = treeManager.getZC_tree(yw_guid,CRZJFH);
       StringBuffer crzjfh= TrFactory.getmodel(zc_crzjfh,yw_guid, CRZJFH);
       stringBuffer.append(crzjfh);
       //一级开发-其他支出
       List<Map<String, Object>> zc_qtzc = treeManager.getZC_tree(yw_guid,QTZC);
       StringBuffer qtzc = TrFactory.getmodel(zc_qtzc,yw_guid, QTZC);
       stringBuffer.append(qtzc);
        return stringBuffer.toString();
    }
}
