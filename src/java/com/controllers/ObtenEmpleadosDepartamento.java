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

public class ObtenEmpleadosDepartamento extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        Connection conn = null;
        HttpSession session = request.getSession(true);
        int idDep = Integer.parseInt(request.getParameter("idDepartamento"));
        
        String queryEmployees = "SELECT employees.employee_id, " +
                "employees.first_name, " +
                "employees.last_name, " +
                "employees.hire_date, " +
                "employees.job_id, " +
                "jobs.job_title, " +
                "employees.email, " +
                "departments.department_name " +
                "FROM employees, departments, jobs " +
                "WHERE employees.department_id = " + idDep + " " +
                "AND employees.department_id = departments.department_id " +
                "AND employees.job_id = jobs.job_id";
        
        
        try {
            ArrayList<Empleado> empleados = new ArrayList<>();
            conn = DBUtil.getProxoolConexion();
            conn.setAutoCommit(false);
            Statement sentencia = conn.createStatement();
            ResultSet resultado = sentencia.executeQuery(queryEmployees);          
            conn.commit();
            
            if (resultado.next()) {
                do {        
                    Empleado empleado = new Empleado(resultado.getString("employee_id"), resultado.getString("first_name"), 
                            resultado.getString("last_name"), resultado.getString("hire_date"), 
                            resultado.getString("job_id"), resultado.getString("job_title"), 
                            resultado.getString("email"), resultado.getString("department_name"));
                    
                    empleados.add(empleado);
                } 
                while (resultado.next());
            }
            
            System.out.println(empleados.isEmpty());
            if(empleados.isEmpty()){
                response.sendRedirect("NoEmpleadosDepartamento.jsp");
            }
            else{
                session.setAttribute("empleadoss", empleados);
                response.sendRedirect("DepartamentoSeleccionado.jsp");
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
