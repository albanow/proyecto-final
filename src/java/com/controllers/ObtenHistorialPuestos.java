package com.controllers;

import com.database.DBUtil;
import com.models.Empleado;
import com.models.HistorialPuestos;
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

public class ObtenHistorialPuestos extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        Connection conn = null;
        HttpSession session = request.getSession(true);
        String idEmpleado = request.getParameter("idEmpleado");
        System.out.println(idEmpleado);
        String queryHistorial = "SELECT 	employees.employee_id, " +
                "employees.first_name, " +
                "employees.last_name, " +
                "job_history.start_date, " +
                "job_history.end_date,  " +
                "jobs.job_id, " +
                "jobs.job_title, " +
                "departments.department_id, " +
                "departments.department_name " +
                "FROM employees, job_history, departments, jobs " +
                "WHERE employees.employee_id = job_history.employee_id " +
                "AND job_history.job_id  = jobs.job_id " +
                "AND job_history.department_id = departments.department_id " +
                "AND employees.employee_id = "+idEmpleado;
        String queryEmpleado = "SELECT employees.employee_id, " +
                "employees.first_name, " +
                "employees.last_name, " +
                "employees.hire_date, " +
                "employees.job_id, " +
                "jobs.job_title, " +
                "employees.email, " +
                "departments.department_name " +
                "FROM employees, departments, jobs " +
                "WHERE employees.department_id = departments.department_id " +
                "AND employees.department_id = departments.department_id " +
                "AND employees.job_id = jobs.job_id "+
                "AND employees.employee_id = "+idEmpleado;
        
        try {
            conn = DBUtil.getProxoolConexion();
            
            Statement sentencia = conn.createStatement();
            ResultSet resultado = sentencia.executeQuery(queryHistorial);
            
            
            ArrayList<HistorialPuestos> historialPuestos = new ArrayList<>();
            
            if (resultado.next()) {
                do {                    
                    HistorialPuestos hp = new HistorialPuestos();
                    hp.setIdEmpleado(resultado.getString("employee_id"));
                    hp.setNombreEmpleado(resultado.getString("first_name"));
                    hp.setApellidoEmpleado(resultado.getString("last_name"));
                    hp.setFechaInicial(resultado.getString("start_date"));
                    hp.setFechaFinal(resultado.getString("end_date"));
                    hp.setIdPuesto(resultado.getString("job_id"));
                    hp.setNombrePuesto(resultado.getString("job_title"));
                    hp.setIdDepartamento(resultado.getString("department_id"));
                    hp.setNombreDepartamento(resultado.getString("department_name"));
                    
                    historialPuestos.add(hp);
                } while (resultado.next());
            }
            
            
            Statement sentece = conn.createStatement();
            ResultSet result = sentece.executeQuery(queryEmpleado);
            
            
            result.next();
            Empleado empleado = new Empleado(result.getString("employee_id"), result.getString("first_name"), 
                            result.getString("last_name"), result.getString("hire_date"), 
                            result.getString("job_id"), result.getString("job_title"), 
                            result.getString("email"), result.getString("department_name"));
            
            if (historialPuestos.isEmpty()) {
                session.setAttribute("empleadoSelected", empleado);
                response.sendRedirect("SinHistorialPuestos.jsp");
            }
            else{
                session.setAttribute("empleadoSelected", empleado);
                session.setAttribute("hp", historialPuestos);
                response.sendRedirect("MuestraHistorialPuestos.jsp");
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
