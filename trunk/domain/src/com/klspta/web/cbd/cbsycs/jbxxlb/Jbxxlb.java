package com.klspta.web.cbd.cbsycs.jbxxlb;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class Jbxxlb extends AbstractBaseBean {
	private  LinkedList<String[][]> linkList = new LinkedList<String[][]>();
	private static Jbxxlb jbxxlb=new Jbxxlb();
	private Jbxxlb(){
		 getXX();
	}
	
	public static  Jbxxlb getInstance(){
		if(jbxxlb==null){
			jbxxlb=	 new Jbxxlb();
		}
		return jbxxlb;
	}
	
	public LinkedList getList(){
		return linkList;
	} 

	public LinkedList<String [][]> getXX() {
		 //合计
		linkList.add(getHJ());
		// 获取行政区划
		String sql_1 = " select code ,name from dkxzq t where parent_code='0'";
		List<Map<String, Object>> query = query(sql_1, YW);
		// 获取区域
		for (int i = 0; i < query.size(); i++) {
			//小计
			String xiaoji[][] =new String [1][22];
			String xiaoj= " select sum(GHZD) as GHZD,sum (GHJSYD)as GHJSYD ,round(sum(GHJZGM)/sum(GHZD),2) as GHRJL,sum(GHJZGM) as GHJZGM , '--'as GHGHYT," +
			" sum (GHGJJZGM) as GHGJJZGM,sum(GHJZJZGM)as GHJZJZGM ,sum(GHSZJZGM) as GHSZJZGM,sum(CQZZSGM)as CQZZSGM ," +
			"sum(CQZZZSGM) as CQZZZSGM,sum (CQZZZSHS) as CQZZZSHS ,round(sum(CQZZZSGM)/sum (CQZZZSHS)*10000 ,2)as CQHJMJ,sum(CQFZZZSGM) as CQFZZZSGM,sum(CQFZZJS) as CQFZZJS," +
			"sum(GHRJL) as CBSYKFCB ,round(sum(CBSYKFCB)/sum(GHRJL)*10000,2 ) as CBSYLMCB,round(sum(CBSYKFCB)/sum(GHJSYD)*10000 ,2)as CBSYDMCB,round(3/sum(GHRJL)-sum(CBSYKFCB) ,2)as CBSYYJZFTDSY,round(1-sum(CBSYKFCB)/(3*sum(GHRJL)),2)as CBSYCXB," +
			"round(sum(CQZZZSGM)/sum(GHZD),2) as QTCQQD,round(sum(GHRJL)*2.4/sum(GHRJL),2) as QTCBFGL from DKINFO where DKXZQ like '"+query.get(i).get("code").toString().substring(0,1)+"%'";
			List<Map<String, Object>> list = query(xiaoj, YW);
			xiaoji[0][0] = "<tr style='background: #83C133; text-align: center; font: normal 18px verdana;'> <td>"+String.valueOf(query.get(i).get("name"))+" 小计</td>";
			xiaoji[0][1] = String.valueOf(list.get(0).get("GHZD"));
			xiaoji[0][2] = String.valueOf(list.get(0).get("GHJSYD"));
			xiaoji[0][3] = String.valueOf(list.get(0).get("GHRJL"));
			xiaoji[0][4] = String.valueOf(list.get(0).get("GHJZGM"));
			
			xiaoji[0][5] = String.valueOf(list.get(0).get("GHGHYT"));
			xiaoji[0][6] = String.valueOf(list.get(0).get("GHGJJZGM"));
			xiaoji[0][7] = String.valueOf(list.get(0).get("GHJZJZGM"));
			xiaoji[0][8] = String.valueOf(list.get(0).get("GHSZJZGM"));
			xiaoji[0][9] = String.valueOf(list.get(0).get("CQZZZSGM"));
			
			xiaoji[0][10] = String.valueOf(list.get(0).get("CQZZZSGM"));
			xiaoji[0][11] = String.valueOf(list.get(0).get("CQZZZSHS"));
			xiaoji[0][12] = String.valueOf(list.get(0).get("CQHJMJ"));
			xiaoji[0][13] = String.valueOf(list.get(0).get("CQFZZZSGM"));
			xiaoji[0][14] = String.valueOf(list.get(0).get("CQFZZJS"));
			xiaoji[0][15] = String.valueOf(list.get(0).get("CBSYKFCB"));
			
			xiaoji[0][16] = String.valueOf(list.get(0).get("CBSYLMCB"));
			xiaoji[0][17] = String.valueOf(list.get(0).get("CBSYDMCB"));
			xiaoji[0][18] = String.valueOf(list.get(0).get("CBSYYJZFTDSY"));
			xiaoji[0][19] = String.valueOf(list.get(0).get("CBSYCXB"));
			xiaoji[0][20] = String.valueOf(list.get(0).get("QTCQQD"));
		
			xiaoji[0][21] = String.valueOf(list.get(0).get("QTCBFGL"));
			for(int w=1;w<22;w++){
				if(w==22){
					xiaoji[0][w]="<td>"+xiaoji[0][w]+"</td></tr>";
				}else{
				if(	xiaoji[0][w]==null||xiaoji[0][w].equals("")||xiaoji[0][w].equals("null")){
					xiaoji[0][w]="<td></td>";
					
				}else{
					String str=xiaoji[0][w];
					xiaoji[0][w]="<td>"+str+"</td>";	
					
				}
				}
			}
			linkList.add(xiaoji);
			
							String sql_2 = "select code ,name from  dkxzq t where parent_code!='0' and parent_code like '"+query.get(i).get("code").toString().substring(0,1)+"%'";
							List<Map<String, Object>> query2 = query(sql_2, YW);
							for (int j = 0; j < query2.size(); j++) {
								String[][] xj = new String[1][22];
								String xjs = " select sum(GHZD) as GHZD,sum (GHJSYD)as GHJSYD ,round(sum(GHJZGM)/sum(GHZD),2) as GHRJL,sum(GHJZGM) as GHJZGM , '--'as GHGHYT," +
								" sum (GHGJJZGM) as GHGJJZGM,sum(GHJZJZGM)as GHJZJZGM ,sum(GHSZJZGM) as GHSZJZGM,sum(CQZZSGM)as CQZZSGM ," +
								"sum(CQZZZSGM) as CQZZZSGM,sum (CQZZZSHS) as CQZZZSHS ,round(sum(CQZZZSGM)/sum (CQZZZSHS)*10000 ,2)as CQHJMJ,sum(CQFZZZSGM) as CQFZZZSGM,sum(CQFZZJS) as CQFZZJS," +
								"sum(GHRJL) as CBSYKFCB ,round(sum(CBSYKFCB)/sum(GHRJL)*10000,2 ) as CBSYLMCB,round(sum(CBSYKFCB)/sum(GHJSYD)*10000 ,2)as CBSYDMCB,round(3/sum(GHRJL)-sum(CBSYKFCB) ,2)as CBSYYJZFTDSY,round(1-sum(CBSYKFCB)/(3*sum(GHRJL)),2)as CBSYCXB," +
								"round(sum(CQZZZSGM)/sum(GHZD),2) as QTCQQD,round(sum(GHRJL)*2.4/sum(GHRJL),2) as QTCBFGL from DKINFO where DKXZQ='"+query2.get(j).get("code")+"' ";
								
								List<Map<String, Object>> que_xj = query(xjs, YW);
								//去掉null
								xj[0][0] = "<tr style='background: #C0C0C0; text-align: center; font: normal 18px verdana;'> <td>"+String.valueOf(query2.get(j).get("name"))+"</td>";
								xj[0][1] = String.valueOf(que_xj.get(0).get("GHZD"));
								xj[0][2] = String.valueOf(que_xj.get(0).get("GHJSYD"));
								xj[0][3] = String.valueOf(que_xj.get(0).get("GHRJL"));
								xj[0][4] = String.valueOf(que_xj.get(0).get("GHJZGM"));
								
								xj[0][5] = String.valueOf(que_xj.get(0).get("GHGHYT"));
								xj[0][6] = String.valueOf(que_xj.get(0).get("GHGJJZGM"));
								xj[0][7] = String.valueOf(que_xj.get(0).get("GHJZJZGM"));
								xj[0][8] = String.valueOf(que_xj.get(0).get("GHSZJZGM"));
								xj[0][9] = String.valueOf(que_xj.get(0).get("CQZZZSGM"));
								
								xj[0][10] = String.valueOf(que_xj.get(0).get("CQZZZSGM"));
								xj[0][11] = String.valueOf(que_xj.get(0).get("CQZZZSHS"));
								xj[0][12] = String.valueOf(que_xj.get(0).get("CQHJMJ"));
								xj[0][13] = String.valueOf(que_xj.get(0).get("CQFZZZSGM"));
								xj[0][14] = String.valueOf(que_xj.get(0).get("CQFZZJS"));
								xj[0][15] = String.valueOf(que_xj.get(0).get("CBSYKFCB"));
								
								xj[0][16] = String.valueOf(que_xj.get(0).get("CBSYLMCB"));
								xj[0][17] = String.valueOf(que_xj.get(0).get("CBSYDMCB"));
								xj[0][18] = String.valueOf(que_xj.get(0).get("CBSYYJZFTDSY"));
								xj[0][19] = String.valueOf(que_xj.get(0).get("CBSYCXB"));
								xj[0][20] = String.valueOf(que_xj.get(0).get("QTCQQD"));
							
								xj[0][21] = String.valueOf(que_xj.get(0).get("QTCBFGL"));
								for(int w=1;w<22;w++){
									if(w==22){
										xj[0][w]="<td>"+xj[0][w]+"</td></tr>";
									}else{
									if(	xj[0][w]==null||xj[0][w].equals("")||xj[0][w].equals("null")){
										xj[0][w]="<td></td>";
										
									}else{
										String str=xj[0][w];
										xj[0][w]="<td>"+str+"</td>";	
										
									}
									}
								}
								
								linkList.add(xj);
								String sql_3 = " select DKNAME,GHZD,GHJSYD,GHRJL,GHJZGM," +
										"GHGHYT,GHGJJZGM,GHJZJZGM,GHSZJZGM,CQZZSGM," +
										"CQZZZSGM,CQZZZSHS,CQHJMJ,CQFZZZSGM,CQFZZJS," +
										"CBSYKFCB,CBSYLMCB,CBSYDMCB,CBSYYJZFTDSY,CBSYCXB," +
										"QTCQQD,QTCBFGL from DKINFO where DKXZQ='"+query2.get(j).get("code").toString()+"' ";
								List<Map<String, Object>> query3 = query(sql_3, YW);
								if (query3.size() > 0) {
									String[][] xx = new String[query3.size()][22];
									for (int f = 0; f < query3.size(); f++) {
										xx[f][0] = "<tr><td>"+String.valueOf(query3.get(f).get("DKNAME"))+"</td>";
										xx[f][1] ="<td>"+ String.valueOf(query3.get(f).get("GHZD"))+"</td>";
										xx[f][2] = "<td>"+String.valueOf(query3.get(f).get("GHJSYD"))+"</td>";
										xx[f][3] ="<td>"+ String.valueOf(query3.get(f).get("GHRJL"))+"</td>";
										xx[f][4] ="<td>"+ String.valueOf(query3.get(f).get("GHJZGM"))+"</td>";
										
										xx[f][5] = "<td>"+String.valueOf(query3.get(f).get("GHGHYT"))+"</td>";
										xx[f][6] ="<td>"+ String.valueOf(query3.get(f).get("GHGJJZGM"))+"</td>";
										xx[f][7] ="<td>"+ String.valueOf(query3.get(f).get("GHJZJZGM"))+"</td>";
										xx[f][8] = "<td>"+String.valueOf(query3.get(f).get("GHSZJZGM"))+"</td>";
										xx[f][9] ="<td>"+ String.valueOf(query3.get(f).get("CQZZZSGM"))+"</td>";
										
										xx[f][10] = "<td>"+String.valueOf(query3.get(f).get("CQZZZSGM"))+"</td>";
										xx[f][11] = "<td>"+String.valueOf(query3.get(f).get("CQZZZSHS"))+"</td>";
										xx[f][12] = "<td>"+String.valueOf(query3.get(f).get("CQHJMJ"))+"</td>";
										xx[f][13] = "<td>"+String.valueOf(query3.get(f).get("CQFZZZSGM"))+"</td>";
										xx[f][14] ="<td>"+ String.valueOf(query3.get(f).get("CQFZZJS"))+"</td>";
										xx[f][15] = "<td>"+String.valueOf(query3.get(f).get("CBSYKFCB"))+"</td>";
										
										xx[f][16] = "<td>"+String.valueOf(query3.get(f).get("CBSYLMCB"))+"</td>";
										xx[f][17] = "<td>"+String.valueOf(query3.get(f).get("CBSYDMCB"))+"</td>";
										xx[f][18] = "<td>"+String.valueOf(query3.get(f).get("CBSYYJZFTDSY"))+"</td>";
										xx[f][19] = "<td>"+String.valueOf(query3.get(f).get("CBSYCXB"))+"</td>";
										xx[f][20] = "<td>"+String.valueOf(query3.get(f).get("QTCQQD"))+"</td>";
									
										xx[f][21] = "<td>"+String.valueOf(query3.get(f).get("QTCBFGL"))+"</td></tr>";
										
									}
									linkList.add(xx);
									
								}
							}
							

		}
return linkList  ;
	}

	/***
	 * 
	 * <br>Description:合计list
	 * <br>Author:朱波海
	 * <br>Date:2013-8-27
	 */
	public String[][] getHJ(){
	String hj[][]=new String[1][22];
	String sql =  " select sum(GHZD) as GHZD,sum (GHJSYD)as GHJSYD ,round(sum(GHJZGM)/sum(GHZD),2) as GHRJL,sum(GHJZGM) as GHJZGM , '--'as GHGHYT," +
	" sum (GHGJJZGM) as GHGJJZGM,sum(GHJZJZGM)as GHJZJZGM ,sum(GHSZJZGM) as GHSZJZGM,sum(CQZZSGM)as CQZZSGM ," +
	"sum(CQZZZSGM) as CQZZZSGM,sum (CQZZZSHS) as CQZZZSHS ,round(sum(CQZZZSGM)/sum (CQZZZSHS)*10000 ,2)as CQHJMJ,sum(CQFZZZSGM) as CQFZZZSGM,sum(CQFZZJS) as CQFZZJS," +
	"sum(GHRJL) as CBSYKFCB ,round(sum(CBSYKFCB)/sum(GHRJL)*10000,2 ) as CBSYLMCB,round(sum(CBSYKFCB)/sum(GHJSYD)*10000 ,2)as CBSYDMCB,round(3/sum(GHRJL)-sum(CBSYKFCB) ,2)as CBSYYJZFTDSY,round(1-sum(CBSYKFCB)/(3*sum(GHRJL)),2)as CBSYCXB," +
	"round(sum(CQZZZSGM)/sum(GHZD),2) as QTCQQD,round(sum(GHRJL)*2.4/sum(GHRJL),2) as QTCBFGL from DKINFO ";
 
	List<Map<String, Object>> list =query(sql, YW);
  //去掉null
    hj[0][0] = "<tr style='background: #C0C0C0; text-align: center; font: normal 22px verdana;'> <td>合计</td>";
    hj[0][1] = String.valueOf(list.get(0).get("GHZD"));
    hj[0][2] = String.valueOf(list.get(0).get("GHJSYD"));
    hj[0][3] = String.valueOf(list.get(0).get("GHRJL"));
    hj[0][4] = String.valueOf(list.get(0).get("GHJZGM"));
	
    hj[0][5] = String.valueOf(list.get(0).get("GHGHYT"));
    hj[0][6] = String.valueOf(list.get(0).get("GHGJJZGM"));
    hj[0][7] = String.valueOf(list.get(0).get("GHJZJZGM"));
    hj[0][8] = String.valueOf(list.get(0).get("GHSZJZGM"));
    hj[0][9] = String.valueOf(list.get(0).get("CQZZZSGM"));
	
    hj[0][10] = String.valueOf(list.get(0).get("CQZZZSGM"));
    hj[0][11] = String.valueOf(list.get(0).get("CQZZZSHS"));
    hj[0][12] = String.valueOf(list.get(0).get("CQHJMJ"));
    hj[0][13] = String.valueOf(list.get(0).get("CQFZZZSGM"));
    hj[0][14] = String.valueOf(list.get(0).get("CQFZZJS"));
    hj[0][15] = String.valueOf(list.get(0).get("CBSYKFCB"));
	
    hj[0][16] = String.valueOf(list.get(0).get("CBSYLMCB"));
    hj[0][17] = String.valueOf(list.get(0).get("CBSYDMCB"));
    hj[0][18] = String.valueOf(list.get(0).get("CBSYYJZFTDSY"));
    hj[0][19] = String.valueOf(list.get(0).get("CBSYCXB"));
    hj[0][20] = String.valueOf(list.get(0).get("QTCQQD"));

    hj[0][21] = String.valueOf(list.get(0).get("QTCBFGL"));
	for(int w=1;w<22;w++){
		if(w==22){
			hj[0][w]="<td>"+hj[0][w]+"</td></tr>";
		}else{
		if(	hj[0][w]==null||hj[0][w].equals("")||hj[0][w].equals("null")){
			hj[0][w]="<td></td>";
			
		}else{
			String str=hj[0][w];
			hj[0][w]="<td>"+str+"</td>";	
			
		}
		}
	}
	return hj;
}
}
