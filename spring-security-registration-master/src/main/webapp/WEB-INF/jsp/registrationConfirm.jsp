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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII"/>
<title>
	<spring:message code=:label.pages.home.title></spring:message>
</title>
</head>
<body>
<div>

<h1 class="alert alert-info">
<spring:message code="message.regSucc"></spring:message>
</h1>
<br/>
<c:if test="param.token != null">
	<span>
		<spring:message code="token.message"></spring:message>
	</span>
</c:if>

<span>
	<c:out value="param.token"></c:out>
</span>
<br/>
<a class="btn btn-primary" href="/login">
	<spring:message code="label.login"></spring:message>
</a>
</div>       
</body>
</html>