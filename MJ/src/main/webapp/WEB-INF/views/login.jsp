<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<link rel="stylesheet" href="/resources/css/login.css">
<script type="text/javascript">
function check(){
	var id = document.getElementById("loginId");
	var pw = document.getElementById("loginPw");
	if(id.value == ""){
		alert("아이디를 입력하세요.");
		id.focus();
		return false;
	}else if(pw.value == ""){
		alert("비밀번호를 입력하세요.");
		pw.focus();
		return false;
	}else{
		document.getElementById("loginForm").submit();
	}
}
</script>
</head>
<body class="align">

  <div class="grid">

    <form id="loginForm" action="/login" method="post" class="form login" onsubmit="return check()">
      <header class="login__header">
        <h3 class="login__title"><!-- <img src="/resources/img/logo.jpg" style="width:150px"> --></h3>
      </header>

      <div class="login__body">
		<br>
        <div class="form__field">
          <input type="text" placeholder="ID" id="loginId" name="id">
        </div>

        <div class="form__field">
          <input type="password" placeholder="Password" name="pw" id="loginPw">
        </div>

      </div>

      <footer class="login__footer">
        <input type="submit" value="LOGIN">

        <p><span></span><a href="#"></a></p>
      </footer>

    </form>
  </div>
</body>
</html>