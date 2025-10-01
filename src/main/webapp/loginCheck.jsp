<!-- 김진주 -->
<%@ include file="common/header.jsp"%>

<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*, utils.*" %>

<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
		
	String nextPage = "login.jsp"; 

	try{
		
		String sql = "SELECT * FROM member_table WHERE id = ? AND pw = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		
		
		rs = pstmt.executeQuery();
		
		if(rs.next()){

			msg = "로그인 성공";
			nextPage = "index.jsp"; 
		
			loginMember = new MemberVO();

			loginMember.setId(rs.getString("id"));	
			loginMember.setPw(rs.getString("pw"));	
			loginMember.setName(rs.getString("name"));	
			loginMember.setAddr(rs.getString("addr"));	
			loginMember.setEmail(rs.getString("email"));	
			loginMember.setPhone(rs.getString("phone"));	
			loginMember.setRole(rs.getString("role"));
			loginMember.setLang(rs.getString("lang"));
			
			session.setAttribute("id", id);
			session.setAttribute("login", loginMember);
	
			String login = request.getParameter("login");
			
			if(login != null){				
				Cookie cookie = new Cookie("rememberMe", id);
				cookie.setMaxAge(60 * 60 * 3); 
				cookie.setPath("/");
				
				response.addCookie(cookie);
				
			}
		}else{
			msg = "로그인 실패";		
		} // end rs.next() if
			
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
		session.setAttribute("msg", msg);
	}
	
%>
<script>
	location.replace('<%=nextPage%>');
</script>

