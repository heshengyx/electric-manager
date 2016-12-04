package com.grgbanking.electric.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.grgbanking.electric.param.OrganizationQueryParam;
import com.grgbanking.electric.service.ITreeService;
import com.grgbanking.electric.tree.Tree;

@Controller
@RequestMapping("/manager/tree")
public class TreeController {

	private final static Logger LOGGER = LoggerFactory
			.getLogger(TreeController.class);
	
	@Autowired
	private ITreeService treeService;
	
	@RequestMapping("")
	@ResponseBody
	public Object tree(OrganizationQueryParam param) {
		List<Tree> data = null;
		try {
			data = treeService.tree(param);
		} catch (Exception e) {
			LOGGER.error("获取数据失败", e);
		}
		return data;
	}
}