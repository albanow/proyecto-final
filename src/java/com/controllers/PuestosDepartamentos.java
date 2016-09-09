package com.controllers;

import com.database.DBUtil;
import com.models.Departamento;
import com.models.Puesto;
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

public class PuestosDepartamentos extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        Connection conn = null;
        HttpSession session = request.getSession(true);
        String jobsQuery = "SELECT jobs.job_id, job_title FROM jobs";
        String departQuery = "SELECT departments.department_id, departments.department_name FROM departments";

        try {
            conn = DBUtil.getProxoolConexion();
            conn.setAutoCommit(false);
            Statement sJobs = conn.createStatement();
            ResultSet resJobs = sJobs.executeQuery(jobsQuery);
            conn.commit();
            
            ArrayList<Puesto> puestos = new ArrayList<>();

            if (resJobs.next()) {
                do {
                    Puesto puesto = new Puesto(resJobs.getString("job_id"),
                            resJobs.getString("job_title"));
                    puestos.add(puesto);
                } while (resJobs.next());
            }
            session.setAttribute("jobs", puestos);

            //Get all departments (departamentos)
            conn.setAutoCommit(false);
            Statement sDpts = conn.createStatement();
            ResultSet resDpts = sDpts.executeQuery(departQuery);
            conn.commit();
            
            ArrayList<Departamento> departamentos = new ArrayList<>();

            if (resDpts.next()) {
                do {
                    Departamento departamento = new Departamento(resDpts.getString("department_id"),
                            resDpts.getString("department_name"));
                    departamentos.add(departamento);
                } while (resDpts.next());
            }

            session.setAttribute("departments", departamentos);
            response.sendRedirect("AgregarEmpleado.jsp");
            
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
