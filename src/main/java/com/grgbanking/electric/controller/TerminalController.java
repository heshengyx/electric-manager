package com.grgbanking.electric.controller;

import java.util.Arrays;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.grgbanking.electric.data.TerminalData;
import com.grgbanking.electric.entity.Terminal;
import com.grgbanking.electric.entity.User;
import com.grgbanking.electric.json.JSONMessage;
import com.grgbanking.electric.param.TerminalQueryParam;
import com.grgbanking.electric.service.ITerminalService;

@Controller
@RequestMapping("/manager/terminal")
public class TerminalController extends BaseController {

	private final static Logger LOGGER = LoggerFactory
			.getLogger(TerminalController.class);

	@Autowired
	private ITerminalService terminalService;

	@RequestMapping("")
	public String page() {
		return "terminal";
	}

	@RequestMapping("/list")
	public String list() {
		return "terminalList";
	}

	@RequestMapping("/query")
	@ResponseBody
	public Object query(TerminalQueryParam param) {
		return terminalService.query(param);
	}
	
	@RequestMapping("/queryData")
	@ResponseBody
	public Object queryData(TerminalQueryParam param) {
		return terminalService.queryData(param);
	}

	@RequestMapping("/saveOrUpdate")
	@ResponseBody
	public Object saveOrUpdate(Terminal Terminal) {
		User user = getCurrentUser();
		JSONMessage jMessage = new JSONMessage();
		try {
			Terminal.setCreateBy(user.getAccount());
			Terminal.setUpdateBy(user.getAccount());
			terminalService.saveOrUpdate(Terminal);
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

	@RequestMapping("/saveBatch")
	@ResponseBody
	public Object saveBatch(TerminalData data) {
		User user = getCurrentUser();
		JSONMessage jMessage = new JSONMessage();
		try {
			data.setCreateBy(user.getAccount());
			terminalService.saveBatchData(data);
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

	@RequestMapping("/deleteByIds")
	@ResponseBody
	public Object deleteByIds(String ids) {
		JSONMessage jMessage = new JSONMessage();
		try {
			terminalService.deleteByIds(Arrays.asList(StringUtils
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
			Terminal data = terminalService.getById(id);
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
	
	@RequestMapping("/updateByIds")
	@ResponseBody
	public Object updateByIds(Terminal terminal, String[] id) {
		User user = getCurrentUser();
		JSONMessage jMessage = new JSONMessage();
		try {
			terminal.setUpdateBy(user.getAccount());
			terminalService.updateByIds(terminal, id);
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
}
