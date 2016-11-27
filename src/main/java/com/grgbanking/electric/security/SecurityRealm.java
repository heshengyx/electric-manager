package com.grgbanking.electric.security;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.stereotype.Component;

import com.grgbanking.electric.entity.User;
import com.grgbanking.electric.service.IUserService;

/**
 * 认证授权
 * 
 * @author hsheng1
 *
 */
@Component("securityRealm")
public class SecurityRealm extends AuthorizingRealm {

	private static final Logger LOGGER = LoggerFactory
			.getLogger(SecurityRealm.class);
	
	@Autowired
	private IUserService userService;

	/**
	 * 授权
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(
			PrincipalCollection principal) {
		return null;
	}

	/**
	 * 认证
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken authcToken) throws AuthenticationException {
		AuthenticationInfo authcInfo = null;
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
		LOGGER.info("login token:{}", ReflectionToStringBuilder.toString(token,
				ToStringStyle.MULTI_LINE_STYLE));
		User user = userService.getUserByAccount(token.getUsername());
		if (null != user) {
			String password = String.valueOf(token.getPassword());
			if (user.getPassword().equals(password)) {
				authcInfo = new SimpleAuthenticationInfo(user, user.getPassword(),
						token.getUsername());
				this.setSession("currentUser", user);
			}
		}
		return authcInfo;
	}

	/**
	 * 设置session
	 * @param key
	 * @param value
	 */
	private void setSession(Object key, Object value) {
		Subject currentUser = SecurityUtils.getSubject();
		if (null != currentUser) {
			Session session = currentUser.getSession();
			LOGGER.info("Session getTimeout:[{}]", session.getTimeout());
			if (null != session) {
				session.setAttribute(key, value);
			}
		}
	}
}