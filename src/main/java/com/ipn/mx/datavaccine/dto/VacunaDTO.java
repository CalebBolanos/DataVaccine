/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ipn.mx.datavaccine.vacunadto;

import com.ipn.mx.datavaccine.entidades.Vacuna;
import java.io.Serializable;

/**
 *
 * @author edgargarcia
 */
public class VacunaDTO implements Serializable {

    private Vacuna entidadVacuna;

    public VacunaDTO() {
        entidadVacuna = new Vacuna();
    }

    public Vacuna getEntidadVacuna() {
        return entidadVacuna;
    }

    public void setEntidadVacuna(Vacuna entidadVacuna) {
        this.entidadVacuna = entidadVacuna;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("idVacuna= ").append(getEntidadVacuna().getIdVacuna()).append("\n");
        sb.append("nombreVacuna= ").append(getEntidadVacuna().getNombreVacuna()).append("\n");
        sb.append("Descripcion= ").append(getEntidadVacuna().getDescripcion()).append("\n");
        sb.append("Logo= ").append(getEntidadVacuna().getLogo()).append("\n");
        sb.append("Portada= ").append(getEntidadVacuna().getPortada()).append("\n");
        sb.append("Eficacia= ").append(getEntidadVacuna().getEficacia()).append("\n");
        sb.append("Seguridad= ").append(getEntidadVacuna().getSeguridad()).append("\n");
        sb.append("idForo= ").append(getEntidadVacuna().getIdForo()).append("\n");
        return sb.toString();
    }

}
