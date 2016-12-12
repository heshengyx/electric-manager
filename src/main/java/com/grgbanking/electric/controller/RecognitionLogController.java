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

import com.grgbanking.electric.data.RecognitionLogData;
import com.grgbanking.electric.entity.RecognitionLog;
import com.grgbanking.electric.entity.User;
import com.grgbanking.electric.json.JSONMessage;
import com.grgbanking.electric.param.RecognitionLogQueryParam;
import com.grgbanking.electric.service.IRecognitionLogService;


@Controller
@RequestMapping("/manager/recognitionLog")
public class RecognitionLogController extends BaseController {
    
    private final static Logger LOGGER = LoggerFactory
            .getLogger(RecognitionLogController.class);

    @Autowired
    private IRecognitionLogService recognitionLogService;
    
    @RequestMapping("")
    public String page() {
        return "recognitionLog";
    }
    
    @RequestMapping("/list")
    public String list() {
        return "recognitionLogList";
    }
    
    @RequestMapping("/query")
    @ResponseBody
    public Object query(RecognitionLogQueryParam param) {
        return recognitionLogService.query(param);
    }
    
    @RequestMapping("/queryAll")
    @ResponseBody
    public Object queryAll(RecognitionLogQueryParam param) {
        return recognitionLogService.queryAll(param);
    }
    
    @RequestMapping("/ipaddr")
    @ResponseBody
    public Object ipaddr() {
        return recognitionLogService.queryIpaddr();
    }
    
    
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public Object saveOrUpdate(RecognitionLog RecognitionLog) {
        User user = getCurrentUser();
        JSONMessage jMessage = new JSONMessage();
        try {
            RecognitionLog.setCreateBy(user.getAccount());
            RecognitionLog.setUpdateBy(user.getAccount());
            recognitionLogService.saveOrUpdate(RecognitionLog);
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
    public Object saveBatch(RecognitionLogData data) {
        JSONMessage jMessage = new JSONMessage();
        try {
            recognitionLogService.saveBatchData(data);
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
            recognitionLogService.deleteByIds(Arrays.asList(StringUtils
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
            RecognitionLog data = recognitionLogService.getById(id);
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
}
