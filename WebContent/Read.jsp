<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- 자바 빈즈, 클래스  설정-->
<%@ page import="Board.BoardBeans" %>
<jsp:useBean id="BoardMgr" class="Board.BoardMgr" scope="page" />
<jsp:include page="css_JSP/Read.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시물 읽기</title>
<%
	int post_Num = Integer.parseInt(request.getParameter("post_Num"));
	
	String nowPage = request.getParameter("nowPage");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	
	BoardMgr.countCheck(post_Num);
	BoardBeans beans = BoardMgr.getPost(post_Num);
	
	String writer_Name = beans.getWriter_Name();
	String writer_Subject = beans.getWriter_Subject();
	String writer_Content = beans.getWriter_Content();
	String reg_Date = beans.getRegistration_date();
	String writer_Ip = beans.getWriter_Ip();
	int post_Count = beans.getPost_Count();
	String fileName = beans.getFileName();
	int fileSize = beans.getFileSize();
	
//  setAttribute(String name, Object value) 
// => 세션 속성명이 name인 속성에 속성 값으로 value를 할당
	session.setAttribute("beans", beans);
// 쿠키는 웹 브라우저에 사용자의 상태를 유지하기 위한 정보를 저장, 
// 세션(session)은 웹 서버 쪽의 웹 컨테이너에 상태를 유지하기 위한 정보를 저장
%>
<script>
	function download(fileName){
		document.downloadForm.fileName.value = fileName;
		document.downloadForm.submit();
	}
</script>
</head>
<body>
<table id="read_Table_Head">
      <tr>
        <td>Post reading</td>
      </tr>
    </table>

      <div id="read_Box">
            <div id="read_Box_Menu">
              <ul>
                <li>이름 : <%=writer_Name %></li>
                <li>IP : <%=writer_Ip %></li>
                <li>등록날짜 : <%=reg_Date %></li>
                <li>조회수 : <%=post_Count %> 회</li>
              </ul>
            </div>

            <div id="read_Box_Content">
              <ul>
                <li>제목 : <%=writer_Subject %></li>
              </ul>

              <ul class="readContent">
                <li><%=writer_Content %></li>
              </ul>
              
				<!-- 파일이름이 있으면 아래의 ul, li 태그를 생성  -->
			  <%
			  	if(fileName != null && !fileName.equals("")){
			  %>
              <ul class="readFile">
                <li>첨부파일 : <a href="javascript:download('<%=fileName%>')"><%=fileName %></a> <%=fileSize %>Kbyte</li>
              </ul>
              <%
            	  }
              %>
          
            </div>

            <div id="read_Box_Bottom">
              <ul>
                <li>
                  <a href="List.jsp">리스트</a>
                  <a href="Update.jsp?nowPage=<%=nowPage%>&post_Num=<%=post_Num%>">수정</a>
                  <a href="Reply.jsp?nowPage=<%=nowPage%>">답변</a>
                  <a href="Delete.jsp?nowPage=<%=nowPage%>&post_Num=<%=post_Num%>">삭제</a>
                </li>
              </ul>
            </div>
    </div>

<!-- List.jsp로 돌아가기 용도의 form -->
    <form name="listForm" action="List.jsp" method="post">
      <input type="hidden" name="nowPage" value="<%=nowPage %>">
      <%
      	if(keyWord != null && !keyWord.equals("")){
      %>
      	<input type="hidden" name="keyWord" value="<%=keyWord %>">
      	<input type="hidden" name="keyField" value="<%=keyField %>">
      <%
      	}
      %>
    </form>
    
 <!-- Download.jsp로 돌아가기 용도의 form -->
    <form name="downloadForm" action="Download.jsp" method="post">
    	<input type="hidden" name="fileName" />
    </form>
</body>
</html>