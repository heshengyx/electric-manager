package com.grgbanking.electric.security;

import java.text.MessageFormat;
import java.util.List;
import java.util.Map;

import org.apache.shiro.config.Ini;
import org.apache.shiro.config.Ini.Section;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import com.grgbanking.electric.entity.Permission;
import com.grgbanking.electric.param.PermissionQueryParam;
import com.grgbanking.electric.service.IPermissionService;

/**
 * 
 * @author hsheng1
 *
 */
public class ChainDefinitionSectionMetaSource implements
		FactoryBean<Ini.Section> {

	public static final String PREMISSION_STRING = "perms[\"{0}\"]";
	
	@Autowired  
    private IPermissionService permissionService;
	private String filterChainDefinitions;
	private Map<String, String> authcs;

	public void setAuthcs(Map<String, String> authcs) {
		this.authcs = authcs;
	}

	public void setFilterChainDefinitions(String filterChainDefinitions) {
		this.filterChainDefinitions = filterChainDefinitions;
	}

	public Section getObject() throws Exception {
		PermissionQueryParam param = new PermissionQueryParam();
		List<Permission> permissions = permissionService.queryAll(param);

		Ini ini = new Ini();
		ini.load(filterChainDefinitions);
		Ini.Section section = ini.getSection(Ini.DEFAULT_SECTION_NAME);
		if (!CollectionUtils.isEmpty(permissions)) {
			for (Permission permission : permissions) {
				if (!(StringUtils.isEmpty(permission.getUrl()) && StringUtils
						.isEmpty(permission.getCode()))) {
					section.put(
							permission.getUrl(),
							MessageFormat.format(PREMISSION_STRING,
									permission.getCode()));
				}
			}
		}
		section.putAll(authcs);
		for (Map.Entry<String, String> entry : section.entrySet()) {
			System.out.println(entry.getKey() + "," + entry.getValue());
		}
		return section;
	}

	public Class<?> getObjectType() {
		return this.getClass();
	}

	public boolean isSingleton() {
		return false;
	}
}
