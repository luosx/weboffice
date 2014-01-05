package com.klspta.web.xiamen.shortmessage;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import com.klspta.base.AbstractBaseBean;
import com.klspta.console.ManagerFactory;
import com.klspta.console.user.User;


public class MessageManager extends AbstractBaseBean {
    
    public void save(){
        String content = request.getParameter("content");        
        String days = request.getParameter("days");
        String sendfrequency = request.getParameter("sendfrequency");
        String sendtime = request.getParameter("sendtime");       
        String selectSql = "select t.yw_guid from message t";       
        String insertSql = "insert into message(content,days,sendfrequency,sendtime) values(?,?,?,?)";
        String updateSql = "update message t set t.content=?,t.days=?,t.sendfrequency=?,t.sendtime=? where t.yw_guid=?";     
        List<Map<String,Object>> list = query(selectSql,YW);
        if(list.size()>0){
            String yw_guid = (String)(list.get(0)).get("yw_guid");
            update(updateSql,YW,new Object[]{content,days,sendfrequency,sendtime,yw_guid});
        }else{          
            update(insertSql,YW,new Object[]{content,days,sendfrequency,sendtime});
        }
        try {
            response.getWriter().write("{success:true,msg:true}");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    public void init(){
        String sql = "select t.yw_guid,t.content,t.days,t.sendfrequency,t.sendtime from message t";      
        List<Map<String,Object>> list = query(sql,YW);       
        response(list);
    }
    
    public void send(){
        //组织人员
        String users = request.getParameter("users");
        //手机号
        String phones = request.getParameter("phones");
        //获取所有电话
        String[] allPersonphone = getAllpersonphone(users,phones);
        
        //消息内容
        String content = request.getParameter("content");
        //是否自动署名
        String isauto = request.getParameter("isauto");
        //自动署名
        String autoname = request.getParameter("autoname");
        //是否定时发送
        String istime = request.getParameter("istime");
        //定时发送
        String time = request.getParameter("time");
        
        //调用OA短信接口发送短信
        
        
        
        //短信存档
        
        
        
    }
    
    
    private String[] getPersonphone(String users){
        String[] userphones = null;
        String[] usernames = null;      
        if(users!=null && !"".equals(users)){
            usernames = users.split(",");
            userphones = new String[usernames.length];
            for(int i=0;i<usernames.length;i++){
                String username = usernames[i].substring(usernames[i].indexOf("(")+1, usernames[i].indexOf(")"));
                try {
                    User user = ManagerFactory.getUserManager().getUserWithName(username);
                    userphones[i] = user.getMobilephone();
                } catch (Exception e) {                  
                    e.printStackTrace();
                }              
            }         
        }  
        return userphones;
    }
    
    private String[] getAllpersonphone(String users,String phones){
        String[] allphones = null;
        //组织人员手机号
        String[] userphones = getPersonphone(users);             
        String[] phonenumbers = null;
        if(phones!=null && !"".equals(phones)){
            phonenumbers = phones.split(",");           
        }  
        if(userphones!=null && phonenumbers !=null){
            allphones = new String[userphones.length+phonenumbers.length];
            System.arraycopy(userphones, 0, allphones, 0, userphones.length);   
            System.arraycopy(phonenumbers, 0, allphones, userphones.length, phonenumbers.length);                        
        }else if(userphones==null && phonenumbers !=null){
            allphones = phonenumbers;
        }else if(userphones!=null && phonenumbers ==null){
            allphones = userphones;
        }       
        return allphones;
    }
    
}
