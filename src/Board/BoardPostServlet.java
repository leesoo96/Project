package Board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Board/BoardPost")
public class BoardPostServlet extends HttpServlet{
// 									    사용자 요청을 처리하는 클래스!
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("EUC-KR");
		
		BoardMgr boardMgr = new BoardMgr();
		boardMgr.insertBoard(req);
		
		resp.sendRedirect("/BoardProject/List.jsp");
	}
// Servlet = 클라이언트의 요청을 처리하고 그 결과를 반환하는 역할을 수행하는 것
//           MVC패턴에서 Controller로 이용된다
}
