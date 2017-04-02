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
<title>QR code</title>

<link type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" />

</head>
<body>
	<div id="qr">
	    <p>Scan this Barcode using Google Authenticator app on your phone to use it later in login
	           <a href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2">Android</a> and 
	           <a href="https://itunes.apple.com/us/app/google-authenticator/id388497605">iPhone</a>
	    </p>
	    <br/>
	    <img src="<c:out value="${param.qr}"/>"/>
	</div>
       
        
    <a href="/login" class="btn btn-primary">Go to login page</a>
</body>
</html>