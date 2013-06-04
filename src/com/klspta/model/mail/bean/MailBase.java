package com.klspta.model.mail.bean;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;


import com.klspta.console.user.User;

public abstract class MailBase
{	
	public boolean sendMail(User user,String subject,MailBase mailContent)
	{
		List<User> list=new ArrayList<User>();
		list.add(user);
		return sendMail(list,MailFactory.username,MailFactory.password,subject,mailContent);
	}
	
	public boolean sendMail(User user,String fromaccount,String password,String subject,MailBase mailContent)
	{
		List<User> list=new ArrayList<User>();
		list.add(user);
		return sendMail(list,fromaccount,password,subject,mailContent);
	}
	
	public boolean sendMail(List<User> toUsers,String subject,MailBase mailContent)
	{
		
		return sendMail(toUsers,MailFactory.username,MailFactory.password,subject,mailContent);
	}
	
	public boolean sendMail(List<User> toUsers,String fromaccount,String password,String subject,MailBase mailContent)
	{
		MailFactory.sendMail(toUsers, fromaccount,password,subject, mailContent);
		return  false;
	}
	
	
	public String getContent(String dir,String filename,Map<String,String> parameters)
	{
		return "";
	}
	
	public String getContent(String modelPaht,Map<String,String> parameters)
	{
		String path=MailModelBean.class.getResource("/").getPath()+"com/klspta/model/mail/content/model/mailModel.html";
		File file=new File(path);
		InputStream input;
		String content="";
	
		try
		{	
			
			input = new BufferedInputStream(new FileInputStream(file));
			
			byte[] bytes=new byte[input.available()];
			
			input.read(bytes);
			
			content=new String(bytes);
			
			for(Entry<String, String> entry:parameters.entrySet())
			{
				content=content.replace(entry.getKey(), entry.getValue());
			}
			
			
		} 
		catch (FileNotFoundException e)
		{
			e.printStackTrace();
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
		
		return content;
	}
	
	public String  getModle(User user)
	{
		StringBuffer model=new StringBuffer();
		model.append("苏州伽利<br>");
		model.append(user.getFullName());
		model.append("<br/>公司：苏州伽利工程技术有限公司<br/>");
//		邮编：215123
//		电话：0512-62997264
//		邮箱：baoxl@chinastis.com
		model.append("邮编：215123<br/>");
		model.append("电话：");
		model.append(user.getMobilephone());
		model.append("<br/>邮箱：");
		model.append(user.getEmail());
		model.append("<br/>");
		return model.toString();
	}
	public abstract String getContent();

}
