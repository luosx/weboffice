package com.klspta.web.cbd.nd;

import java.util.List;
import java.util.Map;


import com.klspta.base.AbstractBaseBean;

public class Annual extends AbstractBaseBean{
    private static Annual Annual;
	private 	String[] cole={"#99CC00","#FFFF00","#00CCFF","#CC99FF","#CC99FF","#FF8080","#C0C0C0"}; 
	private String[][]kftlTable=null;
	private String[][]kftlTable1=null;
	private String[][]azfjsTable=null;
	private String[][]gdtlTable=null;
	private String[][]gdtlTable1=null;
	private String[][]trzqkTable=null;
	
	private  Annual(){
		 kftlTable=KFTLsql_1();
		 kftlTable1=KFTLsql_2();
		 azfjsTable=AZFJSsql();
		 gdtlTable=GDTLsql_1();
		 gdtlTable1=GDTLsql_2();
		 trzqkTable=TRZQKsql();
	 }
	
	 public static  Annual getAnnual(){
		 if (Annual == null) {
			 Annual = new Annual();
	        }
		 return Annual;
	 }
	public  String [][]getKFTL(){
		 return kftlTable;
	 }
	public  String [][]getKFTL_D(){
		 return kftlTable1;
	 }
	public  String [][]getAZFJS(){
		 return azfjsTable;
	 }
	public  String [][]getGDTL(){
		 return gdtlTable;
	 }
	public  String [][]getGDTL_D(){
		 return gdtlTable1;
	 }
	public  String [][]getTRZQK(){
		 return trzqkTable;
	 }
	/****
	 * 
	 * <br>Description:获取开发体量汇总数据
	 * <br>Author:朱波海
	 * <br>Date:2013-8-21
	 */
	public String[][] KFTLsql_1(){
		//List<List<Map<String, Object>>> arrayList = new ArrayList<List<Map<String, Object>>>();
		//Map kftlMap = new HashedMap();
		String kftl[][]=new String[4][10];
		for(int i=0;i<9;i++){ 
			int num=2012;
			String sql="select sum(征收户数) as 征收户数 ,sum(完成开发地量)as 完成开发地量 ,sum(完成开发规模) as 完成开发规模,sum(储备红线投资) as 储备红线投资 from v_开发体量 where 年度='"+(num+i)+"'";
			List<Map<String, Object>> query = query(sql, YW);
				String zshs =String.valueOf( query.get(0).get("征收户数"));
				String wckfdl =String.valueOf( query.get(0).get("完成开发地量"));
				String wckfgm =String.valueOf( query.get(0).get("完成开发规模"));
				String zbhxtz =String.valueOf( query.get(0).get("储备红线投资"));
				
				kftl[0][i]=zshs;
				kftl[1][i]=wckfdl;
				kftl[2][i]=wckfgm;
				kftl[3][i]=zbhxtz;
		}
		String sqls="select sum(征收户数) as 征收户数,sum(完成开发地量) as 完成开发地量 ,sum(完成开发规模) as 完成开发规模,sum(储备红线投资) as 储备红线投资 from v_开发体量";
		List<Map<String, Object>> list2 = query(sqls, YW);
		String zshs = String.valueOf(list2.get(0).get("征收户数"));
		String wckfdl =String.valueOf( list2.get(0).get("完成开发地量"));
		String wckfgm = String.valueOf(list2.get(0).get("完成开发规模"));
		String zbhxtz =String.valueOf( list2.get(0).get("储备红线投资"));
		kftl[0][9]=zshs;
		kftl[1][9]=wckfdl;
		kftl[2][9]=wckfgm;
		kftl[3][9]=zbhxtz;
		for(int f=0;f<kftl.length;f++){
			for(int k=0;k<10;k++){
				if(kftl[f][k]==null||kftl[f][k].equals("")||kftl[f][k].equals("null")){
					kftl[f][k]=" ";
				}
			}
		}
		return kftl;
		
	}
	/***
	 * 
	 * <br>Description:开发体量项目动态加载
	 * <br>Author:朱波海
	 * <br>Date:2013-8-23
	 * @return
	 */
public  String[][] KFTLsql_2(){
	//查找所有项目
	//String sql="select yw_guid ,xmname from xminfo";
	String sql="select distinct xmmc from plan开发体量";
	List<Map<String, Object>> list = query(sql,YW);
	int s=list.size();
	String kftlCenter[][]=new String [s][11];
	for(int i=0;i<list.size();i++){
		String xmmc=list.get(i).get("xmmc").toString();
		kftlCenter[i][0]=xmmc;
		for(int j=0;j<9;j++){
			int num=2012;
			String sqls="select  sum(tz) as tz from plan开发体量 where xmmc='"+xmmc+"' and nd='" +(num+j)+"'" ;
			List<Map<String, Object>> query = query(sqls, YW);
			String tzhj =String.valueOf(query.get(0).get("tz")) ;
			kftlCenter[i][j+1]=tzhj;
		}
		String sqlt="select sum (tz) as hj from plan开发体量 where  xmmc='"+xmmc+"' group by xmmc"   ;
		List<Map<String, Object>> li = query(sqlt, YW);
		String hj = String.valueOf(li.get(0).get("hj"));
		kftlCenter[i][10]=hj;
		
		
	}
	
		
	for(int f=0;f<kftlCenter.length;f++){
		for(int k=0;k<11;k++){
			String str=kftlCenter[f][k];
			if(k==0||k==10){
				if(kftlCenter[f][k]==null||kftlCenter[f][k].equals("")||kftlCenter[f][k].equals("null")){
					kftlCenter[f][k]=" <td style='background-color:#C0C0C0'></td>";
				}else{ kftlCenter[f][k]="<td style='background-color:#C0C0C0'>"+str+"</td>";}
			}else{
			if(kftlCenter[f][k]==null||kftlCenter[f][k].equals("")||kftlCenter[f][k].equals("null")){
				kftlCenter[f][k]="<td></td> ";
			}else{
				
				int length = cole.length;
				if(length>=kftlCenter.length){
					kftlCenter[f][k]="<td style='background-color:"+cole[f]+"'>"+str+"</td>";
				}else{
				kftlCenter[f][k]="<td style='background-color:#"+(cole[kftlCenter.length%length])+"'>"+str+"</td>";
				}
			}
			}
		}
	}
	return kftlCenter;
	
}
/***
 * 
 * <br>Description:安置房建设
 * <br>Author:朱波海
 * <br>Date:2013-8-23
 * @return
 */

public String[][] AZFJSsql(){
	String kftl[][]=new String[4][10];
	for(int i=0;i<9;i++){ 
		int num=2012;
		String sql="select sum(开工及购房量) as 开工 ,sum(投资)as 投资 ,sum(使用量) as 使用量,sum(安置房存量) as 安置房存量 from V_安置房 where 年度='"+(num+i)+"'";
		List<Map<String, Object>> query = query(sql, YW);
			String zshs =String.valueOf( query.get(0).get("开工"));
			String wckfdl =String.valueOf( query.get(0).get("投资"));
			String wckfgm =String.valueOf( query.get(0).get("使用量"));
			String zbhxtz =String.valueOf( query.get(0).get("安置房存量"));
			
			kftl[0][i]=zshs;
			kftl[1][i]=wckfdl;
			kftl[2][i]=wckfgm;
			kftl[3][i]=zbhxtz;
	}
	String sqls="select sum(开工及购房量) as 开工 ,sum(投资)as 投资 ,sum(使用量) as 使用量,sum(安置房存量) as 安置房存量 from V_安置房";
	List<Map<String, Object>> list2 = query(sqls, YW);
	String zshs = String.valueOf(list2.get(0).get("开工"));
	String wckfdl =String.valueOf( list2.get(0).get("投资"));
	String wckfgm = String.valueOf(list2.get(0).get("使用量"));
	String zbhxtz =String.valueOf( list2.get(0).get("安置房存量"));
	kftl[0][9]=zshs;
	kftl[1][9]=wckfdl;
	kftl[2][9]=wckfgm;
	kftl[3][9]=zbhxtz;
	for(int f=0;f<kftl.length;f++){
		for(int k=0;k<10;k++){
			if(kftl[f][k]==null||kftl[f][k].equals("")||kftl[f][k].equals("null")){
				kftl[f][k]=" ";
			}
		}
	}
	
	return kftl;
}
/***
 * 
 * <br>Description:供地体量
 * <br>Author:朱波海
 * <br>Date:2013-8-23
 * @return
 */
public String [][] GDTLsql_1(){
	String kftl[][]=new String[4][10];
	for(int i=0;i<9;i++){ 
		int num=2012;
		String sql="select sum(供应土地) as 供应土地 ,sum(供应规模)as 供应规模 ,sum(储备库库存) as 储备库库存,sum(储备库融资能力) as 储备库融资能力 from v_供地体量  where 年度='"+(num+i)+"'";
		List<Map<String, Object>> query = query(sql, YW);
			String zshs =String.valueOf( query.get(0).get("供应土地"));
			String wckfdl =String.valueOf( query.get(0).get("供应规模"));
			String wckfgm =String.valueOf( query.get(0).get("储备库库存"));
			String zbhxtz =String.valueOf( query.get(0).get("储备库融资能力"));
			
			kftl[0][i]=zshs;
			kftl[1][i]=wckfdl;
			kftl[2][i]=wckfgm;
			kftl[3][i]=zbhxtz;
	}
	String sqls="select sum(供应土地) as 供应土地 ,sum(供应规模)as 供应规模 ,sum(储备库库存) as 储备库库存,sum(储备库融资能力) as 储备库融资能力 from v_供地体量 ";
	List<Map<String, Object>> list2 = query(sqls, YW);
	String zshs = String.valueOf(list2.get(0).get("供应土地"));
	String wckfdl =String.valueOf( list2.get(0).get("供应规模"));
	String wckfgm = String.valueOf(list2.get(0).get("储备库库存"));
	String zbhxtz =String.valueOf( list2.get(0).get("储备库融资能力"));
	kftl[0][9]=zshs;
	kftl[1][9]=wckfdl;
	kftl[2][9]=wckfgm;
	kftl[3][9]=zbhxtz;
	for(int f=0;f<kftl.length;f++){
		for(int k=0;k<10;k++){
			if(kftl[f][k]==null||kftl[f][k].equals("")||kftl[f][k].equals("null")){
				kftl[f][k]=" ";
			}
		}
	}
	return kftl;
}
/***
 * 
 * <br>Description:开供地体量项目动态加载
 * <br>Author:朱波海
 * <br>Date:2013-8-23
 * @return
 */
public String[][] GDTLsql_2(){
	String sql="select distinct xmmc from plan供地体量";
	List<Map<String, Object>> list = query(sql,YW);
	int s=list.size();
	String kftlCenter[][]=new String [s][11];
	for(int i=0;i<list.size();i++){
		String xmmc=list.get(i).get("xmmc").toString();
		kftlCenter[i][0]=xmmc;
		for(int j=0;j<9;j++){
			int num=2012;
			String sqls="select  sum(gm) as tz from plan供地体量 where xmmc='"+xmmc+"' and nd='" +(num+j)+"'" ;
			List<Map<String, Object>> query = query(sqls, YW);
			String tzhj =String.valueOf(query.get(0).get("tz")) ;
			kftlCenter[i][j+1]=tzhj;
		}
		String sqlt="select sum (gm) as hj from plan供地体量 where  xmmc='"+xmmc+"' group by xmmc"   ;
		List<Map<String, Object>> li = query(sqlt, YW);
		String hj = String.valueOf(li.get(0).get("hj"));
		kftlCenter[i][10]=hj;
		
		
	}
	for(int f=0;f<kftlCenter.length;f++){
		for(int k=0;k<11;k++){
			String str=kftlCenter[f][k];
			if(k==0||k==10){
				if(kftlCenter[f][k]==null||kftlCenter[f][k].equals("")||kftlCenter[f][k].equals("null")){
					kftlCenter[f][k]=" <td style='background-color:#C0C0C0'></td>";
				}else{ kftlCenter[f][k]="<td style='background-color:#C0C0C0'>"+str+"</td>";}
				
			}else{
			if(kftlCenter[f][k]==null||kftlCenter[f][k].equals("")||kftlCenter[f][k].equals("null")){
				kftlCenter[f][k]=" <td></td>";
			}else{
				int length = cole.length;
				if(length>=kftlCenter.length){
					kftlCenter[f][k]="<td style='background-color:"+cole[f]+"'>"+str+"</td>";
				}else{
				kftlCenter[f][k]="<td style='background-color:#"+(cole[kftlCenter.length%length])+"'>"+str+"</td>";
				}
			}}
		}
	}
	return kftlCenter;
}
/***
 * 
 * <br>Description:投融资情况
 * <br>Author:朱波海
 * <br>Date:2013-8-23
 * @return
 */
public String[][]TRZQKsql(){
	String kftl[][]=new String[8][10];
	for(int i=0;i<9;i++){ 
		int num=2012;
		String sql="select sum(BQTZXQ) as 本期投资需求 ,sum(BQHLCB)as 本期回笼成本 ,sum(ZFTDSY) as 政府土地收益,sum(BQRZXQ) as 本期融资需求 ," +
				"sum(BQHKXQ) as 本期还款需求,sum(QYXZJZR) as 权益性资金注入,sum(FZYE) as 负债余额,sum(BQZMYE) as 本期账面余额 " +
				" from PLAN投融资情况 where ND='"+(num+i)+"'";
		List<Map<String, Object>> query = query(sql, YW);
			String nd1 =String.valueOf( query.get(0).get("本期投资需求"));
			String nd2  =String.valueOf( query.get(0).get("本期回笼成本"));
			String nd3  =String.valueOf( query.get(0).get("政府土地收益"));
			String nd4  =String.valueOf( query.get(0).get("本期融资需求"));
			String nd5  =String.valueOf( query.get(0).get("本期还款需求"));
			String nd6  =String.valueOf( query.get(0).get("权益性资金注入"));
			String nd7  =String.valueOf( query.get(0).get("负债余额"));
			String nd8  =String.valueOf( query.get(0).get("本期账面余额"));
			kftl[0][i]=nd1;
			kftl[1][i]=nd2;
			kftl[2][i]=nd3;
			kftl[3][i]=nd4;
			kftl[4][i]=nd5;
			kftl[5][i]=nd6;
			kftl[6][i]=nd7;
			kftl[7][i]=nd8;
	}
	String sqls="select sum(BQTZXQ) as 本期投资需求 ,sum(BQHLCB)as 本期回笼成本 ,sum(ZFTDSY) as 政府土地收益,sum(BQRZXQ) as 本期融资需求 ," +
	"sum(BQHKXQ) as 本期还款需求,sum(QYXZJZR) as 权益性资金注入,sum(FZYE) as 负债余额,sum(BQZMYE) as 本期账面余额 " +
	" from PLAN投融资情况 ";
	List<Map<String, Object>> query2 = query(sqls, YW);
	String nd1 =String.valueOf( query2.get(0).get("本期投资需求"));
	String nd2  =String.valueOf( query2.get(0).get("本期回笼成本"));
	String nd3  =String.valueOf( query2.get(0).get("政府土地收益"));
	String nd4  =String.valueOf( query2.get(0).get("本期融资需求"));
	String nd5  =String.valueOf( query2.get(0).get("本期还款需求"));
	String nd6  =String.valueOf( query2.get(0).get("权益性资金注入"));
	String nd7  =String.valueOf( query2.get(0).get("负债余额"));
	String nd8  =String.valueOf( query2.get(0).get("本期账面余额"));
	kftl[0][9]=nd1;
	kftl[1][9]=nd2;
	kftl[2][9]=nd3;
	kftl[3][9]=nd4;
	kftl[4][9]=nd5;
	kftl[5][9]=nd6;
	kftl[6][9]=nd7;
	kftl[7][9]=nd8;
	for(int f=0;f<kftl.length;f++){
		for(int k=0;k<10;k++){
			if(kftl[f][k]==null||kftl[f][k].equals("")||kftl[f][k].equals("null")){
				kftl[f][k]=" ";
			}
		}
	}
	return kftl;
	
	
}




}
