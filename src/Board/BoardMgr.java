package Board;

public class BoardMgr {
	private DBConnectionMgr pool;
	
//	업로드된 파일을 저장할 곳, 인코딩, 파일 최대 사이즈 지정
	private static final String SAVEFOLDER = "C:\\JSP\\BoardProject\\WebContent\\FileUpload";
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
}
