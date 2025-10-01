<!-- 김도은 / 공지글 수정 요청 처리 페이지 -->
<%@ include file="common/header.jsp"%>

<%@page import="vo.*, utils.*, java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	// post 방식으로 전달 받은 파라미터 가져오기
	String title = request.getParameter("title");
	String content = request.getParameter("content");
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
	
	if(loginMember == null || !loginMember.getId().equals("admin") ||
	   title == null || content == null || num == 0 || strPageNum == null){
		// 비로그인 상태이거나 관리자 계정이 아닌 경우, 파라미터가 하나라도 안 넘어온 경우(잘못된 경로) 접근 제한
		response.sendError(403);
		return;
	}
	
%>

<!-- 공지글 상세 페이지로 돌아가기 위해 정보를 넘겨줄 폼 -->
<form action="noticeDetail.jsp" method="post" id="goBack">
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="page" value="<%=pageNum%>">
</form>

<%	
	// num으로 master 테이블에서 공지글 검색 & 업데이트
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	
	String sql = "UPDATE master SET title = ?, content = ? WHERE num = ?";
	
	try{
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setInt(3, num);
		
		int result = pstmt.executeUpdate();
		
		if(result == 1){
			msg = "공지가 수정되었습니다.";
		}else{
			msg = "공지를 수정하지 못했습니다.";
		}
		
	}catch(Exception e){
		msg = "공지를 수정하지 못했습니다. : "+e.getMessage();
	}finally{
		DBCPUtil.close(pstmt, conn);
		session.setAttribute("msg", msg);
		out.print("<script>");
		out.print("document.getElementById('goBack').submit();");
		out.print("</script>");
	}
	
	
	
%>

