package com.grgbanking.electric.test;

import java.util.Arrays;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

import com.grgbanking.electric.entity.Organization;
import com.grgbanking.electric.page.IPage;
import com.grgbanking.electric.param.OrganizationQueryParam;
import com.grgbanking.electric.service.IOrganizationService;
import com.grgbanking.electric.service.IUserService;

public class JunitTest extends BaseJunitTest {

	@Autowired
	private IUserService userService;
	
	@Autowired
	private IOrganizationService organizationService;
	
	@Test
	public void testUser() {
		OrganizationQueryParam param = new OrganizationQueryParam();
		IPage<Organization> page = organizationService.query(param);
		System.out.println(page);
	}
	
	public static void main(String[] args) {
		String ids = "1,2";
		List<String> list = Arrays.asList(StringUtils
				.commaDelimitedListToStringArray(ids));
		for (String s : list) {
			System.out.println(s);
		}
	}
}
