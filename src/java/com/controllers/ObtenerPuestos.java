
package com.controllers;

import com.database.DBUtil;
import com.models.Puesto;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ObtenerPuestos extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        Connection conn= null;
        HttpSession session = request.getSession();
        String queryPuestos = "SELECT 	jobs.job_id, " +
                "jobs.job_title, " +
                "jobs.min_salary, " +
                "jobs.max_salary  " +
                "FROM jobs";
        try {
            conn = DBUtil.getProxoolConexion();
            conn.setAutoCommit(false);
            Statement sentencia = conn.createStatement();
            ResultSet resultado = sentencia.executeQuery(queryPuestos);
            conn.commit();
            
            ArrayList<Puesto> puestos = new ArrayList<>();
            
            if (resultado.next()) {
                do {                    
                    Puesto puesto = new Puesto(resultado.getString("job_id"), 
                            resultado.getString("job_title"), resultado.getString("min_salary"), 
                            resultado.getString("max_salary"));
                    puestos.add(puesto);
                } while (resultado.next());
            }
            
            session.setAttribute("jobss", puestos);
            response.sendRedirect("MuestraPuestos.jsp");
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
