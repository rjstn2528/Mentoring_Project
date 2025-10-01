<!-- 김도은 / 에러 페이지 -->

<%@ include file="../common/header.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<section id="error">
	<div id="text">
		<h1>잘못된 요청입니다.</h1>
		<h4>요청하신 정보를 처리할 수 없습니다.<br>확인 후 다시 요청해 주세요.</h4>
		
		<div class="btnBox">
		<a href="index.jsp" class="goToMain"><button>메인으로</button></a>
		</div>
	</div>
</section>


<%@ include file="../common/footer.jsp"%>
