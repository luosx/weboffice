addLocalMapLayer(_$layers, type, mapid){
        switch(mapid){
            case "ZPG" : _$layers[mapid] = new my.ZPG(90.71428571427429,-5123200,10002100); break;
            case "TSSC" : _$layers[mapid] = new my.TSSC(90.71428571427429,-5123200,10002100); break;
            case "SCYUANQU" : _$layers[mapid] = new my.SCYUANQU(90.71428571427429,-5123200,10002100); break;
            case "SCQY" : _$layers[mapid] = new my.SCQY(90.71428571427429,-5123200,10002100); break;
            case "NYJSF_NYYuanQu" : _$layers[mapid] = new my.NYJSF_NYYuanQu(90.71428571427429,-5123200,10002100); break;
            case "NYJSF_NYTeSeShuCai" : _$layers[mapid] = new my.NYJSF_NYTeSeShuCai(90.71428571427429,-5123200,10002100); break;
            case "NYJSF_NYQiYe" : _$layers[mapid] = new my.NYJSF_NYQiYe(90.71428571427429,-5123200,10002100); break;
            case "NYJSF_DXH" : _$layers[mapid] = new my.NYJSF_DXH(90.71428571427429,-5123200,10002100); break;
            case "JZDJ" : _$layers[mapid] = new my.JZDJ(90.71428571427429,-5123200,10002100); break;
            case "GHSF" : _$layers[mapid] = new my.GHSF(90.71428571427429,-5123200,10002100); break;
            case "DLHX" : _$layers[mapid] = new my.DLHX(90.71428571427429,-5123200,10002100); break;
            case "dmdz_ztfl" : _$layers[mapid] = new my.dmdz_ztfl(90.71428571427429,-5123200,10002100); break;
            case "dmdz_xqd" : _$layers[mapid] = new my.dmdz_xqd(90.71428571427429,-5123200,10002100); break;
            case "dlst500and1000" : _$layers[mapid] = new my.dlst500and1000(90.71428571427429,-5123200,10002100); break;
            case "dlst50000" : _$layers[mapid] = new my.dlst50000(90.71428571427429,-5123200,10002100); break;
            case "dlst10000" : _$layers[mapid] = new my.dlst10000(90.71428571427429,-5123200,10002100); break;
            case "SGRaster_WMS_C" : _$layers[mapid] = new my.SGRaster_WMS_C(90.71428571427429,-5123200,10002100); break;
            case "SGDOM500_WMS_C" : _$layers[mapid] = new my.SGDOM500_WMS_C(90.71428571427429,-5123200,10002100); break;
            case "SGDOM3000_WMS_C" : _$layers[mapid] = new my.SGDOM3000_WMS_C(90.71428571427429,-5123200,10002100); break;
            case "SGDOM1000_WMS_C" : _$layers[mapid] = new my.SGDOM1000_WMS_C(90.71428571427429,-5123200,10002100); break;
            case "ZHGX" : _$layers[mapid] = new my.ZHGX(90.71428571427429,-5123200,10002100); break;
            case "SGDM" : _$layers[mapid] = new my.SGDM(90.71428571427429,-5123200,10002100); break;
            case "SGDOM3000" : _$layers[mapid] = new my.SGDOM3000(90.71428571427429,-5123200,10002100); break;
            case "SGRoad" : _$layers[mapid] = new my.SGRoad(90.71428571427429,-5123200,10002100); break;
            case "SGDOM1000" : _$layers[mapid] = new my.SGDOM1000(90.71428571427429,-5123200,10002100); break;
            case "SGDOM500" : _$layers[mapid] = new my.SGDOM500(90.71428571427429,-5123200,10002100); break;
            case "SGRaster" : _$layers[mapid] = new my.SGRaster(90.71428571427429,-5123200,10002100); break;
            case "SGMap" : _$layers[mapid] = new my.SGMap(90.71428571427429,-5123200,10002100); break;
            case "JBNT" : _$layers[mapid] = new my.JBNT(96,430613.16206432,4177624.82530318); break;
            case "TDLYXZ" : _$layers[mapid] = new my.TDLYXZ(96,430613.16206432,4177624.82530318); break;
            case "SGMapWW" : _$layers[mapid] = new my.SGMapWW(96,-180,90); break;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////    WMTS and WMS Services infomation for Souguang by wangyingbo         2011-11-17 at Shouguang
///WMTS////////////////////////////////////////////////////////////////////////////////////////////////////////
var zdextend = new esri.geometry.Extent(430613.16206432,4021081.47825382,587156.509113681,4177624.82530318, this.spatialReference);
dojo.declare("my.JBNT", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
	    this.spatialReference = new esri.SpatialReference({wkid:0});
	    this.initialExtent = zdextend;
	    this.fullExtent = zdextend;
	    this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 0},
		    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
	    	      "level": 0,"scale": 2311166.8399999999,"resolution": 611.49744941156553}, {
	    	      "level": 1,"scale": 1155583.4199999999,"resolution": 305.74872470578276}, {
	    	      "level": 2,"scale": 577791.70999999996,"resolution": 152.87436235289138}, {
	    	      "level": 3,"scale": 288895.84999999998,"resolution": 76.437179853526374}, {
	    	      "level": 4,"scale": 144447.92999999999,"resolution": 38.218591249682497}, {
	    	      "level": 5,"scale": 72223.960000000006,"resolution": 19.109294301921938}, {
	    	      "level": 6,"scale": 36111.980000000003,"resolution": 9.5546471509609692}, {
	    	      "level": 7,"scale": 18055.990000000002,"resolution": 4.7773235754804846}, {
	    	      "level": 8,"scale": 9028,"resolution": 2.3886631106595546}, {
	    	      "level": 9,"scale": 4514,"resolution": 1.1943315553297773}, {
	    	      "level": 10,"scale": 2257,"resolution": 0.59716577766488865}, {
	    	      "level": 11,"scale": 1128.5,"resolution": 0.29858288883244433}, {
	    	      "level": 12,"scale": 564.25,"resolution": 0.14929144441622216}]});;
	    this.loaded = true;
	    this.onLoad(this);
	},
	getTileUrl: function(level, row, col) {
		return "http://10.14.100.30/MapgisOGCWebService/Service/KVP/JBNT/WMTS?service=WMTS&request=GetTile&layer=0&style=default&format=image/png&tileMatrixSet=IndexNT.HDF&TILEMATRIX=" + level + "&TILEROW=" + row + "&TILECOL=" + col;
	}
});
dojo.declare("my.TDLYXZ", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
	this.spatialReference = new esri.SpatialReference({wkid:0});
	this.initialExtent = zdextend;
	this.fullExtent = zdextend;
	this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 0},
	    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
  	      "level": 0,"scale": 2311166.8399999999,"resolution": 611.49744941156553}, {
  	      "level": 1,"scale": 1155583.4199999999,"resolution": 305.74872470578276}, {
  	      "level": 2,"scale": 577791.70999999996,"resolution": 152.87436235289138}, {
  	      "level": 3,"scale": 288895.84999999998,"resolution": 76.437179853526374}, {
  	      "level": 4,"scale": 144447.92999999999,"resolution": 38.218591249682497}, {
  	      "level": 5,"scale": 72223.960000000006,"resolution": 19.109294301921938}, {
  	      "level": 6,"scale": 36111.980000000003,"resolution": 9.5546471509609692}, {
  	      "level": 7,"scale": 18055.990000000002,"resolution": 4.7773235754804846}, {
  	      "level": 8,"scale": 9028,"resolution": 2.3886631106595546}, {
  	      "level": 9,"scale": 4514,"resolution": 1.1943315553297773}, {
  	      "level": 10,"scale": 2257,"resolution": 0.59716577766488865}, {
  	      "level": 11,"scale": 1128.5,"resolution": 0.29858288883244433}, {
  	      "level": 12,"scale": 564.25,"resolution": 0.14929144441622216}]});;
	this.loaded = true;
	this.onLoad(this);
},
getTileUrl: function(level, row, col) {
	return "http://10.14.100.30/MapgisOGCWebService/Service/KVP/TDLYXZ/WMTS?service=WMTS&request=GetTile&layer=0&style=default&format=image/png&tileMatrixSet=IndexDC.HDF&TILEMATRIX=" + level + "&TILEROW=" + row + "&TILECOL=" + col;
}
});
///////////////////////////


dojo.declare("my.ZHGX", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
	    this.spatialReference = new esri.SpatialReference({wkid:0});
	    this.initialExtent = map.extent;
	    this.fullExtent = map.extent;
	    this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 0},
		    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
	    	      "level": 0,"scale": 2311166.8399999999,"resolution": 611.49744941156553}, {
	    	      "level": 1,"scale": 1155583.4199999999,"resolution": 305.74872470578276}, {
	    	      "level": 2,"scale": 577791.70999999996,"resolution": 152.87436235289138}, {
	    	      "level": 3,"scale": 288895.84999999998,"resolution": 76.437179853526374}, {
	    	      "level": 4,"scale": 144447.92999999999,"resolution": 38.218591249682497}, {
	    	      "level": 5,"scale": 72223.960000000006,"resolution": 19.109294301921938}, {
	    	      "level": 6,"scale": 36111.980000000003,"resolution": 9.5546471509609692}, {
	    	      "level": 7,"scale": 18055.990000000002,"resolution": 4.7773235754804846}, {
	    	      "level": 8,"scale": 9028,"resolution": 2.3886631106595546}, {
	    	      "level": 9,"scale": 4514,"resolution": 1.1943315553297773}, {
	    	      "level": 10,"scale": 2257,"resolution": 0.59716577766488865}, {
	    	      "level": 11,"scale": 1128.5,"resolution": 0.29858288883244433}, {
	    	      "level": 12,"scale": 564.25,"resolution": 0.14929144441622216}]});;
	    this.loaded = true;
	    this.onLoad(this);
	},
	getTileUrl: function(level, row, col) {
		return "http://172.17.1.66/MapgisOGCWebService/Service/KVP/gssj00/WMTS?userName=test123&password=test123&TILEMATRIXSET=sss&SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetTile&LAYER=0&STYLE=default&FORMAT=image/png&TILEMATRIX=" + level + "&TILEROW=" + row + "&TILECOL=" + col;
	}
});

dojo.declare("my.SGDM", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
	    this.spatialReference = new esri.SpatialReference({wkid:0});
	    this.initialExtent = map.extent;
	    this.fullExtent = map.extent;
	    this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 0},
		    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
	    	      "level": 0,"scale": 2311166.8399999999,"resolution": 611.49744941156553}, {
	    	      "level": 1,"scale": 1155583.4199999999,"resolution": 305.74872470578276}, {
	    	      "level": 2,"scale": 577791.70999999996,"resolution": 152.87436235289138}, {
	    	      "level": 3,"scale": 288895.84999999998,"resolution": 76.437179853526374}, {
	    	      "level": 4,"scale": 144447.92999999999,"resolution": 38.218591249682497}, {
	    	      "level": 5,"scale": 72223.960000000006,"resolution": 19.109294301921938}, {
	    	      "level": 6,"scale": 36111.980000000003,"resolution": 9.5546471509609692}, {
	    	      "level": 7,"scale": 18055.990000000002,"resolution": 4.7773235754804846}, {
	    	      "level": 8,"scale": 9028,"resolution": 2.3886631106595546}, {
	    	      "level": 9,"scale": 4514,"resolution": 1.1943315553297773}, {
	    	      "level": 10,"scale": 2257,"resolution": 0.59716577766488865}, {
	    	      "level": 11,"scale": 1128.5,"resolution": 0.29858288883244433}, {
	    	      "level": 12,"scale": 564.25,"resolution": 0.14929144441622216}]});;
	    this.loaded = true;
	    this.onLoad(this);
	},
	getTileUrl: function(level, row, col) {
		return "http://10.14.100.24/tileservice/SGDM?userName=test123&password=test123&TILEMATRIXSET=sss&SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetTile&LAYER=0&STYLE=default&FORMAT=image/png&TILEMATRIX=" + level + "&TILEROW=" + row + "&TILECOL=" + col;
	}
});

dojo.declare("my.SGDOM3000", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
	    this.spatialReference = new esri.SpatialReference({wkid:0});
	    this.initialExtent = map.extent;
	    this.fullExtent = map.extent;
	    this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 0},
		    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
	    	      "level": 0,"scale": 2311166.8399999999,"resolution": 611.49744941156553}, {
	    	      "level": 1,"scale": 1155583.4199999999,"resolution": 305.74872470578276}, {
	    	      "level": 2,"scale": 577791.70999999996,"resolution": 152.87436235289138}, {
	    	      "level": 3,"scale": 288895.84999999998,"resolution": 76.437179853526374}, {
	    	      "level": 4,"scale": 144447.92999999999,"resolution": 38.218591249682497}, {
	    	      "level": 5,"scale": 72223.960000000006,"resolution": 19.109294301921938}, {
	    	      "level": 6,"scale": 36111.980000000003,"resolution": 9.5546471509609692}, {
	    	      "level": 7,"scale": 18055.990000000002,"resolution": 4.7773235754804846}, {
	    	      "level": 8,"scale": 9028,"resolution": 2.3886631106595546}, {
	    	      "level": 9,"scale": 4514,"resolution": 1.1943315553297773}, {
	    	      "level": 10,"scale": 2257,"resolution": 0.59716577766488865}, {
	    	      "level": 11,"scale": 1128.5,"resolution": 0.29858288883244433}, {
	    	      "level": 12,"scale": 564.25,"resolution": 0.14929144441622216}]});;
	    this.loaded = true;
	    this.onLoad(this);
	},
	getTileUrl: function(level, row, col) {
		return "http://10.14.100.24/tileservice/SGDOM3000?userName=test123&password=test123&TILEMATRIXSET=sss&SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetTile&LAYER=0&STYLE=default&FORMAT=image/png&TILEMATRIX=" + level + "&TILEROW=" + row + "&TILECOL=" + col;
	}
});

dojo.declare("my.SGRoad", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
	    this.spatialReference = new esri.SpatialReference({wkid:0});
	    this.initialExtent = map.extent;
	    this.fullExtent = map.extent;
	    this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 0},
		    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
	    	      "level": 0,"scale": 2311166.8399999999,"resolution": 611.49744941156553}, {
	    	      "level": 1,"scale": 1155583.4199999999,"resolution": 305.74872470578276}, {
	    	      "level": 2,"scale": 577791.70999999996,"resolution": 152.87436235289138}, {
	    	      "level": 3,"scale": 288895.84999999998,"resolution": 76.437179853526374}, {
	    	      "level": 4,"scale": 144447.92999999999,"resolution": 38.218591249682497}, {
	    	      "level": 5,"scale": 72223.960000000006,"resolution": 19.109294301921938}, {
	    	      "level": 6,"scale": 36111.980000000003,"resolution": 9.5546471509609692}, {
	    	      "level": 7,"scale": 18055.990000000002,"resolution": 4.7773235754804846}, {
	    	      "level": 8,"scale": 9028,"resolution": 2.3886631106595546}, {
	    	      "level": 9,"scale": 4514,"resolution": 1.1943315553297773}, {
	    	      "level": 10,"scale": 2257,"resolution": 0.59716577766488865}, {
	    	      "level": 11,"scale": 1128.5,"resolution": 0.29858288883244433}, {
	    	      "level": 12,"scale": 564.25,"resolution": 0.14929144441622216}]});;
	    this.loaded = true;
	    this.onLoad(this);
	},
	getTileUrl: function(level, row, col) {
		return "http://10.14.100.24/tileservice/SGRoad?userName=test123&password=test123&TILEMATRIXSET=sss&SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetTile&LAYER=0&STYLE=default&FORMAT=image/png&TILEMATRIX=" + level + "&TILEROW=" + row + "&TILECOL=" + col;
	}
});

dojo.declare("my.SGDOM1000", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
	    this.spatialReference = new esri.SpatialReference({wkid:0});
	    this.initialExtent = map.extent;
	    this.fullExtent = map.extent;
	    this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 0},
		    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
	    	      "level": 0,"scale": 2311166.8399999999,"resolution": 611.49744941156553}, {
	    	      "level": 1,"scale": 1155583.4199999999,"resolution": 305.74872470578276}, {
	    	      "level": 2,"scale": 577791.70999999996,"resolution": 152.87436235289138}, {
	    	      "level": 3,"scale": 288895.84999999998,"resolution": 76.437179853526374}, {
	    	      "level": 4,"scale": 144447.92999999999,"resolution": 38.218591249682497}, {
	    	      "level": 5,"scale": 72223.960000000006,"resolution": 19.109294301921938}, {
	    	      "level": 6,"scale": 36111.980000000003,"resolution": 9.5546471509609692}, {
	    	      "level": 7,"scale": 18055.990000000002,"resolution": 4.7773235754804846}, {
	    	      "level": 8,"scale": 9028,"resolution": 2.3886631106595546}, {
	    	      "level": 9,"scale": 4514,"resolution": 1.1943315553297773}, {
	    	      "level": 10,"scale": 2257,"resolution": 0.59716577766488865}, {
	    	      "level": 11,"scale": 1128.5,"resolution": 0.29858288883244433}, {
	    	      "level": 12,"scale": 564.25,"resolution": 0.14929144441622216}]});;
	    this.loaded = true;
	    this.onLoad(this);
	},
	getTileUrl: function(level, row, col) {
		return "http://10.14.100.24/tileservice/SGDOM1000?userName=test123&password=test123&TILEMATRIXSET=sss&SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetTile&LAYER=0&STYLE=default&FORMAT=image/png&TILEMATRIX=" + level + "&TILEROW=" + row + "&TILECOL=" + col;
	}
});

dojo.declare("my.SGDOM500", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
	    this.spatialReference = new esri.SpatialReference({wkid:0});
	    this.initialExtent = map.extent;
	    this.fullExtent = map.extent;
	    this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 0},
		    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
	    	      "level": 0,"scale": 2311166.8399999999,"resolution": 611.49744941156553}, {
	    	      "level": 1,"scale": 1155583.4199999999,"resolution": 305.74872470578276}, {
	    	      "level": 2,"scale": 577791.70999999996,"resolution": 152.87436235289138}, {
	    	      "level": 3,"scale": 288895.84999999998,"resolution": 76.437179853526374}, {
	    	      "level": 4,"scale": 144447.92999999999,"resolution": 38.218591249682497}, {
	    	      "level": 5,"scale": 72223.960000000006,"resolution": 19.109294301921938}, {
	    	      "level": 6,"scale": 36111.980000000003,"resolution": 9.5546471509609692}, {
	    	      "level": 7,"scale": 18055.990000000002,"resolution": 4.7773235754804846}, {
	    	      "level": 8,"scale": 9028,"resolution": 2.3886631106595546}, {
	    	      "level": 9,"scale": 4514,"resolution": 1.1943315553297773}, {
	    	      "level": 10,"scale": 2257,"resolution": 0.59716577766488865}, {
	    	      "level": 11,"scale": 1128.5,"resolution": 0.29858288883244433}, {
	    	      "level": 12,"scale": 564.25,"resolution": 0.14929144441622216}]});;
	    this.loaded = true;
	    this.onLoad(this);
    },
    getTileUrl: function(level, row, col) {
	    return "http://10.14.100.24/tileservice/SGDOM500?userName=test123&password=test123&TILEMATRIXSET=sss&SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetTile&LAYER=0&STYLE=default&FORMAT=image/png&TILEMATRIX=" + level + "&TILEROW=" + row + "&TILECOL=" + col;
    }
});

dojo.declare("my.SGRaster", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
	    this.spatialReference = new esri.SpatialReference({wkid:0});
	    this.initialExtent = map.extent;
	    this.fullExtent = map.extent;
	    this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 0},
		    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
	    	      "level": 0,"scale": 2311166.8399999999,"resolution": 611.49744941156553}, {
	    	      "level": 1,"scale": 1155583.4199999999,"resolution": 305.74872470578276}, {
	    	      "level": 2,"scale": 577791.70999999996,"resolution": 152.87436235289138}, {
	    	      "level": 3,"scale": 288895.84999999998,"resolution": 76.437179853526374}, {
	    	      "level": 4,"scale": 144447.92999999999,"resolution": 38.218591249682497}, {
	    	      "level": 5,"scale": 72223.960000000006,"resolution": 19.109294301921938}, {
	    	      "level": 6,"scale": 36111.980000000003,"resolution": 9.5546471509609692}, {
	    	      "level": 7,"scale": 18055.990000000002,"resolution": 4.7773235754804846}, {
	    	      "level": 8,"scale": 9028,"resolution": 2.3886631106595546}, {
	    	      "level": 9,"scale": 4514,"resolution": 1.1943315553297773}, {
	    	      "level": 10,"scale": 2257,"resolution": 0.59716577766488865}, {
	    	      "level": 11,"scale": 1128.5,"resolution": 0.29858288883244433}, {
	    	      "level": 12,"scale": 564.25,"resolution": 0.14929144441622216}]});;
	    this.loaded = true;
	    this.onLoad(this);
	    },
	    getTileUrl: function(level, row, col) {
	        return "http://10.14.100.24/tileservice/SGRaster?userName=test123&password=test123&TILEMATRIXSET=sss&SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetTile&LAYER=0&STYLE=default&FORMAT=image/png&TILEMATRIX=" + level + "&TILEROW=" + row + "&TILECOL=" + col;
	    }
});

dojo.declare("my.SGMap", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
        this.spatialReference = new esri.SpatialReference({wkid:0});
	    this.initialExtent = map.extent;
	    this.fullExtent = map.extent;
	    this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 0},
		    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
	    	      "level": 0,"scale": 2311166.8399999999,"resolution": 611.49744941156553}, {
	    	      "level": 1,"scale": 1155583.4199999999,"resolution": 305.74872470578276}, {
	    	      "level": 2,"scale": 577791.70999999996,"resolution": 152.87436235289138}, {
	    	      "level": 3,"scale": 288895.84999999998,"resolution": 76.437179853526374}, {
	    	      "level": 4,"scale": 144447.92999999999,"resolution": 38.218591249682497}, {
	    	      "level": 5,"scale": 72223.960000000006,"resolution": 19.109294301921938}, {
	    	      "level": 6,"scale": 36111.980000000003,"resolution": 9.5546471509609692}, {
	    	      "level": 7,"scale": 18055.990000000002,"resolution": 4.7773235754804846}, {
	    	      "level": 8,"scale": 9028,"resolution": 2.3886631106595546}, {
	    	      "level": 9,"scale": 4514,"resolution": 1.1943315553297773}, {
	    	      "level": 10,"scale": 2257,"resolution": 0.59716577766488865}, {
	    	      "level": 11,"scale": 1128.5,"resolution": 0.29858288883244433}, {
	    	      "level": 12,"scale": 564.25,"resolution": 0.14929144441622216}]});
	    this.loaded = true;
	    this.onLoad(this);
    },
    getTileUrl: function(level, row, col) {
	    return "http://10.14.100.24/tileservice/SGMap?userName=test123&password=test123&TILEMATRIXSET=sss&SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetTile&LAYER=0&STYLE=default&FORMAT=image/png&TILEMATRIX=" + level + "&TILEROW=" + row + "&TILECOL=" + col;
    }
});
dojo.declare("my.SGMapWW", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
        this.spatialReference = new esri.SpatialReference({wkid:0});
	    this.initialExtent = map.extent;
	    this.fullExtent = map.extent;
	    this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 0},
		    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
	    	      "level": 0,"scale": 295497593.05879998,"resolution": 0.70312500000011879}, {
	    	      "level": 1,"scale": 147748796.52939999,"resolution": 0.3515625000000594}, {
	    	      "level": 2,"scale": 73874398.264699996,"resolution": 0.1757812500000297}, {
	    	      "level": 3,"scale": 36937199.132349998,"resolution": 0.087890625000014849}, {
	    	      "level": 4,"scale": 18468599.566174999,"resolution": 0.043945312500007425}, {
	    	      "level": 5,"scale": 9234299.7830874994,"resolution": 0.021972656250003712}, {
	    	      "level": 6,"scale": 4617149.8915437497,"resolution": 0.010986328125001856}, {
	    	      "level": 7,"scale": 2308574.9457718749,"resolution": 0.0054931640625009281}, {
	    	      "level": 8,"scale": 1154287.4728859374,"resolution": 0.002746582031250464}, {
	    	      "level": 9,"scale": 577143.73644296871,"resolution": 0.001373291015625232}, {
	    	      "level": 10,"scale": 288571.86822148436,"resolution": 0.00068664550781261601}, {
	    	      "level": 11,"scale": 144285.93411074218,"resolution": 0.000343322753906308}, {
				  "level": 12,"scale": 72142.967055371089,"resolution": 0.000171661376953154}, {
				  "level": 13,"scale": 36071.483527685545,"resolution": 0.000085830688476577001}, {
				  "level": 14,"scale": 18035.741763842772,"resolution": 4.2915344238288501e-005}, {
				  "level": 15,"scale": 9017.8708819213862,"resolution": 2.145767211914425e-005}, {
				  "level": 16,"scale": 4508.9354409606931,"resolution": 1.0728836059572125e-005}, {
				  "level": 17,"scale": 2254.4677204803465,"resolution": 5.3644180297860626e-006}, {
				  "level": 18,"scale": 1127.2338602401733,"resolution": 2.6822090148930313e-006}, {
	    	      "level": 19,"scale": 563.61693012008664,"resolution": 1.3411045074465156e-006}]});
	    this.loaded = true;
	    this.onLoad(this);
    },
    getTileUrl: function(level, row, col) {
	    return "http://123.131.86.228:81/tileservice/SGMap?userName=test123&password=test123&TILEMATRIXSET=sss&SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetTile&LAYER=0&STYLE=default&FORMAT=image/png&TILEMATRIX=" + level + "&TILEROW=" + row + "&TILECOL=" + col;
    }
});
///MYWMS////////////////////////////////////////////////////////////////////////////////////////////////////////
dojo.declare("my.ZPG", esri.layers.DynamicMapServiceLayer, {
    constructor: function(dpi, xx, yy) {
        this.initialExtent = this.fullExtent = map.extent;
        this.spatialReference = new esri.SpatialReference({wkid:0});
        this.loaded = true;
        this.onLoad(this);
    },
    getImageUrl: function(extent, width, height, callback) {
        var params = {
            request:"GetMap",
            transparent:true,
            format:"image/png",
            bgcolor:"ffffff",
            version:"1.1.1",
            layers:"0",
            styles: "default,default",
            exceptions: "application/vnd.ogc.se_xml",
            bbox:extent.xmin + "," + extent.ymin + "," + extent.xmax + "," + extent.ymax,
            srs: "EPSG:0",
            width: width,
            height: height
        };
        callback("http://10.14.100.23/arcgis/services/ZPG/MapServer/WMSServer?userName=test123&password=test123&" + dojo.objectToQuery(params));
    }
});

dojo.declare("my.TSSC", esri.layers.DynamicMapServiceLayer, {
    constructor: function(dpi, xx, yy) {
        this.initialExtent = this.fullExtent = map.extent;
        this.spatialReference = new esri.SpatialReference({wkid:0});
        this.loaded = true;
        this.onLoad(this);
    },
    getImageUrl: function(extent, width, height, callback) {
        var params = {
            request:"GetMap",
            transparent:true,
            format:"image/png",
            bgcolor:"ffffff",
            version:"1.1.1",
            layers:"0",
            styles: "default,default",
            exceptions: "application/vnd.ogc.se_xml",
            bbox:extent.xmin + "," + extent.ymin + "," + extent.xmax + "," + extent.ymax,
            srs: "EPSG:0",
            width: width,
            height: height
        };
        callback("http://10.14.100.23/arcgis/services/TSSC/MapServer/WMSServer?userName=test123&password=test123&" + dojo.objectToQuery(params));
    }
});

dojo.declare("my.SCYUANQU", esri.layers.DynamicMapServiceLayer, {
    constructor: function(dpi, xx, yy) {
        this.initialExtent = this.fullExtent = map.extent;
        this.spatialReference = new esri.SpatialReference({wkid:0});
        this.loaded = true;
        this.onLoad(this);
    },
    getImageUrl: function(extent, width, height, callback) {
        var params = {
            request:"GetMap",
            transparent:true,
            format:"image/png",
            bgcolor:"ffffff",
            version:"1.1.1",
            layers:"0",
            styles: "default,default",
            exceptions: "application/vnd.ogc.se_xml",
            bbox:extent.xmin + "," + extent.ymin + "," + extent.xmax + "," + extent.ymax,
            srs: "EPSG:0",
            width: width,
            height: height
        };
        callback("http://10.14.100.23/arcgis/services/SCYUANQU/MapServer/WMSServer?userName=test123&password=test123&" + dojo.objectToQuery(params));
    }
});

dojo.declare("my.SCQY", esri.layers.DynamicMapServiceLayer, {
    constructor: function(dpi, xx, yy) {
        this.initialExtent = this.fullExtent = map.extent;
        this.spatialReference = new esri.SpatialReference({wkid:0});
        this.loaded = true;
        this.onLoad(this);
    },
    getImageUrl: function(extent, width, height, callback) {
        var params = {
            request:"GetMap",
            transparent:true,
            format:"image/png",
            bgcolor:"ffffff",
            version:"1.1.1",
            layers:"0",
            styles: "default,default",
            exceptions: "application/vnd.ogc.se_xml",
            bbox:extent.xmin + "," + extent.ymin + "," + extent.xmax + "," + extent.ymax,
            srs: "EPSG:0",
            width: width,
            height: height
        };
        callback("http://10.14.100.23/arcgis/services/SCQY/MapServer/WMSServer?userName=test123&password=test123&" + dojo.objectToQuery(params));
    }
});

dojo.declare("my.NYJSF_NYYuanQu", esri.layers.DynamicMapServiceLayer, {
    constructor: function(dpi, xx, yy) {
        this.initialExtent = this.fullExtent = map.extent;
        this.spatialReference = new esri.SpatialReference({wkid:0});
        this.loaded = true;
        this.onLoad(this);
    },
    getImageUrl: function(extent, width, height, callback) {
        var params = {
            request:"GetMap",
            transparent:true,
            format:"image/png",
            bgcolor:"ffffff",
            version:"1.1.1",
            layers:"0",
            styles: "default,default",
            exceptions: "application/vnd.ogc.se_xml",
            bbox:extent.xmin + "," + extent.ymin + "," + extent.xmax + "," + extent.ymax,
            srs: "EPSG:0",
            width: width,
            height: height
        };
        callback("http://10.14.100.23/arcgis/services/NYJSF_NYYuanQu/MapServer/WMSServer?userName=test123&password=test123&" + dojo.objectToQuery(params));
    }
});

dojo.declare("my.NYJSF_NYTeSeShuCai", esri.layers.DynamicMapServiceLayer, {
    constructor: function(dpi, xx, yy) {
        this.initialExtent = this.fullExtent = map.extent;
        this.spatialReference = new esri.SpatialReference({wkid:0});
        this.loaded = true;
        this.onLoad(this);
    },
    getImageUrl: function(extent, width, height, callback) {
        var params = {
            request:"GetMap",
            transparent:true,
            format:"image/png",
            bgcolor:"ffffff",
            version:"1.1.1",
            layers:"0",
            styles: "default,default",
            exceptions: "application/vnd.ogc.se_xml",
            bbox:extent.xmin + "," + extent.ymin + "," + extent.xmax + "," + extent.ymax,
            srs: "EPSG:0",
            width: width,
            height: height
        };
        callback("http://10.14.100.23/arcgis/services/NYJSF_NYTeSeShuCai/MapServer/WMSServer?userName=test123&password=test123&" + dojo.objectToQuery(params));
    }
});

dojo.declare("my.NYJSF_NYQiYe", esri.layers.DynamicMapServiceLayer, {
    constructor: function(dpi, xx, yy) {
        this.initialExtent = this.fullExtent = map.extent;
        this.spatialReference = new esri.SpatialReference({wkid:0});
        this.loaded = true;
        this.onLoad(this);
    },
    getImageUrl: function(extent, width, height, callback) {
        var params = {
            request:"GetMap",
            transparent:true,
            format:"image/png",
            bgcolor:"ffffff",
            version:"1.1.1",
            layers:"0",
            styles: "default,default",
            exceptions: "application/vnd.ogc.se_xml",
            bbox:extent.xmin + "," + extent.ymin + "," + extent.xmax + "," + extent.ymax,
            srs: "EPSG:0",
            width: width,
            height: height
        };
        callback("http://10.14.100.23/arcgis/services/NYJSF_NYQiYe/MapServer/WMSServer?userName=test123&password=test123&" + dojo.objectToQuery(params));
    }
});

dojo.declare("my.NYJSF_DXH", esri.layers.DynamicMapServiceLayer, {
    constructor: function(dpi, xx, yy) {
        this.initialExtent = this.fullExtent = map.extent;
        this.spatialReference = new esri.SpatialReference({wkid:0});
        this.loaded = true;
        this.onLoad(this);
    },
    getImageUrl: function(extent, width, height, callback) {
        var params = {
            request:"GetMap",
            transparent:true,
            format:"image/png",
            bgcolor:"ffffff",
            version:"1.1.1",
            layers:"0",
            styles: "default,default",
            exceptions: "application/vnd.ogc.se_xml",
            bbox:extent.xmin + "," + extent.ymin + "," + extent.xmax + "," + extent.ymax,
            srs: "EPSG:0",
            width: width,
            height: height
        };
        callback("http://10.14.100.23/arcgis/services/NYJSF_DXH/MapServer/WMSServer?userName=test123&password=test123&" + dojo.objectToQuery(params));
    }
});

dojo.declare("my.JZDJ", esri.layers.DynamicMapServiceLayer, {
    constructor: function(dpi, xx, yy) {
        this.initialExtent = this.fullExtent = map.extent;
        this.spatialReference = new esri.SpatialReference({wkid:0});
        this.loaded = true;
        this.onLoad(this);
    },
    getImageUrl: function(extent, width, height, callback) {
        var params = {
            request:"GetMap",
            transparent:true,
            format:"image/png",
            bgcolor:"ffffff",
            version:"1.1.1",
            layers:"0",
            styles: "default,default",
            exceptions: "application/vnd.ogc.se_xml",
            bbox:extent.xmin + "," + extent.ymin + "," + extent.xmax + "," + extent.ymax,
            srs: "EPSG:0",
            width: width,
            height: height
        };
        callback("http://10.14.100.23/arcgis/services/JZDJ/MapServer/WMSServer?userName=test123&password=test123&" + dojo.objectToQuery(params));
    }
});

dojo.declare("my.GHSF", esri.layers.DynamicMapServiceLayer, {
    constructor: function(dpi, xx, yy) {
        this.initialExtent = this.fullExtent = map.extent;
        this.spatialReference = new esri.SpatialReference({wkid:0});
        this.loaded = true;
        this.onLoad(this);
    },
    getImageUrl: function(extent, width, height, callback) {
        var params = {
            request:"GetMap",
            transparent:true,
            format:"image/png",
            bgcolor:"ffffff",
            version:"1.1.1",
            layers:"0",
            styles: "default,default",
            exceptions: "application/vnd.ogc.se_xml",
            bbox:extent.xmin + "," + extent.ymin + "," + extent.xmax + "," + extent.ymax,
            srs: "EPSG:0",
            width: width,
            height: height
        };
        callback("http://10.14.100.23/arcgis/services/GHSF/MapServer/WMSServer?userName=test123&password=test123&" + dojo.objectToQuery(params));
    }
});

dojo.declare("my.DLHX", esri.layers.DynamicMapServiceLayer, {
    constructor: function(dpi, xx, yy) {
        this.initialExtent = this.fullExtent = map.extent;
        this.spatialReference = new esri.SpatialReference({wkid:0});
        this.loaded = true;
        this.onLoad(this);
    },
    getImageUrl: function(extent, width, height, callback) {
        var params = {
            request:"GetMap",
            transparent:true,
            format:"image/png",
            bgcolor:"ffffff",
            version:"1.1.1",
            layers:"0",
            styles: "default,default",
            exceptions: "application/vnd.ogc.se_xml",
            bbox:extent.xmin + "," + extent.ymin + "," + extent.xmax + "," + extent.ymax,
            srs: "EPSG:0",
            width: width,
            height: height
        };
        callback("http://10.14.100.23/arcgis/services/DLHX/MapServer/WMSServer?userName=test123&password=test123&" + dojo.objectToQuery(params));
    }
});

dojo.declare("my.dmdz_ztfl", esri.layers.DynamicMapServiceLayer, {
    constructor: function(dpi, xx, yy) {
        this.initialExtent = this.fullExtent = map.extent;
        this.spatialReference = new esri.SpatialReference({wkid:0});
        this.loaded = true;
        this.onLoad(this);
    },
    getImageUrl: function(extent, width, height, callback) {
        var params = {
            request:"GetMap",
            transparent:true,
            format:"image/png",
            bgcolor:"ffffff",
            version:"1.1.1",
            layers:"0",
            styles: "default,default",
            exceptions: "application/vnd.ogc.se_xml",
            bbox:extent.xmin + "," + extent.ymin + "," + extent.xmax + "," + extent.ymax,
            srs: "EPSG:0",
            width: width,
            height: height
        };
        callback("http://10.14.100.23/arcgis/services/dmdz_ztfl/MapServer/WMSServer?userName=test123&password=test123&" + dojo.objectToQuery(params));
    }
});

dojo.declare("my.dmdz_xqd", esri.layers.DynamicMapServiceLayer, {
    constructor: function(dpi, xx, yy) {
        this.initialExtent = this.fullExtent = map.extent;
        this.spatialReference = new esri.SpatialReference({wkid:0});
        this.loaded = true;
        this.onLoad(this);
    },
    getImageUrl: function(extent, width, height, callback) {
        var params = {
            request:"GetMap",
            transparent:true,
            format:"image/png",
            bgcolor:"ffffff",
            version:"1.1.1",
            layers:"0",
            styles: "default,default",
            exceptions: "application/vnd.ogc.se_xml",
            bbox:extent.xmin + "," + extent.ymin + "," + extent.xmax + "," + extent.ymax,
            srs: "EPSG:0",
            width: width,
            height: height
        };
        callback("http://10.14.100.23/arcgis/services/dmdz_xqd/MapServer/WMSServer?userName=test123&password=test123&" + dojo.objectToQuery(params));
    }
});

dojo.declare("my.dlst500and1000", esri.layers.DynamicMapServiceLayer, {
    constructor: function(dpi, xx, yy) {
        this.initialExtent = this.fullExtent = map.extent;
        this.spatialReference = new esri.SpatialReference({wkid:0});
        this.loaded = true;
        this.onLoad(this);
    },
    getImageUrl: function(extent, width, height, callback) {
        var params = {
            request:"GetMap",
            transparent:true,
            format:"image/png",
            bgcolor:"ffffff",
            version:"1.1.1",
            layers:"0",
            styles: "default,default",
            exceptions: "application/vnd.ogc.se_xml",
            bbox:extent.xmin + "," + extent.ymin + "," + extent.xmax + "," + extent.ymax,
            srs: "EPSG:0",
            width: width,
            height: height
        };
        callback("http://10.14.100.23/arcgis/services/dlst500and1000/MapServer/WMSServer?userName=test123&password=test123&" + dojo.objectToQuery(params));
    }
});

dojo.declare("my.dlst50000", esri.layers.DynamicMapServiceLayer, {
    constructor: function(dpi, xx, yy) {
        this.initialExtent = this.fullExtent = map.extent;
        this.spatialReference = new esri.SpatialReference({wkid:0});
        this.loaded = true;
        this.onLoad(this);
    },
    getImageUrl: function(extent, width, height, callback) {
        var params = {
            request:"GetMap",
            transparent:true,
            format:"image/png",
            bgcolor:"ffffff",
            version:"1.1.1",
            layers:"0",
            styles: "default,default",
            exceptions: "application/vnd.ogc.se_xml",
            bbox:extent.xmin + "," + extent.ymin + "," + extent.xmax + "," + extent.ymax,
            srs: "EPSG:0",
            width: width,
            height: height
        };
        callback("http://10.14.100.23/arcgis/services/dlst50000/MapServer/WMSServer?userName=test123&password=test123&" + dojo.objectToQuery(params));
    }
});

dojo.declare("my.dlst10000", esri.layers.DynamicMapServiceLayer, {
    constructor: function(dpi, xx, yy) {
        this.initialExtent = this.fullExtent = map.extent;
        this.spatialReference = new esri.SpatialReference({wkid:0});
        this.loaded = true;
        this.onLoad(this);
    },
    getImageUrl: function(extent, width, height, callback) {
        var params = {
            request:"GetMap",
            transparent:true,
            format:"image/png",
            bgcolor:"ffffff",
            version:"1.1.1",
            layers:"0",
            styles: "default,default",
            exceptions: "application/vnd.ogc.se_xml",
            bbox:extent.xmin + "," + extent.ymin + "," + extent.xmax + "," + extent.ymax,
            srs: "EPSG:0",
            width: width,
            height: height
        };
        callback("http://10.14.100.23/arcgis/services/dlst10000/MapServer/WMSServer?userName=test123&password=test123&" + dojo.objectToQuery(params));
    }
});

dojo.declare("my.SGRaster_WMS_C", esri.layers.DynamicMapServiceLayer, {
    constructor: function(dpi, xx, yy) {
        this.initialExtent = this.fullExtent = map.extent;
        this.spatialReference = new esri.SpatialReference({wkid:0});
        this.loaded = true;
        this.onLoad(this);
    },
    getImageUrl: function(extent, width, height, callback) {
        var params = {
            request:"GetMap",
            transparent:true,
            format:"image/png",
            bgcolor:"ffffff",
            version:"1.1.1",
            layers:"0",
            styles: "default,default",
            exceptions: "application/vnd.ogc.se_xml",
            bbox:extent.xmin + "," + extent.ymin + "," + extent.xmax + "," + extent.ymax,
            srs: "EPSG:0",
            width: width,
            height: height
        };
        callback("http://10.14.100.24/WMS-CService/service/SGRaster_WMS_C?userName=test123&password=test123&" + dojo.objectToQuery(params));
    }
});

dojo.declare("my.SGDOM500_WMS_C", esri.layers.DynamicMapServiceLayer, {
    constructor: function(dpi, xx, yy) {
        this.initialExtent = this.fullExtent = map.extent;
        this.spatialReference = new esri.SpatialReference({wkid:0});
        this.loaded = true;
        this.onLoad(this);
    },
    getImageUrl: function(extent, width, height, callback) {
        var params = {
            request:"GetMap",
            transparent:true,
            format:"image/png",
            bgcolor:"ffffff",
            version:"1.1.1",
            layers:"0",
            styles: "default,default",
            exceptions: "application/vnd.ogc.se_xml",
            bbox:extent.xmin + "," + extent.ymin + "," + extent.xmax + "," + extent.ymax,
            srs: "EPSG:0",
            width: width,
            height: height
        };
        callback("http://10.14.100.24/WMS-CService/service/SGDOM500_WMS_C?userName=test123&password=test123&" + dojo.objectToQuery(params));
    }
});

dojo.declare("my.SGDOM3000_WMS_C", esri.layers.DynamicMapServiceLayer, {
    constructor: function(dpi, xx, yy) {
        this.initialExtent = this.fullExtent = map.extent;
        this.spatialReference = new esri.SpatialReference({wkid:0});
        this.loaded = true;
        this.onLoad(this);
    },
    getImageUrl: function(extent, width, height, callback) {
        var params = {
            request:"GetMap",
            transparent:true,
            format:"image/png",
            bgcolor:"ffffff",
            version:"1.1.1",
            layers:"0",
            styles: "default,default",
            exceptions: "application/vnd.ogc.se_xml",
            bbox:extent.xmin + "," + extent.ymin + "," + extent.xmax + "," + extent.ymax,
            srs: "EPSG:0",
            width: width,
            height: height
        };
        callback("http://10.14.100.24/WMS-CService/service/SGDOM3000_WMS_C?userName=test123&password=test123&" + dojo.objectToQuery(params));
    }
});

dojo.declare("my.SGDOM1000_WMS_C", esri.layers.DynamicMapServiceLayer, {
    constructor: function(dpi, xx, yy) {
        this.initialExtent = this.fullExtent = map.extent;
        this.spatialReference = new esri.SpatialReference({wkid:0});
        this.loaded = true;
        this.onLoad(this);
    },
    getImageUrl: function(extent, width, height, callback) {
        var params = {
            request:"GetMap",
            transparent:true,
            format:"image/png",
            bgcolor:"ffffff",
            version:"1.1.1",
            layers:"0",
            styles: "default,default",
            exceptions: "application/vnd.ogc.se_xml",
            bbox:extent.xmin + "," + extent.ymin + "," + extent.xmax + "," + extent.ymax,
            srs: "EPSG:0",
            width: width,
            height: height
        };
        callback("http://10.14.100.24/WMS-CService/service/SGDOM1000_WMS_C?userName=test123&password=test123&" + dojo.objectToQuery(params));
    }
});

