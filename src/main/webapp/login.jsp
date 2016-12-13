<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title>登录-数据收集平台</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link rel="stylesheet" type="text/css" href="${ctx}/css/login.css" />
    </head>
    <body>
        <div class="wrapper">
            <br/><br/>
            <h1 style="text-align:center">数据收集平台</h1>
            <br/><br/>
            <div class="content">
                <div id="form_wrapper" class="form_wrapper">
                    <form class="login active" id="loginForm" method="post" action="${ctx}/manager/login">
                        <h3>用户登录</h3>
                        <div>
                            <label>账号:</label>
                            <input type="text" name="account" id="account" />
                            <!-- <span class="error">This is an error</span> -->
                        </div>
                        <div>
                            <label>密码: </label>
                            <input type="password" name="password" id="password" />
                            <span class="error" id="showMsg"></span>
                        </div>
                        <div class="bottom">
                            <div class="remember"><input type="checkbox" /><span>记住我</span></div>
                            <input type="button" value="登录" id="loginBtn"></input>
                            <div class="clear"></div>
                        </div>
                    </form>
                </div>
                <div class="clear"></div>
            </div>
        </div>
        
        <!-- The JavaScript -->
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
	        /* $('#resetBtn').click(function() {
	            $('#loginForm').form('clear');
	        }); */
	    });
	    function login() {
	    	$('#showMsg').html("");
	    	if($('#account').val() == "") {
	    		$('#account').focus();
	    	} else if($('#password').val() == "") {
	            $('#password').focus();
	        } else {
	            var $form = $('#loginForm');
	            $.post($form.attr('action'), $form.serialize(), function(result) {
	                if (result.status) {
	                    window.location.href = '${ctx}/manager';
	                } else {
	                    /* $.messager.alert({
	                        title: '消息',
	                        ok: '确定',
	                        msg: result.message
	                    }); */
	                    $('#account').focus();
	                	$('#showMsg').html("账号或密码错误");
	                }
	            }, 'json');
	        }
	    }
	    </script>
	    <!-- js -->
    </body>
</html>