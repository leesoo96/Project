<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- �ڹ� ����, Ŭ����  ����-->
<%@ page import="Board.BoardBeans" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="BoardMgr" class="Board.BoardMgr" scope="page" />
<jsp:include page="css_JSP/List.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSP �Խ���</title>
 <% // �Խù� ǥ�� ���� ����
 // �Խñ� 
 	int totalPost = 0; // ��ü �Խù� �� (DB�� ����� ��ü �� ���� ����)
 	int pageNumber = 10; // �� �������� �������� �Խù� �� 
 	
 // ������
 	int totalPage = 0; 
 	int nowPage = 1; // ���� ������ �� 
 
 // ��
 	int totalBlock = 0;
 	int pageBlockNumber = 15; // ���� ǥ���� ��������([1][2]..[15])
 	int nowBlock = 1; // ���� ��
 	
 // �Խù��� ����
 	Vector<BoardBeans> vectorBoardList = null;
 %>
 
 <% // �˻� ó�� ���� ����
 // �˻� ����
 	int start = 0; // select�� ���� ��ȣ
 	int end = 10; // ���۹�ȣ�κ��� ������ select�� ���� 
 	
 // �˻� ����� ���� �޾ƿ� �Խù� ����
 	int searchListSize = 0;
 	
 // �˻� ���� ����� ���� 
    String keyWord = "", keyField = "";
 
 // ���� ������ Ȯ��
	if(request.getParameter("nowPage") != null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
 
 // �˻�â�� �Է»��¿� ���� ����
 	if(request.getParameter("keyWord") != null){
 		keyWord = request.getParameter("keyWord");
 		keyField = request.getParameter("keyField");
 	}
 
 // ó������ ��ư�� ���� �� ó���Ǵ� �۾�
 	if(request.getParameter("reload") != null){
 		if(request.getParameter("reload").equals("true")){
 			keyWord = "";
 			keyField = "";
 		}
 	}
 
 // �˻�� ���� �˻��� �Խù��� �� ����(�˻����� ������ ��ü �Խù��� ����)
 	totalPost = BoardMgr.postTotalCount(keyField, keyWord);
 
 // ǥ���� �Խù��� ���� ��ġ
 //              2        10           10   -> 2��° ������������ 10������ ���� 
 	start = (nowPage * pageNumber) - pageNumber;
 	end = pageNumber;
 	
 // ��ü ������ �� (��ü �Խù� �� / ������ �� ǥ�õ� �Խù� ��)
 	totalPage = (int)Math.ceil((double)totalPost / pageNumber);
 	// Math.ceil -> �Ҽ��� ���� �ø�
 	
 // �� ���� ����
 //                                                 10  
 	nowBlock = (int)Math.ceil((double)nowPage / pageBlockNumber);
 	totalBlock = (int)Math.ceil((double)totalPost / pageBlockNumber);
 %>
<script>
//'ó������' ��ũ�� Ŭ���ϸ� �Խ��� ���� ȭ���� �����ش�
	function listRead(){
		document.listForm.action = "List.jsp";
		document.listForm.submit();
	}
//����ũ�� Ŭ���ϸ� �ش� �Խñ۷� �̵�
	function postRead(post_Num){
		document.readForm.post_Num.value = post_Num;
		document.readForm.action = "Read.jsp";
		document.readForm.submit();
	}
//�� ó�� = ���� ���̳� ���� ���� Ŭ���ϸ�  readForm�� nowPage�� �ش� ���� ���� ������ ��ȣ�� �����Ѵ�
	function moveBlock(value){
		document.readForm.nowPage.value=<%=pageBlockNumber%> * (value - 1) + 1;
		document.readForm.submit();      //    15            *  1 - 1 = 0  + 1 = 1
	}
//����¡ó�� = Ư�� ����ȣ�� Ŭ���ϸ� �׿� �ش��ϴ� �������� �Խù� ǥ��
	function paging(page){
		document.readForm.nowPage.value = page;
		document.readForm.submit();
	}
//�˻�â�� �˻��� ����(��)�� �Է��������� ��� �˶�â�� �ߵ��� ��
function searchCheck(){
	if(document.searchForm.keyWord.value == ""){
		alert("�˻�� �Է����ּ���.");
		document.searchForm.keyWord.focus();
		return false;
	}
  document.searchForm.submit();
}
</script>
</head>

<body>
<h2>Welcome to the bulletin board</h2>
<table>
	<tr>
		<td align=right id="topLinkMenu">
     		 <a href="Post.jsp">[�۾���]</a> 
     		 <a href="List.jsp" onClick="listRead()">[ó������]</a>
   	 	</td>
   	</tr>
 </table>
 
<table id="board_title">
  <tr>
    <td>Total(<%=totalPost %>)&nbsp;&nbsp;&nbsp;���(<%=nowPage %> / <%=totalPage %> PAGE)</td>
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
  
  <!-- ����Ʈ �ݺ� ���� ó���Ǵ� �κ�(DB���� �� ��� �ݺ� ) -->
  <%
  	vectorBoardList = BoardMgr.getBoardList(keyField, keyWord, start, end);
  	if(vectorBoardList.isEmpty()){
  		out.println("<td>��ϵ� �Խù��� �����ϴ�.</td>");
  	}else{
  		for(int i=0; i<pageNumber; i++){
  			if(i == vectorBoardList.size()){
  				break;
  			}else{
  				BoardBeans beans = vectorBoardList.get(i);
  				
  				int post_Num = beans.getPost_Num();
  				String writer_Name = beans.getWriter_Name();
  				String wirter_Subject = beans.getWriter_Subject();
  				String registration_date = beans.getRegistration_date();
  				int post_Count = beans.getPost_Count();
  %> 
 	 <tr class="listContent">   <!-- ���� -->       
   		<td><%=totalPost-((nowPage-1)*pageNumber)-i %></td>
   		<td><a href="javascript:postRead('<%=post_Num%>')"><%=wirter_Subject %></a></td>
   	 	<td><%=writer_Name %></td>
    	<td><%=registration_date %></td>
    	<td><%=post_Count %></td>
 	 </tr>
  <% 
  			}
  		}
  	}
  %>
</table>

<!-- ������ �ѱ�� ó�� -->
<table id="blockMenu">
	<tr>
		<td>
			<%
			//  ��Ͽ� ǥ�õǴ� ������ ���� ��ȣ [1]
			//                     1-1 = 0     *        15       + 1 = 1
				int pageStart = (nowBlock - 1) * pageBlockNumber + 1;
			                         
			// pageStart + pageBlockNumber �� ����� totalPage ���� �۰ų� ������ pageStart + pageBlockNumber �� ����� ��� 
			// �׷��������� totalPage + 1 �� ����� ��´�
				int pageEnd = ((pageStart + pageBlockNumber) <= totalPage)? (pageStart + pageBlockNumber) : totalPage + 1;
			
				if(totalPage != 0){ // 1������ �̻� ������ ��� 
					if(nowBlock > 1){
						%>
						    <!-- ���� ������� �̵� -->
							<a href="javascript:moveBlock('<%=nowBlock - 1%>')">��</a>
						<% 
					}
					for(; pageStart < pageEnd; pageStart++){
						%>
							<!-- Ư�� �� Ŭ�� �� �ش��ϴ� ������ ��� -->
							<a href="javascript:paging('<%=pageStart%>')">
								[<%=pageStart %>]
							</a>
						<% 
					}
					if(totalBlock > nowBlock){
						%>
							<!-- ���� ������� �̵� -->
							<a href="javascript:moveBlock('<%=nowBlock + 1%>')">��</a>
						<% 
					}
				}
			%>                                   
		</td>
		
	</tr>
</table>

<!-- �˻��� �� -->
<form action="List.jsp" method="get" name="searchForm">
  <table id="searchMenu">
    <tr>
      <td>
        <select name="keyField" size="1">
          <option value="writer_Name">�̸�</option>
          <option value="writer_Subject">����</option>
          <option value="writer_Content">����</option>
        </select>
        <input name="keyWord" size="16" />
        <input type="button" value="ã��" onclick="searchCheck()" />
        <input type="hidden" name="nowPage" value="1" />
      </td>
    </tr>
  </table>
</form>

<!-- ù �������� �̵��ϴ� �� -->
<form method="post" name="listForm">
  <input type="hidden" name="reload" value="true">
  <input type="hidden" name="nowPage" value="1">
</form>

<!-- ����¡ ó�� �� -->
<form name="readForm" method="get">
	<input type="hidden" name="post_Num" />
	
	<!-- ��ó�� ���� �κ�  -->
	<input type="hidden" name="nowPage" value="<%=nowPage %>" />
	
	<input type="hidden" name="keyField" value="<%=keyField %>" />
	<input type="hidden" name="keyWord" value="<%=keyWord %>" />
</form>
</body>
</html>