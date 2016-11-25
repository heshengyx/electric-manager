package com.grgbanking.electric.security;

import java.text.MessageFormat;
import java.util.List;

import org.apache.shiro.config.Ini;
import org.apache.shiro.config.Ini.Section;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import com.grgbanking.electric.entity.Permission;

/**
 * »®œﬁ∂¡»°
 * @author hsheng1
 *
 */
public class ChainDefinitionSectionMetaSource implements
		FactoryBean<Ini.Section> {

	private String filterChainDefinitions;

	public static final String PREMISSION_STRING = "perms[\"{0}\"]";

	public void setFilterChainDefinitions(String filterChainDefinitions) {
		this.filterChainDefinitions = filterChainDefinitions;
	}

	public Section getObject() throws Exception {
		List<Permission> permissions = null;

		Ini ini = new Ini();
		ini.load(filterChainDefinitions);
		Ini.Section section = ini.getSection(Ini.DEFAULT_SECTION_NAME);
		if (!CollectionUtils.isEmpty(permissions)) {
			for (Permission permission : permissions) {
				if (!(StringUtils.isEmpty(permission.getUrl()) && StringUtils
						.isEmpty(permission.getName()))) {
					section.put(
							permission.getUrl(),
							MessageFormat.format(PREMISSION_STRING,
									permission.getName()));
				}
			}
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
