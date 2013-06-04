package com.klspta.base.util.api;

public interface IStrUtil {

    public String byte2String(byte[] b);

    public String unescape(String src);
  
    public String escape(String src);
    
    public String getGuid();
    
    public String changeKeyWord(String inString,String keywords);
    
    /*
     * 返回指定字符串
     */
    public String manageStr(int source, int digit);
}
