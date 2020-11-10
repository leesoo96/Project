package Board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Board/BoardReply")
public class BoardReplyServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("EUC-KR");
		
		BoardMgr boardMgr = new BoardMgr();
		
//		답변글의 입력 값을 담을 객체
		BoardBeans replyBeans = new BoardBeans();
		
//		답변글의 정보들 
		replyBeans.setWriter_Name(req.getParameter("writer_Name"));
		replyBeans.setWriter_Subject(req.getParameter("writer_Subject"));
		replyBeans.setWriter_Content(req.getParameter("writer_Content"));
		replyBeans.setReply_Ref(Integer.parseInt(req.getParameter("reply_Ref")));
		replyBeans.setReply_Pos(Integer.parseInt(req.getParameter("reply_Pos")));
		replyBeans.setReply_Depth(Integer.parseInt(req.getParameter("reply_Depth")));
		replyBeans.setPost_Password(req.getParameter("post_Password"));
		replyBeans.setWriter_Ip(req.getParameter("writer_Ip"));

//		답변글 이전에 있는 게시글의 게시물 번호를 하나씩 증가시킨다
		boardMgr.replyUpdateBoard(replyBeans.getReply_Ref(), replyBeans.getReply_Pos());
		
//		답변 게시글을 tblBoard(DB테이블)에 저장
		boardMgr.replyBoard(replyBeans);
		
		String nowPage = req.getParameter("nowPage");
		resp.sendRedirect("/BoardProject/List.jsp?nowPage="+nowPage);
	}

}
