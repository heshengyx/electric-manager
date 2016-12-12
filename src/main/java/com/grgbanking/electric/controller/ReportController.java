package com.grgbanking.electric.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.grgbanking.electric.param.RecognitionLogQueryParam;
import com.grgbanking.electric.service.IRecognitionLogService;

@Controller
@RequestMapping("/manager/report")
public class ReportController extends BaseController {

	@Autowired
    private IRecognitionLogService recognitionLogService;
	
	@RequestMapping("/list")
    public String list() {
        return "reportList";
    }
	
	@RequestMapping("/query")
    @ResponseBody
    public Object query(RecognitionLogQueryParam param) {
        return recognitionLogService.queryReport(param);
    }
}
