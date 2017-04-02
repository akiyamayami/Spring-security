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
	<spring:message code="label.pages.home.title"></spring:message>
</title>
</head>
<body>
<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">
      	<spring:message code="label.pages.home.title"></spring:message>
      </a>
    </div>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="/j_spring_security_logout">
        <spring:message code="label.pages.logout"></spring:message>
        </a></li>
      </ul>
  </div>
</nav>
    <div class="container">
            <h1>
            	<spring:message code="label.pages.home.message"></spring:message>
            </h1>
    </div>
</body>
</html>