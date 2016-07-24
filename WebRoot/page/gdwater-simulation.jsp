<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">

<meta name="pragma" content="no-cache">
<meta name="cache-control" content="no-cache,must-revalidate">
<meta name="expires" content="0">

<link type="text/css" rel="stylesheet"
	href="http://localhost/arcgis_js_v39_sdk/arcgis_js_api/library/3.9/3.9compact/js/dojo/dijit/themes/tundra/tundra.css" />
<link type="text/css" rel="stylesheet"
	href="http://localhost/arcgis_js_v39_sdk/arcgis_js_api/library/3.9/3.9compact/js/dojo/dijit/themes/claro/claro.css" />
<link type="text/css" rel="stylesheet"
	href="http://localhost/arcgis_js_v39_sdk/arcgis_js_api/library/3.9/3.9compact/js/esri/css/esri.css" />
<link type="text/css" rel="stylesheet" href="css/morris.css" />

<style type="text/css">
.tree {
	height: 100%;
	min-height: 20px;
	padding: 19px;
	margin-bottom: 20px;
	/*background-color: #fbfbfb;*/
	background-color: #C3DCCC;
	border: 1px solid #999;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
	-moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
	overflow-y: scroll;
	overflow-x: auto;
	font-size: 10px;
	border: 1px solid #999;
}

.tree li {
	list-style-type: none;
	margin: 0;
	padding: 10px 5px 0 5px;
	position: relative
}

.tree li::before, .tree li::after {
	content: '';
	left: -20px;
	position: absolute;
	right: auto
}

.tree li::before {
	border-left: 1px solid #999;
	bottom: 50px;
	height: 100%;
	top: 0;
	width: 1px
}

.tree li::after {
	border-top: 1px solid #999;
	height: 20px;
	top: 25px;
	width: 25px
}

.tree li span {
	width: 120px;
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	border: 1px solid #999;
	border-radius: 5px;
	display: inline-block;
	padding: 0px 8px;
	text-decoration: none
}

.tree li.parent_li>span {
	cursor: pointer
}

.tree>ul>li::before, .tree>ul>li::after {
	border: 0
}

.tree li:last-child::before {
	height: 30px
}

.tree li.parent_li>span:hover, .tree li.parent_li>span:hover+ul li span
	{
	background: #eee;
	border: 1px solid #94a0b4;
	color: #000
}

#mapContent {
	height: 802px;
}

.toolbar {
	width: 100%;
	height: 50px;
	background: #E4E7EA;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 15px;
}

.toolbar>.panel {
	background: #A8A8A8;
	opacity: 0.85;
}

.mapToolBar {
	width: 300px;
	height: 35px;
	left: 300px;
	top: 100px;
	position: absolute;
	z-index: 999;
	cursor: move;
	background: #999;
	border-radius: 5px;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	opacity: 0.85;
}

#footer {
	border-radius: 4px;
	border: solid 2px #ccc;
	background-color: #fff;
	display: block;
	padding: 5px;
	position: relative;
	text-align: center;
	z-index: 99;
}
</style>

</head>

<body>
	<div class="contentpanel" id="contentpanel_func_4"
		style="width:100%;margin-left:0px;">
		<div id="preloader_simulation" class="preloader_contentpanel"
			style="width:100%">
			<div id="status">
				<i class="fa fa-spinner fa-spin"></i>
			</div>
		</div>

		<section>
			<div class="row" style="margin-top:5px;">
				<div class="toolbar" id="toolbar">
					<div class="panel" style="width:100%;height:100%;">
						<button
							style="width:50px;height:100%;border-radius:5px;
						 -webkit-border-radius:5px; -moz-border-radius:5px;
						 text-align:center;font-weight:bold;"
							class="btn-info" id="addPollutionSrc">加载点源</button>

						<button
							style="width:50px;height:100%;border-radius:5px;
						 -webkit-border-radius:5px; -moz-border-radius:5px;
						 text-align:center;font-weight:bold;"
							class="btn-info" id="deletePollutionSrc">删除点源</button>

						<button
							style="width:50px;height:100%;border-radius:5px;
						 -webkit-border-radius:5px; -moz-border-radius:5px;
						 text-align:center;font-weight:bold;"
							class="btn-info" id="setParams">参数设置</button>

						<button
							style="width:80px;height:100%;border-radius:5px;
						 -webkit-border-radius:5px; -moz-border-radius:5px;
						 text-align:center;font-weight:bold;"
							class="btn-info" id="loadSurfaceCASpace">加载地表元胞空间</button>
							
						<button
							style="width:70px;height:100%;border-radius:5px;
						 -webkit-border-radius:5px; -moz-border-radius:5px;
						 text-align:center;font-weight:bold;"
							class="btn-info" id="surfaceSimuDisplay">地表扩散演示</button>
						
						<button
							style="width:70px;height:100%;border-radius:5px;
						 -webkit-border-radius:5px; -moz-border-radius:5px;
						 text-align:center;font-weight:bold;"
							class="btn-info" id="load3DScene">加载三维场景</button>
							
						<button
							style="width:80px;height:100%;border-radius:5px;
						 -webkit-border-radius:5px; -moz-border-radius:5px;
						 text-align:center;font-weight:bold;"
							class="btn-info" id="loadGDWCASpace">加载地下元胞空间</button>
							
						<button
							style="width:70px;height:100%;border-radius:5px;
						 -webkit-border-radius:5px; -moz-border-radius:5px;
						 text-align:center;font-weight:bold;"
							class="btn-info" id="gdwaterSimuDisplay">地下扩散演示</button>
					</div>
				</div>
			</div>
			<div class="row" id="mapContent">
				<div class="mapToolBar" id="mapToolBar">
					<div class="row" style="width:100%; height:100%; margin-left:0px;">
						<button
							style="width:35px; height:35px; border-radius:5px;
						 -webkit-border-radius:5px; -moz-border-radius:5px;"
							class="btn-info tooltips" id="toolbar-mapZoomIn"
							data-toggle="tooltip" data-placement="bottom" title="放大">
							<i class="glyphicon glyphicon-zoom-in"></i>
						</button>
						<button
							style="width:35px; height:35px; border-radius:5px;
						 -webkit-border-radius:5px; -moz-border-radius:5px;"
							class="btn-info tooltips" id="toolbar-mapZoomOut"
							data-toggle="tooltip" data-placement="bottom" title="缩小">
							<i class="glyphicon glyphicon-zoom-out"></i>
						</button>
						<button
							style="width:35px; height:35px; border-radius:5px;
						 -webkit-border-radius:5px; -moz-border-radius:5px;"
							class="btn-info tooltips" id="toolbar-mapGlobe"
							data-toggle="tooltip" data-placement="bottom" title="复位">
							<i class="glyphicon glyphicon-globe"></i>
						</button>
						<button
							style="width:35px; height:35px; border-radius:5px;
						 -webkit-border-radius:5px; -moz-border-radius:5px;"
							class="btn-info tooltips" id="toolbar-mapPan"
							data-toggle="tooltip" data-placement="bottom" title="漫游">
							<i class="glyphicon glyphicon-move"></i>
						</button>
						<button
							style="width:35px; height:35px; border-radius:5px;
						 -webkit-border-radius:5px; -moz-border-radius:5px;"
							class="btn-info tooltips" id="toolbar-mapPrevExtent"
							data-toggle="tooltip" data-placement="bottom" title="上级窗口">
							<i class="glyphicon glyphicon-hand-left"></i>
						</button>
						<button
							style="width:35px; height:35px; border-radius:5px;
						 -webkit-border-radius:5px; -moz-border-radius:5px;"
							class="btn-info tooltips" id="toolbar-mapNextExtent"
							data-toggle="tooltip" data-placement="bottom" title="下级窗口">
							<i class="glyphicon glyphicon-hand-right"></i>
						</button>
					</div>
				</div>
				<div class="col-sm-9">
					<div class="panel">
						<div class="tundra">
							<div id="mainSimuMap" class="MapClass"
								style="height:770px; border:1px solid #999;">
								<div id="mapswitch"
									style="width:52px; position: absolute; z-index:999;
									border:0px; float:right; right:70px; top:100px;">
									<a
										style="width:100%; height:52px; border-radius:4px; 
										background-image:url('images/topo.gif'); 
										background-position: 0 -10px; text-align:center;
										background-color:#E4E7EA;"
										class="btn btn-default-alt"> <span
										style="position:absolute; font-weight:600;
											line-height:60px; font-size:6px; margin-left:-18px;">
											地形图 </span>
									</a> <a
										style="width:100%; height:52px; border-radius:4px; 
										background-image:url('images/terrain.gif'); 
										background-position: 0 -10px; text-align:center;
										background-color:#E4E7EA;"
										class="btn btn-default-alt"> <span
										style="position:absolute; font-weight:600;
											line-height:60px; font-size:6px; margin-left:-9px;">
											Dem </span>
									</a> <a
										style="width:100%; height:52px; border-radius:4px; 
										background-image:url('images/rs.gif'); 
										background-position: 0 -3px; text-align:center;
										background-color:#E4E7EA;"
										class="btn btn-default-alt"> <span
										style="position:absolute; font-weight:600;
											line-height:60px; font-size:6px; margin-left:-13px;">
											卫星 </span>
									</a>
								</div>
							</div>
							<div
								style="height:30px; border:1px solid #999;	background:#BCBCBC">
								<input id="mapCoordinate" type="text"
									style="width:100%; height:100%; font-color:#000;" />
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-3">
					<div class="panel" style="height:800px;">
						<ul id="toc" class="tree well"></ul>
					</div>
				</div>
			</div>
		</section>
	</div>

	<!-- Modal 模态框 -->
	<!-- Progressbar -->
	<div id="progressBarModal" class="modal bs-modal-panel" tabindex="-1"
		role="dialog" aria-labelledby="progressbar" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="panel panel-dark panel-alt widget-add-index">
					<div class="panel-body"
						style="height:30px; width:600px; padding: 0 0 0 0;">
						<div class="progress progress-striped active" id="progressBar"
							style="width:100%; height:30px; line-height:30px; padding-left:auto;
						padding-right:auto; position:relative;">
							<div class="progress-bar progress-bar-primary" role="progressbar"
								aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"
								style="width:0%; font-size:18px; line-height:30px;"></div>
							<span
								style="position:absolute; color:#E02327; left:230px; font-weight:bold;">
								地图已加载0%, 请稍候... </span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 仿真参数设置 -->
	<div id="setSimuParams" class="modal bs-modal-panel" tabindex="-1"
		role="dialog" aria-labelledby="simuParams" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="panel panel-dark panel-alt widget-add-index">
					<div class="panel-heading">
						<div class="panel-btns">
							<a href="" class="panel-close" data-source="setSimuParams">&times;</a>
							<a href="" class="minimize">&minus;</a>
						</div>
						<!-- panel-btns -->
						<h5 class="panel-title">仿真参数设置</h5>
					</div>
					<div class="panel-body">
						<div class="col-md-8">
							<div class="table-responsive">
								<table class="table mb30">
									<tbody>
										<tr style="height:30px;">
											<td style="height:100%;"><span
												style="height:100%; line-height:30px; font-family:黑体; color:#FF4040; font-weight:bold">污染物总质量</span>
											</td>
											<td style="height:100%;"><input type="text"
												class="form-control" style="width:200px; height:30px;"
												placeholder="" /></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="col-md-4"></div>
						<button class="btn btn-primary"
							style="float:right; margin-right:40px; margin-bottom:20px;">保存</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript" charset="utf-8">
		jQuery.getScript("scripts/js/gdwater-simulation.js");
	</script>

	<script type="text/javascript" charset="utf-8">
		var /*常数π*/pi = parseFloat("3.14159");
		var /*Map*/mainSimuMap, /*Map Options*/options, navToolBar, visible = [];
		var /*ProgressTimer*/progressTimer, /*Progressbar Timestamp*/oriTime = "";
		var /*Time Slider*/timeSlider;
		
		var /*污染点源坐标Pollution Source Point*/pluSrcPoint;		
		var /*已扩散时间Spread Timestamp*/spreadTime = 0;	
		var /*时间步长Time Step(s)*/deltaT = 5;	
		var /*当前所有被污染的元胞*/curAllPluSrcPoint = new Array();
		var /*元胞空间大小*/spaceCA = 21; 				
		
		//地表污染物扩散	
		var /*污染物质量初始值Cell Mass(g)*/cellMass = parseFloat("100.0");
		var /*地表元胞大小Cell Step(m)*/cellStep = parseFloat("35.389");			
		var /*经验静态扩散系数*/mValue = parseFloat("0.084");									
		var /*经验斜向扩散系数*/dValue = parseFloat("0.16");
		var /*地表变化后的元胞*/changedCell = new Array();		
			
		//地下污染物扩散
		var /*地下元胞大小Cell Step(m)*/gdwCellStep = parseFloat("35.389");
		var /*分子扩散系数*/liqMolDiffCoef = parseFloat("1.10592") * Math.pow(10, -4) * deltaT / (gdwCellStep * gdwCellStep);
		var /*源汇项*/srcSinkTerm = parseFloat("0.0");
		var /*扩散作用量*/effect = new Array();
		var /*分子扩散变化后的元胞*/changedCell1 = new Array();
		var /*机械弥散后的元胞*/changedCell2 = new Array();
		
		var interval;
		//扩散区域
		var rasterSpreadArea = new Array(spaceCA);

		require([ "dojo/_base/connect", "dojo/parser", "esri/map",
			"esri/geometry/Point", "esri/geometry/Polygon",
			"esri/symbols/SimpleMarkerSymbol",
			"esri/symbols/SimpleLineSymbol",
			"esri/symbols/SimpleFillSymbol",

			"esri/graphic", "dojo/_base/array", "dojo/dom-style",
			"esri/SpatialReference", "esri/Color",
			"esri/InfoTemplate", "esri/config",

			"esri/layers/ArcGISDynamicMapServiceLayer",
			"esri/layers/ArcGISImageServiceLayer",
			"esri/layers/ImageServiceParameters",
			"esri/layers/ImageParameters",

			"esri/toolbars/navigation", "dojo/on",
			"esri/dijit/Scalebar", "dijit/registry",

			"esri/tasks/GeometryService",
			"esri/tasks/BufferParameters",

			"esri/tasks/ImageServiceIdentifyTask",
			"esri/tasks/ImageServiceIdentifyParameters",
			"esri/tasks/ImageServiceIdentifyResult",
			
			"esri/dijit/TimeSlider", "dojo/dom", "dojo/DeferredList" ],
			function(connect, parser, Map, Point, Polygon,
				SimpleMarkerSymbol, SimpleLineSymbol, SimpleFillSymbol,
				Graphic, arrayUtils, domStyle, SpatialReference, Color,
				InfoTemplate, esriConfig, ArcGISDynamicMapServiceLayer,
				ArcGISImageServiceLayer, ImageServiceParameters,
				ImageParameters, Navigation, on, Scalebar, registry,
				GeometryService, BufferParameters,
				ImageServiceIdentifyTask, ImageServiceIdentifyParameters,
				ImageServiceIdentifyResult, TimeSlider, dom, DeferredList) {
				//Parse
				parser.parse();

				//CORS
				esri.config.defaults.io.corsDetection = false;

				//Proxy
				var gProxyUrl = "http://localhost/arcgis_js_v39_sdk/arcgis_js_api/proxy/proxy.ashx";
				esri.config.defaults.io.proxyUrl = gProxyUrl;
				esri.config.defaults.io.alwaysUseProxy = false;

				// Close Button in Panels
				jQuery('.panel .panel-close').click(function() {
					jQuery(this).closest('.panel').fadeOut(200);
					jQuery("#" + jQuery(this).data("source")).modal("hide");
					return false;
				});

				//Minimize Button in Panels
				jQuery('.minimize').click(function() {
					var t = jQuery(this);
					var p = t.closest('.panel');
					if (!jQuery(this).hasClass('maximize')) {p.find(
						'.panel-body, .panel-footer').slideUp(200);
						t.addClass('maximize');
						t.html('&plus;');

						var mainpanelwidth = jQuery('.mainpanel').width();
						var tabwidth = parseInt(mainpanelwidth - 20);

						jQuery('#tt').css('width', tabwidth);
					} else {p.find('.panel-body, .panel-footer').slideDown(200);
						t.removeClass('maximize');
						t.html('&minus;');

						var mainpanelwidth = jQuery('.mainpanel').width();
						var tabwidth = parseInt(mainpanelwidth - 260);

						jQuery('#tt').css('width', tabwidth);
					}
					return false;
				});

				//基本地图及地图切换

				//Map Options
				options = {
					logo : false,
					slider : false,
					zoom : 16
				};

				//Map
				mainSimuMap = new Map("mainSimuMap", options);

				//Image Parameters
				var imageParameters = new ImageParameters();
				imageParameters.format = "jpeg";

				//Dynamic Layer
				var mapDynamicLayer = new ArcGISDynamicMapServiceLayer(
					"http://localhost:6080/arcgis/rest/services/bjMap/MapServer",
					{
						"opacity" : 0.9,
						"imageParameters" : imageParameters
					});

				//Image Dem Service
				var imageDemServiceParams = new ImageServiceParameters();
				imageDemServiceParams.noData = 0;
				var imageDemServiceLayer = new ArcGISImageServiceLayer(
					"http://localhost:6080/arcgis/rest/services/bjDEM/ImageServer",
					{
						imageServiceParameters : imageDemServiceParams,
						opacity : 0.75
					});

				//Image RS Service
				var imageRSServiceParams = new ImageServiceParameters();
				imageRSServiceParams.noData = 0;
				var imageRSServiceLayer = new ArcGISImageServiceLayer(
					"http://localhost:6080/arcgis/rest/services/bjRS/ImageServer",
					{
						imageServiceParameters : imageRSServiceParams,
						opacity : 0.75
					});
				
				//Image Task && Query
				var imageDemTask = new ImageServiceIdentifyTask(
					"http://localhost:6080/arcgis/rest/services/bjDEM/ImageServer");
				var imageSlopeTask = new ImageServiceIdentifyTask(
					"http://localhost:6080/arcgis/rest/services/bjDEMSlope/ImageServer");
				var imageGDWaterLevelTask = new ImageServiceIdentifyTask(
					"http://localhost:6080/arcgis/rest/services/saGDWaterLevel/ImageServer");
				var imageHyConductivityTask = new ImageServiceIdentifyTask(
					"http://localhost:6080/arcgis/rest/services/saHYConductivity/ImageServer");
				var imageSoilPorosityTask = new ImageServiceIdentifyTask(
					"http://localhost:6080/arcgis/rest/services/saSoilPorosity/ImageServer");
				var query = new ImageServiceIdentifyParameters();								

				//Add Layer Method
				mainSimuMap.addLayer(mapDynamicLayer);

				jQuery("#mapswitch").find("a").on("click", function() {
					var index = jQuery(this).index() + 1;
					if (index === 1) {
						mainSimuMap.removeAllLayers();
						mainSimuMap.addLayer(mapDynamicLayer);
					} else if (index === 2) {
						mainSimuMap.removeAllLayers();
						mainSimuMap.addLayer(imageDemServiceLayer);
					} else if (index === 3) {
						oriTime = new Date().getTime();
						new Progressbar("#progressBar");
						progressTimer = setInterval(progressTimeStamp, 2 * 1000);
						jQuery("#progressBarModal").modal("show");
						mainSimuMap.removeAllLayers();
						mainSimuMap.addLayer(imageRSServiceLayer);
					} else {
						return;
					}
				});

				//Progressbar
				var Progressbar = function(element) {
					this.$element = $(element);
				}

				Progressbar.prototype.update = function(value) {
					var $div = this.$element.find("div");
					var $span = this.$element.find("span");
					$div.attr("aria-valuenow", value);
					$div.css("width", value + "%");
					$span.text("地图已加载" + value + "%, 请稍候...");
				}

				Progressbar.prototype.finish = function() {
					this.update(100);
					jQuery("#progressBarModal").modal("hide");
				}

				Progressbar.prototype.reset = function() {
					this.update(0);
				}

				//Progressbar Timestamp
				var progressTimeStamp = function() {
					var timestamp = (new Date().getTime() - oriTime) * 4 / 1000;
					if (timestamp >= 100) {
						new Progressbar("#progressBar").finish();
						clearInterval(progressTimer);
						return;
					}
					new Progressbar("#progressBar").update(timestamp);
				}

				//Scale 显示比例尺
				var scalebar = new Scalebar({
					map : mainSimuMap,
					attachTo : "bottom-right",
					scalebarUnit : "dual"
				});

				jQuery(".esriScalebar").css({
					"bottom" : "80px",
					"right" : "200px"
				});

				//MapToolbar Draggment 地图工具条拖动
				jQuery("#mapToolBar").draggable({
					containment : '#mapContent',
					snap : '#mapContent',
					snapMode : 'outer'
				});

				//MapToolbar Function Archievement 地图工具条功能实现			
				var navToolBar = new Navigation(mainSimuMap);
				navToolBar.on("extent-history-change",
					extentHistoryChangeHandler);

				//Zoom In
				jQuery("#toolbar-mapZoomIn").click(function() {
					navToolBar.activate(Navigation.ZOOM_IN);
					//on(mainSimuMap, "onUnload");
				});

				//Zoom Out
				jQuery("#toolbar-mapZoomOut").click(function() {
					navToolBar.activate(Navigation.ZOOM_OUT);
				});

				//Global
				jQuery("#toolbar-mapGlobe").click(function() {
					navToolBar.zoomToFullExtent();
				});

				//Pan
				jQuery("#toolbar-mapPan").click(function() {
					navToolBar.activate(Navigation.PAN);
				});

				//Prev Extent
				jQuery("#toolbar-mapPrevExtent").click(function() {
					navToolBar.zoomToPrevExtent();
				});

				//Next Extent
				jQuery("#toolbar-mapNextExtent").click(function() {
					navToolBar.zoomToNextExtent();
				});

				function extentHistoryChangeHandler() {
					jQuery("#toolbar-mapPrevExtent").attr("disabled",
							navToolBar.isFirstExtent());
					jQuery("#toolbar-mapNextExtent").attr("disabled",
							navToolBar.isLastExtent());
				}

				//Coordinates 坐标
				connect.connect(mainSimuMap, "onMouseMove", showCoordinates);

				function showCoordinates(evt) {
					var mp = evt.mapPoint;
					if ((mp.x != 0.0 && mp.y != 0.0) && (mp.x != undefined && mp.y != undefined)) {
						jQuery("#mapCoordinate").val("  当前坐标：x=" + mp.x + ", y=" + mp.y);
					} else {
						jQuery("#mapCoordinate").val("  当前坐标：x=0.0, y=0.0");
					}

				}

				//Toc Load
				if (mapDynamicLayer.loaded) {
					buildLayerList(mapDynamicLayer);
				} else {
					connect.connect(mapDynamicLayer, "onLoad", buildLayerList);
				}

				//Toc Build
				function buildLayerList(layer) {
					var layerinfos = layer.layerInfos;
					var root = "<li><span style='height:30px; line-height:30px; "
					+ "font-size:16px; font-weight:bold;'><i class='glyphicon "
					+ "glyphicon-folder-open'></i>&nbsp;&nbsp;图层</span><ul>";
					var parentnodes = [];//保存所有的父亲节点
					var node = {};

					if (layerinfos != null && layerinfos.length > 0) {
						for (var i = 0, j = layerinfos.length; i < j; i++) {
							var info = layerinfos[i];
							if (info.defaultVisibility) {
								visible.push(info.id);
							}

							//node为tree用到的json数据
							node = {
								"id" : info.id,
								"text" : info.name,
								"pid" : info.parentLayerId,
								"checked" : info.defaultVisibility ? true : false,
								"children" : []
							};

							if (info.parentLayerId == -1) {
								parentnodes.push(node);
								root += "<li><span><div class='mr5' style='display:inline'></div>"
									+ "<div class='ckbox ckbox-success' style='display:inline'>"
									+ "<input type='checkbox' id='checkboxlayer-" + node.id 
                   	 				+ "'/><label for='checkboxlayer-" + node.id + "'>"
									+ node.text
									+ "</label></div></span></li>";
							}
						}
					}
					root += "</ul></li>";

					jQuery("#toc").append(root);

					for (var i = 0; i < visible.length; i++) {
						var layervisible_id = visible[i];
						jQuery("#checkboxlayer-" + layervisible_id).attr("checked", true);
					}

					for (var i = 0; i < layerinfos.length; i++) {
						jQuery("#checkboxlayer-" + layerinfos[i].id).on("change", function() {
							var c = jQuery(this);
							var checked = c.attr("checked");
							var layerid = c.attr("id")
									.toString().split("-")[1];

							if (checked === "checked") {
								visible.push(layerid);
								mapDynamicLayer.setVisibleLayers(visible);
							} else {
								visible.splice(visible.indexOf(parseInt(layerid)),1);
								mapDynamicLayer.setVisibleLayers(visible);
							}
						});
					}
				}

				//Toolbar Archievement
				//Add Pollution Source 加载点源
				jQuery("#addPollutionSrc").on("click", function() {
					pluSrcPoint = null;
					jQuery.ajax({
						type : "POST",
						url : "GdWaterServlet",
						async : false,
						context : this,
						data : {
							servicename : "simulation-db-service",
							servicetype : "get-pollution-source"
						},
						success : function(data) {
							if (data.success_get_pollution_source) {
								//Pollution Source Type Info
								var pollutionsrcinfo = data.pollutionsourceinfo;
								//Pollution Source Geo x and Geo y
								var pollutionsrcgeo = data.pollutionsourcegeo;
								//Pollution Source Records Length
								var count = pollutionsrcgeo.length;
								var points = "";
								for (var i = 0; i < count; i++) {
									points += pollutionsrcgeo[i][0].toString() + "," 
										+ pollutionsrcgeo[i][1].toString() + "-";
								}
								points = points.substring(0, points.length - 1);

								var pointsarr1 = points.split("-");
								var pointsarr2 = new Array();

								for (var i = 0; i < pointsarr1.length; i++) {
									pointsarr2[i] = pointsarr1[i].split(",");
									pluSrcPoint = pointsarr2[i];
								}

								var pointid = 0; /*Point id*/
								var iconPath = "M16,4.938c-7.732,0-14,4.701-14,10.5c0,1.981,0.741,3.833,2.016,5.414L2,25.272l5.613-1.44c2.339,1.316,5.237,2.106,8.387,2.106c7.732,0,14-4.701,14-10.5S23.732,4.938,16,4.938zM16.868,21.375h-1.969v-1.889h1.969V21.375zM16.772,18.094h-1.777l-0.176-8.083h2.113L16.772,18.094z"; /*Point Icon*/
								var initColor = "#ce641d"; /*Point Color*/

								arrayUtils.forEach(pointsarr2, function(point) {
									var attr = {
										"id" : (pointid + 1),
										"pollutiontype" : pollutionsrcinfo[pointid],
										"type" : "Pollution Source"
									};
									var flag = "MouseOut";
									var graphic = new Graphic(new Point(point,
										new SpatialReference({wkid : 3857})),
										createSymbol(iconPath,initColor),attr);
									mainSimuMap.graphics.add(graphic);

									pointid++;
								});
								pointid = 0;

								function createSymbol(path,	color, flag) {
									var markerSymbol = new SimpleMarkerSymbol();
									markerSymbol.setPath(path);
									markerSymbol.setColor(new dojo.Color(color));
									markerSymbol.setSize(20);

									if (flag === "MouseOut") {
										markerSymbol.setSize(20);
									} else if (flag === "MouseOver") {
										markerSymbol.setSize(23);
									}

									markerSymbol.setOutline(null);
									return markerSymbol;
								}

								connect.connect(mainSimuMap.graphics, "onMouseOver", PollutionSrcMouseOver);
								connect.connect(mainSimuMap.graphics, "onMouseOut", PollutionSrcMouseOut);

								function PollutionSrcMouseOver(event) {
									var highlightColor = "#FB2504";
									var flag = "MouseOver";
									var pointid = "";
									if (event.graphic.attributes) {
										var pointid = parseInt(event.graphic.attributes.id);
									}

									if (!pointid) {
										return;
									} else {
										mainSimuMap.graphics.graphics.forEach(function(graphic) {
											if (graphic.attributes) {
												if (graphic.attributes.id === pointid) {
													graphic.setSymbol(createSymbol(iconPath, highlightColor, flag));
													mainSimuMap.infoWindow.setContent("污染类型: "
														+ graphic.attributes.pollutiontype);
													mainSimuMap.infoWindow.show(event.screenPoint, mainSimuMap
														.getInfoWindowAnchor(event.screenPoint));
												}
											}
										});
									}
								}

								function PollutionSrcMouseOut(event) {
									var pointid = "";
									if (event.graphic.attributes) {
										var pointid = parseInt(event.graphic.attributes.id);
									}

									if (!pointid) {
										return;
									} else {
										var flag = "MouseOut";
										mainSimuMap.graphics.graphics.forEach(function(graphic) {
											if (graphic.attributes) {
												if (graphic.attributes.id === pointid) {
													graphic.setSymbol(createSymbol(iconPath, initColor, flag));
													mainSimuMap.infoWindow.hide();
												}
											}
										});
									}
								}
							}
						},
						error : function(e) {

						},
						dataType : "json"
					});
				});

				//Delete Pollution Source 删除点源
				jQuery("#deletePollutionSrc").on("click", function() {					
					mainSimuMap.graphics.clear();
				});

				//Set Parameters 参数设置
				jQuery("#setParams").on("click", function() {
					jQuery("#setSimuParams").modal("show");
				});
				
				//Load Surface CA Space 加载地表元胞空间
				jQuery("#loadSurfaceCASpace").on("click", function() {
					//初始化元胞空间
					if (pluSrcPoint != undefined && pluSrcPoint != null) {
						for (var i = 0; i < spaceCA; i++) {
							rasterSpreadArea[i] = new Array(spaceCA);
							for (var j = 0; j < spaceCA; j++) {
								rasterSpreadArea[i][j] = {};
							}
						}
						/*drawTimeSlider();

						timeSlider.on("time-extent-change",	function(evt) {
							var endValString = evt.endTime
									.getHours();
						});*/											
						//清空Graphics
						mainSimuMap.graphics.clear();
						//请求Rest服务返回当前栅格元胞的高程和坡度
						tempAr = new Array();
						//记录当前栅格元胞的像素值
						var rasterPixel = new Array();
						//rasterSpreadArea初始化
						for (var j = 0; j < spaceCA; j++) {
							 for (var i = 0; i < spaceCA; i++) {						
								rasterSpreadArea[j][i] = {
									"pixelx" : parseInt(spaceCA/2)*(-1) + i,  //当前元胞像素列（x坐标）位置
									"pixely" : parseInt(spaceCA/2)*(-1) + j,  //当前元胞像素行（y坐标）位置
									"cellMass" : parseFloat("0.0"),  //当前元胞污染物质量
									"geometry" : [parseFloat(pluSrcPoint[0]) + parseFloat((i + parseInt(spaceCA/2)*(-1))) * cellStep,
										parseFloat(pluSrcPoint[1]) + parseFloat((j + parseInt(spaceCA/2)*(-1))) * cellStep],  //当前元胞栅格
									"elevation" : parseFloat("0.0"),  //当前元胞高程值
									"slope" : parseFloat("0.0"),
									"hyconductivity" : parseFloat("0.0"),  //当前元胞地表层渗透系数
									"roughness" : parseFloat("0.0"),  //当前元胞地表粗糙度值
									"boundary" : null,  //当前元胞边界条件
									"heightdiff" : null,  //当前元胞为中央元胞时与邻域元胞的高程差
									"heightdiffrate" : null,  //当前元胞为中央元胞时与邻域元胞的高程差比率
									"roughnessinverserate" : null,  //当前元胞为中央元胞时与邻域元胞的地表粗糙度反比
									"type" : "Pollution Source Spread"	 //类型，污染源扩散														
								}
								query.geometry = new Point(
									rasterSpreadArea[j][i].geometry,
									new SpatialReference({
										wkid : 3857
								}));
								tempAr.push(imageDemTask.execute(query));  //向地图服务器发出污染源高程查询请求
								tempAr.push(imageSlopeTask.execute(query));  //向地图服务器发出污染源坡度查询请求
								tempAr.push(imageHyConductivityTask.execute(query));  //向地图服务器发出渗透系数查询
								rasterPixel.push([i,j]);
							}
						}
						
						curAllPluSrcPoint.push([0, 0]);
						rasterSpreadArea[parseInt(spaceCA/2)][parseInt(spaceCA/2)].cellMass = parseFloat(cellMass);
															
						deferList = new DeferredList(tempAr);																																			
						deferList.then(function (results) {							
							for (var i = 0; i < results.length; i++) {	
								if (i % 3 === 0) {
									rasterSpreadArea[rasterPixel[i/3][1]][rasterPixel[i/3][0]].elevation = parseFloat(results[i][1].value);
								} else if (i % 3 === 1) {
									rasterSpreadArea[rasterPixel[parseInt(i/3)][1]][rasterPixel[parseInt(i/3)][0]].slope = results[i][1].value;
									rasterSpreadArea[rasterPixel[parseInt(i/3)][1]][rasterPixel[parseInt(i/3)][0]].roughness = 1/Math.cos(parseFloat(results[i][1].value*pi/180));
								} else {
									rasterSpreadArea[rasterPixel[parseInt(i/3)][1]][rasterPixel[parseInt(i/3)][0]].hyconductivity = parseFloat(results[i][1].value);
								}								
							}
							
							for (var j = 0; j < spaceCA; j++) {
								for (var i = 0; i < spaceCA; i++) {
									var moorpixel = new Array();
									var boundary = null;
									//不包含左、右、上、下边界
									if ((i >= 1) && (i <= spaceCA - 2) && (j >= 1) && (j <= spaceCA - 2)) {
										boundary = "noboundary";
										for (var q = j - 1; q <= j + 1; q++) {
											 for (var p = i - 1; p <= i + 1; p++) {
												moorpixel.push([p, q]);
											}
										}	
									}
									//只包含左边界
									else if ((i == 0) && (j >= 1) && (j <= spaceCA - 2)) {
										boundary = "leftboundary";
										for (var q = j - 1; q <= j + 1; q++) {
											 for (var p = 0; p <= 1; p++) {
												moorpixel.push([p, q]);
											}
										}
									}
									//只包含右边界
									else if ((i == spaceCA - 1) && (j >= 1) && (j <= spaceCA - 2)) {
										boundary = "rightboundary";
										for (var q = j - 1; q <= j + 1; q++) {
											 for (var p = spaceCA - 2; p <= spaceCA - 1; p++) {
												moorpixel.push([p, q]);
											}
										}
									}
									//只包含上边界
									else if ((i >= 1) && (i <= spaceCA - 2) && (j == 0)) {
										boundary = "topboundary";
										for (var q = 0; q <= 1; q++) {
											 for (var p = i - 1; p <= i + 1; p++) {
												moorpixel.push([p, q]);
											}
										}
									}
									//只包含下边界
									else if ((i >= 1) && (i <= spaceCA - 2) && (j == spaceCA - 1)) {
										boundary = "bottomboundary";
										for (var q = spaceCA - 2; q <= spaceCA - 1; q++) {
											 for (var p = i - 1; p <= i + 1; p++) {
												moorpixel.push([p, q]);
											}
										}
									}
									//包含左上边界
									else if ((i == 0) && (j == 0)) {
										boundary = "topleftboundary";
										for (var q = 0; q <= 1; q++) {
											for (var p = 0; p <= 1; p++) {
												moorpixel.push([p, q]);	
											}
										}																		
									}
									//包含右上边界
									else if  ((i == spaceCA - 1) && (j == 0)) {
										boundary = "toprightboundary";
										for (var q = 0; q <= 1; q++) {
											for (var p = spaceCA - 2; p <= spaceCA - 1; p++) {
												moorpixel.push([p, q]);	
											}
										}	
									}
									//包含左下边界
									else if ((i == 0) && (j == spaceCA - 1)) {
										boundary = "bottomleftboundary";
										for (var q = spaceCA - 2; q <= spaceCA - 1; q++) {
											for (var p = 0; p <= 1; p++) {
												moorpixel.push([p, q]);	
											}
										}	
									}
									//包含右下边界
								    else if ((i == spaceCA - 1) && (j == spaceCA - 1)) {
								    	boundary = "bottomrightboundary";
										for (var q = spaceCA - 2; q <= spaceCA - 1; q++) {
											for (var p = spaceCA - 2; p <= spaceCA - 1; p++) {
												moorpixel.push([p, q]);	
											}
										}	
								    }
								    
								    var heightdiff = new Array(moorpixel.length);
								    var heightdiffamount = 0.0;
								    var heightdiffrate = new Array(moorpixel.length);
								    var roughness = new Array(moorpixel.length);
								    var roughnessinverse = new Array(moorpixel.length);
								    var roughnessinverseamount = 0.0;
								    var roughnessinverserate = new Array(moorpixel.length);
								    for (var p = 0; p < moorpixel.length; p++) {
								    	heightdiff[p] = parseFloat(rasterSpreadArea[j][i].elevation)
								    		- parseFloat(rasterSpreadArea[moorpixel[p][1]][moorpixel[p][0]].elevation);
								    	roughness[p] = parseFloat(rasterSpreadArea[moorpixel[p][1]][moorpixel[p][0]].roughness);
								    	roughnessinverse[p] = parseFloat(1/roughness[p]);
								    	if (heightdiff[p] > 0) {
								    		heightdiffamount += heightdiff[p];
								    		roughnessinverseamount += roughnessinverse[p];
								    	}
								    }
								    for (var p = 0; p < moorpixel.length; p++) {
								    	if (heightdiff[p] > 0) {
								    		heightdiffrate[p] = parseFloat(heightdiff[p]/heightdiffamount);
								    		roughnessinverserate[p] = parseFloat(roughnessinverse[p]/roughnessinverseamount);
								    	} else {
								    		heightdiffrate[p] = parseFloat("0.0");
								    		roughnessinverserate[p] = parseFloat("0.0");
								    	}
								    }
								    
								    rasterSpreadArea[j][i].boundary = boundary;
								    rasterSpreadArea[j][i].heightdiff = heightdiff;
								    rasterSpreadArea[j][i].heightdiffrate = heightdiffrate;
								    rasterSpreadArea[j][i].roughnessinverserate = roughnessinverserate;
								}
							}
							
							//打印扩散区域高程
							for (var j = 0; j < spaceCA; j++) {
								var a = "";
								for (var i = 0; i < spaceCA; i++) {
									a += rasterSpreadArea[j][i].hyconductivity + " ";
								}
								console.log(a);
							}
							
							jQuery.gritter.add({
								title : "消息",
								text : "加载地表元胞空间完成",
								class_name : "growl-success",
								image : "images/screen.png",
								sticky : false,
								time : 5000
							});																		
					    });								    											
					} else {
						jQuery.gritter.add({
							title : "警告",
							text : "请先设定污染点源及参数",
							class_name : "growl-danger",
							image : "images/screen.png",
							sticky : false,
							time : 5000
						});
					}
				});
				
				//Surface Simulation Display 地表扩散演示
				jQuery("#surfaceSimuDisplay").on("click", function() {
					if (rasterSpreadArea === undefined || rasterSpreadArea === null
						|| rasterSpreadArea[0] === undefined || rasterSpreadArea[parseInt(spaceCA/2)][parseInt(spaceCA/2)] === undefined) {
						jQuery.gritter.add({
							title : "警告",
							text : "请先加载地表元胞空间",
							class_name : "growl-danger",
							image : "images/screen.png",
							sticky : false,
							time : 5000
						});
					} else {						
						drawPolygon();
						interval = setInterval(pluSpread, 1000 * deltaT);	
					}										
				});
				
				//Pollution Spread (per deltaT*1000s)
				var pluSpread = function() {
					spreadTime += 1;
					if (spreadTime === spaceCA) {
						clearInterval(interval);
					}
					console.log("第" + spreadTime + "次计算");				
					//针对目前已污染的元胞进行遍历
					for (var i = 0; i < curAllPluSrcPoint.length; i++) {
						findRasterValue(curAllPluSrcPoint[i]);
					}
					changedCell = arrUnique(changedCell);
					for (var i = 0; i < changedCell.length; i++) {
						rasterSpreadArea[changedCell[i][1]][changedCell[i][0]].cellMass = parseFloat(changedCell[i][2]);
					}	
									
					for (var i = 0; i < changedCell.length; i++) {
						curAllPluSrcPoint.push([changedCell[i][0] - parseInt(spaceCA/2), changedCell[i][1] - parseInt(spaceCA/2)]);
					}
					curAllPluSrcPoint = arrUnique(curAllPluSrcPoint);
					changedCell = new Array();
					//console.log(curAllPluSrcPoint);
					for (var j = 0; j <= spaceCA - 1; j++) {
						var cellmass = new Array(spaceCA);
						for (var i = 0; i <= spaceCA - 1; i++) {
							cellmass[i] = rasterSpreadArea[j][i].cellMass;
						}
						console.log(cellmass);
					}
					drawPolygon();	
					
					if (spreadTime === spaceCA) {
						rasterSpreadArea = new Array(spaceCA);
						spreadTime = 0;
					}				
				}
				
				function findRasterValue(curPluSrcPoint) {					
					//moorpixel
					var moorpixel = new Array();
					//boundary 边界情况
					var boundary = null;									
					
					//处理边界条件
					if ((curPluSrcPoint[0] >= parseInt(spaceCA/2)*(-1) && curPluSrcPoint[0] <= spaceCA - parseInt(spaceCA/2) - 1) && (curPluSrcPoint[1] >= parseInt(spaceCA/2)*(-1) && curPluSrcPoint[1] <= spaceCA - parseInt(spaceCA/2) - 1)) {
						//不包含左、右、上、下边界
						if ((curPluSrcPoint[0] - 1 >= parseInt(spaceCA/2)*(-1)) && (curPluSrcPoint[0] + 1 <= spaceCA - parseInt(spaceCA/2) - 1) &&
							(curPluSrcPoint[1] - 1 >= parseInt(spaceCA/2)*(-1)) && (curPluSrcPoint[1] + 1 <= spaceCA - parseInt(spaceCA/2) - 1)) {
							boundary = "noboundary";
							for (var j = curPluSrcPoint[1] + parseInt(spaceCA/2) - 1; j <= curPluSrcPoint[1] + parseInt(spaceCA/2) + 1; j++)							 {
								 for (var i = curPluSrcPoint[0] + parseInt(spaceCA/2) - 1; i <= curPluSrcPoint[0] + curPluSrcPoint[1] + parseInt(spaceCA/2) + 1; i++) {
									moorpixel.push([i, j]);
								}
							}	
						}
						//只包含左边界
						else if ((curPluSrcPoint[0] === parseInt(spaceCA/2)*(-1)) && (curPluSrcPoint[1] - 1 >= parseInt(spaceCA/2)*(-1)) && (curPluSrcPoint[1] + 1 <= spaceCA - parseInt(spaceCA/2) - 1)) {
							boundary = "leftboundary";
							for (var j = curPluSrcPoint[1] + parseInt(spaceCA/2) - 1; j <= curPluSrcPoint[1] + parseInt(spaceCA/2) + 1; j++) {
								for (var i = 0; i <= 1; i++) {
									moorpixel.push([i, j]);
								}
							}
						}
						//只包含右边界
						else if ((curPluSrcPoint[0] === spaceCA - parseInt(spaceCA/2) - 1) && (curPluSrcPoint[1] - 1 >= parseInt(spaceCA/2)*(-1)) && (curPluSrcPoint[1] + 1 <= spaceCA - parseInt(spaceCA/2) - 1)) {
							boundary = "rightboundary";
							for (var j = curPluSrcPoint[1] + parseInt(spaceCA/2) - 1; j <= curPluSrcPoint[1] + parseInt(spaceCA/2) + 1; j++) {
								 for (var i = spaceCA - 2; i <= spaceCA - 1; i++) {
									moorpixel.push([i, j]);
								}
							}
						}
						//只包含上边界
						else if ((curPluSrcPoint[0] - 1 >= parseInt(spaceCA/2)*(-1)) && (curPluSrcPoint[0] + 1 <= spaceCA - parseInt(spaceCA/2) - 1) &&	(curPluSrcPoint[1] === parseInt(spaceCA/2)*(-1))) {
							boundary = "topboundary";
							for (var j = 0; j <= 1; j++) {
								 for (var i = curPluSrcPoint[0] + parseInt(spaceCA/2) - 1; i <= curPluSrcPoint[0] + parseInt(spaceCA/2) + 1; i++) {
									moorpixel.push([i, j]);
								}
							}
						}
						//只包含下边界
						else if ((curPluSrcPoint[0] - 1 >= parseInt(spaceCA/2)*(-1)) && (curPluSrcPoint[0] + 1 <= spaceCA - parseInt(spaceCA/2) - 1) && (curPluSrcPoint[1] === spaceCA - parseInt(spaceCA/2) - 1)) {
							boundary = "bottomboundary";
							for (var j = spaceCA - 2; j <= spaceCA - 1; j++) {
								for (var i = curPluSrcPoint[0] + parseInt(spaceCA/2) - 1; i <= curPluSrcPoint[0] + parseInt(spaceCA/2) + 1; i++) {
									moorpixel.push([i, j]);								
								}
							}
						}
						//包含左上边界
						else if ((curPluSrcPoint[0] === parseInt(spaceCA/2)*(-1)) && (curPluSrcPoint[1] === parseInt(spaceCA/2)*(-1))) {
							boundary = "topleftboundary";
							for (var j = 0; j <= 1; j++) {
								for (var i = 0; i <= 1; i++) {
									moorpixel.push([i, j]);
								}
							}							
						}
						//包含右上边界
						else if  ((curPluSrcPoint[0] === spaceCA - parseInt(spaceCA/2) - 1) && (curPluSrcPoint[1] === parseInt(spaceCA/2)*(-1))) {
							boundary = "toprightboundary";
							for (var j = 0; j <= 1; j++) {
								for (var i = spaceCA - 2; i <= sapceCA - 1; i++) {
									moorpixel.push([i, j]);
								}
							}
						}
						//包含左下边界
						else if ((curPluSrcPoint[0] === parseInt(spaceCA/2)*(-1)) && (curPluSrcPoint[1] === spaceCA - parseInt(spaceCA/2) - 1)) {
							boundary = "bottomleftboundary";
							for (var j = spaceCA - 2; j <= sapceCA - 1; j++) {
								for (var i = 0; i <= 1; i++) {
									moorpixel.push([i, j]);
								}
							}
						}
						//包含右下边界
					    else if ((curPluSrcPoint[0] === spaceCA - parseInt(spaceCA/2) - 1) && (curPluSrcPoint[1] === spaceCA - parseInt(spaceCA/2) - 1)) {
					    	boundary = "bottomrightboundary";
							for (var j = spaceCA - 2; j <= sapceCA - 1; j++) {
								for (var i = spaceCA - 2; i <= spaceCA - 1; i++) {
									moorpixel.push([i, j]);
								}
							}
					    }
					}
					
					for (var i = 0; i< moorpixel.length; i++) {
						if (rasterSpreadArea[parseInt(spaceCA/2) + curPluSrcPoint[1]][parseInt(spaceCA/2) + curPluSrcPoint[0]].heightdiff[i] > 0 || i === 4) {	
							//邻域高差
							var heightdiff = rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].heightdiff;
							//邻域高差比率
							var heightdiffrate = rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].heightdiffrate;
							//邻域地表粗糙度反比率
							var roughnessinverserate = rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].roughnessinverserate;
							//邻域污染物质量
							var cellmass = new Array(heightdiff.length);
							//用于计算的当前污染物质量
							var curPointCellMass = new Array(heightdiff.length);
							//邻域元胞影响因素
							var moorRate = new Array(heightdiff.length);
							
							for (var j = 0; j < heightdiffrate.length; j++) {
								curPointCellMass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].cellMass);
								var tmp = new Array(2);
								if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "noboundary") {
									cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 3) - 1][moorpixel[i][0] + (j % 3) - 1].cellMass);
									tmp[0] = moorpixel[i][0] + (j % 3) - 1;
									tmp[1] = moorpixel[i][1] + parseInt(j / 3) - 1;
								} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "leftboundary") {
									cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 2) - 1][moorpixel[i][0] + (j % 2)].cellMass);
									tmp[0] = moorpixel[i][0] + (j % 2);
									tmp[1] = moorpixel[i][1] + parseInt(j / 2) - 1;
								} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "rightboundary") {
									cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 2) - 1][moorpixel[i][0] + (j % 2) - 1].cellMass);
									tmp[0] = moorpixel[i][0] + (j % 2) - 1;
									tmp[1] = moorpixel[i][1] + parseInt(j / 2) - 1;
								} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "topboundary") {
									cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 3)][moorpixel[i][0] + (j % 3) - 1].cellMass);
									tmp[0] = moorpixel[i][0] + (j % 3) - 1;
									tmp[1] = moorpixel[i][1] + parseInt(j / 3);
								} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "bottomboundary") {
									cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 3) - 1][moorpixel[i][0] + (j % 3) - 1].cellMass);
									tmp[0] = moorpixel[i][0] + (j % 3) - 1;
									tmp[1] = moorpixel[i][1] + parseInt(j / 3) - 1;
								} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "topleftboundary") {
									cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 2)][moorpixel[i][0] + (j % 2)].cellMass);
									tmp[0] = moorpixel[i][0] + (j % 2);
									tmp[1] = moorpixel[i][1] + parseInt(j / 2);
								} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "toprightboundary") {
									cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 2)][moorpixel[i][0] + (j % 2) - 1].cellMass);
									tmp[0] = moorpixel[i][0] + (j % 2) - 1;
									tmp[1] = moorpixel[i][1] + parseInt(j / 2);
								} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "bottomleftboundary") {
									cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 2) - 1][moorpixel[i][0] + (j % 2)].cellMass);
									tmp[0] = moorpixel[i][0] + (j % 2);
									tmp[1] = moorpixel[i][1] + parseInt(j / 2) - 1;
								} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "bottomrightboundary") {
									cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 2) - 1][moorpixel[i][0] + (j % 2) - 1].cellMass);
									tmp[0] = moorpixel[i][0] + (j % 2) - 1;
									tmp[1] = moorpixel[i][1] + parseInt(j / 2) - 1;
								}
								
								if (heightdiff[j] < 0 && parseFloat(cellmass[j]) > 0.0) {
									var len = rasterSpreadArea[parseInt(tmp[1])][parseInt(tmp[0])].heightdiffrate.length;
									heightdiffrate[j] = rasterSpreadArea[parseInt(tmp[1])][parseInt(tmp[0])].heightdiffrate[parseInt(len - 1 - j)];
									roughnessinverserate[j] = rasterSpreadArea[parseInt(tmp[1])][parseInt(tmp[0])].roughnessinverserate[parseInt(len - 1 - j)];
									curPointCellMass[j] = parseFloat("0.0");
								} else if (heightdiff[j] > 0) {
									cellmass[j] = parseFloat("0.0");
								}
								moorRate[j] = heightdiffrate[j]*roughnessinverserate[j];
								/*console.log("m: " + mValue);					
								console.log("d: " + dValue);
								console.log("heightdiff: " + heightdiff);
								console.log("heightdiffrate: " + heightdiffrate);
								console.log("roughnessinverserate: " + roughnessinverserate);
								console.log("cellmass: " + cellmass);					
								console.log("curPointCellMass: " + curPointCellMass);
								console.log("moorRate: " + moorRate);*/
								
								var afterChangedCellMass = parseFloat("0.0");
								
								if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "noboundary") {
									afterChangedCellMass = parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].cellMass)
										+ (parseFloat(mValue*moorRate[1]*(cellmass[1] - curPointCellMass[1]))
										+ parseFloat(mValue*moorRate[3]*(cellmass[3] - curPointCellMass[3]))
										+ parseFloat(mValue*moorRate[5]*(cellmass[5] - curPointCellMass[5]))
										+ parseFloat(mValue*moorRate[7]*(cellmass[7] - curPointCellMass[7]))
										+ parseFloat(mValue*dValue*moorRate[0]*(cellmass[0] - curPointCellMass[0]))
										+ parseFloat(mValue*dValue*moorRate[2]*(cellmass[2] - curPointCellMass[2]))
										+ parseFloat(mValue*dValue*moorRate[6]*(cellmass[6] - curPointCellMass[6])))
										- parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].hyconductivity/(24*3600) * deltaT);
								} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "leftboundary") {
									afterChangedCellMass = parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].cellMass)
										+ (parseFloat(mValue*moorRate[0]*(cellmass[0] - curPointCellMass[0]))
										+ parseFloat(mValue*moorRate[3]*(cellmass[3] - curPointCellMass[3]))
										+ parseFloat(mValue*moorRate[4]*(cellmass[4] - curPointCellMass[4]))
										+ parseFloat(mValue*dValue*moorRate[1]*(cellmass[1] - curPointCellMass[1]))
										+ parseFloat(mValue*dValue*moorRate[5]*(cellmass[5] - curPointCellMass[5])))
										- parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].hyconductivity/(24*3600) * deltaT);
								} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "rightboundary") {
									afterChangedCellMass = parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].cellMass)
										+ (parseFloat(mValue*moorRate[1]*(cellmass[1] - curPointCellMass[1]))
										+ parseFloat(mValue*moorRate[2]*(cellmass[2] - curPointCellMass[2]))
										+ parseFloat(mValue*moorRate[5]*(cellmass[5] - curPointCellMass[5]))
										+ parseFloat(mValue*dValue*moorRate[0]*(cellmass[0] - curPointCellMass[0]))
										+ parseFloat(mValue*dValue*moorRate[4]*(cellmass[4] - curPointCellMass[4])))
										- parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].hyconductivity/(24*3600) * deltaT);
								} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "topboundary") {
									afterChangedCellMass = parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].cellMass)
										+ (parseFloat(mValue*moorRate[0]*(cellmass[0] - curPointCellMass[0]))
										+ parseFloat(mValue*moorRate[2]*(cellmass[2] - curPointCellMass[2]))
										+ parseFloat(mValue*moorRate[4]*(cellmass[4] - curPointCellMass[4]))
										+ parseFloat(mValue*dValue*moorRate[3]*(cellmass[3] - curPointCellMass[3]))
										+ parseFloat(mValue*dValue*moorRate[5]*(cellmass[5] - curPointCellMass[5])))
										- parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].hyconductivity/(24*3600) * deltaT);
								} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "bottomboundary") {
									afterChangedCellMass = parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].cellMass)
										+ (parseFloat(mValue*moorRate[1]*(cellmass[1] - curPointCellMass[1]))
										+ parseFloat(mValue*moorRate[3]*(cellmass[3] - curPointCellMass[3]))
										+ parseFloat(mValue*moorRate[5]*(cellmass[5] - curPointCellMass[5]))
										+ parseFloat(mValue*dValue*moorRate[0]*(cellmass[0] - curPointCellMass[0]))
										+ parseFloat(mValue*dValue*moorRate[2]*(cellmass[2] - curPointCellMass[2])))
										- parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].hyconductivity/(24*3600) * deltaT);
								} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "topleftboundary") {
									afterChangedCellMass = parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].cellMass)
										+ (parseFloat(mValue*moorRate[1]*(cellmass[1] - curPointCellMass[1]))
										+ parseFloat(mValue*moorRate[2]*(cellmass[2] - curPointCellMass[2]))
										+ parseFloat(mValue*dValue*moorRate[3]*(cellmass[3] - curPointCellMass[3])))
										- parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].hyconductivity/(24*3600) * deltaT);
								} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "toprightboundary") {
									afterChangedCellMass = parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].cellMass)
										+ (parseFloat(mValue*moorRate[0]*(cellmass[0] - curPointCellMass[0]))
										+ parseFloat(mValue*moorRate[3]*(cellmass[3] - curPointCellMass[3]))
										+ parseFloat(mValue*dValue*moorRate[2]*(cellmass[2] - curPointCellMass[2])))
										- parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].hyconductivity/(24*3600) * deltaT);
								} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "bottomleftboundary") {
									afterChangedCellMass = parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].cellMass)
										+ (parseFloat(mValue*moorRate[0]*(cellmass[0] - curPointCellMass[0]))
										+ parseFloat(mValue*moorRate[3]*(cellmass[3] - curPointCellMass[3]))
										+ parseFloat(mValue*dValue*moorRate[1]*(cellmass[1] - curPointCellMass[1])))
										- parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].hyconductivity/(24*3600) * deltaT);
								} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "bottomrightboundary") {
									afterChangedCellMass = parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].cellMass)
										+ (parseFloat(mValue*moorRate[1]*(cellmass[1] - curPointCellMass[1]))
										+ parseFloat(mValue*moorRate[2]*(cellmass[2] - curPointCellMass[2]))
										+ parseFloat(mValue*dValue*moorRate[0]*(cellmass[0] - curPointCellMass[0])))
										- parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].hyconductivity/(24*3600) * deltaT);
								}
								
								if (afterChangedCellMass > 0) {
									changedCell.push([moorpixel[i][0], moorpixel[i][1], parseFloat(afterChangedCellMass)]);
									/*console.log("rasterSpreadArea[" + moorpixel[i][0] + "][" + moorpixel[i][1] + "].cellMass: " + afterChangedCellMass);*/
								}								
							}
						}
					}
				}
				
				//load 3d scene 加载三维场景
				jQuery("#load3DScene").on("click",function() {
					removeTabActiveClass();
					
					var threedimscenenav = "<li class='active' id='threedimscene'><a href='#threedim-scene' "
							+ "data-toggle='tab'><i class='fa fa-check'></i>"
							+ "<strong>三维场景</strong><i class='glyphicon glyphicon-remove'>"
							+ "</i></a></li>";
					
					var threedimscenepanel = "<div class='tab-pane active' "
							+ "id='threedim-scene'></div>";
							
					jQuery("#tabs-nav").append(threedimscenenav);
					jQuery("#tabs-panel").append(threedimscenepanel);
					
					jQuery("#threedim-scene").load("page/gdwater-threedimscene.jsp",false);
					
					jQuery(".glyphicon-remove").on("click", function() {
						var prev_tab = jQuery(this).parent('a').parent('li').prev().attr('id');
						var nav_tab_id = jQuery(this).parent('a').parent('li').attr('id');
						var panel_tab_href = jQuery(this).parent('a')[0].hash;
	
						jQuery(panel_tab_href).empty();
						jQuery(panel_tab_href).remove();
	
						jQuery('#' + nav_tab_id).empty();
						jQuery('#' + nav_tab_id).remove();
	
						jQuery('#' + prev_tab + " a").tab('show');
					});
					
					jQuery("#func-5").empty();
					jQuery("#func-5").remove();
					
					jQuery("#content-simulation").empty();
					jQuery("#content-simulation").remove();
				});
				
				function removeTabActiveClass() {
					jQuery('ul#tabs-nav > li').each(function() {
						var t = jQuery(this);
						if (t.hasClass('active')) {
							t.removeClass('active');
						}
					});

					jQuery('div#tabs-panel > div').each(function() {
						var t = jQuery(this);
						if (t.hasClass('active')) {
							t.removeClass('active');
						}
					});
				}		
													
				//load ground-water CA Space加载地下水元胞空间
				jQuery("#loadGDWCASpace").on("click", function() {
					if (pluSrcPoint != undefined && pluSrcPoint != null) {
						for (var i = 0; i < 21; i++) {
							rasterSpreadArea[i] = new Array(21);
							for (var j = 0; j < 21; j++) {
								rasterSpreadArea[i][j] = {};
							}
						}
						//清空Graphics
						mainSimuMap.graphics.clear();
						//请求Rest服务返回当前栅格元胞的地下水位、渗透系数和土壤孔隙度
						tempAr = new Array();
						//记录当前栅格元胞的像素值
						var rasterPixel = new Array();
						//rasterSpreadArea初始化
						for (var j = 0; j < 21; j++) {
							 for (var i = 0; i < 21; i++) {						
								rasterSpreadArea[j][i] = {
									"pixelx" : parseInt("-10") + i,
									"pixely" : parseInt("-10") + j,
									"cellMass" : parseFloat("0.0"),
									"geometry" : [parseFloat(pluSrcPoint[0]) + parseFloat((i - 10)) * gdwCellStep,
										parseFloat(pluSrcPoint[1]) + parseFloat((j - 10)) * gdwCellStep],
									"waterlevel" : parseFloat("0.0"),
									"hyconductivity" : parseFloat("0.0"),
									"soilporosity" : parseFloat("0.0"),
									"flowspeed" : parseFloat("0.0"),
									"flowdirection" : parseInt("0"),
									"moorlength" : parseInt("0"),
									"flowcode" : null,
									"boundary" : null,
									"moorpixel" : null,
									"type" : "Groundwater Pollution Source Spread"																
								}
								query.geometry = new Point(
									rasterSpreadArea[j][i].geometry,
									new SpatialReference({
										wkid : 3857
								}));
								
								tempAr.push(imageGDWaterLevelTask.execute(query));
								tempAr.push(imageHyConductivityTask.execute(query));
								//tempAr.push(imageSoilPorosityTask.execute(query));
								rasterPixel.push([i,j]);
							}
						}
						
						curAllPluSrcPoint.push([0, 0]);
						rasterSpreadArea[10][10].cellMass = parseFloat("0");
						
						deferList = new DeferredList(tempAr);																																			
						deferList.then(function (results) {
							for (var i = 0; i < results.length; i++) {
								if (i % 2 === 0) {
									rasterSpreadArea[rasterPixel[i/2][1]][rasterPixel[i/2][0]].waterlevel = parseFloat(results[i][1].value);
								} else if (i % 2 === 1) {
									rasterSpreadArea[rasterPixel[parseInt(i/2)][1]][rasterPixel[parseInt(i/2)][0]].hyconductivity = parseFloat(results[i][1].value);
								} 
								/* else {
									rasterSpreadArea[rasterPixel[parseInt(i/3)][1]][rasterPixel[parseInt(i/3)][0]].soilporosity = parseFloat(results[i][1].value);
								} */
							}
							
							for (var j = 0; j < 21; j++) {
								for (var i = 0; i < 21; i++) {
									var moorpixel = new Array();
									var boundary = null;
									//不包含左、右、上、下边界
									if ((i >= 1) && (i <= 19) && (j >= 1) && (j <= 19)) {
										boundary = "noboundary";
										for (var q = j - 1; q <= j + 1; q++) {
											 for (var p = i - 1; p <= i + 1; p++) {
												moorpixel.push([p, q]);
											}
										}	
									}
									//只包含左边界
									else if ((i == 0) && (j >= 1) && (j <= 19)) {
										boundary = "leftboundary";
										for (var q = j - 1; q <= j + 1; q++) {
											 for (var p = 0; p <= 1; p++) {
												moorpixel.push([p, q]);
											}
										}
									}
									//只包含右边界
									else if ((i == 20) && (j >= 1) && (j <= 19)) {
										boundary = "rightboundary";
										for (var q = j - 1; q <= j + 1; q++) {
											 for (var p = 19; p <= 20; p++) {
												moorpixel.push([p, q]);
											}
										}
									}
									//只包含上边界
									else if ((i >= 1) && (i <= 19) && (j == 0)) {
										boundary = "topboundary";
										for (var q = 0; q <= 1; q++) {
											 for (var p = i - 1; p <= i + 1; p++) {
												moorpixel.push([p, q]);
											}
										}
									}
									//只包含下边界
									else if ((i >= 1) && (i <= 19) && (j == 20)) {
										boundary = "bottomboundary";
										for (var q = 19; q <= 20; q++) {
											 for (var p = i - 1; p <= i + 1; p++) {
												moorpixel.push([p, q]);
											}
										}
									}
									//包含左上边界
									else if ((i == 0) && (j == 0)) {
										boundary = "topleftboundary";
										for (var q = 0; q <= 1; q++) {
											for (var p = 0; p <= 1; p++) {
												moorpixel.push([p, q]);	
											}
										}																		
									}
									//包含右上边界
									else if  ((i == 20) && (j == 0)) {
										boundary = "toprightboundary";
										for (var q = 0; q <= 1; q++) {
											for (var p = 19; p <= 20; p++) {
												moorpixel.push([p, q]);	
											}
										}	
									}
									//包含左下边界
									else if ((i == 0) && (j == 20)) {
										boundary = "bottomleftboundary";
										for (var q = 19; q <= 20; q++) {
											for (var p = 0; p <= 1; p++) {
												moorpixel.push([p, q]);	
											}
										}	
									}
									//包含右下边界
								    else if ((i == 20) && (j == 20)) {
								    	boundary = "bottomrightboundary";
										for (var q = 19; q <= 20; q++) {
											for (var p = 19; p <= 20; p++) {
												moorpixel.push([p, q]);	
											}
										}	
								    }
								    
								    var heightdiff = new Array(moorpixel.length);  //中央元胞与邻域元胞高度差数组
								    var flowcode = new Array(moorpixel.length);  //高度差与距离比值数组
								    for (var p = 0; p < moorpixel.length; p++) {
								    	heightdiff[p] = parseFloat(rasterSpreadArea[j][i].waterlevel)
								    		- parseFloat(rasterSpreadArea[moorpixel[p][1]][moorpixel[p][0]].waterlevel);
								    	var distance = Math.sqrt((moorpixel[p][1] - j)*(moorpixel[p][1] - j) + 
								    		(moorpixel[p][0] - i)*(moorpixel[p][0] - i));
								    	if (distance != 0) {
								    		flowcode[p] = heightdiff[p] / distance;
								    	} else {
								    		flowcode[p] = 0.0;
								    	}
								    }
								    //求比值的最大值
								    var maxflowcode = Math.max.apply(null, flowcode); 
								    //求比值的最大值编码（下标）
								    var flowdirection = searchKey(flowcode, maxflowcode);
								    
								    rasterSpreadArea[j][i].boundary = boundary;
							  		rasterSpreadArea[j][i].flowdirection = flowdirection;
							  		rasterSpreadArea[j][i].flowspeed = parseFloat(rasterSpreadArea[j][i].hyconductivity) / (24 * 3600);
							  		rasterSpreadArea[j][i].moorlength = moorpixel.length;
							  		rasterSpreadArea[j][i].flowcode = flowcode;
							  		rasterSpreadArea[j][i].moorpixel = moorpixel;
							  	}
						    }
						    
						    for (var j = 0; j < 21; j++) {
								for (var i = 0; i < 21; i++) {
									var flowdirection = rasterSpreadArea[j][i].flowdirection;
									if (flowdirection != -1) {
										var moorpixel = rasterSpreadArea[j][i].moorpixel;									
										var boundary = rasterSpreadArea[j][i].boundary;
										var flowcode = rasterSpreadArea[j][i].flowcode;
										var flowdirvec = flowDir(flowdirection, boundary);
										for (var p = 0; p < moorpixel.length; p++) {
											var curflowdirection = rasterSpreadArea[moorpixel[p][1]][moorpixel[p][0]].flowdirection;
											var curboundary = rasterSpreadArea[moorpixel[p][1]][moorpixel[p][0]].boundary;
											var curflowdirvec = flowDir(curflowdirection, curboundary);
											if (curflowdirvec[0] == (-1) * flowdirvec[0] && curflowdirvec[1] == (-1) * flowdirvec[1]) {
												rasterSpreadArea[moorpixel[p][1]][moorpixel[p][0]].flowdirection = -1;
											}
										}
										if (flowcode.length == 0) {
											rasterSpreadArea[j][i].flowdirection = -1;
										} else {
											var maxflowcode = Math.max.apply(null, flowcode);
											var flowdirection = searchKey(flowcode, maxflowcode);
											rasterSpreadArea[j][i].flowdirection = flowdirection;
										}
									}									
								}
							}
						    
						    jQuery.gritter.add({
								title : "消息",
								text : "加载地下元胞空间完成",
								class_name : "growl-success",
								image : "images/screen.png",
								sticky : false,
								time : 5000
							});							    
							
							/*for (var j = 0; j < 21; j++) {
								var n = new Array(21);
								for (var i = 0; i < 21; i++) {
									n[i] = rasterSpreadArea[j][i].flowspeed;
							 	}
							 	console.log(n);
							}*/
						});
					} else {
						jQuery.gritter.add({
							title : "警告",
							text : "请先设定污染点源及参数",
							class_name : "growl-danger",
							image : "images/screen.png",
							sticky : false,
							time : 5000
						});
					}
				});
				
				//Groundwater Simulation Display地下水扩散演示
				jQuery("#gdwaterSimuDisplay").on("click", function() {
					if (rasterSpreadArea === undefined || rasterSpreadArea === null
						|| rasterSpreadArea[0] === undefined || rasterSpreadArea[10][10] === undefined) {
						jQuery.gritter.add({
							title : "警告",
							text : "请先加载地下元胞空间",
							class_name : "growl-danger",
							image : "images/screen.png",
							sticky : false,
							time : 5000
						});
					} else {						
						drawPolygon();
						interval = setInterval(gdwPluSpread, 1000 * deltaT);	
					}	
				});
				
				//Pollution Spread (per deltaT*1000s)
				var gdwPluSpread = function() {
					spreadTime += 1;
					if (spreadTime === 10) {
						clearInterval(interval);
					}
					
					rasterSpreadArea[10][10].cellMass = rasterSpreadArea[10][10].cellMass 
						+ parseFloat("-0.6") * parseFloat(parseFloat(spreadTime) - parseFloat("5")) * 
						parseFloat(parseFloat(spreadTime) - parseFloat("5")) + 15;
					
					console.log("第" + spreadTime + "次计算, 质量注入" + (parseFloat("-0.6") * parseFloat(parseFloat(spreadTime) - parseFloat("5")) * 
						parseFloat(parseFloat(spreadTime) - parseFloat("5")) + 15) + "g");					
					
					//针对目前已污染的元胞进行遍历
					//漂移
					for (var i = 0; i < curAllPluSrcPoint.length; i++) {
						srcShift(curAllPluSrcPoint[i]);						
					}
					
					//机械弥散
					for (var i = 0; i < curAllPluSrcPoint.length; i++) {
						findGDWRasterValue2(curAllPluSrcPoint[i]);						
					}
										
					changedCell2 = arrUnique(changedCell2);
					
					for (var i = 0; i < changedCell2.length; i++) {
						rasterSpreadArea[changedCell2[i][1]][changedCell2[i][0]].cellMass = parseFloat(changedCell2[i][2]);
					}	
									
					for (var i = 0; i < changedCell2.length; i++) {
						curAllPluSrcPoint.push([changedCell2[i][0] - 10, changedCell2[i][1] - 10]);
					}
					
					var neweffect = new Array();
					for (var i = 0; i < effect.length; i++) {
						var flag = false;
						for (var j = 0; j < neweffect.length; j++) {
							if (effect[i].effect[0] === neweffect[j].effect[0] &&
							 	effect[i].effect[1] === neweffect[j].effect[1] &&
								effect[i].effected[0] === neweffect[j].effected[0] &&
								effect[i].effected[1] === neweffect[j].effected[1]) {
								flag = true;
							}						
						}
						if (flag == false) {
							neweffect.push(effect[i]);	
						}
										
					}
					
					for (var i = 0; i < neweffect.length; i++) {
						var effected = neweffect[i].effected;
						rasterSpreadArea[effected[1]][effected[0]].cellMass += parseFloat("-1.0") * parseFloat(neweffect[i].value);
					}
					
					curAllPluSrcPoint = arrUnique(curAllPluSrcPoint);
					changedCell2 = new Array();
					effect = new Array();
					
					//分子扩散
					for (var i = 0; i < curAllPluSrcPoint.length; i++) {
						findGDWRasterValue1(curAllPluSrcPoint[i]);						
					}
					
					changedCell1 = arrUnique(changedCell1);
					
					for (var i = 0; i < changedCell1.length; i++) {
						rasterSpreadArea[changedCell1[i][1]][changedCell1[i][0]].cellMass = parseFloat(changedCell1[i][2]);
					}	
					
					for (var i = 0; i < changedCell1.length; i++) {
						curAllPluSrcPoint.push([changedCell1[i][0] - 10, changedCell1[i][1] - 10]);
					}
					
					curAllPluSrcPoint = arrUnique(curAllPluSrcPoint);
					changedCell1 = new Array();						
					
					for (var j = 0; j <= 20; j++) {
						var cellmass = new Array(21);
						for (var i = 0; i <= 20; i++) {
							cellmass[i] = rasterSpreadArea[j][i].cellMass;
						}
						console.log(cellmass);
					}
					
					drawPolygon();	
					
					if (spreadTime === 10) {
						rasterSpreadArea = new Array(21);
						spreadTime = 0;
					}		
				}
				
				//漂移
				function srcShift(curPluSrcPoint) {
					//当前点流向
					var flowdirection = rasterSpreadArea[10 + curPluSrcPoint[1]][10 + curPluSrcPoint[0]].flowdirection;
					//当前点边界情况
					var boundary = rasterSpreadArea[10 + curPluSrcPoint[1]][10 + curPluSrcPoint[0]].boundary;
					//当前点点流向矢量
					var flowdirvec = flowDir(flowdirection, boundary);
					//当前点流速
					var flowspeed = rasterSpreadArea[10 + curPluSrcPoint[1]][10 + curPluSrcPoint[0]].flowspeed;
					//当前点坐标
					var point = [10 + curPluSrcPoint[0], 10 + curPluSrcPoint[1]];
					
					var len = parseInt(flowspeed * deltaT / gdwCellStep);
					for (var i = 0; i < len; i++) {
						point = [(flowdirvec[0] + point[0]) ,(flowdirvec[1] + point[1])];
						flowdirection = rasterSpreadArea[point[1]][point[0]].flowdirection;
						boundary = rasterSpreadArea[point[1]][point[0]].boundary;
						flowdirvec = flowDir(flowdirection, boundary);						
					}
					
					rasterSpreadArea[point[1]][point[0]].cellMass = rasterSpreadArea[10 + curPluSrcPoint[1]][10 + curPluSrcPoint[0]].cellMass;
					if (len > 0) {
						rasterSpreadArea[10 + curPluSrcPoint[1]][10 + curPluSrcPoint[0]].cellMass = parseFloat("0.0");
					}					
				}
				
				//分子扩散
				function findGDWRasterValue1(curPluSrcPoint) {
					//moorpixel
					var moorpixel = new Array();
					//boundary 边界情况
					var boundary = null;
					
					if ((curPluSrcPoint[0] >= -10 && curPluSrcPoint[0] <= 10) && (curPluSrcPoint[1] >= -10 && curPluSrcPoint[1] <= 10)) {
						//不包含左、右、上、下边界
						if ((curPluSrcPoint[0] - 1 >= -10) && (curPluSrcPoint[0] + 1 <= 10) &&
							(curPluSrcPoint[1] - 1 >= -10) && (curPluSrcPoint[1] + 1 <= 10)) {
							boundary = "noboundary";
							for (var j = curPluSrcPoint[1] + 9; j <= curPluSrcPoint[1] + 11; j++)							 {
								 for (var i = curPluSrcPoint[0] + 9; i <= curPluSrcPoint[0] + 11; i++) {
									moorpixel.push([i, j]);
								}
							}	
						}
						//只包含左边界
						else if ((curPluSrcPoint[0] === -10) && (curPluSrcPoint[1] - 1 >= -10) && (curPluSrcPoint[1] + 1 <= 10)) {
							boundary = "leftboundary";
							for (var j = curPluSrcPoint[1] + 9; j <= curPluSrcPoint[1] + 11; j++) {
								for (var i = 0; i <= 1; i++) {
									moorpixel.push([i, j]);
								}
							}
						}
						//只包含右边界
						else if ((curPluSrcPoint[0] === 10) && (curPluSrcPoint[1] - 1 >= -10) && (curPluSrcPoint[1] + 1 <= 10)) {
							boundary = "rightboundary";
							for (var j = curPluSrcPoint[1] + 9; j <= curPluSrcPoint[1] + 11; j++) {
								 for (var i = 19; i <= 20; i++) {
									moorpixel.push([i, j]);
								}
							}
						}
						//只包含上边界
						else if ((curPluSrcPoint[0] - 1 >= -10) && (curPluSrcPoint[0] + 1 <= 10) &&	(curPluSrcPoint[1] === -10)) {
							boundary = "topboundary";
							for (var j = 0; j <= 1; j++) {
								 for (var i = curPluSrcPoint[0] + 9; i <= curPluSrcPoint[0] + 11; i++) {
									moorpixel.push([i, j]);
								}
							}
						}
						//只包含下边界
						else if ((curPluSrcPoint[0] - 1 >= -10) && (curPluSrcPoint[0] + 1 <= 10) && (curPluSrcPoint[1] === 10)) {
							boundary = "bottomboundary";
							for (var j = 19; j <= 20; j++) {
								for (var i = curPluSrcPoint[0] + 9; i <= curPluSrcPoint[0] + 11; i++) {
									moorpixel.push([i, j]);								
								}
							}
						}
						//包含左上边界
						else if ((curPluSrcPoint[0] === -10) && (curPluSrcPoint[1] === -10)) {
							boundary = "topleftboundary";
							for (var j = 0; j <= 1; j++) {
								for (var i = 0; i <= 1; i++) {
									moorpixel.push([i, j]);
								}
							}							
						}
						//包含右上边界
						else if  ((curPluSrcPoint[0] === 10) && (curPluSrcPoint[1] === -10)) {
							boundary = "toprightboundary";
							for (var j = 0; j <= 1; j++) {
								for (var i = 19; i <= 20; i++) {
									moorpixel.push([i, j]);
								}
							}
						}
						//包含左下边界
						else if ((curPluSrcPoint[0] === -10) && (curPluSrcPoint[1] === 10)) {
							boundary = "bottomleftboundary";
							for (var j = 19; j <= 20; j++) {
								for (var i = 0; i <= 1; i++) {
									moorpixel.push([i, j]);
								}
							}
						}
						//包含右下边界
					    else if ((curPluSrcPoint[0] === 10) && (curPluSrcPoint[1] === 10)) {
					    	boundary = "bottomrightboundary";
							for (var j = 19; j <= 20; j++) {
								for (var i = 19; i <= 20; i++) {
									moorpixel.push([i, j]);
								}
							}
					    }
					}
					
					//用于计算的当前污染物质量
					var curPointCellMass = new Array(moorpixel.length);
					for (var i = 0; i< moorpixel.length; i++) {
						//邻域污染物质量
						var cellmass = new Array(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].moorlength);
						//邻域污染物质量差
						var cellmassdiff = new Array(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].moorlength);
						curPointCellMass[i] = parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].cellMass);
						
						for (var j = 0; j < rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].moorlength; j++) {												
							if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "noboundary") {
								cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 3) - 1][moorpixel[i][0] + (j % 3) - 1].cellMass);
							} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "leftboundary") {
								cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 2) - 1][moorpixel[i][0] + (j % 2)].cellMass);
							} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "rightboundary") {
								cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 2) - 1][moorpixel[i][0] + (j % 2) - 1].cellMass);
							} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "topboundary") {
								cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 3)][moorpixel[i][0] + (j % 3) - 1].cellMass);
							} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "bottomboundary") {
								cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 3) - 1][moorpixel[i][0] + (j % 3) - 1].cellMass);
							} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "topleftboundary") {
								cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 2)][moorpixel[i][0] + (j % 2)].cellMass);
							} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "toprightboundary") {
								cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 2)][moorpixel[i][0] + (j % 2) - 1].cellMass);
							} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "bottomleftboundary") {
								cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 2) - 1][moorpixel[i][0] + (j % 2)].cellMass);
							} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "bottomrightboundary") {
								cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 2) - 1][moorpixel[i][0] + (j % 2) - 1].cellMass);
							}							
							cellmassdiff[j] = cellmass[j] - curPointCellMass[i];	
						}
						
						var afterChangedCellMass = parseFloat("0.0");
						if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "noboundary") {
							afterChangedCellMass = curPointCellMass[i] + cellmassdiff[0] / Math.sqrt(2) * liqMolDiffCoef 
								+ cellmassdiff[2] / Math.sqrt(2) * liqMolDiffCoef + cellmassdiff[6] / Math.sqrt(2) * liqMolDiffCoef 
								+ cellmassdiff[8] / Math.sqrt(2) * liqMolDiffCoef + cellmassdiff[1] * liqMolDiffCoef 
								+ cellmassdiff[3] * liqMolDiffCoef + cellmassdiff[5] * liqMolDiffCoef + cellmassdiff[7] * liqMolDiffCoef;
						} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "leftboundary") {
							afterChangedCellMass = curPointCellMass[i] + cellmassdiff[1] / Math.sqrt(2) * liqMolDiffCoef 
								+ cellmassdiff[5] / Math.sqrt(2) * liqMolDiffCoef + cellmassdiff[0] * liqMolDiffCoef 
								+ cellmassdiff[3] * liqMolDiffCoef + cellmassdiff[4] * liqMolDiffCoef;								
						} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "rightboundary") {
							afterChangedCellMass = curPointCellMass[i] + cellmassdiff[0] / Math.sqrt(2) * liqMolDiffCoef
								+ cellmassdiff[4] / Math.sqrt(2) * liqMolDiffCoef + cellmassdiff[1] * liqMolDiffCoef
								+ cellmassdiff[2] * liqMolDiffCoef + cellmassdiff[5] * liqMolDiffCoef;
						} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "topboundary") {
							afterChangedCellMass = curPointCellMass[i] + cellmassdiff[3] / Math.sqrt(2) * liqMolDiffCoef
								+ cellmassdiff[5] / Math.sqrt(2) * liqMolDiffCoef + cellmassdiff[0] * liqMolDiffCoef
								+ cellmassdiff[2] * liqMolDiffCoef + cellmassdiff[4] * liqMolDiffCoef;
						} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "bottomboundary") {
							afterChangedCellMass = curPointCellMass[i] + cellmassdiff[0] / Math.sqrt(2) * liqMolDiffCoef
								+ cellmassdiff[2] / Math.sqrt(2) * liqMolDiffCoef + cellmassdiff[1] * liqMolDiffCoef
								+ cellmassdiff[3] * liqMolDiffCoef + cellmassdiff[5] * liqMolDiffCoef;
						} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "topleftboundary") {
							afterChangedCellMass = curPointCellMass[i] + cellmassdiff[3] / Math.sqrt(2) * liqMolDiffCoef
								+ cellmassdiff[1] * liqMolDiffCoef + cellmassdiff[2] * liqMolDiffCoef;
						} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "toprightboundary") {
							afterChangedCellMass = curPointCellMass[i] + cellmassdiff[2] / Math.sqrt(2) * liqMolDiffCoef
								+ cellmassdiff[0] * liqMolDiffCoef + cellmassdiff[3] * liqMolDiffCoef;
						} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "bottomleftboundary") {
							afterChangedCellMass = curPointCellMass[i] + cellmassdiff[1] / Math.sqrt(2) * liqMolDiffCoef
								+ cellmassdiff[0] * liqMolDiffCoef + cellmassdiff[3] * liqMolDiffCoef;
						} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "bottomrightboundary") {
							afterChangedCellMass = curPointCellMass[i] + cellmassdiff[0] / Math.sqrt(2) * liqMolDiffCoef
								+ cellmassdiff[1] * liqMolDiffCoef + cellmassdiff[2] * liqMolDiffCoef;
						}
						
						changedCell1.push([moorpixel[i][0], moorpixel[i][1], parseFloat(afterChangedCellMass)]);
					}					
				}
				
				//机械弥散
				function findGDWRasterValue2(curPluSrcPoint) {
					//moorpixel
					var moorpixel = new Array();
					//boundary 边界情况
					var boundary = null;
					
					if ((curPluSrcPoint[0] >= -10 && curPluSrcPoint[0] <= 10) && (curPluSrcPoint[1] >= -10 && curPluSrcPoint[1] <= 10)) {
						//不包含左、右、上、下边界
						if ((curPluSrcPoint[0] - 1 >= -10) && (curPluSrcPoint[0] + 1 <= 10) &&
							(curPluSrcPoint[1] - 1 >= -10) && (curPluSrcPoint[1] + 1 <= 10)) {
							boundary = "noboundary";
							for (var j = curPluSrcPoint[1] + 9; j <= curPluSrcPoint[1] + 11; j++)							 {
								 for (var i = curPluSrcPoint[0] + 9; i <= curPluSrcPoint[0] + 11; i++) {
									moorpixel.push([i, j]);
								}
							}	
						}
						//只包含左边界
						else if ((curPluSrcPoint[0] === -10) && (curPluSrcPoint[1] - 1 >= -10) && (curPluSrcPoint[1] + 1 <= 10)) {
							boundary = "leftboundary";
							for (var j = curPluSrcPoint[1] + 9; j <= curPluSrcPoint[1] + 11; j++) {
								for (var i = 0; i <= 1; i++) {
									moorpixel.push([i, j]);
								}
							}
						}
						//只包含右边界
						else if ((curPluSrcPoint[0] === 10) && (curPluSrcPoint[1] - 1 >= -10) && (curPluSrcPoint[1] + 1 <= 10)) {
							boundary = "rightboundary";
							for (var j = curPluSrcPoint[1] + 9; j <= curPluSrcPoint[1] + 11; j++) {
								 for (var i = 19; i <= 20; i++) {
									moorpixel.push([i, j]);
								}
							}
						}
						//只包含上边界
						else if ((curPluSrcPoint[0] - 1 >= -10) && (curPluSrcPoint[0] + 1 <= 10) &&	(curPluSrcPoint[1] === -10)) {
							boundary = "topboundary";
							for (var j = 0; j <= 1; j++) {
								 for (var i = curPluSrcPoint[0] + 9; i <= curPluSrcPoint[0] + 11; i++) {
									moorpixel.push([i, j]);
								}
							}
						}
						//只包含下边界
						else if ((curPluSrcPoint[0] - 1 >= -10) && (curPluSrcPoint[0] + 1 <= 10) && (curPluSrcPoint[1] === 10)) {
							boundary = "bottomboundary";
							for (var j = 19; j <= 20; j++) {
								for (var i = curPluSrcPoint[0] + 9; i <= curPluSrcPoint[0] + 11; i++) {
									moorpixel.push([i, j]);								
								}
							}
						}
						//包含左上边界
						else if ((curPluSrcPoint[0] === -10) && (curPluSrcPoint[1] === -10)) {
							boundary = "topleftboundary";
							for (var j = 0; j <= 1; j++) {
								for (var i = 0; i <= 1; i++) {
									moorpixel.push([i, j]);
								}
							}							
						}
						//包含右上边界
						else if  ((curPluSrcPoint[0] === 10) && (curPluSrcPoint[1] === -10)) {
							boundary = "toprightboundary";
							for (var j = 0; j <= 1; j++) {
								for (var i = 19; i <= 20; i++) {
									moorpixel.push([i, j]);
								}
							}
						}
						//包含左下边界
						else if ((curPluSrcPoint[0] === -10) && (curPluSrcPoint[1] === 10)) {
							boundary = "bottomleftboundary";
							for (var j = 19; j <= 20; j++) {
								for (var i = 0; i <= 1; i++) {
									moorpixel.push([i, j]);
								}
							}
						}
						//包含右下边界
					    else if ((curPluSrcPoint[0] === 10) && (curPluSrcPoint[1] === 10)) {
					    	boundary = "bottomrightboundary";
							for (var j = 19; j <= 20; j++) {
								for (var i = 19; i <= 20; i++) {
									moorpixel.push([i, j]);
								}
							}
					    }
					}
					
					//用于计算的当前污染物质量
					var curPointCellMass = new Array(moorpixel.length);
					for (var i = 0; i< moorpixel.length; i++) {
						//当前元胞流向
						var curflowdirection = rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].flowdirection;
						//当前边界条件
						var curboundary = rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary;
						//当前流向矢量
						var curflowdirvec = flowDir(curflowdirection, curboundary);
						//当前元胞流速
						var flowspeed = rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].flowspeed;
						//邻域污染物质量
						var cellmass = new Array(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].moorlength);
						//邻域污染物质量差
						var cellmassdiff = new Array(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].moorlength);
						//机械弥散流出通量
						var outMechDispersion = parseFloat("0.0");
						curPointCellMass[i] = parseFloat(rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].cellMass);
						
						for (var j = 0; j < rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].moorlength; j++) {
							var tmp = new Array(2);
							var vec = new Array(2);													
							if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "noboundary") {
								cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 3) - 1][moorpixel[i][0] + (j % 3) - 1].cellMass);
								tmp[0] = moorpixel[i][0] + (j % 3) - 1;
								tmp[1] = moorpixel[i][1] + parseInt(j / 3) - 1;
							} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "leftboundary") {
								cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 2) - 1][moorpixel[i][0] + (j % 2)].cellMass);
								tmp[0] = moorpixel[i][0] + (j % 2);
								tmp[1] = moorpixel[i][1] + parseInt(j / 2) - 1;
							} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "rightboundary") {
								cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 2) - 1][moorpixel[i][0] + (j % 2) - 1].cellMass);
								tmp[0] = moorpixel[i][0] + (j % 2) - 1;
								tmp[1] = moorpixel[i][1] + parseInt(j / 2) - 1;
							} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "topboundary") {
								cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 3)][moorpixel[i][0] + (j % 3) - 1].cellMass);
								tmp[0] = moorpixel[i][0] + (j % 3) - 1;
								tmp[1] = moorpixel[i][1] + parseInt(j / 3);
							} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "bottomboundary") {
								cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 3) - 1][moorpixel[i][0] + (j % 3) - 1].cellMass);
								tmp[0] = moorpixel[i][0] + (j % 3) - 1;
								tmp[1] = moorpixel[i][1] + parseInt(j / 3) - 1;
							} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "topleftboundary") {
								cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 2)][moorpixel[i][0] + (j % 2)].cellMass);
								tmp[0] = moorpixel[i][0] + (j % 2);
								tmp[1] = moorpixel[i][1] + parseInt(j / 2);
							} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "toprightboundary") {
								cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 2)][moorpixel[i][0] + (j % 2) - 1].cellMass);
								tmp[0] = moorpixel[i][0] + (j % 2) - 1;
								tmp[1] = moorpixel[i][1] + parseInt(j / 2);
							} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "bottomleftboundary") {
								cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 2) - 1][moorpixel[i][0] + (j % 2)].cellMass);
								tmp[0] = moorpixel[i][0] + (j % 2);
								tmp[1] = moorpixel[i][1] + parseInt(j / 2) - 1;
							} else if (rasterSpreadArea[moorpixel[i][1]][moorpixel[i][0]].boundary === "bottomrightboundary") {
								cellmass[j] = parseFloat(rasterSpreadArea[moorpixel[i][1] + parseInt(j / 2) - 1][moorpixel[i][0] + (j % 2) - 1].cellMass);
								tmp[0] = moorpixel[i][0] + (j % 2) - 1;
								tmp[1] = moorpixel[i][1] + parseInt(j / 2) - 1;
							}							
							cellmassdiff[j] = cellmass[j] - curPointCellMass[i];							
							
							if (cellmassdiff[j] < 0) {
								vec[0] = tmp[0]	- moorpixel[i][0];
								vec[1] = tmp[1] - moorpixel[i][1];
								
								//流线上流速方向
								if (vec[0] == curflowdirvec[0] && vec[1] == curflowdirvec[1]) {								
									outMechDispersion += flowspeed * deltaT / gdwCellStep * parseFloat(cellmassdiff[j]); 
									effect.push({"effect": moorpixel[i], "effected": tmp, "value": flowspeed * deltaT / gdwCellStep * parseFloat(cellmassdiff[j])});
								}
								//在流向方向上有分量
								else if ((vec[0] * curflowdirvec[0] + vec[1] * curflowdirvec[1]) / Math.sqrt(vec[0] * vec[0] + vec[1] * vec[1])
									/ Math.sqrt(curflowdirvec[0] * curflowdirvec[0] + curflowdirvec[1] * curflowdirvec[1]) > 0) {
									outMechDispersion += 0.5 * flowspeed * deltaT / gdwCellStep * parseFloat(cellmassdiff[j]); 
									effect.push({"effect": moorpixel[i], "effected": tmp, "value": 0.5 * flowspeed * deltaT / gdwCellStep * parseFloat(cellmassdiff[j])});
								}
							}
						}											
						
						var afterChangedCellMass = parseFloat("0.0");
						afterChangedCellMass = curPointCellMass[i] + outMechDispersion;
						
						changedCell2.push([moorpixel[i][0], moorpixel[i][1], parseFloat(afterChangedCellMass)]);
					}
				}
				
				//Draw CA
				function drawPolygon() {
					mainSimuMap.graphics.clear();
					mainSimuMap.graphics.redraw();			
					for (var i = 0; i < curAllPluSrcPoint.length; i++) {
						var point = rasterSpreadArea[parseInt(parseInt(spaceCA/2) + curAllPluSrcPoint[i][1])][parseInt(parseInt(spaceCA/2) + curAllPluSrcPoint[i][0])].geometry;
						var curCM = rasterSpreadArea[parseInt(parseInt(spaceCA/2) + curAllPluSrcPoint[i][1])][parseInt(parseInt(spaceCA/2) + curAllPluSrcPoint[i][0])].cellMass;
						var polygon = new Polygon(new SpatialReference({wkid : 3857}));
						
						polygon.addRing([[parseFloat(point[0]) - parseFloat(cellStep / 2),
							parseFloat(point[1]) - parseFloat(cellStep / 2) ],
							[parseFloat(point[0]) + parseFloat(cellStep / 2),
							parseFloat(point[1]) - parseFloat(cellStep / 2) ],
							[parseFloat(point[0]) + parseFloat(cellStep / 2),
							parseFloat(point[1]) + parseFloat(cellStep / 2) ],
							[parseFloat(point[0]) - parseFloat(cellStep / 2),
							parseFloat(point[1]) + parseFloat(cellStep / 2) ],
							[parseFloat(point[0]) - parseFloat(cellStep / 2),
							parseFloat(point[1]) - parseFloat(cellStep / 2) ]]);
						var symbol, color;
						if (curCM < Math.pow(10, -20) && curCM > 0) {
							color = new dojo.Color([29,254,23,0.1]);
						} else if (curCM < Math.pow(10, -14) && curCM >= Math.pow(10, -20)) {
							color = new dojo.Color([0,255,0,0.2]);
						} else if (curCM < Math.pow(10, -12) && curCM >= Math.pow(10, -14)) {
							color = new dojo.Color([151,232,7,0.3]);
						} else if (curCM < Math.pow(10, -10) && curCM >= Math.pow(10, -12)) {
							color = new dojo.Color([255,255,0,0.4]);
						} else if (curCM < Math.pow(10, -6) && curCM >= Math.pow(10, -10)) {
							color = new dojo.Color([255,99,5,0.5]);
						} else if (curCM < Math.pow(10, -2) && curCM >= Math.pow(10, -6)) {
							color = new dojo.Color([217,104,26,0.6]);
						} else if (curCM < 1 && curCM >= Math.pow(10, -2)) {
							color = new dojo.Color([255,0,0,0.7]);
						} else if (curCM < 10 && curCM >= 1) {
							color = new dojo.Color([204,16,15,0.8]);
						} else if (curCM < 100 && curCM >= 10) {
							color = new dojo.Color([128,0,35,0.9]);
						} else if (curCM == 100) {
							color = new dojo.Color([94,4,29,1]);
						}
						symbol = new SimpleFillSymbol(SimpleFillSymbol.STYLE_SOLID).setColor(color);
						//console.log(symbol);
						var graphic = new Graphic(polygon,symbol);  
						mainSimuMap.graphics.add(graphic);
					}
				}
				
				//流向转矢量
				function flowDir(num, boundary) {
					var flowdir = new Array();
					if (boundary === "noboundary") {
						flowdir = [(parseInt(num) % 3) - 1, parseInt(parseInt(num) / 3) - 1];
					} else if (boundary === "leftboundary") {
						flowdir = [parseInt(num) % 2, parseInt(parseInt(num) / 2) - 1];
					} else if (boundary === "rightboundary") {
						flowdir = [(parseInt(num) % 2) - 1, parseInt(parseInt(num) / 2) - 1];
					} else if (boundary === "topboundary") {
						flowdir = [(parseInt(num) % 3) - 1, parseInt(parseInt(num) / 3)];
					} else if (boundary === "bottomboundary") {
						flowdir = [(parseInt(num) % 3) - 1, parseInt(parseInt(num) / 3) - 1];
					} else if (boundary === "topleftboundary") {
						flowdir = [parseInt(num) % 2, parseInt(parseInt(num) / 2)];
					} else if (boundary === "toprightboundary") {
						flowdir = [(parseInt(num) % 2) - 1, parseInt(parseInt(num) / 2)];
					} else if (boundary === "bottomleftboundary") {
						flowdir = [parseInt(num) % 2, parseInt(parseInt(num) / 2) - 1];
					} else if (boundary === "bottomrightboundary") {
						flowdir = [(parseInt(num) % 2) - 1, parseInt(parseInt(num) / 2) - 1];
					} 
					return flowdir;
				}
				
				//数组去重
				function arrUnique(arr) {
				    var result = [], hash = {};
				    for (var i = 0, elem; (elem = arr[i]) != null; i++) {
				        if (!hash[elem]) {
				            result.push(elem);
				            hash[elem] = true;
				        }
				    }
				    return result;
				}
				
				//根据值查找数组下标，多个下标返回随机数值
				function searchKey(arr, value) {
					var tmp = new Array();
					var tmpV = null;
					for (var i = 0; i < arr.length; i++) {
						if (arr[i] == value) {
							tmp.push(i);
						}
					}
					tmpV = tmp[Math.floor(Math.random()*tmp.length + 1) - 1];
					return tmpV;
				}

				//Draw Time Slider
				function drawTimeSlider() {
					jQuery("#mapContent").after("<div class='row claro'><div class='col-sm-12'>"
						+ "<div id='footer'><div id='timeSlider'></div></div></div></div>");
					timeSlider = TimeSlider({
						style : "height:40px"
					}, dom.byId("timeSlider"));
					mainSimuMap.setTimeSlider(timeSlider);
					timeSlider.setThumbIndexes([ 0, 1 ]);
					var myTimeStepIntervals = [
							new Date(2015, 9, 20, 0, 0, 0, 0),
							new Date(2015, 9, 20, 1, 0, 0, 0),
							new Date(2015, 9, 20, 2, 0, 0, 0),
							new Date(2015, 9, 20, 3, 0, 0, 0),
							new Date(2015, 9, 20, 4, 0, 0, 0),
							new Date(2015, 9, 20, 5, 0, 0, 0),
							new Date(2015, 9, 20, 6, 0, 0, 0),
							new Date(2015, 9, 20, 7, 0, 0, 0),
							new Date(2015, 9, 20, 8, 0, 0, 0),
							new Date(2015, 9, 20, 9, 0, 0, 0),
							new Date(2015, 9, 20, 10, 0, 0, 0),
							new Date(2015, 9, 20, 11, 0, 0, 0),
							new Date(2015, 9, 20, 12, 0, 0, 0),
							new Date(2015, 9, 20, 13, 0, 0, 0),
							new Date(2015, 9, 20, 14, 0, 0, 0),
							new Date(2015, 9, 20, 15, 0, 0, 0),
							new Date(2015, 9, 20, 16, 0, 0, 0),
							new Date(2015, 9, 20, 17, 0, 0, 0),
							new Date(2015, 9, 20, 18, 0, 0, 0),
							new Date(2015, 9, 20, 19, 0, 0, 0),
							new Date(2015, 9, 20, 20, 0, 0, 0),
							new Date(2015, 9, 20, 21, 0, 0, 0),
							new Date(2015, 9, 20, 22, 0, 0, 0),
							new Date(2015, 9, 20, 23, 0, 0, 0) ];
					timeSlider.setTimeStops(myTimeStepIntervals);
					timeSlider.setThumbCount(1);
					timeSlider.startup();
					var labels = arrayUtils.map(timeSlider.timeStops, function(timeStop, i) {
						if (i === 0) {
							return (timeStop.getFullYear()
									+ "/"
									+ timeStop.getMonth()
									+ "/"
									+ timeStop.getDate() + "(Hour)");
						} else if (i % 2 === 0) {
							return timeStop.getHours();
						} else {
							return "";
						}
					});
					timeSlider.setLabels(labels);

					timeSlider.setThumbMovingRate(5000);
					timeSlider.singleThumbAsTimeInstant(true);
				}
			});
	</script>
</body>
</html>
