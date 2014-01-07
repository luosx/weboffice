package com.klspta.web.cbd.qyjc.common;

import java.util.List;
import java.util.Map;


public class ModelFactory {
    /****
     * 
     * <br>Description:一年测算展现
     * <br>Author:朱波海
     * <br>Date:2014-1-7
     * @param year
     * @param type
     * @return
     */
    public static String getOneTab(String year,String type){
        BuildModel buildModel = new BuildModel();
        DataInteraction interaction = new DataInteraction();
        List<Map<String, Object>> list = interaction.getDateList(year,type);
        String one_year = buildModel.build_One_year(list, type,year);
        return one_year;
        }
    /****
     * 
     * <br>Description:多年测算展现
     * <br>Author:朱波海
     * <br>Date:2014-1-7
     * @param year
     * @param type
     * @return
     */
    public static String getMoreTab(String []year,String type){
        BuildModel buildModel = new BuildModel();
        DataInteraction interaction = new DataInteraction();
        List<List<Map<String, Object>>> list = interaction.getDateList(year,type);
        String more_year = buildModel.build_More_year(list, type, year);
        return more_year;
        
    }
    /****
     * 
     * <br>Description:资金管理基本信息
     * <br>Author:朱波海
     * <br>Date:2014-1-6
     * @return
     */
    public static String getZjqk(){
        BuildModel buildModel = new BuildModel();
        DataInteraction interaction = new DataInteraction();
        List<Map<String, Object>> list = interaction.getXzl_Zjqk_xx();
        String table = buildModel.getZjqkTable(list);
        return  table;
        
    }
    /*****
     * 
     * <br>Description:资金管理年度
     * <br>Author:朱波海
     * <br>Date:2014-1-6
     * @return
     */
    public static String getZjqk_nd(){
        BuildModel buildModel = new BuildModel();
        DataInteraction interaction = new DataInteraction();
        List<Map<String, Object>> list = interaction.getXzl_Zjqk_pjlm();
        List<Map<String, Object>> list2 = interaction.getXzl_Zjqk_pjzj();
        String table = ((BuildModel) buildModel).getZjqkNd(list,list2);
        return  table;
        
    }
    /*****
     * 
     * <br>Description:资金管理年度信息
     * <br>Author:朱波海
     * <br>Date:2014-1-6
     * @return
     */
    public static String getZjqk_pjlm(){
        BuildModel buildModel = new BuildModel();
        DataInteraction interaction = new DataInteraction();
        List<Map<String, Object>> list = interaction.getXzl_Zjqk_pjlm();
        String table = buildModel.getZjqkNd(list);
        return  table;
        
    }
    /*****
     * 
     * <br>Description:资金管理年度信息
     * <br>Author:朱波海
     * <br>Date:2014-1-6
     * @return
     */
    public static String getZjqk_pjzj(){
        BuildModel buildModel = new BuildModel();
        DataInteraction interaction = new DataInteraction();
        List<Map<String, Object>> list = interaction.getXzl_Zjqk_pjzj();
        String table = buildModel.getZjqkNd(list);
        return  table;
        
    }
        
    } 
    
