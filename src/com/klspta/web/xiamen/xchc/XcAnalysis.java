package com.klspta.web.xiamen.xchc;

import java.rmi.server.UID;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.rowset.serial.SerialException;

import com.klspta.base.AbstractBaseBean;

/**
 * 
 * <br>Title:外业分析
 * <br>Description:
 * <br>Author:陈强峰
 * <br>Date:2014-2-20
 */
public class XcAnalysis extends AbstractBaseBean {
    DecimalFormat df = new DecimalFormat("0.###");

    //平方米单位转化到亩单位的系数
    private double coefficient = 0.0015;

    private String yw_guid = null;

    private boolean isBigPolygon = false;

    private XcAnalysis() {

    }

    /**
     * 
     * <br>Description:分析回传信息给平板
     * <br>Author:陈强峰
     * <br>Date:2014-2-20
     */
    public void analysis() {
        try {
            String wkt = request.getParameter("wkt");
            String mj = request.getParameter("zmj");
          //  wkt = "POLYGON  (( 67422.23302820 13857.56412365, 67404.32465167 13865.17505631, 67404.30018584 13865.02592847, 67403.52700884 13860.38099850, 67403.49081562 13860.17202718, 67402.68383796 13855.59502945, 67402.66952607 13855.51720874, 67401.79486842 13850.81702505, 67401.78517493 13850.76683326, 67400.89475783 13846.21896487, 67400.86075917 13846.04804865, 67400.83444523 13845.91901970, 67399.88064655 13841.28807448, 67399.85055900 13841.14703976, 67398.85510706 13836.53697650, 67398.84632263 13836.49751398, 67397.78463070 13831.79708538, 67397.74636392 13831.63324673, 67396.66877529 13827.06705393, 67396.60824153 13826.81796505, 67395.59122047 13822.68332718, 67395.50776080 13822.34806024, 67395.47778011 13822.23002717, 67394.30170736 13817.64007631, 67394.27215406 13817.52794054, 67393.08492031 13813.06973852, 67393.05077780 13812.94306060, 67393.01778450 13812.82295262, 67391.75476206 13808.25906703, 67391.72643751 13808.15943629, 67390.41483764 13803.58804721, 67390.39101106 13803.50701823, 67389.02977659 13798.93006767, 67388.99832577 13798.82704213, 67387.60069529 13794.28509509, 67387.51047947 13793.99885239, 67386.12689824 13789.65403301, 67386.11034748 13789.60335133, 67384.60893088 13785.03702306, 67384.60001450 13785.01052670, 67383.07539185 13780.51710831, 67383.04722401 13780.43492248, 67381.44161170 13775.84713802, 67381.38480699 13775.68855804, 67379.79213056 13771.27595236, 67379.74796337 13771.15597725, 67378.09951602 13766.72018275, 67378.01687331 13766.50277949, 67376.36286397 13762.18105267, 67376.34324309 13762.13078036, 67374.67906993 13757.89951575, 67374.58369756 13757.65912099, 67374.52226397 13757.50643783, 67372.76077526 13753.15409210, 67372.72447753 13753.06615818, 67370.91202385 13748.70647138, 67370.89504514 13748.66598091, 67368.98677894 13744.19709567, 67368.94551160 13744.10234862, 67367.03593904 13739.74602699, 67366.96581710 13739.58889977, 67365.04196474 13735.31301608, 67365.03411210 13735.29589470, 67363.00673085 13730.90012551, 67362.96088820 13730.80251726, 67361.02154433 13726.70119104, 67360.92901247 13726.50699402, 67358.80957991 13722.13320596, 67358.72590936 13721.96361241, 67356.64876102 13717.78023287, 67347.42321525 13699.41922458, 67302.11497048 13609.24514943, 67300.34471704 13605.77714663, 67300.29898994 13605.68959610, 67298.56337963 13602.39204356, 67298.53095356 13602.33102491, 67298.52057739 13602.31179366, 67296.67393913 13598.90903350, 67296.66378924 13598.89073348, 67294.84160636 13595.62972161, 67294.77406231 13595.50996454, 67292.83104470 13592.13497393, 67290.84610150 13588.78493883, 67288.81897130 13585.46001771, 67288.81380405 13585.45171111, 67286.89786574 13582.39409806, 67286.75067613 13582.16120637, 67286.67558486 13582.04407260, 67284.63987285 13578.88808295, 67284.61716617 13578.85355288, 67282.48890533 13575.64306370, 67282.46579872 13575.60892842, 67280.29681971 13572.42412414, 67280.19874529 13572.28282772, 67278.06471918 13569.23419933, 67277.99787816 13569.14062593, 67275.79205308 13566.07196146, 67275.73092766 13565.98845360, 67273.47994702 13562.93903963, 67273.46661941 13562.92133375, 67271.12895177 13559.83503689, 67271.10761934 13559.80738026, 67268.73798270 13556.76101363, 67268.73361108 13556.75549985, 67266.33092004 13553.74406192, 67266.30908929 13553.71692757, 67263.84185008 13550.70412429, 67263.80306776 13550.65765136, 67261.40444412 13547.80180141, 67261.33783941 13547.72313705, 67261.28226849 13547.65834882, 67258.79486982 13544.77311353, 67258.76124021 13544.73481570, 67256.33070211 13541.98477996, 67256.21598960 13541.85600933, 67256.21214917 13541.85175157, 67253.60064147 13538.97132880, 67253.50730766 13538.87027721, 67251.11357909 13536.29601040, 67250.94882381 13536.12016627, 67250.88635269 13536.05432287, 67248.26087128 13533.30212410, 67248.22608699 13533.26630488, 67245.53781800 13530.51818056, 67245.47096806 13530.45116257, 67242.78071178 13527.76929213, 67242.63289545 13527.62456037, 67239.98791600 13525.05508761, 67239.95698100 13525.02559451, 67237.16190875 13522.37609723, 67237.06134417 13522.28242712, 67234.30265908 13519.73337382, 67234.18067557 13519.62281076, 67231.41001641 13517.12698162, 67231.35815368 13517.08106104, 67228.48404445 13514.55694875, 67225.52698035 13512.02380173, 67184.60790169 13481.34513112, 67186.03874294 13459.02874100, 67219.57197913 12935.98832548, 67228.94401399 12942.40893242, 67231.30337446 12944.94269884, 67231.50163369 12945.15633878, 67234.04109772 12947.92017863, 67236.43568516 12950.56061041, 67236.56276997 12950.70120724, 67239.06604932 12953.49790651, 67241.48242845 12956.23337756, 67241.55087268 12956.31111173, 67244.01794201 12959.14014234, 67246.43246287 12961.94701035, 67246.46593946 12961.98605175, 67248.89585520 12964.84690690, 67251.18052592 12967.57308091, 67251.30675242 12967.72420611, 67253.69887463 12970.61621550, 67256.01909566 12973.46014593, 67256.07190014 12973.52508095, 67258.42609234 12976.44807811, 67260.71172871 12979.32498359, 67260.76090026 12979.38707872, 67263.07710681 12982.34099943, 67265.25657534 12985.15822210, 67265.37374557 12985.31019549, 67267.65102303 12988.29397897, 67269.82202403 12991.17748142, 67269.90881065 12991.29314159, 67272.14695253 12994.30601110, 67274.33809004 12997.29726269, 67274.36494215 12997.33404210, 67276.56401344 13000.37608522, 67278.66032827 13003.31701676, 67278.74281227 13003.43313290, 67280.90183062 13006.50318575, 67283.01173087 13009.54720942, 67283.03993791 13009.58804275, 67285.15903565 13012.68679231, 67287.25200522 13015.79159116, 67287.25698807 13015.79900799, 67289.33576694 13018.92487972, 67291.32357118 13021.95805101, 67291.39283192 13022.06410938, 67293.43016977 13025.21691816, 67295.37634218 13028.27209140, 67295.44681413 13028.38311754, 67297.44289634 13031.56187322, 67299.35497624 13034.65214085, 67299.41783573 13034.75410091, 67301.37210588 13037.95820601, 67333.17777600 13082.77478003, 67369.42780887 13142.65710905, 67382.35108950 13158.21298736, 67423.77991278 13226.65014910, 67435.91679631 13260.21681690, 67536.66085858 13426.63905852, 67557.00822946 13449.39008082, 67577.07311247 13482.53589935, 67570.18104791 13510.08611888, 67546.70309476 13524.03805776, 67565.47714886 13555.63088139, 67589.49381175 13541.35896311, 67619.74911730 13549.17180986, 67621.98540065 13552.91438774, 67622.02680882 13552.98411283, 67624.24719852 13556.79999728, 67624.25992772 13556.82204142, 67626.43527734 13560.66177691, 67626.44894393 13560.68603142, 67626.52357797 13560.82030048, 67628.55574939 13564.50743114, 67628.59280344 13564.57510688, 67630.62012236 13568.35400209, 67630.69193231 13568.48903570, 67632.68163715 13572.30360132, 67632.74568575 13572.42716188, 67632.88486538 13572.69957825, 67634.73109102 13576.34476061, 67634.75286829 13576.38806573, 67636.71494075 13580.37210686, 67646.78399141 13607.30879199, 67647.87499344 13610.09964639, 67647.92374705 13610.22509772, 67649.00550420 13613.05940527, 67649.03981009 13613.15007126, 67650.04282422 13615.84440135, 67650.13154482 13616.08416745, 67650.29325549 13616.52702731, 67651.13348786 13618.84548744, 67651.19911764 13619.02795801, 67652.19386591 13621.84011620, 67652.24274505 13621.97908915, 67652.36560586 13622.33326012, 67653.16801135 13624.66508179, 67653.26206093 13624.93997935, 67654.17815178 13627.67005871, 67654.25757840 13627.90813982, 67654.34434004 13628.17206462, 67655.21772951 13630.85347913, 67655.22792999 13630.88502247, 67656.10280986 13633.64152865, 67656.17463416 13633.86911481, 67656.22839513 13634.04210798, 67657.09602193 13636.86199335, 67657.94781829 13639.70676953, 67657.99376974 13639.86106820, 67658.01743296 13639.94180658, 67658.85333227 13642.82431667, 67658.86591301 13642.86802485, 67659.71073120 13645.86969306, 67659.71414502 13645.88196008, 67660.48514993 13648.70923779, 67660.53759761 13648.90310796, 67661.30829859 13651.82409019, 67661.33592365 13651.93001970, 67662.05858199 13654.76244673, 67662.10961781 13654.96409596, 67662.22018982 13655.40894009, 67662.80925573 13657.80356932, 67662.85804377 13658.00398946, 67663.56380453 13660.97344834, 67663.58186573 13661.05003142, 67664.21386166 13663.80640852, 67664.28079756 13664.10204531, 67664.92006565 13667.00149965, 67664.95474444 13667.16005546, 67665.01016784 13667.41869099, 67665.60301934 13670.22299600, 67666.21151360 13673.21485856, 67666.22688278 13673.29102347, 67666.25940425 13673.45577989, 67666.81848127 13676.33050160, 67666.82492786 13676.36401372, 67667.36218713 13679.24459577, 67667.39871062 13679.44205309, 67667.41136572 13679.51218861, 67667.94600284 13682.52499951, 67668.46481281 13685.58650776, 67668.46905477 13685.61199104, 67668.96411858 13688.69129888, 67668.96597769 13688.70300350, 67669.42000003 13691.67704803, 67669.43810884 13691.79798400, 67669.86783436 13694.77799256, 67669.88477517 13694.89703156, 67670.27704833 13697.78216746, 67670.30591490 13697.99901111, 67670.68297298 13700.95576286, 67670.70174064 13701.10503215, 67670.74384492 13701.45160674, 67671.03532013 13703.90033908, 67671.07188717 13704.21401288, 67671.40380560 13707.20698269, 67671.41680876 13707.32602058, 67671.44314266 13707.57679968, 67671.73125456 13710.39466128, 67671.73589482 13710.44101029, 67672.02112844 13713.46394335, 67672.02985962 13713.55801282, 67672.04354799 13713.71247848, 67672.28964642 13716.57978052, 67672.29778901 13716.67701721, 67672.52949468 13719.65118266, 67672.54079611 13719.79901530, 67672.54498977 13719.85704145, 67672.74367856 13722.71589002, 67672.75757362 13722.92202786, 67672.94675928 13726.00892613, 67672.94898152 13726.04700103, 67673.10589594 13729.00250364, 67673.11466222 13729.17401660, 67673.24919483 13732.16649177, 67673.25485825 13732.30100559, 67673.36856296 13735.41800439, 67673.36897926 13735.43000068, 67673.45198687 13738.32814072, 67673.45798205 13738.56000042, 67673.52102978 13741.68999950, 67673.55563336 13744.49225011, 67673.55880143 13744.82100142, 67673.57045610 13747.81008659, 67673.57077638 13747.95200015, 67673.57032301 13748.19123244, 67673.55737217 13750.99976647, 67673.55681145 13751.08299830, 67673.52037535 13754.02236265, 67673.51771422 13754.21299558, 67673.51512498 13754.35597282, 67673.46450540 13756.82147167, 67673.45251201 13757.34398773, 67673.36552182 13760.35190371, 67673.36184731 13760.47299517, 67673.36025956 13760.51901759, 67673.24641668 13763.56411286, 67673.24492603 13763.60199694, 67673.10557440 13766.67874405, 67673.10310353 13766.73000528, 67672.94723684 13769.64566244, 67672.93557451 13769.85597554, 67672.75159201 13772.83355852, 67672.74206095 13772.98100410, 67672.52300097 13776.10400007, 67672.29851884 13778.98187085, 67672.27879607 13779.22598299, 67672.02253282 13782.18867090, 67672.00873856 13782.34497649, 67671.97896255 13782.66705356, 67671.74580528 13785.12202496, 67671.71645129 13785.42565647, 67671.71291462 13785.46199149, 67671.39825423 13788.51532811, 67671.39190552 13788.57598996, 67671.36734160 13788.80162145, 67671.04651426 13791.67441966, 67671.04496964 13791.68799648, 67670.67300308 13794.79700038, 67670.65690804 13794.92553475, 67670.30009852 13797.71352162, 67670.27557717 13797.90194401, 67669.87704622 13800.82766109, 67669.85277211 13801.00396832, 67669.84805048 13801.03723313, 67669.42036238 13803.99006676, 67669.40377920 13804.10296713, 67669.39207309 13804.11290040, 67600.17286124 13861.57102313, 67600.15000000 13861.59000000, 67600.13218693 13861.57751771, 67530.35980623 13811.61013574, 67422.23302820 13857.56412365))";
            List<Map<String, Object>> totalList = new ArrayList<Map<String, Object>>();
            Map<String, Object> totalMap = new HashMap<String, Object>();
            double zmj = getArea(wkt, "DLGZXZR") * coefficient;
            List<Map<String, Object>> xzlist = analysis("DLGZXZR", "TBBH,QSDWMC,DLBM,DLMC", wkt);
            double nydmj = 0;
            double gengdmj = 0;
            double jsydmj = 0;
            double wlydmj = 0;
            String nydbm = "011,012,013,021,022,023,031,032,033,041,042,043,104,114,117,123";
            String gengdbm = "011,012,013";
            String jsydbm = "051,052,053,054,061,062,063,071,072,081,082,083,084,085,086,087,088,091,092,093,094,095,101,102,103,105,106,107,113,118,121,201,202,203,204,205";
            String wlydbm = "111,112,115,116,119,122,124,125,126,127";
            if (xzlist != null) {
                List<Map<String, Object>> xzAll = new ArrayList<Map<String, Object>>();
                Map<String, Object> xzSingle = null;
                for (int xz = 0; xz < xzlist.size(); xz++) {
                    xzSingle = new HashMap<String, Object>();
                    Map<String, Object> map = xzlist.get(xz);
                    double xzdlmj = Double.parseDouble(df.format(Double.parseDouble(map.get("area")
                            .toString())
                            * coefficient));
                    String tbbh = checkNull(map.get("TBBH"));
                    String qsdwmc = checkNull(map.get("QSDWMC"));
                    String dlbm = checkNull(map.get("DLBM"));
                    String dlmc = checkNull(map.get("DLMC"));
                    if (nydbm.indexOf(dlbm) >= 0) {
                        nydmj += xzdlmj;
                    }
                    if (gengdbm.indexOf(dlbm) >= 0) {
                        gengdmj += xzdlmj;
                    }
                    if (jsydbm.indexOf(dlbm) >= 0) {
                        jsydmj += xzdlmj;
                    }
                    if (wlydbm.indexOf(dlbm) >= 0) {
                        wlydmj += xzdlmj;
                    }
                    xzSingle.put("TBBH", tbbh);
                    xzSingle.put("QSDWMC", qsdwmc);
                    xzSingle.put("DLBM", dlbm);
                    xzSingle.put("DLMC", dlmc);
                    xzSingle.put("MJ", xzdlmj);
                    //塞入一条记录
                    xzAll.add(xzSingle);
                }
                nydmj = Double.parseDouble(df.format(nydmj));
                gengdmj = Double.parseDouble(df.format(gengdmj));
                jsydmj = Double.parseDouble(df.format(jsydmj));
                wlydmj = Double.parseDouble(df.format(wlydmj));
                //整个现状数据
                totalMap.put("nydmj", nydmj);
                totalMap.put("gengdmj", gengdmj);
                totalMap.put("jsydmj", jsydmj);
                totalMap.put("wlydmj", wlydmj);
                totalMap.put("xzall", xzAll);
            }
            List<Map<String, Object>> ghlist = analysis("dlgztdytqr", "TDYTQLXDM", wkt);
            double fhghmj = 0;
            double bfhghmj = 0;
            double zyjbntmj = 0;
            String fhghdm = "030,040,050";
            String zyjbntdm = "010";
            if (ghlist != null) {
                List<Map<String, Object>> tdytAll = new ArrayList<Map<String, Object>>();
                Map<String, Object> tdytSingle = null;
                for (int gh = 0; gh < ghlist.size(); gh++) {
                    tdytSingle = new HashMap<String, Object>();
                    Map<String, Object> map = ghlist.get(gh);
                    String tdlyfqdm = checkNull(map.get("TDYTQLXDM"));
                    String sm = "";
                    if ("010".equals(tdlyfqdm)) {
                        sm = "基本农田保护区";
                    } else if ("020".equals(tdlyfqdm)) {
                        sm = "一般农用地区";
                    } else if ("030".equals(tdlyfqdm)) {
                        sm = "城镇建设用地区";
                    } else if ("040".equals(tdlyfqdm)) {
                        sm = "村镇建设用地区";
                    } else if ("050".equals(tdlyfqdm)) {
                        sm = "独立工矿用地区";
                    } else if ("060".equals(tdlyfqdm)) {
                        sm = "风景旅游用地区";
                    } else if ("070".equals(tdlyfqdm)) {
                        sm = "生态环境安全控制区";
                    } else if ("080".equals(tdlyfqdm)) {
                        sm = "自然与文化遗产保护区";
                    } else if ("090".equals(tdlyfqdm)) {
                        sm = "林业用地区";
                    } else if ("100".equals(tdlyfqdm)) {
                        sm = "牧业用地区";
                    } else if ("990".equals(tdlyfqdm)) {
                        sm = "其它用地区";
                    } else {
                        sm = "有条件建设区";
                    }
                    double ghdlmj = Double.parseDouble(df.format(Double.parseDouble(map.get("area")
                            .toString())
                            * coefficient));
                    if (fhghdm.indexOf(tdlyfqdm) >= 0) {
                        fhghmj += ghdlmj;
                    } else {
                        bfhghmj += ghdlmj;
                        if (zyjbntdm.equals(tdlyfqdm)) {
                            zyjbntmj += ghdlmj;
                        }
                    }
                    //单个土地用途区
                    tdytSingle.put("TDYTQLXDM", tdlyfqdm);
                    tdytSingle.put("SM", sm);
                    tdytSingle.put("MJ", ghdlmj);
                    tdytAll.add(tdytSingle);
                }
                fhghmj = Double.parseDouble(df.format(fhghmj));
                bfhghmj = Double.parseDouble(df.format(bfhghmj));
                zyjbntmj = Double.parseDouble(df.format(zyjbntmj));
                //整个土地用途区数据
                totalMap.put("fhghmj", fhghmj);
                totalMap.put("bfhghmj", bfhghmj);
                totalMap.put("zyjbntmj", zyjbntmj);
                totalMap.put("tdytall", tdytAll);
            }
            //建设用地管制区
            double yxjsq = 0;
            double ytjjsq = 0;
            double xzjsq = 0;
            double jzjsq = 0;
            List<Map<String, Object>> gzqlist = analysis("dlgzjsydgzqr", "GZQLXDM", wkt);
            if (gzqlist != null) {
                for (int gzq = 0; gzq < gzqlist.size(); gzq++) {
                    Map<String, Object> map = gzqlist.get(gzq);
                    double gzqmj = Double.parseDouble(map.get("area").toString()) * coefficient;
                    String gzqlxdm = checkNull(map.get("GZQLXDM"));
                    if ("010".equals(gzqlxdm)) {
                        yxjsq += gzqmj;
                    } else if ("020".equals(gzqlxdm)) {
                        ytjjsq += gzqmj;
                    } else if ("030".equals(gzqlxdm)) {
                        xzjsq += gzqmj;
                    } else if ("040".equals(gzqlxdm)) {
                        jzjsq += gzqmj;
                    }
                }
                yxjsq = Double.parseDouble(df.format(yxjsq));
                ytjjsq = Double.parseDouble(df.format(ytjjsq));
                xzjsq = Double.parseDouble(df.format(xzjsq));
                jzjsq = Double.parseDouble(df.format(jzjsq));
                totalMap.put("yxjsq", yxjsq);
                totalMap.put("ytjjsq", ytjjsq);
                totalMap.put("xzjsq", xzjsq);
                totalMap.put("jzjsq", jzjsq);
            }
            //审批分析
            double spblTotal = 0;
            double spmjTotal = 0;
            List<Map<String, Object>> splist = analysis("dlgzspr", "XMMC,PZWH,PZSJ", wkt);
            if (splist != null) {
                List<Map<String, Object>> spAll = new ArrayList<Map<String, Object>>();
                Map<String, Object> spSingle = null;
                for (int sp = 0; sp < splist.size(); sp++) {
                    spSingle = new HashMap<String, Object>();
                    Map<String, Object> map = splist.get(sp);
                    double spmj = Double.parseDouble(df.format(Double.parseDouble(map.get("area").toString())
                            * coefficient));
                    String spxmmc = checkNull(map.get("XMMC"));
                    String spwh = checkNull(map.get("PZWH"));
                    String spsj = checkNull(map.get("PZSJ"));
                    double ygspbl = Double.parseDouble(df.format(spmj / zmj * 100));
                    spblTotal += ygspbl;
                    double ygspmj = Double.parseDouble(df.format(spmj));
                    spmjTotal += ygspmj;
                    spSingle.put("XMMC", spxmmc);
                    spSingle.put("PZWH", spwh);
                    spSingle.put("PZSJ", spsj);
                    spSingle.put("SPYGBL", ygspbl);
                    spSingle.put("SPYGMJ", ygspmj);
                    spAll.add(spSingle);
                }
                totalMap.put("spblTotal", df.format(spblTotal));
                totalMap.put("spmjTotal", spmjTotal);
                totalMap.put("spall", spAll);
            }
            //供地
            double gdblTotal = 0;
            double gdmjTotal = 0;
            List<Map<String, Object>> gdlist = analysis("dlgzgdr",
                    "XMMC,SZFPW,to_char(PZRQ,'yyyy-mm-dd') PZRQ", wkt);
            if (gdlist != null) {
                List<Map<String, Object>> gdAll = new ArrayList<Map<String, Object>>();
                Map<String, Object> gdSingle = null;
                for (int gd = 0; gd < gdlist.size(); gd++) {
                    gdSingle = new HashMap<String, Object>();
                    Map<String, Object> map = gdlist.get(gd);
                    double gdmj = Double.parseDouble(df.format(Double.parseDouble(map.get("area").toString())
                            * coefficient));
                    String gdxmmc = checkNull(map.get("XMMC"));
                    String gdwh = checkNull(map.get("SZFPW"));
                    String gdsj = checkNull(map.get("PZRQ"));
                    double yggdbl = Double.parseDouble(df.format(gdmj / zmj * 100));
                    gdblTotal += yggdbl;
                    double yggdmj = Double.parseDouble(df.format(gdmj));
                    gdmjTotal += yggdmj;
                    gdSingle.put("XMMC", gdxmmc);
                    gdSingle.put("SZFPW", gdwh);
                    gdSingle.put("PZRQ", gdsj);
                    gdSingle.put("GDYGBL", yggdbl);
                    gdSingle.put("GDYAMJ", yggdmj);
                    gdAll.add(gdSingle);
                }
                totalMap.put("gdall", gdAll);
                totalMap.put("gdmjTotal", gdmjTotal);
                totalMap.put("gdblTotal", df.format(gdblTotal));
            }
            totalList.add(totalMap);
            if (yw_guid != null) {
                String sql = "delete from DLGZTESTR where yw_guid=?";
                update(sql, GIS, new Object[] { yw_guid });
            }
            response(totalList);
        } catch (Exception e) {
            e.printStackTrace();
            response("");
        }
    }

    private List<Map<String, Object>> analysis(String layerName, String properties, String wkt) {
        if (yw_guid != null) {
            return analysisWithBigPolygon(layerName, properties, yw_guid);
        }
        String querySrid = "select t.srid from sde.st_geometry_columns t where t.table_name =?";
        List<Map<String, Object>> sridList = query(querySrid, GIS, new Object[] { layerName.toUpperCase() });
        String srid = "";
        if (sridList.size() > 0) {
            srid = (sridList.get(0)).get("srid").toString();
        }
        String ayalySql = "select " + properties
                + ",sde.st_area(sde.st_intersection(t.shape,sde.st_geometry(?,?))) area from " + layerName
                + " t where sde.st_intersects(t.shape,sde.st_geometry(?,?))=1";
        List<Map<String, Object>> list = query(ayalySql, GIS, new Object[] { wkt, srid, wkt, srid });
        return list;
    }

    /**
     * 
     * <br>Description:大图斑分析
     * <br>Author:陈强峰
     * <br>Date:2014-3-6
     * @param layerName
     * @param properties
     * @param yw_guid
     * @return
     */
    private List<Map<String, Object>> analysisWithBigPolygon(String layerName, String properties,
            String yw_guid) {
        String ayalySql = "select "
                + properties
                + ",sde.st_area(sde.st_intersection(t.shape,(select d.shape from dlgztestr d where d.yw_guid=? ))) area from "
                + layerName
                + " t where sde.st_intersects(t.shape,(select l.shape from dlgztestr l where l.yw_guid=?))=1";
        List<Map<String, Object>> list = query(ayalySql, GIS, new Object[] { yw_guid, yw_guid });
        return list;
    }

    /**
     * 
     * <br>Description:获取面积
     * <br>Author:陈强峰
     * <br>Date:2014-2-21
     * @param wkt
     * @return
     */
    private double getArea(String wkt, String layerName) {
        String querySrid = "select t.srid from sde.st_geometry_columns t where t.table_name =? ";
        List<Map<String, Object>> sridList = query(querySrid, GIS, new Object[] { layerName.toUpperCase() });
        String srid = "";
        if (sridList.size() > 0) {
            srid = (sridList.get(0)).get("srid").toString();
        }
        if (wkt.length() < 4000) {
            String str = "select sde.st_area(sde.st_geometry(?,?)) area from dual";
            List<Map<String, Object>> list = query(str, GIS, new Object[] { wkt, srid });
            if (list.size() > 0) {
                return Double.parseDouble(list.get(0).get("area").toString());
            }
        } else {
            isBigPolygon = true;
            System.out.println("BIG POLYGON");
            String guid = new UID().toString().replaceAll(":", "-");
            insertBlob("call InsertTempPoly(?,?,?)", GIS, guid, srid, wkt);
            String sql = "select sde.st_area(t.shape) area from DLGZTESTR t where t.yw_guid=?";
            List<Map<String, Object>> list = query(sql, GIS, new Object[] { guid });
            if (list.size() == 1) {
                yw_guid = guid;
                return Double.parseDouble(list.get(0).get("area").toString());
            }
        }
        return 0;
    }

    private String checkNull(Object obj) {
        if (obj == null) {
            return "";
        }
        return obj.toString();
    }
}
