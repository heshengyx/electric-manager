<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>

<!DOCTYPE html>
<html>
	<body>
	<c:set var="title" value="公司"/>
	<c:if test="${empty param.id}"><c:set var="title" value="集团"/></c:if>
	<!-- content -->
	<div id="tools">
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" id="addBtn">新增</a>
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="addBatchBtn">批量</a>
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" id="deleteBtn">删除</a>
	</div>
	<table id="datagrid" style="width:100%;"></table>
	
	<!-- 新增 -->
	<div class="easyui-window" id="editBtnWin" data-options="modal:true,closed:true,resizable:false,
				minimizable:false,
				maximizable:false,
				draggable:true,
				collapsible:false"
				style="width:300px;height:150px;padding-left:10px;padding-top:10px;">
	    <form id="editForm" method="post">
		<input type="hidden" name="id" id="dataId">
		<table class="table">
			<tr>
				<td align="right">${title}名称：</td>
				<td>
				<input class="easyui-validatebox" type="text" name="name" id="nameEdit" style="width:150px;" data-options="required:true"></td>
			</tr>
			<tr>
				<td align="right">${title}编码：</td>
				<td>
				<input class="easyui-validatebox" type="text" name="code" id="codeEdit" style="width:150px;" data-options="required:true"></td>
			</tr>
			<tr>
				<td></td>
				<td><a class="easyui-linkbutton" id="saveBtn" href="#" data-options="iconCls:'icon-save'">保存</a></td>
			</tr>
		</table>
		</form>
	</div>
	<!-- 新增 -->
	<!-- content -->
	<!-- js -->
	<script type="text/javascript">
	$(function() {
		var title = "公司";
		/* $('#trees').tree({
	   		url: "${ctx}/manager/organization/tree",
	   		onClick: function(node) {
	   	    	//$(thisree('toggle', node.target);
	   			openTab(node.text, '${ctx}/manager/organization/query');
	   	    }
	   	}); */
	   	
	   	$('#datagrid').datagrid({
			url: '${ctx}/manager/organization/queryData',
			toolbar: '#tools',
			idField: "id",
			autoRowHeight: true,
			fitColumns: true,
			showFooter: true,
			pagination: true,
			pageNumber: 1,
			pageSize: 20,
			singleSelect: false,
			rownumbers: true,
			selectOnCheck: true,
			checkOnSelect: true,
			columns: [[
				{field: 'id', title: '选择', width: 30, checkbox: true},
		        {field: 'name', title: title + '名称', width: 300},
		        {field: 'code', title: title + '编码'},
		        {field: 'createTime', title: '创建时间', formatter:function(val, row, idx) {
		        	return to_date_hms(val);
		        }},
		        {field: 'opts', title: '操作', formatter:function(val, row, idx) {
		        	return '<a href="#" class="easyui-linkbutton" data-options="iconCls:\'icon-edit\',plain:true" onclick="updateById(\'' + row.id + '\')">修改</a>';
		        }}
		    ]]
		});
		
		$('#addBtn').click(function() {
			$("#editBtnWin").window({title:"新增" + title}).window("open").window("center");
		});
		
		$('#deleteBtn').click(function() {
			var rows = $('#datagrid').datagrid('getChecked');
			if (!rows.length) {
				$.messager.alert('消息', '请至少选择一条记录', 'error');
			} else {
				$.messager.confirm({
					title: '消息',
					ok: '确定',
					cancel: '取消',
					msg: '确定要删除吗?',
					fn: function(r){
						if (r){
							$.messager.progress();
							var url = "${ctx}/manager/organization/deleteBatch"
							var params = {
								ids: getRowIds(rows)	
							};
							$.post(url, params, function(result) {
								$.messager.progress('close');
					        	if (result.status) {
		                            $.messager.alert('消息', '删除成功', 'info');  
		                            $('#trees').tree('reload');
		                            $('#datagrid').datagrid('reload');
					        	} else {
									$.messager.alert('消息', result.message, 'error');
								}
					      	}, 'json');
						}
					}
				});
			}
		});
		
		$('#saveBtn').click(function() {
			$.messager.progress();
			$('#editForm').submit();
		});
		
		$('#editForm').form({
		    url: '${ctx}/manager/organization/saveOrUpdate',
		    onSubmit: function() {
		    	var isValid = $(this).form('validate');
				if (!isValid){
					$.messager.progress('close');
				}
				return isValid;
		    },
		    success: function(result) {
		    	var result = $.parseJSON(result);
		    	$.messager.progress('close');
				if (result.status) {
					$.messager.alert('消息', '保存成功', 'info', function(r) {
						$("#editBtnWin").window('close');
						$('#trees').tree('reload');
						$('#datagrid').datagrid('reload');
						$('#editForm').form('reset');
					});
				} else {
					$.messager.alert('消息', result.message, 'error');
				}
		    }
		});
	});
	function updateById(id) {
		$.messager.progress();
		var url = "${ctx}/manager/organization/getById"
		var params = {
			id: id	
		};
		$.post(url, params, function(result) {
			$.messager.progress('close');
	       	if (result.status) {
	       		$('#dataId').val(result.data.id);
	       		$('#nameEdit').val(result.data.name);
	       		$('#codeEdit').val(result.data.code);
	       		$("#editBtnWin").window({title:"修改集团"}).window("open").window("center");
	       	} else {
				$.messager.alert('消息', result.message, 'error');
			}
	   	}, 'json');
	}
	</script>
	<!-- js -->
	</body>
</html>