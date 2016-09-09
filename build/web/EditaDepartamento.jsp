<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.models.DepartamentosUbicacion" %>
<%@page import="com.models.Ubicacion" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="libs/jquery/dist/jquery.min.js" type="text/javascript"></script>
        <link href="libs/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="libs/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>
        <link href="css/main.css" rel="stylesheet" type="text/css"/>
        <title>Edita departamento</title>
    </head>
    <body>
        <%
            DepartamentosUbicacion departamento = (DepartamentosUbicacion) session.getAttribute("depart");
            ArrayList<Ubicacion> ubicaciones = (ArrayList<Ubicacion>) session.getAttribute("ubicaciones");
        %>

        <div class="container myLogin">

            <div class="col-md-6 col-md-offset-3">
                <div>
                    <a href="Principal.jsp" class='btn btn-primary' role='button'>
                        Principal <span class='glyphicon glyphicon-home' aria-hidden='true'></span>
                    </a>
                </div><br>
                <form class="form-horizontal" action="EditarDepartamento" method="POST">
                    
                    <input type="hidden"
                           class="form-control"
                           name="idDepartamento"
                           value="<c:out value="${sessionScope.depart.idDepartamento}" />"
                           readonly><br>
                    Departamento: 
                    <input type="text"
                           class="form-control"
                           name="nombreDepartamento"
                           value="<c:out value="${sessionScope.depart.nombreDepartamento}" />"
                           readonly><br>
                    Gerente: 
                    <input type="text"
                           class="form-control"
                           name="nombreManager"
                           value="<c:out value="${sessionScope.depart.nombreManager}" /> <c:out value="${sessionScope.depart.apellidoManager}" />"
                           readonly><br>
                    Ubicacion:
                    <select name="idUbicacion" class="form-control">
                        <c:forEach var="ubi" items="${ubicaciones}">
                            <option value="<c:out value="${ubi.getIdUbicacion()}"/>">
                                <c:out value="${ubi.ubicacionCompleta()}"/>
                            </option>
                        </c:forEach>
                    </select><br>
                    <input type="submit" class="btn btn-success" value="Actualizar">
                    <a href="ObtenDepartamentos" class="btn btn-danger" role="button">Cancelar</a>
                </form>
            </div>
        </div>
    </body>
</html>
