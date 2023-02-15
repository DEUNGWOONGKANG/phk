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
function deleteData(id){
	var result = confirm("삭제하시겠습니까?");
	if(result == true){
		location.href="/deleteManager/"+id;
	}
}
function modifyData(id){
	window.open('/managerInfo/'+id
			, 'managerInfo', 'height=800,width=800');
}
function managerAdd(){
	window.open('/managerAdd'
			, 'managerAdd', 'height=600,width=1200');
}
function check(){
	document.getElementById("searchForm").submit();
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
		    	<form id="searchForm" action="/managerSearch" method="post">
		    		<b>직원상태:</b> 
		    		<select class="selectBox" id="searchStatus" name="searchStatus">
						<option value="9" <c:if test="${search.searchStatus == 9}">selected</c:if>>-----전체-----</option>
						<option value="0" <c:if test="${search.searchStatus == 0}">selected</c:if>>퇴사</option>
						<option value="1" <c:if test="${search.searchStatus == 1}">selected</c:if>>재직</option>
					</select>&nbsp;&nbsp;&nbsp;
		    		<b>검색종류:</b> <select class="selectBox" id="searchKey" name="searchKey">
						<option value="name" <c:if test="${search.searchKey eq 'name'}">selected</c:if>>이름</option>
						<option value="id" <c:if test="${search.searchKey eq 'id'}">selected</c:if>>ID</option>
					</select>
			  		<input type="text" class="inputText" placeholder="검색어" id="searchKeyword" name="searchKeyword" value="${search.searchKeyword }">
			  		&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="button-gray-small" value="검색" onclick="check()">
				</form>
			</div>
      	</div>
      		<span style="margin-left:20px;">총 ${totalCnt } 건</span>
	      	<table class="table table-hover" style="margin-left:10px;">
			  <thead>
			    <tr>
			      <th style="width:10%">NO</th>
			      <th style="width:20%">ID</th>
			      <th style="width:20%">직원명</th>
			      <th style="width:20%">직책</th>
			      <th style="width:10%">연락처</th>
			      <th style="width:10%">상태</th>
			      <th style="width:10%">관리</th>
			    </tr>
			  </thead>
			  <tbody>
			  	<c:forEach var="manager" items="${managerList}" varStatus="status">
				    <tr>
				      <th scope="row">${(pageMaker.cri.page-1)*10+status.count}</th>
				      <td>
						${manager.id}
				      </td>
				      <td>
				      	${manager.name}
					  </td>
				      <td>
				      	${manager.position}
				      </td>
				      <td>
				      	${manager.tel1}-${manager.tel2}-${manager.tel3}
				      </td>
				      <td>
				      	<c:if test="${manager.status == 0}">퇴사</c:if>
				      	<c:if test="${manager.status == 1}">재직</c:if>				      
				      </td>
				      <td>
				      <c:if test="${position eq '관리자'}">
				      	<button type="button" class="btn-outline-dark" onclick="modifyData('${manager.id}')">수정</button>
				     	<br><button type="button" class="btn-outline-danger" onclick="deleteData('${manager.id}')">삭제</button>
				      </c:if>
				      </td>
				    </tr>
				</c:forEach>
			  </tbody>
			</table>
		<div class="container">
			<div class="row">
				<div class="col">
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li class="page-item"><a class="page-link" href="/menu/menu2${pageMaker.makeManagerQuery(pageMaker.startPage - 1)}">&lt;</a></li>
						</c:if> 
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
							<c:choose>
								<c:when test="${idx eq pageMaker.cri.page}">
									<li class="page-item"><a class="page-link" href="/menu/menu2${pageMaker.makeManagerQuery(idx)}"><b>${idx}</b></a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a class="page-link" href="/menu/menu2${pageMaker.makeManagerQuery(idx)}">${idx}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${pageMaker.next}">
							<li class="page-item"><a class="page-link" href="/menu/menu2${pageMaker.makeManagerQuery(pageMaker.endPage + 1)}">></a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		<div style="width:80%;margin-left:auto;margin-right:auto;text-align:right;margin-bottom:30px;">
			<c:if test="${position eq '관리자'}">
			<input type="button" class="btn btn-dark" value="직원등록" onclick="managerAdd()">
			</c:if>
		</div>
      </div>
    </div>
  </body>
</html>