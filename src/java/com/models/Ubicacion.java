package com.models;

import java.io.Serializable;

public class Ubicacion implements Serializable{

    private String idUbicacion;
    private String calle;
    private String cp;
    private String ciudad;
    private String estado;
    private String idPais;
    private String nombrePais;
    private String idRegion;
    private String nombreRegion;

    public Ubicacion() {
    }
    
    public Ubicacion(String idUbicacion, String calle, 
            String cp, String ciudad, String estado, 
            String idPais, String nombrePais, 
            String idRegion, String nombreRegion) {
        this.idUbicacion = idUbicacion;
        this.calle = calle;
        this.cp = cp;
        this.ciudad = ciudad;
        this.estado = estado;
        this.idPais = idPais;
        this.nombrePais = nombrePais;
        this.idRegion = idRegion;
        this.nombreRegion = nombreRegion;
    }

    public String getIdUbicacion() {
        return idUbicacion;
    }

    public void setIdUbicacion(String idUbicacion) {
        this.idUbicacion = idUbicacion;
    }

    public String getCalle() {
        return calle;
    }

    public void setCalle(String calle) {
        this.calle = calle;
    }

    public String getCp() {
        return cp;
    }

    public void setCp(String cp) {
        this.cp = cp;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
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
    
    public String ubicacionCompleta(){
        return this.idUbicacion + ", " + this.calle + ", ZIP " +
                this.cp + ", " + this.ciudad + ", " +
                this.estado + ", " + this.nombrePais + ", " +
                this.nombreRegion;
    }

}
