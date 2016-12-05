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
		<link rel="stylesheet" type="text/css" href="${ctx}/themes/extension.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/themes/icon.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/css/common.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/css/style.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/css/prettify.css" />
		<link rel="shortcut icon" type="image/x-icon" href="${ctx}/favicon.ico" />
		<sitemesh:write property="head" />
	</head>
	
	<body class="easyui-layout">
		<!-- content -->
		<div data-options="region:'center',border:false">
		<sitemesh:write property="body" />
		</div>
		<!-- content -->
		<!-- js -->
		<script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
		<script type="text/javascript" src="${ctx}/js/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="${ctx}/js/prettify.js"></script>
		<script type="text/javascript" src="${ctx}/locale/easyui-lang-zh_CN.js"></script>
		<sitemesh:write property="jscript" />
		<!-- js -->
	</body>
</html>