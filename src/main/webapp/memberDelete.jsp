<!-- 민서진 -->
<%@ include file="common/header.jsp"%>

<%@ include file="checkAdmin.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*" %>

<%
	String strNum = request.getParameter("num");
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	String sql = "DELETE FROM member_table WHERE num =?";
	int result = 0;
	
	try{
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(strNum));
		
		result = pstmt.executeUpdate();
		if(result == 0){
			msg = "회원 정보 삭제에 실패했습니다.";
		}else{
			msg = "회원 정보를 삭제했습니다.";
		}
		
	}catch(Exception e){
		e.printStackTrace();
		response.sendError(500, e.getMessage());
		return;
	}finally{
		DBCPUtil.close(pstmt, conn);
		session.setAttribute("msg", msg);
		response.sendRedirect("memberList.jsp");
	}
%>










