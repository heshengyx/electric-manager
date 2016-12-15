package com.grgbanking.electric.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.grgbanking.electric.json.JSONMessage;
import com.grgbanking.electric.param.FileParam;
import com.grgbanking.electric.service.IRecognitionLogService;

@Controller
@RequestMapping("/manager/file")
public class FileController extends BaseController {

	private final static Logger LOGGER = LoggerFactory
			.getLogger(FileController.class);

	@Autowired
    private IRecognitionLogService recognitionLogService;
	
	/**
	 * 文件上传
	 * @param multipartFile
	 * @param param
	 * @return
	 */
	@RequestMapping("/upload")
	@ResponseBody
	public Object upload(@RequestParam("file") MultipartFile multipartFile,
			FileParam param) {
		return null;
	}
	
	/**
	 * 文件下载
	 * @param response
	 * @param fileName
	 * @return
	 */
	@RequestMapping("/download")
	public String download(HttpServletResponse response, String id) {
		File file = recognitionLogService.exists(id);
		String fileName = file.getName();
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		response.setHeader("Content-Disposition", "attachment;fileName="
				+ fileName);
		OutputStream out = null;
		InputStream in = null;
		
		try {
			out = new BufferedOutputStream(response.getOutputStream());
			in = new FileInputStream(file);
			
			byte[] b = new byte[2048];
			int length;
			while ((length = in.read(b)) > 0) {
				out.write(b, 0, length);
			}
			out.flush();
		} catch (FileNotFoundException e) {
			LOGGER.error("文件[{}]不存在", fileName, e);
		} catch (IOException e) {
			LOGGER.error("文件[{}]下载异常", fileName, e);
		} finally {
			try {
				if (in != null && out != null) {
					in.close();
					out.close();
				}
			} catch (IOException e) {
				LOGGER.error("文件[{}]关闭流异常", fileName, e);
			}
		}
		return null;
	}
	
	@RequestMapping("/exists")
    @ResponseBody
    public Object exists(String id) {
        JSONMessage jMessage = new JSONMessage();
        try {
        	recognitionLogService.exists(id);
            jMessage.setStatus(Boolean.TRUE);
        } catch (Exception e) {
            LOGGER.error("获取数据失败", e);
            jMessage.setStatus(Boolean.FALSE);
            if (e instanceof IllegalArgumentException) {
                jMessage.setMessage(e.getMessage());
            } else {
                jMessage.setMessage("系统异常");
            }
        }
        return jMessage;
    }
}
