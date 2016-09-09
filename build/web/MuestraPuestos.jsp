<%@page import="java.util.ArrayList"%>
<%@page import="com.models.Puesto"%>

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
        <title>Mostrar puestos</title>
    </head>
    <body>
        <%
            ArrayList<Puesto> jobss = (ArrayList<Puesto>) session.getAttribute("jobss");
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
                        <th>Puesto</th>
                        <th>Salario minimo</th>
                        <th>Salario maximo</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="puesto" items="${jobss}">
                        <tr>
                            <td>
                                <c:out value="${puesto.getIdPuesto()}"/> <c:out value="${puesto.getNombrePuesto()}"/>
                            </td>
                            <td>
                                $ <c:out value="${puesto.getMinSalario()}"/>
                            </td>
                            <td>
                                $ <c:out value="${puesto.getMaxSalario()}" />
                            </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>


    </body>
</html>
