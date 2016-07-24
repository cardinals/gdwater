/**
 * Create by GeekCarnegie On 2015-06-11
 */

/****************** Variable ******************/
/* 1. */
/**********************************************/

/****************** Function ******************/
/* 1. */
/**********************************************/

/***** Add Preloader *****/
jQuery(window).load(function() {
	"use strict";

	// Page Preloader
	jQuery('#preloader').delay(1000).fadeOut(function() {
		jQuery('body').delay(1000).css({
			'overflow' : 'visible'
		});
	});
});

jQuery(document)
		.ready(
				function() {
					"use strict";

					// Get Document Width And Height
					var w = jQuery(document).width();
					var h = jQuery(document).height();

					// Current Time
					function getCurTimeAndDraw() {
						var time = new Date();

						jQuery('.cur-time').html(
								'当前时间：' + time.getFullYear() + '年'
										+ (time.getMonth() + 1) + '月'
										+ time.getDate() + '日' + '&nbsp;'
										+ time.getHours() + '时'
										+ time.getMinutes() + '分'
										+ time.getSeconds() + '秒');
					}
					getCurTimeAndDraw();
					setInterval(getCurTimeAndDraw, 1000);

					// Toggle Left Menu
					jQuery('.leftpanel .nav-parent > a').on(
							'click',
							function() {
								var parent = jQuery(this).parent();
								var sub = parent.find('> ul');

								// Dropdown works only when leftpanel is not
								// collapsed
								if (!jQuery('body').hasClass(
										'leftpanel-collapsed')) {
									if (sub.is(':visible')) {
										sub.slideUp(200, function() {
											parent.removeClass('nav-active');
											jQuery('.mainpanel').css({
												height : ''
											});
											adjustmainpanelheight();
										});
									} else {
										closeVisibleSubMenu();
										parent.addClass('nav-active');
										sub.slideDown(200, function() {
											adjustmainpanelheight();
										});
									}
								}
								return false;
							});

					function closeVisibleSubMenu() {
						jQuery('.leftpanel .nav-parent').each(function() {
							var t = jQuery(this);
							if (t.hasClass('nav-active')) {
								t.find('> ul').slideUp(200, function() {
									t.removeClass('nav-active');
								});
							}
						});
					}

					function adjustmainpanelheight() {
						// Adjust mainpanel height
						var docHeight = jQuery(document).height();
						if (docHeight > jQuery('.mainpanel').height())
							jQuery('.mainpanel').height(docHeight);
					}
					adjustmainpanelheight();

					// Tooltip
					jQuery('.tooltips').tooltip({
						container : 'body'
					});

					// Popover
					jQuery('.popovers').popover();

					// Close Button in Panels
					jQuery('.panel .panel-close').click(function() {
						jQuery(this).closest('.panel').fadeOut(200);
						return false;
					});

					// Form Toggles
					jQuery('.toggle').toggles({
						on : true
					});

					// Minimize Button in Panels
					jQuery('.minimize')
							.click(
									function() {
										var t = jQuery(this);
										var p = t.closest('.panel');
										if (!jQuery(this).hasClass('maximize')) {
											p
													.find(
															'.panel-body, .panel-footer')
													.slideUp(200);
											t.addClass('maximize');
											t.html('&plus;');

											var mainpanelwidth = jQuery(
													'.mainpanel').width();
											var tabwidth = parseInt(mainpanelwidth - 20);

											jQuery('#tt')
													.css('width', tabwidth);
										} else {
											p
													.find(
															'.panel-body, .panel-footer')
													.slideDown(200);
											t.removeClass('maximize');
											t.html('&minus;');

											var mainpanelwidth = jQuery(
													'.mainpanel').width();
											var tabwidth = parseInt(mainpanelwidth - 260);

											jQuery('#tt')
													.css('width', tabwidth);
										}
										return false;
									});

					// Add class everytime a mouse pointer hover over it
					jQuery('.nav-bracket > li').hover(function() {
						jQuery(this).addClass('nav-hover');
					}, function() {
						jQuery(this).removeClass('nav-hover');
					});

					// Menu Toggle
					jQuery('.menutoggle')
							.click(
									function() {
										var body = jQuery('body');
										var bodypos = body.css('position');

										if (bodypos != 'relative') {
											if (!body
													.hasClass('leftpanel-collapsed')) {
												body
														.addClass('leftpanel-collapsed');
												jQuery('.nav-bracket ul').attr(
														'style', '');

												jQuery(this).addClass(
														'menu-collapsed');
											} else {
												body
														.removeClass('leftpanel-collapsed chat-view');
												jQuery(
														'.nav-bracket li.active ul')
														.css({
															display : 'block'
														});

												jQuery(this).removeClass(
														'menu-collapsed');
											}
										} else {
											if (body.hasClass('leftpanel-show'))
												body
														.removeClass('leftpanel-show');
											else
												body.addClass('leftpanel-show');

											adjustmainpanelheight();
										}
									});

					reposition_topnav();

					/*
					 * This function allows top navigation menu to move to left
					 * navigation menu when viewed in screens lower than 1024px
					 * and will move it back when viewed higher than 1024px
					 */
					function reposition_topnav() {
						if (jQuery('.nav-horizontal').length > 0) {

							// top navigation move to left nav
							// .nav-horizontal will set position to relative
							// when viewed in screen below 1024
							if (jQuery('.nav-horizontal').css('position') == 'relative') {
								if (jQuery('.leftpanel .nav-bracket').length == 2) {
									jQuery('.nav-horizontal').insertAfter(
											'.nav-bracket:eq(1)');
								} else {
									// only add to bottom if .nav-horizontal is
									// not yet in the left panel
									if (jQuery('.leftpanel .nav-horizontal').length == 0)
										jQuery('.nav-horizontal').appendTo(
												'.leftpanelinner');
								}

								jQuery('.nav-horizontal')
										.css({
											display : 'block'
										})
										.addClass(
												'nav-pills nav-stacked nav-bracket');

								jQuery('.nav-horizontal .children')
										.removeClass('dropdown-menu');
								jQuery('.nav-horizontal > li').each(
										function() {
											jQuery(this).removeClass('open');
											jQuery(this).find('a').removeAttr(
													'class');
											jQuery(this).find('a').removeAttr(
													'data-toggle');

										});

								if (jQuery('.nav-horizontal li:last-child')
										.has('form')) {
									jQuery('.nav-horizontal li:last-child form')
											.addClass('searchform').appendTo(
													'.topnav');
									jQuery('.nav-horizontal li:last-child')
											.hide();
								}
							} else {
								// move nav only when .nav-horizontal is
								// currently from leftpanel
								// that is viewed from screen size above 1024
								if (jQuery('.leftpanel .nav-horizontal').length > 0) {

									jQuery('.nav-horizontal')
											.removeClass(
													'nav-pills nav-stacked nav-bracket')
											.appendTo('.topnav');
									jQuery('.nav-horizontal .children')
											.addClass('dropdown-menu')
											.removeAttr('style');
									jQuery('.nav-horizontal li:last-child')
											.show();
									jQuery('.searchform')
											.removeClass('searchform')
											.appendTo(
													'.nav-horizontal li:last-child .dropdown-menu');
									jQuery('.nav-horizontal > li > a')
											.each(
													function() {

														jQuery(this)
																.parent()
																.removeClass(
																		'nav-active');

														if (jQuery(this)
																.parent()
																.find(
																		'.dropdown-menu').length > 0) {
															jQuery(this)
																	.attr(
																			'class',
																			'dropdown-toggle');
															jQuery(this)
																	.attr(
																			'data-toggle',
																			'dropdown');
														}

													});
								}
							}
						}
					}

					// Check if leftpanel is collapsed
					if (jQuery('body').hasClass('leftpanel-collapsed'))
						jQuery('.nav-bracket .children').css({
							display : ''
						});

					// Handles form inside of dropdown
					jQuery('.dropdown-menu').find('form').click(function(e) {
						e.stopPropagation();
					});

					jQuery('.leftpanelinner > ul > li a')
							.on(
									'click',
									function() {
										var a = jQuery(this);
										var name = a.data("name");

										jQuery('.leftpanelinner > ul > li')
												.each(
														function() {
															var t = jQuery(this);

															if (t
																	.hasClass('active')) {
																t
																		.removeClass('active');
															}
														});

										if (!a.parent().parent('ul').hasClass(
												'children')) {
											var p = a.parent('li');
											p.addClass('active');
										} else {
											var p = a.parent('li').parent('ul')
													.parent('li');
											p.addClass('active');
										}

										if (!a.parent('li').hasClass(
												'nav-parent')) {
											if (name === "func-1-1") {
												if (!checkRepeatTab(name)) {
													return;
												} else {
													removeTabActiveClass();

													var new_tab_nav = "<li class='active' id='func-1-1'><a href='#content-index-mana' "
															+ "data-toggle='tab'><i class='fa fa-database'></i>"
															+ "<strong>指标管理</strong><i class='glyphicon glyphicon-remove'>"
															+ "</i></a></li>";

													var new_tab_panel = "<div class='tab-pane active' "
															+ "id='content-index-mana'></div>";

													jQuery('#tabs-nav').append(
															new_tab_nav);
													jQuery('#tabs-panel')
															.append(
																	new_tab_panel);

													jQuery(
															'#content-index-mana')
															.load(
																	"page/gdwater-index-mana.jsp",
																	false);
												}
											} else if (name === "func-1-2") {
												if (!checkRepeatTab(name)) {
													return;
												} else {
													removeTabActiveClass();

													var new_tab_nav = "<li class='active' id='func-1-2'><a href='#content-index-allo' "
															+ "data-toggle='tab'><i class='fa fa-database'></i>"
															+ "<strong>指标分配</strong><i class='glyphicon glyphicon-remove'>"
															+ "</i></a></li>";

													var new_tab_panel = "<div class='tab-pane active' "
															+ "id='content-index-allo'></div>";

													jQuery('#tabs-nav').append(
															new_tab_nav);
													jQuery('#tabs-panel')
															.append(
																	new_tab_panel);

													jQuery(
															'#content-index-allo')
															.load(
																	"page/gdwater-index-allo.jsp",
																	false);
												}
											} else if (name === "func-1-3") {
												if (!checkRepeatTab(name)) {
													return;
												} else {
													removeTabActiveClass();

													var new_tab_nav = "<li class='active' id='func-1-3'><a href='#content-index-thre' "
															+ "data-toggle='tab'><i class='fa fa-database'></i>"
															+ "<strong>指标阈值</strong><i class='glyphicon glyphicon-remove'>"
															+ "</i></a></li>";

													var new_tab_panel = "<div class='tab-pane active' "
															+ "id='content-index-thre'></div>";

													jQuery('#tabs-nav').append(
															new_tab_nav);
													jQuery('#tabs-panel')
															.append(
																	new_tab_panel);

													jQuery(
															'#content-index-thre')
															.load(
																	"page/gdwater-index-thre.jsp",
																	false);
												}
											}

											else if (name === "func-2") {
												if (!checkRepeatTab(name)) {
													return;
												} else {
													removeTabActiveClass();

													var new_tab_nav = "<li class='active' id='func-2'><a href='#content-AHP' "
															+ "data-toggle='tab'><i class='fa fa-check'></i>"
															+ "<strong>专家评分</strong><i class='glyphicon glyphicon-remove'>"
															+ "</i></a></li>";

													var new_tab_panel = "<div class='tab-pane active' "
															+ "id='content-AHP'></div>";

													jQuery('#tabs-nav').append(
															new_tab_nav);
													jQuery('#tabs-panel')
															.append(
																	new_tab_panel);

													jQuery('#content-AHP')
															.load(
																	"page/gdwater-AHP.jsp",
																	false);
												}
											}

											else if (name === "fun-3") {
												if (!checkRepeatTab(name)) {
													return;
												} else {
													removeTabActiveClass();

													var new_tab_nav = "<li class='active' id='func-3'><a href='#content-alarm' "
															+ "data-toggle='tab'><i class='glyphicon glyphicon-warning-sign'></i>"
															+ "<strong>报警预警</strong><i class='glyphicon glyphicon-remove'>"
															+ "</i></a></li>";

													var new_tab_panel = "<div class='tab-pane active' "
															+ "id='content-alarm'></div>";

													jQuery('#tabs-nav').append(
															new_tab_nav);
													jQuery('#tabs-panel')
															.append(
																	new_tab_panel);

													jQuery(
															'#content-alarm')
															.load(
																	"page/gdwater-alarm.jsp",
																	false);
												}
											}

											else if (name === "func-5") {
												if (!checkRepeatTab(name)) {
													return;
												} else {
													removeTabActiveClass();

													var new_tab_nav = "<li class='active' id='func-5'><a href='#content-3dsimulation' "
															+ "data-toggle='tab'><i class='fa fa-check'></i>"
															+ "<strong>三维仿真</strong><i class='glyphicon glyphicon-remove'>"
															+ "</i></a></li>";

													var new_tab_panel = "<div class='tab-pane active' "
															+ "id='content-3dsimulation'></div>";

													jQuery('#tabs-nav').append(
															new_tab_nav);
													jQuery('#tabs-panel')
															.append(
																	new_tab_panel);

													jQuery(
															'#content-3dsimulation')
															.load(
																	"page/gdwater-3dsimulation.jsp",
																	false);
												}
											}
										} else {
											return;
										}

										jQuery('.glyphicon-remove')
												.on(
														'click',
														function() {
															var prev_tab = jQuery(
																	this)
																	.parent('a')
																	.parent(
																			'li')
																	.prev()
																	.attr('id');
															var nav_tab_id = jQuery(
																	this)
																	.parent('a')
																	.parent(
																			'li')
																	.attr('id');
															var panel_tab_href = jQuery(
																	this)
																	.parent('a')[0].hash;

															jQuery(
																	panel_tab_href)
																	.empty();
															jQuery(
																	panel_tab_href)
																	.remove();

															jQuery(
																	'#'
																			+ nav_tab_id)
																	.empty();
															jQuery(
																	'#'
																			+ nav_tab_id)
																	.remove();

															jQuery(
																	'#'
																			+ prev_tab
																			+ " a")
																	.tab('show');
														});
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

					function checkRepeatTab(name) {
						var flag = true;

						jQuery('ul#tabs-nav > li').each(function() {
							var t = jQuery(this);
							var tab_name = t.attr('id');

							if (name === tab_name) {
								flag = false;
								t.find('a').tab('show');
							}
						});

						return flag;
					}
				});