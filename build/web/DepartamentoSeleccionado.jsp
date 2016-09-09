<%@page import="java.util.ArrayList" %>
<%@page import="com.models.Empleado" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Departamento Seleccionado</title>
        <script src="libs/jquery/dist/jquery.min.js" type="text/javascript"></script>
        <link href="libs/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="libs/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>
        <link href="css/main.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%
            ArrayList<Empleado> empleadoss = (ArrayList<Empleado>) session.getAttribute("empleadoss");
        %>
        <div class="container myLogin" >
            <a href="Principal.jsp" class='btn btn-primary' role='button'>
                Principal <span class='glyphicon glyphicon-home' aria-hidden='true'></span>
            </a>
            <a href="ObtenDepartamentos" class='btn btn-primary' role='button'>
                Departamentos <span class='glyphicon glyphicon-menu-left' aria-hidden='true'></span>
            </a>
        </div><br>
        <div class="container">
            <h2>Departamento: <c:out value="${empleadoss.get(0).getDepartamento()}"/></h2>
            <table class="table table-bordered table-hover table-condensed">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Fecha de Contratacion</th>
                        <th>Puesto</th>
                        <th>Email</th>
                        <th>Departamento</th>
                    </tr>
                </thead>
                <tbody>
                    
                    <c:forEach var="employee" items="${empleadoss}">
                        
                        <tr>
                            <td>
                                
                                <c:out value="${employee.getNombre()}"/> <c:out value="${employee.getApellido()}"/>
                            </td>
                            <td>
                                <c:out value="${employee.getFechaContratacion()}"/>
                            </td>
                            <td>
                                <c:out value="${employee.getIdPuesto()}"/> <c:out value="${employee.getNombrePuesto()}"/>
                            </td>
                            <td>
                                <c:out value="${employee.getEmail()}"/>
                            </td>
                            <td>
                                <c:out value="${employee.getDepartamento()}"/>
                            </td>
                        </tr>
                    </c:forEach>
                        
                </tbody>
            </table>
        </div>

    </body>
</html>
