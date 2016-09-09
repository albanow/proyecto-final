package com.controllers;

import com.database.DBUtil;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EditarDepartamento extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        Connection conn = null;
        String idDep = request.getParameter("idDepartamento");
        String idUbicacion = request.getParameter("idUbicacion");
        String queryUpdate = "UPDATE departments SET location_id = " + idUbicacion +
                "WHERE department_id = " + idDep;
        
        try {
            
            conn = DBUtil.getProxoolConexion();
            conn.setAutoCommit(false);
            Statement sentecia = conn.createStatement();
            int i = sentecia.executeUpdate(queryUpdate);
            conn.commit();
            response.sendRedirect("ObtenDepartamentos");
            
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
