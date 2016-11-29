<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" contentType="text/html;charset=gbk" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Health Check</title>
	</head>
	
	<body>
    <table style="width:700px;background-color:#30F860;">
    	<tr>
    		<td valign="top"><b>MSS Server Health Check</b></td>
    		<td>
    		System Time：<%=new Date()%><br>
    		Server：<%=request.getRemoteAddr()%><br>
    		Last update：<%=new Date()%>
    		</td>
    	</tr>
    	<tr>
    		<td><b style="text-decoration:underline">UID Check</b></td>
    		<td></td>
    	</tr>
    	<tr>
    		<td>UID</td>
    		<td></td>
    	</tr>
    	<tr>
    		<td><b style="text-decoration:underline">DB Connection Check</b></td>
    		<td></td>
    	</tr>
    	<tr>
    		<td>CBBA Account Date：</td>
    		<td></td>
    	</tr>
    	<tr>
    		<td>HK Account Date：</td>
    		<td></td>
    	</tr>
    	<tr>
    		<td><b style="text-decoration:underline">HSM Connection Check</b></td>
    		<td></td>
    	</tr>
    	<tr>
    		<td>HSM Connection Status：</td>
    		<td>SUCCESS</td>
    	</tr>
    	<tr>
    		<td><b style="text-decoration:underline">Get Challenge</b></td>
    		<td></td>
    	</tr>
    	<tr>
    		<td>Challenge：</td>
    		<td></td>
    	</tr>
    	<tr>
    		<td><b style="text-decoration:underline">Link Test</b></td>
    		<td></td>
    	</tr>
    </table>
	</body>
</html>