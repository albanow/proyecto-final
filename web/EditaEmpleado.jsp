<%@page import="java.util.ArrayList"%>
<%@page import="com.models.Empleado"%>
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
        <title>Edita Empleado</title>
    </head>
    <body>
        <%  Empleado empleado = (Empleado) session.getAttribute("singleEmpleado");
            ArrayList<Puesto> puestos = (ArrayList<Puesto>) session.getAttribute("puestos");
            ArrayList<Departamento> departamentos = (ArrayList<Departamento>) session.getAttribute("departamentos");
        %>

        <div class="container myLogin">
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <form class="form-horizontal" action="EditaEmpleado" method="POST">
                        id: 
                        <input type="text"
                               class="form-control"
                               name="idEmpleado"
                               value="<c:out value="${sessionScope.singleEmpleado.idEmpleado}"/>"><br>
                        Nombre: 
                        <input type="text" 
                               class="form-control"
                               name="nombre" 
                               value="<c:out value="${sessionScope.singleEmpleado.nombre}"/>" ><br>
                        Apellido:
                        <input type="text" 
                               class="form-control"
                               name="apellido" 
                               value="<c:out value="${sessionScope.singleEmpleado.apellido}"/>" ><br>
                        Fecha de contratacion: 
                        <input type="date" 
                               class="form-control"
                               name="fechaContratacion" 
                               value="<c:out value="${sessionScope.singleEmpleado.fechaContratacion}"/>" ><br>
                        Puesto:
                        <select name="idPuesto" class="form-control">
                            <c:forEach var="jobs" items="${puestos}">
                                <option value="<c:out value="${jobs.getIdPuesto()}"/>">
                                    <c:out value="${jobs.getNombrePuesto()}"/>
                                </option>
                            </c:forEach>
                        </select><br>
                        Email: 
                        <input type="text" 
                               class="form-control"
                               name="email" 
                               value="<c:out value="${sessionScope.singleEmpleado.email}"/>" ><br>
                        Departamento:
                        <select name="idDepartamento" class="form-control">
                            <c:forEach var="dpts" items="${departamentos}">
                                <option value="<c:out value="${dpts.getIdDepartamento()}"/>">
                                    <c:out value="${dpts.getNombreDepartamento()}"/>
                                </option>
                            </c:forEach>
                        </select><br>
                        <input type="submit" class="btn btn-success" value="Actualizar">
                        <a href="MuestraEmpleados.jsp" class="btn btn-danger" role="button">Cancelar</a>
                    </form>
                    
                </div>
            </div>
        </div>

    </body>
</html>
