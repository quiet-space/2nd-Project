package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class freeboardDAO {
	private Connection con;
	private ResultSet rs;
	
	
	public freeboardDAO() {
		try {
			String dbURL ="jdbc:mysql://localhost:3306/roomdb";
			String driver ="com.mysql.cj.jdbc.Driver";
			String dbID = "root";
			String dbPW ="1234";
			Class.forName(driver);
			con=DriverManager.getConnection(dbURL,dbID,dbPW);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public String getDate() {
		String SQL = "SELECT NOW()";//sql���� �ð� �������� �Լ�
		try {
			PreparedStatement pstmt=con.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";//���� �Ͻ� ���ڿ� ��ȯ
	}
	public int getNext() {
		String SQL = "SELECT fbn from freeboard ORDER BY fbn DESC";//�Խù� ��ȣ �����ͼ� �����ֱ� ��������
		try {
			PreparedStatement pstmt=con.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;//�Խù� �ۼ��� �ϳ��� �����ϱ� ������
			}
			return 1;//������ 1��° �Խù� �̱� ������ 1�� ��ȯ�Ѵ�
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return -1;//���� �Ͻ� -1 ��ȯ�ؼ� ���� �߻� Ȯ�ΰ���
	}
	public int write(String fbo, String userid, String fbrcontent) {
		String SQL = "INSERT INTO freeboard VALUES(?,?,?,?,?,?)";//�Խù� ��ȣ �����ͼ� �����ֱ� ��������
		
		try {
			PreparedStatement pstmt=con.prepareStatement(SQL);
			pstmt.setInt(1, getNext());//
			pstmt.setString(2, fbo);
			pstmt.setString(3, userid);//userid�� �ؾ���
			pstmt.setString(4, getDate());
			pstmt.setString(5, fbrcontent);
			pstmt.setInt(6, 1);//�����ϱ����� ��ȣ
			return pstmt.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return -1;//���� �Ͻ� -1 ��ȯ�ؼ� ���� �߻� Ȯ�ΰ���
	}
	public ArrayList<freeboard> getList(int pageNumber){
		String SQL = "Select * from freeboard where fbn < ? AND fbavaliable =1 ORDER by fbn DESC LIMIT 30";
		//�Խù� ��ȣ �����ͼ� �����ֱ� �������� ���ø� �ٽ�¥����
		
		ArrayList<freeboard> list= new ArrayList<freeboard>();
		
		try {
			PreparedStatement pstmt=con.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber -1)*30);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				freeboard freeboard=new freeboard();
				freeboard.setFbn(rs.getInt(1));
				freeboard.setFbo(rs.getString(2));
				freeboard.setUserid(rs.getString(3));
				freeboard.setFbd(rs.getString(4));
				freeboard.setFbrcontent(rs.getString(5));
				freeboard.setFbavaliable(rs.getInt(6));
				list.add(freeboard);
			}
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return list;//���� �Ͻ� -1 ��ȯ�ؼ� ���� �߻� Ȯ�ΰ���
		
	}
	public boolean nextPage(int pageNumber) {
		String SQL = "Select * from freeboard where fbn < ? AND fbavaliable =1";//�Խù� ��ȣ �����ͼ� �����ֱ� ��������
		
		try {
			PreparedStatement pstmt=con.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber -1)*30);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;//������������ 
	}
	public freeboard getfreeboard(int fbn) {
		String SQL = "SELECT * FROM freeboard where fbn=?";
		try {
			PreparedStatement pstmt=con.prepareStatement(SQL);
			pstmt.setInt(1, fbn);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				freeboard freeboard=new freeboard();
				freeboard.setFbn(rs.getInt(1));
				freeboard.setFbo(rs.getString(2));
				freeboard.setUserid(rs.getString(3));
				freeboard.setFbd(rs.getString(4));
				freeboard.setFbrcontent(rs.getString(5));
				freeboard.setFbavaliable(rs.getInt(6));
				return freeboard;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return null;
		
	}
	public int update(int fbn, String fbo, String fbrcontent) {
		String SQL ="UPDATE freeboard set fbo=?,fbrcontent,where fbn=?";
		try {
			PreparedStatement pstmt=con.prepareStatement(SQL);
			pstmt.setString(1, fbo);
			pstmt.setString(2, fbrcontent);
			pstmt.setInt(3, fbn);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public int delete(int fbn) {
		String SQL ="UPDATE freeboard set fbavaliable = 0 where fbn=?";
		try {
			PreparedStatement pstmt=con.prepareStatement(SQL);
			pstmt.setInt(1, fbn);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
