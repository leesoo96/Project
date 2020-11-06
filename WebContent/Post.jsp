<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시물 작성하기</title>
<jsp:include page="css_JSP/Post.jsp" />
</head>
<body>
    <table id="writer_head">
        <tr>
          <td>&#10084 Please write your thoughts &#10084</td>
        </tr>
      </table>

    <form action="/BoardProject/Board/BoardPost" method="post" name="postForm" enctype="multipart/form-data">
        <table id="writer_box">
        <tr>
          <td>
            <table class="writer_box_Menu" >
              <tr>
                <td>성명 :<input name="writer_Name" maxlength="10"/></td>
              </tr>
              <tr>
                <td>제목 :<input name="writer_Subject" /></td>
              </tr>
              <tr>
                <td>내용 :<textarea name="writer_Content" rows="10" cols="50"></textarea></td>
              </tr>
              <tr>
                <td>비밀번호 :<input type="password" name="post_Password" size="15" maxlength="15" /></td>
              </tr>
              <tr>
                <td>파일찾기<input type="file" name="fileName" size="50" maxlength="50" /></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>

      <table id="buttons">
        <tr>
          <td><input type="submit" value="등록하기" /><input type="button" value="리스트로 이동" onclick="location.href='List.jsp'" />
          </td>
        </tr>
      </table>
    </form>

    <input type="hidden" name="writer_Ip" value="<%=request.getRemoteAddr()%>">
</body>
</html>