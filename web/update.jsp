<%-- 
    Document   : update
    Created on : Jan 14, 2021, 11:09:49 PM
    Author     : USER
--%>

<%@page import="tungvs.dtos.UserDTO"%>
<%@page import="tungvs.daos.CategoryDAO"%>
<%@page import="java.util.List"%>
<%@page import="tungvs.dtos.CategoryDTO"%>
<%@page import="tungvs.dtos.ProductErrorDTO"%>
<%@page import="tungvs.dtos.ProductErrorDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Page</title>
        <link rel="stylesheet" href="./css/admin.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">    
    </head>
    <body style="background-color: #FFCAF2">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

        <%
            if (session.getAttribute("LOGIN_ADMIN") == null) {//ko phia admin
        %>
        <section class="shop text-center" >
            <div class="shop__header">
                <div class="row">
                    <div class="col-sm-4">
                        <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>
                    </div>
                    <div class="col-sm-4">
                        <h1 style="color: white;display: inline-block">ERROR PAGE</h1> 
                    </div>
                    <div class="col-sm-4">
                        <div style="float: right; display: block;color: white"><a href="login.jsp" ><button class="btn btn-warning"><i class="fa fa-sign-in" aria-hidden="true"></i> Login</button></a></div>
                    </div>
                </div>             
            </div>
        </section>
        <div style="padding-top: 90px;">
            <h1 style="display: inline-block; color: red">Only ADMIN can connect this page!!!</h1><i style="font-size: 100px"class="fa fa-exclamation-triangle btn-warning" aria-hidden="true"></i>
        </div>
        <%
        } else {
            String search = "";//search
            if (request.getParameter("txtSearch") == null) {
                if (request.getAttribute("txtSearch") != null) {
                    search = (String) request.getAttribute("txtSearch");
                }
            } else {
                search = request.getParameter("txtSearch");
            }
            String name="";//name
            if (request.getParameter("txtName") == null) {
                if (request.getAttribute("txtName") != null) {
                    name = (String) request.getAttribute("txtName");
                }
            } else {
                name = request.getParameter("txtName");
            }
            String proId="";//ID
            if (request.getParameter("txtID") == null) {
                if (request.getAttribute("txtID") != null) {
                    proId = (String) request.getAttribute("txtID");
                }
            } else {
                proId = request.getParameter("txtID");
            }
            String description="";//description
            if (request.getParameter("txtDescription") == null) {
                if (request.getAttribute("txtDescription") != null) {
                    description = (String) request.getAttribute("txtDescription");
                }
            } else {
                description = request.getParameter("txtDescription");
            }
            float price=0;//price
            if (request.getParameter("txtPrice") == null) {
                if (request.getAttribute("txtPrice") != null) {
                    price = (float) request.getAttribute("txtPrice");
                }
            } else {
                price = Float.valueOf(request.getParameter("txtPrice"));
            }
            int quantity=0;//quantity
            if (request.getParameter("txtQuantity") == null) {
                if (request.getAttribute("txtQuantity") != null) {
                    quantity = (int) request.getAttribute("txtQuantity");
                }
            } else {
                quantity = Integer.valueOf(request.getParameter("txtQuantity"));
            }
            String categoryId="";//cateID
            if (request.getParameter("txtCategoryID") == null) {
                if (request.getAttribute("txtCategoryID") != null) {
                    categoryId = (String) request.getAttribute("txtCategoryID");
                }
            } else {
                categoryId = request.getParameter("txtCategoryID");
            }
            boolean check=true;//status
            if (request.getParameter("txtIsAvailable") == null) {
                if (request.getAttribute("txtIsAvailable") != null) {
                    check = (boolean) request.getAttribute("txtIsAvailable");
                }
            } else {
                check = Boolean.valueOf(request.getParameter("txtIsAvailable"));
            }
 
            ProductErrorDTO error = new ProductErrorDTO("", "", "", "", "", "", "", "", "", "");
            List<CategoryDTO> list = null;
            CategoryDAO cateDAO = new CategoryDAO();
            try {
                list = cateDAO.getAllCategoryWithID();
            } catch (Exception e) {
            }
            if (request.getAttribute("ERROR") != null) {
                error = (ProductErrorDTO) request.getAttribute("ERROR");
            }
            UserDTO admin = (UserDTO) session.getAttribute("LOGIN_ADMIN");
        %>
        <section class="shop text-center" >
            <div class="shop__header">
                <div class="row">
                    <div class="col-sm-4">
                        <a href="admin.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-cog" aria-hidden="true"></i> Admin Page</button></a>
                        <h2 style="color: greenyellow; float: left;margin-left: 10px">Welcome: <%=admin.getUserId()%></h2>  
                    </div>
                    <div class="col-sm-4"><h1 style="color: white">UPDATE PAGE</h1> </div>
                    <div class="col-sm-4">
                        <div style="float: right; display: block;color: white"> 
                            <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</button></a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div style="padding-top: 90px;"></div>
        <div class="row">
            <div class="col-sm-4"></div>
            <div class="col-sm-4">
                <form action="UpdateProductController" method="POST" enctype="multipart/form-data">
                    Product ID <input type="text" name="txtID" value="<%=proId%>" readonly="true"/><font color="red"><%=error.getProIdError()%></font></br>
                    Product Name <input type="text" name="txtName" value="<%=name%>" required="true"/><font color="red"><%=error.getNameError()%></font></br>
                    Description <input  type="text" name="txtDescription" value="<%=description%>" required="true"/><font color="red"><%=error.getDescriptionError()%></font></br>
                    Price <input type="number" step="0.1" name="txtPrice" value="<%=price%>" required="true"/><font color="red"><%=error.getPriceError()%></font></br>
                    Quantity <input type="number" name="txtQuantity" value="<%=quantity%>" required="true"/><font color="red"><%=error.getQuantityError()%></font></br>
                    Category ID 
                    <select name="txtCategoryID">
                        <%
                            for (CategoryDTO cate : list) {
                                if (categoryId.equals(cate.getID())) {
                        %>
                        <option value="<%=cate.getID()%>" selected="true"><%=cate.getName()%></option>
                        <%
                        } else {
                        %>
                        <option value="<%=cate.getID()%>"><%=cate.getName()%></option>
                        <%
                                }
                            }
                        %>           
                    </select></br>

                    Status: <%
                        if (check) {
                    %>
                    Available <input type="radio" name="status" value="true" checked="checked" /> Unavailable <input type="radio" name="status" value="false" /></br>
                    <%
                    } else {
                    %>
                    Available <input type="radio" name="status" value="true"  /> Unavailable <input type="radio" name="status" value="false" checked="checked" /></br>
                    <%
                        }
                    %>

                    Image <input type="file" name="image" value="" required="true"/><font color="red"><%=error.getImageError()%></font></br>
                    <button name="btnAction" value="Update Product" type="submit" class="btn  btn-warning">Update Product</button>

                </form>
            </div>
            <div class="col-sm-4"></div>
        </div>
        <%
            }
        %>

    </body>
</html>
