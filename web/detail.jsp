<%-- 
    Document   : detail
    Created on : Jan 17, 2021, 7:55:12 PM
    Author     : USER
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tungvs.dtos.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="tungvs.dtos.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./css/admin.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    </head>
    <body style="background-color: #FFCAF2">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

        <%
            if (session.getAttribute("LOGIN_USER") != null) {
                UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
                if (request.getAttribute("LIST") != null) {
                    List<ProductDTO> list = (List<ProductDTO>) request.getAttribute("LIST");
        %>
        <section class="shop text-center" >
            <div class="shop__header">
                <div class="row">
                    <div class="col-sm-4">
                        <a  style="float: left"href="history.jsp"><button class="btn  btn-success "><i class="fa fa-history" aria-hidden="true"></i> History</button></a>
                        <h2 style="color: greenyellow; float: left;margin-left: 10px">Welcome: <%=user.getUserId()%></h2>  
                    </div>
                    <div class="col-sm-4"><h1 style="color: white">DETAIL</h1> </div>
                    <div class="col-sm-4">
                        <div style="float: right; display: block;color: white"> 
                            <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</button></a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div style="padding-top: 90px;"></div>
        <div class="tablePro">
            <div class="table-responsive">
                <table class="table table-striped" style="background-color: white">
                    <thead>
                        <tr>
                            <th scope="col">No</th>
                            <th>Image</th>
                            <th>Category</th> 
                            <th scope="col">Name</th>
                            <th scope="col">Description</th>                            
                            <th scope="col">Create Date</th>                                                       
                            <th scope="col" class="text-center">Quantity</th>
                            <th scope="col" class="text-right">Price</th>                            
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int count = 0;
                            SimpleDateFormat simple = new SimpleDateFormat("dd/MM/yyyy");
                            for (ProductDTO product : list) {
                                count++;                              
                        %>
                        <tr>
                            <td><%=count%></td>
                            <td><img src="./images/<%=product.getImage()%>"width="80" height="100"/></td>
                            <td><%=product.getCategoryName()%></td>
                            <td><%=product.getName()%></td>
                            <td><%=product.getDescription()%></td>
                            <td><%=simple.format(product.getCreateDate())%></td>
                            <td><%=product.getQuantity()%></td>
                            <td><%=product.getPrice()%></td>
                            <td><%=product.getQuantity() * product.getPrice()%></td>

                        </tr>
                        <%
                            }
                        %>




                        <%
                            }
                        %>                    
                    </tbody>
                </table>
            </div>       

        </div>
        <%
        } else {
        %>
        <section class="shop text-center" >
            <div class="shop__header">
                <div class="row">
                    <div class="col-sm-4">
                        <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>
                    </div>
                    <div class="col-sm-4">
                        <h1 style="color: white;display: inline-block">DETAIL</h1> 
                    </div>
                    <div class="col-sm-4">
                        <div style="float: right; display: block;color: white"><a href="MainController?btnAction=Logout" ><button class="btn btn-warning"><i class="fa fa-sign-in" aria-hidden="true"></i> Login</button></a></div>
                    </div>
                </div>             
            </div>
        </section>
        <div style="padding-top: 90px;">
            <h1>Only USER can connect this page AND can only see your own history account</h1>
        </div>
        <%
            }


        %>

    </body>
</html>