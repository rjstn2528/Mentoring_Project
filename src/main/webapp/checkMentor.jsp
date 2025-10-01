<!-- 김도은 / 메인 화면에서 멘토 전용 버튼 클릭 시 로그인 멤버가 멘토인지 체크 -->
<%@ include file="common/header.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
<%
	
	
	String mentorId = null;

	if(loginMember == null){
		// 비로그인 상태일 경우 알림 띄운 후 로그인 페이지로
		msg = "로그인 후 이용 가능한 페이지입니다.";
		session.setAttribute("msg", msg);
		response.sendRedirect("login.jsp"); 
	}
	
	if(loginMember != null && loginMember.getRole().equals("멘토")){
		// 로그인 한 멤버가 멘토일 경우 프로필을 등록했는지 먼저 확인 후 등록한 프로필이 있으면 멘토 페이지 이동
		 // 멘토라면 로그인 멤버 아이디 저장
		
		Connection conn = DBCPUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM mentor_profile WHERE mentor_id = ?";
		
		try{
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, loginMember.getId());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				// 프로필이 있음
				// 해당 멘토의 아이디를 mentorId에 저장 후 멘토 페이지로 이동
				mentorId = loginMember.getId();
			}else{
				msg = "프로필 등록 후 이용 가능한 페이지입니다.";
			}
		}catch(Exception e){
			e.printStackTrace();
			response.sendError(500);
		}finally{
			DBCPUtil.close(rs, pstmt, conn);
			if(mentorId != null){
				// 프로필 등록된 멘토일 경우 멘토 페이지로 이동
				response.sendRedirect("boardList.jsp?mentorId="+mentorId);
			}else{
				// 프로필 등록 안 된 멘토일 경우 알림 띄운 후 메인으로 이동
				session.setAttribute("msg", msg);
				response.sendRedirect("index.jsp");
			}
		}
		
	}
	
	if(loginMember != null && !loginMember.getRole().equals("멘토") || 
	   loginMember != null && loginMember.getId().equals("admin")){
	  // 로그인 멤버가 멘토가 아니거나 관리자일 경우
	  msg = "멘토만 이용 가능한 페이지입니다.";
	  session.setAttribute("msg", msg);
	  response.sendRedirect("index.jsp");
	  return;
	}

%>