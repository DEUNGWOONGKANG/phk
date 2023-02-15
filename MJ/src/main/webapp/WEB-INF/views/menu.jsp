<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/orionicons.css">
<meta charset="EUC-KR">
<title>ADMIN PAGE</title>
<%
	String menuName = (String)session.getAttribute("menu");
%>
</head>
<body>
<div id="sidebar" class="sidebar py-3">
  <div class="text-gray-400 text-uppercase px-3 px-lg-4 py-4 font-weight-bold small headings-font-family">ADMIN PAGE</div>
  <ul class="sidebar-menu list-unstyled">
    <!-- <li class="sidebar-list-item" id="menu1"><a id="menu1a" href="/super/menu/menu1" class="sidebar-link text-muted"><i class="o-home-1 mr-3 text-gray"></i><span><b>Home</b></span></a></li>-->
    <li class="sidebar-list-item" id="menu0"><a id="menu0a" href="/menu/menu0" class="sidebar-link text-muted"><i class="o-letter-1 mr-3 text-gray"></i><span><b>공지사항</b></span></a>
    </li>
    <li class="sidebar-list-item" id="menu1"><a id="menu1a" href="/menu/menu1" class="sidebar-link text-muted"><i class="o-database-1 mr-3 text-gray"></i><span><b>고객관리</b></span></a>
    </li>
    <li class="sidebar-list-item" id="menu2"><a id="menu2a" href="/menu/menu2" class="sidebar-link text-muted"><i class="o-imac-screen-1 mr-3 text-gray"></i><span><b>직원관리</b></span></a>
    </li>
   	<li class="sidebar-list-item" id="menu3"><a id="menu3a" href="#" data-toggle="collapse" data-target="#pages2" aria-expanded="false" aria-controls="pages2" class="sidebar-link text-muted"><i class="o-sales-up-1 mr-3 text-gray"></i><span><b>정산</b></span></a>
     <div id="pages2" class="collapse">
       <ul class="sidebar-menu list-unstyled border-left border-primary border-thick">
         <li class="sidebar-list-item" id="menu3_1"><a id="menu3_1a" href="/menu/menu3_1" class="sidebar-link text-muted pl-lg-5"><b>일지리스트</b></a></li>
         <li class="sidebar-list-item" id="menu3_2"><a id="menu3_2a" href="/menu/menu3_2" class="sidebar-link text-muted pl-lg-5"><b>DB 일/월정산</b></a></li>
         <!-- <li class="sidebar-list-item" id="menu3_3"><a id="menu3_3a" href="/menu/menu3_3" class="sidebar-link text-muted pl-lg-5"><b>금액 일/월정산</b></a></li>-->
       </ul>
     </div>
    </li>
    <li class="sidebar-list-item" id="menu4"><a id="menu4a" href="/menu/menu4" class="sidebar-link text-muted"><i class="o-wireframe-1 mr-3 text-gray"></i><span><b>금융사관리</b></span></a>
    </li>
    <li class="sidebar-list-item" id="menu5"><a id="menu5a" href="/menu/menu5" class="sidebar-link text-muted"><i class="o-table-content-1 mr-3 text-gray"></i><span><b>접속IP관리</b></span></a>
    </li>
    <li class="sidebar-list-item" id="menu6"><a id="menu6a" href="/menu/menu6" class="sidebar-link text-muted"><i class="o-document-1 mr-3 text-gray"></i><span><b>상태값 관리</b></span></a>
    </li>
  </ul>
</div>
</body>
<script type="text/javascript">
var menu =  "<%=menuName%>";
active(menu);

function active(num){
	var menu = document.getElementById("sidebar").getElementsByTagName("li");
	 for(var i=0; i<menu.length; i++){
		if(num == menu[i].id){
			document.getElementById(menu[i].id+"a").className = document.getElementById(menu[i].id+"a").className + " active";
			if(num == "menu3_1" || num == "menu3_2" || num == "menu3_3"){
				document.getElementById("pages2").className = document.getElementById("pages2").className + " show";
			}
		}
	} 
}

</script>
</html>