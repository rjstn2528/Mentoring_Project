<!-- 김도은 / 답변 요청 처리 -->
<%@ include file="common/header.jsp"%>

<%@ page import="vo.*, java.sql.*, utils.DBCPUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	String mentorId = request.getParameter("mentorId");
	String strBoardNum = request.getParameter("boardNum");
	int boardNum = 0;
	if(strBoardNum != null){
		boardNum = Integer.parseInt(strBoardNum);
	}
	String content = request.getParameter("content");
	String strRn = request.getParameter("rn");
	int rn = 0;
	if(strRn != null){
		rn = Integer.parseInt(strRn);
	}
	
	if(mentorId == null || boardNum == 0 || content == null || rn == 0 || 
	   loginMember == null || !loginMember.getId().equals(mentorId)){
		// 파라미터가 하나라도 넘어오지 않은 경우 & 로그인 멤버가 null이거나 답변을 달 수 있는 멘토 본인이 아닌 경우 접근 제한
		response.sendError(403);
		return;
	}
	
%>

<!-- 게시물 상세 페이지로 돌아가기 위해 정보를 넘겨줄 폼 -->
<form action="boardDetail.jsp" method="post" id="goBack">
	<input type="hidden" name="mentorId" value="<%=mentorId%>">
	<input type="hidden" name="num" value="<%=boardNum%>">
	<input type="hidden" name="rnum" value="<%=rn%>">
</form>

<%
	// 답변 테이블에 답변 저장	
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	
	try{
		String sql = "INSERT INTO answer_table(mentor_id, content, board_num) VALUES(?, ?, ?)";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, mentorId);
		pstmt.setString(2, content);
		pstmt.setInt(3, boardNum);
		
		int result = pstmt.executeUpdate();
		
		if(result == 1){
			msg = "답변이 등록되었습니다.";
		}else{
			msg = "답변 등록에 실패하였습니다.";
		}
		
	}catch(Exception e){
		e.getStackTrace();
		msg = "게시글 등록 실패 : " + e.getMessage();
	}finally{
		DBCPUtil.close(pstmt, conn);
		session.setAttribute("msg", msg);
		out.print("<script>");
		out.print("document.getElementById('goBack').submit();");
		out.print("</script>");
	}
	
%>