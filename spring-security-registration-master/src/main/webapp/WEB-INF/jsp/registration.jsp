<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<fmt:setBundle basename="messages" />
<fmt:message key="PasswordMatches.user" var="PasswordMatches" />
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
<style>
.password-verdict{
color:#000;
}
</style>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="/resources/pwstrength.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII"/>
<title>
<spring:message code="label.form.title"></spring:message>
</title>
</head>
<body>
    <div class="container">
        <div >
            <h1 ><spring:message code="label.form.title"></spring:message></h1>
            <br/>
            <form action="/" method="POST" enctype="utf8">
                <div class="form-group row" >
                    <label class="col-sm-3">
                    <spring:message code="label.user.firstName"></spring:message>
                    </label>
                    <span class="col-sm-5"><input class="form-control" name="firstName" value="" required="required"/></span>
                    <span id="firstNameError" class="alert alert-danger col-sm-4" style="display:none"></span>
                    
                </div>
                <div class="form-group row">
                    <label class="col-sm-3">
                    <spring:message code="label.user.lastName"></spring:message>
                    </label>
                    <span class="col-sm-5"><input class="form-control" name="lastName" value="" required="required"/></span>
                    <span id="lastNameError" class="alert alert-danger col-sm-4" style="display:none"></span>
                    
                </div>
                <div class="form-group row">
                    <label class="col-sm-3" >
                    <spring:message code="label.user.email"></spring:message>
                    </label>
                    <span class="col-sm-5"><input type="email" class="form-control" name="email" value="" required="required"/></span>                    
                    <span id="emailError" class="alert alert-danger col-sm-4" style="display:none"></span>
                    
                </div>
                <div class="form-group row">
                    <label class="col-sm-3"  >
                        <spring:message code="label.user.password"></spring:message>
                    </label>
                    <span class="col-sm-5"><input id="password" class="form-control" name="password" value="" type="password" required="required"/></span>
                    <span id="passwordError" class="alert alert-danger col-sm-4" style="display:none"></span>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3"  >
                     <spring:message code="label.user.confirmPass"></spring:message>
                    </label>
                    <span class="col-sm-5"><input id="matchPassword" class="form-control" name="matchingPassword" value="" type="password" required="required"></span>
                    <span id="globalError" class="alert alert-danger col-sm-4" style="display:none"></span>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3">
                    <spring:message code="label.user.2fa"></spring:message>
                    </label>
                    <span class="col-sm-5"><input type="checkbox" name="using2FA" value="true"/></span>
                </div>
                <br/>
                <button type="submit" class="btn btn-primary">
                	<spring:message code="label.form.submit"></spring:message>
                </button>
            </form>
            <br/> 
            <a href="/login" >
            	<spring:message code="label.form.loginLink"></spring:message>
            </a>
        </div>
    </div>

<script type="text/javascript">
var serverContext = "/";

$(document).ready(function () {
    $('form').submit(function(event) {
    	register(event);
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

function register(event){
	event.preventDefault();
    $(".alert").html("").hide();
    $(".error-list").html("");
    if($("#password").val() != $("#matchPassword").val()){
    	$("#globalError").show().html("${PasswordMatches}");
    	return;
    }
    alert("123");
    alert(formData);
    var formData= $('form').serialize();
    $.post(serverContext + "user/registration",formData ,function(data){
        if(data.message == "success"){
            window.location.href = serverContext + "successRegister";
        }
        
    })
    .fail(function(data) {
        if(data.responseJSON.error.indexOf("MailError") > -1)
        {
            window.location.href = serverContext + "emailError.html";
        }
        else if(data.responseJSON.error == "UserAlreadyExist"){
            $("#emailError").show().html(data.responseJSON.message);
        }
        else if(data.responseJSON.error.indexOf("InternalError") > -1){
            window.location.href = serverContext + "login?message=" + data.responseJSON.message;
        }
        else{
        	var errors = $.parseJSON(data.responseJSON.message);
            $.each( errors, function( index,item ){
                $("#"+item.field+"Error").show().html(item.defaultMessage);
            });
            errors = $.parseJSON(data.responseJSON.error);
            $.each( errors, function( index,item ){
                $("#globalError").show().append(item.defaultMessage+"<br/>");
            });
        }
    });
}

</script>
</body>
</html>