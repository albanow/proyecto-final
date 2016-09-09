<%@page import="java.util.ArrayList" %>
<%@page import="com.models.Ubicacion" %>
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
        <title>Ubicaciones</title>
    </head>
    <body>
        <%
            ArrayList<Ubicacion> locations = (ArrayList<Ubicacion>) session.getAttribute("locations");
        %>
        <div class="container myLogin" >
            <a href="Principal.jsp" class='btn btn-primary' role='button'>
                Principal <span class='glyphicon glyphicon-home' aria-hidden='true'></span>
            </a>
        </div><br>
        <div class="container">
            <table class="table table-bordered table-hover table-condensed">
                <thead>
                    <tr>
                        <th>Calle</th>
                        <th>Codigo Postal</th>
                        <th>Ciudad</th>
                        <th>Estado</th>
                        <th>Pais</th>
                        <th>Region</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="loc" items="${locations}">
                        <tr>
                            <td>
                                <a href="ObtenDepartamentosUbicacion?idUbicacion=<c:out value="${loc.getIdUbicacion()}"/>">
                                    <c:out value="${loc.getIdUbicacion()}"/> - <c:out value="${loc.getCalle()}"/>
                                </a>
                                
                            </td>
                            <td>
                                <c:out value="${loc.getCp()}"/>
                            </td>
                            <td>
                                <c:out value="${loc.getCiudad()}"/>
                            </td>
                            <td>
                                <c:out value="${loc.getEstado()}"/>
                            </td>
                            <td>
                                <c:out value="${loc.getIdPais()}"/>
                            </td>
                            <td>
                                <c:out value="${loc.getNombrePais()}"/>
                            </td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>

        </div>
    </body>
</html>
