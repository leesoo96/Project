<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="Board.BoardBeans" %>
<jsp:useBean id="boardMgr" class="Board.BoardMgr" scope="page" />
<jsp:include page="css_JSP/Delete.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խñ� ����</title>
<%
//  ���� ������ ��ȣ
	String nowPage = request.getParameter("nowPage");
	
//  ������ �Խù� ��ȣ
	int post_Num = Integer.parseInt(request.getParameter("post_Num"));
//  ��й�ȣ Ȯ���ؼ� ��ġ�ϸ� �Խù� ����
	if(request.getParameter("post_Password") != null){
		
		// ���� �Է��� ��й�ȣ
		String insertPassword = request.getParameter("post_Password");
	
		// ���ǿ� ����� �Խù��� ����
		Board.BoardBeans beans = (Board.BoardBeans)session.getAttribute("beans");
		
		// beans��(DB���� ������) ����� ��й�ȣ
		String DBPassword = beans.getPost_Password();
		
		if(insertPassword.equals(DBPassword)){
			boardMgr.deletePost(post_Num);
		
			String url = "List.jsp?nowPage="+nowPage;
			response.sendRedirect(url);
		}else{
			%>
				<script>
					alert("��й�ȣ�� �ٸ��ϴ�");
				</script>
			<% 
		}
	}
%>
<script>
	function insertPasswordCheck(){
		if(document.deleteForm.post_Password.value == ""){
			alert("��й�ȣ�� �Է����ּ���");
			document.deleteForm.post_Password.focus();
			return false;
		}
	  document.deleteForm.submit();
	}
</script>
</head>
<body>
<form name="deleteForm" method="post" action="Delete.jsp">
	<table id="deleteTable">
		<tr>
			<td>�Խñ��� ��й�ȣ�� �Է����ּ���</td>
		</tr>

		<tr>
			<td>&#128073 <input type="password" name="post_Password" /></td>
		</tr>

		<tr>
			<td>
				<input type="button" value="Delete" onClick="insertPasswordCheck();return confirm('���� �����Ͻðڽ��ϱ�?'); " />
				<input type="button" value="Back" onClick="history.go(-1)" />
			</td>
		</tr>
	</table>
	<input type="hidden" name="nowPage" value="<%=nowPage %>" />
	<input type="hidden" name="post_Num" value="<%=post_Num %>" />
</form>
</body>
</html>