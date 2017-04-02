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
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII"/>
<title >
<spring:message code="message.resetPassword"></spring:message></title>
</head>
<body>
<div class="container">
    <h1>
    	<spring:message code="message.resetPassword"></spring:message>
    </h1>
    <br/>
    <div class="row">
        <label class="col-sm-1"><spring:message code="label.user.email"></spring:message></label>
        <span class="col-sm-5"><input class="form-control" id="email" name="email" type="email" value="" /></span>
        <button class="btn btn-primary" type="submit" onclick="resetPass()">
        	<spring:message code="message.resetPassword"></spring:message>
        </button>
    </div>

<br/> 
<a class="btn btn-default" href="/registration">
	<spring:message code="label.form.loginSignUp"></spring:message>
</a>
<br/><br/>
<a class="btn btn-default" href="/login">
<spring:message code="label.form.loginLink"></spring:message>
</a>

</div>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script type="text/javascript">
//<![CDATA[
var serverContext = "/";

function resetPass(){
    var email = $("#email").val();
    $.post(serverContext + "user/resetPassword",{email: email} ,function(data){
            window.location.href = serverContext + "login?message=" + data.message;
    })
    .fail(function(data) {
    	if(data.responseJSON.error.indexOf("MailError") > -1)
        {
            window.location.href = serverContext + "emailError";
        }
        else{
            window.location.href = serverContext + "login?message=" + data.responseJSON.message;
        }
    });
}

$(document).ajaxStart(function() {
    $("title").html("LOADING ...");
});
/*]]>*/
</script>
</body>
</html>