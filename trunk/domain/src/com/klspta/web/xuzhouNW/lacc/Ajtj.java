package com.klspta.web.xuzhouNW.lacc;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class Ajtj extends AbstractBaseBean {
	private static Ajtj ajtj = null;

	private Ajtj() {

	}

	public static Ajtj getInstance() {
		if (ajtj == null) {
			ajtj = new Ajtj();
		}
		return ajtj;
	}

	/**
	 * <br>
	 * Description:根据流程节点和办理机构进行统计 <br>
	 * Author:赵伟 <br>
	 * Date:2012-10-30
	 * 
	 * @return
	 */
	public int[][] getAjtj() {
		String rolesIds[] = { "d6b42d4682af6c82b9dfb4e60dc11463", "4b31c5d8ea49fe8a90dd192a0ef7b976",
				"c2a650ffabe839368d8a0847f046a2c8", "4cea8f3c170db294722cc36280585b07",
				"013e5b5ff4bfd5da51a6f1ec55746d50", "5ed4bdc57eb8b8c9f8c91140582c0249",
				"770623eb1fb55e9223c8160dc582beae", "1ebe05bf3766f9761498c024e42c55c3",
				"57d63b4aeec7db32810a4b11478532cd" };
		Map<String, Integer> node = new HashMap<String, Integer>();
		node.put("受理立案", 0);
		node.put("立案审查", 1);
		node.put("立案审核", 2);
		node.put("立案审批", 3);
		node.put("调查取证", 4);
		node.put("审查决定", 5);
		node.put("大队审理", 6);
		node.put("案件执行室审查", 7);
		node.put("支队长审核", 8);
		node.put("政策法规处审批", 9);
		node.put("局长批签", 10);
		node.put("告知", 11);
		node.put("听证", 12);
		node.put("更改意见", 13);
		node.put("大队审查", 14);
		node.put("执行室审查", 15);
		node.put("支队审核", 16);
		node.put("政策法规处意见", 17);
		node.put("分管局长批签", 18);
		node.put("下达处罚决定", 19);
		node.put("执行", 20);
		node.put("移送", 21);
		node.put("结案", 22);
		node.put("结案审核", 23);
		node.put("结案审查", 24);
		node.put("结案审批 ", 25);
		node.put("归档", 26);
		node.put("局领导审批 ", 27);
		node.put("案件执行室审核 ", 28);
		node.put("大队审核", 29);
		node.put("撤案", 30);

		int result[][] = new int[9][31];
		String sql = "select t.activity_name_ from ACTIVE_TASK t where t.wfId='ZFJC-1' and t.wfInsId in(select l1.wfInsId from zfjc.lacpb l1) and t.assignee_ in(select t.fullname from core.core_users t inner join core.map_user_role m on t.id=m.user_id and m.role_id=?) ";
		for (int i = 0; i < rolesIds.length; i++) {
			List<Map<String, Object>> list = query(sql, WORKFLOW, new String[] { rolesIds[i] });
			for (Map<String, Object> map : list) {
				String activityName = map.get("activity_name_").toString();
				if(activityName.equals("结案审查")){
					continue;
				}
				int index = node.get(activityName);
				result[i][index] += 1;
			}
		}
		return result;
	}
}
