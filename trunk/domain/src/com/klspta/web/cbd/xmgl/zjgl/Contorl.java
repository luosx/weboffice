package com.klspta.web.cbd.xmgl.zjgl;


public class Contorl  {
    //Ⅱ.资金支出\2.1 一级开发支出\前期费用\拆迁费用\市政费用\财务费用\管理费用\筹融资金返还\ 其他支出\Ⅱ.资金支出
 public static String ZJZC="ZJZC";
public static String YIKFZC="YIKFZC";
public static String  QQFY="QQFY";
public static String  CQFY="CQFY";
public static String  SZFY="SZFY";
public static String  CWFY="CWFY";
public static String  GLFY="GLFY";
public static String  CRZJFH="CRZJFH";
public static String  QTZC="QTZC";

private String  yw_guid;

private ZjglThread ZJZCThread;
private ZjglThread YIKFZCThread;
private ZjglThread QQFYThread;
private ZjglThread CQFYThread;
private ZjglThread SZFYThread;
private ZjglThread CWFYThread;
private ZjglThread GLFYThread;
private ZjglThread CRZJFHThread;
private ZjglThread QTZCHThread;

public Contorl(String yw_guid){
    this.yw_guid=yw_guid;
    Init();
    try {
        Thread.sleep(3000);
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
}
public  void Init(){
    ZJZCThread = new ZjglThread(this.yw_guid,ZJZC);
    Thread thread=new Thread(ZJZCThread);
    thread.start();
    YIKFZCThread = new ZjglThread(this.yw_guid,YIKFZC);
    Thread thread1=new Thread(YIKFZCThread);
    thread1.start();
    QQFYThread=new ZjglThread(this.yw_guid,QQFY);
    Thread thread2=new Thread(QQFYThread);
    thread2.start();
    CQFYThread= new ZjglThread(this.yw_guid,CQFY);
    Thread thread3=new Thread(CQFYThread);
    thread3.start();
    SZFYThread=new ZjglThread(this.yw_guid,SZFY);
    Thread thread4=new Thread(SZFYThread);
    thread4.start();
    CWFYThread=new ZjglThread(this.yw_guid,CWFY);
    Thread thread5=new Thread(CWFYThread);
    thread5.start();
    GLFYThread=new ZjglThread(this.yw_guid,GLFY);
    Thread thread6=new Thread(GLFYThread);
    thread6.start();
    CRZJFHThread=new ZjglThread(this.yw_guid,CRZJFH);
    Thread thread7=new Thread(CRZJFHThread);
    thread7.start();
    QTZCHThread=new ZjglThread(this.yw_guid,QTZC);
    Thread thread8=new Thread(QTZCHThread);
    thread8.start(); 
    
}
private StringBuffer buffer=new StringBuffer();
public  String getTextMode(){
        //是否项目初始化
        new ZjglData().setMX(this.yw_guid);
        StringBuffer title = ZjglBuild.buildTitle();
        buffer.append(title);
        //资金流入
        StringBuffer zjlr = TrFactory.getmod(this.yw_guid);
        buffer.append(zjlr);
        buffer.append(ZJZCThread.getBuffer());
        buffer.append(YIKFZCThread.getBuffer());
        buffer.append(QQFYThread.getBuffer());
        buffer.append(CQFYThread.getBuffer());
        buffer.append(SZFYThread.getBuffer());
        buffer.append(CWFYThread.getBuffer());
        buffer.append(GLFYThread.getBuffer());
        buffer.append(CRZJFHThread.getBuffer());
        buffer.append(QTZCHThread.getBuffer());
        return this.buffer.toString();
    }
}
