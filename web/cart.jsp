<%-- 
    Document   : carttest
    Created on : Jan 16, 2021, 10:06:35 AM
    Author     : USER
--%>

<%@page import="tungvs.dtos.UserDTO"%>
<%@page import="tungvs.dtos.ProductDTO"%>
<%@page import="tungvs.dtos.CartDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tungvs.daos.ProductDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./css/cart.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    </head>
    <body style="background-color: #FFCAF2">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <%
            if (session.getAttribute("LOGIN_USER") == null) {//not a user
        %>
        <section class="shop text-center" >
            <div class="shop__header">
                <div class="row">
                    <div class="col-sm-4">
                        <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>
                    </div>
                    <div class="col-sm-4">
                        <h1 style="color: white;display: inline-block">SHOPPING CART</h1> 
                    </div>
                    <div class="col-sm-4">
                        <div style="float: right; display: block;color: white"><a href="MainController?btnAction=Logout" ><button class="btn btn-warning"><i class="fa fa-sign-in" aria-hidden="true"></i> Login</button></a></div>
                    </div>
                </div>             
            </div>
        </section>
        <div style="padding-top: 90px;">
            <h1>Only USER can connect this page!!!</h1>
        </div>
        <%
        } else {//is user
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            if (session.getAttribute("CART") == null) {//no cart
        %>
        <section class="shop text-center" >
            <div class="shop__header">
                <div class="row">
                    <div class="col-sm-4">
                        <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>
                        <h4 style="color: greenyellow; float: left;margin-left: 10px">Welcome: <%=user.getUserId()%></h4>  
                    </div>
                    <div class="col-sm-4"><h1 style="color: white">SHOPPING CART</h1> </div>
                    <div class="col-sm-4">
                        <div style="float: right; display: block;color: white"> 
                            <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</button></a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div style="padding-top: 140px;"></div>
        <div style="margin-left: 20px;">
            <h1>Your cart is empty!</h1>          
            <a href="home.jsp"><button class="btn btn-info">Continue Shopping</button></a>
        </div>

        <%
        } else {//have cart
        %>
        <section class="shop text-center" >
            <div class="shop__header">
                <div class="row">
                    <div class="col-sm-4">
                        <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>
                        <h4 style="color: greenyellow; float: left;margin-left: 10px">Welcome: <%=user.getUserId()%></h4>  
                    </div>
                    <div class="col-sm-4"><h1 style="color: white">SHOPPING CART</h1> </div>
                    <div class="col-sm-4">
                        <div style="float: right; display: block;color: white"> 
                            <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</button></a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div style="padding-top: 140px;">

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
                                <th>Edit</th>
                                <th>Remove</th>
                                <th class="text-center">Note</th>

                            </tr>
                        </thead>
                        <tbody>

                            <%
                                boolean check = true;
                                SimpleDateFormat simple = new SimpleDateFormat("dd/MM/yyyy");
                                int count = 0;
                                CartDTO cart = (CartDTO) session.getAttribute("CART");
                                float total = 0;
                                for (ProductDTO product : cart.getCart().values()) {
                                    total += product.getPrice() * product.getQuantity();
                                    count++;
                            %>
                        <form action="MainController">
                            <tr>
                                <td><%=count%></td>
                                <td><img src="./images/<%=product.getImage()%>" width="80" height="100"</td> 
                                <td><%=product.getCategoryName()%></td>
                                <td><%=product.getName()%></td>
                                <td ><%=product.getDescription()%></td>


                                <td><%=simple.format(product.getCreateDate())%></td>  
                               
                                
                                <td><input type="number" style="width: 100px"  name="txtQuantity" value="<%=product.getQuantity()%>" required="true"/> </td>

                                <td class="text-right"><%=product.getPrice()%> $</td>       
                                <td><%=product.getQuantity() * product.getPrice()%>$</td>
                                <td class="text-right">                            
                                    <input type="submit" value="Edit" name="btnAction" />
                                    <input type="hidden" name="txtID" value="<%=product.getProId()%>" />                        
                                </td>
                                
                                <td class="text-right"><button value="Remove" name="btnAction" onclick="return confirm('Are you sure to remove <%=product.getQuantity()%> items [<%=product.getName()%>]?')" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i> </button></td>
                                <td >
                                    <%//check quantity
                                        ProductDAO dao = new ProductDAO();
                                        int checkQuantity = dao.getQuantity(product.getProId());
                                        if (checkQuantity < product.getQuantity()) {
                                            check = false;
                                    %>
                                    <font color="red">We only have <%=checkQuantity%> items left!</font>
                                    <%
                                    } else {
                                    %>
                                    <font color="green">Valid</font>
                                    <%
                                        }
                                    %>
                                </td>
                            </tr>
                        </form>


                        <%
                            }
                        %>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                           
                            <td></td>
                            <td></td>
                            <td><h3>Total</h3></td>
                            <td class="text-right"><h3><%=total%> $</h3></td>
                        </tr>
                        </tbody>
                    </table>
                </div>       
                <div class="col mb-2">
                    <div class="row">
                        <div class="col-sm-12  col-md-6">
                            <a href="home.jsp" style="text-decoration: none"><button class="btn btn-lg btn-block btn-info text-uppercase">Continue Shopping</button></a>
                        </div>
                        <div class="col-sm-12 col-md-6 text-right">
                            <%
                                if (check) {
                            %>
                            <form action="MainController">
                                <button name="btnAction" value="Checkout" type="submit" class="btn btn-lg btn-block btn-success text-uppercase">Checkout</button>
                            </form>
                            <%
                                }
                            %>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
            if (request.getAttribute("QUANTITY_ERROR") != null) {
        %>
        <font color="red"><h2><%=(String) request.getAttribute("QUANTITY_ERROR")%></h2></font>
            <%
                        }

                    }
                }

            %>




    </body>
</html>
