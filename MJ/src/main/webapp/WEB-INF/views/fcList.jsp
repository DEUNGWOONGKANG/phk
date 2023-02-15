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
		location.href="/deleteFc/"+id;
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
      	<div class="container-fluid px-xl-5">
      	</div>
	      	<table class="table table-hover" style="margin-left:10px;">
			  <thead>
			    <tr>
			      <th style="width:70%">금융사</th>
			      <th style="width:20%">등록일</th>
			      <th style="width:10%">삭제</th>
			    </tr>
			  </thead>
			  <tbody>
			  	<c:forEach var="fc" items="${fcList}">
				    <tr>
				      <td>
						${fc.name}
				      </td>
				      <td>
				      	<fmt:formatDate value="${fc.created}" pattern="YYYY-MM-dd HH:mm:ss"/>
					  </td>
				      <td>
				     	<button type="button" class="btn-outline-danger" onclick="deleteData('${fc.id}')">삭제</button>
				      </td>
				    </tr>
				</c:forEach>
					<tr>
				      <td colspan="3" style="text-align:right">
				      	<form id="searchForm" action="/fcInsert" method="post" >
						<input type="text" id="name" name="name" >
				     	<button type="submit" class="btn-outline-danger">금융사추가</button>
				     	</form>
				      </td>
				    </tr>
			  </tbody>
			</table>
      </div>
    </div>
  </body>
</html>