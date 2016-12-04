$(function() {
	
	//批量datagrid
	$('#addBatchDatagrid').datagrid({
        toolbar: '#addTools',
        onClickRow: onClickRow
    });
	
	//打开新增界面
	$('#addBtn').click(function() {
        $("#editWin").window({title:"新增"}).window("open").window("center");
    });
    
	//打开批量新增界面
    $('#addBatchBtn').click(function() {
    	removeAll();
        append();
        $("#addBatchWin").window({title:"批量新增"}).window("open").window("center");
    });
    
    //单个新增保存
    $('#saveBtn').click(function() {
        $.messager.progress();
        $('#editForm').submit();
    });
});

//取得选择行ID
function getRowIds(rows) {
	var ids = new Array();
	for(var i = 0; i < rows.length; i++){
		ids.push(rows[i].id);
	}
	return ids.join(",");
}

//提交保存
function submitForm(url) {
	$('#editForm').form({
        url: url,
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
                    $('#datagrid').datagrid('reload');
                    $('#editForm').form('reset');
                });
            } else {
                $.messager.alert('消息', result.message, 'error');
            }
        }
    });
}

//删除选择行
function deleteRow(url) {
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
                        var params = {
                            ids: getRowIds(rows)    
                        };
                        $.post(url, params, function(result) {
                            $.messager.progress('close');
                            if (result.status) {
                                $.messager.alert('消息', '删除成功', 'info');  
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
}
var editIndex = undefined;
//行编辑
function endEditing() {
    if (editIndex == undefined){return true}
    if ($('#addBatchDatagrid').datagrid('validateRow', editIndex)) {
        /* var ed = $('#addBatchDatagrid').datagrid('getEditor', {index:editIndex,field:'productid'});
        var productname = $(ed.target).combobox('getText');
        $('#addBatchDatagrid').datagrid('getRows')[editIndex]['productname'] = productname; */
        $('#addBatchDatagrid').datagrid('endEdit', editIndex);
        editIndex = undefined;
        return true;
    } else {
        return false;
    }
}
//行新增
function append() {
    if (endEditing()) {
        $('#addBatchDatagrid').datagrid('appendRow', {});
        editIndex = $('#addBatchDatagrid').datagrid('getRows').length-1;
        $('#addBatchDatagrid').datagrid('selectRow', editIndex)
                .datagrid('beginEdit', editIndex);
    }
}
//行删除
function removeit() {
    if (editIndex == undefined){return;}
    $('#addBatchDatagrid').datagrid('cancelEdit', editIndex)
            .datagrid('deleteRow', editIndex);
    editIndex = undefined;
}
//行删除全部
function removeAll() {
	var item = $('#addBatchDatagrid').datagrid('getRows');
	if (item) {
		for (var i = item.length - 1; i >= 0; i--) {
			var index = $('#addBatchDatagrid').datagrid('getRowIndex', item[i]);
			$('#addBatchDatagrid').datagrid('deleteRow', index);
		}
	}
}
//行单击事件
function onClickRow(index){
    if (editIndex != index){
        if (endEditing()){
            $('#addBatchDatagrid').datagrid('selectRow', index)
                    .datagrid('beginEdit', index);
            editIndex = index;
        } else {
            $('#addBatchDatagrid').datagrid('selectRow', editIndex);
        }
    }
}