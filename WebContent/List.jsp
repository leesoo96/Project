<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- 자바 빈즈, 클래스  설정-->
<%@ page import="Board.BoardBeans" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="BoardMgr" class="Board.BoardMgr" scope="page" />
<jsp:include page="css_JSP/List.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSP 게시판</title>
 <% // 게시물 표시 변수 설정
 // 게시글 
 	int totalPost = 0; // 전체 게시물 수 (DB에 저장된 전체 행 개수 저장)
 	int pageNumber = 10; // 한 페이지에 보여지는 게시물 수 
 	
 // 페이지
 	int totalPage = 0; 
 	int nowPage = 1; // 현재 페이지 수 
 
 // 블럭
 	int totalBlock = 0;
 	int pageBlockNumber = 15; // 블럭당 표시할 페이지수([1][2]..[15])
 	int nowBlock = 1; // 현재 블럭
 	
 // 게시물을 저장
 	Vector<BoardBeans> vectorBoardList = null;
 %>
 
 <% // 검색 처리 변수 설정
 // 검색 범위
 	int start = 0; // select의 시작 번호
 	int end = 10; // 시작번호로부터 가져올 select의 개수 
 	
 // 검색 결과를 통해 받아온 게시물 개수
 	int searchListSize = 0;
 	
 // 검색 정보 저장용 변수 
    String keyWord = "", keyField = "";
 
 // 현재 페이지 확인
	if(request.getParameter("nowPage") != null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
 
 // 검색창의 입력상태에 따른 저장
 	if(request.getParameter("keyWord") != null){
 		keyWord = request.getParameter("keyWord");
 		keyField = request.getParameter("keyField");
 	}
 
 // 처음으로 버튼을 누를 시 처리되는 작업
 	if(request.getParameter("reload") != null){
 		if(request.getParameter("reload").equals("true")){
 			keyWord = "";
 			keyField = "";
 		}
 	}
 
 // 검색어를 통해 검색된 게시물의 총 개수(검색값이 없으면 전체 게시물을 저장)
 	totalPost = BoardMgr.postTotalCount(keyField, keyWord);
 
 // 표시할 게시물의 시작 위치
 //              2        10           10   -> 2번째 페이지에서는 10번부터 시작 
 	start = (nowPage * pageNumber) - pageNumber;
 	end = pageNumber;
 	
 // 전체 페이지 수 (전체 게시물 수 / 페이지 당 표시될 게시물 수)
 	totalPage = (int)Math.ceil((double)totalPost / pageNumber);
 	// Math.ceil -> 소수점 이하 올림
 	
 // 블럭 개수 저장
 //                                                 10  
 	nowBlock = (int)Math.ceil((double)nowPage / pageBlockNumber);
 	totalBlock = (int)Math.ceil((double)totalPost / pageBlockNumber);
 %>
<script>
//'처음으로' 링크를 클릭하면 게시판 메인 화면을 보여준다
	function listRead(){
		document.listForm.action = "List.jsp";
		document.listForm.submit();
	}
//제목링크를 클릭하면 해당 게시글로 이동
	function postRead(post_Num){
		document.readForm.post_Num.value = post_Num;
		document.readForm.action = "Read.jsp";
		document.readForm.submit();
	}
//블럭 처리 = 다음 블럭이나 이전 블럭을 클릭하면  readForm의 nowPage에 해당 블럭의 시작 페이지 번호를 전달한다
	function moveBlock(value){
		document.readForm.nowPage.value=<%=pageBlockNumber%> * (value - 1) + 1;
		document.readForm.submit();      //    15            *  1 - 1 = 0  + 1 = 1
	}
//페이징처리 = 특정 블럭번호를 클릭하면 그에 해당하는 페이지의 게시물 표시
	function paging(page){
		document.readForm.nowPage.value = page;
		document.readForm.submit();
	}
//검색창에 검색할 문자(열)를 입력하지않을 경우 알람창이 뜨도록 함
function searchCheck(){
	if(document.searchForm.keyWord.value == ""){
		alert("검색어를 입력해주세요.");
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
     		 <a href="Post.jsp">[글쓰기]</a> 
     		 <a href="List.jsp" onClick="listRead()">[처음으로]</a>
   	 	</td>
   	</tr>
 </table>
 
<table id="board_title">
  <tr>
    <td>Total(<%=totalPost %>)&nbsp;&nbsp;&nbsp;목록(<%=nowPage %> / <%=totalPage %> PAGE)</td>
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
  
  <!-- 리스트 반복 동작 처리되는 부분(DB연동 후 결과 반복 ) -->
  <%
  	vectorBoardList = BoardMgr.getBoardList(keyField, keyWord, start, end);
  	if(vectorBoardList.isEmpty()){
  		out.println("<td>등록된 게시물이 없습니다.</td>");
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
 	 <tr class="listContent">   <!-- 본문 -->       
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

<!-- 페이지 넘기기 처리 -->
<table id="blockMenu">
	<tr>
		<td>
			<%
			//  블록에 표시되는 페이지 시작 번호 [1]
			//                     1-1 = 0     *        15       + 1 = 1
				int pageStart = (nowBlock - 1) * pageBlockNumber + 1;
			                         
			// pageStart + pageBlockNumber 의 결과가 totalPage 보다 작거나 같으면 pageStart + pageBlockNumber 을 결과로 얻고 
			// 그렇지않으면 totalPage + 1 을 결과로 얻는다
				int pageEnd = ((pageStart + pageBlockNumber) <= totalPage)? (pageStart + pageBlockNumber) : totalPage + 1;
			
				if(totalPage != 0){ // 1페이지 이상 존재할 경우 
					if(nowBlock > 1){
						%>
						    <!-- 이전 블록으로 이동 -->
							<a href="javascript:moveBlock('<%=nowBlock - 1%>')">◀</a>
						<% 
					}
					for(; pageStart < pageEnd; pageStart++){
						%>
							<!-- 특정 블럭 클릭 시 해당하는 페이지 출력 -->
							<a href="javascript:paging('<%=pageStart%>')">
								[<%=pageStart %>]
							</a>
						<% 
					}
					if(totalBlock > nowBlock){
						%>
							<!-- 다음 블록으로 이동 -->
							<a href="javascript:moveBlock('<%=nowBlock + 1%>')">▶</a>
						<% 
					}
				}
			%>                                   
		</td>
		
	</tr>
</table>

<!-- 검색용 폼 -->
<form action="List.jsp" method="get" name="searchForm">
  <table id="searchMenu">
    <tr>
      <td>
        <select name="keyField" size="1">
          <option value="writer_Name">이름</option>
          <option value="writer_Subject">제목</option>
          <option value="writer_Content">내용</option>
        </select>
        <input name="keyWord" size="16" />
        <input type="button" value="찾기" onclick="searchCheck()" />
        <input type="hidden" name="nowPage" value="1" />
      </td>
    </tr>
  </table>
</form>

<!-- 첫 페이지로 이동하는 폼 -->
<form method="post" name="listForm">
  <input type="hidden" name="reload" value="true">
  <input type="hidden" name="nowPage" value="1">
</form>

<!-- 페이징 처리 폼 -->
<form name="readForm" method="get">
	<input type="hidden" name="post_Num" />
	
	<!-- 블럭처리 관련 부분  -->
	<input type="hidden" name="nowPage" value="<%=nowPage %>" />
	
	<input type="hidden" name="keyField" value="<%=keyField %>" />
	<input type="hidden" name="keyWord" value="<%=keyWord %>" />
</form>
</body>
</html>