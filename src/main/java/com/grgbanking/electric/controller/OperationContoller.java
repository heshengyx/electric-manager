package com.grgbanking.electric.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.grgbanking.electric.entity.User;
import com.grgbanking.electric.param.OrganizationQueryParam;
import com.grgbanking.electric.param.PermissionQueryParam;
import com.grgbanking.electric.param.RoleQueryParam;
import com.grgbanking.electric.service.ITreeService;
import com.grgbanking.electric.tree.Tree;

@Controller
@RequestMapping("/manager")
public class OperationContoller extends BaseController {

	private final static Logger LOGGER = LoggerFactory
			.getLogger(OperationContoller.class);
	
	@Autowired
	private ITreeService treeService;
	
	@RequestMapping("/organization/tree")
	@ResponseBody
	public Object tree(OrganizationQueryParam param) {
		User user = getCurrentUser();
		List<Tree> data = null;
		try {
			param.setUserId(user.getId());
			param.setAdmin(user.getAdmin());
			data = treeService.treeOrganization(param);
		} catch (Exception e) {
			LOGGER.error("获取数据失败", e);
		}
		return data;
	}
	
	@RequestMapping("/permission/tree")
	@ResponseBody
	public Object tree(PermissionQueryParam param) {
		List<Tree> data = null;
		try {
			data = treeService.treePermission(param);
		} catch (Exception e) {
			LOGGER.error("获取数据失败", e);
		}
		return data;
	}
	
	@RequestMapping("/role/tree")
	@ResponseBody
	public Object tree(RoleQueryParam param) {
		List<Tree> data = null;
		try {
			data = treeService.treeRole(param);
		} catch (Exception e) {
			LOGGER.error("获取数据失败", e);
		}
		return data;
	}
	
	@RequestMapping("/timeliness/list")
	public String timeliness() {
		return "timelinessList";
	}
	
	@RequestMapping("/associate/list")
	public String associate() {
		return "associateList";
	}
}
