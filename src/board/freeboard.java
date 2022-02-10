package board;

public class freeboard {
	private int fbn;//게시물번호
	private String fbo;//게시물 제목
	private String userid;//유저 아이디 외래키지정함 오류남
	private String fbd;// sql에서 관리할수 있는데 나중에 공부하기 현재시간으로 등록됨
	private int fbr;//추천수
	private int fbv;//조회수
	private int fbavaliable;// 게시물 관리 삭제 되었는지
	private String fbrcontent;//게시물 내용
	
	
	public int getFbn() {
		return fbn;
	}
	public void setFbn(int fbn) {
		this.fbn = fbn;
	}
	public String getFbo() {
		return fbo;
		
	}
	public void setFbo(String fbo) {
		this.fbo = fbo;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getFbd() {
		return fbd;
	}
	public void setFbd(String fbd) {
		this.fbd = fbd;
	}
	public int getFbr() {
		return fbr;
	}
	public void setFbr(int fbr) {
		this.fbr = fbr;
	}
	public int getFbv() {
		return fbv;
	}
	public void setFbv(int fbv) {
		this.fbv = fbv;
	}
	public int getFbavaliable() {
		return fbavaliable;
	}
	public void setFbavaliable(int fbavaliable) {
		this.fbavaliable = fbavaliable;
	}
	public String getFbrcontent() {
		return fbrcontent;
	}
	public void setFbrcontent(String fbrcontent) {
		this.fbrcontent = fbrcontent;
	}
	
	
}
