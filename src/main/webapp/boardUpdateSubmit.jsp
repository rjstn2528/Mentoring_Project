<!-- 김도은 / 게시글 수정 요청 처리 -->
<%@ include file="common/header.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.DBCPUtil" %>
<%

	// 파라미터로 전달 받은 멘토/멘티 아이디와 게시글 번호, rn
	String mentorId = request.getParameter("mentorId");
	String menteeId = request.getParameter("menteeId");
	String strNum = request.getParameter("num");
	int num = 0;
	if(strNum != null){
		num = Integer.parseInt(strNum);
	}
	
	String strRNum = request.getParameter("rn");
	int rn = 0;
	if(strRNum != null){
		rn = Integer.parseInt(strRNum);
	}
	
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String category = request.getParameter("category");
	
	if(loginMember == null || !loginMember.getId().equals(menteeId) ||
	   menteeId == null || strNum == null || strRNum == null || title == null || content == null || category == null){
		// 비로그인 상태이거나 파라미터가 넘어오지 않은 경우
		response.sendError(403);
		return;
	}
	
%>
<!-- 게시글 상세 페이지로 돌아가기 위해 정보를 넘겨줄 폼 -->
<form action="boardDetail.jsp" method="post" id="goBack">
	<input type="hidden" name="mentorId" value="<%=mentorId%>">
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="rnum" value="<%=rn%>">
</form>
<%
	// 게시글 수정된 데이터로 업데이트	
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	
	String sql = "UPDATE board_table SET title = ?, content = ?, category = ? WHERE num = ?";

	try{
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, category);
		pstmt.setInt(4, num);
		
		int result = pstmt.executeUpdate();
		
		if(result == 1){
			msg = "게시글 수정이 완료되었습니다.";
		}else{
			msg = "게시글 수정에 실패하였습니다.";
		}
		
	}catch(Exception e){
		e.printStackTrace();
		response.sendError(500);
		return;
	}finally{
		DBCPUtil.close(pstmt, conn);
		session.setAttribute("msg", msg);
		out.print("<script>");
		out.print("document.getElementById('goBack').submit();");
		out.print("</script>");
	}
%>



