package com.controllers;

import com.database.DBUtil;
import com.models.Empleado;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EditarEmpleado extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        Connection conn = null;
        String idEmpleado = request.getParameter("idEmpleado");
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
                "AND employees.department_id = departments.department_id " +
                "AND employees.employee_id = ?";
        
        try {
            conn = DBUtil.getProxoolConexion();
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setInt(1, Integer.parseInt(idEmpleado));
            ResultSet rs = statement.executeQuery(query);
            
            if (rs.next()) {
                do {                    
                    Empleado empleado = new Empleado(rs.getString("idEmpleado"), rs.getString("nombre"), 
                            rs.getString("apellido"), rs.getString("fechaContratacion"), 
                            rs.getString("idPuesto"), rs.getString("nombrePuesto"), 
                            rs.getString("email"), rs.getString("departamento"));
                } 
                while (rs.next());
            }
        } 
        catch (Exception e) {
            System.out.println(e.toString());
        }
        finally{
            DBUtil.cierraConexion(conn);
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
