
package com.controllers;

import com.database.DBUtil;
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

public class ObtenerUbicaciones extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Connection conn = null;
        HttpSession session = request.getSession(true);
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
            Statement sentencia = conn.createStatement();
            ResultSet resultado = sentencia.executeQuery(queryUbicaciones);
            
            ArrayList<Ubicacion> ubicaciones = new ArrayList<>();
            
            if (resultado.next()) {
                do {                    
                    Ubicacion ubicacion = new Ubicacion();
                    ubicacion.setIdUbicacion(resultado.getString("location_id"));
                    ubicacion.setCalle(resultado.getString("street_address"));
                    ubicacion.setCp(resultado.getString("postal_code"));
                    ubicacion.setCiudad(resultado.getString("city"));
                    ubicacion.setEstado(resultado.getString("state_province"));
                    ubicacion.setIdPais(resultado.getString("country_id"));
                    ubicacion.setNombrePais(resultado.getString("country_name"));
                    ubicacion.setIdRegion(resultado.getString("region_id"));
                    ubicacion.setNombreRegion(resultado.getString("region_name"));
                    ubicaciones.add(ubicacion);
                } 
                while (resultado.next());
            }
            
            session.setAttribute("locations", ubicaciones);
            response.sendRedirect("MuestraUbicaciones.jsp");
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
