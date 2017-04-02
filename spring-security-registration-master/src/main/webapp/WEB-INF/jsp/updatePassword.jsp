<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<fmt:setBundle basename="messages" />
<fmt:message key="PasswordMatches.user" var="PasswordMatches.user" />
<fmt:message key="error.wordLength" var="wordLength" />
<fmt:message key="error.wordNotEmail" var="wordNotEmail" />
<fmt:message key="error.wordSequences" var="wordSequences" />
<fmt:message key="error.wordLowercase" var="wordLowercase" />
<fmt:message key="error.wordUppercase" var="wordUppercase" />
<fmt:message key="error.wordOneNumber" var="wordOneNumber" />
<fmt:message key="error.wordOneSpecialChar" var="wordOneSpecialChar" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII"/>
<style>
.password-verdict{
color:#000;
}
</style>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="/resources/pwstrength.js"></script>
<title>
	<spring:message code="message.updatePassword"></spring:message>
</title>
</head>
<body>
<div sec:authorize="hasAuthority('CHANGE_PASSWORD_PRIVILEGE')">
    <div class="container">
        <div class="row">
            <h1>
            	<spring:message code="message.resetYourPassword"></spring:message>
            </h1>
            <form >
                	<br/>
                    <label class="col-sm-2">
                    	<spring:message code="label.user.password"></spring:message>
                    </label>
                    <span class="col-sm-5"><input class="form-control" id="password" name="newPassword" type="password" value="" /></span>
                    <div class="col-sm-12"></div>
					<br/><br/>
                    <label class="col-sm-2">
                    	<spring:message code="label.user.confirmPass"></spring:message>
                    </label>
                    <span class="col-sm-5"><input class="form-control" id="matchPassword" type="password" value=""></span>
                    <div id="globalError" class="col-sm-12 alert alert-danger" style="display:none">
                    	<spring:message code="PasswordMatches.user"></spring:message>
                    </div>
                   
                <div class="col-sm-12">
                <br/><br/>
                <button class="btn btn-primary" type="submit" onclick="savePass()">
                	<spring:message code="message.updatePassword"></spring:message>
                </button>
                </div>
            </form>
            
        </div>
    </div>
  
<script type="text/javascript">


var serverContext = "/";

	$(document).ready(function () {
	    $('form').submit(function(event) {
	    	savePass(event);
	    });
	    
	    $(":password").keyup(function(){
	        if($("#password").val() != $("#matchPassword").val()){
	            $("#globalError").show().html("${PasswordMatches}");
	        }else{
	            $("#globalError").html("").hide();
	        }
	    });
	    
	    options = {
	            common: {minChar:8},
	            ui: {
	                showVerdictsInsideProgressBar:true,
	                showErrors:true,
	                errorMessages:{
	                      wordLength: "${wordLength}",
	                      wordNotEmail: "${wordNotEmail}",
	                      wordSequences: "${wordSequences}",
	                      wordLowercase: "${wordLowercase}",
	                      wordUppercase: "${wordUppercase}",
	                      wordOneNumber: "${wordOneNumber}",
	                      wordOneSpecialChar: "${wordOneSpecialChar}"
	                    }
	                }
	        };
	     $('#password').pwstrength(options);
	});

function savePass(event){
    event.preventDefault();
    $(".alert").html("").hide();
    $(".error-list").html("");
    if($("#password").val() != $("#matchPassword").val()){
    	$("#globalError").show().html("${PasswordMatches}");
        return;
    }
    var formData= $('form').serialize();
    $.post(serverContext + "user/savePassword",formData ,function(data){
        window.location.href = serverContext + "login?message="+data.message;
    })
    .fail(function(data) {
        if(data.responseJSON.error.indexOf("InternalError") > -1){
        	window.location.href = serverContext + "login?message=" + data.responseJSON.message;
        }
        else{
            var errors = $.parseJSON(data.responseJSON.message);
            $.each( errors, function( index,item ){
                $("#globalError").show().html(item.defaultMessage);
            });
            errors = $.parseJSON(data.responseJSON.error);
            $.each( errors, function( index,item ){
                $("#globalError").show().append(item.defaultMessage+"<br/>");
            });
        }
    });
}
</script>    
</div>
</body>
</html>