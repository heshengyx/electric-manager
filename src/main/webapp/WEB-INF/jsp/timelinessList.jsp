<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title>实时数据-数据收集平台</title>
    </head>
    
    <body>
	    <!-- content -->
	    <div style="padding:5px;">
	    	<div id="tabs" class="easyui-tabs" style="width:100%;">
			    <div title="瞬时数据" style="display:none;">
			    	<!-- search -->
				    <form class="data-form" id="searchForm" method="post">
				    <table>
				        <tr>
				            <td class="td-right">采样时间：</td>
				            <td>
				            <input class="easyui-datebox" type="text" id="createDateBeginQuery" style="width:100px;">~
				            <input class="easyui-datebox" type="text" id="createDateEndQuery" style="width:100px;">&nbsp;&nbsp;
				            <a class="easyui-linkbutton" id="searchBtn" href="javascript:void(0);" data-options="iconCls:'icon-search'">查询</a>&nbsp;
				            <a class="easyui-linkbutton" id="resetBtn" href="javascript:void(0);" data-options="iconCls:'icon-back'">重置</a>
				            </td>
				        </tr>
				    </table>
				    </form>
				    <!-- search -->
				    <div id="instantaneousTools">
				        <a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-calculator_edit',plain:true" id="addBtn">人工补采</a>
				        <a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-table_edit',plain:true" id="addBatchBtn">实时抄读</a>
				    </div>
			        <table id="instantaneousDatagrid" style="width:100%;height:auto;"></table>
			    </div>
			    <div title="曲线数据" style="overflow:auto;padding:20px;display:none;">
			        tab2
			    </div>
			    <div title="日冻结数据" style="overflow:auto;padding:20px;display:none;">
			        tab3
			    </div>
			    <div title="月冻结数据" style="overflow:auto;padding:20px;display:none;">
			        tab2
			    </div>
			    <div title="事件量" style="overflow:auto;padding:20px;display:none;">
			        tab2
			    </div>
			</div>
	    </div>
	    <!-- content -->
	    <jscript>
	    <script type="text/javascript" src="${ctx}/js/format.js"></script>
	    <!-- js -->
	    <script type="text/javascript">
	    $(function() {
	    	/* $(window).resize(function () {  
	            $('#tabs').tabs({  
	            	width: $('#tabs').parent().width(), 
		    		height: 'auto'  
	            });  
	        })
	    	$('#tabs').tabs({ 
	    		width: $('#tabs').parent().width(), 
	    		height: 'auto'
	    	}); */
	    	$('#instantaneousDatagrid').datagrid({
	    		url: '${ctx}/manager/instantaneous/query',
                toolbar: '#instantaneousTools',
                idField: "id",
                queryParams: {terminalId: '${param.id}'},
                fixed: true,
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
	    	    columns:[[
	    	        {field: 'terminalCode',title: '监测点编号'},
	    	        {field: 'sampleTime',title: '采样时间', formatter:function(val, row, idx) {
	                    return to_date_hms(val);
	                }},
	    	        {field: 'forwardHas',title: '当前正向有功',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	    	        {field: 'assembleNo',title: '当前组合无功',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	    	        {field: 'reverseHas',title: '当前反向有功',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	    	        {field: 'assembleReverseNo',title: '当前组合反向无功',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	    	        {field: 'assembleHas',title: '当前组合有功',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	    	        {field: 'degree',title: '当前总示度',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }}
	    	        /* {field: 'assembleHas',title: '当前总有功功率',align: 'right'},
	    	        {field: 'assembleHas',title: '当前A相有功功率',align: 'right'},
	    	        {field: 'assembleHas',title: '当前B相有功功率',align: 'right'},
	    	        {field: 'assembleHas',title: '当前C相有功功率',align: 'right'},
	    	        {field: 'assembleHas',title: '当前总无功功率',align: 'right'},
	    	        {field: 'assembleHas',title: '当前总无功功率',align: 'right'},
	    	        {field: 'assembleHas',title: '当前A相无功功率',align: 'right'},
	    	        {field: 'assembleHas',title: '当前B相无功功率',align: 'right'},
	    	        {field: 'assembleHas',title: '当前C相无功功率',align: 'right'} */
	    	    ]]
	    	});
	    });
	    </script>
	    <!-- js -->
	    </jscript>
    </body>
</html>