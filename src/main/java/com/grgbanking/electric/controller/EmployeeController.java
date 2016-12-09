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

import com.grgbanking.electric.data.EmployeeData;
import com.grgbanking.electric.entity.Employee;
import com.grgbanking.electric.entity.User;
import com.grgbanking.electric.json.JSONMessage;
import com.grgbanking.electric.param.EmployeeQueryParam;
import com.grgbanking.electric.service.IEmployeeService;


@Controller
@RequestMapping("/manager/employee")
public class EmployeeController extends BaseController {
    
    private final static Logger LOGGER = LoggerFactory
            .getLogger(EmployeeController.class);

    @Autowired
    private IEmployeeService employeeService;
    
    @RequestMapping("")
    public String page() {
        return "employee";
    }
    
    @RequestMapping("/list")
    public String list() {
        return "employeeList";
    }
    
    @RequestMapping("/query")
    @ResponseBody
    public Object query(EmployeeQueryParam param) {
        return employeeService.query(param);
    }
    
    @RequestMapping("/queryAll")
    @ResponseBody
    public Object queryAll(EmployeeQueryParam param) {
        return employeeService.queryAll(param);
    }
    
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public Object saveOrUpdate(Employee Employee) {
        User user = getCurrentUser();
        JSONMessage jMessage = new JSONMessage();
        try {
            Employee.setCreateBy(user.getAccount());
            Employee.setUpdateBy(user.getAccount());
            employeeService.saveOrUpdate(Employee);
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
    public Object saveBatch(EmployeeData data) {
        User user = getCurrentUser();
        JSONMessage jMessage = new JSONMessage();
        try {
            data.setCreateBy(user.getAccount());
            employeeService.saveBatchData(data);
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
            employeeService.deleteByIds(Arrays.asList(StringUtils
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
            Employee data = employeeService.getById(id);
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
