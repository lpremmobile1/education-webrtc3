<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!doctype html>
<html lang="en">
    <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    </head>
    <body>
    	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/jsp/webrtc/subject.jsp" />
    <div class="container-lg">
    	<br>
    	<h5>There will be two peers that is Peer A and Peer B. To begin communication between two peers you should start 
    	signaling between two peers i.e. you should complete section 1 of the Both Peer A and Peer B step wise</h5>
    	<h5>Peer A : In step 1.1 you will generate Offer Session Description Protocol String(a.k.a. SDP) and will be store in backend</h5>
    	<h5>Peer B : In step 1.2 you will receive Offer SDP</h5>
    	<h5>Peer B : In step 1.3 you will generate Answer SDP and stored in backend</h5>
    	<h5>Peer A : In step 1.4 you will receive Answer SDP</h5>
    	<h5>Peer A : In step 1.5 you can open webrtc connection between two peers.</h5>
    	<h5>Now you can send data between those two peers</h5>
    	<br>
    	<h5>peer A and peer B can be opened with below links</h5>
    	<a href="${pageContext.request.contextPath}/peera" target="_blank">Peer A</a> <br>
    	<a href="${pageContext.request.contextPath}/peerb" target="_blank">Peer B</a> <br>
    	<h5></h5>
    	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
    </div>
    </body>
    </html>