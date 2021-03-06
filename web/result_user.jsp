<%-- 
    Document   : result_user
    Created on : Jan 17, 2021, 9:31:49 AM
    Author     : USER
--%>

<%@page import="tungvs.dtos.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Result Page</title>
    <link rel="stylesheet" href="./css/admin.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">    

    </head>
    <body style="background-color: #FFCAF2">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

        <%
            if (session.getAttribute("LOGIN_USER") == null) {//ko phia user
        %>
        <section class="shop text-center" >
            <div class="shop__header">
                <div class="row">
                    <div class="col-sm-4">
                        <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>

                    </div>
                    <div class="col-sm-4"><h1 style="color: white">ERROR PAGE</h1> </div>
                    <div class="col-sm-4">
                        <div style="float: right; display: block;color: white"> 
                            <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-out" aria-hidden="true"></i> Login</button></a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <div style="padding-top: 140px">
            <h1 style="display: inline-block; color: red">NOTHING HERE ...</h1><i style="font-size: 100px"class="fa fa-exclamation-triangle btn-warning" aria-hidden="true"></i>
        </div>
        <%
        } else {
            UserDTO admin = (UserDTO) session.getAttribute("LOGIN_USER");
        %>
        <section class="shop text-center" >
            <div class="shop__header">
                <div class="row">
                    <div class="col-sm-4">
                        <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>
                        <h2 style="color: greenyellow; float: left;margin-left: 10px">Welcome: <%=admin.getUserId()%></h2>  
                    </div>
                    <div class="col-sm-4"><h1 style="color: white">RESULT PAGE</h1> </div>
                    <div class="col-sm-4">
                        <div style="float: right; display: block;color: white"> 
                            <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</button></a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div style="padding-top: 140px;"></div>
        <%
            if (request.getAttribute("MESSAGE") != null) {
        %>
        <font color="green"><h1><%=request.getAttribute("MESSAGE")%></h1></font></br>


        <%
            }
            else {
        %>
        <font color="green"><h1>Nothing here....</h1></font></br>
        
        <%
                }
            }
        %>

    </body>
</html>
