package com.klspta.web.xiamen.jcl;
import org.jbpm.api.identity.Group;
import org.springframework.web.util.Log4jConfigListener;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.klspta.base.util.UtilFactory;
import com.klspta.base.util.bean.xzqhutil.XzqhBean;
import com.klspta.console.ManagerFactory;
import com.klspta.console.role.Role;

/**
 * 
 * <br>Title:权限管理管理类
 * <br>Description:根据用户的Role的行政区划获取本级和下级的所有行政区划
 * <br>Author:黎春行
 * <br>Date:2013-11-18
 */
public class XzqHandle  {
	
	/**
	 * 
	 * <br>Description:根据行政区划获取所有本级和下级的行政区划
	 * <br>Author:黎春行
	 * <br>Date:2013-11-18
	 * @param xzqh
	 * @return
	 */
	public static Set<String> getChildSetByParentId(String xzqh){
		Set<String> childSet  = new HashSet<String>();
		List<XzqhBean> childList = UtilFactory.getXzqhUtil().getChildListByParentId(xzqh);
		childSet.add(xzqh);
		for(XzqhBean xzqhBean : childList){
			childSet.add(xzqhBean.getCatoncode());
			Set<String> querySet = getChildSetByParentId(xzqhBean.getCatoncode());
			if(!querySet.isEmpty()){
				childSet.addAll(querySet);
			}
		}
		
		return childSet;
	}
	
	/**
	 * 
	 * <br>Description:根据用户的UserId获取本级和下级的行政区划
	 * <br>Author:黎春行
	 * <br>Date:2013-11-18
	 * @param userId
	 * @return
	 */
	public static Set<String> getChildSetByUserId(String userId){
		Set<String> childSet  = new HashSet<String>();
		try {
			List<Group> roleList = ManagerFactory.getRoleManager().getRoleBeanListByUserId(userId);
			for(Group roleGroup : roleList){
				Role role = (Role)roleGroup;
				String xzqh = role.getXzqh();
				Set<String> quertSet = getChildSetByParentId(xzqh);
				childSet.addAll(quertSet);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return childSet;
	}
	
	/**
	 * 
	 * <br>Description:获取便于sql查询的权限
	 * <br>Author:黎春行
	 * <br>Date:2013-11-21
	 * @param userId
	 * @return
	 */
	public static String editXzq(String userId){
		Set<String> xzqSet = XzqHandle.getChildSetByUserId(userId);
		StringBuffer containBuffer = new StringBuffer();
		containBuffer.append("(");
		for(String xzqname : xzqSet){
			containBuffer.append("'").append(xzqname).append("',");
		}
		containBuffer.append(" 'null' )");
		return containBuffer.toString();
	}
	

}
