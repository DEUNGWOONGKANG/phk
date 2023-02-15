<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<%    request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
<title>Loccitane Admin Page</title>
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
<!-- JavaScript files-->
<script src="/resources/js/jquery-3.4.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="/resources/js/bootstrap.js"></script>
<script src="/resources/js/jquery.cookie.js"> </script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script src="/resources/js/front.js"></script>
<!-- Favicon-->
<!-- <link rel="shortcut icon" href="img/favicon.png?3">-->
<script type="text/javascript">
if("${saveYn}" == "Y"){
	alert("저장되었습니다.");
	goback();
}
function check(){
	var result = confirm("등록하시겠습니까?");
		
	if(result){
		document.getElementById("formdata").submit();
	}else{
		return false;
	}
	
}
function goback(){
	opener.parent.location.reload();
	window.close();
}

</script>
</head>
  <body>
    <!-- navbar-->
      	<form id="formdata" action="/customerInsert" method="post" style="width:100%">
      	<div style="width:100%;height:550px;">
	      	<table class="storeAdd">
			  <tbody>
			    <tr>
			      <th style="">고객명</th>
				  <td>
				  	<input type="text" placeholder="고객명" id="name" name="name" style="width:70%">
				  </td>
			      <th>주민등록번호</th>
				  <td>
				  	<input type="text" id="reg_num1" name="reg_num1" style="width:30%">
				  	-<input type="text" id="reg_num2" name="reg_num2" style="width:30%">
				  </td>
			    </tr>
			    <tr>
			      <th>직업구분</th>
				  <td>
				  	<input type="text" placeholder="직업" id="job" name="job" style="width:70%">
				  </td>
				  <th>연락처</th>
				  <td>
				  	<input type="text" id="tel1" name="tel1" style="width:20%">
				  	-<input type="text" id="tel2" name="tel2" style="width:20%">
				  	-<input type="text" id="tel3" name="tel3" style="width:20%">
				  </td>
			    </tr>
			    <tr>
			      <th>상태</th>
				  <td>
				  	<select id="status" name="status">
				  		<c:forEach var="data" items="${statusList}">
				  			<option value="${data.name}">${data.name}</option>
				  		</c:forEach>
				  	</select>
				  </td>
				  <th>담당자</th>
				  <td>
				  	<select id="manager" name=manager>
				  			<option value="">담당자 없음</option>
				  		<c:forEach var="manager" items="${managerList}">
				  			<option value="${manager.id}">${manager.name}</option>
				  		</c:forEach>
				  	</select>
				  </td>
			    </tr>
			    <tr>
			      <th>1차 접수처</th>
				  <td colspan="3">
				  	<input type="text" id="receive" name="receive" style="width:50%">
				  </td>
			    </tr>
			    <tr style="height:100px">
			      <th>메모</th>
				  <td colspan="3"><textarea id="memo" name="memo" style="width:98%;height:95%"></textarea></td>
			    </tr>
			  </tbody>
			</table>
			<div class="btndiv">
				<button type="button" class="button-gray-small" onclick="check()">등록</button>
				<button type="button" class="button-gray-small" onclick="goback()">닫기</button>
			</div>
		</div>
		</form>
  </body>
</html>