
package com.controllers;

import com.database.DBUtil;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EliminaEmpleado extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        String idEmpleado = request.getParameter("idEmpleado");
        String deleteQuery = "DELETE FROM employees WHERE employees.employee_id = ?";
        Connection conn = null;
        
        try {
            
            conn = DBUtil.getProxoolConexion();
            PreparedStatement statement = conn.prepareStatement(deleteQuery);
            statement.setInt(1, Integer.parseInt(idEmpleado));
            statement.executeUpdate();
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
