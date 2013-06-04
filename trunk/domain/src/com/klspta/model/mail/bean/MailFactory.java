package com.klspta.model.mail.bean;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import com.klspta.base.util.UtilFactory;
import com.klspta.console.user.User;

public class MailFactory
{
	public static HashMap<String, String> mailContent;
	public static String host;
	public static String port;
	public static String contentroot;
	public static String username;
	public static String password;
	private MailFactory instance;
	static
	{
		String s = UtilFactory.getConfigUtil().getApppath();
		try
		{
			
			FileInputStream input=new FileInputStream(s+"config.properties");
			Properties properties=new Properties();
			properties.load(input);
			MailFactory.host=properties.getProperty("mail.host");
			MailFactory.port=properties.getProperty("mail.port");
			//邮件模板根目录
			MailFactory.contentroot=properties.getProperty("mail.contentroot");
			if("default".equals(MailFactory.contentroot))
			{			
				MailFactory.contentroot=MailModelBean.class.getResource("/").getPath()+"com/klspta/model/mail/content/";				
			}
			MailFactory.username=properties.getProperty("mail.username");
			MailFactory.password=properties.getProperty("mail.password");
			//mailContent=new HashMap<String, String>();
			
			
		} catch (FileNotFoundException e)
		{
			System.out.println("config not found");
		} catch (IOException e)
		{
			System.out.println("IOException");
		}
		
	
	}
	
	public static void sendMail(List<User> addressList,String fromAccount,String passsword,String subject,MailBase mailContent)
	{
		Properties props = new Properties();
		
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.host", MailFactory.host);
		props.put("mail.smtp.port", MailFactory.port);
		
		//props.put("mail.smtp.socketFactory.port","25");
		//props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
		//props.put("mail.smtp.socketFactory.fallback", "true");
		
		Session session=Session.getDefaultInstance(props);
		
//		Session session=Session.getInstance(props,new Authenticator(){
//		      protected PasswordAuthentication getPasswordAuthentication() {
//		          return new PasswordAuthentication("Renbao.Long@ge.com","Jan0436A");
//			}});
		
		session.setDebug(false);
		
		MimeMessage message=new MimeMessage(session);
		try
		{
			message.setFrom(new InternetAddress(fromAccount));
			//message.setRecipient(Message.RecipientType.TO,new InternetAddress(mailAdress));
	
			List<InternetAddress> addresses=new ArrayList<InternetAddress>();
			String address=null;
			for(int i=0;i<addressList.size();i++)
			{
				address=addressList.get(i).getEmail();
				
				if(address==null||"".equals(address))
				{			
					continue;
				}
			
				addresses.add(new InternetAddress(address));
			}
			if(addresses.size()==0)
			{
				return;
			}
			InternetAddress[] addressArr=new InternetAddress[addresses.size()];
			for(int i=0;i<addresses.size();i++)
			{
				addressArr[i]=addresses.get(i);
			}
			message.setRecipients(Message.RecipientType.TO,addressArr);
			message.setSubject(subject);
			Multipart multipart=new MimeMultipart();
			//context
			BodyPart context=new MimeBodyPart();
			context.setContent(mailContent.getContent(),"text/html;charset=GBK");
			
			//multipart.setSubType("related");
			//attachment ppt
			//BodyPart attachment_pdf=new MimeBodyPart();
			//DataSource pdfSource=new FileDataSource(mailBean.getPdfPath());
			//attachment_pdf.setDataHandler(new DataHandler(pdfSource));
			
			sun.misc.BASE64Encoder enc = new sun.misc.BASE64Encoder();
			
			//String fileName="eCertificate_"+mailBean.getName()+".pdf";
			//attachment_pdf.setFileName("=?GBK?B?"+enc.encode(fileName.getBytes())+"?=");
			
			//attachment image
//			String[] imagePaths=mailBean.getImagePath();
//			
//			for(int i=0;i<imagePaths.length;i++)
//			{
//				BodyPart attachment_image=new MimeBodyPart();
//				
//				DataSource imageSource=new FileDataSource(imagePaths[i]);
//				attachment_image.setDataHandler(new DataHandler(imageSource));
//				String filename="IMG"+i+".gif";
//				
//				attachment_image.setFileName(filename);
//				String context_id="<IMG"+(i+1)+">";
//				
//				attachment_image.setHeader("Content-ID",context_id);
//				//multipart.addBodyPart(attachment_image);
//				
//			}
			
			multipart.addBodyPart(context);
			
			//multipart.addBodyPart(attachment_pdf);			
			//      |     \\
			
			message.setContent(multipart);
			
			message.saveChanges();
			
			//sendmail\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
			Transport transport=session.getTransport("smtp");
			transport.connect(MailFactory.host,fromAccount,passsword);
			
			transport.sendMessage(message,message.getAllRecipients());
			
			//Transport.send(message);
			
			transport.close();
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	
	public static void main(String[] args)
	{			
		//new MailFactory().sendMail("156110452@qq.com");
	}

}
