<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title>用户管理-数据收集平台</title>
    </head>
    
    <body>
	    <div data-options="region:'center',border:false">
		    <div class="tag-content">
		    <!-- search -->
		    <form class="data-form" id="searchForm" method="post">
		    <table>
		        <tr>
		        	<td class="td-right">用户名称：</td>
		            <td><input type="text" id="nameQuery" style="width:150px;"></td>
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
            <div id="tools">
                <a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-add',plain:true" id="addBtn">新增</a>
                <a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-remove',plain:true" id="deleteBtn">删除</a>
                <a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-control_add_blue',plain:true" id="addBatchBtn">批量</a>
                <a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-user_key',plain:true" id="assigneBtn">分配角色</a>
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
		        <table class="table">
		            <tr>
					    <td align="right">用户名称：</td>
					    <td>
					    <input class="easyui-validatebox" type="text" name="name" id="nameEdit" style="width:150px;" data-options="required:true"></td>
					</tr>
					<tr>
					    <td align="right">用户编码：</td>
					    <td>
					    <input class="easyui-validatebox" type="text" name="code" id="codeEdit" style="width:150px;" data-options="required:true"></td>
					</tr>
					<tr>
                        <td align="right">用户账号：</td>
                        <td>
                        <input class="easyui-validatebox" type="text" name="account" id="accountEdit" style="width:150px;" data-options="required:true"></td>
                    </tr>
                    <tr>
                        <td align="right">用户密码：</td>
                        <td>
                        <input class="easyui-validatebox" type="text" name="password" id="passwordEdit" style="width:150px;" data-options="required:true"></td>
                    </tr>
		            <tr>
		                <td></td>
		                <td><a class="easyui-linkbutton" id="saveBtn" href="#" data-options="iconCls:'icon-save'">保存</a></td>
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
		                style="width:350px;height:400px;">
		        <div id="tb" style="height:auto">
		            <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">添加行</a>
		            <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">删除行</a>
		            <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="saveBatch()">保存</a>
		        </div>
		        <table id="addBatchDatagrid" style="width:100%;">
		            <thead>
		                <tr>
		                    <th data-options="field:'name',editor:{type:'text'}">类别名称</th>
		                    <th data-options="field:'code',editor:{type:'text'}">类别编码</th>
		                </tr>
		            </thead>
		        </table>
		        <form id="addBatchForm" method="post"></form>
		    </div>
		    <!-- 批量 -->
		    <input type="hidden" id="selectedId">
		    <!-- 权限分配 -->
		    <div class="easyui-window" id="assigneWin" data-options="modal:true,closed:true,resizable:false,
		                minimizable:false,
		                maximizable:false,
		                draggable:true,
		                collapsible:false"
		                style="width:430px;height:350px;padding:5px;">
			    <div class="easyui-layout" fit="true">
		            <div region="center" border="false">
				        <div id="tabs" class="easyui-tabs" style="width:400px;height:260px;">
						    <div title="分配角色" style="padding-top:10px;">
						    	<ul id="roleTrees" style="margin-left:20px;"></ul>
						    </div>
						</div>
		            </div>
		            <div region="south" border="false" style="text-align:right;padding:5px 0;">
		            	<form id="addRoleBatchForm" method="post"></form>
		                <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" href="javascript:void(0)" id="saveRoleBtn">保存</a>
		            </div>
				</div>
		    </div>
		    <!-- 权限分配 -->
		    </div>
	    </div>
	    <jscript>
	    <!-- js -->
	    <script type="text/javascript" src="${ctx}/js/format.js"></script>
	    <script type="text/javascript" src="${ctx}/js/common.js"></script>
	    <script type="text/javascript">
	    $(function() {
	        $('#datagrid').datagrid({
	            url: '${ctx}/manager/user/query',
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
	                {field: 'name', title: '用户名称'},
	                {field: 'code', title: '用户编码'},
	                {field: 'createTime', title: '创建时间', formatter:function(val, row, idx) {
	                    return to_date_hms(val);
	                }},
	                {field: 'opts', title: '操作', formatter:function(val, row, idx) {
	                    return '<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:\'icon-edit\',plain:true" onclick="updateById(\'' + row.id + '\')">修改</a>';
	                }}
	            ]]
	        });
	        
	        $('#searchBtn').click(function() {
	            $('#datagrid').datagrid('load', {
	                name: $('#nameQuery').val(),
	                createDateBegin: $('#createDateBeginQuery').datebox('getValue'),
	                createDateEnd: $('#createDateEndQuery').datebox('getValue')
	            });
	        });
	        
	        submitForm('${ctx}/manager/user/saveOrUpdate');
	        deleteRow('${ctx}/manager/user/deleteBatch');
	        
	        $('#assigneBtn').click(function() {
	        	var rows = $('#datagrid').datagrid('getChecked');
	            if (!rows.length) {
	                $.messager.alert('消息', '请至少选择一条记录', 'error');
	            } else {
	            	$('#selectedId').val(rows[0].id);
	            	roleTrees(rows[0].id);
	            	$("#assigneWin").window({title:"分配角色"}).window("open").window("center");
	            }
	        });
	        
	        $('#saveRoleBtn').click(function() {
	        	var nodes = $('#roleTrees').tree('getChecked');
	        	var form = $('#addRoleBatchForm');
                form.children().remove();
                if (nodes) {
                	for (var i=0; i<nodes.length; i++) {
                        form.append('<input type="hidden" name="roleId" value="' + nodes[i].id + '">');
                    }
                	form.append('<input type="hidden" name="userId" value="' + $('#selectedId').val() + '">');
                	
                	var url = '${ctx}/manager/userRole/saveBatch';
                    $.post(url, form.serialize(), function(result) {
                        if (result.status) {
                        	$.messager.alert('消息', '保存成功', 'info');
                        } else {
                        	$.messager.alert('消息', result.message, 'error');
                        }
                    }, 'json');
                }
	        });
	    });
	    function updateById(id) {
	        $.messager.progress();
	        var url = "${ctx}/manager/role/getById"
	        var params = {id: id};
	        $.post(url, params, function(result) {
	            $.messager.progress('close');
	            if (result.status) {
	                $('#dataId').val(result.data.id);
	                $('#nameEdit').val(result.data.name);
	                $('#codeEdit').val(result.data.code);
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
	                    var form = $('#addBatchForm');
	                    form.children().remove();
	                    for (var i=0; i<inserted.length; i++) {
	                        form.append('<input type="hidden" name="name" value="' + inserted[i].name + '">');
	                        form.append('<input type="hidden" name="code" value="' + inserted[i].code + '">');
	                    }
	                    var url = '${ctx}/manager/user/saveBatch';
	                    $.post(url, form.serialize(), function(result) {
	                        if (result.status) {
	                            $('#addBatchWin').window('close');
	                            $('#datagrid').datagrid('reload');
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
	    function roleTrees(userId) {
	    	var url = '${ctx}/manager/role/tree';
	    	if (userId) {
	    		url += '?userId=' + userId;
	    	}
	    	
	    	$('#roleTrees').tree({
                url: url,
                lines: true,
                checkbox: true,
                onClick: function(node) {
                }
            });
	    }
	    </script>
	    <!-- js -->
	    </jscript>
    </body>
</html>