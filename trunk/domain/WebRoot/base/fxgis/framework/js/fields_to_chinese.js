//外业巡查核查图层
var xm_wy = {YW_GUID: '任务编号',
				任务类型:'任务类型',
				发现时间:'发现时间',
				用地主体:'用地主体',
				用地位置:'用地位置',
				用地项目:'用地项目'};
//土地变更调查
var xm_2013jctb = {JCBH:'监测编号',
				JCMJ:'监测面积（亩）',
				QSX:'前时相',
				HSX: '后时相',
				TBLX:'图斑类型',
				XMC:'县名称',
				XZQDM:'行政区代码',
				XZB:'X坐标',
				YZB:'Y坐标'};
//厦门卫片
var xm_2012yswftb = {TBBH:'图斑编号',
				TBMJ:'图斑面积（亩）',
				TBLX:'图斑类型',
				TFH:'图幅号',
				BGQDLBM:'变更前地类编码',
				DLBM:'地类编码',
				DLMC:'地类名称',
				QSDWDM: '权属单位代码',
				QSDWMC:'权属单位名称',
				XJXZQHDM:'县级行政区划代码',
				XJXZQHMC:'县级行政区划名称',
				ZLDWDM:'坐落单位代码',
				ZLDWMC:'坐落单位名称'};
//农转用年度层
var xm_nzy = {PCBH:'批次编号',
				PCLX:'批次类型',
				PCMC:'批次名称',
				PZSJ:'批准时间',
				PZWH:'批准文号',
				XMMC:'项目名称',
				XMMJ:'项目面积'};
//建设用地红线成果图
var xm_gdba = {XMMC:'项目名称',
				XMBH:'项目编号',
				SZFPW:'省政府批文',
				YDDWMC:'用地单位名称',
				DKMC:'地块名称',
				DKYTMS:'地块用途描述',
				GDFS:'供地方式',
				JSYDMJ:'建设用地面积',
				PQDKBH:'批前地块编号',
				PHDKBH:'批后地块编号',
				PZJG:'批准机构',
				PZMJ:'批准面积',
				PZRQ:'批准日期',
				TDYT:'土地用途',
				XZQHDM:'行政区划代码',
				YWLX:'业务类型',
				BZ:'备注'};
//土地利用现状
var xm_tdlyxz = {DLMC:'地类名称',
				DLBM:'地类编码',
				BGRQ:'变更日期',
				PZWH:'批准文号',
				QSDWDM:'权属单位代码',
				QSDWMC:'权属单位名称',
				TBBH:'图斑编号',
				TBDLMJ:'图斑地类面积',
				TBMJ:'图斑面积',
				ZLDWDM:'坐落单位代码',
				ZLDWMC:'坐落单位名称'};
//土地用途区图层
var xm_tdytq = {TDYTQLXDM:'土地用途区类型代码'};
//建设用地管制区
var xm_jsydgzq = {GZQLXDM:'管制区类型代码',
				GZQMJ:'管制区面积'};
				
function fields_to_chinese(fields_flag){
	if(fields_flag == "外业巡查核查图层"){
		return xm_wy;
	}else if(fields_flag == "土地变更调查"){
		return xm_2013jctb;
	}else if(fields_flag == "厦门卫片"){
		return xm_2012yswftb;
	}else if(fields_flag == "农转用年度层"){
		return xm_nzy;
	}else if(fields_flag == "建设用地红线成果图"){
		return xm_gdba;
	}else if(fields_flag == "土地利用现状"){
		return xm_tdlyxz;
	}else if(fields_flag == "土地用途区图层"){
		return xm_tdytq;
	}else if(fields_flag == "建设用地管制区"){
		return xm_jsydgzq;
	}
}