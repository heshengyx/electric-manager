package com.grgbanking.electric.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoggerHandlerInterceptor implements HandlerInterceptor {

	/**
	 * ��������ʱ��ʼ��
	 */
	public void init() {
	}
	
	/**
	 * ����Controller����ǰִ��
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		return true;
	}

	/**
	 * ����Controller�����󣬷���ModelAndViewǰִ��
	 */
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

	}

	/**
	 * ִ����Controller������ִ��
	 */
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
	}
}
