<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- �ڹ� ����, Ŭ����  ����-->
<%@ page import="Board.BoardBeans" %>
<jsp:include page="css_JSP/Update.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խù� �����ϱ�</title>
<%
	int post_Num = Integer.parseInt(request.getParameter("post_Num"));
	
	String nowPage = request.getParameter("nowPage");
	
	// ���ǿ� ���Ե� �Խù��� ����
	Board.BoardBeans beans = (Board.BoardBeans)session.getAttribute("beans");
	String writer_Name = beans.getWriter_Name();
	String writer_Subject = beans.getWriter_Subject();
	String writer_Content = beans.getWriter_Content();
%>
<script>
	function passwordCheck(){
		if(document.updateForm.post_Password.value == ""){
			alert("���� �� ��й�ȣ�� �ʿ��մϴ�.");
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
           <p>���� : <input name="writer_Name" value="<%=writer_Name %>" /></p>
      	</div>

        <div id="read_Box_Content">
          <p>���� : <input name="writer_Subject" value="<%=writer_Subject %>" /></p>

        <div class="readContent">
          <p><textarea name="writer_Content"><%=writer_Content %></textarea><br/>
                            ��й�ȣ : <input type="password" name="post_Password" />
          </p>
          <small>&#11088 �Խñ� �ۼ� �� �Է��ߴ� ��й�ȣ�� �Է����ּ���</small>
        </div>
    </div>

    <div id="read_Box_Bottom">
      <ul>
       <li>
         <input type="button" value="���� �Ϸ�" onClick="passwordCheck()"/>
         <input type="reset" value="�ٽ� ����" />
         <input type="button" value="�ڷ� ����" onClick="history.go(-1)" />
       </li>
      </ul>
   </div>
  </div>
   
   <input type="hidden" name="nowPage" value="<%=nowPage %>" />
   <input type="hidden" name="post_Num" value="<%=post_Num %>" />
  </form>
</body>
</html>