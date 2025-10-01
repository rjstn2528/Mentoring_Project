<!-- 김진주 -->
<!-- 회원정보에서 회원탈퇴 -->
<%@ include file="common/header.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    String id = (String) session.getAttribute("id");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        conn = DBCPUtil.getConnection();

        String sql = "DELETE FROM member_table WHERE id=? AND pw=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, request.getParameter("pw"));

        int result = pstmt.executeUpdate();

        if (result > 0) {
            session.invalidate();  
%>
            <script>
                alert("회원 탈퇴가 완료되었습니다.");
                location.href="index.jsp"; 
            </script>
<%
        } else {
%>
            <script>
                alert("비밀번호가 틀렸습니다. 다시 시도해주세요.");
                history.back();
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            alert("오류가 발생했습니다.");
            history.back();
        </script>
<%
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>