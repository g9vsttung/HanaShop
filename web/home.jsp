<%-- 
    Document   : hometest
    Created on : Jan 15, 2021, 3:14:39 PM
    Author     : USER
--%>

<%@page import="tungvs.daos.ProductDAO"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="tungvs.dtos.UserDTO"%>
<%@page import="tungvs.dtos.ProductDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tungvs.daos.CategoryDAO"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./css/home.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    </head>
    <body style="background-color: #FFCAF2">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <%!final int MAX_PRODUCT_PER_PAGE = 20;%>
        <c:set value="${20}" var="MAX_PRODUCT_PER_PAGE"/>
        <sql:setDataSource var="con"
                           driver="com.microsoft.sqlserver.jdbc.SQLServerDriver"
                           url="jdbc:sqlserver://SE140240\\SQLEXPRESS:1433; databaseName=CarRenter;"
                           user="sa" password="123456" scope="page"
                           />
        <c:set value="${param.txtSearch}" var="search"/>
        <c:choose>
            <c:when test="${ not empty requestScope.LIST}">
                <c:set value="${requestScope.SIZE}" var="size"/>
                <c:set value="${0}" var="noPage"/>
                <c:choose>
                    <c:when test="${not empty requestScope.CUR_PAGE}">
                        <c:set value="${requestScope.CUR_PAGE}" var="curPage"/>
                    </c:when>
                    <c:otherwise>
                        <c:set value="${1}" var="curPage"/>
                    </c:otherwise>
                </c:choose>

                <c:choose>
                    <c:when test="${size % MAX_PRODUCT_PER_PAGE == 0}">
                        <c:set value="${size / MAX_PRODUCT_PER_PAGE}" var="noPage"/>
                    </c:when>
                    <c:otherwise>
                        <c:set value="${size / MAX_PRODUCT_PER_PAGE + 1}" var="noPage"/>
                    </c:otherwise>
                </c:choose>
                <c:set value="${(curPage-1) * MAX_PRODUCT_PER_PAGE}" var="startIndex"/>


                <section class="shop">
                    <div class="shop__header">
                        <div class="shop__title">
                            <h1 class="title" >Hana Shop</h1> 
                            <a href="home.jsp"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>

                            <c:choose>
                                <c:when test="${not empty sessionScope.LOGIN_USER}">
                                    <a  href="history.jsp"><button class="btn  btn-success "><i class="fa fa-history" aria-hidden="true"></i> History</button></a>
                                    <div style=" display: inline-block;color: white"> 
                                        <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</button></a>
                                    </div>
                                    <h4 class="welcome">Welcome: ${sessionScope.LOGIN_USER.userId}</h4>
                                </c:when>
                                <c:when test="${not empty sessionScope.LOGIN_ADMIN}">
                                    <div style=" display: inline-block;color: white"> 
                                        <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</button></a>
                                        <a href="admin.jsp"><button class="btn  btn-warning "><i class="fa fa-cog" aria-hidden="true"></i> Admin Page</button></a>
                                    </div>
                                    <h4 class="welcome">Welcome: ${requestScope.LOGIN_ADMIN.userId}</h4>
                                </c:when>
                                <c:otherwise>
                                    <div style=" display: inline-block;color: white"><a href="login.jsp" ><button class="btn btn-warning"><i class="fa fa-sign-in" aria-hidden="true"></i> Login</button></a></div>
                                </c:otherwise>
                            </c:choose>

                        </div>
                        <div class="shop__text">
                            <form class="search" action="MainController">
                                <h4 style="display: inline">Search Field</h4> <input style="border-radius: 5px" type="text" name="txtSearch" value="${search}" />            
                                <select name="cbCategory" style="margin-top: 15px">
                                    <option>All</option>
                                    <c:forEach var="cate" items="${requestScope.CATE_LIST}">
                                        <option>${cate}</option>
                                    </c:forEach>                           
                                </select>
                                <h4 style="display: inline">From</h4> <input style="border-radius: 5px" type="number" name="txtFrom" value="0" required="true"/> <h4 style="display: inline">To</h4> <input style="border-radius: 5px" type="number" name="txtTo" value="" />  <h4 style="display: inline">$</h4></br>
                                <button style="margin: 6px 0px 0px 7px;float: right;" name="btnAction" value="Search Product" type="submit" class="btn  btn-info"><i class="fa fa-search" aria-hidden="true"></i></button>
                                <button style="margin: 6px 0px 0px 7px;float: right;" name="btnAction" value="View Cart" type="submit" class="btn  btn-warning"><i class="fa fa-shopping-cart" aria-hidden="true"></i> Cart</button>
                            </form>  
                        </div>


                    </div>

                    <!--end title-->
                    <!--product list-->
                    <div class="shop__products">
                        <c:if test="${not empty requestScope.MESSAGE}">
                            <font color="red"><h2>${requestScope.MESSAGE}</h2></font>
                            </c:if>
                        <div class="products">
                            <c:set value="${0}" var="ranged"/>
                            <c:choose>
                                <c:when test="${size - ((curPage - 1) * MAX_PRODUCT_PER_PAGE) < MAX_PRODUCT_PER_PAGE}">
                                    <c:set value="${size}" var="ranged"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set value="${startIndex + MAX_PRODUCT_PER_PAGE}" var="ranged"/>
                                </c:otherwise>
                            </c:choose>
                            <c:set value="${0}" var="count"/>
                            <c:forEach var="product" items="${requestScope.LIST}" begin="${startIndex}" end="${ranged -1}" >
                                <div class="products__item"><!--product-->
                                    <article class="product">
                                        <div class="product__title">
                                            <img src="./images/${product.image}" width="120" height="130"/></br>

                                            <font color="blue"></font>
                                            <p>${product.name}</p>
                                            <div class="info">
                                                <p class="des">${product.description}</p>

                                                <span style="color: blue;">Create:</span> ${product.createDate}</br>                                   
                                                <span style="color: blue">Quantity:</span>${product.quantity}</br>
                                                <span style="color: blue">Type:</span> ${product.categoryName}</br>
                                                <p style="text-align: center">${product.price} $</p>
                                            </div>

                                        </div>
                                        <p class="product__text">
                                        <form action="MainController">
                                            <input class="button js-add-product" type="submit" value="Add" name="btnAction" /> 
                                            <input type="hidden" name="txtID" value="${product.proId}" />                                        

                                        </form>
                                        </p>
                                    </article>
                                </div><!--end product-->
                            </c:forEach>

                        </div>
                    </div><!--end list-->
                    <!--paging-->
                    <form class="pageForm" action="MainController"></br></br>
                        <c:choose>
                            <c:when test="${curPage >= 3}">
                                <c:choose>
                                    <c:when test="${(noPage - curPage) <= 2}">
                                        <c:set var="i" value="${curPage-2}"/>
                                        <c:forEach begin="${curPage-2}" end="${noPage}">                                    
                                            <input type="submit" value="${i}" name="btnAction" width="30"/>
                                            <c:set var="i" value="${i + 1}"/>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="i" value="${curPage-2}"/>
                                        <c:forEach begin="${curPage-2}" end="${curPage + 2}">
                                            <input type="submit" value="${i}" name="btnAction" width="30"/>
                                            <c:set var="i" value="${i + 1}"/>

                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${(noPage - curPage) <= 4}">
                                        <c:set var="i" value="${1}"/>
                                        <c:forEach begin="${1}" end="${noPage}">                                    
                                            <input type="submit" value="${i}" name="btnAction" width="30"/>
                                            <c:set var="i" value="${i+1}"/>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="i" value="${1}"/>
                                        <c:forEach begin="${1}" end="${5}">                                    
                                            <input type="submit" value="${i}" name="btnAction" width="30"/>
                                            <c:set var="i" value="${i+1}"/>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>

                            </c:otherwise>
                        </c:choose>

                        </br>
                        <c:if test="${not empty sessionScope.LOGIN_ADMIN}">
                            <input type="hidden" name="isAdmin" value="true" />
                        </c:if>


                    </form>
                </section>
            </c:when>
            <c:otherwise>
                <h2>Product are sold out</h2>
            </c:otherwise>
        </c:choose>
        <h2>We had sold out all product!!! Sorry, we will get product more <3</h2>   


    </body>
</html>
