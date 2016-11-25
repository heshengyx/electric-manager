package com.grgbanking.electric.controller;

import java.util.Arrays;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.grgbanking.electric.entity.Organization;
import com.grgbanking.electric.entity.User;
import com.grgbanking.electric.json.JSONMessage;
import com.grgbanking.electric.param.OrganizationQueryParam;
import com.grgbanking.electric.service.IOrganizationService;
import com.grgbanking.electric.tree.Tree;

@Controller
@RequestMapping("/manager/organization")
public class OrganizationController extends BaseController {
	
	private final static Logger LOGGER = LoggerFactory
			.getLogger(OrganizationController.class);

	@Autowired
	private IOrganizationService organizationService;
	
	@RequestMapping("")
	public String page() {
		return "organization";
	}
	
	@RequestMapping("/query")
	public String query() {
		return "organizationList";
	}
	
	@RequestMapping("/queryData")
	@ResponseBody
	public Object queryData(OrganizationQueryParam param) {
		return organizationService.query(param);
	}
	
	@RequestMapping("/saveOrUpdate")
	@ResponseBody
	public Object saveOrUpdate(Organization organization) {
		User user = getCurrentUser();
		JSONMessage jMessage = new JSONMessage();
		try {
			organization.setCreateBy(user.getAccount());
			organization.setUpdateBy(user.getAccount());
			organizationService.saveOrUpdate(organization);
			jMessage.setStatus(Boolean.TRUE);
		} catch (Exception e) {
			LOGGER.error("保存数据失败", e);
			jMessage.setStatus(Boolean.FALSE);
			if (e instanceof DataAccessResourceFailureException) {
				jMessage.setMessage(e.getMessage());
			} else {
				jMessage.setMessage("系统异常");
			}
		}
		return jMessage;
	}
	
	@RequestMapping("/deleteBatch")
	@ResponseBody
	public Object deleteBatch(String ids) {
		JSONMessage jMessage = new JSONMessage();
		try {
			organizationService.deleteByIds(Arrays.asList(StringUtils
					.commaDelimitedListToStringArray(ids)));
			jMessage.setStatus(Boolean.TRUE);
		} catch (Exception e) {
			LOGGER.error("删除数据失败", e);
			jMessage.setStatus(Boolean.FALSE);
			if (e instanceof DataAccessResourceFailureException) {
				jMessage.setMessage(e.getMessage());
			} else {
				jMessage.setMessage("系统异常");
			}
		}
		return jMessage;
	}
	
	@RequestMapping("/getById")
	@ResponseBody
	public Object getById(String id) {
		JSONMessage jMessage = new JSONMessage();
		try {
			Organization data = organizationService.getById(id);
			jMessage.setStatus(Boolean.TRUE);
			jMessage.setData(data);
		} catch (Exception e) {
			LOGGER.error("获取数据失败", e);
			jMessage.setStatus(Boolean.FALSE);
			if (e instanceof DataAccessResourceFailureException) {
				jMessage.setMessage(e.getMessage());
			} else {
				jMessage.setMessage("系统异常");
			}
		}
		return jMessage;
	}
	
	@RequestMapping("/tree")
	@ResponseBody
	public Object tree(OrganizationQueryParam param) {
		List<Tree> data = null;
		try {
			data = organizationService.tree(param);
		} catch (Exception e) {
			LOGGER.error("获取数据失败", e);
		}
		return data;
	}
}
