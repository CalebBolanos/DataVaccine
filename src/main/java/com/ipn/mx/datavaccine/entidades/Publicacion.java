/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ipn.mx.datavaccine.entidades;

import java.io.Serializable;
import java.sql.Date;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *
 * @author caleb
 */
@Data
@NoArgsConstructor
public class Publicacion implements Serializable{
    public int idPublicacion;
    public int idVacuna;
    public String titulo;
    public String nombreUsuario;
    public String imagen;
    public String mensaje;
    public Date fecha;
}
