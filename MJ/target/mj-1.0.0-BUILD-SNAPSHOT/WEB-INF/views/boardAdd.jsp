<%@page import="com.project.mj.manager.domain.ManagerVO"%>
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
<%
	ManagerVO manager = (ManagerVO)session.getAttribute("manager");
	String managerId = manager.getId();
%>
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
      	<form id="formdata" action="/boardInsert" method="post" style="width:100%">
      	<input type="hidden" id="writer" name="writer" value="<%=managerId%>">
      	<div style="width:100%;height:550px;">
	      	<table class="storeAdd">
			  <tbody>
			    <tr>
			      <th style="">제목</th>
				  <td>
				  	<input type="text" placeholder="제목" id="title" name="title" style="width:70%">
				  </td>
			    </tr>
			    <tr style="height:100px">
			      <th>내용</th>
				  <td><textarea id="content" name="content" style="width:98%;height:95%"></textarea></td>
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