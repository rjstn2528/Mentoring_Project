<!-- 김도은 / 에러 페이지 -->

<%@ include file="../common/header.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<section id="error">
	<div id="text">
		<h1>잘못된 요청입니다.</h1>
		<h3>요청하신 페이지를 찾을 수 없습니다.</h3>
		<div class="btnBox">
		<a href="javascript:history.go(-1);" class="goToPrev"><button>이전 페이지</button></a>
		<a href="index.jsp" class="goToMain"><button>메인으로</button></a>
		</div>
	</div>
</section>


<%@ include file="../common/footer.jsp"%>