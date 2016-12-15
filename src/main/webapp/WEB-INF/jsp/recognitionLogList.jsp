<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title>识别日志-数据收集平台</title>
    </head>
    
    <body>
	    <div data-options="region:'center',border:false">
		    <div class="tag-content">
		    <!-- search -->
		    <form class="data-form" id="searchForm" method="post">
		    <table>
		        <tr>
		        	<td class="td-right">用户名称：</td>
		            <td><input type="text" id="nameQuery" style="width:100px;"></td>
		            <td class="td-right">ip地址：</td>
                    <td>
                    <select class="easyui-combobox" id="ipaddrQuery" style="width:100px;"></select></td>
		            <td class="td-right">识别时间：</td>
		            <td>
		            <input class="easyui-datebox" type="text" id="createDateBeginQuery" value="${dateBegin}" style="width:100px;">~
		            <input class="easyui-datebox" type="text" id="createDateEndQuery" value="${dateEnd}" style="width:100px;"></td>
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
		        <a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-remove',plain:true" id="deleteBtn">删除</a>
		    </div>
		    <table id="datagrid" style="width:100%;"></table>
		    <!-- datagrid -->
		    </div>
		    <div id="win"></div>
	    </div>
	    <jscript>
	    <!-- js -->
	    <script type="text/javascript" src="${ctx}/js/format.js"></script>
	    <script type="text/javascript" src="${ctx}/js/common.js"></script>
	    <script type="text/javascript">
	    $(function() {
	        $('#datagrid').datagrid({
	            url: '${ctx}/manager/recognitionLog/query',
	            toolbar: '#tools',
	            idField: 'id',
	            queryParams: {
	            	createDateBegin: $('#createDateBeginQuery').datebox('getValue'),
	                createDateEnd: $('#createDateEndQuery').datebox('getValue')
	            },
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
	                {field: 'name', title: '用户姓名'},
	                {field: 'code', title: '用户编码'},
	                {field: 'seq', title: '手指序号'},
	                {field: 'threshold', title: '相识度'},
	                {field: 'indexed', title: '索引'},
	                {field: 'status', title: '状态', align: 'center', formatter:function(val, row, idx) {
	                	var content = '<img src="${ctx}/themes/extensions/bullet_cross.png" width="13">';
	                	if (val === '1') {
	                		content = '<img src="${ctx}/themes/extensions/bullet_tick.png" width="13">';
	                	}
	                    return content;
	                }},
	                {field: 'orgName', title: '部门名称', width: 100},
	                {field: 'ipaddr', title: 'ip地址'},
	                {field: 'createTime', title: '创建时间', formatter:function(val, row, idx) {
	                    return to_date_hms(val);
	                }},
	                {field: 'opt', title: '操作', formatter:function(val, row, idx) {
	                	var filePath = row.filePath;
	                	var content = '';
	                	if (filePath) {
	                		content += '<div style="text-align:center"><a href="javascript:void(0);" onclick="downloadFile(\'' + row.id + '\');">';
	                		content += '<img src="${ctx}/themes/extensions/package_down.png" width="13">';
	                		content += '</a></div>';
	                	}
	                    return content;
	                }}
	            ]]
	        });
	        
	        $('#searchBtn').click(function() {
	            $('#datagrid').datagrid('load', {
	                name: $('#nameQuery').val(),
	                ipaddr: $('#ipaddrQuery').combobox('getValue'),
	                createDateBegin: $('#createDateBeginQuery').datebox('getValue'),
	                createDateEnd: $('#createDateEndQuery').datebox('getValue')
	            });
	        });
	        
	        deleteRow('${ctx}/manager/recognitionLog/deleteBatch');
	        ipaddrs('ipaddrQuery');
	    });
	    function ipaddrs(fieldId) {
            var $fieldId = $('#' + fieldId);
            var url = "${ctx}/manager/recognitionLog/ipaddr?random="+ Math.random();
            var params = {};
            $.post(url, params, function(result) {
                try {
                	$fieldId.combobox({
                        data: result,
                        valueField: 'ipaddr',
                        textField: 'ipaddr'
                    });
                } catch(e){}
            }, 'json');
        }
	    function downloadFile(id) {
	    	if (id) {
	    		var url = "${ctx}/manager/recognitionLog/exists?random="+ Math.random();
	            var params = {id: id};
	            $.post(url, params, function(result) {
	            	if (result.status) {
	            		/* $('#win').window({});
	            		$('#win').window('refresh', '${ctx}/download.jsp');
	            		$('#win').window('close'); */
	                } else {
	                	$.messager.alert('消息', result.message, 'error');
	                }
	            }, 'json');
	    	}
	    }
	    </script>
	    <!-- js -->
	    </jscript>
    </body>
</html>