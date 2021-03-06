<%-- 
    Document   : checkout
    Created on : Jan 17, 2021, 9:01:02 AM
    Author     : USER
--%>

<%@page import="tungvs.dtos.InvoiceErrorDTO"%>
<%@page import="tungvs.dtos.ProductDTO"%>
<%@page import="tungvs.dtos.CartDTO"%>
<%@page import="tungvs.dtos.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./css/checkout.css"> 
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    </head>
    <body style="background-color: #FFCAF2">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

        <%
            if (session.getAttribute("CART") == null) {
        %>
        <section class="shop text-center" >
            <div class="shop__header">
                <div class="row">
                    <div class="col-sm-4">
                        <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a> 
                    </div>
                    <div class="col-sm-4"><h1 style="color: white">CHECKOUT</h1> </div>
                    <div class="col-sm-4">
                        <div style="float: right; display: block;color: white"> 
                            <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-in" aria-hidden="true"></i> Login</button></a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div style="padding-top: 90px;"></div>
        <div style="margin-left: 20px;">
            <h1>You dont't have a cart to checkout! Login with user account, add item to CART and you con checkout ♥</h1>          
            <a href="home.jsp"><button class="btn btn-info">Continue Shopping</button></a>
        </div>
        <%
        } else {
            float total = 0;
            InvoiceErrorDTO error = new InvoiceErrorDTO("", "");
            if (request.getAttribute("ERROR") != null) {
                error = (InvoiceErrorDTO) request.getAttribute("ERROR");
            }
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            CartDTO cart = (CartDTO) session.getAttribute("CART");
            String address = request.getParameter("txtAddress") == null ? "" : request.getParameter("txtAddress");
            String phone = request.getParameter("txtPhone") == null ? "" : request.getParameter("txtPhone");
            for (ProductDTO product : cart.getCart().values()) {
                total += product.getQuantity() * product.getPrice();
            }
        %>
        <section class="shop text-center" >
            <div class="shop__header">
                <div class="row">
                    <div class="col-sm-4">
                        <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>
                        <h2 style="color: greenyellow; float: left;margin-left: 10px">Welcome: <%=user.getUserId()%></h2>  </br></br>
                    
                    </div>
                    <div class="col-sm-4"><h1 style="color: white">CHECKOUT</h1> </div>
                    <div class="col-sm-4">
                        <div style="float: right; display: block;color: white"> 
                            <a href="MainController?btnAction=View Cart"><button class="btn  btn-warning "><i class="fa fa-shopping-cart" aria-hidden="true"></i> Cart</button></a>
                            <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</button></a>

                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div style="padding-top: 140px;"></div>
        <div class="row">
            <div class="col-sm-4"></div>
            <div class="col-sm-4">
                <form action="MainController">
                    Address</br><input type="text" name="txtAddress" value="<%=address%>" required="true"/><font color="red"><%=error.getAddressError()%></font></br>
                    Number phone</br> <input type="number" name="txtPhone" value="<%=phone%>" required="true"/><font color="red"><%=error.getPhoneError()%></font></br>
                    Payment</br>
                    <select name="txtPayment">
                        <option selected="true">Cash upon delivery</option>
                        <option>Momo</option>
                        <option>Zalo Pay</option>
                        <option>Credit Card</option>
                    </select></br>
                    <h2>Total: <%=total%>$</h2>
                    <input type="hidden" name="txtTotal" value="<%=total%>" />
                    <button onclick="return confirm('Are you sure?')" name="btnAction" value="Confirm" type="submit" class="btn  btn-warning">Checkout</button>
                    </br>
                </form>

                <%
                    if (request.getAttribute("ERROR_QUANTITY") != null) {
                %>
                <h1 style="color: red"><%=request.getAttribute("ERROR_QUANTITY")%></h1>
                <%
                    }
                %>
            </div>
            <div class="col-sm-4"></div>
        </div>
        <%
            }
        %>
    </body>
</html>
