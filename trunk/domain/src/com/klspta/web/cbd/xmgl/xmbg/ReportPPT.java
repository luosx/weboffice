package com.klspta.web.cbd.xmgl.xmbg;

import java.io.File;

import org.apache.poi.hslf.model.Picture;
import org.apache.poi.hslf.model.Shape;
import org.apache.poi.hslf.model.Slide;
import org.apache.poi.hslf.model.TextBox;
import org.apache.poi.hslf.usermodel.RichTextRun;
import org.apache.poi.hslf.usermodel.SlideShow;

import com.klspta.base.AbstractBaseBean;

public class ReportPPT extends AbstractBaseBean {
	
	public SlideShow ppt = new SlideShow();
	public SlideShow styleppt;

	public ReportPPT() {
		super();
	}
	
	public SlideShow getPPT() throws Exception{
		java.awt.Dimension pgsize = ppt.getPageSize();
		int pgx = pgsize.width;
		int pgy = pgsize.height;
		
		Slide slide = buildSlide();
		setSlideSize(800, 600);
		setPicture(10, 10, pgx/2, pgy/2, "G:\\domain\\src\\com\\klspta\\web\\cbd\\xmgl\\xmbg\\图片1.jpg", Picture.JPEG, slide);
		setPicture(pgx/2 + 30, 10, pgx/2, pgy/2, "G:\\domain\\src\\com\\klspta\\web\\cbd\\xmgl\\xmbg\\图片2.jpg", Picture.JPEG, slide);
		setPicture(10, pgy/2 + 30, pgx/2, pgy/2, "G:\\domain\\src\\com\\klspta\\web\\cbd\\xmgl\\xmbg\\图片3.jpg", Picture.JPEG, slide);
		
		
		TextBox txt = new TextBox();
		RichTextRun rt = txt.getTextRun().getRichTextRuns()[0];
		rt.setFontSize(14);
		//rt.setBold(true);
		rt.setAlignment(TextBox.AlignLeft);
		txt.setAnchor(new java.awt.Rectangle(pgx/2 + 30,pgy/2 + 30,pgx/2,pgy/2));
		txt.setText("项目名称：联大商学院项目\r"+
					"开发主体：拟由分中心作为主体实施收储带前期开发。\r"+
					"项目区位：该项目位于朝阳区红领巾桥西南角，延静里中街。\r"+
					"规划情况：项目占地约1.95公顷，规划建设用地面积1.26公顷，规划建筑规模4.41万平方米，主要规划用途为居住及配套用地。\r" + 
					"现状情况：现状建筑规模约2.14万㎡，全部为联大商学院校区。\r"+
					"相关进展：");
		setText(slide, txt);
		return ppt;
	}
	
	public SlideShow buildPPT(String xmmc, String file_ids){
		
		
		return null;
	}
	
	public Slide buildSlide(){
		return ppt.createSlide();
	}
	
	public void setSlideSize(int width, int height){
		ppt.setPageSize(new java.awt.Dimension(width, height));
	}
	
	public void setText(Slide slide, TextBox txt){
		slide.addShape(txt);
	}
	
	public void setPicture(int left, int top, int width, int height, String path, int format,Slide slide) throws Exception{
		int idx = ppt.addPicture(new File(path), format);
		Picture picture = new Picture(idx);
		picture.setAnchor(new java.awt.Rectangle(left, top, width, height));
		slide.addShape(picture);
	}
	
	public Slide getSlide(int i){
		if(ppt == null){
			return null;
		}else{
			Slide[] slide = ppt.getSlides();
			return slide[i];
		}
	}
	
	public TextBox getTextBox(Slide slide, int i){
		Shape[] sh = slide.getShapes();
		if(-1 == i){
			for(int j = 0; j < sh.length; j++){
				if(sh[j] instanceof TextBox){
					return (TextBox)sh[j];
				}
			}
		}else{
			for(int j = i; j < sh.length; j++){
				if(sh[j] instanceof TextBox){
					return (TextBox)sh[j];
				}
			}
		}
		return null;
	}
	
	

}
