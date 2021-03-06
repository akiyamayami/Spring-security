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
	<title>
		<spring:message code="label.pages.home.title"></spring:message>
	</title>
</head>
<body>
<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="/home">
      	<spring:message code="label.pages.home.title"></spring:message>
      </a>
      </div>
      <ul class="nav navbar-nav navbar-right">
        <li>
	        <a href="/j_spring_security_logout">
	        	<spring:message code="label.pages.logout"></spring:message>
	        </a> 
        </li>
      </ul>
    </div>
</nav>

<div class="container">         
     <sec:authorize access="!hasAuthority('WRITE_PRIVILEGE')">
     	<p><spring:message code="message.unauth"></spring:message></p>
     </sec:authorize>
      <sec:authorize access="hasAuthority('WRITE_PRIVILEGE')">
      	<p><spring:message code="label.pages.admin.message"></spring:message></p>
      </sec:authorize>
</div>
</body>
</html>