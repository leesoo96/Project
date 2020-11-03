package Board;

public class BoardBeans {
//	post_Num = 게시물의 번호
	private int post_Num; 
	
//	writer_Name = 작성자의 이름
	private String writer_Name;
	
//	writer_Subject = 작성글 제목명
	private String writer_Subject;
	
//	writer_Content = 작성글 내용
	private String writer_Content;
	
//	reply_Pos = 답변 정보 -> 답변글이 등록된 순번
	private int reply_Pos;
	
//	reply_Ref = 게시물이 답변글일 경우 답변글의 원본 글의 게시물 번호를 저장
	private int reply_Ref;
	
//	reply_Depth = 들여쓰기( ex: 원본글 
//	                            -> 답변글 )
	private int reply_Depth;
	
//	registration_date = 글 등록 날짜
	private String registration_date;
	
//	post_Password = 게시글 등록 시 필요한 비밀번호 
	private String post_Password;
	
//	writer_Ip = 작성자의 아이피 주소를 담는다
	private String writer_Ip;
	
//	post_Count = 조회수
	private int post_Count;
	
//	fileName = 첨부파일 이름 
	private String fileName; 
	
//	fileSize = 첨부파일 크기
	private int fileSize;
	
	public int getPost_Num() {
		return post_Num;
	}
	public int getPost_Count() {
		return post_Count;
	}
	public void setPost_Count(int post_Count) {
		this.post_Count = post_Count;
	}
	public void setPost_Num(int post_Num) {
		this.post_Num = post_Num;
	}
	public String getWriter_Name() {
		return writer_Name;
	}
	public void setWriter_Name(String writer_Name) {
		this.writer_Name = writer_Name;
	}
	public String getWriter_Subject() {
		return writer_Subject;
	}
	public void setWriter_Subject(String writer_Subject) {
		this.writer_Subject = writer_Subject;
	}
	public String getWriter_Content() {
		return writer_Content;
	}
	public void setWriter_Content(String writer_Content) {
		this.writer_Content = writer_Content;
	}
	public int getReply_Pos() {
		return reply_Pos;
	}
	public void setReply_Pos(int reply_Pos) {
		this.reply_Pos = reply_Pos;
	}
	public int getReply_Ref() {
		return reply_Ref;
	}
	public void setReply_Ref(int reply_Ref) {
		this.reply_Ref = reply_Ref;
	}
	public int getReply_Depth() {
		return reply_Depth;
	}
	public void setReply_Depth(int reply_Depth) {
		this.reply_Depth = reply_Depth;
	}
	public String getRegistration_date() {
		return registration_date;
	}
	public void setRegistration_date(String registration_date) {
		this.registration_date = registration_date;
	}
	public String getPost_Password() {
		return post_Password;
	}
	public void setPost_Password(String post_Password) {
		this.post_Password = post_Password;
	}
	public String getWriter_Ip() {
		return writer_Ip;
	}
	public void setWriter_Ip(String writer_Ip) {
		this.writer_Ip = writer_Ip;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public int getFileSize() {
		return fileSize;
	}
	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}
}
