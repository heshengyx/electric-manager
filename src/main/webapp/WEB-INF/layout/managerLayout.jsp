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
		<link rel="stylesheet" type="text/css" href="${ctx}/themes/extension.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/css/common.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/css/style.css" />
		<link rel="shortcut icon" type="image/x-icon" href="${ctx}/favicon.ico" />
		<style type="text/css">
		.tree-title {font-size: 12px;}
		.tree-title a {text-decoration: none;}
		.header-layout {
            overflow: hidden; 
		    height: 30px;
            background: url(${ctx}/images/header-bg.gif) #7f99be repeat-x center 50%;
            line-height: 25px;
            color: #fff;
		}
		.header-right {
		    float: right;
		    padding-right: 20px;
		}
		.header-right a {color: #fff;}
		.header-left {
            font-size: 14px;
            padding-left: 20px;
        }
        .menu-accordion {
        	padding: 10px 10px 10px 5px;
        }
        .easyui-accordion ul{list-style-type:none;margin:0px; padding:10px;}
		.easyui-accordion ul li{padding:0px;}
		.easyui-accordion ul li a{line-height:24px;text-decoration: none;}
		.easyui-accordion ul li div{margin:2px 0px;padding-left:10px;padding-top:2px;}
		.easyui-accordion ul li div.hover{background:#E0ECFF;cursor:pointer;}
		.easyui-accordion ul li div.hover a{color:#416AA3;}
		.easyui-accordion ul li div.selected{background:#E0ECFF;cursor:default;}
		.easyui-accordion ul li div.selected a{color:#416AA3; font-weight:bold;}
		</style>
		<sitemesh:write property="head" />
	</head>
	
	<body class="easyui-layout">
		<div data-options="region:'north',split:true,border:false" class="header-layout">
            <span class="header-right">用户：<shiro:principal property="name" />，欢迎使用  <a href="javascript:void(0);" id="modify">修改密码</a> <a href="javascript:void(0);" id="logout">安全退出</a></span>
            <span class="header-left"><img src="${ctx}/images/logo.gif" width="20" height="20" /> 数据收集平台</span>
        </div>
        <div data-options="region:'south',split:true,border:false" style="height: 30px; background: #D2E0F2; ">
            <div class="footer">Copyright @ 2016 广电运通 www.grgbanking.com</div>
        </div>
        <div data-options="region:'west',split:true,iconCls:'icon-application_side_tree'" title="导航菜单" style="width:20%;min-width:180px;">
            <div class="easyui-accordion" style="border:0;height:100%;" id="menuTree">
                <div title="实时数据" data-options="iconCls:'icon-report',selected:true">
                    <ul class="easyui-tree trees"></ul>
                </div>
			    <div title="组织机构" data-options="iconCls:'icon-chart_organisation'">
			        <ul>
			        	<li><div><a target="mainFrame" href="${ctx}/manager/organization/list"><span class="icon icon-add"></span>机构管理</a></div></li>
			        	<li><div><a target="mainFrame" href="${ctx}/manager/associate/list"><span class="icon icon-add"></span>关联终端</a></div></li>
			        </ul>
			        <!-- <ul class="easyui-tree" id="trees"></ul> -->
			    </div>
			    <div title="终端管理" data-options="iconCls:'icon-computer'">
			        <%-- <ul>
						<li><a href="javascript:void(0);" onclick="openTab('终端列表', '${ctx}/manager/permission/list', true)">终端列表</a></li>
						<li><a href="javascript:void(0);" onclick="openTab('终端类别', '${ctx}/manager/role/list', true)">终端类别</a></li>
					</ul> --%>
					<ul>
                        <li><div><a target="mainFrame" href="${ctx}/manager/terminal/list"><span class="icon icon-add"></span>终端列表</a></div></li>
                        <li><div><a target="mainFrame" href="${ctx}/manager/style/list"><span class="icon icon-add"></span>终端类别</a></div></li>
                    </ul>
			    </div>
			    <div title="用户管理" data-options="iconCls:'icon-user'">
                    <ul>
                        <li><div><a href="javascript:void(0);" onclick="openTab('权限管理', '${ctx}/manager/permission/list', true)"><span class="icon icon-add"></span>权限管理</a></div></li>
                        <li><div><a href="javascript:void(0);" onclick="openTab('角色管理', '${ctx}/manager/role/list', true)"><span class="icon icon-add"></span>角色管理</a></div></li>
                    </ul>
                </div>
                <div title="系统管理" data-options="iconCls:'icon-wrench'">
                    content3
                </div>
			</div>
        </div>
		<!-- content -->
		<sitemesh:write property="body" />
		<!-- content -->
		<!-- js -->
		<script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
		<script type="text/javascript" src="${ctx}/js/jquery.easyui.min.js"></script>
		<script type="text/javascript">
		$(function() {
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
			//trees();
			//openTab('集团列表', '${ctx}/manager/organization/list', false);
			$('.trees').tree({
                url: "${ctx}/manager/tree?terminalFlag=1",
                lines: true,
                onClick: function(node) {
                    if (node.attributes) {
                    	openTab(node.text, '${ctx}/manager/timeliness/list?id=' + node.id, true);
                    }
                }
            });
			$('.easyui-accordion li a').click(function() {
				var text = $(this).text();
				var url = $(this).attr("href");
				//openTab(text, url, true);
				$('.easyui-accordion li div').removeClass("selected");
				$(this).parent().addClass("selected");
			}).hover(function() {
				$(this).parent().addClass("hover");
			}, function() {
				$(this).parent().removeClass("hover");
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
					content: '<iframe name="mainFrame" scrolling="no" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>'
					/* bodyCls: 'content-doc',
					extractor: function(data){
						return data;
					} */
				});
			}
		}
		function trees() {
            $('#trees').tree({
                url: "${ctx}/manager/tree",
                lines: true,
                onClick: function(node) {
                    if (node.children) {
                    	openTab(node.text, '${ctx}/manager/organization/list?parentId=' + node.id, true);
                    } else {
                    	openTab(node.text, '${ctx}/manager/terminal/list?orgId=' + node.id, true);
                    }
                }
            });
        }
		</script>
		<sitemesh:write property="jscript" />
		<!-- js -->
	</body>
</html>