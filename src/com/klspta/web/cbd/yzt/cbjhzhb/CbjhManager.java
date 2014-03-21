package com.klspta.web.cbd.yzt.cbjhzhb;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;


public class CbjhManager extends AbstractBaseBean {
	
    public void update() throws Exception{
    	String xmmc =new String(request.getParameter("key").getBytes("iso-8859-1"), "UTF-8");
    	String index = request.getParameter("vindex");
    	String value = new String(request.getParameter("value").getBytes("iso-8859-1"), "UTF-8");
    	String field = Cbjhzhb.fields[Integer.parseInt(index) - 1][0];
    	//boolean result = new CbjhData().update(xmmc, field, value);
    	CbjhData cbjhData = new CbjhData();
    	cbjhData.setChange(xmmc, field, value);
    	ExecutorService exec = Executors.newCachedThreadPool();
    	exec.execute(cbjhData);
    	exec.shutdown();
    }
	
    String[] str = {"XMLX","XMQX","DKMC","XMWZ","XMQW","XMLB","XMZT","SFDZ","DZBV","XMZTAI",
      		"ZMJ","NYDMJ","QZGDMJ","DCTDMJ","JSYDXJ","JSYDJZ","JSYDSF","JSYDQT","GHDZD","GHJZXJ","GHJZJZ","GHJZSF",
      		"GHJZQT","SXGHNF","SXSQSJ","SXGHTJ","SXYSPF","SXHZPF","SXZDPF","SXCQXK","ZDZMJ","YWCZDZMJ","QYZDMJ","YZDMJ",
      		"JHZDMJ","CQJZMJ","CQCQBL","CQJHMJ","TZJHTZ","TZYWC","YTZXJ","YTZSZX","YTZFZX","YTZQY","JHXJ","JHZCB",
      		"JHSZX","JHFZX","JHQY","ZJHLXJ","ZJHLSZX","ZJHLFZX","ZJHLQY","LJWCKF","XCYSMJ","SFJHWC","JHWCSJ","JHWCMJ",
      		"GHYDXJ","GHYDJZ","GHYDSF","GHYDQT","WCGHJZXJ","WCGHJZJZ","WCGHJZSF","WCGHJZQT","WCKFQBCD","WCKFPX",
      		"LJGYMJ","DNGYMJ","SFJMNGY","JHGYSJ","JHGYMJ","GHYDMJXJ","GHYDMJJZ","GHYDMJSF","GHYDMJQT","GHJZGMXJ",
      		"GHJZGMJZ","GHJZGMSF","GHJZGMQT","SXGYQBCD","SXGYPX","ZYWT","SFXCFW","GDJTX","XZLY","BZ"};
    
    public void modify(){
    	String xmmc = request.getParameter("XMMC");
    	String sql = "";
    	String data = "";
    	for(int i=0; i< str.length;i++){
    	    data = request.getParameter(str[i]);
    		sql = "update jc_cbjhzhb set "+str[i]+"=? where xmmc = '"+xmmc+"'";
    		this.update(sql,YW,new Object[]{data});
    	}
    	response("{success:true}");
    }
    
    public void getName(){
        String sql = "select t.dkmc from dcsjk_kgzb t ";
        List<Map<String, Object>> getList = query(sql, YW);
        //Map<String, Object> map = new HashMap<String, Object>();
        //getList.add(map);
        response(getList);
    }
    
    public void save(){
        String dkmcs = request.getParameter("dkmc");
        dkmcs = UtilFactory.getStrUtil().unescape(dkmcs);
        String[] dkmc = dkmcs.split(",");
//        String del = "delete from cbzy_dkm where 1=1";
//        this.update(del, YW);
        String sql = "insert into cbzy_dkm dkmc values(?)";
        for(int i=0;i<dkmc.length;i++){
            this.update(sql, YW, new Object[]{dkmc[i]});
        }
        response("{success:true}");
    }
    /**
     * 获取实物储备资源地块
     * 李国明
     * 2014-3-21
     */
    public void getSelectName(){
    	String sql = "select t.dkmc from cbzy_dkm t";
        List<Map<String, Object>> getList = query(sql, YW);
       // Map<String, Object> map = new HashMap<String, Object>();
        //getList.add(map);
        response(getList);
    }
    
    /**
     * 删除储备资源地块
     * 李国明
     * 2014-3-21
     */
    public void delSelectName(){
    	String dkmcs = request.getParameter("dkmc");
    	dkmcs = UtilFactory.getStrUtil().unescape(dkmcs);
    	String[] dkmc = dkmcs.split(",");
    	String sql = "delete from cbzy_dkm where dkmc in (";
    	for(int i =0 ; i < dkmc.length ; i++){
    		if(i==dkmc.length-1){
    			sql += "?)";
    		}else{
    			sql += "?,";
    		}
    	}
    	int i = update(sql,YW,dkmc);
    	if(i>0){
    		response("{success:true}");
    	}else{
    		response("{success:false}");
    	}
    }
}
