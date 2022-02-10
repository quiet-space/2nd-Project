<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty property="userid" name="user"/>
<jsp:setProperty property="userpw" name="user"/>
<jsp:setProperty property="userpn" name="user"/>
<jsp:setProperty property="useremail" name="user"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인 액션</title>
</head>
<body>
	<%	
	
	
	if(user.getUserid()==null||user.getUserpw()==null||user.getUserpn()==null||user.getUseremail()==null){
		PrintWriter script= response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 필요합니다')");
		script.println("history.back()");
		script.println("</script>");
	}else{
		UserDAO userDAO=new UserDAO();
	int result = userDAO.join(user);
		if(result ==-1){
		PrintWriter script= response.getWriter();
		script.println("<script>");
		script.println("alert('해당 아이디가 존재합니다')");
		script.println("location.href='09_signup2.html'");
		script.println("</script>");
		}else{
		
		PrintWriter script= response.getWriter();
		script.println("<script>");
		script.println("location.href='09_signup3.html'");
		script.println("</script>");
	}
		
	}
		
		
	%>
</body>
</html>