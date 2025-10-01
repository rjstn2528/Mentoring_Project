<!-- 김진주 -->
<%@ include file="common/header.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*" %>

<%
		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		
		String nextPage = "";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

	try {
		conn = DBCPUtil.getConnection();
		
		String sql = "SELECT * FROM member_table WHERE id=? AND email=? AND phone=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, email);
		pstmt.setString(3, phone);
		
		rs = pstmt.executeQuery();

		if (rs.next()) {
		
			sql = "UPDATE member_table SET pw=? WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "0000");
			pstmt.setString(2, id);
		
			int result = pstmt.executeUpdate();
		
			if (result > 0) {
				msg = "비밀번호가 0000으로 재설정되었습니다. 로그인 후 반드시 변경해주세요.";
				nextPage = "login.jsp";
			} else {
				msg = "비밀번호 재설정에 실패했습니다. 다시 시도해주세요.";
				nextPage = "findPw.jsp";
			}
	
		} else {
			msg = "입력하신 정보와 일치하는 회원이 없습니다.";
			nextPage = "findPw.jsp";
		}

	} catch (Exception e) {
		e.printStackTrace();
		msg = "오류가 발생했습니다.";
		nextPage = "findPw.jsp";

	} finally {
		try { if (rs != null) rs.close(); } catch (Exception e) {}
		try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
		try { if (conn != null) conn.close(); } catch (Exception e) {}
		session.setAttribute("msg", msg);
		response.sendRedirect(nextPage);
	}
%>
