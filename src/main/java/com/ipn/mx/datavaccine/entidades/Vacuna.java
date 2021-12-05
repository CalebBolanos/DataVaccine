/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ipn.mx.datavaccine.entidades;

import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *
 * @author edgargarcia
 */
@Data
@NoArgsConstructor
public class Vacuna implements Serializable{
    private int idVacuna;
    private String nombreVacuna;
    private String Descripcion;
    private String Logo;
    private String Portada;
    private String Eficacia;
    private String Seguridad;
    private int idForo;
}
