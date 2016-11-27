<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<title>组织机构-数据收集平台</title>
	</head>
	
	<body>
		<div data-options="region:'west',split:true" title="组织机构" style="width:20%;min-width:180px;padding:5px;">
			<ul class="easyui-tree" id="trees"></ul>
		</div>
		<div data-options="region:'center'">
			<div id="tab" class="easyui-tabs" data-options="fit:true,border:false,plain:true">
				<!-- <div title="集团列表" href="hello.php" class="content-doc"></div> -->
			</div>
		</div>
		<jscript>
		<script type="text/javascript">
		$(function() {
		    openTab('集团列表', '${ctx}/manager/organization/list', false);
		    trees();
			/* var url = "${ctx}/manager/organization/tree"
	        var params = {
	        };
	        $.post(url, params, function(result) {
	            console.log(result);
	        }, 'json'); */
		});
		function trees() {
			$('#trees').tree({
                url: "${ctx}/manager/organization/tree",
                onClick: function(node) {
                    openTab(node.text, '${ctx}/manager/organization/list?parentId=' + node.id, true);
                }
            });
		}
		</script>
		</jscript>
	</body>
</html>