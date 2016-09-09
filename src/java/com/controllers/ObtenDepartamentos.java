package com.controllers;

import com.database.DBUtil;
import com.models.DepartamentosUbicacion;
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

public class ObtenDepartamentos extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        Connection conn = null;
        HttpSession session = request.getSession(true);
        String queryDeptms = "SELECT 	departments.department_id, " +
                "departments.department_name, " +
                "employees.employee_id, " +
                "employees.first_name, " +
                "employees.last_name, " +
                "locations.location_id, " +
                "locations.street_address, " +
                "locations.postal_code, " +
                "locations.city, " +
                "locations.state_province, " +
                "countries.country_id, " +
                "countries.country_name, " +
                "regions.region_id, " +
                "regions.region_name " +
                "FROM departments, employees, locations, countries, regions " +
                "WHERE departments.manager_id = employees.employee_id " +
                "AND departments.location_id = locations.location_id " +
                "AND locations.country_id = countries.country_id " +
                "AND countries.region_id = regions.region_id " +
                "ORDER BY departments.department_name";
        try {
            
            ArrayList<DepartamentosUbicacion> departamentosUbicacion = new ArrayList<>();
            conn = DBUtil.getProxoolConexion();
            conn.setAutoCommit(false);
            Statement sentencia = conn.createStatement();
            ResultSet resultado = sentencia.executeQuery(queryDeptms);
            conn.commit();
            
            if (resultado.next()) {
                do {                    
                    DepartamentosUbicacion depUbi = new DepartamentosUbicacion();
                    depUbi.setIdDepartamento(resultado.getString("department_id"));
                    depUbi.setNombreDepartamento(resultado.getString("department_name"));
                    depUbi.setIdManager(resultado.getString("employee_id"));
                    depUbi.setNombreManager(resultado.getString("first_name"));
                    depUbi.setApellidoManager(resultado.getString("last_name"));
                    depUbi.setIdUbicacion(resultado.getString("location_id"));
                    depUbi.setCalleUbicacion(resultado.getString("street_address"));
                    depUbi.setCpUbicacion(resultado.getString("postal_code"));
                    depUbi.setCiudadUbicacion(resultado.getString("city"));
                    depUbi.setEstadoUbicacion(resultado.getString("state_province"));
                    depUbi.setIdPais(resultado.getString("country_id"));
                    depUbi.setNombrePais(resultado.getString("country_name"));
                    depUbi.setIdRegion(resultado.getString("region_id"));
                    depUbi.setNombreRegion(resultado.getString("region_name"));
                            
                    departamentosUbicacion.add(depUbi);
                } 
                while (resultado.next());
            }
            session.setAttribute("dptsUbicacion", departamentosUbicacion);
            response.sendRedirect("MuestraDepartamentos.jsp");
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
