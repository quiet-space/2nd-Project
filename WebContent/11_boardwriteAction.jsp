<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "board.freeboardDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="board" class="board.freeboard" scope="page"/>
<jsp:setProperty property="fbo" name="board"/>
<jsp:setProperty property="fbrcontent" name="board"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>룸메이트 - 방을 구하는 가장 쉬운 방법</title>
</head>
<body>
<% 
			String userid=null;
			if(session.getAttribute("userid")!=null){
				userid=(String)session.getAttribute("userid");
			}
			if(userid == null){
					PrintWriter script= response.getWriter();
					script.println("<script>");
					script.println("alert('로그인을 해야합니다.')");
					script.println("location.href='08_login.html'");
					script.println("</script>");
			}
			else if(board.getFbo()==null||board.getFbrcontent()==null){
			PrintWriter pw=response.getWriter();
			pw.println("<script>");
			pw.println("alert('제목이나 내용이 공란입니다')");
			pw.println("history.back()");
			pw.println("</script>");
			}else{
	freeboardDAO freeboardDAO= new freeboardDAO();
	int result=freeboardDAO.write(board.getFbo(), userid, board.getFbrcontent());
	if(result==-1){
		PrintWriter pw=response.getWriter();
		pw.println("<script>");
		pw.println("alert('실패했습니다')");
		pw.println("history.back()");
		pw.println("</script>");
	}
	else{
		PrintWriter pw=response.getWriter();
		pw.println("<script>");
		pw.println("location.href='10_freeboard.jsp'");
		pw.println("</script>");
	}
}
%>
</body>
</html>