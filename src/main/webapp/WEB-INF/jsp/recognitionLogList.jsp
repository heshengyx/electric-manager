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
		        <a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-remove',plain:true" id="deleteBtn">删除</a>
		    </div>
		    <table id="datagrid" style="width:100%;"></table>
		    <!-- datagrid -->
		    </div>
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
	                {field: 'status', title: '状态'},
	                {field: 'orgName', title: '部门名称', width: 100},
	                {field: 'ipaddr', title: 'ip地址'},
	                {field: 'createTime', title: '创建时间', formatter:function(val, row, idx) {
	                    return to_date_hms(val);
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
	    </script>
	    <!-- js -->
	    </jscript>
    </body>
</html>