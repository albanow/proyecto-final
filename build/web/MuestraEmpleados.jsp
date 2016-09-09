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
        <title>Empleados</title>
    </head>
    <body>

        <% ArrayList<Empleado> empleados = (ArrayList<Empleado>) session.getAttribute("empleados");
        %>

        <div class="container myLogin" >
            <a href="Principal.jsp" class='btn btn-primary' role='button'>
                Principal <span class='glyphicon glyphicon-home' aria-hidden='true'></span>
            </a>
            <a href="PuestosDepartamentos" class='btn btn-primary' role='button'>
                Agregar Empleado <span class='glyphicon glyphicon-plus-sign' aria-hidden='true'></span>
            </a>
        </div><br>

        <div class="container">
            <table class="table table-bordered table-hover table-condensed">
                <thead>
                    <tr>
                        <th><strong>Nombre (completo)</strong></th>
                        <th>Fecha Contratacion</th>
                        <th>Puesto (id + nombre)</th>
                        <th>Email</th>
                        <th>Departamento</th>
                        <th></th>
                        <th></th>
                        
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="employees" items="${empleados}">
                        <tr>
                            <td>
                                <a href="ObtenHistorialPuestos?idEmpleado=<c:out value="${employees.getIdEmpleado()}"/>">
                                    <c:out value="${employees.getNombre()}"/> <c:out value="${employees.getApellido()}"/>
                                </a>
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
                            <td>
                                <a href="EliminaEmpleado?idEmpleado=<c:out value="${employees.getIdEmpleado()}"/>" 
                                   class='btn btn-danger' 
                                   role='button' 
                                   onclick="return confirm('Eliminar empleado?')">
                                    Eliminar <span class='glyphicon glyphicon-remove' aria-hidden='true'></span>
                                </a>
                            </td>
                            <td>
                                <a href="ObtenerEmpleado?idEmpleado=<c:out value="${employees.getIdEmpleado()}"/>" 
                                   class='btn btn-primary' 
                                   role='button'>
                                    Editar <span class='glyphicon glyphicon-pencil' aria-hidden='true'></span>
                                </a>
                            </td>

                        </tr>
                    </c:forEach>

                </tbody>
            </table>
        </div>

    </body>
</html>
