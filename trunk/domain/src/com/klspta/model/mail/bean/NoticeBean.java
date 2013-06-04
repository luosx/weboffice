package com.klspta.model.mail.bean;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import com.klspta.console.ManagerFactory;
import com.klspta.console.user.User;

public class NoticeBean extends MailBase
{
	private String message;
	private User user;
	public NoticeBean(String message,User from)
	{
		this.message=message;
		this.user=from;
	}

	@Override
	public String getContent() 
	{
		String path=MailFactory.contentroot+"notice/mailModel.html";
		File file=new File(path);
		InputStream input;
		String content="";
		
		try
		{
			
			input = new BufferedInputStream(new FileInputStream(file));
			byte[] bytes=new byte[input.available()];
			input.read(bytes);
			
			content=new String(bytes,"utf-8");			
			content=content.replace("*content*", message);
			content=content.replace("*model*", getModle(user));		
			
		} catch (FileNotFoundException e)
		{
			e.printStackTrace();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		
	
		return content;
	}

	public static void main(String[] args) throws Exception 
	{
		
		User user=ManagerFactory.getUserManager().getUserWithId("8b1d408acce9cea5c8bab99f14926708");

		
		MailModelBean mail=new MailModelBean("你好","王雷",user);
	
		mail.sendMail(user, "test", mail);
		

	}

}
