package Board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Board/BoardUpdate")
public class BoardUpdateServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("EUC-KR");
		resp.setContentType("text/html;charset=EUC-KR");
		
		HttpSession session = req.getSession();
		PrintWriter out = resp.getWriter();
		
		BoardMgr boardMgr = new BoardMgr();
		BoardBeans beans = (BoardBeans)session.getAttribute("beans");
		
		String nowPage = req.getParameter("nowPage");
		
		BoardBeans updateBeans = new BoardBeans();
		updateBeans.setPost_Num(Integer.parseInt(req.getParameter("post_Num")));
		updateBeans.setWriter_Name(req.getParameter("writer_Name"));
		updateBeans.setWriter_Subject(req.getParameter("writer_Subject"));
		updateBeans.setWriter_Content(req.getParameter("writer_Content"));
		updateBeans.setPost_Password(req.getParameter("post_Password"));
		updateBeans.setWriter_Ip(req.getParameter("writer_Ip"));
		
//		수정 시 필요한 비밀번호의 정보
		String updatePassword = updateBeans.getPost_Password();
		
//	        게시글을 작성할때 입력한 비밀번호의 정보
		String insertPassword = beans.getPost_Password();
	
		if(updatePassword.equals(insertPassword)) {
			boardMgr.updateBoard(updateBeans);
			
			String url = "/BoardProject/Read.jsp?nowPage="+nowPage+"&post_Num="+updateBeans.getPost_Num();
			resp.sendRedirect(url);
		}else {
			out.println("<script>");
			out.println("alert('비밀번호가 다릅니다.');");
			out.println("history.back()");
			out.println("</script>");
		}
	}
}
