<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:useBean id="cons" class="org.baeldung.captcha.CaptchaService" scope="session"/>
<fmt:setBundle basename="messages" />
<fmt:message key="message.password" var="noPass" />
<fmt:message key="message.username" var="noUser" />
<fmt:message key="label.form.submit" var="submit"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
<title>
	<spring:message code="label.pages.home.title"></spring:message>
</title>
<script type="text/javascript">
function validate() {
    if (document.f.username.value == "" && document.f.password.value == "") {
        alert("${noUser} and ${noPass}");
	    document.f.username.focus();
	    return false;
    }
    if (document.f.username.value == "") {
	    alert("${noUser}");
	    document.f.username.focus();
	    return false;
     }
     if (document.f.password.value == "") {
	    alert("${noPass}");
	    document.f.password.focus();
	    return false;
     }
}
</script>
<style type="text/css">
.wrapper{width:500px;margin-left:auto;margin-right:auto}
label{padding-left:0 !important}
</style>
</head>
<body>

<c:if test="${not empty param.message}">
    <div class="alert alert-info">
	    <c:out value="${param.message}"></c:out>
    </div>
</c:if>
<c:if test="${param.error != null}">
    <div class="alert alert-danger">
	    ${sessionScope.SPRING_SECURITY_LAST_EXCEPTION}
    </div>
</c:if>

    <div class="container">
        <div class="row wrapper">
            <h1>
            <spring:message code="label.form.loginTitle"></spring:message>
            </h1>
             <a href="?lang=en"><spring:message code="label.form.loginEnglish"></spring:message></a> | 
             <a href="?lang=es_ES"><spring:message code="label.form.loginSpanish"></spring:message></a>
            <br/><br/>
            
            <form name='f' action="login" method='POST' onsubmit="return validate();">
                
                 <label class="col-sm-4"><spring:message code="label.form.loginEmail"></spring:message></label>
                 <span class="col-sm-8"><input class="form-control" type='text' name='username' value=''/></span>
                
                <br/><br/>        
                 <label class="col-sm-4"><spring:message code="label.form.loginPass"></spring:message></label>
                 <span class="col-sm-8"><input class="form-control" type='password' name='password' /></span>
                
                <br/><br/>        
                 <label class="col-sm-4"><spring:message code="label.form.login2fa"></spring:message></label>
                 <span class="col-sm-8"><input class="form-control" type='text' name='code' /></span>
                
                <br/><br/>
                 <input class="btn btn-primary" name="submit" type="submit" value="<c:out value="${submit}"/>" />
 
            </form>
            <br/> Current Locale : <span ><c:out value="${pageContext.request.locale.language}"/> </span><br/><br/> 
             <a class="btn btn-default" href="/registration">
             <spring:message code="label.form.loginSignUp"></spring:message>
             </a>
             <br/>
             <a class="btn btn-default" href="/registrationCaptcha">
              <spring:message code="label.form.loginSignUpCaptcha"></spring:message>
             </a>
             <br/><br/>
            <a class="btn btn-default" href="/forgetPassword">
            	<spring:message code="message.resetPassword"></spring:message>
            </a>
        </div>
    </div>
</body>
</html>




