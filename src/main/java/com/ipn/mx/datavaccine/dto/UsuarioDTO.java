/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ipn.mx.datavaccine.dto;

import com.ipn.mx.datavaccine.entidades.Usuario;
import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;
/**
 *
 * @author Kimi
 */
@Data
public class UsuarioDTO implements Serializable{
    private Usuario entidad;
    
    public UsuarioDTO(){
        entidad = new Usuario();
    }
    
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Clave: ").append(getEntidad().getIdUsuario()).append("\n");
        sb.append("Nombre: ").append(getEntidad().getNombreUsuario()).append("\n");
        sb.append("Apellido Paterno: ").append(getEntidad().getPaterno()).append("\n");
        sb.append("Apellido Materno: ").append(getEntidad().getMaterno()).append("\n");
        sb.append("Genero: ").append(getEntidad().getGenero()).append("\n");
        sb.append("Edad: ").append(getEntidad().getEdad()).append("\n");
        sb.append("Correo: ").append(getEntidad().getCorreo()).append("\n");
        sb.append("Contrasena: ").append(getEntidad().getContrasena()).append("\n");
        sb.append("Folio: ").append(getEntidad().getFolio()).append("\n");
        sb.append("Foto: ").append(getEntidad().getFoto()).append("\n");
        sb.append("Altura: ").append(getEntidad().getAltura()).append("\n");
        sb.append("Peso: ").append(getEntidad().getPeso()).append("\n");
        sb.append("Alergias: ").append(getEntidad().getAlergias()).append("\n");
        sb.append("Grupo Sanguineo: ").append(getEntidad().getGrupoSanguineo()).append("\n");
        sb.append("Clave datos medicos: ").append(getEntidad().getClaveDatosMedicos()).append("\n");
        return sb.toString();
    }
}
