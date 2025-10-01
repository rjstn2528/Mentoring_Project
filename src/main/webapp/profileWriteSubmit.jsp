<!-- 김도은 / 프로필 등록 요청 처리 -->
<%@ include file="common/header.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="vo.*, utils.*, java.sql.*"%>

<%
	
	String intro = request.getParameter("intro");

	if(intro == null || loginMember == null){
		
		// 자기 소개 정보가 안 넘어왔거나 로그인 하지 않은 경우
		response.sendError(403);
		return;
	}
	
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	
	String sql = "INSERT INTO mentor_profile(mentor_id, name, lang, email, introduction) VALUES(?, ?, ?, ?, ?)";
	
	int result = 0;
	String nextPage = null;
	
	try{
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, loginMember.getId());
		pstmt.setString(2, loginMember.getName());
		pstmt.setString(3, loginMember.getLang());
		pstmt.setString(4, loginMember.getEmail());
		pstmt.setString(5, intro);
		
		result = pstmt.executeUpdate();
		
		if(result == 1){
			// 입력 성공
			msg = "프로필이 등록되었습니다.";
			nextPage = "index.jsp";
		}else{
			msg = "프로필 등록에 실패했습니다.";
			nextPage = "info.jsp";
		}
		
	}catch(Exception e){
		e.printStackTrace();
		response.sendError(500);
	}finally{
		DBCPUtil.close(pstmt, conn);
		session.setAttribute("msg", msg);
		response.sendRedirect(nextPage);
	}

%>

