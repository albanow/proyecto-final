<%@page import="java.util.ArrayList" %>
<%@page import="com.models.HistorialPuestos" %>
<%@page import="com.models.Empleado" %>
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
        <title>Historial Puestos</title>
    </head>
    <body>
        <%
            ArrayList<HistorialPuestos> hp = (ArrayList<HistorialPuestos>)session.getAttribute("hp");
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
        <div class="container">
            <h2>Historial de puestos</h2>
            <h3>Empleado: <c:out value="${sessionScope.empleadoSelected.nombre}"/> <c:out value="${sessionScope.empleadoSelected.apellido}"/></h3>
            <table class="table table-bordered table-hover table-condensed">
                <thead>
                    <tr>
                        <th>Puesto</th>
                        <th>Fecha Inicio</th>
                        <th>Fecha Fin</th>
                        <th>Departamento</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="historial" items="${hp}">
                        <tr>
                            <td>
                                <c:out value="${historial.getIdPuesto()}"/> <c:out value="${historial.getNombrePuesto()}"/>
                            </td>
                            <td>
                                <c:out value="${historial.getFechaInicial()}"/>
                            </td>
                            <td>
                                <c:out value="${historial.getFechaFinal()}"/>
                            </td>
                            <td>
                                <c:out value="${historial.getIdDepartamento()}"/> <c:out value="${historial.getNombreDepartamento()}"/>
                            </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>

        </div>
    </body>
</html>
