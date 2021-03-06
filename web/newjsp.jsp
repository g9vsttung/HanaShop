<%-- 
    Document   : newjsp
    Created on : Mar 6, 2021, 9:02:03 AM
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
    <body>
         <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <%!final int MAX_PRODUCT_PER_PAGE = 20;%>
        <sql:setDataSource var="con"
                           driver="com.microsoft.sqlserver.jdbc.SQLServerDriver"
                           url="jdbc:sqlserver://SE140240\\SQLEXPRESS:1433; databaseName=CarRenter;"
                           user="sa" password="123456" scope="page"
                           />
        <c:set value="${param.txtSearch}" var="search"/>
        
    </body>
</html>
