<!-- 김도은 / 별점 작성 폼 -->
<%@ include file="common/header.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// post로 받은 멘토 아이디 & 멘토 이름 & 게시글 번호
	String mentorId = request.getParameter("mentorId");
	String mName = request.getParameter("mName");
	String strNum = request.getParameter("num");
	int num = 0;
	if(strNum != null){
		num = Integer.parseInt(strNum);
	}
	
	if(mentorId == null || mName == null || strNum == null || loginMember == null){
		response.sendError(403);
		return;
	}
	
%>
    

<script>
	
	function setRating(score){
		
		// rating.jsp로 보낼 별점 저장
		document.getElementById('inputRate').value = score;
		
		for(let i = 1; i <= 5; i++){
			// 클릭된 별 개수만큼 ★로 표시
			
			const star = document.getElementById('star'+i);
					
			if(i <= score){
				star.textContent = '★';
			}else{
				star.textContent = '☆';
			} // end if
		} // end for
		
	} // end setRating()
	
	
</script>
<section id="rating">
	<p id="titleR"><span id="mNameR"><%=mName%></span> 멘토의 멘토링 어떠셨나요?</p>
	<hr>
	<form action="rating.jsp" method="post">
		<input type="hidden" name="mentorId" value="<%=mentorId%>">
		<input type="hidden" name="num" value="<%=num%>">
		
		<!-- 선택한 별 개수 전달할 히든 타입 인풋 -->
		<input type="hidden" id="inputRate" name="rate">
	
		<div id="starBox">
			<span onclick="setRating(1)" id="star1">☆</span>
			<span onclick="setRating(2)" id="star2">☆</span>
			<span onclick="setRating(3)" id="star3">☆</span>
			<span onclick="setRating(4)" id="star4">☆</span>
			<span onclick="setRating(5)" id="star5">☆</span>
			<input type="submit" value="별점 주기" id="btn">
		</div>
	
	</form>
</section>

<%@ include file="common/footer.jsp"%>
