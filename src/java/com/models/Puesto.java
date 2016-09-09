package com.models;

import java.io.Serializable;

public class Puesto implements Serializable {

    private String idPuesto;
    private String nombrePuesto;
    private String minSalario;
    private String maxSalario;

    public Puesto(String idPuesto, String nombrePuesto, String minSalario, String maxSalario) {
        this.idPuesto = idPuesto;
        this.nombrePuesto = nombrePuesto;
        this.minSalario = minSalario;
        this.maxSalario = maxSalario;
    }

    public Puesto(String idPuesto, String nombrePuesto) {
        this.idPuesto = idPuesto;
        this.nombrePuesto = nombrePuesto;
    }

    public String getIdPuesto() {
        return idPuesto;
    }

    public void setIdPuesto(String idPuesto) {
        this.idPuesto = idPuesto;
    }

    public String getNombrePuesto() {
        return nombrePuesto;
    }

    public void setNombrePuesto(String nombrePuesto) {
        this.nombrePuesto = nombrePuesto;
    }

    public String getMinSalario() {
        return minSalario;
    }

    public void setMinSalario(String minSalario) {
        this.minSalario = minSalario;
    }

    public String getMaxSalario() {
        return maxSalario;
    }

    public void setMaxSalario(String maxSalario) {
        this.maxSalario = maxSalario;
    }

}
