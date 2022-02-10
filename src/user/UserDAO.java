package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;



public class UserDAO {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
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
	public int login(String userID,String userPW) {
		String SQL = "SELECT userPW FROM user WHERE userID = ?";
		System.out.println("�α����Լ�ȣ��");
		try {
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPW)) {
					return 1;//�α���
				}
				else
					return 0;//��й�ȣ ����ġ
			}
			return -1;//���̵� ����
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return -2;//�����ͺ��̽� ����
	}
	public int join(User user) {
		String SQL="INSERT INTO USER VALUES(?,?,?,?)";
		try {
			pstmt=con.prepareStatement(SQL);
			pstmt.setString(1, user.getUserid());
			pstmt.setString(2, user.getUserpw());
			pstmt.setString(3, user.getUserpn());
			pstmt.setString(4, user.getUseremail());
			return pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
