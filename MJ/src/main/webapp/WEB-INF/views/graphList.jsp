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
    <script type="text/javascript" src="/resources/js/highcharts.js"></script>
	<script type="text/javascript" src="/resources/js/exporting.js"></script>
	<script type="text/javascript" src="/resources/js/export-data.js"></script>
	<script type="text/javascript" src="/resources/js/boost.js"></script>
	
<script type="text/javascript">
var manager = [];
var money = [];
var dmoney = [];
$(document).ready(function () {
	<c:forEach var="data" items="${graphList}">
		manager.push("${data.manager}");
		money.push(${data.money});
		dmoney.push(${data.dmoney});
	</c:forEach>
	
	makeChart();
	$("#dbstartdate").datepicker();
    $("#dbenddate").datepicker();
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
function makeChart(){
   chart =  new Highcharts.chart({
        chart: {
          type: 'bar'
          ,renderTo: 'container'
        },
        title: {
          text: '담당자',
          align: 'left'
        },
        xAxis: {
          categories: manager,
          title: {
            text: null
          }
        },
        yAxis: {
          min: 0,
          title: {
            text: '만원',
            align: 'high'
          },
          valueSuffix: '만원'
        },
        tooltip: {
            headerFormat: '<span style="font-size:12px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
              '<td style="padding:0"><b>{point.y:.1f} 만원</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        legend: {
          width: 150,
          layout: 'vertical',
          align: 'right',
          verticalAlign: 'top',
          floating: true,
          borderWidth: 1,
          backgroundColor:Highcharts.defaultOptions.legend.backgroundColor || '#FFFFFF',
          shadow: true,
        },
        credits: {
          enabled: false
        },
        series: [{
          name: '입금금액',
          data: dmoney
        }, {
          name: '승인금액',
          data: money
        }],
        exporting: {
	       buttons: {
	           contextButton: {
	               enabled: false
	           }
	       }
	   }
   });
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
		    	<form id="searchForm" action="/graphList" method="post">
		    		<b>DB일자:</b> 
		    		<input type="text" class="inputDate" id="dbstartdate" name="dbstartdate" value="${search.dbstartdate }" autocomplete="off">  
					~ <input type="text" class="inputDate" id="dbenddate" name="dbenddate" value="${search.dbenddate }" autocomplete="off">&nbsp;&nbsp;&nbsp;
			  		&nbsp;&nbsp;&nbsp;<input type="submit" class="button-gray-small" value="검색">
			  		<div style="float:right; margin-right:10%;">
			  			입금 총액 : <input type="text" id="dmoney" name="dmoney" readonly style="width:100px" value="<fmt:formatNumber value='${totaldmoney}' pattern='#,###'/>">
			  			승인 총액 : <input type="text" id="money" name="money" readonly style="width:100px" value="<fmt:formatNumber value='${totalmoney}' pattern='#,###'/>">
			  		</div>
				</form>
			</div>
      	</div>
		<div style="margin-left:10%;width:80%;height:800px;" id="container">
		</div>
      </div>
    </div>
  </body>
</html>