<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.freeboardDAO"%>
<%@ page import="board.freeboard"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="board" class="board.freeboard" scope="page" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>룸메이트 - 방을 구하는 가장 쉬운 방법</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<link href="css/styles2.css" rel="stylesheet" />
<link href="css/styles3.css" rel="stylesheet" />
</head>
<body>
	<%
		String userid = null;
		if (session.getAttribute("userid") != null) {
			userid = (String) session.getAttribute("userid");
		}

		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));

		}
	%>
	<!--상단 네비게이션 메뉴-->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="01_index.html">룸메이트</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="navbarDropdown"
						href="02_onroomPage.html" role="button" data-bs-toggle="dropdown"
						aria-expanded="false">원룸</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="/02_onroomPage.html">방
									찾기</a></li>
							<li><hr class="dropdown-divider" /></li>
							<li><a class="dropdown-item" href="#!">찜한 매물</a></li>
							<li><hr class="dropdown-divider" /></li>
							<li><a class="dropdown-item" href="#!">방 내놓기</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="navbarDropdown"
						href="04_tworoomPage.html" role="button" data-bs-toggle="dropdown"
						aria-expanded="false">투룸 / 빌라</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="/04_tworoomPage.html">투룸
									/ 빌라 찾기</a></li>
							<li><hr class="dropdown-divider" /></li>
							<li><a class="dropdown-item" href="#!">찜한 매물</a></li>
							<li><hr class="dropdown-divider" /></li>
							<li><a class="dropdown-item" href="#!">투룸 / 빌라 내놓기</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="navbarDropdown"
						href="06_aptPage.html" role="button" data-bs-toggle="dropdown"
						aria-expanded="false">아파트</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="/06_aptPage.html">아파트
									매매</a></li>
							<li><hr class="dropdown-divider" /></li>
							<li><a class="dropdown-item" href="#!">전세 / 월세</a></li>
							<li><hr class="dropdown-divider" /></li>
							<li><a class="dropdown-item" href="#!">신축분양</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">커뮤니티</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="10_freeboard.jsp">자유게시판</a></li>
							<li><hr class="dropdown-divider" /></li>
							<li><a class="dropdown-item" href="#!">인테리어게시판</a></li>
							<li><hr class="dropdown-divider" /></li>
							<li><a class="dropdown-item" href="#!">법률상담게시판</a></li>
							<li><hr class="dropdown-divider" /></li>
							<li><a class="dropdown-item" href="#!">부동산정보게시판</a></li>
						</ul></li>
				</ul>
				<%
					if (userid == null) {
				%><form class="d-flex" action="09_signup.html">
					<button class="btn btn-outline-dark" href="#">회원가입</button>
				</form>
				<form class="d-flex" action="08_login.html">
					<button class="btn btn-outline-dark" type="submit">로그인</button>
				</form>
				<%
					} else {
				%>
				<form class="d-flex" action="08_logoutAction.jsp">
					<button class="btn btn-outline-dark" type="submit"></button>
					로그아웃
				</form>
				<%
					}
				%>

			</div>
		</div>
	</nav>

	<!--상단 메인 배너-->
	<div class="bg-dark py-6">
		<!--bg-dark가 메인 배너 색상-->
		<img src="/img/hito.png" class="main-person">
		<div class="container px-4 px-lg-5 my-5 main-banner-text">
			<div class="text-start text-white">
				<h1 class="display-6 fw-bolder">
					방 찾으러 멀리 갈 필요 있어?<br>가까운 <span style="color: yellow;">'룸메이트'</span>에게
					물어봐!
				</h1>
				<br>
				<p class="lead fw-normal text-white-50 mb-0">방을 찾는 가장 쉬운 방법,
					룸메이트</p>
			</div>
		</div>
	</div>
	
	<!--원룸 매물 노출 섹션-->
	<section class="container px-lg-5 my-0" style="margin-top:20px;">
		<div class="top-btn">
			<form method="post" action="10_freeboard.jsp">
				<input type="submit" value="자유게시판" class="btn-cst btn-outline-dark">
			</form>
			<form method="post" action="#.jsp">
				<input type="submit" value="인테리어게시판" class="btn-cst btn-outline-dark">
			</form>
			<form method="post" action="#.jsp">
				<input type="submit" value="법률상담게시판" class="btn-cst btn-outline-dark">
			</form>
			<form method="post" action="#.jsp">
				<input type="submit" value="부동산정보게시판" class="btn-cst btn-outline-dark">
			</form>
		</div>
		<div>
			<table style="width: 100%;">
				<colgroup>
					<col width="10%">
					<col width="60%">
					<col width="10%">
					<col width="10%">
					<col width="5%">
					<col width="5%">
				</colgroup>
				<thead>
					<tr>
						<th id="bN"><h6 class="display-10 fw-bolder">번호</h6></th>
						<th id="bO"><h6 class="display-10 fw-bolder">제목</h6></th>
						<th id="bW"><h6 class="display-10 fw-bolder">작성자</h6></th>
						<th id="bD"><h6 class="display-10 fw-bolder">작성일</h6></th>
						<th id="bR"><h6 class="display-10 fw-bolder">추천</h6></th>
						<th id="b0"><h6 class="display-10 fw-bolder">조회</h6></th>
					</tr>
				</thead>

				<tbody>
					<%
						freeboardDAO freeboardDAO = new freeboardDAO();
						ArrayList<freeboard> list = freeboardDAO.getList(pageNumber);
						for (int i = 0; i < list.size(); i++) {
					%>
					<tr style="border-bottom-width: 10px; border-color: white;">
						<td style="text-align: center;"><%=list.get(i).getFbn()%></td>
						<td><a href="10_boardview.jsp?fbn=<%=list.get(i).getFbn()%>"><%=list.get(i).getFbo()%></a>
						</td>
						<!-- 링크걸어서 글내용 보이게 -->
						<td style="text-align: center;"><%=list.get(i).getUserid()%></td>
						<td style="text-align: center;"><%=list.get(i).getFbd().substring(0, 10)%></td>
						<td style="text-align: center;">0</td>
						<td style="text-align: center;">0</td>

					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
		<div class="fb-bottom-btn">
			<%
				if (pageNumber != 1) {
			%>
			<button class="btn btn-outline-dark Previous">
				<a href="10_freeboard.jsp?pageNumber=<%=pageNumber - 1%>">이전페이지</a>
			</button>
			<%
				}
				if (freeboardDAO.nextPage(pageNumber + 1)) {
			%>
			<button class="btn btn-outline-dark nextpage">
				<a href="10_freeboard.jsp?pageNumber=<%=pageNumber + 1%>">다음페이지</a>
			</button>
			<%
				}
			%>
			<button class="btn btn-outline-dark new-writh">
				<a href='11_boardwrite.jsp'>글쓰기</a>
			</button>
		</div>
		<hr class="bar">
	</section>

	<!-- Footer-->
	<footer class="container px-0 py-5 gx-1 gx-4 gx-lg-5 bg-white">
		<div class="px-0 px-5 gx-lg-5 bottom-site">
			<div class="sv">
				<p>고객센터&nbsp;1588-5353</p>
				<p>9 : 30 ~ 18 : 00</p>
				<p>(점심시간 13:00 ~ 14:00)</p>
				<p>주말, 법정공휴일 휴무</p>
				<a class="btn btn-outline-dark mt-auto qa-button" href="#">1:1
					문의</a><br> <img src="/img/Asset 1.png" class="logo">
			</div>
			<div class="b0">
				<!--공백 174px-->
			</div>
			<div class="b1">
				<p class="bold">룸메이트</p>
				<p>룸메이트 메인</p>
				<p>원룸</p>
				<p>투룸 / 빌라</p>
				<p>아파트</p>
				<p>커뮤니티</p>
			</div>
			<div class="b2">
				<p class="bold">룸메이트 정보</p>
				<p>서비스 소개</p>
				<p>인재영입</p>
				<p>룸메이트 PRESS</p>
				<p>크레딧</p>
			</div>
			<div class="b3">
				<p class="bold">관련사이트</p>
				<p>룸메이트 유튜브</p>
				<p>룸메이트 인스타그램</p>
				<p>룸메이트 페이스북</p>
				<p>룸메이트 블로그</p>
				<p>룸메이트 카페</p>
			</div>
			<div class="b4">
				<p class="bold">지원</p>
				<p>공지사항</p>
				<p>자주 묻는 질문</p>
				<p>이용약관</p>
				<p>개인정보처리지침</p>
				<p>전문가 센터</p>
				<p>사이트맵</p>
			</div>
		</div>
		<hr>
		<div class="bottom-anounce">
			<p class="copy1 m-0 text-center text-dark">(주)룸메이트 / 서울시 서초구
				룸메이트로 1028 룸메빌딩 / 대표 : 강하종 / 개인정보관리책임자 : 김희태, 사유진, 신혜지 / 사업자등록번호 :
				202-11-02814 / 통신판매업신고 : 2021-서울강남-211028호</p>
			<p class="copy2 m-0">(주)룸메이트 사이트의 상품/판매회원/중개 서비스/거래 정보, 콘텐츠, UI
				등에 대한 무단복제, 전송, 배포, 스크래핑 등의 행위는 저작권법, 콘텐츠산업 진흥법 등 관련법령에 의하여 엄격히
				금지됩니다. [안내보]</p>
			<p class="copy2 m-0">(주)룸메이트는 통신판매중개자이며, 통신판매의 당사자가 아닙니다. 상품,
				상품정보, 거래에 관한 의무와 책임은 판매회원에게 있습니다. / Copyright &copy; 2021 roommate
				Inc. All rights reserved from Bernie_Alex</p>
		</div>
	</footer>

	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
</body>
</html>
