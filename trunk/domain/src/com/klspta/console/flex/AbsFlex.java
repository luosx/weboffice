package com.klspta.console.flex;

public abstract class AbsFlex {
/**
 * 
 * <br>Description:检测空值
 * <br>Author:陈强峰
 * <br>Date:2014-4-16
 * @param obj
 * @return
 */
    public String check(Object obj){
        if(obj==null){
            return "";
        }
        return obj.toString();
    }
}
