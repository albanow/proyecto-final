<%@page import="java.util.ArrayList"%>
<%@page import="com.models.DepartamentosUbicacion"%>

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
        <title>Departamentos ubicacion</title>
    </head>
    <body>
        <%
            ArrayList<DepartamentosUbicacion> depaLocation = (ArrayList<DepartamentosUbicacion>) session.getAttribute("depaLocation");
        %>

        <div class="container myLogin" >
            <a href="Principal.jsp" class='btn btn-primary' role='button'>
                Principal <span class='glyphicon glyphicon-home' aria-hidden='true'></span>
            </a>
            <a href="ObtenerUbicaciones" class='btn btn-primary' role='button'>
                Regresar a Ubicaciones <span class='glyphicon glyphicon-home' aria-hidden='true'></span>
            </a>
        </div><br>
        
        <div class="container">
            <table class="table table-bordered table-hover table-condensed">
                <thead>
                    <tr>
                        <th>Nombre Departamento</th>
                        <th>Gerente</th>
                        <th>Ubicacion</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="dptsUbi" items="${depaLocation}">
                        <tr>
                            <td>
                                   <c:out value="${dptsUbi.getNombreDepartamento()}"/>
                            </td>
                            <td>
                                <c:out value="${dptsUbi.getNombreManager()}"/> 
                                <c:out value="${dptsUbi.getApellidoManager()}"/>
                            </td>
                            <td>
                                <c:out value="${dptsUbi.getIdUbicacion()}" />,
                                <c:out value="${dptsUbi.getCalleUbicacion()}" />,
                                ZIP <c:out value="${dptsUbi.getCpUbicacion()}" />,
                                <c:out value="${dptsUbi.getCiudadUbicacion()}" />,
                                <c:out value="${dptsUbi.getEstadoUbicacion()}" />,
                                <c:out value="${dptsUbi.getNombrePais()}" />,
                                <c:out value="${dptsUbi.getNombreRegion()}" />
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
