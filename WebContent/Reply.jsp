<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�亯��</title>
<jsp:useBean id="beans" class="Board.BoardBeans" scope="session" />
<jsp:include page="css_JSP/Reply.jsp" />
</head>
<body>
    <table id="read_Table_Head">
     <tr>
        <td>Please write a reply &#128140	</td>
     </tr>
  </table>

  <form method="post" action="/BoardProject/Board/BoardReply">
      <div id="read_Box">
    		<div id="read_Box_Menu">
             <p>���� : <input name="writer_Name" value="<%=beans.getWriter_Name() %>" /></p>
        	</div>

          <div id="read_Box_Content">
            <p>���� : <input name="writer_Subject" value="<%=beans.getWriter_Subject() %>" /></p>

          <div class="readContent">
            <p><%=beans.getWriter_Content() %></p>
          </div>

          <div class="reply_Box">
            <p>�亯 :</p>
            <textarea name="writer_Content" rows="8" cols="80"></textarea>
          </div>

          <p>��й�ȣ : <input type="password" name="post_Password" /></p>
        </div>

      <div id="read_Box_Bottom">
        <ul>
         <li>
           <input type="submit" value="�亯 ���" />
           <input type="reset" value="�ٽ� ����" />
           <input type="button" value="�ڷ� ����" onClick="history.go(-1)" />
         </li>
        </ul>
     </div>
   </div>
<%
	String nowPage = request.getParameter("nowPage");
%>
<input type="hidden" name="writer_Ip" value="<%=request.getRemoteAddr() %>" />
<input type="hidden" name="nowPage" value="<%=nowPage %>" />
<input type="hidden" name="reply_Ref" value="<%=beans.getReply_Ref() %>" />
<input type="hidden" name="reply_Pos" value="<%=beans.getReply_Pos() %>" />
<input type="hidden" name="reply_Depth" value="<%=beans.getReply_Depth() %>" />
</form>
</body>
</html>