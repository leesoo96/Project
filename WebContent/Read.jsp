<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- �ڹ� ����, Ŭ����  ����-->
<%@ page import="Board.BoardBeans" %>
<jsp:useBean id="BoardMgr" class="Board.BoardMgr" scope="page" />
<jsp:include page="css_JSP/Read.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խù� �б�</title>
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
// => ���� �Ӽ����� name�� �Ӽ��� �Ӽ� ������ value�� �Ҵ�
	session.setAttribute("beans", beans);
// ��Ű�� �� �������� ������� ���¸� �����ϱ� ���� ������ ����, 
// ����(session)�� �� ���� ���� �� �����̳ʿ� ���¸� �����ϱ� ���� ������ ����
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
                <li>�̸� : <%=writer_Name %></li>
                <li>IP : <%=writer_Ip %></li>
                <li>��ϳ�¥ : <%=reg_Date %></li>
                <li>��ȸ�� : <%=post_Count %> ȸ</li>
              </ul>
            </div>

            <div id="read_Box_Content">
              <ul>
                <li>���� : <%=writer_Subject %></li>
              </ul>

              <ul class="readContent">
                <li><%=writer_Content %></li>
              </ul>
              
				<!-- �����̸��� ������ �Ʒ��� ul, li �±׸� ����  -->
			  <%
			  	if(fileName != null && !fileName.equals("")){
			  %>
              <ul class="readFile">
                <li>÷������ : <a href="javascript:download('<%=fileName%>')"><%=fileName %></a> <%=fileSize %>Kbyte</li>
              </ul>
              <%
            	  }
              %>
          
            </div>

            <div id="read_Box_Bottom">
              <ul>
                <li>
                  <a href="List.jsp">����Ʈ</a>
                  <a href="Update.jsp?nowPage=<%=nowPage%>&post_Num=<%=post_Num%>">����</a>
                  <a href="Reply.jsp?nowPage=<%=nowPage%>">�亯</a>
                  <a href="Delete.jsp?nowPage=<%=nowPage%>&post_Num=<%=post_Num%>">����</a>
                </li>
              </ul>
            </div>
    </div>

<!-- List.jsp�� ���ư��� �뵵�� form -->
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
    
 <!-- Download.jsp�� ���ư��� �뵵�� form -->
    <form name="downloadForm" action="Download.jsp" method="post">
    	<input type="hidden" name="fileName" />
    </form>
</body>
</html>