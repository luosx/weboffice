package com.klspta.web.cbd.yzt.jc.insertGIS;


import java.util.List;


import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.klspta.base.AbstractBaseBean;

public class GisFactory extends AbstractBaseBean{
	public final static int TYPE_ZRB = 1;
	public final static int TYPE_JBB = 2;
	public final static int TYPE_HXXM = 3;
	
	public void getGis() throws Exception{
		request.setCharacterEncoding("utf-8");
		String type = request.getParameter("type");
		String guid = new String(request.getParameter("guid").getBytes("ISO-8859-1"),"UTF-8");
		java.io.InputStream inputStream;
		AbstractInsertGIS insertGIS = getInsertGIS(type);
		if(ServletFileUpload.isMultipartContent(request)){
			DiskFileItemFactory dfif = new DiskFileItemFactory();
			ServletFileUpload fileUpload = new ServletFileUpload(dfif);
			List<FileItem> files = fileUpload.parseRequest(request);
			for(FileItem f:files){
				if(!f.isFormField()){
					inputStream =  f.getInputStream();
					insertGIS.insertGIS(inputStream, guid);
				}
			}
		}
		response("{success:true}");
	}
	
	private AbstractInsertGIS getInsertGIS(String type){
		AbstractInsertGIS insertCIS;
		switch (Integer.parseInt(type)) {
			case TYPE_ZRB:
				insertCIS = new ZrbInsertGIS();
				break;
			case TYPE_JBB:
				insertCIS = new JbbInsertGIS();
				break;
			case TYPE_HXXM:
				insertCIS = new HxxmInsertGIS();
				break;
			default:
				insertCIS = new ZrbInsertGIS();
				break;
		}
		
		return insertCIS;
	}
	
}
