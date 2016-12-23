package com.grgbanking.electric.interceptor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.grgbanking.electric.entity.Terminal;
import com.grgbanking.electric.entity.User;
import com.grgbanking.electric.security.SecurityRealm;
import com.grgbanking.electric.service.ITerminalService;

/**
 * 终端拦截器
 * 
 * @author hsheng1
 *
 */
public class TerminalHandlerInterceptor implements HandlerInterceptor {

	private final static Logger LOGGER = LoggerFactory
			.getLogger(TerminalHandlerInterceptor.class);

	@Autowired
	private ITerminalService terminalService;

	/**
	 * 容器启动时初始化
	 */
	public void init() {
	}

	/**
	 * 进入Controller方法前执行
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		User user = (User) request.getSession().getAttribute(
				SecurityRealm.CURRENT_USER);
		if (!"1".equals(user.getAdmin())) {
			// 非管理员
			List<Terminal> terminals = terminalService.queryByUserId(user
					.getId());
			String terminalId = request.getParameter("id");
			boolean flag = checkTerminal(terminalId, terminals);
			if (!flag) {
				LOGGER.info("用户[{}]无权访问终端[id:{}]", user.getName(), terminalId);
				String ctx = request.getContextPath();
				request.getRequestDispatcher(ctx + "/unauthor.jsp").forward(request,
						response);
				return flag;
			}
		}
		return true;
	}

	/**
	 * 验证终端访问权限
	 * 
	 * @param terminalId
	 * @param terminals
	 * @return
	 */
	private boolean checkTerminal(String terminalId, List<Terminal> terminals) {
		if (!StringUtils.isEmpty(terminalId)
				&& !CollectionUtils.isEmpty(terminals)) {
			Map<String, String> terminalMap = new HashMap<String, String>();
			for (Terminal terminal : terminals) {
				terminalMap.put(terminal.getId(), terminal.getId());
			}
			if (null == terminalMap.get(terminalId)) {
				return false;
			}
		}
		return true;
	}

	/**
	 * 进入Controller方法后，返回ModelAndView前执行
	 */
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

	}

	/**
	 * 执行完Controller方法后执行
	 */
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

	}
}
