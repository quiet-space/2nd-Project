<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty property="userid" name="user"/>
<jsp:setProperty property="userpw" name="user"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인 액션</title>
</head>
<body>
	<%	String userid=null;
	if(session.getAttribute("userid")!=null){
		userid=(String)session.getAttribute("userid");
	}
	if(userid!=null){
		PrintWriter script= response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 이미 되었습니다.')");
		script.println("location.href='01_index.html'");
		script.println("</script>");
	}
		UserDAO userDAO=new UserDAO();
		int result = userDAO.login(user.getUserid(),user.getUserpw());//login-id login-password
		
				
		if(result ==1){
			session.setAttribute("userid", user.getUserid());
			PrintWriter script= response.getWriter();
			script.println("<script>");
			script.println("location.href='01_index.html'");
			script.println("</script>");
		}else if(result ==0){
			PrintWriter script= response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호 틀렸습니다')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result ==-1){
			PrintWriter script= response.getWriter();
			script.println("<script>");
			script.println("alert('아이디가 없습니다')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>