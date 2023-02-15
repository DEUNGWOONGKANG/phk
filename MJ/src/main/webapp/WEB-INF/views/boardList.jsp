<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<%    request.setCharacterEncoding("UTF-8"); %>
<html>
  <head>
    <title>ADMIN PAGE</title>
    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="/resources/css/bootstrap.css">
    <link rel="stylesheet" href="/resources/css/jquery-ui.css">
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
    <!-- Google fonts - Popppins for copy-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:300,400,800">
    <!-- orion icons-->
    <link rel="stylesheet" href="/resources/css/orionicons.css">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="/resources/css/style.default.css" id="theme-stylesheet">
    <!-- Favicon-->
    <!-- <link rel="shortcut icon" href="img/favicon.png?3">-->
    
	<script src="/resources/js/jquery-3.4.1.min.js"></script>
	<script src="/resources/js/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="/resources/js/bootstrap.js"></script>
    <script src="/resources/js/jquery.cookie.js"> </script>
    <script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
    <script src="/resources/js/front.js"></script>
<script type="text/javascript">
$(function(){
    $("#startdate").datepicker();
    $("#enddate").datepicker();
    if("${saveYn}" == "Y"){
    	alert("저장되었습니다.");
    }
});
$.datepicker.setDefaults({
    dateFormat: 'yy-mm-dd',
    prevText: '<',
    nextText: '>',
    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
    showMonthAfterYear: true,
    yearSuffix: '년'
});
function deleteData(id){
	var result = confirm("삭제하시겠습니까?");
	if(result == true){
		location.href="/deleteBoard/"+id;
	}
}
function modifyData(id){
	window.open('/boardModify/'+id
			, 'boardModify', 'height=600,width=1200');
}
function boardAdd(){
	window.open('/boardAdd'
			, 'boardAdd', 'height=400,width=1000');
}
function check(){
	var startDate = $("#startdate").val();
	var endDate = $("#enddate").val();
	if(startDate != '' && endDate != ''){
		var start = startDate.split('-');
		var end = endDate.split('-');
		var stdt = new Date();
		var eddt = new Date();
		stdt.setFullYear(start[0], start[1]-1, start[2]);
		eddt.setFullYear(end[0], end[1]-1, end[2]);
		if(stdt > eddt){
			alert("시작일이 종료일보다 큽니다.");
			return false;
		}
	}
	document.getElementById("searchForm").submit();
}
function boardInfo(id){
	window.open('/boardInfo/'+id
			, 'boardInfo', 'height=600,width=1200');
}
</script>
  </head>
  <body>
    <!-- navbar-->
    <jsp:include page="header.jsp"></jsp:include>
    <div class="d-flex align-items-stretch">
      <jsp:include page="menu.jsp"></jsp:include>
      <div class="w-100 d-flex flex-wrap">
      	<div class="container-fluid px-xl-5">
      		<div class="search">	
		    	<form id="searchForm" action="/boardSearch" method="post">
		    		<b>작성자:</b> <input type="text" class="inputText" placeholder="작성자" id="searchWriter" name="searchWriter" value="${search.searchWriter }">
		    		<b>제목:</b> <input type="text" class="inputText" placeholder="제목" id="searchTitle" name="searchTitle" value="${search.searchTitle }">
			  		<br><br>
			  		<b>작성일:</b> <input type="text" class="inputDate" id="startdate" name="startdate" value="${search.startdate }" autocomplete="off">  
					~ <input type="text" class="inputDate" id="enddate" name="enddate" value="${search.enddate }" autocomplete="off">
			  		&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="button-gray-small" value="검색" onclick="check()">
				</form>
			</div>
      	</div>
      	<c:if test="${!empty boardList}">
      		<span style="margin-left:20px;">총 ${totalCnt } 건</span>
	      	<table class="table table-hover" style="margin-left:10px;">
			  <thead>
			    <tr>
			      <th style="width:10%">NO</th>
			      <th style="width:50%">제목</th>
			      <th style="width:15%">작성자</th>
			      <th style="width:15%">작성일</th>
			      <th style="width:10%">관리</th>
			    </tr>
			  </thead>
			  <tbody>
			  	<c:forEach var="board" items="${boardList}" varStatus="status">
				    <tr style="cursor:pointer;" onclick="boardInfo('${board.id}')">
				      <th scope="row">${(pageMaker.cri.page-1)*10+status.count}</th>
				      <td>
						${board.title}
				      </td>
				      <td>
				      	${board.writer}
					  </td>
				      <td>
				      	<fmt:formatDate value="${board.created}" pattern="YYYY-MM-dd"/><br>
				      	<fmt:formatDate value="${board.created}" pattern="HH:mm:ss"/>
				      </td>
				      <td>
				      	<c:if test="${position eq '관리자'}">
				      	<button type="button" class="btn-outline-dark" onclick="modifyData('${board.id}')">수정</button>
				     	<br><button type="button" class="btn-outline-danger" onclick="deleteData('${board.id}')">삭제</button>
				     	</c:if>
				      </td>
				    </tr>
				</c:forEach>
			  </tbody>
			</table>
		</c:if>
		<c:if test="${empty boardList}">
			<div style="text-align:center;width:100%">
				<h2>데이터가 존재하지 않습니다.</h2>
			</div>
		</c:if>
		<div class="container">
			<div class="row">
				<div class="col">
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li class="page-item"><a class="page-link" href="/menu/menu0${pageMaker.makeBoardQuery(pageMaker.startPage - 1)}">&lt;</a></li>
						</c:if> 
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
							<c:choose>
								<c:when test="${idx eq pageMaker.cri.page}">
									<li class="page-item"><a class="page-link" href="/menu/menu0${pageMaker.makeBoardQuery(idx)}"><b>${idx}</b></a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a class="page-link" href="/menu/menu0${pageMaker.makeBoardQuery(idx)}">${idx}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${pageMaker.next}">
							<li class="page-item"><a class="page-link" href="/menu/menu0${pageMaker.makeBoardQuery(pageMaker.endPage + 1)}">></a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		<div style="width:80%;margin-left:auto;margin-right:auto;text-align:right;margin-bottom:30px;">
			<c:if test="${position eq '관리자'}">
			<input type="button" class="btn btn-dark" value="글 쓰기" onclick="boardAdd()">
			</c:if>
		</div>
      </div>
    </div>
  </body>
</html>