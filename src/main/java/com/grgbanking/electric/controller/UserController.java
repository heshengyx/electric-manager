package com.grgbanking.electric.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/manager/user")
public class UserController {

	@RequestMapping("")
	public String page() {
		return "user";
	}
}
