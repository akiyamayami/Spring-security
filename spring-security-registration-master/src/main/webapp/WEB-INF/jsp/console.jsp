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
	        <a href="<c:url value="/j_spring_security_logout" />">
	        	<spring:message code="label.pages.logout"></spring:message>
	        </a> 
        </li>
      </ul>
    </div>
</nav>
<div class="container">
	<c:if test="${param.message != null}">
		<div class="alert alert-info">
			<c:out value="${param.message}"></c:out>
		</div>
	</c:if>
	
    <h1>This is the landing page for the admin</h1>
    
    <div sec:authorize="hasAuthority('READ_PRIVILEGE')">This text is only visible to a user</div>
          
    <div sec:authorize="hasAuthority('WRITE_PRIVILEGE')"> This text is only visible to an admin</div>
    
      <a class="btn btn-default" href="/admin">
      	<spring:message code="label.pages.admin"></spring:message>
      </a>
      <br/>
      <a class="btn btn-default" href="/changePassword">
      	<spring:message code="message.changePassword"></spring:message>
      </a>
      <br/>
      <br/>
      <br/>
      <c:if test="${authentication.principal.using2FA}">
      	You are using Two-step authentication <a href="#" class="btn btn-primary" onclick="disable2FA()">Disable 2FA</a> 
      </c:if>
      <c:if test="${!authentication.principal.using2FA}">
      	You are not using Two-step authentication <a href="#" class="btn btn-primary" onclick="enable2FA()">Enable 2FA</a>  
      </c:if>
        
      
      <br/>
      <div id="qr" style="display:none;">
          <p>Scan this Barcode using Google Authenticator app on your phone 
                 <a href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2">Android</a> and 
                 <a href="https://itunes.apple.com/us/app/google-authenticator/id388497605">iPhone</a>
          </p>
      </div>
  </div>
  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script type="text/javascript">
function enable2FA(){
    set2FA(true);
}

function disable2FA(){
    set2FA(false);
}

function set2FA(use2FA){
    $.post( "/user/update/2fa", { use2FA: use2FA } , function( data ) {
        if(use2FA){
        	$("#qr").append('<img src="'+data.message+'" />').show();
        }else{
            window.location.reload();
        }
    });
}
</script>
</body>
</html>