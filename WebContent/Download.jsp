<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� �ٿ�ε�</title>
<jsp:useBean id="BoardMgr" class="Board.BoardMgr" />
<%
	BoardMgr.downloadFile(request, response, out, pageContext);
%>
</head>
<body>

</body>
</html>