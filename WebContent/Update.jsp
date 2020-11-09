<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- 자바 빈즈, 클래스  설정-->
<%@ page import="Board.BoardBeans" %>
<jsp:include page="css_JSP/Update.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시물 수정하기</title>
<%
	int post_Num = Integer.parseInt(request.getParameter("post_Num"));
	
	String nowPage = request.getParameter("nowPage");
	
	// 세션에 포함된 게시물의 정보
	Board.BoardBeans beans = (Board.BoardBeans)session.getAttribute("beans");
	String writer_Name = beans.getWriter_Name();
	String writer_Subject = beans.getWriter_Subject();
	String writer_Content = beans.getWriter_Content();
%>
<script>
	function passwordCheck(){
		if(document.updateForm.post_Password.value == ""){
			alert("수정 시 비밀번호가 필요합니다.");
			document.updateForm.post_Password.focus();
			return ;
		}
	  document.updateForm.submit();
	}
</script>
</head>
<body>
  <table id="read_Table_Head">
        <tr>
          <td>&#10004 Modify</td>
        </tr>
  </table>

  <form name="updateForm" method="post" action="/BoardProject/Board/BoardUpdate">
    <div id="read_Box">
  		<div id="read_Box_Menu">
           <p>성명 : <input name="writer_Name" value="<%=writer_Name %>" /></p>
      	</div>

        <div id="read_Box_Content">
          <p>제목 : <input name="writer_Subject" value="<%=writer_Subject %>" /></p>

        <div class="readContent">
          <p><textarea name="writer_Content"><%=writer_Content %></textarea><br/>
                            비밀번호 : <input type="password" name="post_Password" />
          </p>
          <small>&#11088 게시글 작성 시 입력했던 비밀번호를 입력해주세요</small>
        </div>
    </div>

    <div id="read_Box_Bottom">
      <ul>
       <li>
         <input type="button" value="수정 완료" onClick="passwordCheck()"/>
         <input type="reset" value="다시 쓰기" />
         <input type="button" value="뒤로 가기" onClick="history.go(-1)" />
       </li>
      </ul>
   </div>
  </div>
   
   <input type="hidden" name="nowPage" value="<%=nowPage %>" />
   <input type="hidden" name="post_Num" value="<%=post_Num %>" />
  </form>
</body>
</html>