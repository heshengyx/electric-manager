<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title>组织机构-数据收集平台</title>
    </head>

	<body>
    	<div data-options="region:'west',iconCls:'icon-application_side_tree'" title="组织机构" style="width:20%;min-width:180px;">
            <div class="easyui-accordion" style="border:0;height:100%;" id="menuTree">
			    <ul class="easyui-tree" id="trees"></ul>
			</div>
        </div>
        <div data-options="region:'center',border:false">
        	<!-- content -->
			<div class="tag-content">
			<!-- search -->
			<form class="data-form" id="searchForm" method="post">
		    <table>
		        <tr>
		            <td>${title}名称：</td>
		            <td><input type="text" id="name" style="width:150px;"></td>
		            <td class="td-right">${title}编码：</td>
		            <td><input type="text" id="code" style="width:100px;"></td>
		            <td class="td-right">创建时间：</td>
		            <td>
		            <input class="easyui-datebox" type="text" id="createDateBegin" style="width:100px;">~
		            <input class="easyui-datebox" type="text" id="createDateEnd" style="width:100px;"></td>
		        </tr>
		        <tr>
		            <td></td>
		            <td colspan="5">
		            <a class="easyui-linkbutton" id="searchBtn" href="javascript:void(0);" data-options="iconCls:'icon-search'">查询</a>&nbsp;
		            <a class="easyui-linkbutton" id="resetBtn" href="javascript:void(0);" data-options="iconCls:'icon-back'">重置</a>
		            </td>
		        </tr>
		    </table>
		    </form>
			<!-- search -->
			<!-- datagrid -->
			<div id="tools">
				<a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-add',plain:true" id="addBtn">新增</a>
				<a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-remove',plain:true" id="deleteBtn">删除</a>
				<a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-control_add_blue',plain:true" id="addBatchBtn">批量</a>
			</div>
			<table id="datagrid" style="width:100%;"></table>
			<!-- datagrid -->
			<!-- 新增 -->
			<div class="easyui-window" id="editWin" data-options="modal:true,closed:true,resizable:false,
						minimizable:false,
						maximizable:false,
						draggable:true,
						collapsible:false"
						style="width:330px;height:160px;padding:10px;">
			    <form id="editForm" method="post">
				<input type="hidden" name="id" id="dataId">
				<input type="hidden" name="parentId" id="parentId" value="${param.parentId}">
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
						<td><a class="easyui-linkbutton" id="saveBtn" href="javascript:void(0);" data-options="iconCls:'icon-save'">保存</a></td>
					</tr>
				</table>
				</form>
			</div>
			<!-- 新增 -->
			<!-- 批量 -->
			<div class="easyui-window" id="editBatchWin" data-options="modal:true,closed:true,resizable:false,
		                minimizable:false,
		                maximizable:false,
		                draggable:true,
		                collapsible:false"
		                style="width:350px;height:400px;">
		        <div id="tb" style="height:auto">
		            <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">添加行</a>
		            <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">删除行</a>
		            <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="saveBatch()">保存</a>
		        </div>
		        <table id="dgBatch" style="width:100%;">
		            <thead>
		                <tr>
		                    <th data-options="field:'name',width:100,editor:{type:'text'}">${title}名称</th>
		                    <th data-options="field:'code',width:100,editor:{type:'text'}">${title}编码</th>
		                </tr>
		            </thead>
		        </table>
		        <form id="editBatchForm" method="post"></form>
		    </div>
			<!-- 批量 -->
			</div>
			<!-- content -->
        </div>
        <jscript>
	    <!-- js -->
	    <script type="text/javascript" src="${ctx}/js/format.js"></script>
	    <script type="text/javascript" src="${ctx}/js/common.js"></script>
	    <script type="text/javascript">
	    $(function() {
	    	trees();
	    	$('#datagrid').datagrid({
				url: '${ctx}/manager/organization/query',
				toolbar: '#tools',
				idField: "id",
				queryParams: {parentId: $('#parentId').val()},
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
			        {field: 'name', title: '${title}名称'},
			        {field: 'code', title: '${title}编码', width: 300},
			        {field: 'createTime', title: '创建时间', formatter:function(val, row, idx) {
			        	return to_date_hms(val);
			        }},
			        {field: 'opts', title: '操作', formatter:function(val, row, idx) {
			        	return '<a href="#" class="easyui-linkbutton" data-options="iconCls:\'icon-edit\',plain:true" onclick="updateById(\'' + row.id + '\')">修改</a>';
			        }}
			    ]]
			});
		    
		    $('#searchBtn').click(function() {
		    	$('#datagrid').datagrid('load', {
		    	    name: $('#name').val(),
		    	    code: $('#code').val(),
		    	    parentId: $('#parentId').val(),
		    	    createDateBegin: $('#createDateBegin').datebox('getValue'),
		    	    createDateEnd: $('#createDateEnd').datebox('getValue')
		    	});
		    });
		    
		    $('#editForm').form({
			    url: '${ctx}/manager/organization/saveOrUpdate',
			    onSubmit: function() {
			    	var isValid = $(this).form('validate');
					if (!isValid) {$.messager.progress('close');}
					return isValid;
			    },
			    success: function(result) {
			    	var result = $.parseJSON(result);
			    	$.messager.progress('close');
					if (result.status) {
						$.messager.alert('消息', '保存成功', 'info', function(r) {
							$('#editWin').window('close');
							window.parent.trees();
							$('#datagrid').datagrid('reload');
							$('#editForm').form('reset');
						});
					} else {
						$.messager.alert('消息', result.message, 'error');
					}
			    }
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
			                            window.parent.trees();
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
	    });
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
	    <!-- js -->
	    </jscript>
	</body>
</html>