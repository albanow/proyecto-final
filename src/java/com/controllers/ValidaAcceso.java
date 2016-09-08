package com.controllers;

import com.database.DBUtil;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Types;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ValidaAcceso extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        Connection conn = null;

        try {
            conn = DBUtil.getProxoolConexion();
            
            CallableStatement stmt = conn.prepareCall("{ ? = call validausuario(?, ?)}");
            stmt.registerOutParameter(1, Types.VARCHAR);
            stmt.setString(2, username);
            stmt.setString(3, password);
            stmt.execute();
            
            String validacion = stmt.getString(1);

            if (validacion.equals("OK")) {
                response.sendRedirect("http://localhost:8084/ProyectoFinal/Principal.jsp");
            } else {
                response.sendRedirect("http://localhost:8084/ProyectoFinal/ErrorLogin.jsp");

            }
        } 
        catch (Exception e) {
            System.out.println(e.toString());
        } 
        finally {
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
