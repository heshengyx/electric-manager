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

import com.grgbanking.electric.data.CurveData;
import com.grgbanking.electric.entity.Curve;
import com.grgbanking.electric.entity.User;
import com.grgbanking.electric.json.JSONMessage;
import com.grgbanking.electric.param.CurveQueryParam;
import com.grgbanking.electric.service.ICurveService;


@Controller
@RequestMapping("/manager/curve")
public class CurveController extends BaseController {
    
    private final static Logger LOGGER = LoggerFactory
            .getLogger(CurveController.class);

    @Autowired
    private ICurveService curveService;
    
    @RequestMapping("")
    public String page() {
        return "curve";
    }
    
    @RequestMapping("/list")
    public String list() {
        return "curveList";
    }
    
    @RequestMapping("/query")
    @ResponseBody
    public Object query(CurveQueryParam param) {
        return curveService.query(param);
    }
    
    @RequestMapping("/queryAll")
    @ResponseBody
    public Object queryAll(CurveQueryParam param) {
        return curveService.queryAll(param);
    }
    
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public Object saveOrUpdate(Curve Curve) {
        User user = getCurrentUser();
        JSONMessage jMessage = new JSONMessage();
        try {
            Curve.setCreateBy(user.getAccount());
            Curve.setUpdateBy(user.getAccount());
            curveService.saveOrUpdate(Curve);
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
    public Object saveBatch(CurveData data) {
        User user = getCurrentUser();
        JSONMessage jMessage = new JSONMessage();
        try {
            data.setCreateBy(user.getAccount());
            curveService.saveBatchData(data);
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
            curveService.deleteByIds(Arrays.asList(StringUtils
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
            Curve data = curveService.getById(id);
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
