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

import com.grgbanking.electric.data.RoleOrganizationData;
import com.grgbanking.electric.entity.RoleOrganization;
import com.grgbanking.electric.entity.User;
import com.grgbanking.electric.json.JSONMessage;
import com.grgbanking.electric.param.RoleOrganizationQueryParam;
import com.grgbanking.electric.service.IRoleOrganizationService;


@Controller
@RequestMapping("/manager/roleOrganization")
public class RoleOrganizationController extends BaseController {
    
    private final static Logger LOGGER = LoggerFactory
            .getLogger(RoleOrganizationController.class);

    @Autowired
    private IRoleOrganizationService roleOrganizationService;
    
    @RequestMapping("")
    public String page() {
        return "roleOrganization";
    }
    
    @RequestMapping("/list")
    public String list() {
        return "roleOrganizationList";
    }
    
    @RequestMapping("/query")
    @ResponseBody
    public Object query(RoleOrganizationQueryParam param) {
        return roleOrganizationService.query(param);
    }
    
    @RequestMapping("/queryAll")
    @ResponseBody
    public Object queryAll(RoleOrganizationQueryParam param) {
        return roleOrganizationService.queryAll(param);
    }
    
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public Object saveOrUpdate(RoleOrganization RoleOrganization) {
        User user = getCurrentUser();
        JSONMessage jMessage = new JSONMessage();
        try {
            RoleOrganization.setCreateBy(user.getAccount());
            RoleOrganization.setUpdateBy(user.getAccount());
            roleOrganizationService.saveOrUpdate(RoleOrganization);
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
    public Object saveBatch(RoleOrganizationData data) {
        User user = getCurrentUser();
        JSONMessage jMessage = new JSONMessage();
        try {
            data.setCreateBy(user.getAccount());
            roleOrganizationService.saveBatchData(data);
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
            roleOrganizationService.deleteByIds(Arrays.asList(StringUtils
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
            RoleOrganization data = roleOrganizationService.getById(id);
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
