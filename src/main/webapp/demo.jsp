<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>登录-数据收集平台</title>
		<link rel="stylesheet" type="text/css" href="${ctx}/themes/default/easyui.css" />
	</head>
	
	<body class="easyui-layout">
    <div data-options="region:'north'" style="height:100px"></div>
    <div data-options="region:'center'">
        <div class="easyui-layout" data-options="fit:true">
            <div data-options="region:'west',collapsed:true" style="width:180px"></div>
            <div data-options="region:'center'"></div>
        </div>
    </div>
</body>
	<!-- js -->
	<script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery.easyui.min.js"></script>
	<!-- js -->
</html>