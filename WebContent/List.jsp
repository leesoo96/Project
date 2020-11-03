<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- 자바 빈즈, 클래스  설정-->
<%@ page import="Board.BoardBeans" %>
<%@ page import="java.util.Vector" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSP 게시판 페이지</title>
 <link rel="stylesheet" href="css/list.css" type="text/css">
</head>
<body>
<h2>게시판</h2>
<table id="board_title">
  <tr>
    <td>Total Articles PAGE</td>
  </tr>
</table>

<table id="board_menu">
  <tr>
    <td>번호</td>
    <td>제목</td>
    <td>이름</td>
    <td>날짜</td>
    <td>조회수</td>
  </tr>
  <tr>
    <td>total</td>
    <td>subject</td>
    <td>name</td>
    <td>regdate</td>
    <td>count</td>
  </tr>
</table>

<table id="board_menu_bottom">
  <tr>
    <td>block</td>
    <td align=right>
      <a href="#">글쓰기</a>
      <a href="#">처음으로</a>
    </td>
  </tr>
</table>

<form action="C01List.jsp" method="get" name="searchForm">
  <table>
    <tr>
      <td>
        <select name="keyField">
          <option value="name">이름</option>
          <option value="subject">제목</option>
          <option value="content">내용</option>
        </select>
        <input name="keyword" size="15" />
        <input type="button" value="찾기" onclick="#" />
        <input type="hidden" name="nowPage" value="찾기" />
      </td>
    </tr>
  </table>
</form>

<form method="post" name="listForm">
  <input type="hidden" name="reload" value="true">
  <input type="hidden" name="nowPage" value="1">
</form>
</body>
</html>