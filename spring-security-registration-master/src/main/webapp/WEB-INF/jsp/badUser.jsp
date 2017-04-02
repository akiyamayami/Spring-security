<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<fmt:setBundle basename="messages" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
	    <title>
	    	<spring:message code="label.badUser.title"></spring:message>
		</title>
</head>
<body>
<div class="container">
	<h1 class="alert alert-danger">
		<c:out value="${param.message[0]}"/>
	</h1>
	<br/>
	<a class="btn btn-default" href="/registration">
		<spring:message code="label.form.loginSignUp"></spring:message>
	</a>
	<c:if test="${param.expired}">
	    <br/>
		<h1><spring:message code="label.form.resendRegistrationToken"></spring:message></h1>
		<button onclick="resendToken()">resend</button>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
		<script type="text/javascript">
		var serverContext = "/";
		
		function resendToken(){
			var token = "${param.token}";
		    $.get(serverContext + "user/resendRegistrationToken?token="+token, function(data){
		        window.location.href = serverContext +"login?message=" + data.message;
		    })
		    .fail(function(data) {
		        if(data.responseJSON.error.indexOf("MailError") > -1)
		        {
		            window.location.href = serverContext + "emailError.html";
		        }
		        else{
		            window.location.href = serverContext + "login?message=" + data.responseJSON.message;
		        }
		    });
		}
		
		$(document).ajaxStart(function() {
		    $("title").html("LOADING ...");
		});
		//]]>
		</script>
	</c:if>
</div>
</body>
</html>