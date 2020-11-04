package Board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

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
}
