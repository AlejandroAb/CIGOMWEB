<%-- 
    Document   : error.jsp
    Created on : 24/11/2016, 01:15:56 PM
    Author     : Alejandro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CIGOM - ERROR</title>
    </head>
    <body>
        <br>
        <center>  
                <img src="images/error.png">
                <br>
                <h5 style="color:#EC1010">
                    <b>"<%= request.getAttribute("msg")%>"</b>
                </h5> 
        </center>
    </body>
</html>
