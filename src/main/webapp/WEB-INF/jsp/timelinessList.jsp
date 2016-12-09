<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title>实时数据-数据收集平台</title>
    </head>
    
    <body>
	    <div data-options="region:'center',border:false">
		    <div style="padding:5px;">
		    	<div id="tabs" class="easyui-tabs" style="width:100%;">
				    <div title="瞬时数据" style="display:none;">
				    	<!-- search -->
					    <form class="data-form" id="instantaneousForm" method="post">
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
				    <div title="曲线数据" style="overflow:auto;display:none;">
				        <!-- search -->
					    <form class="data-form" id="curveForm" method="post">
					    <table>
					        <tr>
					            <td class="td-right">采样时间：</td>
					            <td>
					            <input class="easyui-datebox" type="text" id="createDateBeginQuery" style="width:100px;">~
					            <input class="easyui-datebox" type="text" id="createDateEndQuery" style="width:100px;">&nbsp;&nbsp;
					            <a class="easyui-linkbutton" id="searchCurveBtn" href="javascript:void(0);" data-options="iconCls:'icon-search'">查询</a>&nbsp;
					            <a class="easyui-linkbutton" id="resetCurveBtn" href="javascript:void(0);" data-options="iconCls:'icon-back'">重置</a>
					            </td>
					        </tr>
					    </table>
					    </form>
					    <!-- search -->
					    <div id="curveTools">
					        <a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-calculator_edit',plain:true" id="addCurveBtn">人工补采</a>
					        <a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-table_edit',plain:true" id="addCurveBatchBtn">实时抄读</a>
					    </div>
				        <table id="curveDatagrid" style="width:100%;height:auto;"></table>
				    </div>
				    <div title="日冻结数据" style="overflow:auto;display:none;">
				        <!-- search -->
					    <form class="data-form" id="freezeDayForm" method="post">
					    <table>
					        <tr>
					            <td class="td-right">采样时间：</td>
					            <td>
					            <input class="easyui-datebox" type="text" id="createDateBeginQuery" style="width:100px;">~
					            <input class="easyui-datebox" type="text" id="createDateEndQuery" style="width:100px;">&nbsp;&nbsp;
					            <a class="easyui-linkbutton" id="searchFreezeDayBtn" href="javascript:void(0);" data-options="iconCls:'icon-search'">查询</a>&nbsp;
					            <a class="easyui-linkbutton" id="resetFreezeDayBtn" href="javascript:void(0);" data-options="iconCls:'icon-back'">重置</a>
					            </td>
					        </tr>
					    </table>
					    </form>
					    <!-- search -->
					    <div id="freezeDayTools">
					        <a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-calculator_edit',plain:true" id="addFreezeDayBtn">人工补采</a>
					        <a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-table_edit',plain:true" id="addFreezeDayBatchBtn">实时抄读</a>
					    </div>
				        <table id="freezeDayDatagrid" style="width:100%;height:auto;"></table>
				    </div>
				    <div title="月冻结数据" style="overflow:auto;display:none;">
				        <!-- search -->
					    <form class="data-form" id="freezeMonthForm" method="post">
					    <table>
					        <tr>
					            <td class="td-right">采样时间：</td>
					            <td>
					            <input class="easyui-datebox" type="text" id="createDateBeginQuery" style="width:100px;">~
					            <input class="easyui-datebox" type="text" id="createDateEndQuery" style="width:100px;">&nbsp;&nbsp;
					            <a class="easyui-linkbutton" id="searchFreezeMonthBtn" href="javascript:void(0);" data-options="iconCls:'icon-search'">查询</a>&nbsp;
					            <a class="easyui-linkbutton" id="resetFreezeMonthBtn" href="javascript:void(0);" data-options="iconCls:'icon-back'">重置</a>
					            </td>
					        </tr>
					    </table>
					    </form>
					    <!-- search -->
					    <div id="freezeMonthTools">
					        <a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-calculator_edit',plain:true" id="addFreezeMonthBtn">人工补采</a>
					        <a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-table_edit',plain:true" id="addFreezeMonthBatchBtn">实时抄读</a>
					    </div>
				        <table id="freezeMonthDatagrid" style="width:100%;height:auto;"></table>
				    </div>
				    <div title="事件量" style="overflow:auto;display:none;">
				        <!-- search -->
					    <form class="data-form" id="eventForm" method="post">
					    <table>
					        <tr>
					            <td class="td-right">发生时间：</td>
					            <td>
					            <input class="easyui-datebox" type="text" id="createDateBeginQuery" style="width:100px;">~
					            <input class="easyui-datebox" type="text" id="createDateEndQuery" style="width:100px;">&nbsp;&nbsp;
					            <a class="easyui-linkbutton" id="searchEventBtn" href="javascript:void(0);" data-options="iconCls:'icon-search'">查询</a>&nbsp;
					            <a class="easyui-linkbutton" id="resetEventBtn" href="javascript:void(0);" data-options="iconCls:'icon-back'">重置</a>
					            </td>
					        </tr>
					    </table>
					    </form>
					    <!-- search -->
					    <div id="eventTools">
					        <a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-calculator_edit',plain:true" id="addEventBtn">人工补采</a>
					        <a class="easyui-linkbutton" href="javascript:void(0);" data-options="iconCls:'icon-table_edit',plain:true" id="addEventBatchBtn">实时抄读</a>
					    </div>
				        <table id="eventDatagrid" style="width:100%;height:auto;"></table>
				    </div>
				</div>
		    </div>
	    </div>
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
               	idField: 'id',
               	queryParams: {terminalId: '${param.id}'},
               	fixed: true,
               	autoRowHeight: true,
               	fitColumns: true,
               	striped: true,
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
	    	        {field: 'sampleTime',title: '采样时间', width: 200, formatter:function(val, row, idx) {
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
	    	
	    	$('#curveDatagrid').datagrid({
	    		url: '${ctx}/manager/curve/query',
               	toolbar: '#curveTools',
               	idField: 'id',
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
	    	        {field: 'sampleTime',title: '采样时间', width: 200, formatter:function(val, row, idx) {
	                    return to_date_hms(val);
	                }},
	    	        {field: 'assembleHas',title: '组合有功',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	    	        {field: 'assembleNo',title: '组合无功',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	    	        {field: 'totals',title: '总示值',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	    	        {field: 'forwardHas',title: '正向有功',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	    	        {field: 'forwardNo',title: '正向无功',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	    	        {field: 'reverseHas',title: '反向有功',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'reverseNo',title: '反向无功',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }}
	    	    ]]
	    	});
	    	
	    	$('#freezeDayDatagrid').datagrid({
	    		url: '${ctx}/manager/freezeDay/query',
               	toolbar: '#freezeDayTools',
               	idField: 'id',
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
	    	        {field: 'sampleTime',title: '采样时间', width: 200, formatter:function(val, row, idx) {
	                    return to_date_hms(val);
	                }},
	    	        {field: 'assembleTotals',title: '组合总示值',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	    	        {field: 'forwardHas',title: '正向有功',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	    	        {field: 'forwardNo',title: '正向无功',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	    	        {field: 'reverseHas',title: '反向有功',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	    	        {field: 'reverseNo',title: '反向无功',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	    	        {field: 'totals',title: '总电量',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'forwardHasDay',title: '日正向有功',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'forwardNoDay',title: '日正向无功',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'reverseHasDay',title: '日反向有功',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'reverseNoDay',title: '日反向无功',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'peakTotals',title: '峰电量',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'flatTotals',title: '谷电量',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'valleyTotals',title: '平电量',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'tipTotals',title: '尖电量',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'morningTotals',title: '早班电量',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'middayTotals',title: '中班电量',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'nightTotals',title: '晚班电量',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }}
	    	    ]]
	    	});
	    	
	    	$('#freezeMonthDatagrid').datagrid({
	    		url: '${ctx}/manager/freezeMonth/query',
               	toolbar: '#freezeMonthTools',
               	idField: 'id',
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
	    	        {field: 'sampleTime',title: '采样时间', width: 200, formatter:function(val, row, idx) {
	                    return to_date_hms(val);
	                }},
	    	        {field: 'assembleTotals',title: '组合总示值',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	    	        {field: 'forwardHas',title: '正向有功总电能',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	    	        {field: 'forwardNo',title: '正向无功总电能',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	    	        {field: 'reverseHas',title: '反向有功总电能',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	    	        {field: 'reverseNo',title: '反向无功总电能',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	    	        {field: 'totals',title: '总电量',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'forwardHasMonth',title: '正向有功总电量',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'forwardNoMonth',title: '正向无功总电量',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'reverseHasMonth',title: '反向有功总电量',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'reverseNoMonth',title: '反向无功总电量',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'peakTotals',title: '峰电量',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'flatTotals',title: '谷电量',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'valleyTotals',title: '平电量',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'tipTotals',title: '尖电量',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'morningTotals',title: '早班电量',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'middayTotals',title: '中班电量',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }},
	                {field: 'nightTotals',title: '晚班电量',align: 'right', formatter:function(val, row, idx) {
	                    return jmoney(val);
	                }}
	    	    ]]
	    	});
	    	
	    	$('#eventDatagrid').datagrid({
	    		url: '${ctx}/manager/event/query',
               	toolbar: '#eventTools',
               	idField: 'id',
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
	    	        {field: 'createTime',title: '发生时间', width: 200, formatter:function(val, row, idx) {
	                    return to_date_hms(val);
	                }},
	    	        {field: 'name',title: '事件名称'},
	    	        {field: 'code',title: '事件编号'},
	    	        {field: 'paramValue',title: '辅助参数值'},
	    	        {field: 'equipmentCode',title: '设备编号'},
	    	        {field: 'alarmCode',title: '告警编号'},
	    	        {field: 'accidentCode',title: '事故编号'},
	                {field: 'sampleType',title: '采样机制'},
	                {field: 'dealStatus',title: '处理状态'},
	                {field: 'accidentReason',title: '事故原因'}
	    	    ]]
	    	});
	    });
	    </script>
	    <!-- js -->
	    </jscript>
    </body>
</html>