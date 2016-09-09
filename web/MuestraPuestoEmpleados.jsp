<%@page import="java.util.ArrayList"%>
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
        <title>Muestra puesto empleados</title>
    </head>
    <body>
         <% ArrayList<Empleado> jobEmpleados = (ArrayList<Empleado>) session.getAttribute("jobEmpleados");
        %>
        
        <div class="container myLogin" >
            <a href="Principal.jsp" class='btn btn-primary' role='button'>
                Principal <span class='glyphicon glyphicon-home' aria-hidden='true'></span>
            </a>
            <a href="ObtenerPuestos" class='btn btn-primary' role='button'>
                Regresar a Puestos <span class='glyphicon glyphicon-plus-sign' aria-hidden='true'></span>
            </a>
        </div><br>
        
        <div class="container">
            <h3>Puesto: <c:out value="${sessionScope.jobEmpleados.get(0).nombrePuesto}"/></h3>
            <table class="table table-bordered table-hover table-condensed">
                <thead>
                    <tr>
                        <th><strong>Nombre (completo)</strong></th>
                        <th>Fecha Contratacion</th>
                        <th>Puesto (id + nombre)</th>
                        <th>Email</th>
                        <th>Departamento</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="employees" items="${jobEmpleados}">
                        <tr>
                            <td>
                                    <c:out value="${employees.getNombre()}"/> <c:out value="${employees.getApellido()}"/>
                            </td>
                            <td>
                                <c:out value="${employees.getFechaContratacion()}"/>
                            </td>
                            <td> 
                                <c:out value="${employees.getIdPuesto()}"/> <c:out value="${employees.getNombrePuesto()}"/> 
                            </td>
                            <td> 
                                <c:out value="${employees.getEmail()}" /> 
                            </td>
                            <td> 
                                <c:out value="${employees.getDepartamento()}" /> 
                            </td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>
        </div>
    </body>
</html>
