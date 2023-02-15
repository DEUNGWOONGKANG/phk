<%@page import="com.project.mj.manager.domain.ManagerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<%    request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
<title>Admin Page</title>
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
<script src="/resources/js/jquery-3.4.1.min.js"></script>
<script src="/resources/js/jquery-ui.js"></script>
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
$(function(){
    $("#dbDate").datepicker();
    $("#depositDate").datepicker();
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
function check(){
	var result = confirm("수정하시겟습니까??");
		
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
<% 
	ManagerVO manager = (ManagerVO)session.getAttribute("manager");
%>
  <body>
    <!-- navbar-->
      <form id="formdata" action="/dailyLogModify" method="post" style="width:100%">
      	<div style="width:100%;height:550px;">
      		<input type="hidden" id="id" name="id" value="${log.id }">
	      	<table class="storeAdd">
			  <tbody>
			    <tr>
			      <th>DB일자</th>
				  <td>
				  	<input type="text" class="inputDate" id="dbDate" name="dbDate" value="${log.dbDate}">
				  </td>
			      <th>입금일자</th>
				  <td>
				  	<input type="text" class="inputDate" id="depositDate" name="depositDate" value="${log.depositDate}">
				  </td>
			    </tr>
			    <tr>
			      <th>추천인</th>
				  <td>
				  	<input type="text" placeholder="추천인" id="referee" name="referee" style="width:70%" value="${log.referee}">
				  </td>
				  <th>고객명</th>
				  <td>
				  	${log.name }
				  </td>
			    </tr>
			    <tr>
			      <th>승인금융사</th>
				  <td>
				  	<select id="fc" name="fc">
				  		<c:forEach var="data" items="${fcList}">
				  			<option value="${data.name}" <c:if test="${log.fc eq data.name}">selected</c:if>>${data.name}</option>
				  		</c:forEach>
				  	</select>
				  </td>
				  <th>승인금액</th>
				  <td>
				  	<input type="text" placeholder="승인금액" id="money" name="money" style="width:70%" value="${log.money}">
				  </td>
			    </tr>
			    <tr>
			      <th>입금액</th>
				  <td colspan="3">
				  	<input type="text" placeholder="입금액" id="dmoney" name="dmoney" style="width:70%" value="${log.dmoney}">
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
  </body>
</html>