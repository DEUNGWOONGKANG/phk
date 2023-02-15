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
    $("#dbstartdate").datepicker();
    $("#dbenddate").datepicker();
    $("#depositstartdate").datepicker();
    $("#depositenddate").datepicker();
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
function deleteLog(id){
	var result = confirm("삭제하시겠습니까?");
	if(result){
		location.href="/deleteLog/"+id;
	}
}
function modifyLog(id){
	window.open('/logInfo/'+id
			, 'logInfo', 'height=600,width=1200');
}
function changeStatus(e, id){
	var pageNum = $('#page').val();
	if(e.value == 1){
		var result = confirm("확정 하시겠습니까?");
		if(result){
			location.href="/statusChange/ok/"+id+"/"+pageNum;
		}
	}else{
		var result = confirm("확정을 해제하시겠습니까?");
		if(result){
			location.href="/statusChange/no/"+id+"/"+pageNum;
		}
	}
}


</script>
  </head>
  <body>
    <!-- navbar-->
    <jsp:include page="header.jsp"></jsp:include>
    <div class="d-flex align-items-stretch">
      <jsp:include page="menu.jsp"></jsp:include>
      <div class="w-100 d-flex flex-wrap">
      	<input type="hidden" id="page" value="${pageMaker.cri.page}">
      	<div class="container-fluid px-xl-5">
      		<div class="search">	
		    	<form id="searchForm" action="/dailyLogList" method="post">
		    		<b>DB일자:</b> 
		    		<input type="text" class="inputDate" id="dbstartdate" name="dbstartdate" value="${search.dbstartdate }" autocomplete="off">  
					~ <input type="text" class="inputDate" id="dbenddate" name="dbenddate" value="${search.dbenddate }" autocomplete="off">&nbsp;&nbsp;&nbsp;
		    		<b>입금일자:</b> 
		    		<input type="text" class="inputDate" id="depositstartdate" name="depositstartdate" value="${search.depositstartdate }" autocomplete="off">  
					~ <input type="text" class="inputDate" id="depositenddate" name="depositenddate" value="${search.depositenddate }" autocomplete="off">&nbsp;&nbsp;&nbsp;
					<br><br>
			  		<b>작성자:</b> <input type="text" class="inputText" placeholder="작성자" id="manager" name="manager" value="${search.manager }" style="width:100px;">
			  		<b>고객명:</b> <input type="text" class="inputText" placeholder="고객명" id="name" name="name" value="${search.name }" style="width:100px;">
			  		<b>일지상태:</b> 
		    		<select class="selectBox" id="searchStatus" name="searchStatus">
						<option value="9" <c:if test="${search.searchStatus == 9}">selected</c:if>>전체</option>
						<option value="0" <c:if test="${search.searchStatus == 0}">selected</c:if>>대기</option>
						<option value="1" <c:if test="${search.searchStatus == 1}">selected</c:if>>확정</option>
					</select>
			  		&nbsp;&nbsp;&nbsp;<input type="submit" class="button-gray-small" value="검색">
				</form>
			</div>
      	</div>
      	<c:if test="${!empty dailyLogList}">
      		<span style="margin-left:20px;">총 ${totalCnt}건</span>
	      	<table class="table table-hover" style="margin-left:10px;">
			  <thead>
			    <tr>
			      <th style="width:5%">NO</th>
			      <th style="width:10%">작성자</th>
			      <th style="width:10%">DB일자</th>
			      <th style="width:10%">입금일자</th>
			      <th style="width:10%">추천인</th>
			      <th style="width:10%">고객명</th>
			      <th style="width:20%">승인금융사</th>
			      <th style="width:10%">승인금액</th>
			      <th style="width:10%">입금액</th>
			      <th style="width:5%">관리</th>
			    </tr>
			  </thead>
			  <tbody>
			  	<c:forEach var="log" items="${dailyLogList}" varStatus="status">
				    <tr>
				      <th scope="row">${(pageMaker.cri.page-1)*10+status.count}</th>
				      <td>
						${log.manager}<br>
						<c:if test="${position eq '관리자'}">
							<select class="selectBox" id="status" name="status" onchange="changeStatus(this, '${log.id}')">
								<option value="0" <c:if test="${log.status == 0}">selected</c:if>>대기</option>
								<option value="1" <c:if test="${log.status == 1}">selected</c:if>>확정</option>
							</select>
						</c:if>
						<c:if test="${position eq '담당자'}">
							<c:if test="${log.status == 0}">[대기]</c:if>
							<c:if test="${log.status == 1}">[확정]</c:if>
						</c:if>
				      </td>
				      <td>
				      	${log.dbDate}
					  </td>
				      <td>
				      	${log.depositDate}
				      </td>
				      <td>
				      	${log.referee}
				      </td>
				      <td>
				      	${log.name}
				      </td>
				      <td>
				      	${log.fc}
				      </td>
				      <td>
				      	<fmt:formatNumber value="${log.money}" pattern="#,###" />
				      </td>
				      <td>
				      	<fmt:formatNumber value="${log.dmoney}" pattern="#,###" />
				      </td>
				      <td><button type="button" class="btn-outline-dark" onclick="modifyLog('${log.id}')">수정</button>
				     	  <br><button type="button" class="btn-outline-danger" onclick="deleteLog('${log.id}')">삭제</button>
				      </td>
				    </tr>
				</c:forEach>
			  </tbody>
			</table>
		</c:if>
		<c:if test="${empty dailyLogList}">
			<div style="text-align:center;width:100%">
				<h2>일지 데이터가 존재하지 않습니다.</h2>
			</div>
		</c:if>
		<div class="container">
			<div class="row">
				<div class="col">
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li class="page-item"><a class="page-link" href="/menu/menu3_1${pageMaker.makeLogQuery(pageMaker.startPage - 1)}">&lt;</a></li>
						</c:if> 
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
							<c:choose>
								<c:when test="${idx eq pageMaker.cri.page}">
									<li class="page-item"><a class="page-link" href="/menu/menu3_1${pageMaker.makeLogQuery(idx)}"><b>${idx}</b></a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a class="page-link" href="/menu/menu3_1${pageMaker.makeLogQuery(idx)}">${idx}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${pageMaker.next}">
							<li class="page-item"><a class="page-link" href="/menu/menu3_1${pageMaker.makeLogQuery(pageMaker.endPage + 1)}">></a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		<div style="width:80%;margin-left:auto;margin-right:auto;text-align:right;margin-bottom:30px;">
			<!-- <input type="button" class="btn btn-dark" value="일지등록" onclick="writeLog()">-->
		</div>
      </div>
    </div>
  </body>
</html>