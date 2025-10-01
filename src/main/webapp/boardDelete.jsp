<!-- 김도은 / 게시글 삭제 처리 -->
<%@ include file="common/header.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*" %>

<%
	

	// post 방식으로 전송받은 파라미터
	String mentorId = request.getParameter("mentorId");
	String menteeId = request.getParameter("menteeId");
	String strNum = request.getParameter("num");
	int num = 0;
	if(strNum != null){
		num = Integer.parseInt(strNum);
	}
	String strRn = request.getParameter("rnum");
	int rn = 0;
	if(strRn != null){
		rn = Integer.parseInt(strRn);
	}
	
	if(loginMember == null || !loginMember.getId().equals(menteeId)
	   || mentorId == null || num == 0 || rn == 0){
	    // 비로그인 상태이거나 게시글을 작성한 멘티 본인이 아닌 경우, 파라미터가 하나라도 넘어오지 않은 경우 
		response.sendError(403);
	    return;
	}

%>
	<!-- 게시물 상세 페이지로 돌아가기 위해 정보를 넘겨줄 폼 -->
	<form action="boardDetail.jsp" method="post" id="goBack">
		<input type="hidden" name="mentorId" value="<%=mentorId%>">
		<input type="hidden" name="num" value="<%=num%>">
		<input type="hidden" name="rnum" value="<%=rn%>">
	</form>
	
	<form action="boardList.jsp" method="post" id="goList">
		<input type="hidden" name="mentorId" value="<%=mentorId%>">
	</form>
<%
	//게시글에 달린 답변이 있다면 답변부터 삭제
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	boolean isAnswer = false;
	
	String sql = "SELECT * FROM answer_table WHERE board_num = ?";
	
	try{
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, num);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			// 답변이 있는 게시글이라면 isAnswer true로 만들기
			isAnswer = true;
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBCPUtil.close(pstmt, conn);
	}
	
	
	int result = 0;
	
	
	if(isAnswer){ // 답변이 있다면 답변부터 삭제
	
		sql = "DELETE FROM answer_table WHERE board_num = ?";
		
		try{
			conn = DBCPUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			result = pstmt.executeUpdate();
			
			if(result == 1){
				System.out.println("답변 삭제 성공");
			}else{
				System.out.println("답변 삭제 실패");
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBCPUtil.close(pstmt, conn);
			out.print("<script>");
			if(result == 0){
				// 답글 삭제 실패할 경우 기존 게시글로
				out.print("document.getElementById('goBack').submit();");
			}
			out.print("</script>");
		}
	}
	
	boolean isRate = false;
	result = 0; // 다시 0으로 초기화
	
	// 완료 후 별점을 준 게시글인지 확인
	sql = "SELECT * FROM rating WHERE board_num = ?";
	
	try{
		conn = DBCPUtil.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, num);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			// 별점이 있는 게시글이라면 isRate true로 만들기
			isRate = true;
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBCPUtil.close(pstmt, conn);
	}
	
	// 별점 테이블에서 별점 삭제
	
	if(isRate){
		sql = "DELETE FROM rating WHERE board_num = ?";
		
		try{
			conn = DBCPUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			result = pstmt.executeUpdate();
			
			if(result == 1){
				System.out.println("별점 삭제 성공");
			}else{
				System.out.println("별점 삭제 실패");
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBCPUtil.close(pstmt, conn);
			out.print("<script>");
			if(result == 0){
				// 별점 삭제 실패할 경우 기존 게시글로
				out.print("document.getElementById('goBack').submit();");
			}
			out.print("</script>");
		}
		
	} // 별점 삭제
	
	
	// 답변+별점이 없거나 삭제에 성공했다면 num으로 해당 게시글 검색 후 삭제
	conn = DBCPUtil.getConnection();
	
	sql = "DELETE FROM board_table WHERE num = ?";
	
	try{
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, num);
		
		result = pstmt.executeUpdate();
		
		if(result == 1){
			msg = "게시글이 삭제되었습니다.";
		}else{
			msg = "게시글 삭제에 실패하였습니다.";
		}
		
	}catch(Exception e){
		e.printStackTrace();
		response.sendError(500);
		return;
	}finally{
		DBCPUtil.close(pstmt, conn);
		session.setAttribute("msg", msg);
		out.print("<script>");
		if(result == 1){
			// 게시글 삭제 & 답변 삭제 성공할 경우 멘토 페이지(게시글 목록)로
			out.print("document.getElementById('goList').submit();");
		}else{
			// 게시글 삭제 실패할 경우 다시 기존 게시글로
			out.print("document.getElementById('goBack').submit();");
		}
		out.print("</script>");
	}
	
	
%>