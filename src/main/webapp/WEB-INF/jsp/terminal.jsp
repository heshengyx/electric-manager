<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<title>终端管理-数据收集平台</title>
	</head>
	
	<body>
		<div data-options="region:'west',split:true" title="终端管理" style="width:20%;min-width:180px;padding:5px;">
			<ul class="easyui-tree" id="trees">
				<li iconCls="icon-base"><span>终端管理</span>
				<ul>
					<li iconCls="icon-gears"><a href="javascript:void(0);" onclick="openTab('终端列表', '${ctx}/manager/terminal/list', false)">终端列表</a></li>
					<li iconCls="icon-gears"><a href="javascript:void(0);" onclick="openTab('终端类别', '${ctx}/manager/style/list', false)">终端类别</a></li>
				</ul>
			</ul>
		</div>
		<div data-options="region:'center'">
			<div id="tab" class="easyui-tabs" data-options="fit:true,border:false,plain:true">
			</div>
		</div>
		<jscript>
		<script type="text/javascript">
		$(function() {
		    openTab('终端列表', '${ctx}/manager/terminal/list', false);
		});
		</script>
		</jscript>
	</body>
</html>