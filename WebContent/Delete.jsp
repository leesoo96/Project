<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="Board.BoardBeans" %>
<jsp:useBean id="boardMgr" class="Board.BoardMgr" scope="page" />
<jsp:include page="css_JSP/Delete.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시글 삭제</title>
<%
//  현재 페이지 번호
	String nowPage = request.getParameter("nowPage");
	
//  삭제할 게시물 번호
	int post_Num = Integer.parseInt(request.getParameter("post_Num"));
//  비밀번호 확인해서 일치하면 게시물 삭제
	if(request.getParameter("post_Password") != null){
		
		// 폼에 입력한 비밀번호
		String insertPassword = request.getParameter("post_Password");
	
		// 세션에 저장된 게시물의 정보
		Board.BoardBeans beans = (Board.BoardBeans)session.getAttribute("beans");
		
		// beans에(DB에서 가져온) 저장된 비밀번호
		String DBPassword = beans.getPost_Password();
		
		if(insertPassword.equals(DBPassword)){
			boardMgr.deletePost(post_Num);
		
			String url = "List.jsp?nowPage="+nowPage;
			response.sendRedirect(url);
		}else{
			%>
				<script>
					alert("비밀번호가 다릅니다");
				</script>
			<% 
		}
	}
%>
<script>
	function insertPasswordCheck(){
		if(document.deleteForm.post_Password.value == ""){
			alert("비밀번호를 입력해주세요");
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
			<td>게시글의 비밀번호를 입력해주세요</td>
		</tr>

		<tr>
			<td>&#128073 <input type="password" name="post_Password" /></td>
		</tr>

		<tr>
			<td>
				<input type="button" value="Delete" onClick="insertPasswordCheck();return confirm('정말 삭제하시겠습니까?'); " />
				<input type="button" value="Back" onClick="history.go(-1)" />
			</td>
		</tr>
	</table>
	<input type="hidden" name="nowPage" value="<%=nowPage %>" />
	<input type="hidden" name="post_Num" value="<%=post_Num %>" />
</form>
</body>
</html>