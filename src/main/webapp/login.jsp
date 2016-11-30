<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>登录-数据收集平台</title>
		<link rel="stylesheet" type="text/css" href="${ctx}/themes/default/easyui.css" />
	</head>
	
	<body>
		<div id="loginWin" class="easyui-window" title="登录" style="width:350px;height:188px;padding:5px;"
   			minimizable="false" maximizable="false" resizable="false" collapsible="false">
	    	<div class="easyui-layout" fit="true">
	            <div region="center" border="false" style="padding:5px;background:#fff;border:1px solid #ccc;">
			        <form id="loginForm" method="post" action="${ctx}/manager/login">
			            <div style="padding:5px 0;">
			                <label for="account">帐号:</label>
			                <input type="text" name="account" id="account" style="width:260px;"></input>
			            </div>
			            <div style="padding:5px 0;">
			                <label for="password">密码:</label>
			                <input type="password" name="password" id="password" style="width:260px;"></input>
			            </div>
			             <div style="padding:5px 0;text-align: center;color: red;" id="showMsg"></div>
			        </form>
	            </div>
	            <div region="south" border="false" style="text-align:right;padding:5px 0;">
	                <a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" id="loginBtn">登录</a>
	                <a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" id="resetBtn">重置</a>
	            </div>
			</div>
		</div>
	</body>
	<!-- js -->
	<script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery.easyui.min.js"></script>
	<script type="text/javascript">
	$(function() {
		document.onkeydown = function(e){
		    var event = e || window.event;  
		    var code = event.keyCode || event.which || event.charCode;
		    if (code == 13) {
		        login();
		    }
		}
	    $('#account').focus();
	    $('#loginBtn').click(function() {
	    	login();
	    });
	    $('#resetBtn').click(function() {
	    	$('#loginForm').form('clear');
	    });
	});
	function login() {
		if($('#account').val() == "" || $('#password').val() == ""){
            $('#showMsg').html("用户名或密码为空，请输入");
            $('#account').focus();
        } else {
        	var $form = $('#loginForm');
        	$.post($form.attr('action'), $form.serialize(), function(result) {
		    	if (result.status) {
		    	  	window.location.href = '${ctx}/manager';
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
	</script>
	<!-- js -->
</html>