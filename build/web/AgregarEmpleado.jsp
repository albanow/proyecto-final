<%@page import="java.util.ArrayList"%>
<%@page import="com.models.Puesto"%>
<%@page import="com.models.Departamento"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="libs/jquery/dist/jquery.min.js" type="text/javascript"></script>
        <script src="libs/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>
        <link href="libs/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/main.css" rel="stylesheet" type="text/css"/>
        <title>Agregar Empleado</title>
    </head>
    <body>
        <%  ArrayList<Puesto> jobs = (ArrayList<Puesto>) session.getAttribute("jobs");
            ArrayList<Departamento> departments = (ArrayList<Departamento>) session.getAttribute("departments");
        %>
        <div class="container myLogin">
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <form class="form-horizontal" action="AgregarEmpleado" method="GET">

                        Nombre: 
                        <input type="text" 
                               class="form-control"
                               name="nombre" 
                               placeholder="Nombre" 
                               required><br>
                        Apellido:
                        <input type="text" 
                               class="form-control"
                               name="apellido" 
                               placeholder="Apellido" 
                               required><br>
                        Fecha de contratacion: 
                        <input type="date" 
                               class="form-control"
                               name="fechaContratacion" 
                               required><br>
                        Puesto:
                        <select name="idPuesto" class="form-control">
                            <c:forEach var="jobs" items="${jobs}">
                                <option value="<c:out value="${jobs.getIdPuesto()}"/>">
                                    <c:out value="${jobs.getNombrePuesto()}"/>
                                </option>
                            </c:forEach>
                        </select><br>
                        Telefono: 
                        <input type="text" 
                               class="form-control"
                               name="phone" 
                               placeholder="000-000-0000" 
                               required><br>
                        Email: 
                        <input type="text" 
                               class="form-control"
                               name="email" 
                               placeholder="Email" 
                               required><br>
                        Departamento:
                        <select name="idDepartamento" class="form-control">
                            <c:forEach var="dpts" items="${departments}">
                                <option value="<c:out value="${dpts.getIdDepartamento()}"/>">
                                    <c:out value="${dpts.getNombreDepartamento()}"/>
                                </option>
                            </c:forEach>
                        </select><br>
                        <input type="submit" class="btn btn-success" value="Agregar">
                        <a href="Empleados" class="btn btn-danger" role="button">Cancelar</a>
                    </form>

                </div>
            </div>
        </div>
    </body>
</html>
