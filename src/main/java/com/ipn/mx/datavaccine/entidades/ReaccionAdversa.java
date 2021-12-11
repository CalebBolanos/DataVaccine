/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ipn.mx.datavaccine.entidades;

import java.math.BigDecimal;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *
 * @author caleb
 */
@Data
@NoArgsConstructor
public class ReaccionAdversa {
    public String nombre;
    public int numeroEventos;
    public BigDecimal probabilidad, porcentajeProbabilidad;
    
    public ReaccionAdversa(String nombre, int numeroEventos, BigDecimal probabilidad) {
        this.nombre = nombre;
        this.numeroEventos = numeroEventos;
        this.probabilidad = probabilidad;
        porcentajeProbabilidad = probabilidad.multiply(new BigDecimal(100));
    }
}
