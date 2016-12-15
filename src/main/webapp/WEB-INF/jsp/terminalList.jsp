<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title>终端管理-数据收集平台</title>
    </head>
    
    <body>
	    <div data-options="region:'center',border:false">
		    <div class="tag-content">
		    <!-- search -->
		    <form class="data-form" id="searchForm" method="post">
		    <table>
		        <tr>
		        	<td>终端名称：</td>
					<td><input type="text" id="nameQuery" style="width:150px;"></td>
					<td class="td-right">终端编码：</td>
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
		    <img src="${ctx}/themes/extensions/lightbulb.png" width="13">："在线"，<img src="${ctx}/themes/extensions/lightbulb_off.png" width="13">："断线"
		    <!-- search -->
		    <!-- datagrid -->
		    <div id="tools">
		        <a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-add',plain:true" id="addBtn">新增</a>
		        <a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-remove',plain:true" id="deleteBtn">删除</a>
		        <a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-control_add_blue',plain:true" id="addBatchBtn">批量</a>
		        <c:if test="${!empty param.orgId}">
		        <a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-computer_add',plain:true" id="appendBatchBtn">添加</a>
		        </c:if>
		    </div>
		    <table id="datagrid" style="width:100%;"></table>
		    <!-- datagrid -->
		    <!-- 新增 -->
		    <div class="easyui-window" id="editWin" data-options="modal:true,closed:true,resizable:false,
		                minimizable:false,
		                maximizable:false,
		                draggable:true,
		                collapsible:false"
		                style="width:330px;height:200px;padding:10px;">
		        <form id="editForm" method="post">
		        <input type="hidden" name='id' id="dataId">
		        <input type="hidden" name="orgId" id="orgId" value="${param.orgId}">
		        <table class="table">
		            <tr>
						<td align="right">终端名称：</td>
						<td>
						<input class="easyui-validatebox" type="text" name="name" id="nameEdit" style="width:150px;" data-options="required:true"></td>
					</tr>
					<tr>
						<td align="right">终端编号：</td>
						<td>
						<input class="easyui-validatebox" type="text" name="code" id="codeEdit" style="width:150px;" data-options="required:true"></td>
					</tr>
					<tr>
						<td align="right">终端类别：</td>
						<td>
						<select class="easyui-combobox" name="styleId" id="styleEdit" style="width:150px;">
							<option value="">请选择</option>
						</select></td>
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
		        <div id="addTools">
		            <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">添加行</a>
		            <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">删除行</a>
		            <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="saveBatch()">保存</a>
		        </div>
		        <table id="addBatchDatagrid" style="width:100%;">
		            <thead>
		                <tr>
		                    <th data-options="field:'name',editor:{type:'text'}">终端名称</th>
							<th data-options="field:'code',editor:{type:'text'}">终端编码</th>
		                </tr>
		            </thead>
		        </table>
		        <form id="addBatchForm" method="post"></form>
		    </div>
		    <!-- 批量 -->
		    <!-- 添加 -->
		    <div class="easyui-window" id="appendBatchWin" data-options="modal:true,closed:true,resizable:false,
		                minimizable:false,
		                maximizable:false,
		                draggable:true,
		                collapsible:false"
		                style="width:500px;height:350px;">
		        <div id="appendTools">
		            <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" id="saveAppendBtn">保存</a>
		        </div>
		        <div class="tag-content">
		        <!-- search -->
		        <form class="data-form" id="appendSearchForm" method="post">
			    <table>
			        <tr>
			        	<td>终端名称：</td>
						<td><input type="text" id="nameAppendQuery" style="width:150px;"></td>
						<td class="td-right">终端编码：</td>
						<td><input type="text" id="codeAppendQuery" style="width:100px;"></td>
			        </tr>
			        <tr>
			            <td></td>
			            <td colspan="5">
			            <a class="easyui-linkbutton" id="searchAppendBtn" href="javascript:void(0);" data-options="iconCls:'icon-search'">查询</a>&nbsp;
			            <a class="easyui-linkbutton" id="resetAppendBtn" href="javascript:void(0);" data-options="iconCls:'icon-back'">重置</a>
			            </td>
			        </tr>
			    </table>
			    </form>
			    <!-- search -->
			    <!-- datagrid -->
			    <form id="saveAppendForm" method="post">
			    <input type="hidden" name="orgId" value="${param.orgId}">
		        <table id="appendBatchDatagrid" style="width:100%;"></table>
		        </form>
		        <!-- datagrid -->
		        </div>
		    </div>
		    <!-- 添加 -->
		    </div>
	    </div>
	    <jscript>
	    <!-- js -->
	    <script type="text/javascript" src="${ctx}/js/format.js"></script>
	    <script type="text/javascript" src="${ctx}/js/common.js"></script>
	    <script type="text/javascript">
	    $(function() {
	        $('#datagrid').datagrid({
	            url: '${ctx}/manager/terminal/query',
	            toolbar: '#tools',
	            idField: 'id',
	            queryParams: {orgId: $('#orgId').val()},
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
	                {field: 'name', title: '终端名称'},
					{field: 'code', title: '终端编号', width: 300},
					{field: 'styleName', title: '终端类别'},
					{field: 'orgName', title: '所属机构'},
					{field: 'status', title: '状态', align: 'center', formatter:function(val, row, idx) {
	                	var content = '<img src="${ctx}/themes/extensions/lightbulb_off.png" width="13">';
	                	if (val === '1') {
	                		content = '<img src="${ctx}/themes/extensions/lightbulb.png" width="13">';
	                	}
	                    return content;
	                }},
	                {field: 'ipaddr', title: 'ip地址'},
	                {field: 'location', title: '备注'},
	                {field: 'heartbeat', title: '心跳时间', formatter:function(val, row, idx) {
	                    return to_date_hms(val);
	                }},
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
	                name: $('#nameQuery').val(),
					code: $('#codeQuery').val(),
	                createDateBegin: $('#createDateBeginQuery').datebox('getValue'),
	                createDateEnd: $('#createDateEndQuery').datebox('getValue')
	            });
	        });
	        
	        submitForm('${ctx}/manager/terminal/saveOrUpdate');
	        deleteRow('${ctx}/manager/terminal/deleteByIds');
	        styles('styleEdit');
	        
	        //添加datagrid
	    	/* $('#appendBatchDatagrid').datagrid({
	            toolbar: '#appendTools'
	        }); */
	      
	      	//打开添加界面
	        $('#appendBatchBtn').click(function() {
	        	$('#appendBatchDatagrid').datagrid({
	                url: '${ctx}/manager/terminal/queryData',
	                toolbar: '#appendTools',
	                idField: 'id',
	                autoRowHeight: true,
	                fixed: true,
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
	                    {field: 'name', title: '终端名称'},
	    				{field: 'code', title: '终端编号'},
	    				{field: 'styleName', title: '终端类别'}
	                ]]
	            });
	        	$("#appendBatchWin").window({title:"批量添加"}).window("open").window("center");
	        });
	        
	        $('#saveAppendBtn').click(function() {
	        	$.messager.progress();
	        	var url = "${ctx}/manager/terminal/updateByIds"
				$.post(url, $('#saveAppendForm').serialize(), function(result) {
					$.messager.progress('close');
	                if (result.status) {
	                	$('#appendBatchWin').window('close');
	                    $('#datagrid').datagrid('reload');
	                } else {
	                    $.messager.alert({
	                        title: '消息',
	                        ok: '确定',
	                        msg: result.message
	                    });
	                }
	            }, 'json');
	        });
	    });
	    function styles(fieldId) {
	    	/* $('#' + fieldId).combobox({
	    	    url: '${ctx}/manager/style/queryAll?random=' + Math.random(),
	    	    valueField: 'code',
	    	    textField: 'name'
	    	}); */
	    	var $fieldId = $('#' + fieldId);
	    	var url = "${ctx}/manager/style/queryAll?random="+ Math.random();
	        var params = {};
	        $.post(url, params, function(result) {
	        	result.unshift({  
	                'id': '0',  
	                'name': '--请选择--'
	            });//向json数组开头添加自定义数据
	        	try {
	        		$('#' + fieldId).combobox({
	        			data: result,
	            	    valueField: 'id',
	            	    textField: 'name',
	            	    onLoadSuccess: function () { //加载完成后,设置选中第一项  
	                        var val = $(this).combobox('getData');  
	                        for (var item in val[0]) {  
	                            if (item == 'id') {  
	                                $(this).combobox('select', val[0][item]);  
	                            }  
	                        }
	                    } 
	            	});
	        	} catch(e){}
	        }, 'json');
	    }
	    function updateById(id) {
	        $.messager.progress();
	        var url = "${ctx}/manager/terminal/getById?random="+ Math.random();
	        var params = {id: id};
	        $.post(url, params, function(result) {
	            $.messager.progress('close');
	            if (result.status) {
	                $('#dataId').val(result.data.id);
	                $('#nameEdit').val(result.data.name);
					$('#codeEdit').val(result.data.code);
					$('#styleEdit').combobox('setValue', result.data.styleId);
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
	                    var url = "${ctx}/manager/terminal/saveBatch"
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
	    </script>
	    <!-- js -->
	    </jscript>
    </body>
</html>