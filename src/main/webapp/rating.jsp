<!-- 김도은 / 별점 저장 및 멘토링 완료 요청 처리 -->
<%@ include file="common/header.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*, utils.*, java.sql.*" %>
<%
    // post로 전달 받은 멘토 아이디 & 게시글 번호
	String mentorId = request.getParameter("mentorId");
	String strNum = request.getParameter("num");
	int num = 0;
	if(mentorId != null && strNum != null){
		num = Integer.parseInt(strNum);
	}else{
		response.sendError(403);
		return;
	}
	
	// post로 전달 받은 별점
	String strRate = request.getParameter("rate");
	int rate = 0;
	if(strRate != null){
		rate = Integer.parseInt(strRate);
	}else{
		response.sendError(403);
		return;
	}
	
	
%>
	<!-- 해당 멘토 페이지로 돌아가기 위한 폼 -->
	<form action="boardList.jsp" id="goBack">
		<input type="hidden" name="mentorId" value="<%=mentorId%>">
		<input type="hidden" name="page" value="1">
	</form>

<%
	
	// 전달 받은 별점을 별점 저장용 테이블에 저장
	
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	
	String sql = "INSERT INTO rating(board_num, mentor_id, score) VALUES(?, ?, ?)";
	
	
	try{
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, num);
		pstmt.setString(2, mentorId);
		pstmt.setInt(3, rate);
		
		int result = pstmt.executeUpdate();
		
		if(result == 1){
			msg = "별점 작성이 완료되었습니다.";
			
		}else{
			msg = "별점 작성이 완료되지 않았습니다. 다시 시도해 주세요.";
		}
		
	}catch(Exception e){
		e.getStackTrace();
		msg = "별점 작성이 완료되지 않았습니다. "+e.getMessage();
	}finally{
		DBCPUtil.close(pstmt, conn);
		session.setAttribute("msg", msg);
	}
	
	
	// 별점을 저장까지 완료한 뒤에 해당 게시글 완료 처리
	conn = DBCPUtil.getConnection();
	pstmt = null;
	
	sql = "UPDATE board_table SET is_completed = 'Y' WHERE num = ?";
	
	try{
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, num);
		
		int rs = pstmt.executeUpdate();
		
		if(rs == 1){
			msg = "멘토링이 완료되었습니다. 감사합니다.";
		}
		
	}catch(Exception e){
		e.getStackTrace();
		msg = "멘토링을 완료하지 못했습니다. 다시 시도해 주세요. :"+e.getMessage();
	}finally{
		DBCPUtil.close(pstmt, conn);
		session.setAttribute("msg", msg);
		out.print("<script>");
		out.print("document.getElementById('goBack').submit();");
		out.print("</script>");
	}
%>
