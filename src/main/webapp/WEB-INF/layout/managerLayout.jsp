<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title><sitemesh:write property="title" /></title>
		<link rel="stylesheet" type="text/css" href="${ctx}/themes/default/easyui.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/themes/icon.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/css/common.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/css/style.css" />
		<link rel="shortcut icon" type="image/x-icon" href="${ctx}/favicon.ico" />
		<style type="text/css">
		.tree-title{
			font-size: 12px;
		}
		.tree-title a{
			text-decoration: none;
		}
		/* #head-menu{
			position: absolute;
			z-index: 8;
			display: none;
			background: #2d3e50;
			color: #fff;
			left: 0;
			padding: 0 4.5%;
			top: 66px;
		}
		#head-menu .navbar{
			margin: 0 40px 20px 40px;
		}
		#head-menu a{
			color: #fff;
		} */
		.navbar-table tr td a {
		    display: block;
		    text-decoration: none;
		    margin-right: 1.65em;
		}
		</style>
		<sitemesh:write property="head" />
	</head>
	<body class="easyui-layout"">
		<!-- <div id="head-menu">
			<div class="navbar navbar-right">
				<ul>
					<li><a href="/index.php">首页</a></li>
					<li><a href="/demo/main/index.php">Demo</a></li>
					<li><a href="/tutorial/index.php">Tutorial</a></li>
					<li><a href="/documentation/index.php">Documentation</a></li>
					<li><a href="/download/index.php">Download</a></li>
					<li><a href="/extension/index.php">Extension</a></li>
					<li><a href="/contact.php">Contact</a></li>
					<li><a href="/forum/index.php">Forum</a></li>
				</ul>
			</div>
		</div> -->
		<div data-options="region:'north',border:false" class="header" style="height:66px;font-size:12px">
		    <table style="width:100%;">
                <tr>
                    <td style="width:30%;"><a href="/index.php"><img src="${ctx}/images/logo.png" alt="数据收集平台" /></a></td>
                    <td>
                    <table class="navbar-table">
                    <tr>
                        <td><a href="/index.php">首页</a></td>
                        <td><a href="${ctx}/manager/organization">组织机构</a></td>
                        <td><a href="${ctx}/manager/terminal">终端管理</a></td>
                        <td><a href="/index.php">用户管理</a></td>
                        <td><a href="/index.php">报表管理</a></td>
                        <td><a href="/index.php">系统管理</a></td>
                    </tr>
                    </table>
                    <!-- <div class="navbar">
		                <ul>
		                    <li><a href="/index.php">首页</a></li>
		                    <li><a href="/demo/main/index.php">Demo</a></li>
		                    <li><a href="/tutorial/index.php">Tutorial</a></li>
		                    <li><a href="/documentation/index.php">Documentation</a></li>
		                    <li><a href="/download/index.php">Download</a></li>
		                    <li><a href="/extension/index.php">Extension</a></li>
		                    <li><a href="/contact.php">Contact</a></li>
		                    <li><a href="/forum/index.php">Forum</a></li>
		                </ul>
		            </div> -->
                    </td>
                    <td align="right">欢迎：<shiro:principal property="name" />，<a href="#">退出</a></td>
                </tr>
            </table>
			<%-- <div class="content">
				<div class="navigation-toggle" data-tools="navigation-toggle" data-target="#navbar">
					<span>EasyUI</span>
				</div>
				<div id="logo" class="navbar navbar-left">
                    <ul>
                        <li>
                            <a href="/index.php"><img src="${ctx}/images/logo.png" alt="jQuery EasyUI"/></a>
                        </li>
                    </ul>
                </div>
                <div id="navbar" class="navbar navbar-right">
                    <ul>
                         <li><a href="/index.php">首页</a></li>
                         <li><a href="${ctx}/manager/organization">组织机构</a></li>
                         <li><a href="/tutorial/index.php">终端管理</a></li>
                         <li><a href="/documentation/index.php">用户管理</a></li>
                         <li><a href="/download/index.php">报表管理</a></li>
                         <li><a href="/extension/index.php">系统管理</a></li>
                         <li style="width:100px;text-align:right"><a href="/extension/index.php" style="display: inline;">退出</a></li>
                    </ul>
                </div>
                <div style="clear:both"></div>
			</div> --%>
		</div>
		<!-- content -->
		<sitemesh:write property="body" />
		<!-- content -->
		<!-- js -->
		<script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
		<script type="text/javascript" src="${ctx}/js/jquery.easyui.min.js"></script>
		<script type="text/javascript">
		$(function(){
			/* setNav();
			$(window).bind('resize', function(){
				setNav();
			});
			$('.navigation-toggle').bind('click', function(){
				var target = $(this).attr('data-target');
				$(target).toggle();
				setDemoNav();
			});
			$('#tab').tabs({
				onLoad:function(panel){
					var plugin = panel.panel('options').title;
					panel.find('textarea[name="code-'+plugin+'"]').each(function(){
						var data = $(this).val();
						data = data.replace(/(\r\n|\r|\n)/g, '\n');
						if (data.indexOf('\t') == 0){
							data = data.replace(/^\t/, '');
							data = data.replace(/\n\t/g, '\n');
						}
						data = data.replace(/\t/g, '    ');
						var pre = $('<pre name="code" class="prettyprint linenums"></pre>').insertAfter(this);
						pre.text(data);
						$(this).remove();
					});
					prettyPrint();
				}
			});
			var sw = $(window).width();
			if (sw < 767){
				$('body').layout('collapse', 'west');
			}
			$('.navigation-toggle span').bind('click', function(){
				$('#head-menu').toggle();
			}); */
			
			$('#logout').click(function() {
				$.messager.confirm({
					title: '消息',
					ok: '确定',
					cancel: '取消',
					msg: '确定要登出吗?',
					fn: function(r){
						if (r){
							location.href = "${ctx}/manager/logout";
						}
					}
				});
			});
		});
		function openTab(name, url, flag){
			if ($('#tab').tabs('exists', name)){
				$('#tab').tabs('select', name);
			} else {
				$('#tab').tabs('add',{
					title: name,
					//href: url,
					closable: flag,
					content: '<iframe scrolling="no" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>'
					/* bodyCls: 'content-doc',
					extractor: function(data){
						return data;
					} */
				});
			}
		}
		/* function setNav(){
			var demosubmenu = $('#demo-submenu');
			if (demosubmenu.length){
				if ($(window).width() < 450){
					demosubmenu.find('a:last').hide();
				} else {
					demosubmenu.find('a:last').show();
				}
			}
			if ($(window).width() < 767){
				$('.navigation-toggle').each(function(){
					$(this).show();
					var target = $(this).attr('data-target');
					$(target).hide();
					setDemoNav();
				});
			} else {
				$('.navigation-toggle').each(function(){
					$(this).hide();
					var target = $(this).attr('data-target');
					$(target).show();
				});
			}
		}
		function setDemoNav(){
			$('.navigation-toggle').each(function(){
				var target = $(this).attr('data-target');
				if (target == '#navbar-demo'){
					if ($(target).is(':visible')){
						$(this).css('margin-bottom', 0);
					} else {
						$(this).css('margin-bottom', '2.3em');
					}
				}
			});
		} */
		</script>
		<sitemesh:write property="jscript" />
		<!-- js -->
	</body>
</html>