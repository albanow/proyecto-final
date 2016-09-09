
<%@page import="com.models.Empleado"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="libs/jquery/dist/jquery.min.js" type="text/javascript"></script>
        <link href="libs/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="libs/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>
        <link href="css/main.css" rel="stylesheet" type="text/css"/>
        <title>No Historial</title>
    </head>
    <body>
        <%
            Empleado empleadoSelected = (Empleado)session.getAttribute("empleadoSelected");
        %>
        <div class="container myLogin" >
            <a href="Principal.jsp" class='btn btn-primary' role='button'>
                Principal <span class='glyphicon glyphicon-home' aria-hidden='true'></span>
            </a>
            <a href="Empleados" class='btn btn-primary' role='button'>
                Regresar a empleados <span class='glyphicon glyphicon-plus-sign' aria-hidden='true'></span>
            </a>
        </div><br>
         <div class="container" >
            <div class="jumbotron">
                <h1>Empleado sin historial de puestos</h1>
                <h3>Empleado: <c:out value="${sessionScope.empleadoSelected.nombre}"/> <c:out value="${sessionScope.empleadoSelected.apellido}"/></h3>
            </div> 
        </div>
        
    </body>
</html>
