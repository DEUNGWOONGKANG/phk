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
<script type="text/javascript">
if("${saveYn}" == "Y"){
	alert("저장되었습니다.");
	goback();
}
function check(){
	var result = confirm("수정하시겠습니까?");
		
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
      	<form id="formdata" action="/managerModify" method="post" style="width:100%">
      	<div style="width:100%;height:550px;">
	      	<table class="storeAdd">
			  <tbody>
			    <tr>
			      <th>직책</th>
				  <td>
				  	<select id="position" name="position">
				  		<option value="담당자" <c:if test="${manager.position eq '담당자'}">selected</c:if>>담당자</option>
				  		<option value="관리자" <c:if test="${manager.position eq '관리자'}">selected</c:if>>관리자</option>
				  	</select>
				  </td>
			    </tr>
			    <tr>
			      <th>직원ID</th>
				  <td>
				  	<input type="text" id="id" name="id" style="width:30%" value="${manager.id }">
				  </td>
				</tr>
			    <tr>
			      <th>비밀번호</th>
				  <td>
				  	<input type="password" id="pw" name="pw" style="width:30%" value="${manager.pw }">
				  </td>
			    </tr>
			    <tr>
			      <th>이름</th>
				  <td>
				  	<input type="text" id="name" name="name" style="width:30%" value="${manager.name }">
				  </td>
				</tr>
			    <tr>
			      <th>연락처</th>
				  <td>
				  	<input type="text" id="tel1" name="tel1" style="width:10%" value="${manager.tel1 }"> - 
				  	<input type="text" id="tel2" name="tel2" style="width:10%" value="${manager.tel2 }"> - 
				  	<input type="text" id="tel3" name="tel3" style="width:10%" value="${manager.tel3 }">
				  </td>
			    </tr>
			    <tr>
			      <th>기타 연락처</th>
				  <td>
				  	<input type="text" id="etctel1" name="etctel1" style="width:10%" value="${manager.etctel1 }"> - 
				  	<input type="text" id="etctel2" name="etctel2" style="width:10%" value="${manager.etctel2 }"> - 
				  	<input type="text" id="etctel3" name="etctel3" style="width:10%" value="${manager.etctel3 }">
				  </td>
			    </tr>
			    <tr>
			      <th>팀</th>
				  <td>
				  	<select id="team_id" name="team_id">
				  		<option value=""></option>
						<c:forEach var="data" items="${teamList}">
							<option value="${data.id}" <c:if test="${manager.team_id eq data.id}">selected</c:if>>${data.name}</option>
						</c:forEach>
				  	</select>
				  </td>
			    </tr>
			    <tr>
			      <th>상태</th>
				  <td>
				  	<select id="status" name="status">
				  		<option value="1" <c:if test="${manager.status == 1}">selected</c:if>>재직</option>
				  		<option value="0" <c:if test="${manager.status == 0}">selected</c:if>>퇴사</option>
				  	</select>
				  </td>
			    </tr>
			  </tbody>
			</table>
			<div class="btndiv">
				<button type="button" class="button-gray-small" onclick="check()">수정</button>
				<button type="button" class="button-gray-small" onclick="goback()">닫기</button>
			</div>
		</div>
		</form>
    <!-- JavaScript files-->
    <script src="/resources/js/jquery-3.4.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="/resources/js/bootstrap.js"></script>
    <script src="/resources/js/jquery.cookie.js"> </script>
    <script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
    <script src="/resources/js/front.js"></script>
  </body>
</html>