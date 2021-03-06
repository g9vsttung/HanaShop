<%-- 
    Document   : logintest
    Created on : Jan 15, 2021, 11:36:25 AM
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="./css/login.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" integrity="sha384-gfdkjb5BdAXd+lj+gudLWI+BXq4IuLW5IT+brZEZsLFm++aCMlF1V92rMkPaX4PP" crossorigin="anonymous">
    </head>
    <body>
        
        <a href="home.jsp" ><button  style="margin: 10px 0px 10px 10px" class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a> <h5 style="display: inline">Home Page</h5>
        <%
            String userID = request.getParameter("txtUserID") == null ? "" : (String) request.getParameter("txtUserID");
            String password = request.getParameter("txtPassword") == null ? "" : (String) request.getParameter("txtPassword");
        %>
        <div class="container h-100">
		<div class="d-flex justify-content-center h-100">
			<div class="user_card">
				<div class="d-flex justify-content-center">
					<div class="brand_logo_container">
						<img src="https://cdn.freebiesupply.com/logos/large/2x/pinterest-circle-logo-png-transparent.png" class="brand_logo" alt="Logo">
					</div>
				</div>
				<div class="d-flex justify-content-center form_container">
					<form action="MainController" method="POST">
						<div class="input-group mb-3">
							<div class="input-group-append">
								<span class="input-group-text"><i class="fas fa-user"></i></span>
							</div>
                                                    <input type="text" name="txtUserID" class="form-control input_user" value="<%=userID%>" placeholder="username" required="true">
						</div>
						<div class="input-group mb-2">
							<div class="input-group-append">
								<span class="input-group-text"><i class="fas fa-key"></i></span>
							</div>
                                                    <input type="password" name="txtPassword" class="form-control input_pass" value="<%=password%>" placeholder="password" required="true">
						</div>
						<%
                                                    String error=request.getAttribute("LOGIN_ERROR")==null?"":(String)request.getAttribute("LOGIN_ERROR");
                                                %>
                                                <font color="red"><%=error%></font></br>
							<div class="d-flex justify-content-center mt-3 login_container">
                                                            <input type="submit" value="Login" name="btnAction" class="btn login_btn" />
                                                            
                                                        
                                        
				   </div>
                                                        
					</form>
                                                        
				</div>
                                                        <a style="text-align: center; margin-top: 10px" href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8084/HanaShop/login-google&response_type=code&client_id=547055862807-8r1nq6o8vsdgh41d494t54l8f51iltju.apps.googleusercontent.com&approval_prompt=force"><button class="btn  btn-warning "><i class="fa fa-envelope" aria-hidden="true"></i> Login with Google</button></a>
		
				
			</div>
		</div>
	</div>
    </body>
</html>
