package com.controllers;

import com.database.DBUtil;
import com.models.DepartamentosUbicacion;
import com.models.Ubicacion;
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

public class ObtenerDepartamento extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        Connection conn = null;
        HttpSession session = request.getSession(true);
        String idDepartamento = request.getParameter("idDepartamento");
        String queryDepartamento = "SELECT 	departments.department_id, "
                + "departments.department_name, "
                + "employees.employee_id, "
                + "employees.first_name, "
                + "employees.last_name, "
                + "locations.location_id, "
                + "locations.street_address, "
                + "locations.postal_code, "
                + "locations.city, "
                + "locations.state_province, "
                + "countries.country_id, "
                + "countries.country_name, "
                + "regions.region_id, "
                + "regions.region_name "
                + "FROM departments, employees, locations, countries, regions "
                + "WHERE departments.manager_id = employees.employee_id "
                + "AND departments.location_id = locations.location_id "
                + "AND locations.country_id = countries.country_id "
                + "AND countries.region_id = regions.region_id "
                + "AND departments.department_id = " + idDepartamento;
        String queryUbicaciones = "SELECT locations.location_id, " +
                "locations.street_address, " +
                "locations.postal_code, " +
                "locations.city, " +
                "locations.state_province, " +
                "countries.country_id, " +
                "countries.country_name, " +
                "regions.region_id, " +
                "regions.region_name " +
                "FROM locations, countries, regions " +
                "WHERE locations.country_id = countries.country_id " +
                "AND countries.region_id = regions.region_id";

        try {
            conn = DBUtil.getProxoolConexion();
            conn.setAutoCommit(false);
            Statement sentencia = conn.createStatement();
            ResultSet resultado = sentencia.executeQuery(queryDepartamento);
            conn.commit();

            resultado.next();
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
            
            session.setAttribute("depart", depUbi);
            
            conn.setAutoCommit(false);
            Statement sentencia2 = conn.createStatement();
            ResultSet resultado2 = sentencia.executeQuery(queryUbicaciones);
            conn.commit();
            
            ArrayList<Ubicacion> ubicaciones = new ArrayList<>();
            
            if (resultado2.next()) {
                do {                    
                    Ubicacion ubicacion = new Ubicacion();
                    ubicacion.setIdUbicacion(resultado2.getString("location_id"));
                    ubicacion.setCalle(resultado2.getString("street_address"));
                    ubicacion.setCp(resultado2.getString("postal_code"));
                    ubicacion.setCiudad(resultado2.getString("city"));
                    ubicacion.setEstado(resultado2.getString("state_province"));
                    ubicacion.setIdPais(resultado2.getString("country_id"));
                    ubicacion.setNombrePais(resultado2.getString("country_name"));
                    ubicacion.setIdRegion(resultado2.getString("region_id"));
                    ubicacion.setNombreRegion(resultado2.getString("region_name"));
                    ubicaciones.add(ubicacion);

                } 
                while (resultado2.next());
            }
            
            session.setAttribute("ubicaciones", ubicaciones);
            response.sendRedirect("EditaDepartamento.jsp");
            
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
