<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- �ڹ� ����, Ŭ����  ����-->
<%@ page import="Board.BoardBeans" %>
<%@ page import="java.util.Vector" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSP �Խ��� ������</title>
 <link rel="stylesheet" href="css/list.css" type="text/css">
</head>
<body>
<h2>�Խ���</h2>
<table id="board_title">
  <tr>
    <td>Total Articles PAGE</td>
  </tr>
</table>

<table id="board_menu">
  <tr>
    <td>��ȣ</td>
    <td>����</td>
    <td>�̸�</td>
    <td>��¥</td>
    <td>��ȸ��</td>
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
      <a href="#">�۾���</a>
      <a href="#">ó������</a>
    </td>
  </tr>
</table>

<form action="C01List.jsp" method="get" name="searchForm">
  <table>
    <tr>
      <td>
        <select name="keyField">
          <option value="name">�̸�</option>
          <option value="subject">����</option>
          <option value="content">����</option>
        </select>
        <input name="keyword" size="15" />
        <input type="button" value="ã��" onclick="#" />
        <input type="hidden" name="nowPage" value="ã��" />
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