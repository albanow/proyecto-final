package com.controllers;

import com.database.DBUtil;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AgregarEmpleado extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String fechaContratacion = request.getParameter("fechaContratacion");
        String idPuesto = request.getParameter("idPuesto");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String idDepartamento = request.getParameter("idDepartamento");
        
        Connection conn = null;
        String maxQuery = "SELECT max(employee_id) FROM employees";
        
        try {
            conn = DBUtil.getProxoolConexion();
            conn.setAutoCommit(false);
            Statement sentecia = conn.createStatement();
            ResultSet resMaxId = sentecia.executeQuery(maxQuery);
            
            resMaxId.next(); 
            int maxId = Integer.parseInt(resMaxId.getString("max")) + 1;
            
            String insertQuery = "INSERT INTO employees (employee_id, first_name, last_name, "
                + "email, phone_numeric, hire_date, job_id, department_id) "
                + "VALUES ("+maxId+", '"+nombre+"', '"+apellido+"', '"+email+"', '"+phone
                    +"', TO_DATE('"+fechaContratacion+"', 'yyyy/mm/dd'), '"+idPuesto+"', "+idDepartamento+")";
            int i = sentecia.executeUpdate(insertQuery);
            conn.commit();
            response.sendRedirect("Empleados");
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
