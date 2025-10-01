<!-- 김도은 / 멘토 프로필 수정 요청 처리 -->
<%@ include file="common/header.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="vo.*, utils.*, java.sql.*"%>

<%
	String intro = request.getParameter("intro");

	if(loginMember == null || intro == null){
		response.sendError(403);
		return;
	}

	
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	
	String sql = "UPDATE mentor_profile SET introduction = ? WHERE mentor_id = ?";
	
	try{
	
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, intro);
		pstmt.setString(2, loginMember.getId());
		
		int result = pstmt.executeUpdate();
		
		if(result == 1){
			msg = "프로필 수정이 완료되었습니다.";
		}else{
			msg = "프로필 수정에 실패하였습니다.";
		}
	}catch(Exception e){
		e.printStackTrace();
		response.sendError(500);
	}finally{
		DBCPUtil.close(pstmt, conn);
		session.setAttribute("msg", msg);
		response.sendRedirect("info.jsp");
	}
	
%>

