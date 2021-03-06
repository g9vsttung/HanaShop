<%-- 
    Document   : admintest
    Created on : Jan 16, 2021, 9:44:30 PM
    Author     : USER
--%>

<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="tungvs.daos.CategoryDAO"%>
<%@page import="java.util.List"%>
<%@page import="tungvs.dtos.UserDTO"%>
<%@page import="tungvs.dtos.ProductDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tungvs.dtos.CartDTO"%>
<%@page import="tungvs.daos.ProductDAO"%>
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
        <%!final int MAX_PRODUCT_PER_PAGE = 20;%>
        <%
            if (session.getAttribute("LOGIN_ADMIN") != null) {
                UserDTO admin = (UserDTO) session.getAttribute("LOGIN_ADMIN");
                String search = request.getParameter("txtSearch") == null ? "" : request.getParameter("txtSearch");
                List<String> cateList = null;
                CategoryDAO cateDAO = new CategoryDAO();
                try {
                    cateList = cateDAO.getAllCategory();
                } catch (Exception e) {
                }
                if (request.getParameter("txtSearch") == null) {
                    ProductDAO dao = new ProductDAO();
                    List<ProductDTO> list = dao.getAllProducts();
                    int size = list.size();

                    if (list.isEmpty()) {
        %>
        <section class="shop text-center" >
            <div class="shop__header">
                <div class="row">
                    <div class="col-sm-4">
                        <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>
                        <h2 style="color: greenyellow; float: left;margin-left: 10px">Welcome: <%=admin.getUserId()%></h2>  
                        </br></br>
                        <a href="admin.jsp" style="float: left"><button class="btn  btn-warning ">Admin Page</button></a>
                    </div>
                    <div class="col-sm-4"><h1 style="color: white">ADMIN PAGE</h1> </div>
                    <div class="col-sm-4">
                        <div style="float: right; display: block;color: white"> 
                            Logout <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-out" aria-hidden="true"></i></button></a>
                        </div>
                        </br>
                        <div style="display: inline-block;float: right">
                            <form style="display: inline-block;float: right" action="MainController">
                                Search Field <input type="text" name="txtSearch" value="<%=search%>" />            
                                <select name="cbCategory" required="">
                                    <option>All</option>
                                    <%
                                        for (String cate : cateList) {
                                    %>
                                    <option><%=cate%></option>
                                    <%
                                        }
                                    %>
                                </select> 
                                <select name="cbStatus">
                                    <option>All</option>
                                    <option>Available</option>
                                    <option>Unavailable</option>
                                </select>
                                <button style="margin: 6px 0px 0px 7px;float: right;" name="btnAction" value="Search" type="submit" class="btn  btn-info"><i class="fa fa-search" aria-hidden="true"></i></button>
                                <button style="margin: 6px 0px 0px 7px;float: right;" name="btnAction" value="Add Product" type="submit" class="btn  btn-warning">Add Product</button></br>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div style="padding-top: 160px;"></div>
        <div style="margin-left: 20px;">
            <h1>No product in system!</h1>          
        </div>
        <%
        } else {// list product not empty
            Collections.sort(list, new Comparator<ProductDTO>() {
                @Override
                public int compare(ProductDTO o1, ProductDTO o2) {
                    return o2.getCreateDate().compareTo(o1.getCreateDate());
                }
            });
            int noPage = 0;
            int curPage = request.getAttribute("CUR_PAGE") == null ? 1 : (int) request.getAttribute("CUR_PAGE");
            if (size % MAX_PRODUCT_PER_PAGE == 0) {
                noPage = size / MAX_PRODUCT_PER_PAGE;
            } else {
                noPage = (size / MAX_PRODUCT_PER_PAGE) + 1;
            }
            int startIndex = ((curPage - 1) * MAX_PRODUCT_PER_PAGE);
            int ranged = 0;
            if (size - ((curPage - 1) * MAX_PRODUCT_PER_PAGE) < MAX_PRODUCT_PER_PAGE) {
                ranged = size;
            } else {
                ranged = startIndex + MAX_PRODUCT_PER_PAGE;
            }
        %>


        <section class="shop text-center" >
            <div class="shop__header">
                <div class="row">
                    <div class="col-sm-4">
                        <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>
                        <h2 style="color: greenyellow; float: left;margin-left: 10px">Welcome: <%=admin.getUserId()%></h2>  
                        </br></br>
                        <a href="admin.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-cog" aria-hidden="true"></i>Admin Page</button></a>
                    </div>
                    <div class="col-sm-4">
                        <h1 style="color: white">ADMIN PAGE</h1> 
                    </div>
                    <div class="col-sm-4">
                        <div style="float: right; display: block;color: white"> 
                            <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</button></a>
                        </div>
                        </br>
                        <div style="display: inline-block;float: right">
                            <form style="display: inline-block;float: right" action="MainController">
                                Search Field <input type="text" name="txtSearch" value="<%=search%>" />            
                                <select name="cbCategory" required="">
                                    <option>All</option>
                                    <%
                                        for (String cate : cateList) {
                                    %>
                                    <option><%=cate%></option>
                                    <%
                                        }
                                    %>
                                </select> 
                                <select name="cbStatus">
                                    <option>All</option>
                                    <option>Available</option>
                                    <option>Unavailable</option>
                                </select>
                                <button style="margin: 6px 0px 0px 7px;float: right;" name="btnAction" value="Search" type="submit" class="btn  btn-info"><i class="fa fa-search" aria-hidden="true"></i></button>
                                <button style="margin: 6px 0px 0px 7px;float: right;" name="btnAction" value="Add Product" type="submit" class="btn  btn-warning">Add Product</button></br>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <form action="MainController">
            <div style="padding-top: 160px;">

                <div class="tablePro">
                    <div class="table-responsive">
                        <table class="table table-striped" style="background-color: white">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Product ID</th>
                                    <th>Name</th>
                                    <th>Description</th>
                                    <th>Price</th>
                                    <th>Create Date</th>
                                    <th>Update Date</th>
                                    <th>Quantity</th>
                                    <th>Category</th>
                                    <th>Is Available</th>
                                    <th>Image</th>
                                    <th>Delete</th>
                                    <th>Update</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 0;
                                    boolean delete = false;
                                    SimpleDateFormat simple = new SimpleDateFormat("dd/MM/yyyy");
                                    for (int i = startIndex; i < ranged; i++) {

                                        count++;
                                        ProductDTO product = list.get(i);
                                %>
                                <tr>
                                    <td><%=count%></td>
                                    <td><%=product.getProId()%></td>
                                    <td><%=product.getName()%></td>
                                    <td><%=product.getDescription()%></td>
                                    <td><%=product.getPrice()%> $</td>
                                    <td><%=simple.format(product.getCreateDate())%></td>                                
                                    <td>
                                        <%
                                            if (product.getUpdateDate() == null) {
                                        %>
                                        Not yet update
                                        <%
                                        } else {
                                        %>
                                        <%=simple.format(product.getUpdateDate())%>
                                        <%
                                            }
                                        %>
                                    </td>
                                    <td><%=product.getQuantity()%></td>
                                    <td><%=product.getCategoryName()%></td>
                                    <td><%=product.isIsAvailable()%></td>
                                    <td><img src="./images/<%=product.getImage()%>" width="80" height="100"</td>       
                                    <td>
                                        <%
                                        if(product.isIsAvailable()){
                                            %>
                                            <input type="checkbox" name="checkDelete" value="<%=product.getProId()%>" />
                                        <%
                                        }
                                        %>
                                        

                                    </td>
                                    <td>
                                        <form action="MainController">
                                            <input type="submit" value="Update" name="btnAction" />
                                            <input type="hidden" name="txtID" value="<%=product.getProId()%>" />
                                            <input type="hidden" name="txtName" value="<%=product.getName()%>" />
                                            <input type="hidden" name="txtDescription" value="<%=product.getDescription()%>" />
                                            <input type="hidden" name="txtPrice" value="<%=product.getPrice()%>" />
                                            <input type="hidden" name="txtQuantity" value="<%=product.getQuantity()%>" />
                                            <input type="hidden" name="txtCategoryID" value="<%=product.getCategoryId()%>" />
                                            <input type="hidden" name="txtIsAvailable" value="<%=product.isIsAvailable()%>" />
                                            <input type="hidden" name="txtSearch" value="<%=search%>" /> 
                                            <input type="hidden" name="txtImage" value="<%=product.getImage()%>" /> 
                                            <select hidden name="cbCategory" required="">
                                                <option>All</option>
                                                <%
                                                    for (String cate : cateList) {
                                                %>
                                                <option><%=cate%></option>
                                                <%
                                                    }
                                                %>
                                            </select> 
                                        </form>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>

                            </tbody>
                        </table>
                    </div> 
                </div>
            </div>
            
            <button style="margin: 6px 0px 0px 7px" onclick="return confirm('Are you sure to dalete all items selected?')" name="btnAction" value="Delete All Selected" type="submit" class="btn  btn-warning">Delete selected</button>
            <input type="hidden" name="txtSearch" value="<%=search%>" />
        </form>


        <form class="pageForm" action="MainController"></br>
            <%
                if (curPage >= 3) {
                    if ((noPage - curPage) <= 2) {
                        for (int i = curPage - 2; i <= noPage; i++) {
            %>
            <input type="submit" value="<%=i%>" name="btnAction" width="30"/>
            <%
                }
            } else {
                for (int i = curPage - 2; i <= curPage + 2; i++) {
            %>
            <input type="submit" value="<%=i%>" name="btnAction" width="30"/>
            <%
                    }
                }
            } else {
                if ((noPage - curPage) <= 2) {
                    for (int i = 1; i <= noPage; i++) {
            %>
            <input type="submit" value="<%=i%>" name="btnAction" width="30"/>
            <%
                }
            } else {
                for (int i = 1; i <= curPage + 2; i++) {
            %>
            <input type="submit" value="<%=i%>" name="btnAction" width="30"/>
            <%
                        }
                    }
                }


            %>
            </br>
            
        </form>

        <%
                //end else list not empty        
            }
        } else {//txtSearch is exist
        %>

        <%
            ProductDAO dao = new ProductDAO();
            if (request.getAttribute("SEARCH_LIST") == null) {
        %>
        <h2>No result!!!</h2>
        <%
        } else {// list product not empty
            List<ProductDTO> list = (List<ProductDTO>) request.getAttribute("SEARCH_LIST");
            int size = list.size();
            Collections.sort(list, new Comparator<ProductDTO>() {
                @Override
                public int compare(ProductDTO o1, ProductDTO o2) {
                    return o2.getCreateDate().compareTo(o1.getCreateDate());
                }
            });
            int noPage = 0;
            int curPage = request.getAttribute("CUR_PAGE") == null ? 1 : (int) request.getAttribute("CUR_PAGE");
            if (size % MAX_PRODUCT_PER_PAGE == 0) {
                noPage = size / MAX_PRODUCT_PER_PAGE;
            } else {
                noPage = (size / MAX_PRODUCT_PER_PAGE) + 1;
            }
            int startIndex = ((curPage - 1) * MAX_PRODUCT_PER_PAGE);
            int ranged = 0;
            if (size - ((curPage - 1) * MAX_PRODUCT_PER_PAGE) < MAX_PRODUCT_PER_PAGE) {
                ranged = size;
            } else {
                ranged = startIndex + MAX_PRODUCT_PER_PAGE;
            }
        %>


        <section class="shop text-center" >
            <div class="shop__header">
                <div class="row">
                    <div class="col-sm-4">
                        <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>
                        <h2 style="color: greenyellow; float: left;margin-left: 10px">Welcome: <%=admin.getUserId()%></h2> 
                        </br></br>
                        <a href="admin.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-cog" aria-hidden="true"></i>Admin Page</button></a>
                    </div>
                    <div class="col-sm-4"><h1 style="color: white">ADMIN PAGE</h1> </div>
                    <div class="col-sm-4">
                        <div style="float: right; display: block;color: white"> 
                            <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</button></a>
                        </div>
                        </br>
                        <div style="display: inline-block;float: right">
                            <form style="display: inline-block;float: right" action="MainController">
                                Search Field <input type="text" name="txtSearch" value="<%=search%>" />            
                                <select name="cbCategory" required="">
                                    <option>All</option>
                                    <%
                                        for (String cate : cateList) {
                                    %>
                                    <option><%=cate%></option>
                                    <%
                                        }
                                    %>
                                </select> 
                                <select name="cbStatus">
                                    <option>All</option>
                                    <option>Available</option>
                                    <option>Unavailable</option>
                                </select>
                                <button style="margin: 6px 0px 0px 7px;float: right;" name="btnAction" value="Search" type="submit" class="btn  btn-info"><i class="fa fa-search" aria-hidden="true"></i></button>
                                <button style="margin: 6px 0px 0px 7px;float: right;" name="btnAction" value="Add Product" type="submit" class="btn  btn-warning">Add Product</button></br>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </section>
        <form action="MainController">
            <div style="padding-top: 160px;">

                <div class="tablePro">
                    <div class="table-responsive">
                        <table class="table table-striped" style="background-color: white">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Product ID</th>
                                    <th>Name</th>
                                    <th>Description</th>
                                    <th>Price</th>
                                    <th>Create Date</th>
                                    <th>Update Date</th>
                                    <th>Quantity</th>
                                    <th>Category</th>
                                    <th>Is Available</th>
                                    <th>Image</th>
                                    <th>Delete</th>
                                    <th>Update</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 0;
                                    boolean delete = false;
                                    SimpleDateFormat simple = new SimpleDateFormat("dd/MM/yyyy");
                                    for (int i = startIndex; i < ranged; i++) {

                                        count++;
                                        ProductDTO product = list.get(i);
                                %>
                                <tr>
                                    <td><%=count%></td>
                                    <td><%=product.getProId()%></td>
                                    <td><%=product.getName()%></td>
                                    <td><%=product.getDescription()%></td>
                                    <td><%=product.getPrice()%> $</td>
                                    <td><%=simple.format(product.getCreateDate())%></td>                                
                                    <td>
                                        <%
                                            if (product.getUpdateDate() == null) {
                                        %>
                                        Not yet update
                                        <%
                                        } else {
                                        %>
                                        <%=simple.format(product.getUpdateDate())%>
                                        <%
                                            }
                                        %>
                                    </td>
                                    <td><%=product.getQuantity()%></td>
                                    <td><%=product.getCategoryName()%></td>
                                    <td><%=product.isIsAvailable()%></td>
                                    <td><img src="./images/<%=product.getImage()%>" width="80" height="100"</td>       
                                    <td>
                                        <%
                                        if(product.isIsAvailable()){
                                            %>
                                            <input type="checkbox" name="checkDelete" value="<%=product.getProId()%>" />
                                        <%
                                        }
                                        %>
                                    </td>
                                    <td>
                                        <form action="MainController">
                                            <input type="submit" value="Update" name="btnAction" />
                                            <input type="hidden" name="txtID" value="<%=product.getProId()%>" />
                                            <input type="hidden" name="txtName" value="<%=product.getName()%>" />
                                            <input type="hidden" name="txtDescription" value="<%=product.getDescription()%>" />
                                            <input type="hidden" name="txtPrice" value="<%=product.getPrice()%>" />
                                            <input type="hidden" name="txtQuantity" value="<%=product.getQuantity()%>" />
                                            <input type="hidden" name="txtCategoryID" value="<%=product.getCategoryId()%>" />
                                            <input type="hidden" name="txtIsAvailable" value="<%=product.isIsAvailable()%>" />
                                            <input type="hidden" name="txtSearch" value="<%=search%>" /> 
                                            <input type="hidden" name="txtImage" value="<%=product.getImage()%>" /> 
                                            <select hidden name="cbCategory" required="">
                                                <option>All</option>
                                                <%
                                                    for (String cate : cateList) {
                                                %>
                                                <option><%=cate%></option>
                                                <%
                                                    }
                                                %>
                                            </select> 
                                        </form>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>

                            </tbody>
                        </table>
                    </div> 
                </div>
            </div>
            <button style="margin: 6px 0px 0px 7px" onclick="return confirm('Are you sure to dalete all items selected?')" name="btnAction" value="Delete All Selected" type="submit" class="btn  btn-warning">Delete selected</button>
            <input type="hidden" name="txtSearch" value="<%=search%>" />
        </form>



        <form class="pageForm" action="MainController"></br></br>
            <%
                if (curPage >= 3) {
                    if ((noPage - curPage) <= 2) {
                        for (int i = curPage - 2; i <= noPage; i++) {
            %>
            <input type="submit" value="<%=i%>" name="btnAction" width="30"/>
            <%
                }
            } else {
                for (int i = curPage - 2; i <= curPage + 2; i++) {
            %>
            <input type="submit" value="<%=i%>" name="btnAction" width="30"/>
            <%
                    }
                }
            } else {
                if ((noPage - curPage) <= 2) {
                    for (int i = 1; i <= noPage; i++) {
            %>
            <input type="submit" value="<%=i%>" name="btnAction" width="30"/>
            <%
                }
            } else {
                for (int i = 1; i <= curPage + 2; i++) {
            %>
            <input type="submit" value="<%=i%>" name="btnAction" width="30"/>
            <%
                        }
                    }
                }
            %>
            </br>
            
        </form>
        <%
                    //end else list not empty        
                }
            }
        } else {
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
            }
        %>
    </body>
</html>
