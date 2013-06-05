package com.klspta.base.util.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.Vector; //import java.util.zip.ZipEntry;
//import java.util.zip.ZipInputStream;
//import java.util.zip.ZipOutputStream;

import org.apache.tools.ant.Project;
import org.apache.tools.ant.taskdefs.Zip;
import org.apache.tools.ant.types.FileSet;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;

import com.klspta.base.util.api.IZIPUtil;

public final class ZIPUtil implements IZIPUtil {

    private ZIPUtil() {
    }

    public static IZIPUtil getInstance(String key) throws Exception {
        if (!key.equals("NEW WITH UTIL FACTORY!")) {
            throw new Exception("请从UtilFacory获取工具实例.");
        }
        return new ZIPUtil();
    }

    //	@Override
    //	public void zip(String zipFileName,String inputFile){
    //		zip(zipFileName,new File(inputFile));
    //	}
    //	
    //	private void zip(String zipFileName,File inputFile){
    //		ZipOutputStream out = null;
    //		try {
    //			out = new ZipOutputStream(new FileOutputStream(zipFileName));
    //			zip(out,inputFile,"");
    //		} catch (FileNotFoundException e) {
    //			e.printStackTrace();
    //		}finally{
    //			try {
    //				out.close();
    //			} catch (IOException e) {
    //				e.printStackTrace();
    //			}
    //		}
    //	}

    //	private void zip(ZipOutputStream out,File f,String base){
    //	    try {
    //			if (f.isDirectory()){
    //			   File[] fl = f.listFiles();
    //		       out.putNextEntry(new ZipEntry(base + "/"));
    //		       base = base.length() == 0 ? "" : base + "/";
    //		       for (int i = 0; i < fl.length; i++){
    //			       zip(out, fl[i], base+fl[i].getName());
    //		       }
    //		   }else{
    //		       out.putNextEntry(new ZipEntry(base=base.length() == 0?f.getName():base));
    //		       FileInputStream in=new FileInputStream(f);
    //		       int b;
    //		       while ((b = in.read()) != -1){
    //			       out.write(b);
    //		       }
    //		   in.close();
    //		   }
    //		} catch (IOException e) {
    //			e.printStackTrace();
    //		}
    //	}

    //	@Override
    //	public Vector<String> unzip(String zipFileName, String outputDirectory) {
    //		Vector<String> filepaths = new Vector<String>();
    //		ZipInputStream in = null;
    //		FileOutputStream out = null;
    //		try {
    //			in = new ZipInputStream(new FileInputStream(zipFileName));
    //			ZipEntry z;
    //			while ((z = in.getNextEntry()) != null){
    //				if (z.isDirectory()){
    //					String name = z.getName();
    //					name = name.substring(0,name.length() - 1);
    //					File f = new File(outputDirectory + File.separator + name);
    //					f.mkdirs();
    //				}else{
    //					File f = new File(outputDirectory);
    //					f = new File(outputDirectory + File.separator + z.getName());
    //					if(!f.getParentFile().exists()){
    //					    f.getParentFile().mkdirs();
    //					}
    //					filepaths.add(f.getPath());
    //					f.createNewFile();
    //					out = new FileOutputStream(f);
    //					int b;
    //					while((b = in.read()) != -1){
    //						out.write(b);
    //					}
    //					out.close();
    //				}
    //			}
    //		} catch (FileNotFoundException e) {
    //			e.printStackTrace();
    //		} catch (IOException e) {
    //			e.printStackTrace();
    //		}finally{
    //			try{
    //				if(in != null){
    //					in.close();
    //				}
    //				if(out != null){
    //					out.close();
    //				}
    //			}catch(IOException e){
    //				e.printStackTrace();
    //			}
    //		}
    //		return filepaths;
    //	}

    public void zip(String filePath, String srcPathName) {
        File file = new File(filePath);
        file.delete();
        File srcdir = new File(srcPathName);
        Project prj = new Project();
        Zip zip = new Zip();
        zip.setProject(prj);
        zip.setDestFile(file);
        FileSet fileSet = new FileSet();
        fileSet.setProject(prj);
        fileSet.setDir(srcdir);
        zip.addFileset(fileSet);
        zip.execute();
    }

    @Override
    public void unZip(String zipFileName, String destDir) {
        try {
            ZipFile zipFile = new ZipFile(zipFileName);
            Enumeration<?> e = zipFile.getEntries();
            ZipEntry zipEntry = null;
            File fD = new File(destDir);
            if (!fD.exists()) {
                fD.mkdir();
            }
            while (e.hasMoreElements()) {
                zipEntry = (ZipEntry) e.nextElement();
                String entryName = zipEntry.getName();
                String names[] = entryName.split("/");
                int length = names.length;
                String path = destDir;
                for (int v = 0; v < length; v++) {
                    if (v < length - 1) {
                        path += "/" + names[v];
                        new File(path).mkdir();
                    } else {
                        if (entryName.endsWith("/")) {
                            new File(destDir + "/" + entryName).mkdir();
                        } else {
                            InputStream in = zipFile.getInputStream(zipEntry);
                            OutputStream os = new FileOutputStream(new File(destDir + "/" + entryName));
                            byte[] buf = new byte[1024];
                            int len;
                            while ((len = in.read(buf)) > 0) {
                                os.write(buf, 0, len);
                            }
                            in.close();
                            os.close();
                        }
                    }
                }
            }
            zipFile.close();

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

}
