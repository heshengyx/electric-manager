package com.grgbanking.electric.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/manager/timeliness")
public class TimelinessController extends BaseController {

	private final static Logger LOGGER = LoggerFactory
			.getLogger(TimelinessController.class);
	
	@RequestMapping("/list")
	public String page() {
		return "timelinessList";
	}
}
