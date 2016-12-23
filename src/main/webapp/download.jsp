<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include.jsp"%>
<p>Welcome111111</p>
<iframe id="file_frame" width="0" height="0" hidden="true" style="border: 0px;" src="${ctx}/manager/file/download?id=${param.id}"></iframe>