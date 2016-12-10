<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title>采集任务-数据收集平台</title>
    </head>
    
    <body>
	    <div data-options="region:'center',border:false">
		    <div style="padding:5px;">
		    	<div id="tabs" class="easyui-tabs" style="width:100%;">
				    <div title="瞬时数据" style="padding:20px;display:none;">
				    	<h4>瞬时数据任务配置</h4>
				    </div>
				    <div title="曲线数据" style="overflow:auto;padding:20px;display:none;">
				    	<h4>曲线数据任务配置</h4>
				    </div>
				    <div title="日冻结数据" style="overflow:auto;padding:20px;display:none;">
				    	<h4>日冻结数据任务配置</h4>
				    </div>
				    <div title="月冻结数据" style="overflow:auto;padding:20px;display:none;">
				    	<h4>月冻结数据任务配置</h4>
				    </div>
				    <div title="事件量" style="overflow:auto;padding:20px;display:none;">
				    	<h4>事件量任务配置</h4>
				    </div>
				</div>
		    </div>
	    </div>
	    <jscript>
	    <!-- js -->
	    <script type="text/javascript">
	    $(function() {
	    });
	    </script>
	    <!-- js -->
	    </jscript>
    </body>
</html>