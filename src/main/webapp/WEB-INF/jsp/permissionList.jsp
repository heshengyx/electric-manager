<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title>权限管理-数据收集平台</title>
    </head>

	<body>
	    <div data-options="region:'center',border:false">
			<div class="tag-content">
			<!-- search -->
			<form class="data-form" id="searchForm" method="post">
		    <table>
		        <tr>
		            <td>权限名称：</td>
		            <td><input type="text" id="nameQuery" style="width:150px;"></td>
		            <td class="td-right">权限URL：</td>
		            <td><input type="text" id="codeQuery" style="width:100px;"></td>
		            <td class="td-right">创建时间：</td>
		            <td>
		            <input class="easyui-datebox" type="text" id="createDateBeginQuery" style="width:100px;">~
		            <input class="easyui-datebox" type="text" id="createDateEndQuery" style="width:100px;"></td>
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
			<table id="treegrid" style="width:100%;"></table>
			<!-- datagrid -->
			<!-- 新增 -->
			<div class="easyui-window" id="editWin" data-options="modal:true,closed:true,resizable:false,
						minimizable:false,
						maximizable:false,
						draggable:true,
						collapsible:false"
						style="width:330px;height:200px;padding:10px;">
			    <form id="editForm" method="post">
				<input type="hidden" name="id" id="dataId">
				<table class="table">
				    <tr>
                        <td align="right">上级权限：</td>
                        <td>
                        <input type="text" name="parentId" id="parentIdEdit" style="width:150px;"></td>
                    </tr>
					<tr>
						<td align="right">权限名称：</td>
						<td>
						<input class="easyui-validatebox" type="text" name="name" id="nameEdit" style="width:150px;" data-options="required:true"></td>
					</tr>
					<tr>
                        <td align="right">权限编码：</td>
                        <td>
                        <input class="easyui-validatebox" type="text" name="code" id="codeEdit" style="width:150px;" data-options="required:true"></td>
                    </tr>
					<tr>
						<td align="right">权限URL：</td>
						<td>
						<input class="easyui-validatebox" type="text" name="url" id="urlEdit" style="width:150px;" data-options="required:true"></td>
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
			<div class="easyui-window" id="addBatchWin" data-options="modal:true,closed:true,resizable:false,
		                minimizable:false,
		                maximizable:false,
		                draggable:true,
		                collapsible:false"
		                style="width:450px;height:350px;">
		        <div id="addTools">
		            <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">添加行</a>
		            <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">删除行</a>
		            <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="saveBatch()">保存</a>
		        </div>
		        <table id="addBatchDatagrid" style="width:100%;">
		            <thead>
		                <tr>
		                    <th data-options="field:'name',width:100,editor:{type:'text'}">机构名称</th>
		                    <th data-options="field:'code',width:100,editor:{type:'text'}">机构编码</th>
		                </tr>
		            </thead>
		        </table>
		        <form id="addBatchForm" method="post"></form>
		    </div>
			<!-- 批量 -->
			</div>
	    </div>
	    <jscript>
	    <!-- js -->
	    <script type="text/javascript" src="${ctx}/js/format.js"></script>
	    <script type="text/javascript" src="${ctx}/js/common.js"></script>
	    <script type="text/javascript">
	    $(function() {
	    	$('#treegrid').treegrid({
				url: '${ctx}/manager/permission/tree',
				toolbar: '#tools',
				idField: 'id',
				treeField: 'text',
				fixed: true,
				fitColumns: true,
				singleSelect: false,
				autoRowHeight: false,
                rownumbers: true,
                selectOnCheck: true,
                checkOnSelect: true,
				columns: [[
					{field: 'id', title: '选择', width: 30, checkbox: true},
			        {field: 'text', title: '权限名称'},
			        {field: 'code', title: '权限编码', width: 200, formatter:function(val, row, idx) {
                        return row.attributes.code;
                    }},
			        {field: 'url', title: '权限URL', width: 200, formatter:function(val, row, idx) {
                        return row.attributes.url;
                    }},
                    {field: 'createTime', title: '创建时间', formatter:function(val, row, idx) {
                        return row.attributes.createTime;
                    }},
			        {field: 'opts', title: '操作', formatter:function(val, row, idx) {
			        	return '<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:\'icon-edit\',plain:true" onclick="updateById(\'' + row.id + '\')">修改</a>';
			        }}
			    ]]
			});
	    	
	    	$('#parentIdEdit').combotree({
	    	    url: '${ctx}/manager/permission/tree'
	    	});
		    
		    $('#searchBtn').click(function() {
		    	$('#treegrid').treegrid('load', {
		    	    name: $('#nameQuery').val(),
		    	    code: $('#codeQuery').val(),
		    	    createDateBegin: $('#createDateBeginQuery').datebox('getValue'),
		    	    createDateEnd: $('#createDateEndQuery').datebox('getValue')
		    	});
		    });
		    
		    $('#editForm').form({
			    url: '${ctx}/manager/permission/saveOrUpdate',
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
							$('#parentIdEdit').combotree('reload');
							$('#treegrid').treegrid('reload');
							$('#editForm').form('reset');
						});
					} else {
						$.messager.alert('消息', result.message, 'error');
					}
			    }
			});
	
			$('#deleteBtn').click(function() {
				var rows = $('#treegrid').datagrid('getChecked');
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
			                            //重新加载
			                            $('#treegrid').datagrid('reload');
			                            //取消选择行
			                            $('#treegrid').datagrid('clearSelections');
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
	    function updateById(id) {
	        $.messager.progress();
	        var url = "${ctx}/manager/organization/getById"
	        var params = {id: id};
	        $.post(url, params, function(result) {
	            $.messager.progress('close');
	            if (result.status) {
	                $('#dataId').val(result.data.id);
	                $('#nameEdit').val(result.data.name);
	                $('#codeEdit').val(result.data.code);
	                $("#parentIdEdit").combotree('setValue', result.data.parentId);
	                $("#editWin").window({title:"修改"}).window("open").window("center");
	            } else {
	                $.messager.alert('消息', result.message, 'error');
	            }
	        }, 'json');
	    }
	    function saveBatch() {
	        if (endEditing()){
	            var rows = $('#addBatchDatagrid').datagrid('getChanges');
	            if (rows.length) {
	                var inserted = $('#addBatchDatagrid').datagrid('getChanges', "inserted");
	                if (inserted.length) {
	                    var $form = $('#addBatchForm');
	                    $form.children().remove();
	                    for (var i=0; i<inserted.length; i++) {
	                        $form.append('<input type="hidden" name="name" value="' + inserted[i].name + '">');
	                        $form.append('<input type="hidden" name="code" value="' + inserted[i].code + '">');
	                    }
	                    $form.append('<input type="hidden" name="parentId" value="' + $('#parentId').val() + '">');
	                    var url = "${ctx}/manager/organization/saveBatch";
	                    $.post(url, $form.serialize(), function(result) {
	                        if (result.status) {
	                            $('#addBatchWin').window('close');
	                            $('#treegrid').datagrid('reload');
	                        } else {
	                            $.messager.alert({
	                                title: '消息',
	                                ok: '确定',
	                                msg: result.message
	                            });
	                        }
	                    }, 'json');
	                }
	            }
	        }
	    }
	    </script>
	    <!-- js -->
	    </jscript>
	</body>
</html>