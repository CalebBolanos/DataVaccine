/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ipn.mx.datavaccine.entidades;

import java.io.Serializable;
import java.math.BigDecimal;
import lombok.Data;
import lombok.NoArgsConstructor;
/**
 *
 * @author Kimi
 */
@Data
@NoArgsConstructor
public class Usuario implements Serializable{
    private int idUsuario;
    private String nombreUsuario;
    private String paterno;
    private String materno;
    private String genero;
    private int edad;
    private String correo;
    private String contrasena;
    private String folio;
    private String foto;
    private float altura;
    private float peso;
    private String alergias;
    private String grupoSanguineo;
}
