package com.controllers;

import com.database.DBUtil;
import com.models.Empleado;
import com.models.Departamento;
import com.models.Puesto;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ObtenerEmpleado extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Connection conn = null;
        HttpSession session = request.getSession(true);
        String idEmpleado = request.getParameter("idEmpleado");
        String query = "SELECT 	employees.employee_id AS idEmpleado, "
                + "employees.first_name AS nombre, "
                + "employees.last_name AS apellido, "
                + "employees.hire_date AS fechaContratacion, "
                + "employees.email, "
                + "employees.job_id AS idPuesto, "
                + "jobs.job_title AS nombrePuesto, "
                + "departments.department_name AS departamento "
                + "FROM employees, jobs, departments "
                + "WHERE employees.job_id = jobs.job_id "
                + "AND employees.department_id = departments.department_id "
                + "AND employees.employee_id = ?";
        String jobsQuery = "SELECT jobs.job_id, job_title FROM jobs";
        String departQuery = "SELECT departments.department_id, departments.department_name FROM departments";

        try {
            conn = DBUtil.getProxoolConexion();
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setInt(1, Integer.parseInt(idEmpleado));
            ResultSet rs = statement.executeQuery();
            Empleado empleado = null;

            if (rs.next()) {
                do {
                    empleado = new Empleado(rs.getString("idEmpleado"), rs.getString("nombre"),
                            rs.getString("apellido"), rs.getString("fechaContratacion"),
                            rs.getString("idPuesto"), rs.getString("nombrePuesto"),
                            rs.getString("email"), rs.getString("departamento"));
                } while (rs.next());
            }
            
            session.setAttribute("singleEmpleado", empleado);
            //Get all jobs (puestos)
            Statement sJobs = conn.createStatement();
            ResultSet resJobs = sJobs.executeQuery(jobsQuery);
            ArrayList<Puesto> puestos = new ArrayList<>();
            
            if (resJobs.next()) {
                do {                    
                    Puesto puesto = new Puesto(resJobs.getString("job_id"), 
                            resJobs.getString("job_title"));
                    puestos.add(puesto);
                } 
                while (resJobs.next());
            }
            
            session.setAttribute("puestos", puestos);
            
            //Get all departments (departamentos)
            Statement sDpts = conn.createStatement();
            ResultSet resDpts = sDpts.executeQuery(departQuery);
            ArrayList<Departamento> departamentos = new ArrayList<>();
            
            if (resDpts.next()) {
                do {                    
                    Departamento departamento = new Departamento(resDpts.getString("department_id"), 
                            resDpts.getString("department_name"));
                    departamentos.add(departamento);
                } 
                while (resDpts.next());
            }
            
            session.setAttribute("departamentos", departamentos);
            
            response.sendRedirect("EditaEmpleado.jsp");
            
        } 
        catch (Exception e) {
            System.out.println(e.toString());
        } finally {
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
