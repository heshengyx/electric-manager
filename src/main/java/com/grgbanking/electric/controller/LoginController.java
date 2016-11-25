package com.grgbanking.electric.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.grgbanking.electric.entity.User;
import com.grgbanking.electric.json.JSONMessage;

@Controller
@RequestMapping("/manager")
public class LoginController {

	private final static Logger LOGGER = LoggerFactory
			.getLogger(LoginController.class);
	
	@RequestMapping("/login")
	@ResponseBody
	public Object login(User user) {
		JSONMessage jMessage = new JSONMessage();
		String account = user.getAccount();
		UsernamePasswordToken token = new UsernamePasswordToken(
				account, user.getPassword());
		Subject subject = SecurityUtils.getSubject();
		try {
			// token.setRememberMe(true);
			subject.login(token);
			jMessage.setStatus(Boolean.TRUE);
			LOGGER.info("[{}]登录成功", new Object[]{account});
		} catch (Exception e) {
			LOGGER.error("[{}]登录失败", new Object[]{account}, e);
			jMessage.setStatus(Boolean.FALSE);
			if (e instanceof DataAccessResourceFailureException) {
				jMessage.setMessage(e.getMessage());
			} else if (e instanceof UnknownAccountException) {
				jMessage.setMessage("账号或密码错误");
			} else {
				jMessage.setMessage("系统异常");
			}
		}
		return jMessage;
	}
}
