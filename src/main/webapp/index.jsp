<!-- 김도은 / 인덱스 페이지 -->
<%@ include file="common/header.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script>
	function goToCheck(){
		location.href="checkMentor.jsp";
	}
	
	function goToList(){
		location.href="mentorList.jsp";
	}
</script>
<section id="index">

	<div class="box">
		<div id="mentorBox" onclick="goToCheck()">
			<span class="role">멘토</span><span class="txt">이신가요?</span>
		</div>
		<div id="menteeBox" onclick="goToList()">
			<span class="role">멘티</span><span class="txt">이신가요?</span>
		</div>
	</div>
</section>


    
<%@ include file="common/footer.jsp"%>