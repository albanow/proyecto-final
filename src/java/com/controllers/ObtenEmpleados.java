package com.controllers;

import com.database.DBUtil;
import com.models.Empleado;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ObtenEmpleados extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        Connection conn = null;
        String query = "SELECT 	employees.employee_id AS idEmpleado, " +
                "employees.first_name AS nombre, " +
                "employees.last_name AS apellido, " +
                "employees.hire_date AS fechaContratacion, " +
                "employees.email, " +
                "employees.job_id AS idPuesto, " +
                "jobs.job_title AS nombrePuesto, " +
                "departments.department_name AS departamento " +
                "FROM employees, jobs, departments " +
                "WHERE employees.job_id = jobs.job_id " +
                "AND employees.department_id = departments.department_id";
        HttpSession session = request.getSession(true);
        
        try {
            ArrayList<Empleado> empleados = new ArrayList<>();
            
            conn = DBUtil.getProxoolConexion();
            Statement sentencia = conn.createStatement();
            ResultSet resultado = sentencia.executeQuery(query);
            
            if (resultado.next()) {
                do {                    
                    Empleado empleado = new Empleado(resultado.getString("idEmpleado"), resultado.getString("nombre"), 
                            resultado.getString("apellido"), resultado.getString("fechaContratacion"), 
                            resultado.getString("idPuesto"), resultado.getString("nombrePuesto"), 
                            resultado.getString("email"), resultado.getString("departamento"));
                    empleados.add(empleado);
                } 
                while (resultado.next());
            }
            session.setAttribute("empleados", empleados);
            response.sendRedirect("MuestraEmpleados.jsp");
        } 
        catch (Exception e) {
            System.out.println(e.toString());
        }
        finally{
            
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
