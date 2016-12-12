<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title>识别报表-数据收集平台</title>
        <style type="text/css">
        .charts {
        	list-style:none; /* 去掉ul前面的符号 */
		    margin: 0px; /* 与外界元素的距离为0 */
		    padding: 0px; /* 与内部元素的距离为0 */
		    width: auto; /* 宽度根据元素内容调整 */
        }
        .charts li {
        	float: left; /* 向左漂移，将竖排变为横排 */
        }
        </style>
    </head>
    
    <body>
	    <div data-options="region:'center',border:false">
		    <div class="tag-content">
		    <!-- search -->
		    <form class="data-form" id="searchForm" method="post">
		    <table>
		        <tr>
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
		    <table id="datagrid" style="width:100%;"></table>
		    <!-- datagrid -->
		    
		    <div id="reports"><ul class="charts"></ul></div>
		    </div>
	    </div>
	    <jscript>
	    <!-- js -->
	    <script type="text/javascript" src="${ctx}/plugins/echarts.min.js"></script>
	    <script type="text/javascript" src="${ctx}/js/mapper.js"></script>
	    <script type="text/javascript">
	    $(function() {
	        $('#datagrid').datagrid({
	            url: '${ctx}/manager/report/query',
	            autoRowHeight: true,
	            fixed: true,
	            fitColumns: true,
	            showFooter: true,
	            singleSelect: false,
	            rownumbers: true,
	            selectOnCheck: true,
	            checkOnSelect: true,
	            frozenColumns: [[    
                    {field: 'ipaddr', title: 'ip地址', align: 'right', width: 100}    
                ]],
	            columns: [[
					{title: '识别指静脉', colspan: 3},
					{title: '识别密码', colspan: 3}
				],[
	                {field: 'recSuccTotal', title: '成功'},
	                {field: 'recFailTotal', title: '失败'},
	                {field: 'recTotal', title: '合计', formatter:function(val, row, idx) {
	                    return row.recSuccTotal + row.recFailTotal;
	                }},
	                {field: 'pwdSuccTotal', title: '成功'},
	                {field: 'pwdFailTotal', title: '失败'},
	                {field: 'pwdTotal', title: '合计', formatter:function(val, row, idx) {
	                    return row.pwdSuccTotal + row.pwdFailTotal;
	                }}
	            ]],
	            onLoadSuccess: function(index, field, value) {
	            	reports();
	            }
	        });
	        
	        $('#searchBtn').click(function() {
	            $('#datagrid').datagrid('load', {
	                ipaddr: $('#ipaddrQuery').combobox('getValue'),
	                createDateBegin: $('#createDateBeginQuery').datebox('getValue'),
	                createDateEnd: $('#createDateEndQuery').datebox('getValue')
	            });
	            reports();
	        });
	        
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
	    function reports() {
	    	var data = $('#datagrid').datagrid('getData');
	    	if (data && data.rows) {
	    		var $ul = $('#reports ul');
		    	$ul.children().remove();
		    	for (var i=0; i<data.rows.length; i++) {
	    			var $li = $('<li id="chart' + i + '" style="width: 350px;height:250px;"></li>');
	    			$ul.append($li);
	    		}
	    		
	    		for (var i=0; i<data.rows.length; i++) {
	    			var myChart = echarts.init(document.getElementById('chart' + i));

	    	        // 指定图表的配置项和数据
	    	        var option = {
	    	            title: {
	    	                text: data.rows[i].ipaddr,
	    	                x: 'center'
	    	            },
	    	            tooltip : {
	    	                trigger: 'item',
	    	                formatter: "{b} : {c} ({d}%)"
	    	            },
	    	            series : [
	   	                    {
   	                          	name: '访问来源',
   	                          	type: 'pie',
   	                          	radius: '55%',
   	                         	center: ['50%', '50%'],
   	                          	data: [
   	                                {value:data.rows[i].recSuccTotal, name:'指静脉成功'},
   	                             	{value:data.rows[i].recFailTotal, name:'指静脉失败'},
   	                             	{value:data.rows[i].pwdSuccTotal, name:'密码成功'},
   	                             	{value:data.rows[i].pwdFailTotal, name:'密码失败'}
   	                         	]
	   	                    }
	    	        	]
	    	        };
	    	        // 使用刚指定的配置项和数据显示图表。
	    	        myChart.setOption(option); 
	    		}
	    	}
	    }
	    </script>
	    <!-- js -->
	    </jscript>
    </body>
</html>