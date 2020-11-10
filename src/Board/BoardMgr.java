package Board;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardMgr {
	private DBConnectionMgr pool;
	
//	업로드된 파일을 저장할 곳, 인코딩, 파일 최대 사이즈 지정
	private static final String SAVEFOLDER = "C:/JSP/BoardProject/WebContent/FileUpload";
	private static final String ENCTYPE = "EUC-KR";
	private static int MAXSIZE = 5 * 1024 * 1024;

	public BoardMgr() {
		try {
//			pool 객체 생성
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
//	검색한 정보를 받아서 게시글 개수를 반환하는 메소드(검색어 찾기)
	public int postTotalCount(String keyField, String keyWord) {
		Connection conn = null;
		PreparedStatement pstmt = null; // 쿼리문 실행을 위한 객체
		ResultSet rs = null; // select문을 사용해 얻은 값들을 가져오는 객체
		String sql = null;
		int totalCount = 0;
		
		try {
			conn = pool.getConnection();
			
			if(keyWord.equals("null") || keyWord.equals("")) {
				sql = "SELECT COUNT(*) FROM tblBoard"; // 테이블에 저장된 데이터 개수를 가져온다
				pstmt = conn.prepareStatement(sql); // connection의 내장메소드
			}else {
//				keyField에서 keyWord를 포함하는 데이터의 개수를 가져온다 
				sql = "SELECT COUNT(*) FROM tblBoard WHERE "+ keyField + " LIKE ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
			}
			
			rs = pstmt.executeQuery(); // select 쿼리문을 수행

//			rs로부터 데이터 추출 
			if(rs.next()) {
				totalCount = rs.getInt(1); // 1번째로 검색되는 int형 자료를 가져온다
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs); // 자원 해제 필수!
		}
	  return totalCount; 
	}
	
	public Vector<BoardBeans> getBoardList(String keyField, String keyWord, int start, int end){
		Vector<BoardBeans> vectorBoardList = new Vector<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			conn = pool.getConnection();
			
			// 검색한 값이 없으면 전체 게시물 출력
			if(keyWord.equals("null") || keyWord.equals("")) {
//   reply_Ref(원본글)을 기준으로 DESC(내림차순 정렬), 
//   reply_Pos(답변글)을 기준으로 오름차순(ASC:기본정렬값)으로 해서
//   LIMIT을 걸어서 ?부터 ?까지 검색한다 
				sql = "SELECT * FROM tblBoard ORDER BY reply_Ref DESC, reply_Pos LIMIT ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			}else {
				sql = "SELECT * FROM tblBoard WHERE " +keyField+ " LIKE ? ORDER BY reply_Ref DESC, reply_Pos LIMIT ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			
			rs = pstmt.executeQuery();

//			select문을 실행해서 나온 결과 값이 있으면 
			if(rs != null) {
				while(rs.next()) {
					BoardBeans beans = new BoardBeans();
					beans.setPost_Num(rs.getInt("post_Num"));
					beans.setWriter_Name(rs.getString("writer_Name"));
					beans.setWriter_Subject(rs.getString("writer_Subject"));
					beans.setReply_Pos(rs.getInt("reply_Pos"));
					beans.setReply_Ref(rs.getInt("reply_Ref"));
					beans.setReply_Depth(rs.getInt("reply_Depth"));
					beans.setRegistration_date(rs.getString("registration_date"));
					beans.setPost_Count(rs.getInt("post_Count"));
					
//					그 값들을 vectorBoardList에 저장
					vectorBoardList.add(beans);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return vectorBoardList;
	}
	
//	BoardPostServlet
	public void insertBoard(HttpServletRequest req) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
//		파일 업로드 클래스
		MultipartRequest multi = null;
		
//		파일 관련 변수
		int fileSize = 0;
		String fileName = null;
		

		try {
			conn = pool.getConnection();
			
//			총 게시물의 수가 304면 304 라는 값을 가지고 온다
//			MAX -> post_Num의 가장 큰 값을 가지고 온다
			sql = "SELECT MAX(post_Num) FROM tblBoard";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
//			현재 존재하는 게시물의 번호 다음 숫자(게시물이 없으면 1번부터 시작하도록 함)
			int reply_Ref = 1;
			if(rs.next()) {
//			getInt() -> 해당 컬럼의 가장 높은 값을 int형으로 갖고 온다!
//		        현재 존재하는 게시물의 번호가 304라면 게시물이 추가되면 305로 값을 나타낸다
				reply_Ref = rs.getInt(1) + 1;
			}
			
//			파일 객체 생성
			File file = new File(SAVEFOLDER); 
			if(!file.exists()) { // 파일이 없으면
				file.mkdirs(); // 지정한 경로에 폴더를 만들고 파일을 만든다
//				 mkdir() = 지정한 경로에 폴더가 있어야만 파일을 만든다 
			}
			
			multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());

//			                                  Enumeration -> 열거형  인터페이스
//	 폼 요소 중 file 속성으로 지정된 input태그의 name값을 Enumeration객체를 반환한다
			if(multi.getFilesystemName("fileName") != null) {
//			       발견되는 파일 이름이 있으면 
				fileName = multi.getFilesystemName("fileName");
				fileSize = (int)multi.getFile("fileName").length();
			}
			
			String writer_Content = multi.getParameter("writer_Content");
			
			sql = "INSERT INTO tblBoard(writer_Name,writer_Subject,writer_Content,reply_Pos,reply_Ref,reply_Depth,registration_date,post_Password,writer_Ip,post_Count,fileName,fileSize)";
			sql += "VALUES(?,?,?,0,?,0,now(),?,?,0,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("writer_Name"));
			pstmt.setString(2, multi.getParameter("writer_Subject"));
			pstmt.setString(3, writer_Content);
			pstmt.setInt(4, reply_Ref);
			pstmt.setString(5, multi.getParameter("post_Password"));
			pstmt.setString(6, multi.getParameter("writer_Ip"));
			pstmt.setString(7, fileName);
			pstmt.setInt(8, fileSize);
			
			pstmt.executeUpdate(); // insert문 실행
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
	}
	
//	Read.jsp
	public void countCheck(int post_Num) { // 조회수 메소드
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = pool.getConnection();
			sql = "UPDATE tblBoard SET post_Count=post_Count+1 WHERE post_Num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, post_Num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt);
		}
	}
	
//	게시글에 입력되어져있는 값 가져오기
	public BoardBeans getPost(int post_Num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		BoardBeans beans = new BoardBeans();
		
		try {
			conn = pool.getConnection();
			sql = "SELECT * FROM tblBoard WHERE post_Num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, post_Num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				beans.setPost_Num(rs.getInt("post_Num"));
				beans.setWriter_Name(rs.getString("writer_Name"));
				beans.setWriter_Subject(rs.getString("writer_Subject"));
				beans.setWriter_Content(rs.getString("writer_Content"));
				beans.setReply_Pos(rs.getInt("reply_Pos"));
				beans.setReply_Ref(rs.getInt("reply_Ref"));
				beans.setReply_Depth(rs.getInt("reply_Depth"));
				beans.setRegistration_date(rs.getString("registration_Date"));
				beans.setPost_Password(rs.getString("post_Password"));
				beans.setWriter_Ip(rs.getString("writer_Ip"));
				beans.setPost_Count(rs.getInt("post_Count"));
				beans.setFileName(rs.getString("fileName"));
				beans.setFileSize(rs.getInt("fileSize"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		
		return beans;
	}
	
//	Download.jsp
	public void downloadFile(HttpServletRequest req, HttpServletResponse res, JspWriter out, PageContext pagecontext) throws IOException{
		String fileName = req.getParameter("fileName");
		File file = new File(SAVEFOLDER + "/" + fileName);
		byte[] b = new byte[(int) file.length()];
		
		res.setHeader("Accept-Ranges", "bytes");
		/*	Accept-Ranges 응답 HTTP 헤더 = 값의 범위를 정의하기위해서 사용되는 단위
	  									헤더가 존재하면 브라우저는 처음부터 다시 다운로드를 하지않고 
										중단된 다운로드를 다시 재개한다
		option : none - 사용안함
	  	option : byte - byte단위 범위로 지정 */
		
//		application/smnet = 다운로드 창이 뜨지않고 바로 열기동작을 수행한다
		res.setContentType("application/smnet;charset=euc-kr");
		
		res.setHeader("Content-Disposition", "filename" + fileName + ";");
/*		Disposition 헤더 = 브라우저에 Content가 inline으로 표시될지 
							  attachment로 표시될지의 여부를 나타낸다
	inline -> 웹페이지로 혹은 웹페이지 내에서 표시(기본값)
	attachment -> 로컬 다운로드 & 저장(대부분 브라우저는 바로 다운로드되거나 save as 다이얼로그가 표시된다 
				  attachment;filename으로 해주면 attachment가 적용된다
*/
		
/* 파일 다운로드 코드 구현 시 주의점
   JSP페이지는 기본적으로 OutputStream이 Out이라는 객체에 정의되어있다.
      그래서 jsp에 새로 OutputStream을 생성하면 에러가 발생한다
      이를 해결하기위해서는 본래 기본으로 갖고 있던 out 객체를 비워주고 새로운 객체를 선언하면 된다
*/		out = pagecontext.pushBody(); // 기존 Output 스트림 제거

//	파일 다운로드 코드
		if(file.isFile()) { // 파일이 있으면
/*	BufferedInputStream, BufferedOutputStream => 바이트 단위 입출력 스트림	
바이트 단위 입출력 스트림 : 그림, 멀티미디어, 문자등 모든 종류의 데이터들을 주고받을 수 있다
문자 단위 입출력 스트림 : 오로지 문자만 주고받을 수 있다.
*/			BufferedInputStream fileIn = new BufferedInputStream(new FileInputStream(file));
			BufferedOutputStream fileOut = new BufferedOutputStream(res.getOutputStream());
		
			int read = 0;
			
//			read -> 입력스트림으로부터 1바이트를 읽고 읽은 바이트를 리턴
			while((read = fileIn.read(b)) != -1) { // -1이 나오면 더이상 읽을 값이 없다는 의미이다
				fileOut.write(b, 0, read);
//				write -> 출력스트림으로부터 1바이트를 보낸다
			} 
			
			fileIn.close();
			fileOut.close();
			
		}
	}
	
//  BoardUpdateServlet
	public void updateBoard(BoardBeans beans) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = pool.getConnection();
			sql = "UPDATE tblBoard SET writer_Name=?,writer_Subject=?,writer_Content=? WHERE post_Num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, beans.getWriter_Name());
			pstmt.setString(2, beans.getWriter_Subject());
			pstmt.setString(3, beans.getWriter_Content());
			pstmt.setInt(4, beans.getPost_Num());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt);
		}
	}
	
/*	BoardReplyServlet
 
        답변글 이전에 있는 게시글의 위치값을 수정하기위한 메소드
	reply_Ref -> 게시글이 답글일 경우 원 글의 게시물번호를 저장
	reply_Pos -> 게시글의 위치
*/	public void replyUpdateBoard(int reply_Ref, int reply_Pos) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = pool.getConnection();                                   
			sql = "UPDATE tblBoard SET reply_Pos = reply_Pos + 1 WHERE reply_Ref= ? and reply_Pos > ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reply_Ref);
			pstmt.setInt(2, reply_Pos);
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt);
		}
	}
	
//	답변글 등록 메소드
	public void replyBoard(BoardBeans beans) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = pool.getConnection();
			sql = "INSERT INTO tblBoard(writer_Name,writer_Subject,writer_Content,reply_Pos,reply_Ref,reply_Depth,registration_date,post_Password,writer_Ip,post_Count)";
			sql += "VALUE(?,?,?,?,?,?,now(),?,?,0)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, beans.getWriter_Name());
			pstmt.setString(2, beans.getWriter_Subject());
			pstmt.setString(3, beans.getWriter_Content());
			pstmt.setInt(4, beans.getReply_Pos()+1);
			pstmt.setInt(5, beans.getReply_Ref());
			pstmt.setInt(6, beans.getReply_Depth()+1);
			pstmt.setString(7, beans.getPost_Password());
			pstmt.setString(8, beans.getWriter_Ip());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt);
		}
	}
	
//	Delete.jsp
//	게시물 번호에 해당되는 게시물 삭제
	public void deletePost(int post_Num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		
		try {
			conn = pool.getConnection();
			
//			1. 게시물의 첨부파일도 같이 삭제
			sql = "SELECT fileName FROM tblBoard WHERE post_Num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, post_Num);
			rs = pstmt.executeQuery();
			
			String fileName = null;
			
			if(rs != null) {
				while(rs.next()) {
					fileName = rs.getString("fileName");
				}
			}
			
			File file = new File(SAVEFOLDER + "/" + fileName);
			
//			      파일이 존재하는가         파일이 폴더(디렉토리)가 아닌 진짜 파일을 명시하는가
			if(file.exists() && file.isFile()) {
				file.delete(); // 파일 삭제
			}
			
//			2. 게시물 삭제
			sql = "DELETE FROM tblBoard WHERE post_Num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, post_Num);
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
	}
}
