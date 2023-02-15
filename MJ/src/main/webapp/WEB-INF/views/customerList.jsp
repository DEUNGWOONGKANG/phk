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
		location.href="/deleteCustomer/"+id;
	}
}
function modifyData(id){
	window.open('/customerInfo/'+id
			, 'customerInfo', 'height=600,width=1200');
}
function customerAdd(){
	window.open('/customerAdd'
			, 'customerAdd', 'height=600,width=1200');
}
function excelDown(){
	location.href="/excelDown";
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
function writeLog(id){
	window.open('/writeLog/'+id
			, 'dailyLog', 'height=600,width=1200');
}
function changeStatus(e, id){
	var pageNum = $('#page').val();
	var result = confirm("상태를 변경 하시겠습니까?");
	var searchKey = $('#searchKey').val();
	var searchStatus = $('#searchStatus').val();
	var searchKeyword = $('#searchKeyword').val();
	var startdate = $('#startdate').val();
	var enddate = $('#enddate').val();
	if(result){
		location.href="/changeStatus/"+id+"/"+e.value+"/"+pageNum
		+"?searchKey="+searchKey+"&searchStatus="+searchStatus+"&searchKeyword="+searchKeyword
		+"&startdate="+startdate+"&enddate="+enddate;
	} 
}
function changeManager(e, id){
	var pageNum = $('#page').val();
	var searchKey = $('#searchKey').val();
	var searchStatus = $('#searchStatus').val();
	var searchKeyword = $('#searchKeyword').val();
	var startdate = $('#startdate').val();
	var enddate = $('#enddate').val();
	
	var result = confirm("담당자를 변경 하시겠습니까?");
	if(result){
		location.href="/changeManager/"+id+"/"+e.value+"/"+pageNum
		+"?searchKey="+searchKey+"&searchStatus="+searchStatus+"&searchKeyword="+searchKeyword
		+"&startdate="+startdate+"&enddate="+enddate;
	}
}
</script>
  </head>
  <body>
    <!-- navbar-->
    <jsp:include page="header.jsp"></jsp:include>
    <div class="d-flex align-items-stretch">
      <input type="hidden" id="page" value="${pageMaker.cri.page}">
      <jsp:include page="menu.jsp"></jsp:include>
      <div class="w-100 d-flex flex-wrap">
      	<div class="container-fluid px-xl-5">
      		<div class="search">	
		    	<form id="searchForm" action="/customerSearch" method="post">
		    		<b>진행상태:</b> 
		    		<select class="selectBox" id="searchStatus" name="searchStatus">
						<option value="">-----전체-----</option>
					<c:forEach var="data" items="${statusList}">
						<option value="${data.name}" <c:if test="${search.searchStatus eq data.name}">selected</c:if>>${data.name}</option>
					</c:forEach>
					</select>&nbsp;&nbsp;&nbsp;
		    		<b>검색종류:</b> <select class="selectBox" id="searchKey" name="searchKey">
						<option value="name" <c:if test="${search.searchKey eq 'name'}">selected</c:if>>고객명</option>
						<option value="manager" <c:if test="${search.searchKey eq 'manager'}">selected</c:if>>담당자명</option>
						<option value="tel" <c:if test="${search.searchKey eq 'tel'}">selected</c:if>>전화번호</option>
						<option value="receive" <c:if test="${search.searchKey eq 'receive'}">selected</c:if>>1차접수처</option>
						<option value="job" <c:if test="${search.searchKey eq 'job'}">selected</c:if>>직업구분</option>
					</select>
			  		<input type="text" class="inputText" placeholder="검색어" id="searchKeyword" name="searchKeyword" value="${search.searchKeyword }">
			  		<br><br>
			  		<b>작성일:</b> <input type="text" class="inputDate" id="startdate" name="startdate" value="${search.startdate }" autocomplete="off">  
					~ <input type="text" class="inputDate" id="enddate" name="enddate" value="${search.enddate }" autocomplete="off">
			  		&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="button-gray-small" value="검색" onclick="check()">
				</form>
			</div>
      	</div>
      	<c:if test="${!empty customerList}">
      		<span style="margin-left:20px;">총 ${totalCnt } 건</span>
	      	<table class="table table-hover" style="margin-left:10px;">
			  <thead>
			    <tr>
			      <th style="width:5%">NO</th>
			      <th style="width:10%">고객명<br>(1차 접수처)</th>
			      <th style="width:15%">주민등록번호<br>핸드폰번호</th>
			      <th style="width:10%">담당자</th>
			      <th style="width:10%">진행상태</th>
			      <th style="width:10%">작성일</th>
			      <th style="width:10%">직업구분</th>
			      <th>메모</th>
			      <th style="width:5%">관리</th>
			    </tr>
			  </thead>
			  <tbody>
			  	<c:forEach var="customer" items="${customerList}" varStatus="status">
				    <tr style="cursor:pointer;
				    <c:if test="${customer.status eq 'A/S확정'}">background-color:#FFE400</c:if>
				    <c:if test="${customer.status eq 'A/S요청'}">background-color:#FAF4C0</c:if>
				    <c:if test="${customer.status eq '진행처없음'}">background-color:#FFB2D9</c:if>
				    <c:if test="${customer.status eq '본인취소'}">background-color:#FF0000</c:if>
				    <c:if test="${customer.status eq '진행중'}">background-color:#B2EBF4</c:if>
				    <c:if test="${customer.status eq '승인완료'}">background-color:#0054FF</c:if>
				    <c:if test="${customer.status eq '가승인'}">background-color:#2F9D27</c:if>
				    <c:if test="${customer.status eq '부재'}"></c:if>
				    <c:if test="${customer.status eq '재통화예정'}">background-color:#ABF200</c:if>
				    <c:if test="${customer.status eq '서류준비중'}">background-color:#6799FF</c:if>
				    ">
				      <th scope="row">${(pageMaker.cri.page-1)*10+status.count}</th>
				      <td>
				      	<a onclick="writeLog('${customer.id}')">
						${customer.name}<br>(${customer.receive})
						</a>
				      </td>
				      <td>
				      	${customer.reg_num1}-${customer.reg_num2}<br>${customer.tel1}-${customer.tel2}-${customer.tel3}
					  </td>
				      <td>
				      	<select class="selectBox" id="manager" name="manager" onchange="changeManager(this, '${customer.id}')">
							<option value=""></option>
						<c:forEach var="data" items="${managerList}">
							<option value="${data.id}" <c:if test="${customer.manager eq data.id}">selected</c:if>>${data.name}</option>
						</c:forEach>
						</select>
				      </td>
				      <td>
				      	<select class="selectBox" id="status" name="status" onchange="changeStatus(this, '${customer.id}')">
						<c:forEach var="data" items="${statusList}">
							<option value="${data.id}" <c:if test="${customer.status eq data.name}">selected</c:if>>${data.name}</option>
						</c:forEach>
						</select>
				      </td>
				      <td><fmt:formatDate value="${customer.created}" pattern="YYYY-MM-dd"/><br>
				      <fmt:formatDate value="${customer.created}" pattern="HH:mm:ss"/></td>
				      <td>
				      	${customer.job}
				      </td>
				      <td>
				      	${customer.memo}
				      </td>
				      <td><button type="button" class="btn-outline-dark" onclick="modifyData('${customer.id}')">수정</button>
				     	  <br><button type="button" class="btn-outline-danger" onclick="deleteData('${customer.id}')">삭제</button>
				      </td>
				    </tr>
				</c:forEach>
			  </tbody>
			</table>
		</c:if>
		<c:if test="${empty customerList}">
			<div style="text-align:center;width:100%">
				<h2>고객정보가 존재하지 않습니다.</h2>
			</div>
		</c:if>
		<div class="container">
			<div class="row">
				<div class="col">
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li class="page-item"><a class="page-link" href="/menu/menu1${pageMaker.makeQuery(pageMaker.startPage - 1)}">&lt;</a></li>
						</c:if> 
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
							<c:choose>
								<c:when test="${idx eq pageMaker.cri.page}">
									<li class="page-item"><a class="page-link" href="/menu/menu1${pageMaker.makeQuery(idx)}"><b>${idx}</b></a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a class="page-link" href="/menu/menu1${pageMaker.makeQuery(idx)}">${idx}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${pageMaker.next}">
							<li class="page-item"><a class="page-link" href="/menu/menu1${pageMaker.makeQuery(pageMaker.endPage + 1)}">></a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		<div style="width:80%;margin-left:auto;margin-right:auto;text-align:right;margin-bottom:30px;">
			<input type="button" class="btn btn-dark" value="고객등록" onclick="customerAdd()">
			<c:if test="${position eq '관리자'}">
				<input type="button" class="btn btn-success" value="엑셀다운" onclick="excelDown()">
			</c:if>
		</div>
      </div>
    </div>
  </body>
</html>