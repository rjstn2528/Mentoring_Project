<!-- 김진주 -->
<!-- 공통 헤더 -->
<%@page import="vo.MemberVO, java.sql.*, utils.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

	MemberVO loginMember = (MemberVO)session.getAttribute("login");

	

	Cookie[] cookies = request.getCookies();

	if(loginMember == null && cookies != null){

		for(Cookie c : cookies){

			if(c.getName().equals("rememberMe")){
				
				String id = c.getValue(); 
				
				
				Connection conn = DBCPUtil.getConnection();
				String sql = "SELECT * FROM member_table WHERE id = ?";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id); 
				
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()){

					loginMember = new MemberVO(	
							rs.getInt("num"),	
							rs.getString("id"),		
							rs.getString("pw"),		
							rs.getString("name"),		
							rs.getString("addr"),		
							rs.getString("email"),		
							rs.getString("phone"), 	
							rs.getString("role"),
							rs.getString("lang")
						);
						
					session.setAttribute("login", loginMember);
				} // end rs.next() if
				
				DBCPUtil.close(rs, pstmt, conn);
				break;
				
			} // rememberMe check
			
			
		} // end cookies for 
	} // check cookies
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mentoring Project</title>
<link href="css/header.css" rel="stylesheet" type="text/css" />
<link href="css/common.css" rel="stylesheet" type="text/css" />
<link href="css/footer.css" rel="stylesheet" type="text/css" />
<link href="css/rating.css" rel="stylesheet" type="text/css" />
<link href="css/admin.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<header>
    <!-- 윗줄 네비 -->
    <div class="nav">   
        <ul>
            <li><a href="index.jsp">Home</a></li>
            <% if(loginMember == null){ %>
                <li><a href="login.jsp">로그인</a></li>
                <li><a href="join.jsp">회원가입</a></li>
            <% } else { %>
                <li><a href="info.jsp"><%= loginMember.getName() %></a>님</li>
                <li><a href="logout.jsp">로그아웃</a></li>
                <% if(loginMember.getId().equals("admin")){ %>
                    <li><a href="memberList.jsp">회원관리</a></li>
                <% } %>
            <% } %>
        </ul>
    </div>


    <div class="notice">   
        <ul>
            <li><a href="noticeList.jsp">공지사항</a></li>
        </ul>
    </div>
</header>
	
<%
	// 김도은 - 세션에 저장된 메세지 읽어와서 알림 출력
	String msg = (String)session.getAttribute("msg");
	if(msg != null){
		// msg에 저장된 문자열이 있으면 출력, msg는 세션에서 삭제
		session.removeAttribute("msg");
%>
<script>
	alert('<%=msg%>');
</script>
<%		
	msg = null;
	}
%>	
	
	
	
	
	