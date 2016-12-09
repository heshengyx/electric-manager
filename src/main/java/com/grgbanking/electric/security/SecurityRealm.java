package com.grgbanking.electric.security;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import com.grgbanking.electric.entity.Permission;
import com.grgbanking.electric.entity.User;
import com.grgbanking.electric.param.PermissionQueryParam;
import com.grgbanking.electric.service.IPermissionService;
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
	public static final String CURRENT_USER = "currentUser";

	@Autowired
	private IUserService userService;

	@Autowired
	private IPermissionService permissionService;

	/**
	 * 授权
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(
			PrincipalCollection principal) {
		SimpleAuthorizationInfo simpleAuthorInfo = new SimpleAuthorizationInfo();
		User user = (User) super.getAvailablePrincipal(principal);
		// List<String> roleList = new ArrayList<String>();
		List<String> permissionList = new ArrayList<String>();

		if (null != user) {
			List<Permission> permissions = null;
			PermissionQueryParam param = new PermissionQueryParam();
			if ("1".equals(user.getAdmin())) {
				//管理员
				permissions = permissionService.queryAll(param);
			} else {
				//非管理员
				param.setUserId(user.getId());
				permissions = permissionService
						.queryPermissions(param);
			}
			
			if (!CollectionUtils.isEmpty(permissions)) {
				for (Permission permission : permissions) {
					if (!StringUtils.isEmpty(permission.getCode())
							&& !StringUtils.isEmpty(permission.getUrl())) {
						permissionList.add(permission.getCode());
					}
				}
				// simpleAuthorInfo.addRoles(roleList);
				simpleAuthorInfo.addStringPermissions(permissionList);
			}
		}
		return simpleAuthorInfo;
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
		User user = new User();
		user.setAccount(token.getUsername());
		user = userService.getData(user);
		if (null != user) {
			String password = String.valueOf(token.getPassword());
			if (user.getPassword().equals(password)) {
				authcInfo = new SimpleAuthenticationInfo(user,
						user.getPassword(), token.getUsername());
				this.setSession(CURRENT_USER, user);
			}
		}
		return authcInfo;
	}

	/**
	 * 设置session
	 * 
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
