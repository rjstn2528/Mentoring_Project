<!-- 김도은 / 공지글 삭제 요청 처리 -->
<%@ include file="common/header.jsp"%>

<%@ page import="vo.*, utils.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%

	// 비로그인 상태이거나 관리자 계정이 아닌 경우 접근 제한
	if(loginMember == null || loginMember != null && !loginMember.getId().equals("admin")){
		response.sendError(403);
		return;
	}

	// 전달 받은 파라미터 가져오기
	String strNum = request.getParameter("num");
	int num = 0;
	if(strNum != null){
		num = Integer.parseInt(strNum);
	}
	
	int pageNum = 1;
	String strPageNum = request.getParameter("page");
	if(strPageNum != null){
		pageNum = Integer.parseInt(strPageNum);
	}
	
	if(num == 0 || strPageNum == null){
		// 파라미터가 하나라도 넘어오지 않은 경우 접근 제한
		response.sendError(403);
		return;
	}
%>

<!-- 공지글 목록으로 돌아가기 위해 정보를 넘겨줄 폼 -->
<form action="noticeList.jsp" method="post" id="goBack">
	<input type="hidden" name="page" value="<%=pageNum%>">
</form>

<!-- 삭제에 실패할 경우 공지글 상세 페이지로 돌아가기 위해 정보를 넘겨줄 폼 -->
<form action="noticeDetail.jsp" method="post" id="goBackDetail">
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="page" value="<%=pageNum%>">
</form>

<%	
	// num으로 master 테이블에서 공지글 검색 & 삭제
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	
	String sql = "DELETE FROM master WHERE num = ?";
	int result = 0;
	
	
	try{
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, num);
		
		result = pstmt.executeUpdate();
		
		if(result == 1){
			msg = "공지를 삭제했습니다.";
		}else{
			msg = "공지를 삭제하지 못했습니다.";
		}
		
		
	}catch(Exception e){
		e.getStackTrace();
		response.sendError(500);
		return;
	}finally{
		DBCPUtil.close(pstmt, conn);
		session.setAttribute("msg", msg);
		out.print("<script>");
		
		if(result == 1){
			// 삭제에 성공하면 공지 사항 목록 페이지로
			out.print("document.getElementById('goBack').submit();");
		}else{
			// 삭제에 실패하면 기존 공지글 상세 페이지로
			out.print("document.getElementById('goBackDetail').submit();");
		}
		
		out.print("</script>");
	}
	
	
%>
