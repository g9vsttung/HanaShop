<%-- 
    Document   : history
    Created on : Jan 17, 2021, 4:52:48 PM
    Author     : USER
--%>

<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tungvs.dtos.UserDTO"%>
<%@page import="tungvs.dtos.InvoiceDTO"%>
<%@page import="java.util.List"%>
<%@page import="tungvs.daos.InvoiceDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>History Page</title>
        <link rel="stylesheet" href="./css/admin.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    </head>
    <body style="background-color: #FFCAF2">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

        <%
            if (session.getAttribute("LOGIN_USER") != null) {
                UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
                InvoiceDAO dao = new InvoiceDAO();
                String search = request.getParameter("txtSearch") == null ? "" : request.getParameter("txtSearch");
                String date = request.getParameter("txtDate") == null ? "None" : request.getParameter("txtDate");
                if (request.getParameter("txtSearch") == null) {
                    List<InvoiceDTO> list = dao.getallInvoice(user.getUserId());
                    if (!list.isEmpty()) {//có his
                        Collections.sort(list, new Comparator<InvoiceDTO>() {
                            @Override
                            public int compare(InvoiceDTO o1, InvoiceDTO o2) {
                                return o2.getDate().compareTo(o1.getDate());
                            }
                        });
        %>
        <section class="shop text-center" >
            <div class="shop__header">
                <div class="row">
                    <div class="col-sm-5">
                        <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>
                        <h2 style="color: greenyellow; float: left;margin-left: 10px">Welcome: <%=user.getUserId()%></h2>  </br></br>
                        <h1 style="color: white;float: left">HISTORY PAGE</h1>

                    </div>

                    <div class="col-sm-7">
                        <div style="float: right; display: block;color: white;margin-left: 5px"> 
                            <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</button></a></br>
                            <a style="display: inline-block;float: right" href="history.jsp"><button class="btn  btn-success "><i class="fa fa-refresh" aria-hidden="true"></i> Refresh</button></a>
                        </div>

                        <div style="display: inline-block;float: right">
                            <form style="display: inline-block;float: right" action="MainController">
                                <h4 style="display: inline">Name</h4> <input style="border-radius: 5px" type="text" name="txtSearch" value="<%=search%>"/> <h4 style="display: inline">Date</h4> <input style="border-radius: 5px" type="date" name="txtDate" value="<%=date%>" /></br>                               
                                <button style="margin: 6px 0px 0px 7px;float: right;" name="btnAction" value="Search History" type="submit" class="btn  btn-info"><i class="fa fa-search" aria-hidden="true"></i></button>                                
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div style="padding-top: 160px;"></div>
        <div class="tablePro">
            <div class="table-responsive">
                <table class="table table-striped" style="background-color: white">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Invoice name</th>
                            <th>Date</th>
                            <th>Payment</th>
                            <th>Address</th>
                            <th>Phone</th>
                            <th>Total</th>
                            <th>Detail</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int count = 0;

                            SimpleDateFormat simple = new SimpleDateFormat("dd/MM/yyyy");
                            SimpleDateFormat change = new SimpleDateFormat("yyyy-MM-dd");
                            for (InvoiceDTO inv : list) {
                                count++;
                                String dateIssue = simple.format(change.parse(inv.getDate()));

                        %>
                        <tr>
                            <td><%=count%></td>
                            <td><%=inv.getID()%></td>
                            <td><%=dateIssue%></td>
                            <td><%=inv.getPayment()%></td>
                            <td><%=inv.getAddress()%></td>
                            <td><%=inv.getNumberPhone()%></td>
                            <td><%=inv.getTotal()%> $</td>
                            <td>
                                <form action="MainController">
                                    <input type="hidden" name="txtID" value="<%=inv.getID()%>" />
                                    <button name="btnAction" value="Detail" type="submit" class="btn  btn-warning"><i class="fa fa-info" aria-hidden="true"></i> Detail</button>

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
        <%
        }//end if(có list)
        else {
        %>
        <section class="shop text-center" >
            <div class="shop__header">
                <div class="row">
                    <div class="col-sm-5">
                        <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>
                        <h2 style="color: greenyellow; float: left;margin-left: 10px">Welcome: <%=user.getUserId()%></h2>  </br></br>
                        <h1 style="color: white;float: left">HISTORY PAGE</h1>

                    </div>

                    <div class="col-sm-7">
                        <div style="float: right; display: block;color: white;margin-left: 5px"> 
                            <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</button></a></br>
                            <a style="display: inline-block;float: right" href="history.jsp"><button class="btn  btn-success "><i class="fa fa-refresh" aria-hidden="true"></i> Refresh</button></a>
                        </div>

                        <div style="display: inline-block;float: right">
                            <form style="display: inline-block;float: right" action="MainController">
                                <h4 style="display: inline">Name</h4> <input style="border-radius: 5px" type="text" name="txtSearch" value="<%=search%>"/> <h4 style="display: inline">Date</h4> <input style="border-radius: 5px" type="date" name="txtDate" value="<%=date%>" /></br>                               
                                <button style="margin: 6px 0px 0px 7px;float: right;" name="btnAction" value="Search History" type="submit" class="btn  btn-info"><i class="fa fa-search" aria-hidden="true"></i></button>                                
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div style="padding-top: 160px;"></div>
        <h1>No history!</h1>
        <%
            }
        } else {//txtsearch != null
            if (request.getAttribute("LIST") != null) {
                List<InvoiceDTO> list = (List<InvoiceDTO>) request.getAttribute("LIST");
                Collections.sort(list, new Comparator<InvoiceDTO>() {
                    @Override
                    public int compare(InvoiceDTO o1, InvoiceDTO o2) {
                        return o2.getDate().compareTo(o1.getDate());
                    }
                });
        %>
        <section class="shop text-center" >
            <div class="shop__header">
                <div class="row">
                    <div class="col-sm-5">
                        <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>
                        <h2 style="color: greenyellow; float: left;margin-left: 10px">Welcome: <%=user.getUserId()%></h2>  </br></br>
                        <h1 style="color: white;float: left">HISTORY PAGE</h1>

                    </div>

                    <div class="col-sm-7">
                        <div style="float: right; display: block;color: white;margin-left: 5px"> 
                            <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</button></a></br>
                            <a style="display: inline-block;float: right" href="history.jsp"><button class="btn  btn-success "><i class="fa fa-refresh" aria-hidden="true"></i> Refresh</button></a>
                        </div>

                        <div style="display: inline-block;float: right">
                            <form style="display: inline-block;float: right" action="MainController">
                                <h4 style="display: inline">Name</h4> <input style="border-radius: 5px" type="text" name="txtSearch" value="<%=search%>"/> <h4 style="display: inline">Date</h4> <input style="border-radius: 5px" type="date" name="txtDate" value="<%=date%>" /></br>                               
                                <button style="margin: 6px 0px 0px 7px;float: right;" name="btnAction" value="Search History" type="submit" class="btn  btn-info"><i class="fa fa-search" aria-hidden="true"></i></button>                                
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div style="padding-top: 160px;"></div>
        <div class="tablePro">
            <div class="table-responsive">
                <table class="table table-striped" style="background-color: white">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Invoice name</th>
                            <th>Date</th>
                            <th>Payment</th>
                            <th>Address</th>
                            <th>Phone</th>
                            <th>Total</th>
                            <th>Detail</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int count = 0;

                            SimpleDateFormat simple = new SimpleDateFormat("dd/MM/yyyy");
                            SimpleDateFormat change = new SimpleDateFormat("yyyy-MM-dd");
                            for (InvoiceDTO inv : list) {
                                count++;
                                String dateIssue = simple.format(change.parse(inv.getDate()));

                        %>
                        <tr>
                            <td><%=count%></td>
                            <td><%=inv.getID()%></td>
                            <td><%=dateIssue%></td>
                            <td><%=inv.getPayment()%></td>
                            <td><%=inv.getAddress()%></td>
                            <td><%=inv.getNumberPhone()%></td>
                            <td><%=inv.getTotal()%> $</td>
                            <td>
                                <form action="MainController">
                                    <input type="hidden" name="txtID" value="<%=inv.getID()%>" />
                                    <button name="btnAction" value="Detail" type="submit" class="btn  btn-warning"><i class="fa fa-info" aria-hidden="true"></i> Detail</button>

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
        <%
        } else {//ko có list (no result)
            if (request.getAttribute("NO_RESULT") != null) {
        %>
        <section class="shop text-center" >
            <div class="shop__header">
                <div class="row">
                    <div class="col-sm-5">
                        <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>
                        <h2 style="color: greenyellow; float: left;margin-left: 10px">Welcome: <%=user.getUserId()%></h2>  </br></br>
                        <h1 style="color: white;float: left">HISTORY PAGE</h1>

                    </div>

                    <div class="col-sm-7">
                        <div style="float: right; display: block;color: white;margin-left: 5px"> 
                            <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</button></a> </br>
                            <a style="display: inline-block;float: right" href="history.jsp"><button class="btn  btn-success "><i class="fa fa-refresh" aria-hidden="true"></i> Refresh</button></a>
                        </div>

                        <div style="display: inline-block;float: right">
                            <form style="display: inline-block;float: right" action="MainController">
                                <h4 style="display: inline">Name</h4> <input style="border-radius: 5px" type="text" name="txtSearch" value="<%=search%>"/> <h4 style="display: inline">Date</h4> <input style="border-radius: 5px" type="date" name="txtDate" value="<%=date%>" /></br>                               
                                <button style="margin: 6px 0px 0px 7px;float: right;" name="btnAction" value="Search History" type="submit" class="btn  btn-info"><i class="fa fa-search" aria-hidden="true"></i></button>                                
                            </form>

                        </div>

                    </div>
                </div>
            </div>
        </section>
        <div style="padding-top: 160px;"></div>
        <h1><%=request.getAttribute("NO_RESULT")%></h1>
        <%
                    }
                }
            }//end txtSearch !=null
        } else {
        %>
        <section class="shop text-center" >
            <div class="shop__header">
                <div class="row">
                    <div class="col-sm-4">
                        <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>
                    </div>
                    <div class="col-sm-4">
                        <h1 style="color: white;display: inline-block">HISTORY PAGE</h1> 
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
