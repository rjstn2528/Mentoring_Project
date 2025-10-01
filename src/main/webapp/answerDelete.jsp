<!-- 김도은 / 멘토 답변 삭제 요청 처리 -->
<%@ include file="common/header.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="utils.*, java.sql.*"%>

<%

	// post 방식으로 전송받은 파라미터
	String strANum = request.getParameter("aNum");
	int aNum = 0;
	if(strANum != null){
		aNum = Integer.parseInt(strANum);
	}
	String mentorId = request.getParameter("mentorId");
	String strBNum = request.getParameter("num");
	int bNum = 0;
	if(strBNum != null){
		bNum = Integer.parseInt(strBNum);
	}
	String strRn = request.getParameter("rnum");
	int rn = 0;
	if(strRn != null){
		rn = Integer.parseInt(strRn);
	}
	
	if(loginMember == null || !loginMember.getId().equals(mentorId)
	   || aNum == 0 || mentorId == null || bNum == 0 || rn == 0){
	    // 비로그인 상태이거나 답변을 작성한 멘토 본인이 아닌 경우, 파라미터가 하나라도 넘어오지 않은 경우 
		response.sendError(403);
	    return;
	}

%>
	<!-- 게시물 상세 페이지로 돌아가기 위해 정보를 넘겨줄 폼 -->
	<form action="boardDetail.jsp" method="post" id="goBack">
		<input type="hidden" name="mentorId" value="<%=mentorId%>">
		<input type="hidden" name="num" value="<%=bNum%>">
		<input type="hidden" name="rnum" value="<%=rn%>">
	</form>
<%
	
	// answer 테이블에서 해당 답변을 검색 후 삭제
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	
	String sql = "DELETE FROM answer_table WHERE num = ?";
	int result = 0;
	
	try{
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, aNum);
		
		result = pstmt.executeUpdate();
		
		if(result == 1){
			msg = "답변을 삭제했습니다.";
		}else{
			msg = "답변을 삭제하지 못했습니다.";
		}
		
	}catch(Exception e){
		e.getStackTrace();
		msg = "답변을 삭제하지 못했습니다. : " + e.getMessage();
	}finally{
		DBCPUtil.close(pstmt, conn);
		session.setAttribute("msg", msg);
		out.print("<script>");
		out.print("document.getElementById('goBack').submit();");
		out.print("</script>");
	}

%>
