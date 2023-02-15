<%@page import="com.project.mj.manager.domain.ManagerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<title></title>
<%
	ManagerVO manager = (ManagerVO)session.getAttribute("manager");
	if(manager == null){
%>
	<script type="text/javascript">
		location.href = "/logout";
	</script>
<%
	} 
	String menuName = (String)session.getAttribute("menu");
%>
</head>
<body>
 <header class="header">
      <nav class="navbar navbar-expand-lg px-4 py-2 bg-white shadow"><a href="#" class="sidebar-toggler text-gray-500 mr-4 mr-lg-5 lead"><i class="fas fa-align-left"></i></a><a href="/home" class="navbar-brand font-weight-bold text-uppercase text-base"><!-- <img src="/resources/img/logo.jpg" style="width:50px"> --></a>
        <ul class="ml-auto d-flex align-items-center list-unstyled mb-0">
          <li class="nav-item dropdown ml-auto"><a id="userInfo" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link dropdown-toggle"><span style="font-size:12px;">로그아웃</span></a>
            <div aria-labelledby="userInfo" class="dropdown-menu">
              <a href="/logout" class="dropdown-item">Logout</a>
              <!-- <a href="/super/modify" class="dropdown-item">비밀번호변경</a>-->
            </div>
          </li>
        </ul>
      </nav>
    </header>
</body>
