///////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////    WMTS and WMS Services infomation for JINAN by wanglei         2012-05-09 at JINAN
///WMTS////////////////////////////////////////////////////////////////////////////////////////////////////////
var zdextend = new esri.geometry.Extent(39422483.061679855,3980502.085949423,39573615.73900516,4164488.347456437, this.spatialReference);


///////////////////////////

dojo.declare("my.XZQ", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
	this.spatialReference = new esri.SpatialReference({wkid:2363});
	this.initialExtent = zdextend;
	this.fullExtent = zdextend;
	this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 2363},
	    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
  	      "level": 0,"scale": 2000000.0,"resolution":529.1677250021168}, {
  	      "level": 1,"scale": 1000000.0,"resolution": 264.5838625010584}, {
  	      "level": 2,"scale": 500000.0,"resolution": 132.2919312505292}, {
  	      "level": 3,"scale": 250000.0,"resolution": 66.1459656252646}, {
  	      "level": 4,"scale": 125000.0,"resolution": 33.0729828126323}, {
  	      "level": 5,"scale": 62500.0,"resolution": 16.53649140631615}, {
  	      "level": 6,"scale": 31250.0,"resolution": 8.268245703158074}, {
  	      "level": 7,"scale": 15625.0,"resolution": 4.134122851579037}, {
  	      "level": 8,"scale": 7812.5,"resolution": 2.0670614257895186}, {
  	      "level": 9,"scale": 3906.25,"resolution": 1.0335307128947593}, {
  	      "level": 10,"scale": 1953.125,"resolution": 0.5167653564473796}, {
  	      "level": 11,"scale": 976.5625,"resolution": 0.2583826782236898}]});;
	this.loaded = true;
	this.onLoad(this);
},
getTileUrl: function(level, row, col) {
	//return "http://10.14.100.22/MapgisOGCWebService/Service/KVP/TDLYXZ/WMTS?service=WMTS&request=GetTile&layer=0&style=default&format=image/png&tileMatrixSet=IndexDC.HDF&TILEMATRIX=" + level + "&TILEROW=" + row + "&TILECOL=" + col;
	//return "http://10.11.2.8:8399/arcgis/restrvices/index/MapServer/tile/"+level+"/"+row+"/"+col;
	return "http://10.11.2.11/arcgiscache/index/Layers/_alllayers/L" + level + "/R" + row.toString(16) + "/C" + col.toString(16) + ".png";
}
});

//////////////////////////

dojo.declare("my.DT2010", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
	this.spatialReference = new esri.SpatialReference({wkid:2363});
	this.initialExtent = zdextend;
	this.fullExtent = zdextend;
	this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 2363},
	    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
  	      "level": 0,"scale": 2000000.0,"resolution":529.1677250021168}, {
  	      "level": 1,"scale": 1000000.0,"resolution": 264.5838625010584}, {
  	      "level": 2,"scale": 500000.0,"resolution": 132.2919312505292}, {
  	      "level": 3,"scale": 250000.0,"resolution": 66.1459656252646}, {
  	      "level": 4,"scale": 125000.0,"resolution": 33.0729828126323}, {
  	      "level": 5,"scale": 62500.0,"resolution": 16.53649140631615}, {
  	      "level": 6,"scale": 31250.0,"resolution": 8.268245703158074}, {
  	      "level": 7,"scale": 15625.0,"resolution": 4.134122851579037}, {
  	      "level": 8,"scale": 7812.5,"resolution": 2.0670614257895186}, {
  	      "level": 9,"scale": 3906.25,"resolution": 1.0335307128947593}, {
  	      "level": 10,"scale": 1953.125,"resolution": 0.5167653564473796}, {
  	      "level": 11,"scale": 976.5625,"resolution": 0.2583826782236898}]});;
	this.loaded = true;
	this.onLoad(this);
},
getTileUrl: function(level, row, col) {
	return "http://10.11.2.11/arcgiscache/indexdt2010/Layers/_alllayers/L" + level + "/R" + row.toString(16) + "/C" + col.toString(16) + ".png";
}
});

/////////////////////////

dojo.declare("my.DC2009", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
	this.spatialReference = new esri.SpatialReference({wkid:2363});
	this.initialExtent = zdextend;
	this.fullExtent = zdextend;
	this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 2363},
	    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
  	      "level": 0,"scale": 2000000.0,"resolution":529.1677250021168}, {
  	      "level": 1,"scale": 1000000.0,"resolution": 264.5838625010584}, {
  	      "level": 2,"scale": 500000.0,"resolution": 132.2919312505292}, {
  	      "level": 3,"scale": 250000.0,"resolution": 66.1459656252646}, {
  	      "level": 4,"scale": 125000.0,"resolution": 33.0729828126323}, {
  	      "level": 5,"scale": 62500.0,"resolution": 16.53649140631615}, {
  	      "level": 6,"scale": 31250.0,"resolution": 8.268245703158074}, {
  	      "level": 7,"scale": 15625.0,"resolution": 4.134122851579037}, {
  	      "level": 8,"scale": 7812.5,"resolution": 2.0670614257895186}, {
  	      "level": 9,"scale": 3906.25,"resolution": 1.0335307128947593}, {
  	      "level": 10,"scale": 1953.125,"resolution": 0.5167653564473796}, {
  	      "level": 11,"scale": 976.5625,"resolution": 0.2583826782236898}]});;
	this.loaded = true;
	this.onLoad(this);
},
getTileUrl: function(level, row, col) {
	return "http://10.11.2.11/arcgiscache/indexdc2009/Layers/_alllayers/L" + level + "/R" + row.toString(16) + "/C" + col.toString(16) + ".png";
}
});

/////////////////////////

dojo.declare("my.NT2009", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
	this.spatialReference = new esri.SpatialReference({wkid:2363});
	this.initialExtent = zdextend;
	this.fullExtent = zdextend;
	this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 2363},
	    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
  	      "level": 0,"scale": 2000000.0,"resolution":529.1677250021168}, {
  	      "level": 1,"scale": 1000000.0,"resolution": 264.5838625010584}, {
  	      "level": 2,"scale": 500000.0,"resolution": 132.2919312505292}, {
  	      "level": 3,"scale": 250000.0,"resolution": 66.1459656252646}, {
  	      "level": 4,"scale": 125000.0,"resolution": 33.0729828126323}, {
  	      "level": 5,"scale": 62500.0,"resolution": 16.53649140631615}, {
  	      "level": 6,"scale": 31250.0,"resolution": 8.268245703158074}, {
  	      "level": 7,"scale": 15625.0,"resolution": 4.134122851579037}, {
  	      "level": 8,"scale": 7812.5,"resolution": 2.0670614257895186}, {
  	      "level": 9,"scale": 3906.25,"resolution": 1.0335307128947593}, {
  	      "level": 10,"scale": 1953.125,"resolution": 0.5167653564473796}, {
  	      "level": 11,"scale": 976.5625,"resolution": 0.2583826782236898}]});;
	this.loaded = true;
	this.onLoad(this);
},
getTileUrl: function(level, row, col) {
	return "http://10.11.2.11/arcgiscache/indexnt2009/Layers/_alllayers/L" + level + "/R" + row.toString(16) + "/C" + col.toString(16) + ".png";
}
});

/////////////////////

dojo.declare("my.CG2010G", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
	this.spatialReference = new esri.SpatialReference({wkid:2363});
	this.initialExtent = zdextend;
	this.fullExtent = zdextend;
	this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 2363},
	    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
  	      "level": 0,"scale": 2000000.0,"resolution":529.1677250021168}, {
  	      "level": 1,"scale": 1000000.0,"resolution": 264.5838625010584}, {
  	      "level": 2,"scale": 500000.0,"resolution": 132.2919312505292}, {
  	      "level": 3,"scale": 250000.0,"resolution": 66.1459656252646}, {
  	      "level": 4,"scale": 125000.0,"resolution": 33.0729828126323}, {
  	      "level": 5,"scale": 62500.0,"resolution": 16.53649140631615}, {
  	      "level": 6,"scale": 31250.0,"resolution": 8.268245703158074}, {
  	      "level": 7,"scale": 15625.0,"resolution": 4.134122851579037}, {
  	      "level": 8,"scale": 7812.5,"resolution": 2.0670614257895186}, {
  	      "level": 9,"scale": 3906.25,"resolution": 1.0335307128947593}, {
  	      "level": 10,"scale": 1953.125,"resolution": 0.5167653564473796}, {
  	      "level": 11,"scale": 976.5625,"resolution": 0.2583826782236898}]});;
	this.loaded = true;
	this.onLoad(this);
},
getTileUrl: function(level, row, col) {
	return "http://10.11.2.11/arcgiscache/indexCG2010G/Layers/_alllayers/L" + level + "/R" + row.toString(16) + "/C" + col.toString(16) + ".png";
}
});

/////////////////////

dojo.declare("my.NT2010", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
	this.spatialReference = new esri.SpatialReference({wkid:2363});
	this.initialExtent = zdextend;
	this.fullExtent = zdextend;
	this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 2363},
	    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
  	      "level": 0,"scale": 2000000.0,"resolution":529.1677250021168}, {
  	      "level": 1,"scale": 1000000.0,"resolution": 264.5838625010584}, {
  	      "level": 2,"scale": 500000.0,"resolution": 132.2919312505292}, {
  	      "level": 3,"scale": 250000.0,"resolution": 66.1459656252646}, {
  	      "level": 4,"scale": 125000.0,"resolution": 33.0729828126323}, {
  	      "level": 5,"scale": 62500.0,"resolution": 16.53649140631615}, {
  	      "level": 6,"scale": 31250.0,"resolution": 8.268245703158074}, {
  	      "level": 7,"scale": 15625.0,"resolution": 4.134122851579037}, {
  	      "level": 8,"scale": 7812.5,"resolution": 2.0670614257895186}, {
  	      "level": 9,"scale": 3906.25,"resolution": 1.0335307128947593}, {
  	      "level": 10,"scale": 1953.125,"resolution": 0.5167653564473796}, {
  	      "level": 11,"scale": 976.5625,"resolution": 0.2583826782236898}]});;
	this.loaded = true;
	this.onLoad(this);
},
getTileUrl: function(level, row, col) {
	return "http://10.11.2.11/arcgiscache/indexnt2010/Layers/_alllayers/L" + level + "/R" + row.toString(16) + "/C" + col.toString(16) + ".png";
}
});

////////////////////

dojo.declare("my.DC2010", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
	this.spatialReference = new esri.SpatialReference({wkid:2363});
	this.initialExtent = zdextend;
	this.fullExtent = zdextend;
	this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 2363},
	    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
  	      "level": 0,"scale": 2000000.0,"resolution":529.1677250021168}, {
  	      "level": 1,"scale": 1000000.0,"resolution": 264.5838625010584}, {
  	      "level": 2,"scale": 500000.0,"resolution": 132.2919312505292}, {
  	      "level": 3,"scale": 250000.0,"resolution": 66.1459656252646}, {
  	      "level": 4,"scale": 125000.0,"resolution": 33.0729828126323}, {
  	      "level": 5,"scale": 62500.0,"resolution": 16.53649140631615}, {
  	      "level": 6,"scale": 31250.0,"resolution": 8.268245703158074}, {
  	      "level": 7,"scale": 15625.0,"resolution": 4.134122851579037}, {
  	      "level": 8,"scale": 7812.5,"resolution": 2.0670614257895186}, {
  	      "level": 9,"scale": 3906.25,"resolution": 1.0335307128947593}, {
  	      "level": 10,"scale": 1953.125,"resolution": 0.5167653564473796}, {
  	      "level": 11,"scale": 976.5625,"resolution": 0.2583826782236898}]});;
	this.loaded = true;
	this.onLoad(this);
},
getTileUrl: function(level, row, col) {
	return "http://10.11.2.11/arcgiscache/indexdc2010/Layers/_alllayers/L" + level + "/R" + row.toString(16) + "/C" + col.toString(16) + ".png";
}
});

//////////////////

dojo.declare("my.RAS2009G", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
	this.spatialReference = new esri.SpatialReference({wkid:2363});
	this.initialExtent = zdextend;
	this.fullExtent = zdextend;
	this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 2363},
	    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
  	      "level": 0,"scale": 2000000.0,"resolution":529.1677250021168}, {
  	      "level": 1,"scale": 1000000.0,"resolution": 264.5838625010584}, {
  	      "level": 2,"scale": 500000.0,"resolution": 132.2919312505292}, {
  	      "level": 3,"scale": 250000.0,"resolution": 66.1459656252646}, {
  	      "level": 4,"scale": 125000.0,"resolution": 33.0729828126323}, {
  	      "level": 5,"scale": 62500.0,"resolution": 16.53649140631615}, {
  	      "level": 6,"scale": 31250.0,"resolution": 8.268245703158074}, {
  	      "level": 7,"scale": 15625.0,"resolution": 4.134122851579037}, {
  	      "level": 8,"scale": 7812.5,"resolution": 2.0670614257895186}, {
  	      "level": 9,"scale": 3906.25,"resolution": 1.0335307128947593}, {
  	      "level": 10,"scale": 1953.125,"resolution": 0.5167653564473796}, {
  	      "level": 11,"scale": 976.5625,"resolution": 0.2583826782236898}]});;
	this.loaded = true;
	this.onLoad(this);
},
getTileUrl: function(level, row, col) {
	return "http://10.11.2.11/arcgiscache/indexras2009G/Layers/_alllayers/L" + level + "/R" + row.toString(16) + "/C" + col.toString(16) + ".png";
}
});

/////////////////

dojo.declare("my.RAS2010G", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
	this.spatialReference = new esri.SpatialReference({wkid:2363});
	this.initialExtent = zdextend;
	this.fullExtent = zdextend;
	this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 2363},
	    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
  	      "level": 0,"scale": 2000000.0,"resolution":529.1677250021168}, {
  	      "level": 1,"scale": 1000000.0,"resolution": 264.5838625010584}, {
  	      "level": 2,"scale": 500000.0,"resolution": 132.2919312505292}, {
  	      "level": 3,"scale": 250000.0,"resolution": 66.1459656252646}, {
  	      "level": 4,"scale": 125000.0,"resolution": 33.0729828126323}, {
  	      "level": 5,"scale": 62500.0,"resolution": 16.53649140631615}, {
  	      "level": 6,"scale": 31250.0,"resolution": 8.268245703158074}, {
  	      "level": 7,"scale": 15625.0,"resolution": 4.134122851579037}, {
  	      "level": 8,"scale": 7812.5,"resolution": 2.0670614257895186}, {
  	      "level": 9,"scale": 3906.25,"resolution": 1.0335307128947593}, {
  	      "level": 10,"scale": 1953.125,"resolution": 0.5167653564473796}, {
  	      "level": 11,"scale": 976.5625,"resolution": 0.2583826782236898}]});;
	this.loaded = true;
	this.onLoad(this);
},
getTileUrl: function(level, row, col) {
	return "http://10.11.2.11/arcgiscache/indexras2010G/Layers/_alllayers/L" + level + "/R" + row.toString(16) + "/C" + col.toString(16) + ".png";
}
});

////////////////////

dojo.declare("my.RAS2011G", esri.layers.TiledMapServiceLayer, {
	constructor: function(dpi, xx, yy) {
	this.spatialReference = new esri.SpatialReference({wkid:2363});
	this.initialExtent = zdextend;
	this.fullExtent = zdextend;
	this.tileInfo = new esri.layers.TileInfo({"dpi": dpi,"format": "image/png","compressionQuality": 0,"spatialReference": {"wkid": 2363},
	    "rows": 256,"cols": 256,	"origin": { "x": xx,"y": yy},"lods": [{
  	      "level": 0,"scale": 2000000.0,"resolution":529.1677250021168}, {
  	      "level": 1,"scale": 1000000.0,"resolution": 264.5838625010584}, {
  	      "level": 2,"scale": 500000.0,"resolution": 132.2919312505292}, {
  	      "level": 3,"scale": 250000.0,"resolution": 66.1459656252646}, {
  	      "level": 4,"scale": 125000.0,"resolution": 33.0729828126323}, {
  	      "level": 5,"scale": 62500.0,"resolution": 16.53649140631615}, {
  	      "level": 6,"scale": 31250.0,"resolution": 8.268245703158074}, {
  	      "level": 7,"scale": 15625.0,"resolution": 4.134122851579037}, {
  	      "level": 8,"scale": 7812.5,"resolution": 2.0670614257895186}, {
  	      "level": 9,"scale": 3906.25,"resolution": 1.0335307128947593}, {
  	      "level": 10,"scale": 1953.125,"resolution": 0.5167653564473796}, {
  	      "level": 11,"scale": 976.5625,"resolution": 0.2583826782236898}]});;
	this.loaded = true;
	this.onLoad(this);
},
getTileUrl: function(level, row, col) {
	return "http://10.11.2.11/arcgiscache/indexras2011G/Layers/_alllayers/L" + level + "/R" + row.toString(16) + "/C" + col.toString(16) + ".png";
}
});