<%-- 
    Document   : add_product
    Created on : Jan 11, 2021, 7:17:41 AM
    Author     : USER
--%>

<%@page import="tungvs.dtos.CategoryDTO"%>
<%@page import="tungvs.daos.CategoryDAO"%>
<%@page import="java.util.List"%>
<%@page import="tungvs.dtos.UserDTO"%>
<%@page import="tungvs.dtos.ProductErrorDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Page</title>
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
        } else {//la admin
            String proId = request.getAttribute("txtID") == null ? "" : (String) request.getAttribute("txtID");
            String name = request.getAttribute("txtName") == null ? "" : (String) request.getAttribute("txtName");
            String description = request.getAttribute("txtDescription") == null ? "" : (String) request.getAttribute("txtDescription");
            float price = request.getAttribute("txtPrice") == null ? 0 : (float) request.getAttribute("txtPrice");
            int quantity = request.getAttribute("txtQuantity") == null ? 0 : (int) request.getAttribute("txtQuantity");
            String categoryId = request.getAttribute("txtCategoryID") == null ? "" : (String) request.getAttribute("txtCategoryID");
            ProductErrorDTO error = new ProductErrorDTO("", "", "", "", "", "", "", "", "", "");
            List<CategoryDTO> list=null;
            CategoryDAO cateDAO=new CategoryDAO();
            try {
                list=cateDAO.getAllCategoryWithID();
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
                        <a href="admin.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-cog" aria-hidden="true"></i></button></a>
                        <h2 style="color: greenyellow; float: left;margin-left: 10px">Welcome: <%=admin.getUserId()%></h2>  
                    </div>
                    <div class="col-sm-4"><h1 style="color: white">INSERT PAGE</h1> </div>
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
                <form action="AddProductController" method="POST" enctype="multipart/form-data">
            Product ID <input type="text" name="txtID" value="<%=proId%>" required="true"/><font color="red"><%=error.getProIdError()%></font></br>
            Product Name <input type="text" name="txtName" value="<%=name%>" required="true"/><font color="red"><%=error.getNameError()%></font></br>
            Description <input type="text" name="txtDescription" value="<%=description%>" required="true"/><font color="red"><%=error.getDescriptionError()%></font></br>
            Price <input type="number" step="0.1" name="txtPrice" value="<%=price%>" required="true"/><font color="red"><%=error.getPriceError()%></font></br>
            Quantity <input type="number" name="txtQuantity" value="<%=quantity%>" required="true"/><font color="red"><%=error.getQuantityError()%></font></br>
            Category ID 
            <select name="txtCategoryID">
                <%
                for(CategoryDTO cate:list){
                    if(categoryId.equals(cate.getID())){
                        %>
                        <option value="<%=cate.getID()%>" selected="true"><%=cate.getName()%></option>
                <%
                    }else{
                            %>
                        <option value="<%=cate.getID()%>"><%=cate.getName()%></option>
                    <%      
                    }                    
                }
                %>           
            </select></br>
            Image <input type="file" name="image" value="" required="true"/><font color="red"><%=error.getImageError()%></font></br>
            <button name="btnAction" value="Insert Product" type="submit" class="btn  btn-warning">Insert Product</button>
            
        </form>
            </div>
            <div class="col-sm-4"></div>
        </div>
        

        <%

            }

        %>


    </body>
</html>
