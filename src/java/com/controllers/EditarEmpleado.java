package com.controllers;

import com.database.DBUtil;
import com.models.Empleado;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
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
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String fechaContratacion = request.getParameter("fechaContratacion");
        String idPuesto = request.getParameter("idPuesto");
        String email = request.getParameter("email");
        String idDepartamento = request.getParameter("idDepartamento");
        
        
        
        String queryUpdate = "UPDATE employees SET first_name = '" + nombre +
                "', last_name = '" + apellido +
                "', hire_date = TO_DATE('"+fechaContratacion+"', 'yyyy/mm/dd')" +
                ", job_id = '" + idPuesto +
                "', email = '" + email +
                "', department_id = " + idDepartamento +
                " WHERE employee_id = " + idEmpleado;
        System.out.println(queryUpdate);
        try {
            conn = DBUtil.getProxoolConexion();
            conn.setAutoCommit(false);
            Statement sentecia = conn.createStatement();
            int i = sentecia.executeUpdate(queryUpdate);
            conn.commit();
            response.sendRedirect("Empleados");
                    
        } catch (Exception e) {
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
