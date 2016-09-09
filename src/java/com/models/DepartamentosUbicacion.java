package com.models;

import java.io.Serializable;

public class DepartamentosUbicacion implements Serializable{

    private String idDepartamento;
    private String nombreDepartamento;
    private String idManager;
    private String nombreManager;
    private String apellidoManager;
    private String idUbicacion;
    private String calleUbicacion;
    private String cpUbicacion;
    private String ciudadUbicacion;
    private String estadoUbicacion;
    private String idPais;
    private String nombrePais;
    private String idRegion;
    private String nombreRegion;

    public DepartamentosUbicacion() {
    }

    public DepartamentosUbicacion(String idDepartamento, String nombreDepartamento,
            String idManager, String nombreManager,
            String apellidoManager, String idUbicacion,
            String calleUbicacion, String cpUbicacion,
            String ciudadUbicacion, String estadoUbicacion,
            String idPais, String nombrePais, String idRegion,
            String nombreRegion) {
        this.idDepartamento = idDepartamento;
        this.nombreDepartamento = nombreDepartamento;
        this.idManager = idManager;
        this.nombreManager = nombreManager;
        this.apellidoManager = apellidoManager;
        this.idUbicacion = idUbicacion;
        this.calleUbicacion = calleUbicacion;
        this.cpUbicacion = cpUbicacion;
        this.ciudadUbicacion = ciudadUbicacion;
        this.estadoUbicacion = estadoUbicacion;
        this.idPais = idPais;
        this.nombrePais = nombrePais;
        this.idRegion = idRegion;
        this.nombreRegion = nombreRegion;
    }

    public String getIdDepartamento() {
        return idDepartamento;
    }

    public void setIdDepartamento(String idDepartamento) {
        this.idDepartamento = idDepartamento;
    }

    public String getNombreDepartamento() {
        return nombreDepartamento;
    }

    public void setNombreDepartamento(String nombreDepartamento) {
        this.nombreDepartamento = nombreDepartamento;
    }

    public String getIdManager() {
        return idManager;
    }

    public void setIdManager(String idManager) {
        this.idManager = idManager;
    }

    public String getNombreManager() {
        return nombreManager;
    }

    public void setNombreManager(String nombreManager) {
        this.nombreManager = nombreManager;
    }

    public String getApellidoManager() {
        return apellidoManager;
    }

    public void setApellidoManager(String apellidoManager) {
        this.apellidoManager = apellidoManager;
    }

    public String getIdUbicacion() {
        return idUbicacion;
    }

    public void setIdUbicacion(String idUbicacion) {
        this.idUbicacion = idUbicacion;
    }

    public String getCalleUbicacion() {
        return calleUbicacion;
    }

    public void setCalleUbicacion(String calleUbicacion) {
        this.calleUbicacion = calleUbicacion;
    }

    public String getCpUbicacion() {
        return cpUbicacion;
    }

    public void setCpUbicacion(String cpUbicacion) {
        this.cpUbicacion = cpUbicacion;
    }

    public String getCiudadUbicacion() {
        return ciudadUbicacion;
    }

    public void setCiudadUbicacion(String ciudadUbicacion) {
        this.ciudadUbicacion = ciudadUbicacion;
    }

    public String getEstadoUbicacion() {
        return estadoUbicacion;
    }

    public void setEstadoUbicacion(String estadoUbicacion) {
        this.estadoUbicacion = estadoUbicacion;
    }

    public String getIdPais() {
        return idPais;
    }

    public void setIdPais(String idPais) {
        this.idPais = idPais;
    }

    public String getNombrePais() {
        return nombrePais;
    }

    public void setNombrePais(String nombrePais) {
        this.nombrePais = nombrePais;
    }

    public String getIdRegion() {
        return idRegion;
    }

    public void setIdRegion(String idRegion) {
        this.idRegion = idRegion;
    }

    public String getNombreRegion() {
        return nombreRegion;
    }

    public void setNombreRegion(String nombreRegion) {
        this.nombreRegion = nombreRegion;
    }

}
