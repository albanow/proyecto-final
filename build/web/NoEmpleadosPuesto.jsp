
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="libs/jquery/dist/jquery.min.js" type="text/javascript"></script>
        <link href="libs/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="libs/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>
        <link href="css/main.css" rel="stylesheet" type="text/css"/>
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container myLogin">
            <div class="jumbotron">
                <h1>No hay empleados con este puesto</h1>
            </div> 
        </div>
        <div class="container myLogin" >
            <a href="Principal.jsp" class='btn btn-primary' role='button'>
                Principal <span class='glyphicon glyphicon-home' aria-hidden='true'></span>
            </a>
            <a href="ObtenerPuestos" class='btn btn-primary' role='button'>
                Regresar a Puestos <span class='glyphicon glyphicon-menu-left' aria-hidden='true'></span>
            </a>
        </div><br>
    </body>
</html>
