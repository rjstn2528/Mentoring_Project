<!-- 민서진 -->
<%@ include file="common/header.jsp"%>
<%@ include file="checkAdmin.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="java.sql.*, utils.*" %>
<%

	String name = request.getParameter("name");
	String pw = request.getParameter("pw");
	String email = request.getParameter("email");
	String addr = request.getParameter("addr");
	String phone = request.getParameter("phone");
	String strNum = request.getParameter("num");

	Connection conn = null;
	PreparedStatement pstmt = null;

	int updated = 0;
	
	try {
		conn = DBCPUtil.getConnection();

		String sql = "UPDATE member_table SET ";
			   sql += "name = ?, ";
			   sql += "pw = ?, ";
			   sql += "email = ?, ";
			   sql += "addr = ?, ";
			   sql += "phone = ? ";
			   sql += "WHERE num = ?";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, pw);
		pstmt.setString(3, email);
		pstmt.setString(4, addr);
		pstmt.setString(5, phone);
		pstmt.setInt(6, Integer.parseInt(strNum));

/* 		int result = pstmt.executeUpdate();

		// 수정 성공 시 목록으로 이동
		response.sendRedirect("memberInfo.jsp"); */
		
		updated = pstmt.executeUpdate();

	    if (updated > 0) {
	        // 수정된 대상의 PK를 들고 정보 페이지로 이동
	        msg = "회원 정보를 수정했습니다.";
	    } else {
	        msg = "회원 정보를 수정하지 못했습니다.";
	    }

	} catch (Exception e) {
		e.printStackTrace();
		msg = "회원정보 수정 중 오류 발생";
	} finally {
		DBCPUtil.close(pstmt, conn);
		session.setAttribute("msg", msg);
		if(updated > 0){
			response.sendRedirect("memberInfo.jsp?num=" + strNum);
		}
	}
%>
