<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/findload.css"/>
<html>
<body>
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > find road</p>
	</div>
	
	<div id = "topname">
		<p><b>찾아오시는 길</b></p>
	</div>
	
	<div id = "topnamesub">
		<p>오프라인 구매를 원하시면 지도를 참고해 방문해주시기 바랍니다.</p>
	</div>
	
     <form name = "loginForm" action = "../host/hostmain.html" method = "post"
     onsubmit = "return inputCheck();">
     	<fieldset id = "map" style = "width: 700px; height: 400px;">
     		
     	</fieldset>
     </form>
	<script>
      function initMap() {
        var uluru = {lat: 37.476217, lng: 126.868098};
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 14,
          center: uluru
        });
        var marker = new google.maps.Marker({
          position: uluru,
          map: map
        });
      }
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDD5jBp7wYCQ04JGlmcszZq_leuIX51lzU&callback=initMap">
    </script>
<%@ include file = "bottommenu.jsp" %>
</body>
</html>