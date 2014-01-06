package com.klspta.web.xiamen.shortmessage;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

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
        //任务编号
        String xcbh = request.getParameter("guid");
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
        
        //发送人
        String fullname = request.getParameter("fullname");
        
        if(isauto!=null){
            content +="发送人："+autoname;
        }  
        String fssj = "";
        if(istime!= null){
            fssj = time;
        }else{
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            fssj = sdf.format(date);
        }

        String fsr_name = fullname;
        User user = ManagerFactory.getUserManager().getUserWithFullName(fsr_name);
        String fsr_id = user.getUserID();
        String[] jsrys = getReceiver(users,phones);
        String jsry = StringUtils.join(jsrys,",");
        String fsr_xzqh = user.getXzqh();

        //调用OA短信接口发送短信
        
        
        
        //短信存档
        String sql = "insert into dxxxb(DXBH,DXNR,FSSJ,FSR_NAME,FSR_ID,JSRY,FSR_XZQH) values(?,?,?,?,?,?,?)";
        update(sql,YW,new Object[]{xcbh,content,fssj,fsr_name,fsr_id,jsry,fsr_xzqh});
        
        try {
            response.getWriter().write("{success:true,msg:true}");
        } catch (IOException e) {
            e.printStackTrace();
        }        
        
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
    
    private String[] getReceiver(String users,String phones){
        String[] receivers = null;      
        String[] usernames = null; 
        String[] fullnames = null;
        if(users!=null && !"".equals(users)){
            usernames = users.split(",");
            fullnames = new String[usernames.length];
            for(int i=0;i<usernames.length;i++){
                fullnames[i] = usernames[i].substring(0,usernames[i].indexOf("("));         
            }         
        }         
        String[] phonenumbers = null;
        if(phones!=null && !"".equals(phones)){
            phonenumbers = phones.split(",");           
        }  
        if(fullnames!=null && phonenumbers !=null){
            receivers = new String[fullnames.length+phonenumbers.length];
            System.arraycopy(fullnames, 0, receivers, 0, fullnames.length);   
            System.arraycopy(phonenumbers, 0, receivers, fullnames.length, phonenumbers.length);                        
        }else if(fullnames==null && phonenumbers !=null){
            receivers = phonenumbers;
        }else if(fullnames!=null && phonenumbers ==null){
            receivers = fullnames;
        }               
        return receivers;       
    }
}
